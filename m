Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216B6C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A25932064E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 04:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4D0nSZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25932064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbeJCLKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 07:10:46 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37315 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbeJCLKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 07:10:46 -0400
Received: by mail-pg1-f195.google.com with SMTP id c10-v6so948035pgq.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 21:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NZes71k05JZveThK4dwg4hJgdX3SYR4bz4d1tEH+vYI=;
        b=D4D0nSZWkPow1G7jNggVNveCypL4nQ8wYcTRqM8IeyDd8P1ktUN8E09OTO3rANmY+M
         QpNlRFdkBD6u+UIEtMp6OymS7z12hms+feWxdp2dYRj5cBhbkCl5MDFWiGEKmGgbojUk
         V9KnVO09+q208TvkUEn4UVMO1YIbnQY81L47VJCpdT4mDJbOQiXiVccRPUjax/j6b3RB
         op46mmCiW9HQQnjs+PaVJSvAErtyUg0Ws6Z3+SePudMOmNcdtux5LLoZYiDXg9dBQQGR
         zNuqOyBcp0I6rOmnkUsp/3HhsP7CuuCgxdaKJnBGXyrz11Z+2S1dNsavUqa58FuIXiUM
         q68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NZes71k05JZveThK4dwg4hJgdX3SYR4bz4d1tEH+vYI=;
        b=ssMl4r206HdZ41M5x6pbtJVZ9MtoPYgxaiAdGWyg/+DUfRQ/JOPIcOlBm7R8bc9i5v
         aAizbw0OXG0CPNJfqJ1IiWMFhZn+tGu+cJ3WDmS3uL/4Z+hO/P3uwP+vrirz9QAZbbDF
         WlY7jlIpUec1VE/IJmTW9WH9MW6PkU2PKXb1UvdDUH1c8zM0RyfVX88Gp0X+6J6LQvou
         hxlEAp6MmY7GQRUxtr//qzgUBCCBKNwcjHp+SPPF2S+FRHo3zSyrJo+M69rcYkXS4PRm
         Jh2i4Mc8KXcnAadwDnap8Iis7EjDteODHP3rmD6mNV+kqTjyfa92G9D+D64/DgV1zVNo
         y9aQ==
X-Gm-Message-State: ABuFfoicpJe4FRPE2BNOI3SIR2drk377Ob+4n2TpJ7WUtfQHunOHOrO8
        rmJARDQXeUT2SRHB+zLItXA=
X-Google-Smtp-Source: ACcGV61GN/ekaUMScFGFk0rYIX9ZacBiPKECbW5TqiwHtvv67yG4j6/vyPZKLMjwWfUAlSsGLDEllQ==
X-Received: by 2002:a62:c28a:: with SMTP id w10-v6mr3961412pfk.158.1538540647003;
        Tue, 02 Oct 2018 21:24:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id h130-v6sm168291pgc.88.2018.10.02.21.24.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 21:24:06 -0700 (PDT)
Date:   Wed, 3 Oct 2018 14:24:00 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 1/7] book3s/64: avoid circular header inclusion
 in mmu-hash.h
Message-ID: <20181003142400.490fd38a@roar.ozlabs.ibm.com>
In-Reply-To: <c95148024873842459472bbcc0dd0e65607fd43b.1538396658.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <c95148024873842459472bbcc0dd0e65607fd43b.1538396658.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 12:30:19 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h
> includes asm/current.h. This generates a circular dependency.
> To avoid that, asm/processor.h shall not be included in mmu-hash.h
> 
> In order to do that, this patch moves into a new header called
> asm/task_size.h the information from asm/processor.h requires by
> mmu-hash.h

