Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C8EC282C5
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10777218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 08:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgQjPLJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbfAZIKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 03:10:32 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43428 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfAZIKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 03:10:31 -0500
Received: by mail-ed1-f68.google.com with SMTP id f9so9100813eds.10;
        Sat, 26 Jan 2019 00:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4Jzvf/p0rpOd3JqtM+G4fhfeLqa+SZeQEdzgW17WLl0=;
        b=mgQjPLJsFH8tLW+pI9Q/rPKTVLUsrlY8etLIXBoXww3TPQztANay59ObLgQsyXph84
         1/Iuw3HIdDjn5ohfXzn9/jmb/RjQ7ei6g7Uj+lAaSPSv6moI4z+m40tkZHwt6+cASTYy
         PzlcK3TtjQQtvjja5nAZ2TPLzJlQV9qug5vAUL+k2VnJLrTP/IaCtBXJdjNYNHeZF86N
         S6Ovssz+W7/7OIH1KeGXa+pnnztVtNft9GhZklKxeCRgf2Bvqm6kt4OQJpXxA5xL4X7z
         eyTrwimdw/yxi/XIr2rqPYC8d4Pmxh9BVI6O17ydFTluM84K3o3aBbdQS8u3FEWAZK6R
         a/tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4Jzvf/p0rpOd3JqtM+G4fhfeLqa+SZeQEdzgW17WLl0=;
        b=CL6ar0P1mGygAkRVTY5rpCqSXTHzpJ1DoESuEevDxrdfub/NLjmyhIqncogyPL4Oph
         69rIZDOhLgysmX0DKU/eoR8+qAGLkrpLcO593fWSUyjQuaWM25ELOtSJge6y9FOOROS3
         oTYGxET6Swt8YJuEQZ3qSokB/purVapJuJVz9anyqyoWOJAvawDLurRUW64s4LFxQ1O8
         ebZbW5e7pBpQsVoofI+3bZn8mQearibBMuHJU+62JZse+rj7QJoItNUvCiXZmHaFYwy6
         nvLJpeVmQXG327GTVzpQs7/BrDoPMKeKHzJSDBOkcPsh79j7LrwprH3D0WGpBUVkZUwt
         oZ8A==
X-Gm-Message-State: AJcUukembbODMLQg88LqUDylwwzJhUsTZoomYASl20AvzC9xIbUFABSO
        xlE4vR7JgAyVQJX9ahs2SLs=
X-Google-Smtp-Source: ALg8bN72aXNreeTrr22yGwhZyrajInHA2s3iMmWeFGKpIHoBamC69bF9neL5NHLZmQ5yH3aZ4RApMw==
X-Received: by 2002:a17:906:4ad7:: with SMTP id u23-v6mr12455182ejt.202.1548490229472;
        Sat, 26 Jan 2019 00:10:29 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id f31sm12692806eda.16.2019.01.26.00.10.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 26 Jan 2019 00:10:28 -0800 (PST)
Date:   Sat, 26 Jan 2019 01:10:27 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     =?iso-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>,
        Remi Denis-Courmont <courmisch@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: Clang warnings in net/phonet
Message-ID: <20190126081027.GA30885@archlinux-ryzen>
References: <20190108025420.GA26093@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108025420.GA26093@flashbox>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:54:20PM -0700, Nathan Chancellor wrote:
> Hi all,
> 
> When building the kernel with Clang, this warning comes up in net/phonet.
> 
> net/phonet/pep.c:224:16: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
>         ph->data[0] = oph->data[1]; /* CTRL id */
>                       ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:281:10: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
>         switch (hdr->data[1]) {
>                 ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:285:12: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                         switch (hdr->data[4]) {
>                                 ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:295:8: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                         if (hdr->data[4] == PEP_IND_READY)
>                             ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:304:21: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
>                 atomic_add(wake = hdr->data[4], &pn->tx_credits);
>                                   ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:509:9: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
>         n_sb = hdr->data[4];
>                ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:817:14: warning: array index 1 is past the end of the array (which contains 1 element) [-Warray-bounds]
>         peer_type = hdr->other_pep_type << 8;
>                     ^    ~~~~~~~~~~~~~~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> net/phonet/pep.c:820:9: warning: array index 4 is past the end of the array (which contains 1 element) [-Warray-bounds]
>         n_sb = hdr->data[4];
>                ^         ~
> include/net/phonet/pep.h:66:3: note: array 'data' declared here
>                 u8              data[1];
>                 ^
> 8 warnings generated.
> 
> I have taken a look at the effected code but I can't really figure out
> the proper fix for this warning (my knowledge of C just isn't there
> yet). Nick had suggested changing 'u8 data[1]' to 'u8 *data' in
> 'struct pnpipehdr', which seems logical but I can't say for sure. Any
> advice would be appreciated :)
> 
> Thanks,
> Nathan

Gentle ping?
