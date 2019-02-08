Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7115C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95FF520855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 16:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PegaWPt3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBHQAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 11:00:14 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:34342 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHQAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 11:00:12 -0500
Received: by mail-ed1-f67.google.com with SMTP id b3so3219669ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 08:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OSulq3lvXqbyFxTDC1tKNbLEzrnsSrdFhhsO0c+emWk=;
        b=PegaWPt354clt0Nf2kBLiRyOeBlcq+KTIwHGkpto8vdEOFAHq3pPgvQjdCpS8yMSer
         NwbChSq0wto5jUClfp34wusOL4r4SGOIsDi2vLzRyD4zSg1MLB7hShhzpB0xs7WqR1/w
         SaF5zzDISG2OZHeNI2gpR+eOodfNosAEs3AGCR81hwxgxQieeYbfegzvPCQCSDeLAbCq
         sBTKElVDT7UllZyS/x2jzu60mAPG2uB/F8zuEgdjHYwptiv3gvKMj0IDMMR9BaUSYljV
         d4LT+9LA+s6ToqyFKDdUyfiL/80teYStlDGCEFVyzU6a4V1oQc990Y71ugct94IHMKkP
         6/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OSulq3lvXqbyFxTDC1tKNbLEzrnsSrdFhhsO0c+emWk=;
        b=Q5iUkwfTFoSx1QA70UPY4S2fJIum9tD4NpMDJTX0L1Ufdg5m6iflG6iv+K49tOQ82i
         2fw4dcyJLzI4Pm1L7r9AgGAO2+nDyQI6ZQrybQk+AM3yTF7oMeyABJB4DoIg84SJ0jFx
         LEmZP6VrknsqBpzYA7exEeItaRzPpuusvo2jBrRBSvgVFc1Jk5uV0mB75DPRGqmwQJtj
         QmcvCV/9kNwX4yXiyJmTAY0U9vuf6b1yjbjMcSy4b/tpSY4zcJ98jXVoXOWZMluCSCwU
         hYprv9CkPqbYhSeYNvDkKYsMICkDnErOME3YDJw+G7J0HLGObM1BIbidew8bPfqS+1+K
         1Rhg==
X-Gm-Message-State: AHQUAuZOHqrBHgAw1EAx9yAdkKSCaynbqNHoo8CBK1TMkWWRLBlrIPoJ
        0Xu/PsCcxTMgwID7HksJF4E=
X-Google-Smtp-Source: AHgI3IbkGyP7JBxpm3YWvtKeNBT4rPelXWKTqOEdwPlIDJ9mKAqYRNkp+l66Pr+P4qex9ZaOGKYWtQ==
X-Received: by 2002:aa7:c352:: with SMTP id j18mr17153720edr.295.1549641610084;
        Fri, 08 Feb 2019 08:00:10 -0800 (PST)
Received: from archlinux-ryzen ([2a01:4f9:2a:1fae::2])
        by smtp.gmail.com with ESMTPSA id s46sm717960edd.9.2019.02.08.08.00.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 08 Feb 2019 08:00:09 -0800 (PST)
Date:   Fri, 8 Feb 2019 09:00:07 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Julien Thierry <julien.thierry@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, joel@joelfernandes.org,
        marc.zyngier@arm.com, christoffer.dall@arm.com,
        james.morse@arm.com, catalin.marinas@arm.com, will.deacon@arm.com,
        mark.rutland@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v10 12/25] arm64: irqflags: Use ICC_PMR_EL1 for interrupt
 masking
Message-ID: <20190208160007.GA26005@archlinux-ryzen>
References: <1548946743-38979-1-git-send-email-julien.thierry@arm.com>
 <1548946743-38979-13-git-send-email-julien.thierry@arm.com>
 <20190208043543.GA5040@archlinux-ryzen>
 <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5c2aacd-f607-c73e-d636-9cfc73c1fde0@arm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2019 at 09:36:48AM +0000, Julien Thierry wrote:
