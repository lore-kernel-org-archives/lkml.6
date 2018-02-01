Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751976AbeBAIZg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 03:25:36 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:55183 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751831AbeBAIZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 03:25:33 -0500
X-Google-Smtp-Source: AH8x227w2ZzLr9M+ltSEaRYPUEA6Ci1c4AYx3wCJntTwFxQjr0XteEOoKM+UFu4jeOGj1oZoltXq0w==
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Eduardo Valentin <edubezval@gmail.com>,
        Kevin Wangtao <kevin.wangtao@linaro.org>, Leo Yan <leo.yan@linaro.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <CAKfTPtD-cUYoAJfhtuTr-E1=rttZvWxVv1Qv7b+Si4vSBy0JVg@mail.gmail.com>
 <11334876-ef8c-58fa-5e32-ab8499eebd7e@linaro.org>
 <CAKfTPtBXcLHNHEObpttCGtfCWXmR+kwmOW5aD+G23bnYTJi6Yg@mail.gmail.com>
 <6e776e6c-6f1e-b33b-58b7-b95410ca1f95@linaro.org>
 <CAKfTPtAFNdOsNOBC8Qg3c=OB7P635gvePvfpDbc5QF10Tei-9Q@mail.gmail.com>
 <22f4c4fc-fd74-b635-6859-7e2f599695f7@linaro.org>
 <CAKfTPtCSWkXrmET9_6N-Nkt3+N-0deuT3j8E=mB=62ohzztmWw@mail.gmail.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <73836143-e335-f6a1-3c37-d3050dd7ddde@linaro.org>
Date: Thu, 1 Feb 2018 09:25:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCSWkXrmET9_6N-Nkt3+N-0deuT3j8E=mB=62ohzztmWw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/02/2018 08:57, Vincent Guittot wrote:
> On 31 January 2018 at 16:27, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> On 31/01/2018 10:56, Vincent Guittot wrote:
>>> On 31 January 2018 at 10:50, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>> On 31/01/2018 10:46, Vincent Guittot wrote:
>>>>> On 31 January 2018 at 10:33, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>>> On 31/01/2018 10:01, Vincent Guittot wrote:
>>>>>>> Hi Daniel,
>>>>>>>
>>>>>>> On 23 January 2018 at 16:34, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> [ ... ] (please trim :)
>>>>>>

[ ... ]

> struct cpuidle_cooling_device {
>          struct thermal_cooling_device *cdev;
>          struct cpumask *cpumask;
>          struct list_head node;
>          struct hrtimer timer;
>          struct kref kref;
>          atomic_t count;
>          unsigned int idle_cycle;
>          unsigned int state;
> };
> 
> struct cpuidle_cooling_cpu {
>         struct task_struct *tsk;
>         wait_queue_head_t waitq;
> };
> DECLARE_PER_CPU(struct cpuidle_cooling_cpu *, cpu_data);
> 
> You continue to have cpuidle_cooling_device allocated dynamically per
> cluster and added in the list but task and waitq are stored per cpu

Ok. I will try that.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
