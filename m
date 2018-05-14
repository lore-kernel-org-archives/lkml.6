Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752165AbeENJVQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 05:21:16 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:38711 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751954AbeENJVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 05:21:14 -0400
X-Google-Smtp-Source: AB8JxZoYC3YQBDvszxYcDlQHmPZMaHuUNNDMj0o24AWptl3pbGJ8i/SOrInjYYtWPzDRXl01nRkLdVP7q5n+t8aOAZI=
MIME-Version: 1.0
In-Reply-To: <20180511131509.16275-3-patrick.bellasi@arm.com>
References: <20180511131509.16275-1-patrick.bellasi@arm.com> <20180511131509.16275-3-patrick.bellasi@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Mon, 14 May 2018 11:20:53 +0200
Message-ID: <CAKfTPtB_qJn5erf6oqtu9sMS045keTz5Y0VKRifdThMfUGtXpg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] sched/fair: util_est: update before schedutil
To: Patrick Bellasi <patrick.bellasi@arm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>, Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Patrick,

On 11 May 2018 at 15:15, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> When a task is enqueue the estimated utilization of a CPU is updated
> to better support the selection of the required frequency.
> However, schedutil is (implicitly) updated by update_load_avg() which
> always happens before util_est_{en,de}queue(), thus potentially
> introducing a latency between estimated utilization updates and
> frequency selections.
>
> Let's update util_est at the beginning of enqueue_task_fair(),
> which will ensure that all schedutil updates will see the most
> updated estimated utilization value for a CPU.
>
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

>
> ---
>
> Changes in v2:
>  - improve comment in enqueue_task_fair() (Peter)
>  - add "Fixes" tag
>  - add "Acked-by" Viresh tag
> ---
