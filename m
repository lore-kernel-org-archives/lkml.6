Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-457733-1526285157-2-2097161314215289983
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526285157; b=BNai5Gz9l3B3PjdNks3v9Vx1ayy0MsYXXcLLnHt07v0aVmi0cv
    dnSwIGndmMwP77g9E84Xj2JkcBBkxnOid22LFU8K8hw6j/lCMNGcCwJb+HBLqvaK
    Pl7eVnWC+xo4GNBJlHRdppFAM5VIB3xVo+BaR4KdD0bcwNFfQMZHnLDJv2NmnT9k
    jJVOq7aEg4hGE4Fc7mUJVONM08Ui74QW+4I0Pu8WFlw8uq5vSaEq7toafH818BYI
    2Ptlf3UPYkvQrxHOpBOvRx+eKaC4PG830J4N2ghvy5XEGlCKm1WM5zYbByKVJwKT
    pttpIsYmAvi6tAahO+johEBrAE8tqR7E8qNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526285157; bh=z6OvBGkCTWxTKclqxpS1CnQJRsrCqg
    +9TF/nwNugKLY=; b=Pmu9pxxoZdWN5OqcZ9islKkAs+UqTa2EmT4UJ7vvRUJIr0
    ueyjSwS6gpgcCZ+4bDyWZ+PsQM9T0JnX7nh9o+mCAfnyKVw7G6Q2JW6BZVcEGq9q
    dIxTbM+bPVpuz044CmdCFuAccVXZ0HB/1y99ZumKYUgufPNLhliRf+xpiGZpvPnB
    ypqSg6OQKPevJhNTsNDydB5iXVamB4E427JYSGlWDTcMdFwAYkkyn1jGGLw5U7kt
    rFfQhf2V4UL1L80EVBAxQTcUbk0wQtzXHVbOBRXpZI6LODg3s9kN9cuGEkdZmCus
    3o54mDoXhAw/U+TdbsieItLlA2mhBzEdjQK5ZmQQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=npJm+Vrt x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=lzcOyCce;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=npJm+Vrt x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=lzcOyCce;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC6do+3wRD28TcQMqhNaH6sadGZAbb1Ff7zOg7aGkiuGT14xcDa6pCG8CKu6IRD8EdFp91eEcmrTtK5d2x6q1wxfYL/pYKkM8IoW4Yduy9ERSqilnysL
    2O6aVW5LikvIlSe1OvqHjoP6Mi9W9iyA+YeBt/p3ic2fb3LIKRJo0EVaQuX8fNgXOMlk1KKikIrcZOB+h2NTQMxsMEZ0pBzLJMbseTmpin3Xcf9XHZ809hzX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7g0x8hk2SQhkWdhNyNoA:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbeENIF4 (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 04:05:56 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:37824 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752029AbeENIFy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 May 2018 04:05:54 -0400
X-Google-Smtp-Source: AB8JxZrhRk8YLsHX7rRwgFSkXPjNvmHhXMHeVpaISslGve7V10SbNBGiMpbr6/rg9/0QpxPeD9gHKQ==
Date: Mon, 14 May 2018 10:05:49 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jslaby@suse.cz>
Cc: mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH -resend 02/27] x86: assembly, use SYM_DATA for data
Message-ID: <20180514080549.GB6607@gmail.com>
References: <20180510080644.19752-1-jslaby@suse.cz>
 <20180510080644.19752-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510080644.19752-3-jslaby@suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


* Jiri Slaby <jslaby@suse.cz> wrote:

> We make proper use of SYM_DATA on global data instead of marking them as
> ENTRY. ENTRY is intended for functions and shall be paired with ENDPROC.
> ENTRY also aligns symbols which creates unnecessary holes here between
> data.
> 
> ENTRY from saved_eip in wakeup_32 and many saved_* in wakeup_64 is
> simply dropped, as these symbols are local only.

Yeah, so this commit talks about ENTRY() and ENDPROC(), while the new methods are 
SYM_FUNC_START()/END().

