Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +vBZO/bpGFsWWAAAmS7hNA
	; Thu, 07 Jun 2018 08:18:34 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5C877608BA; Thu,  7 Jun 2018 08:18:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iUIQwu9/"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D50D36063F;
	Thu,  7 Jun 2018 08:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D50D36063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753510AbeFGISc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 04:18:32 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:38854 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932066AbeFGIS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 04:18:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id 69-v6so3957458wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fb/HVRQHmXD11lSoBJhK5C7bBDDUNmldlFd2pgh3POU=;
        b=iUIQwu9/YA15+20+9bI0Ow3YM4ip+JGo8Vy1+ytwJfp8RsXM2PB6USZ0IBWeTmMANG
         YvAns7fLAOuKVLf5aSmZ18M2f9zZ/liVu8fz/VupucgKMuCsgMyulzp6xekmYdv1UTt4
         fw3+n0JxluKePy/IXianoFygxOg78h4wE0yyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fb/HVRQHmXD11lSoBJhK5C7bBDDUNmldlFd2pgh3POU=;
        b=T+wmG+aKl28T1P7hSCYJelIn2SyRqgCDCSSK3FrnviNAOQY+K/T2H2Q9oMaml1BxvS
         I1Lk8t+v4KjAz4ynrx4AYRhz25t4Hwfrf57s5Hq4H027cRz9vui809OtYEZo0C3hGIku
         FZdWZ9RrjtWZlFHqoW/2e2DBoWelOnXqEuC1fZCoTFJ5awNSkd2gw2sWzcZ58xmR8i9K
         +gV1UtnUJHWszN3u1LPKazgw7aJbkXSG4bGyX+JysKY45tz6t3pi4kEs3lwFc4dckCu1
         Oy3KoB1X0zkk4gBZV/Yghutz1LShrvYy0s4KaFZVJSHqSIU71ExcDU9Lc8Gq5sFpYhYt
         oiyg==
X-Gm-Message-State: APt69E3LkIIYw77ak1gY935l4rP08WEkCAwqYFzV/K+uHBaFME9DNbe9
        mA8ZkXIr7tGQ8+C1sIKGa61V0Q==
X-Google-Smtp-Source: ADUXVKIXNag+GgeUYu0Rmo63gjsStjYYAlcld5JiRXtvak+9uGtSVusOZU3xqf7npXxlgnjyACuWDw==
X-Received: by 2002:a1c:d509:: with SMTP id m9-v6mr900642wmg.69.1528359508225;
        Thu, 07 Jun 2018 01:18:28 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id q194-v6sm1326439wmd.26.2018.06.07.01.18.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 01:18:27 -0700 (PDT)
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
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
Date: Thu, 7 Jun 2018 10:18:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606150203.GE12180@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/2018 17:02, Peter Zijlstra wrote:
> On Wed, Jun 06, 2018 at 03:42:08PM +0200, Daniel Lezcano wrote:
>> On 06/06/2018 14:23, Peter Zijlstra wrote:
>>> On Tue, Jun 05, 2018 at 11:16:40AM +0200, Daniel Lezcano wrote:
>>>> +	atomic_t idle_duration_ms;
>>>> +	atomic_t run_duration_ms;
>>>
>>>> +	idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>>>
>>>> +	run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>>>
>>>> +	atomic_set(&ii_dev->run_duration_ms, run_duration_ms);
>>>> +	atomic_set(&ii_dev->idle_duration_ms, idle_duration_ms);
>>>
>>>> +	*run_duration_ms = atomic_read(&ii_dev->run_duration_ms);
>>>> +	*idle_duration_ms = atomic_read(&ii_dev->idle_duration_ms);
>>>
>>>> +	if (!atomic_read(&ii_dev->idle_duration_ms))
>>>
>>>> +	if (!atomic_read(&ii_dev->run_duration_ms))
>>>
>>> What is the point of atomic_t here ?!
>>
>> idle_duration and run_duration can be changed from different places at
>> the same time. The atomic is here to ensure the read/write are consistent.
>>
>> Do you think it is pointless ?
> 
> Yes, atomic_read() / atomic_set() are no more atomic than READ_ONCE() /
> WRITE_ONCE().

So IIUC, neither atomic or WRITE|READ_ONCE are necessary in this code
because of the wake_up_process() barrier is enough, right ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
