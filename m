Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37EF0C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:43:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF55621785
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWxGyOPG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF55621785
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbeHMGX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 02:23:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38017 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbeHMGX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 02:23:28 -0400
Received: by mail-pl0-f66.google.com with SMTP id u11-v6so6347194plq.5;
        Sun, 12 Aug 2018 20:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=L+T3hRbA3G+EAVL45olDMU1Uft90dhRV3PfkXKItexE=;
        b=lWxGyOPGXH8YKAHyhWAWcAtTFJOn0r2iVTm+kaNOfWaCxl6omvGs2o3GWgv3ny4OpZ
         BZrcbJncjwh6grYtTVSjpNE97MlW4u9QMBFQHkfWyMRTXU0MxfDM1ABoNDGn++sPXVn/
         VE3ZlS1B6mDKR6JLgzKIUhE6ZMDQquG2o44Td7eo9s2pq6LnYOIV64P91S1brygaxLjo
         s39EQbWZ2XSuIC2MaTjsaNNaykaC9JJtMOKs01k7+ZqdSytTjkuCtb96F8SqS4xuOnpD
         D5yYfGknKItX3gu4AexraRKa8uj4nGvtCJ13QUfuY28wzKr2KPkKVofUj/1fDv+njeHi
         JVvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=L+T3hRbA3G+EAVL45olDMU1Uft90dhRV3PfkXKItexE=;
        b=oHQn/1e9Kr72MtHWW47YaLDaoJRLYFdW2+Y93ojoWdkRg8BAuy2xpkdL53+dLT9WUo
         yDlTaU0KU2cyMM83Cjh2sCM9t88iVETKX9I96YsIkaWfB5QbLdohrgd9vSPQ8quXkTZb
         xo2FPATdZ9xfTwNtMF7FR8tviThKFLalaZQboGX5leIkKNuf0ela2hc1kj6+FI9wrJVX
         kNNtqEbv0bonK6nNPaxaIqsDi2hYwoqkKCeS9G9ik8hBJqM9tbD1xRcaHgxqEdPPr9oq
         LIzWB4GfRzX2iKjtmrpKJY7/j12KMNmXjZKRmywoIPBaL64sOHg+pK6nzaJErqKMgIqX
         QKMg==
X-Gm-Message-State: AOUpUlGvFKT4/UweFCflkUt8LJL3p2Exg/ivORyjejhq1Ks7PvBauF5q
        sSZUvAdaleUdubcNM2P/fxv5knUF
X-Google-Smtp-Source: AA+uWPwSM1BR7jYVAQ9W3PgEoPBmV2ra8/2JjjFzysNPI8i6YZEMrRBvVHxG7ZvNPBeUbPbOnmdmvw==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr15167355pln.261.1534131788174;
        Sun, 12 Aug 2018 20:43:08 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:1501:200:5efe:166.111.71.57? ([2402:f000:1:1501:200:5efe:a66f:4739])
        by smtp.gmail.com with ESMTPSA id z2-v6sm15008669pgv.12.2018.08.12.20.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 20:43:07 -0700 (PDT)
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs: nfs: callback_proc: a possible sleep-in-atomic-context bug
 in nfs4_callback_sequence()
Message-ID: <d2edd56f-782e-737b-b6a8-ca0b5be94f00@gmail.com>
Date:   Mon, 13 Aug 2018 11:43:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel may sleep with holding a spinlock.

The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule_timeout
fs/nfs/nfs4session.c, 223: schedule_timeout in nfs4_slot_wait_on_seqid
fs/nfs/callback_proc.c, 466: nfs4_slot_wait_on_seqid in 
referring_call_exists
fs/nfs/callback_proc.c, 544: referring_call_exists in nfs4_callback_sequence
fs/nfs/callback_proc.c, 504: spin_lock in nfs4_callback_sequence

I do not find a good way to fix, so I only report.
This is found by my static analysis tool (DSAC).


Thanks,
Jia-Ju Bai
