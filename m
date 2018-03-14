Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933037AbeCNB15 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 21:27:57 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36914 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932634AbeCNB1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 21:27:55 -0400
X-Google-Smtp-Source: AG47ELsZVo7H97sZPYsz/RNkgDdJ5+qabZ1r8vq6pPEPrwtsE1+rY5GijaBleLo2WnpH9SXYsGM8zKjAnyBs8P3vABQ=
MIME-Version: 1.0
In-Reply-To: <20180313111506.GC15832@vireshk-i7>
References: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com> <20180313111506.GC15832@vireshk-i7>
From: Joel Fernandes <joelaf@google.com>
Date: Tue, 13 Mar 2018 18:27:53 -0700
Message-ID: <CAJWu+orsBLQdjGJZKOnLP15M-aKboiDPVTQ2W+8tiHpgNLexMg@mail.gmail.com>
Subject: Re: [PATCH v4] cpufreq: schedutil: rate limits for SCHED_DEADLINE
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Claudio Scordino <claudio@evidence.eu.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2018 at 4:15 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 13-03-18, 11:35, Claudio Scordino wrote:
>> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
>> we should not wait for the rate limit, otherwise we may miss some
>> deadline.
>>
>> Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
>> shown reductions of even 10% of deadline misses with a negligible
>> increase of energy consumption (measured through Baylibre Cape).
>>
>> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> CC: Viresh Kumar <viresh.kumar@linaro.org>
>> CC: Patrick Bellasi <patrick.bellasi@arm.com>
>> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> CC: Morten Rasmussen <morten.rasmussen@arm.com>
>> CC: Juri Lelli <juri.lelli@redhat.com>
>> CC: Vincent Guittot <vincent.guittot@linaro.org>
>> CC: Todd Kjos <tkjos@android.com>
>> CC: Joel Fernandes <joelaf@google.com>
>> CC: linux-pm@vger.kernel.org
>> CC: linux-kernel@vger.kernel.org
>> ---
>> Changes from v3:
>>  - Specific routine renamed as ignore_dl_rate_limit()
>
> LGTM. Thanks.

Nice! Thanks.

- Joel
