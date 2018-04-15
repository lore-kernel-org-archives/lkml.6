Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeDOL6W (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 07:58:22 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:52038 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751948AbeDOL6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 07:58:21 -0400
Subject: Re: [PATCH 1/4 v4] sched/pelt: Move pelt related code in a dedicated
 file
To: Vincent Guittot <vincent.guittot@linaro.org>, peterz@infradead.org,
        mingo@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net
Cc: juri.lelli@redhat.com, Morten.Rasmussen@arm.com,
        viresh.kumar@linaro.org, valentin.schneider@arm.com
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
 <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <95f22502-16e6-555c-fb61-e1a9e88f1163@arm.com>
Date: Sun, 15 Apr 2018 13:58:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/16/2018 12:25 PM, Vincent Guittot wrote:
> We want to track rt_rq's utilization as a part of the estimation of the
> whole rq's utilization. This is necessary because rt tasks can steal
> utilization to cfs tasks and make them lighter than they are.
> As we want to use the same load tracking mecanism for both and prevent
> useless dependency between cfs and rt code, pelt code is moved in a
> dedicated file.

This would mean that we introduce function calls into the cfs scheduler 
fast-path, something we avoided so far (e.g. the cpu and frequency 
invariance hooks). Are we OK with that?

Quentin mentioned this already during v3 review back in December.

[...]
