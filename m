Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0536AC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:57:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF24206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 11:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="m5G4xg/0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfAHL46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:56:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37247 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbfAHL46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:56:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id g67so4085289wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 03:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZhAZJuqPU7RKOJhMeSxOJONoJ67G3o8MCo8xEvxcW8E=;
        b=m5G4xg/0cyJYmjd1Ky/f2AU9v7fJ4SPYRWFV4xsXlZiGBtigpCDw36KTwMss2VbTy7
         Km/7fwHldwVB1HgDX4egn2hQbvyBgwP3n+XtQ+OyEvQwk0Jw3zjhQTBQ++NNdt4rM01v
         1HIyPhfX63YlT8XKhfj1U6kmW8HNw39jJugwcZ0Nl5UfjlWfGsggCmMo3/JdMK+ggCPn
         wsrGq0fRmna7/YE4azAbuwLyWtv0yLNIaLwKsrDV+6i8IHtojdFcS5o7N778Cbve6pZD
         2vg+tlh4zrbm8rkJwaDsYLwY3rHlifawK5sbUdqbyPyL8YT2htkvXcMGKJNAtz34fHj+
         5wkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZhAZJuqPU7RKOJhMeSxOJONoJ67G3o8MCo8xEvxcW8E=;
        b=B+WFYBhsf3m1UDWBoLaqqaZADF/HaM68TbHCWCH5S8qDlUf2zpEanch1MHiCmKYPPB
         OSKqs4qTMAl4khR5DpfhGlNoSMtgOQxSJEqBs+wz82XIzJvX7rVXFASB/KybjYSAqziB
         LqcBKLGajre1heabpTwjK9SR1yR5FVck+rTI+CkiJzq7HNeNz0neFhhw+Jg0yG3KsCl3
         pd7QwRItvLIiqoip5dgzH28nfvwyCnkwDbG+aGRUm4rXGdKQyyc4wL0sfy9+MMQRHXHd
         9RjpyTpJ+nP55yTT/7bBSdsPMAkNfKxxODun8uOCH6V86rpaStozFE8FW1zxBkUkmTIV
         qCqA==
X-Gm-Message-State: AJcUukfCnN8Xjj/RjIGyqJjwh/NSt4O5mL5kO742Lm02+nSF2ifN5+w/
        5qh1i6pEkEsbT5npzmx7wVLtOGZsFTias58peh3Pyg==
X-Google-Smtp-Source: ALg8bN6Wfyhx4ZB6t+BJ7QeFc2BIH1aA1jxKAfnPSCTjW+ax7ahyCb0KU+/9lHBirwjCHa8GCI6vRkPGCtNpeJWqAFM=
X-Received: by 2002:a1c:f509:: with SMTP id t9mr1662305wmh.76.1546948616128;
 Tue, 08 Jan 2019 03:56:56 -0800 (PST)
MIME-Version: 1.0
References: <1546940318-9752-1-git-send-email-atish.patra@wdc.com> <1546940318-9752-7-git-send-email-atish.patra@wdc.com>
In-Reply-To: <1546940318-9752-7-git-send-email-atish.patra@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Tue, 8 Jan 2019 17:26:45 +0530
Message-ID: <CAAhSdy0VsOjiSRhBY7fdXVOccWV+4j_UJwKdNX4cNWHBJKyGeA@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] RISC-V: Add required checks during clock source init
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-riscv@lists.infradead.org, Alan Kao <alankao@andestech.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@suse.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitriy Cherkasov <dmitriy@oss-tech.org>,
        Jason Cooper <jason@lakedaemon.net>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Michael Clark <michaeljclark@mac.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zong Li <zongbox@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Few nit changes..

Prefer, "clocksource/drivers/riscv:" prefix instead of "RISC-V:" for
this patch.

On Tue, Jan 8, 2019 at 3:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> Currently, clocksource registration happens for an invalid cpu
> for non-smp kernels. This lead to kernel panic as cpu hotplug
> registration will fail for those cpus. Moreover,
> riscv_hartid_to_cpuid can return errors now.
>
> Do not proceed if hartid or cpuid is invalid. Take this opprtunity
> to print appropriate error strings for different failure cases.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index 43189220..d9b914e9 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -95,14 +95,31 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>         struct clocksource *cs;
>
>         hartid = riscv_of_processor_hartid(n);
> +       if (hartid < 0) {
> +               pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
> +                       n, hartid);
> +               return hartid;
> +       }

Add empty line here.

>         cpuid = riscv_hartid_to_cpuid(hartid);
>

Remove empty line here

> +       if (cpuid < 0) {
> +               pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
> +               return cpuid;
> +       }
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

Remove empty line here.

> +       if (error) {
> +               pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
> +                      error, cpuid);
> +               return error;
> +       }

Add empty line here.

>         sched_clock_register(riscv_sched_clock,
>                         BITS_PER_LONG, riscv_timebase);
>
> @@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
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
> --
> 2.7.4
>

Apart from above, looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
