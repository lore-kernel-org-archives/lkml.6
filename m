Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C9CC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C5652085A
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 02:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtzDCVUt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfAHCyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 21:54:25 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45944 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbfAHCyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 21:54:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so2476299wrr.12;
        Mon, 07 Jan 2019 18:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=eI2Loo88wK0vOY54u0n44Fg4JmzKrvHXnkS3KOUeaH4=;
        b=EtzDCVUtsd8lvEfC7CoTXm0I8MKxIJO+zWgtHYn1wZo5m8rDMeazkaua69tsGdEOg9
         LpWWHLxhdHmckrxSVppaTT34/L+z6gaLf/BSYmx1iuF3gBJ9iQ+jv/DCBEqUiMka/t+/
         vDz2/BwVuEieIiyM0HxndsaclusRL5xkUp4aBgObcWrBSfNYHUsX/bJNiN9Rgx+uv8JA
         xSbiSQtPP7OzdLJUxUS36R/PmLRD8dS6arRUG3mfOw9nlaPbDPdNxODUIun+mtyWYvWX
         PhPQB49hzPI3bJS+Sahzm3LZ2prQUzfYA0tTz1ncoe3ZY9my+2v7tmIumJrREoOjQ2As
         sMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=eI2Loo88wK0vOY54u0n44Fg4JmzKrvHXnkS3KOUeaH4=;
        b=MNDEmoNI5ItN5+lwsnuJiHsfglkmkpDGrHUCdbvu9VlvtljjLWwb8yvFMxrkZj06cq
         jPVFt1JvENhM4Wz80bQqqkrGDIfTTTTG1qU19nAV23z9oaZLXpxI6tLBVL2sqT0mUejj
         ZiGdL8ikXpi2FGArB8AiMZ8/+pPI1FFD/B3PS9Nq7PvfWVyO/AIQBEsE+49Rk6CcmngD
         wYqiRmPaqMZtQbmOGhJwV73nOXf3M4c5HMfYZRZ9sTLtq5443/TscZYUc2cvqC+FpOVb
         VFEPnTvyi2fj9A2zA4NCbYzwvYDMu16esy31GAeR2VSGnm/xlLUx80bVJwnCDNpf3W7n
         t5fA==
X-Gm-Message-State: AJcUukfINDKkI+eNuhLRT0DCXhRU4Ft4rxRCMr7ENhcdyaZAegK206tY
        xMObdvFW/Io62g6AA1Lhlws=
X-Google-Smtp-Source: ALg8bN4AHD5r6EUYUxlX/ljZBkzQDvA6pJJPj3WKSNOa8DnnOM9c4D/mYDAgXDkw0WMP13xioeNv4g==
X-Received: by 2002:adf:b608:: with SMTP id f8mr15373wre.120.1546916062648;
        Mon, 07 Jan 2019 18:54:22 -0800 (PST)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id v16sm45608243wrs.75.2019.01.07.18.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 18:54:22 -0800 (PST)
Date:   Mon, 7 Jan 2019 19:54:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Clang warnings in net/phonet
Message-ID: <20190108025420.GA26093@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

When building the kernel with Clang, this warning comes up in net/phonet.

net/phonet/pep.c:224:16: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
        ph->data[0] = oph->data[1]; /* CTRL id */
                      ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:281:10: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
        switch (hdr->data[1]) {
                ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:285:12: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
                        switch (hdr->data[4]) {
                                ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:295:8: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
                        if (hdr->data[4] == PEP_IND_READY)
                            ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:304:21: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
                atomic_add(wake = hdr->data[4], &pn->tx_credits);
                                  ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:509:9: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
        n_sb = hdr->data[4];
               ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:817:14: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
        peer_type = hdr->other_pep_type << 8;
                    ^    ~~~~~~~~~~~~~~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
net/phonet/pep.c:820:9: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
        n_sb = hdr->data[4];
               ^         ~
include/net/phonet/pep.h:66:3: note: array 'data' declared here
                u8              data[1];
                ^
8 warnings generated.

I have taken a look at the effected code but I can't really figure out
the proper fix for this warning (my knowledge of C just isn't there
yet). Nick had suggested changing 'u8 data[1]' to 'u8 *data' in
'struct pnpipehdr', which seems logical but I can't say for sure. Any
advice would be appreciated :)

Thanks,
Nathan
