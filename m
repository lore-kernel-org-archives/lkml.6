Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id EE/8AGl7GVtMQwAAmS7hNA
	; Thu, 07 Jun 2018 18:39:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6FA9C6089E; Thu,  7 Jun 2018 18:39:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7UAeK2K"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E27DB601C3;
	Thu,  7 Jun 2018 18:39:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E27DB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935007AbeFGSj3 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:39:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:35532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933981AbeFGSj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:39:27 -0400
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69C60208AE
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jun 2018 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528396766;
        bh=6LEe5GSpD2TEtbiZj63Ls647kqPk+eeU1iAj9CzQjbY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b7UAeK2K9xzAJFf4bhIXufPou9uTWnE2h4VgA45mCGWrRscseNKP7AteoOwPek9UF
         7Gi0NpV6RRkTm9Qtj6R+qoGNo7iCoerA2e0MYN0DtotT4gWK+sw8LofkocZQr/y2k2
         K5iEyId7q1seMJSmsJ7TQ/ZguxtoS8Qv0wAkGAC0=
Received: by mail-wm0-f49.google.com with SMTP id v131-v6so21135752wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:39:26 -0700 (PDT)
X-Gm-Message-State: APt69E2VOVb3gQzERULeePgS2qg/wdRcumnggczz87V7KEjuvlBkG54j
        F/51o6qkunsvtgTlZZynlEEX3VRuxZDit+rY9T20jQ==
X-Google-Smtp-Source: ADUXVKLUNcEsPilIv05EfKfRozFCb1vzAVIFojdaYIYFkzyID+eH/btrxAUEs3RqFVGFRHG5f/oN69xtA8nsDLSnuo4=
X-Received: by 2002:a1c:4a9d:: with SMTP id n29-v6mr2231916wmi.46.1528396764938;
 Thu, 07 Jun 2018 11:39:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180607143855.3681-1-yu-cheng.yu@intel.com> <20180607143855.3681-4-yu-cheng.yu@intel.com>
In-Reply-To: <20180607143855.3681-4-yu-cheng.yu@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 7 Jun 2018 11:39:12 -0700
X-Gmail-Original-Message-ID: <CALCETrWNaA4rg3Q6-OShAt7Yp9VmyvyFOQtn6cAbrKMHiggGzg@mail.gmail.com>
Message-ID: <CALCETrWNaA4rg3Q6-OShAt7Yp9VmyvyFOQtn6cAbrKMHiggGzg@mail.gmail.com>
Subject: Re: [PATCH 3/7] mm/mmap: Add IBT bitmap size to address space limit check
To: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. J. Lu" <hjl.tools@gmail.com>,
        "Shanbhogue, Vedvyas" <vedvyas.shanbhogue@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        mike.kravetz@oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 7:42 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> The indirect branch tracking legacy bitmap takes a large address
> space.  This causes may_expand_vm() failure on the address limit
> check.  For a IBT-enabled task, add the bitmap size to the
> address limit.
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> ---
>  arch/x86/include/uapi/asm/resource.h | 5 +++++
>  include/uapi/asm-generic/resource.h  | 3 +++
>  mm/mmap.c                            | 8 +++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/uapi/asm/resource.h b/arch/x86/include/uapi/asm/resource.h
> index 04bc4db8921b..0741b2a6101a 100644
> --- a/arch/x86/include/uapi/asm/resource.h
> +++ b/arch/x86/include/uapi/asm/resource.h
> @@ -1 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +#ifdef CONFIG_X86_INTEL_CET
> +#define rlimit_as_extra() current->thread.cet.ibt_bitmap_size
> +#endif
> +
>  #include <asm-generic/resource.h>
> diff --git a/include/uapi/asm-generic/resource.h b/include/uapi/asm-generic/resource.h
> index f12db7a0da64..8a7608a09700 100644
> --- a/include/uapi/asm-generic/resource.h
> +++ b/include/uapi/asm-generic/resource.h
> @@ -58,5 +58,8 @@
>  # define RLIM_INFINITY         (~0UL)
>  #endif
>
> +#ifndef rlimit_as_extra
> +#define rlimit_as_extra() 0
> +#endif
>
>  #endif /* _UAPI_ASM_GENERIC_RESOURCE_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index e7d1fcb7ec58..5c07f052bed7 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3255,7 +3255,13 @@ struct vm_area_struct *copy_vma(struct vm_area_struct **vmap,
>   */
>  bool may_expand_vm(struct mm_struct *mm, vm_flags_t flags, unsigned long npages)
>  {
> -       if (mm->total_vm + npages > rlimit(RLIMIT_AS) >> PAGE_SHIFT)
> +       unsigned long as_limit = rlimit(RLIMIT_AS);
> +       unsigned long as_limit_plus = as_limit + rlimit_as_extra();
> +
> +       if (as_limit_plus > as_limit)
> +               as_limit = as_limit_plus;
> +

What happens if as_limit_plus overflows?  I guess it's probably okay here.
