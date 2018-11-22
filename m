Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7BDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 424F32075B
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 02:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SXgHBtNF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424F32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbeKVMv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 07:51:56 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40917 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731733AbeKVMv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 07:51:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22-v6so8103073pls.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 18:14:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ASXW2aBNxikJdFrHoVJ0ICyUK293AgPjvojixI5CG/k=;
        b=SXgHBtNFgWzrSjiTtXcRM5sdGJTXoNiKvlcAfn0JxYTWz5pqooJvoi7Vva9H1oCFq7
         CVG9TsNty/GESiOizP+NZbm4pFziQDze37G+r1+nKVK8/Kwokbh2SAjzR8Ml9t/JdwJF
         /YbCpV01xLrH15ipeO04Q27HiFl9Z+Qb4vZZXJ3a3RM44R3rY6Yce5ykHexQQBFwik3m
         JjFoVt3nLp2xROT0tvtLg7qilOlwOOcT3xxpAqQuNWPBaWb7GNoMnj+dJUJ7SBLVtyLc
         WZzYEFiJJ+4WSHnGURSEFCZAlkyIRdgS7aHUuRAoil0uB/DCgB2h2PScp1wiaoB7+qaC
         P9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ASXW2aBNxikJdFrHoVJ0ICyUK293AgPjvojixI5CG/k=;
        b=aG1Do7c6Nai3Hnh1L134Y9hiWVzdgb7W1+1H+APLK/rZQ4NnSDt4aevWT2rx1yRRsJ
         PdIgvUUbwfqiBKDwmnZQllFgPHSfqF8Hm19HHmPOKRD4Gkh6+DaJG4HVNLxkfpmiXPwD
         BgwxiM/5EIAS2pGaOQdR5kTILCDy56VRO3e1xbOiAANhOX1vNrBVlXndvMYFNSbR2MyL
         Xbae05qybJRf7BEon20IMeFIgqV+6b6TuWiBP5Ffn/XBed9OV8V3NJ9N9t+6kdCQQ27h
         ERdQyx3g6gvYyw/ab9vVSENH+s8HBX4rh4H8ITcswqgdtJpLGrUKQSsaPU+kAZLonpsU
         r/nA==
X-Gm-Message-State: AGRZ1gJ5o+bPnUNAWyorN3WfpqJ9/LqXuinduJQutcFq5nmIh5AS7PPY
        cux3iyFhHqQPGWRUYHm98UYd/NtI
X-Google-Smtp-Source: AJdET5fisx/iuNV4/W3+X6T5pVvWu3u0oS1/wuJZObFnYx/i8v1exv7inlGwCezemW2OPgqvmxElzg==
X-Received: by 2002:a62:3501:: with SMTP id c1-v6mr9326814pfa.173.1542852887940;
        Wed, 21 Nov 2018 18:14:47 -0800 (PST)
Received: from localhost ([175.223.27.1])
        by smtp.gmail.com with ESMTPSA id g11sm25678849pfo.139.2018.11.21.18.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 18:14:46 -0800 (PST)
Date:   Thu, 22 Nov 2018 11:14:43 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] zram: support idle page writeback
Message-ID: <20181122021442.GB3441@jagdpanzerIV>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-5-minchan@kernel.org>
 <20181121045551.GC599@jagdpanzerIV>
 <20181121133408.GA103278@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121133408.GA103278@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/21/18 05:34), Minchan Kim wrote:
> > 
> > Just a thought,
> > 
> > I wonder if it will make sense (and if it will be possible) to writeback
> > idle _compressed_ objects. Right now we decompress, say, a perfectly
> > fine 400-byte compressed object to a PAGE_SIZE-d object and then push
> > it to the WB device. In this particular case it has a x10 bigger IO
> > pressure on flash. If we can write/read compressed object then we
> > will write and read 400-bytes, instead of PAGE_SIZE.
> 
> Although it has pros/cons, that's the my final goal although it would
> add much complicated stuffs. Sometime, we should have the feature.

So you plan to switch to "compressed objects" writeback?

> However, I want to go simple one first which is very valuable, too.

Flash wearout is a serious problem; maybe less of a problem on smart
phones, but much bigger on TVs and on other embedded devices that have
lifespans of 5+ years. With "writeback idle compressed" we can remove
the existing "writeback incompressible pages" and writeback only
"idle, compressed" pages.

The existing incompressible writeback is way too aggressive, and,
additionally, it's too simple. It writes-back pages which can be
swapped in immediately; which basically means that we do pointless
PAGE_SIZE writes to a device which doesn't really like pointless
writes.

It's a whole different story with idle, compressible pages writeback.

	-ss
