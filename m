Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E726C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C173225610
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 08:41:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK7W2CEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C173225610
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeFYIlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 04:41:45 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45711 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbeFYIlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 04:41:32 -0400
Received: by mail-ot0-f196.google.com with SMTP id k3-v6so604690otl.12;
        Mon, 25 Jun 2018 01:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PGGtDpIu/n7/5FO6CMf4EyCnfYJq4k/kvJOwCglszZ0=;
        b=jK7W2CEZufSqCgfLFZ/1BgK7wxFOSD+gY0Q1qibJZc4BcxYxXceYJpEbBXkWaPp5HH
         5LVo7SSZ7hRP0Ga3w4pSS1dgpz/2FpDndC8cHPFc3wF0THTiOXYSa611FWkt9rhgDlO6
         anEG3NqJFTKNy/MnXmcss0gwzf4DMi/JOWQ8ZZLFXESmI5JJlDZjz5K3BgI2SwM9D/j5
         2abwr/EIrhYrsEjb8eJjjwg2H9mLRF7vIPmguMIt+lqvo1WZRKXav1sFdq0fHLFkn5MY
         xLHmrplu0CLXTFHpnvs75eyRLx5BYyqQGx27FWq5I/kdsodA3EJ6kcqVloBAeAr51J8u
         osIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PGGtDpIu/n7/5FO6CMf4EyCnfYJq4k/kvJOwCglszZ0=;
        b=ZswAXeY41wP9O6HMASZcysL2PIJk/2CZrwKW3zO2Un06wiX/o/6l/RKwUEffJxBOaW
         /7k94gIDiECNyFoZMsoW8YSmE8s5fWucdbo0YLCCH0gh9sQ+KorY8e9jW0KMWR/N9brS
         rORBAsKOJ3CPzYzJTHh1rHGhrxxbxknuavpNE4pTihp0QaEUV0XbfGNmP0viGKSUNaTU
         yEb2Ge0msjcI0OFX4mkAdzwhVfJzP0RU4BUVfwM2MAP2wuAYKYU5kXtIXYwSJb3sHhs0
         UL7GplAiIH8BUoGmbyJkCnCPH5OP2lYVpgKReBwmD152N24A7srEcnR6x9OXsNVk7H9I
         J9CA==
X-Gm-Message-State: APt69E1IhI1EzRXu5OyPvXo7B7XaKiJIkaBjwvik5alR5CFxV8pm8mwy
        q/E4UZpeLv3C+97oH1My9jm7gvwJZSF2QuqpKN4=
X-Google-Smtp-Source: ADUXVKJckqPdsFyVOIEYrwIYzF0VvyFYGmMuizjlSIdObhhJxMH40UIJycMvtLyie29WP/znuUpTph+hLJYzc2yN7u0=
X-Received: by 2002:a9d:cc7:: with SMTP id o7-v6mr6469528otd.291.1529916092079;
 Mon, 25 Jun 2018 01:41:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 01:41:31
 -0700 (PDT)
In-Reply-To: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
References: <1529414627-5638-1-git-send-email-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 10:41:31 +0200
X-Google-Sender-Auth: baAiExcTC2AlCtH_08MP_0KMhIE
Message-ID: <CAJZ5v0gv9jWyKvhYXrL2a8CqdhrWsNDJ59EDci_ezmfku-2_Ww@mail.gmail.com>
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

One more thing.

> +/**
> + * idle_injection_register - idle injection init routine
> + * @cpumask: the list of CPUs managed by the idle injection device
> + *
> + * This is the initialization function in charge of creating the
> + * initializing of the timer and allocate the structures. It does not
> + * starts the idle injection cycles.
> + *
> + * Return: NULL if an allocation fails.
> + */
> +struct idle_injection_device *idle_injection_register(struct cpumask *cpumask)
> +{
> +       struct idle_injection_device *ii_dev;
> +       int cpu, cpu_rb;
> +
> +       ii_dev = kzalloc(sizeof(*ii_dev) + cpumask_size(), GFP_KERNEL);
> +       if (!ii_dev)
> +               return NULL;
> +
> +       cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
> +       hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +       ii_dev->timer.function = idle_injection_wakeup_fn;
> +
> +       for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
> +
> +               if (per_cpu(idle_injection_device, cpu)) {
> +                       pr_err("cpu%d is already registered\n", cpu);

If you print something like this, it should be clear what it is about
and what piece of code it comes from as there will be no context
around it it the log.

> +                       goto out_rollback_per_cpu;

Shorten the label perhaps?

> +               }
> +
> +               per_cpu(idle_injection_device, cpu) = ii_dev;
> +       }
> +
> +       return ii_dev;
> +
> +out_rollback_per_cpu:
> +       for_each_cpu(cpu_rb, to_cpumask(ii_dev->cpumask)) {
> +               if (cpu == cpu_rb)
> +                       break;
> +               per_cpu(idle_injection_device, cpu_rb) = NULL;
> +       }
> +
> +       kfree(ii_dev);
> +
> +       return NULL;
> +}
> +
