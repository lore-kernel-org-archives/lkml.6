Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54C2C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61AAF25608
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNav1DHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AAF25608
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754448AbeFYIew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:34:52 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:34884 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754315AbeFYIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:34:49 -0400
Received: by mail-ot0-f194.google.com with SMTP id q17-v6so14169958otg.2;
        Mon, 25 Jun 2018 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZryWIhoY5LgEPgD2nNJFNMVO/V+GdLwKCz8fPtN3sng=;
        b=CNav1DHa90ns5BjV45Rfmv8gOTixRP9E9yMymvxy1JMUSW9b6MC+ntJFWG7gYdmSfQ
         JtNw4wHNJoAlBCHg1NIz+NntI8+zsaRRtEDDWJJlIkL6HHdoUJsNEJS81VXr0PBEfmTJ
         KGtfw2gStA7Um/kIC1iPddRYIMFEOW/Qoia+LPS7PkCYcs126czZ1q/XP8IHL/Odtmab
         AhbKcrNGs7lE7Q5ZWjciFK2ooqYw8cnvkFb7nuJ++fz9WNV2nADt4TCrfEzJ8oVDTkia
         opFam2mAK5elKjSqIrbOdQpgqvggpG1rFvuk4DUyY5myvj6NJHpo4K9ojMyfGtYWsq2I
         jQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZryWIhoY5LgEPgD2nNJFNMVO/V+GdLwKCz8fPtN3sng=;
        b=IxLm8qiww7U0n/lj0cvYumlolTnyg716zlch2W8Y2PkVg+fWPhNVQfWrG6qNu0qq/r
         96iw4dWlYfhUY9qg2Hh6kT8T8rWkF5Cg4LMHEUV1XLXFp7s1TBM9yFVx2mrQnV+QT/26
         kUU8pgvsTzDtkSGyUeSicKzdPx06l+l02+VQmMBkRuI2xQuFwI+9aR21sW95892fGnDE
         uAWDL1NvcoZzCI7FVExcHLa4z9sKAA2/OnOb1sFLluGer60RwLAqm54E2pBQSqgBFeyb
         OJJGAduIqnlVliGKup9jYDW3AphbmWBQZn7mKEZGu0g0ID/LMWnOvkIrDaYMurPwCB8Z
         aEEQ==
X-Gm-Message-State: APt69E0cA8ITK6zFwoVVIExZsI32YjS+74yEZ8ISLix1jX1JsgVdJ3+y
        mHIQPf1QC7I2soY41pQ3OIknXv3aGoN2X6UDxhA=
X-Google-Smtp-Source: AAOMgpeXrB4+0lvmihA3Xo5EY91uTO+JoYsfey5jy4tM4uZuMegswLEJIxDZKR/oidrCXePfaCoW+CJ0m0DEY+JA434=
X-Received: by 2002:a9d:7105:: with SMTP id n5-v6mr3858635otj.305.1529915689180;
 Mon, 25 Jun 2018 01:34:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:34:48
 -0700 (PDT)
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 10:34:48 +0200
X-Google-Sender-Auth: W2HziTmPOX3QImq76pp9EXGeyv8
Message-ID: <CAJZ5v0gPmMbpFMTQ8mdhxKC86QsUaVQEzBxWyN9MdiTdR1QgWw@mail.gmail.com>
Subject: Re: [PATCH V9] powercap/drivers/idle_injection: Add an idle injection framework
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 3:23 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:

[cut]

> +/**
> + * idle_injection_wakeup - Wake up all idle injection threads
> + * @ii_dev: the idle injection device
> + *
> + * Every idle injection task belonging to the idle injection device
> + * and running on an online CPU will be wake up by this call.
> + */
> +static void idle_injection_wakeup(struct idle_injection_device *ii_dev)
> +{
> +       struct idle_injection_thread *iit;
> +       unsigned int cpu;
> +
> +       for_each_cpu_and(cpu, to_cpumask(ii_dev->cpumask), cpu_online_mask) {
> +               iit = per_cpu_ptr(&idle_injection_thread, cpu);
> +               iit->should_run = 1;
> +               wake_up_process(iit->tsk);
> +       }
> +}
> +
> +/**
> + * idle_injection_wakeup_fn - idle injection timer callback
> + * @timer: a hrtimer structure
> + *
> + * This function is called when the idle injection timer expires which
> + * will wake up the idle injection tasks and these ones, in turn, play
> + * idle a specified amount of time.
> + *
> + * Return: HRTIMER_RESTART.
> + */
> +static enum hrtimer_restart idle_injection_wakeup_fn(struct hrtimer *timer)
> +{
> +       unsigned int duration_ms;
> +       struct idle_injection_device *ii_dev =
> +               container_of(timer, struct idle_injection_device, timer);
> +
> +       duration_ms = READ_ONCE(ii_dev->run_duration_ms);
> +       duration_ms += READ_ONCE(ii_dev->idle_duration_ms);
> +
> +       idle_injection_wakeup(ii_dev);
> +
> +       hrtimer_forward_now(timer, ms_to_ktime(duration_ms));
> +
> +       return HRTIMER_RESTART;
> +}

Also, I'd rename the above to idle_inject_timer_fn() for clarity.
_wakeup_fn() is kind of too similar to _wakeup() IMO and a bit
confusing.
