Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9C1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7F762148E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 04:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="a/kGpxmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeL0D6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:58:17 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36608 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728511AbeL0D6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:58:16 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so16444502wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hWe2wpBd2D39MiGxDvt7Xxqdm6Vxh4rMpytdLJQK45o=;
        b=a/kGpxmCkjbt6lEu7r9USgPbiaqpYQvkfs8f1joj3Yg9ZkiHI7S2nOO02hzLrl3+u3
         JvUFhpj6b+4NXnNB6C0zRDsBA+uEV1a9/gg7j56nPMJ8Q7WE5Hmc8wURgLaj3byd2yGq
         YX1zFb4Q732/LBnT8CntKygKBTFmvj+dHtjit8Jmkqubcd+Ct5MnRTrId+jJNNxN8k6s
         dPnOA24DNDjAcxiTq05HeVWTry2C0IDt2T2+0IYSiYAnmlt3vhf5Z91nEfumiRb/EPwB
         su8cc2iipgr+y3FKcYE1sNI/NgepZ1n1z/+cLEva7D5j0UohqbG6f2/qigIdMQ0mGVwr
         A/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hWe2wpBd2D39MiGxDvt7Xxqdm6Vxh4rMpytdLJQK45o=;
        b=bxSq3XtGL1jpnLdXJ3753Mos4H3/gbIB0wY/mgrqvjPOAPJyfpQ1d7i8nI77/bPkFr
         kDpCh98qUfl9Xn3fJEYzBfM4TDDKcN71Z852h+NguWbaEPNliAjjqKZVfN4o2t1OvzMg
         N/MOJYySPYzYFciCXStUq9ugY+EAMzEFH26kEViTkkfCEYe7ZHV7rjHdaHdoc/FJvnIp
         I3piEMABmRPNqWtDSp/DW5FqAAPF1/x3RpR60r8n56g2UlYmKQNyX/xYL+rp4fee6THn
         hoM3KIf9xgBWYWo4AK5T9zIGG9RmgvCN3aQW7Gr5+MvKAL/laKzJtGg6uTMzLgqL00H3
         mhjg==
X-Gm-Message-State: AA+aEWY5UfBdld2zcmm7hBjYdja2ZgZ2WsESyIscJrrdlNGjA+FYIMmc
        ztia9oh15FC7KhNTS0yAV3shVKYzaaeL9681a3lhkA==
X-Google-Smtp-Source: AFSGD/WFGOHrimI2VfSwwJThGTm5gQ+kUyw/HUS4fkfIGctjZOxzrYlJ+xkbrWkm9CQ77AGVkK7YHhrckQb0Oyyc/Dg=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr19912199wme.16.1545883094136;
 Wed, 26 Dec 2018 19:58:14 -0800 (PST)
MIME-Version: 1.0
References: <1545865741-22795-1-git-send-email-atish.patra@wdc.com> <1545865741-22795-4-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1545865741-22795-4-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 27 Dec 2018 09:28:03 +0530
Message-ID: <CAAhSdy20-r5e1EQ7yTawbxXs0NgFkfg8L8VLRUFLL=NcXfCD2w@mail.gmail.com>
Subject: Re: [PATCH 3/3] RISC-V: Fix non-smp kernel boot on SMP systems
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Rob Herring <robh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2018 at 4:39 AM Atish Patra <atish.patra@wdc.com> wrote:
>
> In non-smp configuration, hartid can be higher that NR_CPUS.
> riscv_of_processor_hartid should not be compared to hartid to
> NR_CPUS in that case. Moreover, this function checks all the
> DT properties of a hart node. NR_CPUS comparison seems out of
> place.

This only explains change in arch/riscv/kernel/cpu.c

Create separate patch for it.

>
> Do cpuid comparison with NR_CPUs in smp setup code. Update the

Create separate patch for change in arch/riscv/kernel/smp.c

> drivers to handle appropriate code as well.

Create separate patches for riscv_timer and irq-sifive-plic.c
because they will probably go via different gitrepos.

>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/cpu.c           |  4 ----
>  arch/riscv/kernel/smp.c           |  1 -
>  arch/riscv/kernel/smpboot.c       |  5 +++++
>  drivers/clocksource/riscv_timer.c | 21 ++++++++++++++++++---
>  drivers/irqchip/irq-sifive-plic.c |  5 +++++
>  5 files changed, 28 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index b4a7d442..251ffab6 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -34,10 +34,6 @@ int riscv_of_processor_hartid(struct device_node *node)
>                 pr_warn("Found CPU without hart ID\n");
>                 return -(ENODEV);
>         }
> -       if (hart >= NR_CPUS) {
> -               pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
> -               return -(ENODEV);
> -       }
>
>         if (of_property_read_string(node, "status", &status)) {
>                 pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 57b1383e..9ea7ac7d 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -49,7 +49,6 @@ int riscv_hartid_to_cpuid(int hartid)
>                         return i;
>
>         pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
> -       BUG();

Have a separate patch with explanation about why
we don't need BUG() here.

>         return i;
>  }
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index bb8cd242..05291840 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -66,6 +66,11 @@ void __init setup_smp(void)
>                         found_boot_cpu = 1;
>                         continue;
>                 }
> +               if (cpuid >= NR_CPUS) {
> +                       pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
> +                               cpuid, hart);
> +                       break;
> +               }
>
>                 cpuid_to_hartid_map(cpuid) = hart;
>                 set_cpu_possible(cpuid, true);
> diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
> index 084e97dc..acf2af10 100644
> --- a/drivers/clocksource/riscv_timer.c
> +++ b/drivers/clocksource/riscv_timer.c
> @@ -89,20 +89,35 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>         struct clocksource *cs;
>
>         hartid = riscv_of_processor_hartid(n);
> +       if (hartid < 0) {
> +               pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +                       n, hartid);
> +               return hartid;
> +       }
>         cpuid = riscv_hartid_to_cpuid(hartid);
>
> +       if (cpuid < 0)
> +               pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +
>         if (cpuid != smp_processor_id())
>                 return 0;
>
> +       pr_err("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
> +              __func__, cpuid, hartid);
>         cs = per_cpu_ptr(&riscv_clocksource, cpuid);
> -       clocksource_register_hz(cs, riscv_timebase);
> +       error = clocksource_register_hz(cs, riscv_timebase);
>
> +       if (error) {
> +               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> +                      error, cpuid);
> +               return error;
> +       }
>         error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
>                          "clockevents/riscv/timer:starting",
>                          riscv_timer_starting_cpu, riscv_timer_dying_cpu);
>         if (error)
> -               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> -                      error, cpuid);
> +               pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
> +                      error);
>         return error;
>  }
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index 357e9daf..254ecd76 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -237,6 +237,11 @@ static int __init plic_init(struct device_node *node,
>                 }
>
>                 cpu = riscv_hartid_to_cpuid(hartid);
> +               if (cpu < 0) {
> +                       pr_warn("Invalid cpuid for context %d\n", i);
> +                       continue;
> +               }
> +
>                 handler = per_cpu_ptr(&plic_handlers, cpu);
>                 handler->present = true;
>                 handler->ctxid = i;
> --
> 2.7.4
>

Regards,
Anup
