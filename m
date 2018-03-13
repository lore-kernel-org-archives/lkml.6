Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932947AbeCMLPM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 07:15:12 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40101 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932829AbeCMLPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 07:15:10 -0400
X-Google-Smtp-Source: AG47ELuZInGskF0CUVjgCKZcGOHTlsQG6BE7AzOUrF90+y7guQxtQ3zYfdJcT+dhBf0iwJ/dYSP6hg==
Date: Tue, 13 Mar 2018 16:45:06 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] cpufreq: schedutil: rate limits for SCHED_DEADLINE
Message-ID: <20180313111506.GC15832@vireshk-i7>
References: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520937340-2755-1-git-send-email-claudio@evidence.eu.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-03-18, 11:35, Claudio Scordino wrote:
> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> we should not wait for the rate limit, otherwise we may miss some
> deadline.
> 
> Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
> shown reductions of even 10% of deadline misses with a negligible
> increase of energy consumption (measured through Baylibre Cape).
> 
> Signed-off-by: Claudio Scordino <claudio@evidence.eu.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
> CC: Patrick Bellasi <patrick.bellasi@arm.com>
> CC: Dietmar Eggemann <dietmar.eggemann@arm.com>
> CC: Morten Rasmussen <morten.rasmussen@arm.com>
> CC: Juri Lelli <juri.lelli@redhat.com>
> CC: Vincent Guittot <vincent.guittot@linaro.org>
> CC: Todd Kjos <tkjos@android.com>
> CC: Joel Fernandes <joelaf@google.com>
> CC: linux-pm@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
> Changes from v3:
>  - Specific routine renamed as ignore_dl_rate_limit()

LGTM. Thanks.

-- 
viresh
