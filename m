Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E421C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505D5217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549264699;
	bh=xlNR0YyU7rkbqjTCTYrXLWpTVXHMN8IJdIMBpeSaceg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VxdEyjHHLnCrzP2DRD6xuD/El0KnIhYEURCGyiIlComSfCoNTLrlm4OQ2rAyZlbRo
	 LCxwaC9MfmaMe9hJ1OKkUp3L+uSUZWoZWVAnHpdhux/v0WFCxHB5y5nre+Wrgr50C4
	 zH/EC/qtSx3R7Ko7MaroOuo39mIKa36MPgNMh7Jk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfBDHSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:18:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:32845 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727259AbfBDHSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:18:15 -0500
Received: by mail-wm1-f65.google.com with SMTP id r24so9325470wmh.0;
        Sun, 03 Feb 2019 23:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=S6BWPp9h4ePyZCcnf133Oiu8h4NCdTMJ+eb5jVLwjzY=;
        b=nfm1URi3pdoBABg631g26u9eQy0PfNRlI+pt+QDcyQcEzRDWtZMx60/mkygbJJ6S8F
         8x3iOV9bjT5TlwUgzjeMNpgFCqAY2rZXm+bUu/3TO9JgUR3fDwgv5y3Xdfc1SX9D8onM
         xSiSNgW8ZFFfuUrZvTtKahmFinVK3g/KeIrBBTnOWro2OAQ1RL6BKy2Z8yyUr/du4jwI
         MeBonXR9kq+l7nR/PcK+vwfE2ejNW+L7Akj3ib7x2buXJdnBom29FxLKkaYcrlIeTF+D
         Fx5IF+aseIvCu5ZBe03gcheld5jypUB4DiXSV9HRWJcM9oYzh9zLAHYIGJxbXfYKTwhn
         2fcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=S6BWPp9h4ePyZCcnf133Oiu8h4NCdTMJ+eb5jVLwjzY=;
        b=ZmnYwWYNOyJBCFj0yJyEltm1r3vpGqdT/XnPWk1GCKUJ/H8RWKmkCVwMEGcGkeo9Zc
         34P9aBxRNyo34gHfROIUGA0R8LEeeKucWBy2sv4NS9TjGeWNgv5mSOYMHYbwG7N19jV3
         7rnUfgQ1ibSV5EQ7ZQSS2pN6hU6bzVN9AvWQYCF7BQYbh8y/NLQpqeSYgWsPtLEHqwRd
         0+gLwtCIWXRPTt3cWF5DcUi9TzA8Dnw1hVv8e1gmdlkH+z+eshvNASAU/qADcKA96biF
         b3zGBn7o2z6dTa45R7m9ZEzCJB8oYDAjRDESQKke71fbRrOS7JxaRZX6uHlx+NBMafFq
         ADBA==
X-Gm-Message-State: AHQUAuatwCMRROKRNUiZHxaEd4PIXleL9fdZGaYBWYvSnPEybVAKfhqn
        lmNN8bm0r0I4t71psEomexo=
X-Google-Smtp-Source: AHgI3Ibk80m2VR0k4hYa+nH+YeMuoNlVhAfEQxu8VhyzwxwpdATncCa3OW0Gd3P3zJR3eqGk1Sx6eQ==
X-Received: by 2002:a1c:1f83:: with SMTP id f125mr11665190wmf.56.1549264692657;
        Sun, 03 Feb 2019 23:18:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id q21sm2085262wmc.14.2019.02.03.23.18.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Feb 2019 23:18:11 -0800 (PST)
Date:   Mon, 4 Feb 2019 08:18:09 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: Re: [PATCH 02/10] x86/efi: Return error status if mapping EFI
 regions fail
Message-ID: <20190204071809.GA115714@gmail.com>
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
 <20190202094119.13230-3-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190202094119.13230-3-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> 
