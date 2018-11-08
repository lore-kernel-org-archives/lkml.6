Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B92C32789
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5590B20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 12:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RSrjlvka"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5590B20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbeKHWR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 17:17:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:40459 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeKHWR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 17:17:56 -0500
Received: by mail-io1-f67.google.com with SMTP id a23-v6so14495779iod.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 04:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Hezd6akCGse2QWH8e9J0KIe7eCZRvRy27DimaAMKF4U=;
        b=RSrjlvkahZozJamwG1TaieRLmFgLm27d7XzR27hIqZECFbb6p5JWkw7sz3oxswF5KY
         /07e1gJMtsnYDtoObnlAvdRC/MpVSfFyA6arHRjyrbgwRJEzh3/2jad9pWs+qx4RQCVf
         k4svUH88BqFpDuOLhq8urOJJgy99xht5jEAdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Hezd6akCGse2QWH8e9J0KIe7eCZRvRy27DimaAMKF4U=;
        b=hf4waYRNJvClK97JlE948ci4MJn1Vb7kXKKvFrjpLreQejJM9D3MKpbNcd/3v8Fds9
         FlwM6m2yXylBnjY8rDOkwPjyDmgbrAYLVjl42oTVn/JtipLODUzPzUS6bBVqPXuqjGeu
         /tR5QhBs3BgFjEeiZOfisublUlWbgWypYyQa1geZ+54NhwiRgo38uNmTcks1lKKT21DA
         xKUVU9VNxfRik5ltV+D0Nwab/D6kWWOx796oiS47i/YZySKD64KFqvXsNhHe0ZAiHpz5
         Hwiz1ecMH/syYVTqck0anAoPowdB6QtE/diM0y0CYG5j9rVPsBwfaD+2hxFzTj2rhH6u
         IqvA==
X-Gm-Message-State: AGRZ1gKx+ZZ/SwtjyhCaJVQnp6W7K4vLYULbLXJ1SzL24JDorBVBhUOw
        aq1OKYAJmioUneof3fENo2g0r46okVPGPakcC4RRbA==
X-Google-Smtp-Source: AJdET5emnCOzvOIKP8ur8kFOjb5dI2/hy9JJORpUhCTspLNA9gZ8PmgQDYDd+FwKAs3/dBcomCe+s8GGdGzCcQpgpTI=
X-Received: by 2002:a6b:5d18:: with SMTP id r24-v6mr3335078iob.170.1541680956312;
 Thu, 08 Nov 2018 04:42:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a6b:4f16:0:0:0:0:0 with HTTP; Thu, 8 Nov 2018 04:42:35 -0800 (PST)
