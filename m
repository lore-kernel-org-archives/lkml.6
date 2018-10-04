Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F35C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFD2D21477
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 08:40:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxP2QF4b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD2D21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJDPca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 11:32:30 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34703 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeJDPca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 11:32:30 -0400
Received: by mail-wm1-f66.google.com with SMTP id z25-v6so1030312wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9hMLTU7lM5QN9poKME/xB6QqMGzYiGK8o745Es5Wha4=;
        b=YxP2QF4bPdPHZhFoXrhmLR69T3Kd9nXc5AqUJkSIZxCBbG4H3iEim7SbayL9kGkcKt
         ejog1X8QuXJ7HFrP7j7F/ef2zrIWWumZZAx6s/i/R0JtzJQivE4Znq9hiWB/I48r7wx6
         xuSH6YEcCHBjXuDeaFBbkuWu18kvk+gohcBoA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9hMLTU7lM5QN9poKME/xB6QqMGzYiGK8o745Es5Wha4=;
        b=FdXfhWsujnxIdF6kNQUVWafSOBv+TbapBftgds3ypjEnB67KgAD7BkMDJOV11FPzR0
         gaMNrWKfmdCXiB/5KxyewHO9WlY5IPTTnXodaUTpolovEelR+KNZbQiP8F1HCHJAtiPS
         01pXJBrWj+BpwM23THn/0e4ZDKMiB+ELHt5DoCN18bpGVKXKhiHY34887cpC8uwRJv6i
         HN+vR4hXs3I2oflWqEGSdZVmHIJYBF6Yy6WlCymrHusitnrtKRpMG5Y33zhy64EM8pC0
         saVX3pqUPdzEuGbCCPPblyvyNr1yNCL12NSDhQSfoifSXXjoO1BR26661LWGDHa3Dtow
         Akeg==
X-Gm-Message-State: ABuFfogNFzidCplHU6gGezBc+LUp7q2E1thI86Ia3T8BGl8tDKHZKOIz
        VsRByZoUx/E/xFyaLDIGVfPUKMIpVFs=
X-Google-Smtp-Source: ACcGV62LllQc3d22Fw3wb5jpVnAhrUEfhDCdONLeuFAixuBE5DEv20ULPtrNghdeQ71WyglhlfQguA==
X-Received: by 2002:a1c:f016:: with SMTP id a22-v6mr3837270wmb.76.1538642418011;
        Thu, 04 Oct 2018 01:40:18 -0700 (PDT)
Received: from [192.168.0.40] (225.182.88.92.rev.sfr.net. [92.88.182.225])
        by smtp.googlemail.com with ESMTPSA id a5-v6sm4102080wmh.8.2018.10.04.01.40.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Oct 2018 01:40:17 -0700 (PDT)
Subject: Re: [PATCH 2/2] cpuidle/drivers/menu: Remove get_loadavg in the
 performance multiplier
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
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
References: <1538638927-26846-1-git-send-email-daniel.lezcano@linaro.org>
 <1538638927-26846-2-git-send-email-daniel.lezcano@linaro.org>
 <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4541426c-8c73-7fe6-b3b6-9707861564ce@linaro.org>
