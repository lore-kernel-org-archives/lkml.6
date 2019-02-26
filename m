Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF505C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9329621850
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 21:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QJ2Ffgn4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbfBZVbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 16:31:40 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:40316 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728791AbfBZVbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 16:31:39 -0500
Received: by mail-ua1-f66.google.com with SMTP id c5so13330703uaq.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 13:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNH3w69WqOSu5UatortvtlpMyhV0iCePp1B4bd4pGfs=;
        b=QJ2Ffgn4FYd7FSlHQz91s6PQgtgw+rPb61PgEwN4WzyhUMWLJii9JQcEeiAs36H4LS
         LkaXYYmHaxnU8GqdNcbWdPnCoFJ+6WqKydbHioNPOLEA3vXVWONyP0yelY9lPABalgmi
         ei9GwvdiMkdcolQViBk8dV4jEY2//v0P3oseX2k0AIKLESHaSHc8SvQDgIji97WTG9Ga
         ah6y7dbAq6XSQkN8JtlfuROFw4EEaibZGdSF2BnSK9oVteZsRTbKiSLnLv1dtlhB5+aE
         bxROEqFhr274NMBUztCBgOL4waw7vCPvuhaIOT0PY92rqGZMw8Sg670dRVOTpkWd7+B1
         zidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNH3w69WqOSu5UatortvtlpMyhV0iCePp1B4bd4pGfs=;
        b=gcwTSBdu5BxHGSZP0FfbfDl5ANz7Zo4xOEav19XovwEtkyuCjdyf0YDBV9QVyxroEw
         bVlGQEU8xumvfG1f237/1ZTqziBzIoRYJ8j9E6FsLS60gfMQ/u4D3Ik2UOLpsdVXNCwm
         Z6jIKHzTl+Iif93KP6Qd4uBIc8K1zcGvau3sKa4cKvgL770bWapx/66VvE+nSqLjaSmm
         lQZ0hgSNKr8FuKIrbFTmKPi3M3YgCHj+R8sTNLaiVI0hpyM45/G90JsHXhnU3Umexgqz
         p6pxl4DCgNBGBxs28KV6uB2KIAzmfpV1CDuqVz6IaMYymjoahzb31B/FPRtWaGGuO6lA
         CZ2w==
X-Gm-Message-State: APjAAAX6JQRMw9XD/2xQfUNdRH0NaQuxWXGrWLTdvtoIC+qLHyuKdxxu
        NXVyPme6axlpDVDdyIkr8B2ILjoOD0IDDpyAHGq2Iw==
X-Google-Smtp-Source: AHgI3IbC+CmzOj2j1U6/4V1XOEpVwIa7h8kXAQjncLu4b+RVHmgehpiOjjOd3fhofYEGHeRdaRs0MjEE2bVOj7hOPN4=
X-Received: by 2002:a9f:3707:: with SMTP id z7mr130372uad.25.1551216698112;
 Tue, 26 Feb 2019 13:31:38 -0800 (PST)
MIME-Version: 1.0
References: <20190226145415.19411-1-ulf.hansson@linaro.org> <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jiUWsYeQm8xoGf=WpM+yWdnPnkGK0+amPb=3PUE+APfg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 26 Feb 2019 22:31:01 +0100
Message-ID: <CAPDyKFonaODSwNLTOxx=94S2ZNPy5VT07b+niJag0RH=QDatpw@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2019 at 18:50, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Tue, Feb 26, 2019 at 3:55 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Changes in v11:
> >  - This version contains only the infrastructure changes that is needed for
> > deployment. The PSCI/ARM changes have also been updated and tested, but I will
> > post them separately. Still, to provide completeness, I have published a branch
> > containing everything to a git tree [1], feel free to have a look and test.
> >  - The v10 series contained a patch, "timer: Export next wakeup time of a CPU",
> > which has been replaced by a couple of new patches, whom reworks the existing
> > tick_nohz_get_sleep_length() function, to provide the next timer expiration
> > instead of the duration.
> >  - More changelogs are available per patch.
>
> NAK for patches [4-6/8].
>
> The code as is specifically avoids calling ktime_get() from the
> governors as that can be quite expensive, so these patches potentially
> make things worse.

Yeah, good point! What do you think about folding in a patch into the
series, like below, and then let the cpuidle governors use it?

One questions about when CONFIG_NO_HZ_COMMON is unset for the below
suggested code, does it make sense to "return -1" for that case, or
should I return ktime_get()? Does it matter?

Thanks for reviewing!

Kind regards
Uffe

From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 26 Feb 2019 21:43:46 +0100
Subject: [PATCH] time: tick-sched: Add a helper function returning the idle
 entry time

To avoid calling ktime_get() unnecessary times during the idle path, let's
export the timestamp we stored in the per CPU variable,
tick_cpu_sched.idle_entrytime, at the point when we entered idle.

Following changes to the cpuidle governors makes use of this.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 include/linux/tick.h     |  2 ++
 kernel/time/tick-sched.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 5b10a0e4acbb..b641f6e4a50f 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -126,6 +126,7 @@ extern void tick_nohz_irq_exit(void);
 extern bool tick_nohz_idle_got_tick(void);
 extern ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next);
 extern ktime_t tick_nohz_get_next_timer(void);
+extern ktime_t tick_nohz_get_idle_entrytime(void);
 extern unsigned long tick_nohz_get_idle_calls(void);
 extern unsigned long tick_nohz_get_idle_calls_cpu(int cpu);
 extern u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time);
@@ -158,6 +159,7 @@ static inline ktime_t
tick_nohz_get_sleep_length(ktime_t *delta_next)
        *delta_next = TICK_NSEC;
        return *delta_next;
 }
+static inline ktime_t tick_nohz_get_idle_entrytime(void) { return -1; }
 static inline u64 get_cpu_idle_time_us(int cpu, u64 *unused) { return -1; }
 static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 9966be665074..e5d66b618bfa 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -1127,6 +1127,16 @@ ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
        return ktime_sub(next_event, now);
 }

+/**
+ * tick_nohz_get_idle_entrytime - return the time when we entered idle
+ *
+ * Called from power state control code with interrupts disabled
+ */
+ktime_t tick_nohz_get_idle_entrytime(void)
+{
+       return __this_cpu_read(tick_cpu_sched.idle_entrytime);
+}
+
 /**
  * tick_nohz_get_idle_calls_cpu - return the current idle calls counter value
  * for a particular CPU.
-- 
2.17.1
