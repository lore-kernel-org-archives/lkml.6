Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752126AbeDYJDh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 05:03:37 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33511 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbeDYJDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 05:03:30 -0400
X-Google-Smtp-Source: AIpwx48BL1vKoMJ+nDs5AoF2OxQnMA0GxbX+dpX1zNRPwubD5yPVYd1yBYp3tbFejV1yuftOZCye8w==
Date: Wed, 25 Apr 2018 14:33:27 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, c@hirez.programming.kicks-ass.net
Subject: Re: [PATCH] sched/fair: Rearrange select_task_rq_fair() to optimize
 it
Message-ID: <20180425090327.7mwm2pdheeptz6sd@vireshk-i7>
References: <8a34a16da90b9f83ffe60316a074a5e4d05b59b0.1524479666.git.viresh.kumar@linaro.org>
 <434fa179-7c8f-8a01-a07a-4527521a04c7@arm.com>
 <20180424104304.GE4064@hirez.programming.kicks-ass.net>
 <0985e709-0d71-2c08-20a9-7bfb618fb5f2@arm.com>
 <20180424123523.GF4064@hirez.programming.kicks-ass.net>
 <20180425051509.aohopadqw7q5urbd@vireshk-i7>
 <20180425081334.GF14391@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425081334.GF14391@e108498-lin.cambridge.arm.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-04-18, 09:13, Quentin Perret wrote:
> While you're at it, you could probably remove the one in wake_cap() ? I
> think having just one in select_task_rq_fair() should be enough.

Just make it clear, you are asking me to remove sync_entity_load_avg()
in wake_cap() ? But aren't we required to do that, as in the very next
line we call task_util(p) ?

-- 
viresh
