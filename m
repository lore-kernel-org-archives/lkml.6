Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07F9C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58F08223FF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 14:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJ3VAtuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F08223FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbeHJQhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:37:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35009 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727209AbeHJQhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:37:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id w10-v6so4472618pgv.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HVt7FW19u8tMo6vfrtI8/3GLIdrPIeba9/QiqzhT/oQ=;
        b=HJ3VAtuMafU621wINd9xmQTToStSPoR5V9hrZZAVM0ir3vSXLNxNFIyyrFwCRJISCM
         +0hN968bzG83E2U71tr8PkrUr5fNlihoG0pBq56C7sk8BYclOe1gjfaCLZLpz0EZVLDS
         /RnLezS245RgtzAPhbu7qf+MClugRReDcwI1q7qYLwrccdtferT3nE3Uq1Axmb1bSKDB
         SvpV7IQtvJdP2hsnpU8Dq/p35XiOOnpIgBV7YSSzrZv2ykbWCR2t+iUiQQ1QKHBBtCdM
         Ezq9GklBIiMO7HSHjblMrBVBefM74o1YEh7ehsWv4SnAHfZWolI9CBBEDUXSaToEqTsz
         3vvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=HVt7FW19u8tMo6vfrtI8/3GLIdrPIeba9/QiqzhT/oQ=;
        b=TRfsoucAbFvTGzC7DWtuU1hM9bo5Iy1fFpXS5Vofv+nO0bjAjolIBe7oSR6mEmYeHD
         Hgi2QWxvmoW19d2qMglj880VBYQ9skr/5SikvplICagA1g1+VBWyIiGnRw/6xdqJunJb
         nLeLVeFp7fvdKKqbQobKFkQ3f7Z3+aqYvEpcc2T2wipEFQhKk86890MFuzVSfT87nlT2
         nRdYtIDZppDpbNFWpqHI0LMFj5eC19pw+98U8wp8gOhWYLaOFmPPUI/MLRWCBABm97MK
         4Atemll6ePe3yyKgh5Ui7F5xxVzL88o0acLNJ/Djp1BHxz27e0nRHtsb4YV5+F0mVlWP
         cxIQ==
X-Gm-Message-State: AOUpUlFTljci4ZjYt0QSnkV8Nq2Loqi0W69ZOt52SP+Js1WGODmp+hph
        3cE8U8rs4z9o2R6+ucver54=
X-Google-Smtp-Source: AA+uWPwfqyXsdHR3QVs3j9BXatiz8Q3S2GYOGK+VaoWjVTE/Uz+YuwItXrRDAHdFra+AOA2ZcEOt0w==
X-Received: by 2002:a65:46ca:: with SMTP id n10-v6mr6744976pgr.345.1533910058376;
        Fri, 10 Aug 2018 07:07:38 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id x80-v6sm24726209pfe.129.2018.08.10.07.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 07:07:37 -0700 (PDT)
Date:   Fri, 10 Aug 2018 07:07:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        tklauser@distanz.ch, Arnd Bergmann <arnd@arndb.de>,
        Andrew Waterman <andrew@sifive.com>,
        linux@dominikbrodowski.net, dan.carpenter@oracle.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Message-ID: <20180810140736.GA13061@roeck-us.net>
References: <20180809221952.24260-1-palmer@sifive.com>
 <20180809221952.24260-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809221952.24260-2-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 03:19:51PM -0700, Palmer Dabbelt wrote:
> This would be necessary to make non-SMP builds work, but there is
> another error in the implementation of our syscall linkage that actually
> just causes sys_riscv_flush_icache to never build.  I've build tested
> this on allnoconfig and allnoconfig+SMP=y, as well as defconfig like
> normal.
> 
> CC: Christoph Hellwig <hch@infradead.org>
> CC: Guenter Roeck <linux@roeck-us.net>
> In-Reply-To: <20180809055830.GA17533@infradead.org>
> In-Reply-To: <20180809132612.GA31058@roeck-us.net>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/riscv/include/asm/vdso.h |  2 --
>  arch/riscv/kernel/sys_riscv.c | 12 ++++++++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
> index 541544d64c33..ec6180a4b55d 100644
> --- a/arch/riscv/include/asm/vdso.h
> +++ b/arch/riscv/include/asm/vdso.h
> @@ -38,8 +38,6 @@ struct vdso_data {
>  	(void __user *)((unsigned long)(base) + __vdso_##name);			\
>  })
>  
> -#ifdef CONFIG_SMP
>  asmlinkage long sys_riscv_flush_icache(uintptr_t, uintptr_t, uintptr_t);
> -#endif
>  
>  #endif /* _ASM_RISCV_VDSO_H */
> diff --git a/arch/riscv/kernel/sys_riscv.c b/arch/riscv/kernel/sys_riscv.c
> index f7181ed8aafc..568026ccf6e8 100644
> --- a/arch/riscv/kernel/sys_riscv.c
> +++ b/arch/riscv/kernel/sys_riscv.c
> @@ -48,7 +48,6 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>  }
>  #endif /* !CONFIG_64BIT */
>  
> -#ifdef CONFIG_SMP
>  /*
>   * Allows the instruction cache to be flushed from userspace.  Despite RISC-V
>   * having a direct 'fence.i' instruction available to userspace (which we
> @@ -66,15 +65,24 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
>  SYSCALL_DEFINE3(riscv_flush_icache, uintptr_t, start, uintptr_t, end,
>  	uintptr_t, flags)
>  {
> +#ifdef CONFIG_SMP
>  	struct mm_struct *mm = current->mm;
>  	bool local = (flags & SYS_RISCV_FLUSH_ICACHE_LOCAL) != 0;
> +#endif
>  
>  	/* Check the reserved flags. */
>  	if (unlikely(flags & ~SYS_RISCV_FLUSH_ICACHE_ALL))
>  		return -EINVAL;
>  
> +	/*
> +	 * Without CONFIG_SMP flush_icache_mm is a just a flush_icache_all(),
> +	 * which generates unused variable warnings all over this function.
> +	 */
> +#ifdef CONFIG_SMP
>  	flush_icache_mm(mm, local);
> +#else
> +	flush_icache_all();
> +#endif
>  
>  	return 0;
>  }
> -#endif
> -- 
> 2.16.4
> 