> efi_map_region() creates VA mappings for an given EFI region using any one
> of the two helper functions (namely __map_region() and old_map_region()).
> These helper functions *could* fail while creating mappings and presently
> their return value is not checked. Not checking for the return value of
> these functions might create issues because after these functions return
> "md->virt_addr" is set to the requested virtual address (so it's assumed
> that these functions always succeed which is not quite true). This
> assumption leads to "md->virt_addr" having invalid mapping should any of
> __map_region() or old_map_region() fail.
> 
> Hence, check for the return value of these functions and if indeed they
> fail, turn off EFI Runtime Services forever because kernel cannot
> prioritize among EFI regions.
> 
> This also fixes the comment "FIXME: add error handling" in
> kexec_enter_virtual_mode().
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/include/asm/efi.h     |  6 +++---
>  arch/x86/platform/efi/efi.c    | 21 +++++++++++++-----
>  arch/x86/platform/efi/efi_32.c |  6 +++---
>  arch/x86/platform/efi/efi_64.c | 39 ++++++++++++++++++++++------------
>  4 files changed, 48 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index 107283b1eb1e..a37378f986ec 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -125,12 +125,12 @@ extern pgd_t * __init efi_call_phys_prolog(void);
>  extern void __init efi_call_phys_epilog(pgd_t *save_pgd);
>  extern void __init efi_print_memmap(void);
>  extern void __init efi_memory_uc(u64 addr, unsigned long size);
> -extern void __init efi_map_region(efi_memory_desc_t *md);
> -extern void __init efi_map_region_fixed(efi_memory_desc_t *md);
> +extern int __init efi_map_region(efi_memory_desc_t *md);
> +extern int __init efi_map_region_fixed(efi_memory_desc_t *md);
>  extern void efi_sync_low_kernel_mappings(void);
>  extern int __init efi_alloc_page_tables(void);
>  extern int __init efi_setup_page_tables(unsigned long pa_memmap, unsigned num_pages);
> -extern void __init old_map_region(efi_memory_desc_t *md);
> +extern int __init old_map_region(efi_memory_desc_t *md);
>  extern void __init runtime_code_page_mkexec(void);
>  extern void __init efi_runtime_update_mappings(void);
>  extern void __init efi_dump_pagetable(void);
> diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
> index e1cb01a22fa8..3d43ec58775b 100644
> --- a/arch/x86/platform/efi/efi.c
> +++ b/arch/x86/platform/efi/efi.c
> @@ -581,7 +581,7 @@ void __init efi_memory_uc(u64 addr, unsigned long size)
>  	set_memory_uc(addr, npages);
>  }
>  
> -void __init old_map_region(efi_memory_desc_t *md)
> +int __init old_map_region(efi_memory_desc_t *md)
>  {
>  	u64 start_pfn, end_pfn, end;
>  	unsigned long size;
> @@ -601,10 +601,14 @@ void __init old_map_region(efi_memory_desc_t *md)
>  		va = efi_ioremap(md->phys_addr, size,
>  				 md->type, md->attribute);
>  
> -	md->virt_addr = (u64) (unsigned long) va;
> -	if (!va)
> +	if (!va) {
>  		pr_err("ioremap of 0x%llX failed!\n",
>  		       (unsigned long long)md->phys_addr);
> +		return -ENOMEM;
> +	}
> +
> +	md->virt_addr = (u64)(unsigned long)va;
> +	return 0;

Just wondering, shouldn't the failure path set ->virt_addr to something 
safe, just in case a caller doesn't check the error and relies on it? 

That's because in this commit we've now changed it from 0 to undefined.

> +int __init efi_map_region_fixed(efi_memory_desc_t *md) { return 0; }

Inline functions should be marked inline ...

>  	if (efi_va < EFI_VA_END) {
> -		pr_warn(FW_WARN "VA address range overflow!\n");
> -		return;
> +		pr_err(FW_WARN "VA address range overflow!\n");
> +		return -ENOMEM;
>  	}
>  
>  	/* Do the VA map */
> -	__map_region(md, efi_va);
> +	if (__map_region(md, efi_va))
> +		return -ENOMEM;
> +
>  	md->virt_addr = efi_va;
> +	return 0;

Same error return problem of leaving ->virt_addr undefined.

Note that I also fixed up the grammar and readability of the changelog - 
see the updated version below.

Thanks,

	Ingo

=============>
Subject: x86/efi: Return error status if mapping of EFI regions fails
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Sat, 2 Feb 2019 10:41:11 +0100

From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>

efi_map_region() creates VA mappings for a given EFI region using one
of the two helper functions (namely __map_region() and old_map_region()).

These helper functions could fail while creating mappings and presently
their return value is not checked.

Not checking for the return value of these functions might create bugs,
because after these functions return "md->virt_addr" is set to the
requested virtual address (so it's assumed that these functions always
succeed which is not quite true). This assumption leads to
"md->virt_addr" having invalid mapping, should any of __map_region()
or old_map_region() fail.

Hence, check for the return value of these functions and if indeed they
fail, turn off EFI Runtime Services forever because kernel cannot
prioritize among EFI regions.

This also fixes the comment "FIXME: add error handling" in
kexec_enter_virtual_mode().

