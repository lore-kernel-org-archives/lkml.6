Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74701C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A92A20672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llQI4sda"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A92A20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439405AbeKWMyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:54:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44484 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733249AbeKWMyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:54:19 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so2628681pfh.11
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 18:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XCTSGJPI2pxoL2tH0QhREu8eLq4LidKOy8XFjFCPlc4=;
        b=llQI4sda3fn0LoR9Y1v5RTj2FzDO62HH9OFVrI3I70nu7AsKAqskmfLJFmzCfHreAL
         trSuKA0pn01io6L1Jp3GnN3EyV/bpxCpa+oixA10FuGhvZJr0Kr8dKh4hJx0XyOJ97uq
         iRc2VTkcb7mmiRI+RnOrLQep5JrTwvhO/kVDb/9eVXTH6dYX4f7RZ+5pmBL4GzTqZQp0
         br0uxsGXl2ihiYFk9UgLpSVkuovpc1GbQfyejYKkMSMd4e0gU9AqWEKvMn3Myhn/OdoU
         4rOHnCZTuG78oo3AmAdvPs4HHgDUwfPk7Fkcn+8clkYWpJ3Kziy++u10qmPGPzvVnGLp
         suMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XCTSGJPI2pxoL2tH0QhREu8eLq4LidKOy8XFjFCPlc4=;
        b=ta3CWLLsDhZ9/Yihu4d6msk/+qLJKABl2A8sKKKHWL3zDAh3Df0bUZTlH7LiCzcM8/
         3R7zJFTbHlYab/wOBK/nyZmVnBYAzbvfS7qlgX2cLyDBglVTPRmxD428yt1XivPH0bgG
         aMoyiJ/8+qtG3t3/ZzPK0bXv9x4A6nAmHIzrpoINBS/3iElxk0JBQlKMG9qFvtJnfft6
         nffXST6shG/p/daIdIxCQiUaGO3Yvb3frp5fyPCj06Ap8XsPOxHxAYGOhjJ0T7qneWLy
         GCtyVpwgTyI7hsha/BneR7PBVP3+uVPCz3ONuwOfAZudGI92K7cdb2K9dzV+Mi4Nh8VT
         ld/g==
X-Gm-Message-State: AA+aEWa9Zfx9e+EQoe8umRewFBhof7214jiSlbWWQi9H4YKjfDm1qUnu
        7z3972BFP/LMhtFnDrJrof4=
X-Google-Smtp-Source: AFSGD/X/HKjt+bYwUGtLCjld5ESJGUy7R4zlGl0AhaYYTSwfurZkAishWPc6FDvsGPzoJZ5PJSaChA==
X-Received: by 2002:a63:3703:: with SMTP id e3mr12020788pga.348.1542939127197;
        Thu, 22 Nov 2018 18:12:07 -0800 (PST)
Received: from localhost ([175.223.19.111])
        by smtp.gmail.com with ESMTPSA id c67sm30917027pfg.170.2018.11.22.18.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 18:12:06 -0800 (PST)
Date:   Fri, 23 Nov 2018 11:12:02 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Dave Rodgman <dave.rodgman@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        nd <nd@arm.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Matt Sealey <Matt.Sealey@arm.com>,
        "nitingupta910@gmail.com" <nitingupta910@gmail.com>,
        "rpurdie@openedhand.com" <rpurdie@openedhand.com>,
        "markus@oberhumer.com" <markus@oberhumer.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "sergey.senozhatsky.work@gmail.com" 
        <sergey.senozhatsky.work@gmail.com>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: [PATCH 0/6] lib/lzo: performance improvements
Message-ID: <20181123021202.GA1582@jagdpanzerIV>
References: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0802MB25289788BFADB136CE08AADA8FDA0@VI1PR0802MB2528.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (11/21/18 12:06), Dave Rodgman wrote:
> 
> Overall, performance is improved by around 1.1 - 4.8x (data-dependent: data
> with many zero runs shows higher improvement). Under real-world testing with
> zram, time spent in (de)compression during swapping is reduced by around 27%.

Impressive.

I think we usually Cc Greg Kroah-Hartman and Andrew Morton on
lzo/lz4 patches.

> The graph below shows the weighted round-trip throughput of lzo, lz4 and
> lzo-rle, for randomly generated 4k chunks of data with varying levels of
> entropy. (To calculate weighted round-trip throughput, compression performance
> is emphasised to reflect the fact that zram does around 2.25x more compression
> than decompression.

Right. The number is data dependent. Not all swapped out pages can be
compressed; compressed pages that end up being >= zs_huge_class_size() are
considered incompressible and stored as it.

I'd say that on my setups around 50-60% of pages are incompressible.

	-ss
