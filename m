Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383BEC43612
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08170218E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 03:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="sKfZTrqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728670AbeL0Dgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 22:36:37 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38594 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0Dgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 22:36:37 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so17098903wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 19:36:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AUBNZAgxqZfBaytyfOb+0LphpB3Zk2eeZxHObCF+N0Y=;
        b=sKfZTrqRJx4amkkQ2XUfGpJbQS++7AiWyXIt+nTg7Bn/F9FTMw3REp7NV5xiYdkSiC
         RFjn3+QU70CVjLLudpvNDHg4arNBH5kaaiRoQfmnQqXOkMtGxkp/z/fJMt4tk+KxcJXy
         phrLosh/NL8JT7yH4AgERpy4dqY9W2lMcZSZr6DIUmR+uXMYUPWnxSN1+70LA8Omg/UP
         1k/OxSpHOgn5qrZVBDKIF7KRteVoLj5vHsYpXhHktCql3SIZMpp2DPtvTaPsYM/KaFCP
         Cs2/mlBnKXQ3ApNf0gUJPeQ68KbmNZm3g9oIVUznBM8Uo5q3ejAAkQqTyydVU+DHSq7Q
         vUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AUBNZAgxqZfBaytyfOb+0LphpB3Zk2eeZxHObCF+N0Y=;
        b=bwATHJm4frAITUu8G9XYXi3EF5MBwEDUv2ADFr+S/M+oC4XVS7cVB3t/6OV1r1GLCh
         b5aHFeNRmHUiG4U52q/KRcxZwuHWu+ss84h42iMSgt0X8SzyAhEuJFwi28V0v8Nwg8Jh
         YvVwmSn8vdF+qAhwOWltX4yXYSqnAs9jPSr9ENX7ZdO3d7xmu90E3bn0flsJ47GDMQkQ
         5RQXtLBqGnFiJKd6nVsFbKe3vNIV9C1N2pw/Ycv2McpaiOwCi0sFTsDEpMpT31Yb38mM
         QJBK6XCT7DfmnkIN4d9oXwcMGTHC9N9sWkr9RIGbbqRtUPQ/O4FDNw4acXrLAEXdyr78
         Cppg==
X-Gm-Message-State: AJcUukc8Hp3DgJabg5QvtyubwtX/07jbh5M7ZjQeLOS6qcFLVu2BJM72
        nbHqimFd7PZEn6PFK63ZtdKEfsCVR1REHBvxeqNMEg==
X-Google-Smtp-Source: ALg8bN4G+CDxVgjsNrJPo0Pielf+bbaWCpaE4chVn86VCj7v5+qYj9jG+3cUKFro5aqud5/sMaoAhgYwbo+Lgb8ITmg=
X-Received: by 2002:adf:f5d1:: with SMTP id k17mr21949955wrp.59.1545881795255;
 Wed, 26 Dec 2018 19:36:35 -0800 (PST)
MIME-Version: 1.0
References: <1545865741-22795-1-git-send-email-atish.patra@wdc.com> <1545865741-22795-2-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1545865741-22795-2-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 27 Dec 2018 09:06:24 +0530
Message-ID: <CAAhSdy3Wd6tPrv-XDqETK8sBetYSg-mjHzZXJQJgUFeufEjPfA@mail.gmail.com>
Subject: Re: [PATCH 1/3] RISC-V: Do not wait indefinitely in __cpu_up
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
> In SMP path, __cpu_up waits for other CPU to come online
> indefinitely. This is wrong as other CPU might be disabled
> in machine mode and possible CPU is set to the cpus present
> in DT.
>
> Introduce a completion variable and waits only for a second.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/kernel/smpboot.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 18cda0e8..bb8cd242 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -39,6 +39,7 @@
>
>  void *__cpu_up_stack_pointer[NR_CPUS];
>  void *__cpu_up_task_pointer[NR_CPUS];
> +static DECLARE_COMPLETION(cpu_running);
>
>  void __init smp_prepare_boot_cpu(void)
>  {
> @@ -77,6 +78,7 @@ void __init setup_smp(void)
>
>  int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>  {
> +       int ret = 0;
>         int hartid = cpuid_to_hartid_map(cpu);
>         tidle->thread_info.cpu = cpu;
>
> @@ -92,10 +94,15 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>                   task_stack_page(tidle) + THREAD_SIZE);
>         WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>
> -       while (!cpu_online(cpu))
> -               cpu_relax();
> +       wait_for_completion_timeout(&cpu_running,
> +                                           msecs_to_jiffies(1000));
>
> -       return 0;
> +       if (!cpu_online(cpu)) {
> +               pr_crit("CPU%u: failed to come online\n", cpu);
> +               ret = -EIO;
> +       }
> +
> +       return ret;
>  }
>
>  void __init smp_cpus_done(unsigned int max_cpus)
> @@ -121,6 +128,7 @@ asmlinkage void __init smp_callin(void)
>          * a local TLB flush right now just in case.
>          */
>         local_flush_tlb_all();
> +       complete(&cpu_running);
>         /*
>          * Disable preemption before enabling interrupts, so we don't try to
>          * schedule a CPU that hasn't actually started yet.
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>
