Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeC0LKM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:10:12 -0400
Received: from mail-wr0-f172.google.com ([209.85.128.172]:33803 "EHLO
        mail-wr0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750881AbeC0LKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:10:10 -0400
X-Google-Smtp-Source: AG47ELu3zsx3dJMToCS/JjfC8q89rxUl5KF/Tuulpp+0ByPQVCJSQVUr8w2wH2Rhih4TPt4XvHoWWw==
Subject: Re: [PATCH V2 6/7] thermal/drivers/cpu_cooling: Introduce the cpu
 idle cooling driver
To: Leo Yan <leo.yan@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, edubezval@gmail.com,
        kevin.wangtao@linaro.org, vincent.guittot@linaro.org,
        amit.kachhap@gmail.com, linux-kernel@vger.kernel.org,
        javi.merino@kernel.org, rui.zhang@intel.com,
        daniel.thompson@linaro.org, linux-pm@vger.kernel.org
References: <1519226968-19821-1-git-send-email-daniel.lezcano@linaro.org>
 <1519226968-19821-7-git-send-email-daniel.lezcano@linaro.org>
 <20180223073432.GF26947@vireshk-i7>
 <faaf027c-e01c-6801-9a0c-ab7e0ba669a1@linaro.org>
 <20180327034344.GC21693@leoy-ThinkPad-X240s>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e3384215-1872-3918-3c08-f5cb8754a28e@linaro.org>
Date: Tue, 27 Mar 2018 13:10:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327034344.GC21693@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 05:43, Leo Yan wrote:
> On Fri, Feb 23, 2018 at 12:28:51PM +0100, Daniel Lezcano wrote:
>> On 23/02/2018 08:34, Viresh Kumar wrote:
>>> On 21-02-18, 16:29, Daniel Lezcano wrote:
> 
>> [ ... ]
>>
>>>> +static s64 cpuidle_cooling_runtime(struct cpuidle_cooling_device *idle_cdev)
>>>> +{
>>>> +	s64 next_wakeup;
>>>> +	int state = idle_cdev->state;
>>>> +
>>>> +	/*
>>>> +	 * The function must never be called when there is no
>>>> +	 * mitigation because:
>>>> +	 * - that does not make sense
>>>> +	 * - we end up with a division by zero
>>>> +	 */
>>>> +	BUG_ON(!state);
>>>
>>> As there is no locking in place, we can surely hit this case. What if
>>> the state changed to 0 right before this routine was called ?
>>>
>>> I would suggest we should just return 0 in that case and get away with
>>> the BUG_ON().
> 
> Here if 'state' equals to 0 and we return 0, then the return value will
> be same with when 'state' = 100; this lets the return value confused.
> 
> I think for 'state' = 0, should we return -1 so indicate the hrtimer
> will not be set for this case?

Yeah, I will look at how to make this smoother.

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
