Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751098AbeBIJlG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:41:06 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37422 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbeBIJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:41:03 -0500
X-Google-Smtp-Source: AH8x226E+/i88Tj+4vl1E0dVj3GKv11hWE6c/owrUAx/FVsYUGh6jsjmVe7RuiP9RY8sDQahO20+xA==
Date: Fri, 9 Feb 2018 15:11:00 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, amit.kachhap@gmail.com,
        linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Javi Merino <javi.merino@kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 5/8] thermal/drivers/cpu_cooling: Introduce the cpu idle
 cooling driver
Message-ID: <20180209094100.GM28462@vireshk-i7>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
 <1516721671-16360-6-git-send-email-daniel.lezcano@linaro.org>
 <20180207091231.GQ28462@vireshk-i7>
 <54759b82-29e9-f376-bbe8-dcf683ed0cce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54759b82-29e9-f376-bbe8-dcf683ed0cce@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-02-18, 11:34, Daniel Lezcano wrote:
> On 07/02/2018 10:12, Viresh Kumar wrote:
> > What about cpuidle_cooling_unregister() ?
> 
> The unregister function is not needed because cpuidle can't be unloaded.
> The cpuidle cooling device is registered after the cpuidle successfully
> initialized itself, there is no error path.

Okay, then there are two more things here.

First, you don't need a kref in your patch and simple counter should
be used instead, as kref is obviously more heavy to be used for the
single error path here.

Secondly, what about CPU hotplug ? For example, the cpu-freq cooling
device gets removed currently if all CPUs of a cluster are
hotplugged-out. But with your code, even if the CPUs are gone, their
cpu-idle cooling device will stay.

-- 
viresh
