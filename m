Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B35C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C4C20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxjyZBsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C4C20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeJCMRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:17:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33694 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:17:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id s4-v6so2865579plp.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 22:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lLhtMHu6oGGRZTdmmEOM6FX3/aei3zBp6TAJwrcpwRU=;
        b=IxjyZBsUR0kt8UEFy7R/IesQ0gpNNCTw2+SxG2nAdaZyHT22wOZ/b6j74A+9jxKOqJ
         yow8UQwNCpu7qz4sP8YpC6JJ87KqA+pxd5eC4iYcGnV2E1bcp9yGPxa0YCoVVtjnK512
         qUoJwIK5LaspGP+pZvBMsfPjCRbtJYpQSsgt+068nF42k5CCEZOOFFzwv2QL6JhKYQtA
         bbACUFsDxcVAaA5NQzNysdijseF/nVFbXTkg0vNSkv6Z6GxP8aGvY81PLN4lNTPrAG5U
         33fNSY/DckS54Bix0pGlJTAN6RWGAIio72MNN2lgsLiM8cn2BfTiCRYrRrm7KpB37Q7z
         mPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lLhtMHu6oGGRZTdmmEOM6FX3/aei3zBp6TAJwrcpwRU=;
        b=dUNsZz13O3ZJ19tFd9uRBsgjP+MbYctvTgSVlruO1HEJnAz6iXQTjT+tX6B1pjAkDH
         SGw6ntWDCgLTQhMN55YTJGYBEUcRpsjpfGy/xxemU7pUwkWnaSkLL/FOvAhrAK6edaAJ
         3+lGfSL2gO7mKS+QbOEUVPtao1mZb8ips8w8cf3c+S8dtQ5VPAKFLpWjejYG30g6nsVz
         hXBr8SLCgRFz2JsQar7dvhe2Ezn1jxDHevE/a5TAwBLZY01eN1ijUlHM+Rp1RW9eiMjX
         CLXz43PVt9zWOC7hS7aSkED3X1eRAavCKGSqCecGu7XpU4kY2FPmagSQ2VL5RXm4MBNa
         yMtA==
X-Gm-Message-State: ABuFfoh7jb0pzgn0N3rIzevJ/tnFEQvI6ciY/5jzc8tVC6lakT/ddgO3
        cQXvlLe8tJQoBpV4FcktqDU=
X-Google-Smtp-Source: ACcGV62ZXOGJN+GPkFj5PK10uhKUhsBItySZTlEZUGzYsajhSzND+Si7teALHsyYTu5oZRwodgyX6g==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr20063357pls.233.1538544631233;
        Tue, 02 Oct 2018 22:30:31 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
        by smtp.gmail.com with ESMTPSA id a64-v6sm520259pfe.32.2018.10.02.22.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:30:30 -0700 (PDT)
Date:   Wed, 3 Oct 2018 15:30:25 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        aneesh.kumar@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v3 3/7] powerpc: Activate CONFIG_THREAD_INFO_IN_TASK
Message-ID: <20181003153025.35b2dd5e@roar.ozlabs.ibm.com>
In-Reply-To: <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
        <522887e5967b6619be34eb4f04565033dbed2d75.1538396658.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Oct 2018 12:30:23 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> This patch activates CONFIG_THREAD_INFO_IN_TASK which
> moves the thread_info into task_struct.
> 
> Moving thread_info into task_struct has the following advantages:
> - It protects thread_info from corruption in the case of stack
> overflows.
> - Its address is harder to determine if stack addresses are
> leaked, making a number of attacks more difficult.
> 
> This has the following consequences:
> - thread_info is now located at the top of task_struct.

"top"... I got confused for a minute thinking high address and
wondering how you can change CURRENT_THREAD_INFO just to point
to current :)



> diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
> index 07d9dce7eda6..4e98989b5512 100644
> --- a/arch/powerpc/Makefile
> +++ b/arch/powerpc/Makefile
> @@ -422,3 +422,9 @@ checkbin:
>  
>  CLEAN_FILES += $(TOUT)
>  
> +ifdef CONFIG_SMP
> +prepare: task_cpu_prepare
> +
> +task_cpu_prepare: prepare0
> +       $(eval KBUILD_CFLAGS += -D_TASK_CPU=$(shell awk '{if ($$2 == "TI_CPU") print $$3;}' include/generated/asm-offsets.h))
> +endif
> diff --git a/arch/powerpc/include/asm/ptrace.h b/arch/powerpc/include/asm/ptrace.h
> index 447cbd1bee99..3a7e5561630b 100644
> --- a/arch/powerpc/include/asm/ptrace.h
> +++ b/arch/powerpc/include/asm/ptrace.h
> @@ -120,7 +120,7 @@ extern int ptrace_put_reg(struct task_struct *task, int regno,
>  			  unsigned long data);
>  
>  #define current_pt_regs() \
> -	((struct pt_regs *)((unsigned long)current_thread_info() + THREAD_SIZE) - 1)
> +	((struct pt_regs *)((unsigned long)task_stack_page(current) + THREAD_SIZE) - 1)
>  /*
>   * We use the least-significant bit of the trap field to indicate
>   * whether we have saved the full set of registers, or only a
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index 95b66a0c639b..df519b7322e5 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -83,7 +83,13 @@ int is_cpu_dead(unsigned int cpu);
>  /* 32-bit */
>  extern int smp_hw_index[];
>  
> -#define raw_smp_processor_id()	(current_thread_info()->cpu)
> +/*
> + * This is particularly ugly: it appears we can't actually get the definition
> + * of task_struct here, but we need access to the CPU this task is running on.
> + * Instead of using task_struct we're using _TASK_CPU which is extracted from
> + * asm-offsets.h by kbuild to get the current processor ID.
> + */
> +#define raw_smp_processor_id()		(*(unsigned int*)((void*)current + _TASK_CPU))

This is clever but yes ugly. Can't you include asm-offsets.h? riscv
seems to.

I'm not 100% sure on kgdb and kexec stuff but I think it seems okay.
Looks like a pretty nice cleanup too aside from the features it brings,
thanks for working on it.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
