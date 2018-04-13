Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754307AbeDMLqO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:46:14 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:53460 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753126AbeDMLqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:46:12 -0400
X-Google-Smtp-Source: AIpwx49gYxxaToYoSLwttR4e4lnmWyhK43W0X6a3RpALpqfaSEuGau2PakuCVtwMfv3Y6YE9mZj9Pg==
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: viresh.kumar@linaro.org, edubezval@gmail.com, kevin.wangtao@linaro.org,
        leo.yan@linaro.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, javi.merino@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <20180413113848.xj7hg7gsbxpxekbo@holly.lan>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <aa059103-c404-0dc2-f332-e2ea7ddb1c5e@linaro.org>
Date: Fri, 13 Apr 2018 13:46:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180413113848.xj7hg7gsbxpxekbo@holly.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/2018 13:38, Daniel Thompson wrote:

[ ... ]

>> +		/*
>> +		 * Allocate the cpuidle cooling device with the list
>> +		 * of the cpus belonging to the cluster.
>> +		 */
>> +		idle_cdev = cpuidle_cooling_alloc(topology_core_cpumask(cpu));
>> +		if (!idle_cdev)
>> +			goto out;
> 
> Perhaps nitpicking but it might be better to set ret to -ENOMEM here 
> and avoid initializing it during the declarations.
> 
> There's no bug in the current form since ret is never assigned to
> outside of the error paths, but the unwritten assumption that ret keeps
> its original value throughout the loop seems like a bit of a landmine
> w.r.t. future maintainance.

Agree.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
