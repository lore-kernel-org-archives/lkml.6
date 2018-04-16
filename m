Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754656AbeDPJhw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:37:52 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:37406 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753224AbeDPJhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:37:50 -0400
X-Google-Smtp-Source: AIpwx4+wvnAuVM0Go0XYWPFET+kAwD6opNvaDlbj4inf75mp6tiL+fwwcFK6OLYK+uHZbu/UzHW++A==
Date: Mon, 16 Apr 2018 15:07:47 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, leo.yan@linaro.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>
Subject: Re: [PATCH v3 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
Message-ID: <20180416093747.GB4244@vireshk-i7>
References: <1522945005-7165-1-git-send-email-daniel.lezcano@linaro.org>
 <1522945005-7165-7-git-send-email-daniel.lezcano@linaro.org>
 <3f3b3b7a-3b74-aee2-2fac-f2759babe3f0@arm.com>
 <939f7943-feec-aaa2-3bd3-59a6618330c0@linaro.org>
 <20180416073729.GA4244@vireshk-i7>
 <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a3164f9-4738-e24e-6ed0-2c75024c304c@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-04-18, 09:44, Daniel Lezcano wrote:
> Because we rely on the number to identify the cluster and flag it
> 'processed'. The number itself is not important.

It is, because you are creating multiple groups (like cpufreq
policies) right now based on cluster id. Which will be zero for all
the CPUs. So in a big little system we will have two cpufreq cooling
devices and one cpuidle cooling device.

-- 
viresh
