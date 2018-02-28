Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeB1LQA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 06:16:00 -0500
Received: from mail-wr0-f179.google.com ([209.85.128.179]:33986 "EHLO
        mail-wr0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752120AbeB1LP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 06:15:58 -0500
X-Google-Smtp-Source: AG47ELvAikmyMiLwsHPzSdY1lekCioGWZRyHSKMlG8dLhvEwRbPAejccX3kuj8YQ9Hmoh6brgWwRkw==
Subject: Re: [PATCH v2] cpufreq: schedutil: rate limits for SCHED_DEADLINE
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Todd Kjos <tkjos@android.com>, Joel Fernandes <joelaf@google.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519815970-5686-1-git-send-email-claudio@evidence.eu.com>
From: Claudio Scordino <claudio@evidence.eu.com>
Message-ID: <870e5cb6-bb3b-7d51-93b3-db4928f700b4@evidence.eu.com>
Date: Wed, 28 Feb 2018 12:15:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519815970-5686-1-git-send-email-claudio@evidence.eu.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Rafael, dear Viresh,

Il 28/02/2018 12:06, Claudio Scordino ha scritto:
> When the SCHED_DEADLINE scheduling class increases the CPU utilization,
> we should not wait for the rate limit, otherwise we may miss some
> deadline.
> 
> Tests using rt-app on Exynos5422 with up to 10 SCHED_DEADLINE tasks have
> shown reductions of even 10% of deadline misses with a negligible
> increase of energy consumption (measured through Baylibre Cape).

As a follow up of the previous thread, I've put some figures here: https://gist.github.com/claudioscordino/d4a10e8b3ceac419fb0c8b552db19806

In some cases, I've noticed the patch to even reduce the energy consumption (due to a mix of factors plus DL tasks entering the inactive state sooner).

I've also tried to create the "ramp-up" scenario by allocating 10 DL tasks on the same core, but it didn't produce any significant increase of consumption.

IMHO, the overall behavior looks better.

Best regards,

              Claudio
