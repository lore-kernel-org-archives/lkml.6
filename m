Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0CDC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 454442081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GXLU/J+A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454442081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbeLDQJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:09:57 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55238 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbeLDQJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:09:56 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so16182318ita.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 08:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jL/SU8mOveu5SCrLKhzYoUK+3hRFdUMe0A1jGUDp36g=;
        b=GXLU/J+AQMhHlm5MLX70r0IkS9bd+6dApQHZuSXG9XjKYk9bA79fYYo/QFICf0pBEu
         6eTnKx5HWclwWupc1kGIMuZFv47xkijEXeeSlo+gexVSPWwNcyHSxY5hMCD4+r5kp0qu
         3I9a8UkSGlfQzGdJeeHfxjQ++Ij+0bd50nLvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jL/SU8mOveu5SCrLKhzYoUK+3hRFdUMe0A1jGUDp36g=;
        b=AiFUS4IDG6dhJ3l4KKM6SmJWKofedLIVPYVERMw+O0aFdRCZdZDi2KNe5Rl8vdV1mE
         7hnEt2uzi94VF1Q0gkFEPKrzh3tdPet/SMQP+n2Lvs0RhU6IwVHfXeFBGsu7q7JAnZUC
         dnZ3lJE+k3EY4tjNEPEe50UqS9uNbPmumsMaQdH27R4tYOETza/U6+9mx2DqP+VAHD2z
         0xGmQ87SRAf93kgf+GIg2CyI3enkhdlpI/Q5I455QvwXSBPsUBlNqRYODLbqheE4uxhp
         DqxWWWxVPZCeFh+b8XkBXYjLYa5LACr/x+uzhvwYGXcYGKrVm5hYx+j0Ps2OQo9ewYlQ
         xvug==
X-Gm-Message-State: AA+aEWbU6rD7/wcCNGzSafEVQ7jVadR0+IVTXvEsnbLkVoUa0eNiK2Ni
        KQMWfnzyy5xhGnMFxAZ02/jqWRhedIHNYQlGifSpdcWnNdw=
X-Google-Smtp-Source: AFSGD/VSeZhkt9YMP90a6z4+xlgm60YOMoQUHyyti+3Dflhc1BxbamXTxzN7IvBlt4+sQ+oKMPVj8jzhhwVqfAAVEjI=
X-Received: by 2002:a24:edc4:: with SMTP id r187mr13185611ith.158.1543939795127;
 Tue, 04 Dec 2018 08:09:55 -0800 (PST)
MIME-Version: 1.0
References: <1543599271-14339-1-git-send-email-will.deacon@arm.com> <1543599271-14339-3-git-send-email-will.deacon@arm.com>
In-Reply-To: <1543599271-14339-3-git-send-email-will.deacon@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 4 Dec 2018 17:09:41 +0100
Message-ID: <CAKv+Gu-DiKTt2XZr-jiuH7B+ivXXSAMTrF68Nra589y0-vYSfA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] arm64: preempt: Provide our own implementation of asm/preempt.h
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, rml@tech9.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 18:34, Will Deacon <will.deacon@arm.com> wrote:
>
> The asm-generic/preempt.h implementation doesn't make use of the
> PREEMPT_NEED_RESCHED flag, since this can interact badly with load/store
> architectures which rely on the preempt_count word being unchanged across
> an interrupt.
>
> However, since we're a 64-bit architecture and the preempt count is
> only 32 bits wide, we can simply pack it next to the resched flag and
> load the whole thing in one go, so that a dec-and-test operation doesn't
> need to load twice.
>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

One nit below.

