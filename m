Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBHQPD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:15:03 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:39990 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeBHQPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:15:01 -0500
X-Google-Smtp-Source: AH8x227U7uwB/qidSco1PBDbHP+tTY93o9gDyfoiBz+gXtXxVH0ItvaSJ9IDVJUkV6kasoZUWKeHlQ==
Subject: Re: [PATCH v3 0/6] cpufreq: schedutil: fixes for flags updates
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Todd Kjos <tkjos@android.com>,
        Joel Fernandes <joelaf@google.com>
References: <20171130114723.29210-1-patrick.bellasi@arm.com>
 <20171220153029.dqrtjbyowhqdl56r@hirez.programming.kicks-ass.net>
 <f574036c-7572-9b97-79a0-794ff48e4d49@evidence.eu.com>
 <20180206154319.GF5739@e110439-lin>
 <68afaf84-893e-6770-b9f1-619cd2b6dc9c@evidence.eu.com>
 <20180206183623.GH5739@e110439-lin>
From: Claudio Scordino <claudio@evidence.eu.com>
Message-ID: <574fa064-3551-27e8-5abf-bd625ba928de@evidence.eu.com>
Date: Thu, 8 Feb 2018 17:14:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180206183623.GH5739@e110439-lin>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it-IT
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

Il 06/02/2018 19:36, Patrick Bellasi ha scritto:
> On 06-Feb 19:14, Claudio Scordino wrote:
>> Hi Patrick,
> 
>>> At first glance, your proposal below makes to make sense.
>>>
>>> However, I'm wondering if we cannot get it working using
>>> rq->dl's provided information instead of flags?
>>
>> Yes, we can use the value of rq->dl to check if there has been an increase of the deadline utilization.
>> Even if schedutil might have been triggered by a different scheduling class, the effect should be almost the same.
>>
>> Below a potential patch. I've kept all frequency update decisions in a single point (i.e. sugov_should_update_freq).
>> Not yet tested (waiting for further comments).
> 
> I have a todo list entry to backport/test Peter's series on Android...
> will add this patch too. Thanks.

Please discard my latest patch, as the tests on Odroid have shown performance regressions
(likely due to sugov_next_freq_shared being called more often)

Never mind. I have already tested another (even simpler) patch.
Sending soon as a new thread on LKML.

Many thanks and best regards,

                 Claudio
