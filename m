Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD301C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7970622392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 21:20:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P96jqJxd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7970622392
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbeHIXrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 19:47:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33335 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726991AbeHIXrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 19:47:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so3453901pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 14:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z6hpCWDLuA/m7tlVl+PJxoVurH2Mg7cCFcnMH6+9q+Q=;
        b=P96jqJxdiTlJ+gGgeYjWav5iEk4kVJc4Snq0xrD4DedS4f/d988bsSXXW3GzuIMlO2
         FfB2+MAcYyWm4rpVHKT+qjiSJ8enoLeN+wqcPAkJruW73EKb2p5pNuWdXIBSxv/LY9D5
         SXZuw5ZXFp5GBq2T/aGxTgwRVnOTTvQ1R/r6nwJk8clp4SKn4cCIy7H8T8JC+HEGULEI
         22I4NOZyFU+c+Ca+k+xHnozgJuKBkTl7q9y3WMBWCWUfKiELR9KYxWqucO9IA/+XPQdW
         LHcGZSBXK47dogTZdu0rY13jJIsUwh0OLtFvvV/0s8juyWA/6TkzPpgXSW2sM6/liK3/
         Fc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=z6hpCWDLuA/m7tlVl+PJxoVurH2Mg7cCFcnMH6+9q+Q=;
        b=kpC44gD2qUNC9llW1jQijlSh5OvqdFxTTzkJcXr7ApIgoQyTxCUkdnwlwtTCpRKrjZ
         ihop7qhJG5qZIZD4GNpUxbvklcvOkOqpgbWoEJPER3QOefaaQEosspy6WmHRwuganGpb
         bX6WRJhdrLsotXSbos4a1e+niMPZWFcq1d0teN4uSdm2dFYwnLjB6bY82hLwE4eN8xp7
         IfQlmNuuL0yh56+8d9RK6kz3becHZlpggH6+Nscxdnl1p644ekHskH/eRbR+IenjJqsZ
         u9PSqCmBI1adJAXO+AugD7GcRkMmVtQakTB9xPSH60vErt7Gd8Yinv+McTRsYPP083hA
         KQdQ==
X-Gm-Message-State: AOUpUlFIhMoZYWL3ghF1IxbkNwavMjcUBsFnGqRF8GOnqeZmj27sGo70
        QonPRaYH5a/7T7LLSVECC2Q=
X-Google-Smtp-Source: AA+uWPwY+gLrmiyM3mFiacHPtaX2TneaMuD2rxxnY/aUy8IL7e8jIHa0Tb9v1yO79PTjj7fW8SAreA==
X-Received: by 2002:a65:6551:: with SMTP id a17-v6mr3718276pgw.132.1533849656088;
        Thu, 09 Aug 2018 14:20:56 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e14-v6sm10056510pff.128.2018.08.09.14.20.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 14:20:55 -0700 (PDT)
Date:   Thu, 9 Aug 2018 14:20:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Christoph Hellwig <hch@infradead.org>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, tklauser@distanz.ch,
        Andrew Waterman <andrew@sifive.com>, dan.carpenter@oracle.com,
        linux@dominikbrodowski.net, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] RISC-V: Define sys_riscv_flush_icache when SMP=n
Message-ID: <20180809212053.GA13675@roeck-us.net>
References: <20180809202524.1702-1-palmer@sifive.com>
 <20180809202524.1702-2-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809202524.1702-2-palmer@sifive.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 01:25:23PM -0700, Palmer Dabbelt wrote:
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

[Compile-]Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/riscv/include/asm/vdso.h |  2 --
>  arch/riscv/kernel/sys_riscv.c | 10 ++++++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
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
> index f7181ed8aafc..180da8d4e14a 100644
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
> @@ -66,15 +65,22 @@ SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
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
> +	 * Without CONFIG_SMP flush_icache_mm is a NOP, which generates unused
> +	 * variable warnings all over this function.
> +	 */
> +#ifdef CONFIG_SMP
>  	flush_icache_mm(mm, local);
> +#endif
>  
>  	return 0;
>  }
> -#endif
> -- 
> 2.16.4
> 
