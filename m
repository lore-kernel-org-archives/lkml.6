Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BEFC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB0B20870
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KseB4IjZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB0B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388226AbeGKSbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:31:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:40403 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387833AbeGKSbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:31:40 -0400
Received: by mail-io0-f196.google.com with SMTP id l14-v6so15070534iob.7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hNJPR+kq27fj1u6nAjlU7zqqTZl/XuV38TgYLpMVkbw=;
        b=KseB4IjZMFBFMMhveJpHsZ8eTR/nOOPdI59VSYIb9RJ5VMhBHxSaRqqFf8/sOBSp8k
         ArHzu1hSDMNVEwzqWlcumP4MELVp2ipgNXCHANu1t+Xt8n2v7YE/hbAugr0c/DA9ZSLm
         SECGVdEd1SxjHbJztl2Wu8ln47Y3c9iDLFds18syw7sASc16NZcX+Eh+a/E/Drm6lXqq
         Hrw2qDu0YvW1HJNQGppX3eajUzQ9moxYra5VZz24ZigD2CUY39DK9VP3o4wzde45wKRS
         6eaaOH00HTnWflCyirnfRhF6cC9NaBrmf4Vzstcx5Dy1VMRtpMmgFaR7zVgPI5+gJRA3
         epQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hNJPR+kq27fj1u6nAjlU7zqqTZl/XuV38TgYLpMVkbw=;
        b=RzS4tF/i8WPWRPxtzSXBV4z0EDviaEfZmcTjupxPS6cj9+iKH8jnrUQHUePUic8pYn
         MHEaaa0bps9P8krzx1Q5JLqHty3hHp5g1wKiMTmWUz2YVPrwl4pFpNG/Rlj/fEhA+49j
         TR+hEQJwLpohfz37qei05NdISHWxJzPx9oyUCe7/bKWW5AtV6CGYIA5o4FJRUsFvYe/q
         RTvEuFoICLwY4IblBM8jVspmpF1yKbKuRhcz4XOzo5wbMgRGC2w6GuiqtgPGaoS/DN8K
         d5/TOrk53rwwpF4HwJjU3Pj/OMtCpWBxxYEXWgrLNEqHE9x5FNpudeXDdYbl0+t+tgFD
         GCow==
X-Gm-Message-State: APt69E01dqRgcwfBZzIALq1mkfOwgxpzoI+9kwCBG8y1Ukmgz2YWQsfx
        mO76qg2/p2AyBPTrGzPso25OrA==
X-Google-Smtp-Source: AAOMgpfYeHf8RcEgDZyhNIXRv7fqvNt4v55RqFXmbqZH23AQxXkWtSmWusi7MjziUL20a7MTw6U8LA==
X-Received: by 2002:a02:4a0a:: with SMTP id k10-v6mr6432231jab.134.1531333567611;
        Wed, 11 Jul 2018 11:26:07 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u127-v6sm10731036iod.54.2018.07.11.11.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 11:26:07 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.86_2)
        (envelope-from <jgg@ziepe.ca>)
        id 1fdJoU-0005ww-3m; Wed, 11 Jul 2018 12:26:06 -0600
Date:   Wed, 11 Jul 2018 12:26:06 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Faisal Latif <faisal.latif@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Henry Orosco <henry.orosco@intel.com>,
        Tatyana Nikolova <tatyana.e.nikolova@intel.com>,
        Mustafa Ismail <mustafa.ismail@intel.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH] [v3] infiniband: i40iw, nes: don't use wall time for TCP
 sequence numbers
Message-ID: <20180711182606.GA22284@ziepe.ca>
References: <20180709083523.448587-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709083523.448587-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 10:34:43AM +0200, Arnd Bergmann wrote:
> The nes infiniband driver uses current_kernel_time() to get a nanosecond
> granunarity timestamp to initialize its tcp sequence counters. This is
> one of only a few remaining users of that deprecated function, so we
> should try to get rid of it.
> 
> Aside from using a deprecated API, there are several problems I see here:
> 
> - Using a CLOCK_REALTIME based time source makes it predictable in
>   case the time base is synchronized.
> - Using a coarse timestamp means it only gets updated once per jiffie,
>   making it even more predictable in order to avoid having to access
>   the hardware clock source
> - The upper 2 bits are always zero because the nanoseconds are at most
>   999999999.
> 
> For the Linux TCP implementation, we use secure_tcp_seq(), which appears
> to be appropriate here as well, and solves all the above problems.
> 
> i40iw uses a variant of the same code, so I do that same thing there
> for ipv4. Unlike nes, i40e also supports ipv6, which needs to call
> secure_tcpv6_seq instead.
> 
> Acked-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use secure_tcpv6_seq for IPv6 support as suggested by Shiraz Saleem.
> v3: add a soft IPv6 dependency to prevent a link error with CONFIG_IPV6=m,
>     this now forces i40iw to be a module as well, add an IS_ENABLED()
>     check to avoid calling it when IPV6 is completely disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/infiniband/hw/i40iw/Kconfig    |  1 +
>  drivers/infiniband/hw/i40iw/i40iw_cm.c | 26 +++++++++++++++++++++-----
>  drivers/infiniband/hw/nes/nes_cm.c     |  8 +++++---
>  net/core/secure_seq.c                  |  1 +
>  4 files changed, 28 insertions(+), 8 deletions(-)

Applied to for-next thanks

Jason
