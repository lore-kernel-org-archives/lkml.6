Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967670AbeEYSFC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:05:02 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:37670 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967452AbeEYSFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:05:01 -0400
Date: Fri, 25 May 2018 19:04:55 +0100
From: Patrick Bellasi <patrick.bellasi@arm.com>
To: Quentin Perret <quentin.perret@arm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v5 01/10] sched/pelt: Move pelt related code in a
 dedicated file
Message-ID: <20180525180455.GF30654@e110439-lin>
References: <1527253951-22709-1-git-send-email-vincent.guittot@linaro.org>
 <1527253951-22709-2-git-send-email-vincent.guittot@linaro.org>
 <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525142648.GC15173@e108498-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-May 15:26, Quentin Perret wrote:
> And also, I understand these functions are large, but if we _really_
> want to inline them even though they're big, why not putting them in
> sched-pelt.h ?

Had the same tought at first... but then I recalled that header is
generated from a script. Thus, eventually, it should be a different one.

> We probably wouldn't accept that for everything, but
> those PELT functions are used all over the place, including latency
> sensitive code paths (e.g. task wake-up).

We should better measure the overheads, if any, and check what
(a modern) compiler does. Maybe some hackbench run could help on the
first point.

> Thanks,
> Quentin

-- 
#include <best/regards.h>

Patrick Bellasi
