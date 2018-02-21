Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937174AbeBUNsk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 08:48:40 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55008 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933544AbeBUNse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 08:48:34 -0500
Subject: Re: [PATCH v5 1/3] sched: Stop nohz stats when decayed
From: Valentin Schneider <valentin.schneider@arm.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@foss.arm.com>,
        Brendan Jackman <brendan.jackman@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <1518622006-16089-1-git-send-email-vincent.guittot@linaro.org>
 <1518622006-16089-2-git-send-email-vincent.guittot@linaro.org>
 <44a7d9dc-f6f3-e003-44d6-b0c4aa7dc046@arm.com>
 <CAKfTPtAbr2vUvw2DvVCuqCXNnSA-7LuO2EaJ59pP=oJTgQ3R_g@mail.gmail.com>
 <a351f2de-3a00-1cf8-b16f-59493c5b67f5@arm.com>
Message-ID: <f557c2fc-7175-33c1-16c3-839da6bf4702@arm.com>
Date: Wed, 21 Feb 2018 13:48:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a351f2de-3a00-1cf8-b16f-59493c5b67f5@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 01:13 PM, Valentin Schneider wrote:
> On 02/16/2018 01:44 PM, Vincent Guittot wrote:
>> On 16 February 2018 at 13:13, Valentin Schneider
>> <valentin.schneider@arm.com> wrote:
>>> On 02/14/2018 03:26 PM, Vincent Guittot wrote:
> BTW, with the current set on Peter's sched/testing, update_nohz_stats()
> is called here, which doesn't do the update if !rq->has_blocked_load
> (Although that check is done without lock/barrier, so maybe we could not see
> a CPU that just went idle ?)

Ignore that, that's another case of me being overly paranoid after reading
too much of Documentation/memory-barriers.txt 