Doesn't look like you use this header in 32-bit code. Put task_size.h
in asm/64/ maybe?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>  arch/powerpc/include/asm/processor.h          | 34 +---------------------
>  arch/powerpc/include/asm/task_size.h          | 42 +++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_hv_hmi.c              |  1 +
>  4 files changed, 45 insertions(+), 34 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/task_size.h
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index bbeaf6adf93c..7788e35f19f0 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -23,7 +23,7 @@
>   */
>  #include <asm/book3s/64/pgtable.h>
>  #include <asm/bug.h>
> -#include <asm/processor.h>
> +#include <asm/task_size.h>
>  #include <asm/cpu_has_feature.h>
>  
>  /*
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 350c584ca179..353879db3e98 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -101,40 +101,8 @@ void release_thread(struct task_struct *);
>  #endif
>  
>  #ifdef CONFIG_PPC64
> -/*
> - * 64-bit user address space can have multiple limits
> - * For now supported values are:
> - */
> -#define TASK_SIZE_64TB  (0x0000400000000000UL)
> -#define TASK_SIZE_128TB (0x0000800000000000UL)
> -#define TASK_SIZE_512TB (0x0002000000000000UL)
> -#define TASK_SIZE_1PB   (0x0004000000000000UL)
> -#define TASK_SIZE_2PB   (0x0008000000000000UL)
> -/*
> - * With 52 bits in the address we can support
> - * upto 4PB of range.
> - */
> -#define TASK_SIZE_4PB   (0x0010000000000000UL)
>  
> -/*
> - * For now 512TB is only supported with book3s and 64K linux page size.
> - */
> -#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
> -/*
> - * Max value currently used:
> - */
> -#define TASK_SIZE_USER64		TASK_SIZE_4PB
> -#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
> -#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
> -#else
> -#define TASK_SIZE_USER64		TASK_SIZE_64TB
> -#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
> -/*
> - * We don't need to allocate extended context ids for 4K page size, because
> - * we limit the max effective address on this config to 64TB.
> - */
> -#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
> -#endif
> +#include <asm/task_size.h>
>  
>  /*
>   * 32-bit user address space is 4GB - 1 page
> diff --git a/arch/powerpc/include/asm/task_size.h b/arch/powerpc/include/asm/task_size.h
> new file mode 100644
> index 000000000000..ca45638617b0
> --- /dev/null
> +++ b/arch/powerpc/include/asm/task_size.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_TASK_SIZE_H
> +#define _ASM_POWERPC_TASK_SIZE_H
> +
> +#ifdef CONFIG_PPC64
> +/*
> + * 64-bit user address space can have multiple limits
> + * For now supported values are:
> + */
> +#define TASK_SIZE_64TB  (0x0000400000000000UL)
> +#define TASK_SIZE_128TB (0x0000800000000000UL)
> +#define TASK_SIZE_512TB (0x0002000000000000UL)
> +#define TASK_SIZE_1PB   (0x0004000000000000UL)
> +#define TASK_SIZE_2PB   (0x0008000000000000UL)
> +/*
> + * With 52 bits in the address we can support
> + * upto 4PB of range.
> + */
> +#define TASK_SIZE_4PB   (0x0010000000000000UL)
> +
> +/*
> + * For now 512TB is only supported with book3s and 64K linux page size.
> + */
> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
> +/*
> + * Max value currently used:
> + */
> +#define TASK_SIZE_USER64		TASK_SIZE_4PB
> +#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
> +#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
> +#else
> +#define TASK_SIZE_USER64		TASK_SIZE_64TB
> +#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
> +/*
> + * We don't need to allocate extended context ids for 4K page size, because
> + * we limit the max effective address on this config to 64TB.
> + */
> +#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
> +#endif
> +
> +#endif /* CONFIG_PPC64 */
> +#endif /* _ASM_POWERPC_TASK_SIZE_H */
> diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
> index e3f738eb1cac..64b5011475c7 100644
> --- a/arch/powerpc/kvm/book3s_hv_hmi.c
> +++ b/arch/powerpc/kvm/book3s_hv_hmi.c
> @@ -24,6 +24,7 @@
>  #include <linux/compiler.h>
>  #include <asm/paca.h>
>  #include <asm/hmi.h>
> +#include <asm/processor.h>
>  
>  void wait_for_subcore_guest_exit(void)
>  {
> -- 
> 2.13.3
> 

