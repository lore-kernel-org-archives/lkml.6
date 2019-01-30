Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A57FAC169C4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D3621473
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 01:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfA3BXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 20:23:13 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47461 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727558AbfA3BXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 20:23:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,538,1539619200"; 
   d="scan'208";a="53164187"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Jan 2019 09:23:10 +0800
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id C39664C4A8BE;
        Wed, 30 Jan 2019 09:23:06 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXCHPEKD02.g08.fujitsu.local (10.167.33.89) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 30 Jan 2019 09:23:15 +0800
Subject: Re: [PATCH] x86/boot: comments cleanup & indentation fix
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>
References: <20190104120428.26847-1-caoj.fnst@cn.fujitsu.com>
Message-ID: <61837197-1069-f89f-b63a-b0f115df8dad@cn.fujitsu.com>
Date:   Wed, 30 Jan 2019 09:20:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190104120428.26847-1-caoj.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-yoursite-MailScanner-ID: C39664C4A8BE.A8EC4
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  Is the patch not right?

-- 
Sincerely,
Cao jin

On 1/4/19 8:04 PM, Cao jin wrote:
> No real code modification, just cleanup:
> 1. remove redundant comments which have already appeared above
> 2. comments improvement:
>       "aligned to a 2M boundary"
>       -->
>       "aligned up to CONFIG_PHYSICAL_ALIGN boundary"
> 3. typo fix: uncompression --> decompression
> 4. indentation fix in linker script: spaces -> tab
> 
> Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
> ---
>  arch/x86/boot/compressed/head_64.S     | 13 +++++--------
>  arch/x86/boot/compressed/vmlinux.lds.S |  4 ++--
>  2 files changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 64037895b085..58f6a467f1fa 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -90,9 +90,6 @@ ENTRY(startup_32)
>  	jnz	no_longmode
>  
>  /*
> - * Compute the delta between where we were compiled to run at
> - * and where the code will actually run at.
> - *
>   * %ebp contains the address we are loaded at by the boot loader and %ebx
>   * contains the address where we should move the kernel image temporarily
>   * for safe in-place decompression.
> @@ -272,12 +269,12 @@ ENTRY(startup_64)
>  
>  	/*
>  	 * Compute the decompressed kernel start address.  It is where
> -	 * we were loaded at aligned to a 2M boundary. %rbp contains the
> -	 * decompressed kernel start address.
> +	 * we were loaded at aligned up to CONFIG_PHYSICAL_ALIGN boundary.
> +	 * %rbp contains the decompressed kernel start address.
>  	 *
>  	 * If it is a relocatable kernel then decompress and run the kernel
> -	 * from load address aligned to 2MB addr, otherwise decompress and
> -	 * run the kernel from LOAD_PHYSICAL_ADDR
> +	 * from load address aligned up to CONFIG_PHYSICAL_ALIGN, otherwise
> +	 * decompress and run the kernel from LOAD_PHYSICAL_ADDR
>  	 *
>  	 * We cannot rely on the calculation done in 32-bit mode, since we
>  	 * may have been invoked via the 64-bit entry point.
> @@ -525,7 +522,7 @@ relocated:
>   */
>  	pushq	%rsi			/* Save the real mode argument */
>  	movq	%rsi, %rdi		/* real mode address */
> -	leaq	boot_heap(%rip), %rsi	/* malloc area for uncompression */
> +	leaq	boot_heap(%rip), %rsi	/* malloc area for decompression */
>  	leaq	input_data(%rip), %rdx  /* input_data */
>  	movl	$z_input_len, %ecx	/* input_len */
>  	movq	%rbp, %r8		/* output target address */
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index f491bbde8493..c07c8aba0755 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -64,8 +64,8 @@ SECTIONS
>  		_ebss = .;
>  	}
>  #ifdef CONFIG_X86_64
> -       . = ALIGN(PAGE_SIZE);
> -       .pgtable : {
> +	. = ALIGN(PAGE_SIZE);
> +	.pgtable : {
>  		_pgtable = . ;
>  		*(.pgtable)
>  		_epgtable = . ;
> 





