Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04DF6C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965E921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 01:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qTuXyQN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965E921547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388960AbeIUHaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 03:30:03 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45817 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387971AbeIUHaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 03:30:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id j8-v6so5161283pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 18:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/SEihLXLWty0JneGq3T7K8PQMcvfGwdrxcbd2IMk44=;
        b=qTuXyQN1zS7AM/ii3H4jyLTsuRpWX+NqtvhFjTC00Kp7uaRil0dHO5jvcfgtAAltWd
         ve9KssNmGU/8Ocu8zy7vD+43wCnkNuIBdPgbxSNBRuoFmSUyLVxSKBtM/v7TJrDUbFBb
         mQ5+iDCb2rGpd9mHF++8LrnycHwynN9s0jm35pHi8PZ0VlThsvJNF+PCZNGoBkGU0/A9
         SMJB/Mqlc0v0YXxn5JMOC7xvGPEEk60I3zzgMBP5DSBZIwCR0ljly9RH8C9BamXr+Ltq
         J2pUCv8QWvlB36GLqOz1SPB13m72qKjQNTKV+NRMs4FOoUw5M/blHcjyLlKoZYNGFwty
         SCJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/SEihLXLWty0JneGq3T7K8PQMcvfGwdrxcbd2IMk44=;
        b=hRib+lpOzf0BiHj43R3cQKhrwR4JzAY62FVNloaoY08meM6MqEMzzZu9EnI1Jxf7Lt
         SOHJhxx72GvvA2VYvWkQI+C9MIROBMwaE9J4eFuueSASkzt4ihXTD05yQ60ze9dRy4ni
         IRCqQwgJkogy/Lrgkf1Hl0lnncq4K/Hb2ArbeDioDYdKJJHqHkuybTdvgsPiXctUQh5e
         qIjAdE5/ykizt5waa2ty5jqyvjOBc9SQmom8a17TvrfooTAXe/pN8vsAXVv0jD5hJn6y
         S9gA1lPhIhldcy8Mda2PoX3EBkb9SOP7nAuinDgrPi0HR2b72Qgd6tQ1uSDBO3+OuRh8
         YGyA==
X-Gm-Message-State: APzg51BCTmlw5KwDx8mzGQs9uPSZEJ+0nrX7/yalAqim7utm1w/xppMJ
        i1vkJXFudxZS5wdH7COYHC4=
X-Google-Smtp-Source: ANB0VdbV5qb04RDf90e+abJ7kbll5JRlLP0rRCT6j6tphAUB0K8ZHumzOxUajC1xlFF6ZeOVPM+MaA==
X-Received: by 2002:a17:902:6b83:: with SMTP id p3-v6mr42138915plk.133.1537494218670;
        Thu, 20 Sep 2018 18:43:38 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id e7-v6sm32507226pgc.55.2018.09.20.18.43.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 18:43:38 -0700 (PDT)
From:   Minchan Kim <minchan.kernel@gmail.com>
X-Google-Original-From: Minchan Kim <minchan@kernel.org>
Date:   Fri, 21 Sep 2018 10:43:32 +0900
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        miles.chen@mediatek.com, jian-min.lui@mediatek.com,
        juju.sung@mediatek.com, Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH v1 1/3] arm: mm: reordering memory type table
Message-ID: <20180921014332.GA112825@rodete-desktop-imager.corp.google.com>
References: <20180917004451.174527-1-minchan@kernel.org>
 <20180917004451.174527-2-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180917004451.174527-2-minchan@kernel.org>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

Could you have a chance to review this patchset?

Thanks!

On Mon, Sep 17, 2018 at 09:44:49AM +0900, Minchan Kim wrote:
> To use bit 5 in page table as L_PTE_SPECIAL, we need a room for that.
> It seems we don't need 4 bits for the memory type with ARMv6+.
> If it's true, let's reorder bits to make bit 5 free.
> 
> We will use the bit for L_PTE_SPECIAL in next patch.
> 
> A note from Catalin
> "
> > Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> > shared device in hardware. Looking through the arm32 code, it seems that
> > MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> > and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> > should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> > DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on shmbile).
> "
> 
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Steve Capper <steve.capper@linaro.org>
> Cc: Simon Horman <horms@verge.net.au>
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> ---
>  arch/arm/include/asm/pgtable-2level.h | 19 +++++++++++++++----
>  arch/arm/mm/proc-macros.S             |  4 ++--
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> index 92fd2c8a9af0..514b13c27b43 100644
> --- a/arch/arm/include/asm/pgtable-2level.h
> +++ b/arch/arm/include/asm/pgtable-2level.h
> @@ -164,14 +164,25 @@
>  #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
>  #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
>  #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
> +#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> +#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x05) << 2)	/* 0101 */
>  #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
>  #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
> -#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> -#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> +#if defined(CONFIG_CPU_V7) || defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> +/*
> + * On ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> + * shared device in hardware.
> + */
> +#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_DEV_SHARED
> +#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
> +#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
> +#define L_PTE_MT_MASK		(_AT(pteval_t, 0x07) << 2)
> +#else
>  #define L_PTE_MT_DEV_WC		(_AT(pteval_t, 0x09) << 2)	/* 1001 */
>  #define L_PTE_MT_DEV_CACHED	(_AT(pteval_t, 0x0b) << 2)	/* 1011 */
> -#define L_PTE_MT_VECTORS	(_AT(pteval_t, 0x0f) << 2)	/* 1111 */
> -#define L_PTE_MT_MASK		(_AT(pteval_t, 0x0f) << 2)
> +#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> +#define L_PTE_MT_MASK           (_AT(pteval_t, 0x0f) << 2)
> +#endif
>  
>  #ifndef __ASSEMBLY__
>  
> diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> index 81d0efb055c6..367a89d5aeca 100644
> --- a/arch/arm/mm/proc-macros.S
> +++ b/arch/arm/mm/proc-macros.S
> @@ -138,7 +138,7 @@
>  	.long	PTE_CACHEABLE					@ L_PTE_MT_WRITETHROUGH
>  	.long	PTE_CACHEABLE | PTE_BUFFERABLE			@ L_PTE_MT_WRITEBACK
>  	.long	PTE_BUFFERABLE					@ L_PTE_MT_DEV_SHARED
> -	.long	0x00						@ unused
> +	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
>  	.long	0x00						@ L_PTE_MT_MINICACHE (not present)
>  	.long	PTE_EXT_TEX(1) | PTE_CACHEABLE | PTE_BUFFERABLE	@ L_PTE_MT_WRITEALLOC
>  	.long	0x00						@ unused
> @@ -148,7 +148,7 @@
>  	.long	PTE_EXT_TEX(2)					@ L_PTE_MT_DEV_NONSHARED
>  	.long	0x00						@ unused
>  	.long	0x00						@ unused
> -	.long	PTE_CACHEABLE | PTE_BUFFERABLE | PTE_EXT_APX	@ L_PTE_MT_VECTORS
> +	.long	0x00						@ unused
>  	.endm
>  
>  	.macro	armv6_set_pte_ext pfx
> -- 
> 2.19.0.397.gdd90340f6a-goog
> 
