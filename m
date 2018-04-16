Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754140AbeDPKDn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:03:43 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43555 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeDPKDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:03:39 -0400
X-Google-Smtp-Source: AIpwx4/tHyfg2m9H1wyzzalI25DZc5CNCcuIbSd5OPcTExWXzfe2vVC2kvMyB5pPU3hL/qzGzrYYhg==
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
 <20180416093747.GB4244@vireshk-i7>
 <4abf0d97-d2b8-46ab-3c05-4a11510ac3fe@linaro.org>
 <20180416095006.GC4244@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b0e7ff16-c947-89a0-6bd9-56ee9a76e7ad@linaro.org>
Date: Mon, 16 Apr 2018 12:03:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180416095006.GC4244@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/04/2018 11:50, Viresh Kumar wrote:
> On 16-04-18, 11:45, Daniel Lezcano wrote:
>> Can you elaborate a bit ? I'm not sure to get the point.
> 
> Sure. With your current code on Hikey960 (big/LITTLE), you end up
> creating two cooling devices, one for the big cluster and one for
> small cluster. Which is the right thing to do, as we also have two
> cpufreq cooling devices.
> 
> But with the change Sudeep is referring to, the helper you used to get
> cluster id will return 0 (SoC id) for all the 8 CPUs. So your code
> will end up creating a single cpuidle cooling device for all the CPUs.
> Which would be wrong.

Is the semantic of topology_physical_package_id changing ? I don't
understand the change Sudeep is referring to.

I saw this attempt:

https://patchwork.kernel.org/patch/9959977/

>> BTW, Am I asked to change my code to stick to something which is not
>> merged ?
> 
> Sudeep looked pretty confident on how the meaning of this routine is
> going to change very soon. I will let him respond on what guarantees
> we have that it will get merged :)



-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
