Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAA7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB9F213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB9F213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbeJDPj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:39:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46499 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbeJDPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:39:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id o21so8082095otb.13;
        Thu, 04 Oct 2018 01:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FUcNDFNEXzpZU7Lc+/TIANbIHhSVFBO8QEjgt1OrT5w=;
        b=Sm9BwK63WyK8d3EDS5uxBbp6ytYkbXK0oJA3P8o18Dw3EJNvzS1PrsdAPNrL6I7Grp
         r1cSFnSAylcmRrsVV8Wn54O6ZFuC00/A7ppF0f+uT9PPjFpAHRJFA1tkXg8CGF282Ofc
         SBFaO7A81oMqWs0C5Ri8zlXNPREE7zULATI7F6Kb0XdfRqkDKuL6rhuX8Ifh+4rcLzoO
         nH5Zb3dz7cguXnwRE6jw/LywrtmV6v7zY5Dhk16t7DkRE1xsOUAA34CmSOXhxsC5uO8B
         d25aqcX5UWWqQ/b2RL4ykSdpMPUsVsAOwSLne4/0n9/j5rtoASxG+TZMfX/No9QdLgr3
         D/Wg==
X-Gm-Message-State: ABuFfoj+/KgCuw98Ms/xtwpapHY6pVe8FU0kgzW7CvFxXmMDFEjj7vmQ
        dK0PUvN2/5oDpaw4xJ/7zOyjCoeAV1/DG2hP3D0=
X-Google-Smtp-Source: ACcGV61jSZpXMb8vKHvp1FHlMNetfXeFl8vett+TGEkY/qIdoEosjrg85G3NrwQTcfhXkLGbd6qq0guIpoBVmT5oZM4=
X-Received: by 2002:a9d:7303:: with SMTP id e3-v6mr2863225otk.124.1538642835775;
 Thu, 04 Oct 2018 01:47:15 -0700 (PDT)
MIME-Version: 1.0
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com> <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
In-Reply-To: <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 10:47:04 +0200
Message-ID: <CAJZ5v0i+TMAeaMp8D8qGph1VZKg0L23RsqdPMEQ0xHhpTCHgQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@android.com>,
        Ramesh Thomas <ramesh.thomas@intel.com>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Alex Shi <alex.shi@linaro.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 10:40 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 04/10/2018 10:22, Rafael J. Wysocki wrote:
> > On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

[cut]

> >> -               interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> >> +               interactivity_req = data->predicted_us /
> >> +                       performance_multiplier(nr_iowaiters);
> >
> > I wouldn't break this line.
>
> Ok, mind if I break the line in a separate patch before ? (my git
> pre-commit hook runs checkpatch and it complains and prevent to commit
> the patch because of the line length (94)).

OK, just keep it the way it is, then.  I can remove the line break
before applying the patch easily enough. :-)

> >>                 if (latency_req > interactivity_req)
> >>                         latency_req = interactivity_req;
> >>         }
> >> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> >> index 04f1321..f30954c 100644
> >> --- a/include/linux/sched/stat.h
> >> +++ b/include/linux/sched/stat.h
> >> @@ -20,7 +20,6 @@ extern unsigned long nr_running(void);
> >>  extern bool single_task_running(void);
> >>  extern unsigned long nr_iowait(void);
> >>  extern unsigned long nr_iowait_cpu(int cpu);
> >> -extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
> >>
> >>  static inline int sched_info_on(void)
> >>  {
> >> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> >> index b88a145..5605f03 100644
> >> --- a/kernel/sched/core.c
> >> +++ b/kernel/sched/core.c
> >> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
> >>
> >>         return sum;
> >>  }
> >> -/*
> >> - * Consumers of these two interfaces, like for example the cpufreq menu
> >> - * governor are using nonsensical data. Boosting frequency for a CPU that has
> >> - * IO-wait which might not even end up running the task when it does become
> >> - * runnable.
> >> - */
> >
> > Doesn't the comment still apply to nr_iowait_cpu()?
>
> The comment is very confusing. I talks about a cpufreq menu governor and
> boosting frequency.

So it should be talking about the *cpuidle* menu governor and
preferring shallow idle state selection.

I guess I'll send a patch to update it. :-)

> I don't see this function used in the cpufreq framework but in:
>
> kernel/time/tick-sched.c
> fs/proc/stat.c
> drivers/cpuidle/governors/menu.c
>
> The comment is irrelevant as the remaining function is used for
> statistics in addition to the perf multiplier. It does exactly what the
> function name is.

Which is my point.  It shouldn't be dropped entirely, but updated IMO.