In-Reply-To: <20181026142152.5F0D868C95@newverein.lst.de>
References: <20181026142008.D922868C94@newverein.lst.de> <20181026142152.5F0D868C95@newverein.lst.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 8 Nov 2018 13:42:35 +0100
Message-ID: <CAKv+Gu_D2vzk-sBkufK7JvaPawC+QnpZwkC0+ikTb7A6qko8ng@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] arm64: implement live patching
To:     Torsten Duwe <duwe@lst.de>
Cc:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 October 2018 at 16:21, Torsten Duwe <duwe@lst.de> wrote:
> Based on ftrace with regs, do the usual thing.
> (see Documentation/livepatch/livepatch.txt)
>
> Use task flag bit 6 to track patch transisiton state for the consistency
> model. Add it to the work mask so it gets cleared on all kernel exits to
> userland.
>
> Tell livepatch regs->pc is the place to change the return address.
> Make sure the graph tracer call hook is only called on the final function
> entry in case regs->pc gets modified after an interception.
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
>
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -120,6 +120,7 @@ config ARM64
>         select HAVE_GENERIC_DMA_COHERENT
>         select HAVE_HW_BREAKPOINT if PERF_EVENTS
>         select HAVE_IRQ_TIME_ACCOUNTING
> +       select HAVE_LIVEPATCH
>         select HAVE_MEMBLOCK
>         select HAVE_MEMBLOCK_NODE_MAP if NUMA
>         select HAVE_NMI
> @@ -1350,4 +1351,6 @@ if CRYPTO
>  source "arch/arm64/crypto/Kconfig"
>  endif
>
> +source "kernel/livepatch/Kconfig"
> +
>  source "lib/Kconfig"
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -76,6 +76,7 @@ void arch_release_task_struct(struct tas
>  #define TIF_FOREIGN_FPSTATE    3       /* CPU's FP state is not current's */
>  #define TIF_UPROBE             4       /* uprobe breakpoint or singlestep */
>  #define TIF_FSCHECK            5       /* Check FS is USER_DS on return */
> +#define TIF_PATCH_PENDING      6
>  #define TIF_NOHZ               7
>  #define TIF_SYSCALL_TRACE      8
>  #define TIF_SYSCALL_AUDIT      9
> @@ -94,6 +95,7 @@ void arch_release_task_struct(struct tas
>  #define _TIF_NEED_RESCHED      (1 << TIF_NEED_RESCHED)
>  #define _TIF_NOTIFY_RESUME     (1 << TIF_NOTIFY_RESUME)
>  #define _TIF_FOREIGN_FPSTATE   (1 << TIF_FOREIGN_FPSTATE)
> +#define _TIF_PATCH_PENDING     (1 << TIF_PATCH_PENDING)
>  #define _TIF_NOHZ              (1 << TIF_NOHZ)
>  #define _TIF_SYSCALL_TRACE     (1 << TIF_SYSCALL_TRACE)
>  #define _TIF_SYSCALL_AUDIT     (1 << TIF_SYSCALL_AUDIT)
> @@ -106,7 +108,8 @@ void arch_release_task_struct(struct tas
>
>  #define _TIF_WORK_MASK         (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
>                                  _TIF_NOTIFY_RESUME | _TIF_FOREIGN_FPSTATE | \
> -                                _TIF_UPROBE | _TIF_FSCHECK)
> +                                _TIF_UPROBE | _TIF_FSCHECK | \
> +                                _TIF_PATCH_PENDING)
>
>  #define _TIF_SYSCALL_WORK      (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>                                  _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP | \
> --- /dev/null
> +++ b/arch/arm64/include/asm/livepatch.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + *
> + * livepatch.h - arm64-specific Kernel Live Patching Core
> + *
> + * Copyright (C) 2016,2018 SUSE
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version 2
> + * of the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +#ifndef _ASM_ARM64_LIVEPATCH_H
> +#define _ASM_ARM64_LIVEPATCH_H
> +
> +#include <asm/ptrace.h>
> +
> +static inline int klp_check_compiler_support(void)
> +{
> +       return 0;
> +}
> +
> +static inline void klp_arch_set_pc(struct pt_regs *regs, unsigned long ip)
> +{
> +       regs->pc = ip;
> +}
> +
> +#endif /* _ASM_ARM64_LIVEPATCH_H */
> --- a/arch/arm64/kernel/entry-ftrace.S
> +++ b/arch/arm64/kernel/entry-ftrace.S
> @@ -226,6 +226,7 @@ ftrace_common:
>
>         /* The program counter just after the ftrace call site */
>         str     lr, [x9, #S_PC]
> +
>         /* The stack pointer as it was on ftrace_caller entry... */
>         add     x28, fp, #16
>         str     x28, [x9, #S_SP]

Please drop this hunk

> @@ -233,6 +234,10 @@ ftrace_common:
>         ldr     x28, [fp, 8]
>         str     x28, [x9, #S_LR]        /* to pt_regs.r[30] */
>
> +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> +       mov     x28, lr         /* remember old return address */
> +#endif
> +
>         ldr_l   x2, function_trace_op, x0
>         ldr     x1, [fp, #8]
>         sub     x0, lr, #8      /* function entry == IP */
> @@ -245,6 +250,17 @@ ftrace_call:
>
>         bl      ftrace_stub
>
> +#if defined(CONFIG_LIVEPATCH) && defined(CONFIG_FUNCTION_GRAPH_TRACER)
> +       /* Is the trace function a live patcher an has messed with
> +        * the return address?
> +        */
> +       add     x9, sp, #16     /* advance to pt_regs for restore */
> +       ldr     x0, [x9, #S_PC]
> +       cmp     x0, x28         /* compare with the value we remembered */
> +       /* to not call graph tracer's "call" mechanism twice! */
> +       b.ne    ftrace_common_return

Is ftrace_common_return guaranteed to be in range? Conditional
branches have only -/+ 1 MB range IIRC.

Better to do

b.eq ftrace_graph_call
b   ftrace_common_return

to be sure

> +#endif
> +
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER

Can we fold these #ifdef blocks together (i.e, incorporate the
conditional livepatch sequence here)

>         .global ftrace_graph_call
>  ftrace_graph_call:                     // ftrace_graph_caller();
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -29,6 +29,7 @@
>  #include <linux/sizes.h>
>  #include <linux/string.h>
>  #include <linux/tracehook.h>
> +#include <linux/livepatch.h>
>  #include <linux/ratelimit.h>
>  #include <linux/syscalls.h>
>
> @@ -934,6 +935,9 @@ asmlinkage void do_notify_resume(struct
>                         if (thread_flags & _TIF_UPROBE)
>                                 uprobe_notify_resume(regs);
>
> +                       if (thread_flags & _TIF_PATCH_PENDING)
> +                               klp_update_patch_state(current);
> +
>                         if (thread_flags & _TIF_SIGPENDING)
>                                 do_signal(regs);
>