>  arch/x86/kernel/acpi/wakeup_32.S |  4 ++--
>  arch/x86/kernel/acpi/wakeup_64.S | 14 +++++++-------
>  arch/x86/kernel/head_32.S        |  6 ++----
>  arch/x86/kernel/head_64.S        |  5 ++---
>  4 files changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/acpi/wakeup_32.S b/arch/x86/kernel/acpi/wakeup_32.S
> index 0c26b1b44e51..feac1e5ecba0 100644
> --- a/arch/x86/kernel/acpi/wakeup_32.S
> +++ b/arch/x86/kernel/acpi/wakeup_32.S
> @@ -89,8 +89,8 @@ ret_point:
>  
>  .data
>  ALIGN
> -ENTRY(saved_magic)	.long	0
> -ENTRY(saved_eip)	.long	0
> +SYM_DATA(saved_magic,	.long 0)
> +saved_eip:		.long 0
>  
>  # saved registers
>  saved_idt:	.long	0,0
> diff --git a/arch/x86/kernel/acpi/wakeup_64.S b/arch/x86/kernel/acpi/wakeup_64.S
> index 50b8ed0317a3..551758f48eb7 100644
> --- a/arch/x86/kernel/acpi/wakeup_64.S
> +++ b/arch/x86/kernel/acpi/wakeup_64.S
> @@ -125,12 +125,12 @@ ENTRY(do_suspend_lowlevel)
>  ENDPROC(do_suspend_lowlevel)
>  
>  .data
> -ENTRY(saved_rbp)	.quad	0
> -ENTRY(saved_rsi)	.quad	0
> -ENTRY(saved_rdi)	.quad	0
> -ENTRY(saved_rbx)	.quad	0
> +saved_rbp:		.quad	0
> +saved_rsi:		.quad	0
> +saved_rdi:		.quad	0
> +saved_rbx:		.quad	0
>  
> -ENTRY(saved_rip)	.quad	0
> -ENTRY(saved_rsp)	.quad	0
> +saved_rip:		.quad	0
> +saved_rsp:		.quad	0
>  
> -ENTRY(saved_magic)	.quad	0
> +SYM_DATA(saved_magic,	.quad	0)
> diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
> index b59e4fb40fd9..80965fd75fea 100644
> --- a/arch/x86/kernel/head_32.S
> +++ b/arch/x86/kernel/head_32.S
> @@ -507,10 +507,8 @@ GLOBAL(early_recursion_flag)
>  
>  __REFDATA
>  	.align 4
> -ENTRY(initial_code)
> -	.long i386_start_kernel
> -ENTRY(setup_once_ref)
> -	.long setup_once
> +SYM_DATA(initial_code,		.long i386_start_kernel)
> +SYM_DATA(setup_once_ref,	.long setup_once)
>  
>  /*
>   * BSS section
> diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> index 8344dd2f310a..17543533642d 100644
> --- a/arch/x86/kernel/head_64.S
> +++ b/arch/x86/kernel/head_64.S
> @@ -463,9 +463,8 @@ early_gdt_descr:
>  early_gdt_descr_base:
>  	.quad	INIT_PER_CPU_VAR(gdt_page)
>  
> -ENTRY(phys_base)
> -	/* This must match the first entry in level2_kernel_pgt */
> -	.quad   0x0000000000000000
> +/* This must match the first entry in level2_kernel_pgt */
> +SYM_DATA(phys_base, .quad 0x0000000000000000)
>  EXPORT_SYMBOL(phys_base)
>  
>  #include "../../x86/xen/xen-head.S"

I'd also suggest splitting this patch into two:

  - one for the renaming of the existing ENTRY() uses

  - and another one for the dropping of ENTRY() annotations

Could you please also do this for other patches if necessary, i.e. there should be 
'pure renaming' patches that are easy to review and verify, separate from patches 
that actually change the symbol table?

Thanks,

	Ingo