> Hi Nathan,
> 
> On 08/02/2019 04:35, Nathan Chancellor wrote:
> > On Thu, Jan 31, 2019 at 02:58:50PM +0000, Julien Thierry wrote:
> 
> [...]
> 
> > 
> > Hi Julien,
> > 
> > This patch introduced a slew of Clang warnings:
> > 
> > In file included from arch/arm64/kernel/signal.c:21:
> > In file included from include/linux/compat.h:10:
> > In file included from include/linux/time.h:6:
> > In file included from include/linux/seqlock.h:36:
> > In file included from include/linux/spinlock.h:54:
> > In file included from include/linux/irqflags.h:16:
> > arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >                 : "r" (GIC_PRIO_IRQON)
> >                        ^
> > arch/arm64/include/asm/ptrace.h:39:25: note: expanded from macro 'GIC_PRIO_IRQON'
> > #define GIC_PRIO_IRQON          0xf0
> >                                 ^
> > arch/arm64/include/asm/irqflags.h:46:44: note: use constraint modifier "w"
> >                 "msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
> >                                                          ^~
> >                                                          %w0
> 
> I'm not sure I get the relevance of this kind of warnings from Clang.
> Had it been an output operand I could understand the concern of having a
> variable too small to store the register value. But here it's an input
> operand being place in a wider register...
> 
> > arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
> >         _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
> >                                    ^
> > arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
> >         __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
> >                                     ^
> > arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
> >         newinstr "\n"                                                   \
> >         ^
> > In file included from arch/arm64/kernel/signal.c:21:
> > In file included from include/linux/compat.h:10:
> > In file included from include/linux/time.h:6:
> > In file included from include/linux/seqlock.h:36:
> > In file included from include/linux/spinlock.h:54:
> > In file included from include/linux/irqflags.h:16:
> > arch/arm64/include/asm/irqflags.h:61:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >                 : "r" (GIC_PRIO_IRQOFF)
> >                        ^
> > arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
> > #define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
> >                                 ^
> > arch/arm64/include/asm/irqflags.h:58:45: note: use constraint modifier "w"
> >                 "msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
> >                                                           ^
> > arch/arm64/include/asm/irqflags.h:94:10: warning: value size does not match register size specified by the constraint and modifier [-Wasm-operand-widths]
> >                 : "r" (GIC_PRIO_IRQOFF)
> >                        ^
> > arch/arm64/include/asm/ptrace.h:40:26: note: expanded from macro 'GIC_PRIO_IRQOFF'
> > #define GIC_PRIO_IRQOFF         (GIC_PRIO_IRQON & ~0x80)
> >                                 ^
> > arch/arm64/include/asm/irqflags.h:91:18: note: use constraint modifier "w"
> >                         "csel   %0, %0, %2, eq",
> >                                         ^~
> >                                         %w2
> > arch/arm64/include/asm/alternative.h:286:29: note: expanded from macro 'ALTERNATIVE'
> >         _ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
> >                                    ^
> > arch/arm64/include/asm/alternative.h:88:30: note: expanded from macro '_ALTERNATIVE_CFG'
> >         __ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg), 0)
> >                                     ^
> > arch/arm64/include/asm/alternative.h:76:2: note: expanded from macro '__ALTERNATIVE_CFG'
> >         newinstr "\n"                                                   \
> >         ^
> > 3 warnings generated.
> > 
> > 
> > I am not sure if they should be fixed with Clang's suggestion of a
> > constraint modifier or a cast like commit 1b57ec8c7527 ("arm64: io:
> > Ensure value passed to __iormb() is held in a 64-bit register"), hence
> > this message.
> > 
> 
> Clang's suggestion would not work as MSR instructions do not operate on
> 32-bit general purpose registers. Seeing that PMR is a 32-bit register,
> I'd avoid adding UL for the GIC_PRIO_IRQ* constants.
> 
> So I'd recommend just casting the the asm inline operands to unsigned
> long. This should only affect the 3 locations
> arch/arm64/include/asm/irqflags.h.
> 
> Does the following patch work for you?

Hi Julien,

Yes it does, thank you for the quick response and fix!

Nathan

> 
> Thanks,
> 
> -- 
> Julien Thierry
> 
> 
> -->
> 
> From e839dec632bbf440efe8314751138ba46324078c Mon Sep 17 00:00:00 2001
> From: Julien Thierry <julien.thierry@arm.com>
> Date: Fri, 8 Feb 2019 09:21:58 +0000
> Subject: [PATCH] arm64: irqflags: Fix clang build warnings
> 
> Clang complains when passing asm operands that are smaller than the
> registers they are mapped to:
> 
> arch/arm64/include/asm/irqflags.h:50:10: warning: value size does not
> 	match register size specified by the constraint and modifier
> 	[-Wasm-operand-widths]
>                 : "r" (GIC_PRIO_IRQON)
> 
> Fix it by casting the affected input operands to a type of the correct
> size.
> 
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Julien Thierry <julien.thierry@arm.com>

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
>  arch/arm64/include/asm/irqflags.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
> index d4597b2..43d8366 100644
> --- a/arch/arm64/include/asm/irqflags.h
> +++ b/arch/arm64/include/asm/irqflags.h
> @@ -47,7 +47,7 @@ static inline void arch_local_irq_enable(void)
>  		"dsb	sy",
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> -		: "r" (GIC_PRIO_IRQON)
> +		: "r" ((unsigned long) GIC_PRIO_IRQON)
>  		: "memory");
>  }
>  
> @@ -58,7 +58,7 @@ static inline void arch_local_irq_disable(void)
>  		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ", %0",
>  		ARM64_HAS_IRQ_PRIO_MASKING)
>  		:
> -		: "r" (GIC_PRIO_IRQOFF)
> +		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
>  		: "memory");
>  }
>  
> @@ -91,7 +91,7 @@ static inline unsigned long arch_local_save_flags(void)
>  			"csel	%0, %0, %2, eq",
>  			ARM64_HAS_IRQ_PRIO_MASKING)
>  		: "=&r" (flags), "+r" (daif_bits)
> -		: "r" (GIC_PRIO_IRQOFF)
> +		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
>  		: "memory");
>  
>  	return flags;
> -- 
> 1.9.1
> 
> 