> ---
>  arch/arm64/include/asm/Kbuild        |  1 -
>  arch/arm64/include/asm/preempt.h     | 88 ++++++++++++++++++++++++++++++++++++
>  arch/arm64/include/asm/thread_info.h | 13 +++++-
>  3 files changed, 100 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm64/include/asm/preempt.h
>
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 6cd5d77b6b44..33498f900390 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -14,7 +14,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += msi.h
> -generic-y += preempt.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
>  generic-y += rwsem.h
> diff --git a/arch/arm64/include/asm/preempt.h b/arch/arm64/include/asm/preempt.h
> new file mode 100644
> index 000000000000..f1c1398cf065
> --- /dev/null
> +++ b/arch/arm64/include/asm/preempt.h
> @@ -0,0 +1,88 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_PREEMPT_H
> +#define __ASM_PREEMPT_H
> +
> +#include <linux/thread_info.h>
> +
> +#define PREEMPT_NEED_RESCHED   BIT(32)
> +#define PREEMPT_ENABLED        (PREEMPT_NEED_RESCHED)
> +
> +static inline int preempt_count(void)
> +{
> +       return READ_ONCE(current_thread_info()->preempt.count);
> +}
> +
> +static inline void preempt_count_set(u64 pc)
> +{
> +       /* Preserve existing value of PREEMPT_NEED_RESCHED */
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +#define init_task_preempt_count(p) do { \
> +       task_thread_info(p)->preempt_count = FORK_PREEMPT_COUNT; \
> +} while (0)
> +
> +#define init_idle_preempt_count(p, cpu) do { \
> +       task_thread_info(p)->preempt_count = PREEMPT_ENABLED; \
> +} while (0)
> +
> +static inline void set_preempt_need_resched(void)
> +{
> +       current_thread_info()->preempt.need_resched = 0;
> +}
> +
> +static inline void clear_preempt_need_resched(void)
> +{
> +       current_thread_info()->preempt.need_resched = 1;
> +}
> +
> +static inline bool test_preempt_need_resched(void)
> +{
> +       return !current_thread_info()->preempt.need_resched;
> +}
> +
> +static inline void __preempt_count_add(int val)
> +{
> +       u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +       pc += val;
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +static inline void __preempt_count_sub(int val)
> +{
> +       u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> +       pc -= val;
> +       WRITE_ONCE(current_thread_info()->preempt.count, pc);
> +}
> +
> +static inline bool __preempt_count_dec_and_test(void)
> +{
> +       struct thread_info *ti = current_thread_info();
> +       u64 pc = READ_ONCE(ti->preempt_count);
> +
> +       WRITE_ONCE(ti->preempt.count, --pc);

The difference between preempt.count and preempt_count doesn't really
stand out visually, so perhaps add a comment here that the truncation
is intentional?

> +
> +       /*
> +        * If we wrote back all zeroes, then we're preemptible and in
> +        * need of a reschedule. Otherwise, we need to reload the
> +        * preempt_count in case the need_resched flag was cleared by an
> +        * interrupt occurring between the non-atomic READ_ONCE/WRITE_ONCE
> +        * pair.
> +        */
> +       return !pc || !READ_ONCE(ti->preempt_count);
> +}
> +
> +static inline bool should_resched(int preempt_offset)
> +{
> +       u64 pc = READ_ONCE(current_thread_info()->preempt_count);
> +       return pc == preempt_offset;
> +}
> +
> +#ifdef CONFIG_PREEMPT
> +void preempt_schedule(void);
> +#define __preempt_schedule() preempt_schedule()
> +void preempt_schedule_notrace(void);
> +#define __preempt_schedule_notrace() preempt_schedule_notrace()
> +#endif /* CONFIG_PREEMPT */
> +
> +#endif /* __ASM_PREEMPT_H */
> diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
> index cb2c10a8f0a8..bbca68b54732 100644
> --- a/arch/arm64/include/asm/thread_info.h
> +++ b/arch/arm64/include/asm/thread_info.h
> @@ -42,7 +42,18 @@ struct thread_info {
>  #ifdef CONFIG_ARM64_SW_TTBR0_PAN
>         u64                     ttbr0;          /* saved TTBR0_EL1 */
>  #endif
> -       int                     preempt_count;  /* 0 => preemptable, <0 => bug */
> +       union {
> +               u64             preempt_count;  /* 0 => preemptible, <0 => bug */
> +               struct {
> +#ifdef CONFIG_CPU_BIG_ENDIAN
> +                       u32     need_resched;
> +                       u32     count;
> +#else
> +                       u32     count;
> +                       u32     need_resched;
> +#endif
> +               } preempt;
> +       };
>  };
>
>  #define thread_saved_pc(tsk)   \
> --
> 2.1.4
>