Date:   Thu, 4 Oct 2018 10:40:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0iLAtfo0w=BE-G+YW1WAxXsAdveiRvNhBSkpVPsd+TC9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 10:22, Rafael J. Wysocki wrote:
> On Thu, Oct 4, 2018 at 9:42 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> The function get_loadavg() returns almost always zero. To be more
>> precise, statistically speaking for a total of 1023379 times passing
>> in the function, the load is equal to zero 1020728 times, greater than
>> 100, 610 times, the remaining is between 0 and 5.
>>
>> In 2011, the get_loadavg() was removed from the Android tree because
>> of the above [1]. At this time, the load was:
>>
>> unsigned long this_cpu_load(void)
>> {
>>         struct rq *this = this_rq();
>>         return this->cpu_load[0];
>> }
>>
>> In 2014, the code was changed by commit 372ba8cb46b2 (cpuidle: menu: Lookup CPU
>> runqueues less) and the load is:
>>
>> void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
>> {
>>         struct rq *rq = this_rq();
>>         *nr_waiters = atomic_read(&rq->nr_iowait);
>>         *load = rq->load.weight;
>> }
>>
>> with the same result.
>>
>> Both measurements show using the load in this code path does no matter
>> anymore. Removing it.
>>
>> [1] https://android.googlesource.com/kernel/common/+/4dedd9f124703207895777ac6e91dacde0f7cc17
>>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Joel Fernandes <joelaf@google.com>
>> Cc: Colin Cross <ccross@android.com>
>> Cc: Ramesh Thomas <ramesh.thomas@intel.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  drivers/cpuidle/governors/menu.c | 26 +++++++-------------------
>>  include/linux/sched/stat.h       |  1 -
>>  kernel/sched/core.c              | 13 -------------
>>  3 files changed, 7 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>> index e26a409..066b01f 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -135,11 +135,6 @@ struct menu_device {
>>  #define LOAD_INT(x) ((x) >> FSHIFT)
>>  #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
>>
>> -static inline int get_loadavg(unsigned long load)
>> -{
>> -       return LOAD_INT(load) * 10 + LOAD_FRAC(load) / 10;
>> -}
>> -
>>  static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters)
>>  {
>>         int bucket = 0;
>> @@ -173,18 +168,10 @@ static inline int which_bucket(unsigned int duration, unsigned long nr_iowaiters
>>   * to be, the higher this multiplier, and thus the higher
>>   * the barrier to go to an expensive C state.
>>   */
>> -static inline int performance_multiplier(unsigned long nr_iowaiters, unsigned long load)
>> +static inline int performance_multiplier(unsigned long nr_iowaiters)
>>  {
>> -       int mult = 1;
>> -
>> -       /* for higher loadavg, we are more reluctant */
>> -
>> -       mult += 2 * get_loadavg(load);
>> -
>> -       /* for IO wait tasks (per cpu!) we add 5x each */
>> -       mult += 10 * nr_iowaiters;
>> -
>> -       return mult;
>> +       /* for IO wait tasks (per cpu!) we add 10x each */
>> +       return 1 + 10 * nr_iowaiters;
>>  }
>>
>>  static DEFINE_PER_CPU(struct menu_device, menu_devices);
>> @@ -290,7 +277,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>         int idx;
>>         unsigned int interactivity_req;
>>         unsigned int expected_interval;
>> -       unsigned long nr_iowaiters, cpu_load;
>> +       unsigned long nr_iowaiters;
>>         ktime_t delta_next;
>>
>>         if (data->needs_update) {
>> @@ -307,7 +294,7 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>         /* determine the expected residency time, round up */
>>         data->next_timer_us = ktime_to_us(tick_nohz_get_sleep_length(&delta_next));
>>
>> -       get_iowait_load(&nr_iowaiters, &cpu_load);
>> +       nr_iowaiters = nr_iowait_cpu(dev->cpu);
>>         data->bucket = which_bucket(data->next_timer_us, nr_iowaiters);
>>
>>         /*
>> @@ -359,7 +346,8 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>                  * Use the performance multiplier and the user-configurable
>>                  * latency_req to determine the maximum exit latency.
>>                  */
>> -               interactivity_req = data->predicted_us / performance_multiplier(nr_iowaiters, cpu_load);
>> +               interactivity_req = data->predicted_us /
>> +                       performance_multiplier(nr_iowaiters);
> 
> I wouldn't break this line.

Ok, mind if I break the line in a separate patch before ? (my git
pre-commit hook runs checkpatch and it complains and prevent to commit
the patch because of the line length (94)).

>>                 if (latency_req > interactivity_req)
>>                         latency_req = interactivity_req;
>>         }
>> diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
>> index 04f1321..f30954c 100644
>> --- a/include/linux/sched/stat.h
>> +++ b/include/linux/sched/stat.h
>> @@ -20,7 +20,6 @@ extern unsigned long nr_running(void);
>>  extern bool single_task_running(void);
>>  extern unsigned long nr_iowait(void);
>>  extern unsigned long nr_iowait_cpu(int cpu);
>> -extern void get_iowait_load(unsigned long *nr_waiters, unsigned long *load);
>>
>>  static inline int sched_info_on(void)
>>  {
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index b88a145..5605f03 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -2873,25 +2873,12 @@ unsigned long long nr_context_switches(void)
>>
>>         return sum;
>>  }
>> -/*
>> - * Consumers of these two interfaces, like for example the cpufreq menu
>> - * governor are using nonsensical data. Boosting frequency for a CPU that has
>> - * IO-wait which might not even end up running the task when it does become
>> - * runnable.
>> - */
> 
> Doesn't the comment still apply to nr_iowait_cpu()?

The comment is very confusing. I talks about a cpufreq menu governor and
boosting frequency. I don't see this function used in the cpufreq
framework but in:

kernel/time/tick-sched.c
fs/proc/stat.c
drivers/cpuidle/governors/menu.c

The comment is irrelevant as the remaining function is used for
statistics in addition to the perf multiplier. It does exactly what the
function name is.

>>  unsigned long nr_iowait_cpu(int cpu)
>>  {
>>         return atomic_read(&cpu_rq(cpu)->nr_iowait);
>>  }
>>
>> -void get_iowait_load(unsigned long *nr_waiters, unsigned long *load)
>> -{
>> -       struct rq *rq = this_rq();
>> -       *nr_waiters = atomic_read(&rq->nr_iowait);
>> -       *load = rq->load.weight;
>> -}
>> -
>>  /*
>>   * IO-wait accounting, and how its mostly bollocks (on SMP).
>>   *
>> --


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

