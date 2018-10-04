Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9CCC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A132082A
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:23:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93A132082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727832AbeJDWRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:17:09 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42433 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbeJDWRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:17:09 -0400
Received: by mail-oi1-f195.google.com with SMTP id w81-v6so7776721oiw.9;
        Thu, 04 Oct 2018 08:23:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mp+d3p3Qaiy4p0fwsgLjGJ7jJKkFuv2/hI5GI6eUl1s=;
        b=OFTtM7mNHx6zHAZJDBO1sPgvMoiOhve7Br3Xq02WhwkKI9U0/La8F7JxPwyXfgBjWm
         RyKp+M9Jv7ZfVqCkg4z5DsBB+F83hcXDVd3ipnhBcHrzqyPZJbyREY9L9LWYg+Rsj/R2
         CWLaKB5nFJJRDW2d0/y/uoXomA5BtzcDq5H+rU1CDAJsT7f3ROgqf/Rf81CzyLiWTktu
         XeG2TNo2DaquMKClCOpTrM3sPhxWlpj/2zr1NYXxdNRyeNunqR6nKdsqKsR0Yp/bUhKP
         GMVMN4pl5ALnZBodLNQSTZDuPn88kCKjcHw74PxaoKO+psfv+cUUJlRTpfvhARHph7fL
         Q6xQ==
X-Gm-Message-State: ABuFfohW78weMAu7AQpvfhoF2PAcMpyXAA0UVGEc+8/U6JyBwJPxVT4x
        VD+kfT69UDex/4ohLNAOw3f9uNUXvBoki1PK7IU=
X-Google-Smtp-Source: ACcGV637OsI5oQyTLrLbBOL14Qq9o4HJWIi3LFWcfUCZlEW/pxjjKArbQn14vJoXsKYeCYKmIt2ZNt18W5bsCrahD7Y=
X-Received: by 2002:aca:b157:: with SMTP id a84-v6mr3120907oif.289.1538666602947;
 Thu, 04 Oct 2018 08:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <1538654644-32705-1-git-send-email-daniel.lezcano@linaro.org> <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
In-Reply-To: <1538654644-32705-2-git-send-email-daniel.lezcano@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 4 Oct 2018 17:23:11 +0200
Message-ID: <CAJZ5v0hKybawJTfmSNp=Hargq4QHhtJ-_mkzVLVJXxYwiMDnAQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
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
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 2:04 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The function get_loadavg() returns almost always zero. To be more
> precise, statistically speaking for a total of 1023379 times passing
> in the function, the load is equal to zero 1020728 times, greater than
> 100, 610 times, the remaining is between 0 and 5.
>
> In 2011, the get_loadavg() was removed from the Android tree because
> of the above [1]. At this time, the load was:
>
> unsigned long this_cpu_load(void)
> {
>         struct rq *this = this_rq();
>         return this->cpu_load[0];
> }
>
> In 2014, the code was changed by commit 372ba8cb46b2 (cpuidle: menu: Lookup CPU
> runqueues less) and the load is:
>
> void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> {
>         struct rq *rq = this_rq();
>         *nr_waiters = atomic_read(&rq->nr_iowait);
>         *load = rq->load.weight;
> }
>
> with the same result.
>
> Both measurements show using the load in this code path does no matter
> anymore. Removing it.
>
> [1] https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Todd Kjos <tkjos@google.com>
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Colin Cross <ccross@android.com>
> Cc: Ramesh Thomas <ramesh.thomas@intel.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/cpuidle/governors/menu.c | 26 +++++++-------------------
>  include/linux/sched/stat.h       |  1 -
>  kernel/sched/core.c              |  7 -------
>  3 files changed, 7 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
> index e26a409..066b01f 100644
> --- a/drivers/cpuidle/governors/menu.c
> +++ b/drivers/cpuidle/governors/menu.c
> @@ -135,11 +135,6 @@ struct menu_device {
>  #define LOAD_INT(x) ((x) >> FSHIFT)
>  #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
>
> -static inline int get_loadavg(unsigned long load)
> -{
> -       return LOAD_INT(load) * 10 + LOAD_FRAC(load) / 10;
> -}
> -
>  static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters)
>  {
>         int bucket = 0;
> @@ -173,18 +168,10 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
>   * to be, the higher this multiplier, and thus the higher
>   * the barrier to go to an expensive C state.
>   */
> -static inline int performance_multiplier(unsigned long nr_iowaiters, unsigned long load)
> +static inline int performance_multiplier(unsigned long nr_iowaiters)
>  {
> -       int mult = 1;
> -
> -       /* for higher loadavg, we are more reluctant */
> -
> -       mult += 2 * get_loadavg(load);
> -
> -       /* for IO wait tasks (per cpu!) we add 5x each */
> -       mult += 10 * nr_iowaiters;
> -
> -       return mult;
> +       /* for IO wait tasks (per cpu!) we add 10x each */
> +       return 1 + 10 * nr_iowaiters;
>  }
>
>  static DEFINE_PER_CPU(struct menu_device, menu_devices);
> @@ -290,7 +277,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         int idx;
>         unsigned int interactivity_req;
>         unsigned int expected_interval;
> -       unsigned long nr_iowaiters, cpu_load;
> +       unsigned long nr_iowaiters;
>         ktime_t delta_next;
>
>         if (data->needs_update) {
> @@ -307,7 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>         /* determine the expected residency time, round up */
>         data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
>
> -       get_iowait_load(&nr_iowaiters, &cpu_load);
> +       nr_iowaiters = nr_iowait_cpu(dev->cpu);
>         data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
>
>         /*
> @@ -359,7 +346,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>                  * Use the performance multiplier and the user-configurable
>                  * latency_req to determine the maximum exit latency.
>                  */
> -               interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
> +               interactivity_req = data->predicted_us /
> +                       performance_multiplier(nr_iowaiters);
>                 if (latency_req > interactivity_req)
>                         latency_req = interactivity_req;
>         }
> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
> index 04f1321..f30954c 100644
> --- a/include/linux/sched/stat.h
> +++ b/include/linux/sched/stat.h
> @@ -20,7 +20,6 @@ extern unsigned long nr_running(void);
>  extern bool single_task_running(void);
>  extern unsigned long nr_iowait(void);
>  extern unsigned long nr_iowait_cpu(int cpu);
> -extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
>
>  static inline int sched_info_on(void)
>  {
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 43efb74..48a786a 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2886,13 +2886,6 @@ unsigned long nr_iowait_cpu(int cpu)
>         return atomic_read(&cpu_rq(cpu)->nr_iowait);
>  }
>
> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
> -{
> -       struct rq *rq = this_rq();
> -       *nr_waiters = atomic_read(&rq->nr_iowait);
> -       *load = rq->load.weight;
> -}
> -
>  /*
>   * IO-wait accounting, and how its mostly bollocks (on SMP).
>   *
> --
> 2.7.4
>
