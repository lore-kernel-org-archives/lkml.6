Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbeBFE3E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 23:29:04 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:41725 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752132AbeBFE2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 23:28:55 -0500
X-Google-Smtp-Source: AH8x226DHaVVFBCYlVSVB2M9lR0yMcjfhGGyfJqxSkputyzI/Ucw1kWDrMjupY0LVdkRnUf4fyw8oA==
Date: Tue, 6 Feb 2018 09:58:53 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        daniel.thompson@linaro.org
Subject: Re: [PATCH 8/8] thermal/drivers/cpu_cooling: Add the combo cpu
 cooling device
Message-ID: <20180206042853.GI28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-9-git-send-email-daniel.lezcano@linaro.org>
 <20180202104259.GA28462@vireshk-i7>
 <8dadd854-25ac-68aa-aa9f-33ba76a137a4@linaro.org>
 <20180205041734.GD28462@vireshk-i7>
 <911804cd-2f1d-a1f7-61a2-6c8b95a88d6b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <911804cd-2f1d-a1f7-61a2-6c8b95a88d6b@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-02-18, 11:32, Daniel Lezcano wrote:
> On 05/02/2018 05:17, Viresh Kumar wrote:
> > Right, but I thought the cooling-maps can help us specify different cooling
> > states for different cooling devices for the same trip point. Maybe my
> > understanding of that is incorrect.

Any inputs on this? I am still wondering if this can be done.

> At the first glance, it sounds interesting but I'm afraid that raises
> more corner-cases than it solves because we have to take into account
> all the combinations: cpuidle=0 && cpufreq=1, cpuidle=1 && cpufreq=0,
> cpuidle=1 && cpufreq=1 with dynamic code changes when the cpufreq driver
> is loaded/unloaded.
> 
> I'm not against this approach as well as merging all the cpu cooling
> devices into a single one but that won't be trivial and will need
> several iterations before reaching this level of features.
> 
> IMO, we should keep the current approach (but handle the cpufreq
> loading/unloading) and then iteratively merge all the cooling device
> into a single one with policy change at runtime which will automatically
> handle the cpufreq load/unload.

Surely we can do one thing at a time if that's the way we choose to do it.

-- 
viresh
