Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933121AbeEHIWu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 04:22:50 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:37110 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932921AbeEHIWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 04:22:46 -0400
X-Google-Smtp-Source: AB8JxZpY1YydIt/LnWDRWis5R5jOC23DbEOzd8jY7h2I62UxSKALpqdQ6upErKBLOQBvuiIZKYjaSw==
Date: Tue, 8 May 2018 13:52:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, linux-pm@vger.kernel.org,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH] Revert "cpufreq: schedutil: Don't restrict kthread to
 related_cpus unnecessarily"
Message-ID: <20180508082242.bre6sjfvefhz6xc3@vireshk-i7>
References: <20180508073340.13114-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508073340.13114-1-dietmar.eggemann@arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-05-18, 08:33, Dietmar Eggemann wrote:
> This reverts commit e2cabe48c20efb174ce0c01190f8b9c5f3ea1d13.
> 
> Lifting the restriction that the sugov kthread is bound to the
> policy->related_cpus for a system with a slow switching cpufreq driver,
> which is able to perform DVFS from any cpu (e.g. cpufreq-dt), is not
> only not beneficial it also harms Enery-Aware Scheduling (EAS) on
> systems with asymmetric cpu capacities (e.g. Arm big.LITTLE).
> 
> The sugov kthread which does the update for the little cpus could
> potentially run on a big cpu. It could prevent that the big cluster goes
> into deeper idle states although all the tasks are running on the little
> cluster.

I think the original patch did the right thing, but that doesn't suit
everybody as you explained.

I wouldn't really revert the patch but fix my platform's cpufreq
driver to set dvfs_possible_from_any_cpu = false, so that other
platforms can still benefit from the original commit.

-- 
viresh
