Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752494AbeDOMRA (ORCPT <rfc822;w@1wt.eu>);
        Sun, 15 Apr 2018 08:17:00 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36621 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbeDOMQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Apr 2018 08:16:59 -0400
X-Google-Smtp-Source: AIpwx4+bujQZF1Lv78XaKLrkEclQIJ2I0nk2/hHIwOfFop6jRiD6hf2A6dPSpKDI/3bj0sf+4sAbbEI/7ZLLQmP6RE8=
MIME-Version: 1.0
In-Reply-To: <95f22502-16e6-555c-fb61-e1a9e88f1163@arm.com>
References: <1521199541-15308-1-git-send-email-vincent.guittot@linaro.org>
 <1521199541-15308-2-git-send-email-vincent.guittot@linaro.org> <95f22502-16e6-555c-fb61-e1a9e88f1163@arm.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 15 Apr 2018 14:16:37 +0200
Message-ID: <CAKfTPtCp2Qy7pZoTQH-550pJ2DZqwR2aAzk0+2B5b8DOenU4uA@mail.gmail.com>
Subject: Re: [PATCH 1/4 v4] sched/pelt: Move pelt related code in a dedicated file
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, rjw@rjwysocki.net,
        Juri Lelli <juri.lelli@redhat.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        viresh kumar <viresh.kumar@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 April 2018 at 13:58, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> On 03/16/2018 12:25 PM, Vincent Guittot wrote:
>>
>> We want to track rt_rq's utilization as a part of the estimation of the
>> whole rq's utilization. This is necessary because rt tasks can steal
>> utilization to cfs tasks and make them lighter than they are.
>> As we want to use the same load tracking mecanism for both and prevent
>> useless dependency between cfs and rt code, pelt code is moved in a
>> dedicated file.
>
>
> This would mean that we introduce function calls into the cfs scheduler
> fast-path, something we avoided so far (e.g. the cpu and frequency
> invariance hooks). Are we OK with that?
>
> Quentin mentioned this already during v3 review back in December.

Yes and I hadn't seen any differences in the code size with the patch
which should have been the case if inline function where replaced by
function call


>
> [...]
