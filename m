Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qm0rNzw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 656DD60555
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeFFNmQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:42:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37615 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751409AbeFFNmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:42:11 -0400
X-Google-Smtp-Source: ADUXVKIiLmwvZWPoxiDWYx/E8sUN3z7EAcpAxRXbHkQkHvZvBoZQAzQLPzCuaVwTUxvE8iOnGNq9Yw==
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Peter Zijlstra <peterz@infradead.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180606122357.GN12258@hirez.programming.kicks-ass.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
Date: Wed, 6 Jun 2018 15:42:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606122357.GN12258@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 14:23, Peter Zijlstra wrote:
> On Tue, Jun 05, 2018 at 11:16:40AM +0200, Daniel Lezcano wrote:
>> +	atomic_t idle_duration_ms;
>> +	atomic_t run_duration_ms;
> 
>> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
> 
>> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
> 
>> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
>> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
> 
>> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
> 
>> +	if (!atomic_read(&ii_dev->idle_duration_ms))
> 
>> +	if (!atomic_read(&ii_dev->run_duration_ms))
> 
> What is the point of atomic_t here ?!

idle_duration and run_duration can be changed from different places at
the same time. The atomic is here to ensure the read/write are consistent.

Do you think it is pointless ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
