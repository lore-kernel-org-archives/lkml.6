Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42A5FC070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D354E21480
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 06:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTZ6k8lL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D354E21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbeINLj7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 07:39:59 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36283 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbeINLj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 07:39:59 -0400
Received: by mail-pl1-f196.google.com with SMTP id p5-v6so3718401plk.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 23:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LBYa0QXyTtj/nKUARmuDfMrcup/ZVecqySBUQLIrsV4=;
        b=QTZ6k8lL20WwLx+7a/mPcUdn/pM9/gHLN5+gG8YKX5KD/pRu1Y3pr42LNrPQw3kkvG
         fLV3pVf5WAaNom13srJ8l9wz7nCpd8Geht2hjtcVlcjFprkzxOaL+1c5dXNuQPhxYtlJ
         oEvS1UMFQ/BV+SyPJ0AuQieWjt3vUbOUw2rEp7gHFwUL9T4UgAOilkrw/5A+dIV6Pao6
         VU9o9GWfWZeQGu5uT3p9AvodnkpZY9eK2e/qm2x2f5W4OTVVWqNNn7Wp4aTgiM+TIjQ9
         Rb1oQXATf4rAxwUA77X+0jzP7wAgCsDtFAaZ43D/e8k/dZLAvDHUL/E/erahx+SYYZNl
         FxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=LBYa0QXyTtj/nKUARmuDfMrcup/ZVecqySBUQLIrsV4=;
        b=Hog9JIYCkBxRzmfjOghwdF7EcvSeWXjOP/GJoop86NzMcjKqpkF36xbWfm1rHoCVe8
         t8DQEWMa/CyuFmwWxXBnpu9vR9cvRV24Zy8rrijKntRp7aRWSr8kVqUjLxUlD0ULFUYU
         x6oU63A6pwpg+FBsYW5Rojlt8eHucsnx8Xp/s9DIyrzKJjf0nqF3VxbMICVjFLwKFw1k
         exHjvlH3eRduZ0KNwRAIcw1m+74+5EpQVscsaLVNS6AniKSLfdzWp9PMGJSY3IZ+pw8z
         hXdjiG8zrud0JW4q7DqCCYe2tIOu8/YNp/GaAceUEKxpyxkAivDaSshQcEXiTh6td/nk
         bx9A==
X-Gm-Message-State: APzg51DxxCIMhx6wvDlEMISgep6tV7ajfmo1LFdZ7MhevwlZabueT/wf
        qqZ5JCSF/X+m0NC1TqvdUGE=
X-Google-Smtp-Source: ANB0VdY1UhD1LUmQsdoICcPIcBgswpxI0iFiClF5Man/RuTZZLt2DwhtYqevhf4iHpBARzCWVqfb1g==
X-Received: by 2002:a17:902:7c07:: with SMTP id x7-v6mr10485043pll.113.1536906420728;
        Thu, 13 Sep 2018 23:27:00 -0700 (PDT)
Received: from rodete-desktop-imager.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id q62-v6sm7927872pfi.185.2018.09.13.23.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 23:26:59 -0700 (PDT)
Date:   Fri, 14 Sep 2018 15:26:55 +0900
From:   Minchan Kim <minchan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk,
        steve.capper@linaro.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org,
        android-treble-mediatek-ext@partner.android.com,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        Simon Horman <horms@verge.net.au>
Subject: Re: [RFC 1/3] arm: mm: reordering memory type table
Message-ID: <20180914062655.GA102810@rodete-desktop-imager.corp.google.com>
References: <20180906102212.218294-1-minchan@kernel.org>
 <20180906102212.218294-2-minchan@kernel.org>
 <20180910165011.zcighyuabshsmxjb@armageddon.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910165011.zcighyuabshsmxjb@armageddon.cambridge.arm.com>
User-Agent: Mutt/1.10.1+60 (6df12dc1) (2018-08-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 05:50:11PM +0100, Catalin Marinas wrote:
> On Thu, Sep 06, 2018 at 07:22:10PM +0900, Minchan Kim wrote:
> > diff --git a/arch/arm/include/asm/pgtable-2level.h b/arch/arm/include/asm/pgtable-2level.h
> > index 92fd2c8a9af0..91b99fadcba1 100644
> > --- a/arch/arm/include/asm/pgtable-2level.h
> > +++ b/arch/arm/include/asm/pgtable-2level.h
> > @@ -164,14 +164,23 @@
> >  #define L_PTE_MT_BUFFERABLE	(_AT(pteval_t, 0x01) << 2)	/* 0001 */
> >  #define L_PTE_MT_WRITETHROUGH	(_AT(pteval_t, 0x02) << 2)	/* 0010 */
> >  #define L_PTE_MT_WRITEBACK	(_AT(pteval_t, 0x03) << 2)	/* 0011 */
> > +#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> >  #define L_PTE_MT_MINICACHE	(_AT(pteval_t, 0x06) << 2)	/* 0110 (sa1100, xscale) */
> >  #define L_PTE_MT_WRITEALLOC	(_AT(pteval_t, 0x07) << 2)	/* 0111 */
> > -#define L_PTE_MT_DEV_SHARED	(_AT(pteval_t, 0x04) << 2)	/* 0100 */
> > -#define L_PTE_MT_DEV_NONSHARED	(_AT(pteval_t, 0x0c) << 2)	/* 1100 */
> > +#if defined(CONFIG_CPU_V7) || defined(CONFIG_CPU_V7M) || \
> > +	defined (CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> > +#define L_PTE_MT_DEV_WC		L_PTE_MT_BUFFERABLE
> > +#define L_PTE_MT_DEV_CACHED	L_PTE_MT_WRITEBACK
> > +#define L_PTE_MT_DEV_NONSHARED	L_PTE_MT_MINICACHE
> 
> I think you can just ignore v7M here, it doesn't have an MMU.

I didn't know that. Will fix.

> 
> You are defining L_PTE_MT_DEV_NONSHARED to L_PTE_MT_MINICACHE but what I
> think you just meant is index 6 in the cpu_v6_mt_table which I would use
> explicitly to avoid confusion.
> 
> Anyway, on ARMv7 or ARMv6+LPAE, the non-shared device gets mapped to
> shared device in hardware. Looking through the arm32 code, it seems that

Thanks for the information. I didn't know that.

> MT_DEVICE_NONSHARED is used by arch/arm/mach-shmobile/setup-r8a7779.c
> and IIUC that's a v7 platform (R-Car H1, Cortex-A9). I think the above
> should be defined to L_PTE_MT_DEV_SHARED, unless I miss any place where
> DEV_NONSHARED is relevant on ARMv6 (adding Simon to confirm on
> shmobile).

Simon, could you confirm this?

> 
> > diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
> > index 81d0efb055c6..f896a30653fa 100644
> > --- a/arch/arm/mm/proc-macros.S
> > +++ b/arch/arm/mm/proc-macros.S
> > @@ -134,21 +134,21 @@
> >  	.macro	armv6_mt_table pfx
> >  \pfx\()_mt_table:
> 
> Since you changed the MT index, you'd have to fix proc-v7-*levels.S  as
> well. If you define DEV_NONSHARED to SHARED, I think you only need to
> update the index for L_PTE_MT_VECTORS.

Good idea. I will try it on.

Thanks for the review, Catalin.
