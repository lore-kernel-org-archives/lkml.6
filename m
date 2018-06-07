Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id gz12LMIlGVuvbgAAmS7hNA
	; Thu, 07 Jun 2018 12:32:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9BBCD607E7; Thu,  7 Jun 2018 12:32:02 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4llK5/C"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id F220D601C3;
	Thu,  7 Jun 2018 12:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F220D601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeFGMb7 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:31:59 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35841 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbeFGMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:31:57 -0400
Received: by mail-wm0-f67.google.com with SMTP id v131-v6so18818510wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 05:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ECQSXkLsrtrSrsMu9+V4bNBK9X+z0JgyVVNgtTPLrU4=;
        b=P4llK5/CACy5FQt581I4mCHTujUD+ZhFuC/BxZ47hDm1jerdzZq0x/8M/JCLl/8TWZ
         1zy10GADRrG4LZVG0kHvvCIXG+qj6SwWJTMRTAwBpxdOJ4Ksh2NsVcZvHe5IKumMbaui
         9cBXk0w/XdCk8yPYkfSDApgJsl70xTcCrQnJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ECQSXkLsrtrSrsMu9+V4bNBK9X+z0JgyVVNgtTPLrU4=;
        b=dZLrqGZcVxQmN1E8VvNcP55IxOHG/UwD9X2RKkz9Ul1CckTLM4XtIfbBX1gHwJk1EK
         if9jSXaC+ag6ViXkTxr5DiZVOQ2KSpXKWGUsnkowe16NJ6Dm1MDi0NU50fsKxYFMBzCg
         y7QmyPD6nAD0A/3r7KRDsHxqUabrM3llyorjv2l2J2v1OOVdLc4wMeyIo1xYn1MnAM3m
         ijBK5sPXgc/Cwh5hhqT2IBIH6QmPzRHUSkhRQ7k7G15/+jgdxojgS9d1tJNMBhCfxQpe
         9O6Ht7xwRhFcRZpA9IUjpNObU5MMw0j7lchG24GM2TXv378dHsl1ZkEN9fFTdS0Tby7x
         wYCA==
X-Gm-Message-State: APt69E0KgVTUzAFgMwkh7ASdRwMiZa2L4nUP1W7SG1zg3EmXxFOrAFLH
        bVrGq8dXX4ml9zfSu/xTut/f3A==
X-Google-Smtp-Source: ADUXVKIxJeaDpEZ/L5jAdEBwbdiNXb+m/mV2nxG4qxWZxv8XvQO/KBBwBiEoD5Vn5oWQ1ArWp2jivg==
X-Received: by 2002:adf:f482:: with SMTP id l2-v6mr1648126wro.259.1528374715795;
        Thu, 07 Jun 2018 05:31:55 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id o138-v6sm2195763wmg.10.2018.06.07.05.31.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 05:31:54 -0700 (PDT)
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Peter Zijlstra <peterz@infradead.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <20180606122357.GN12258@hirez.programming.kicks-ass.net>
 <22f5cf0b-049e-7938-55f6-4b4b154f8389@linaro.org>
 <20180606150203.GE12180@hirez.programming.kicks-ass.net>
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
 <d2b8c964-ea0f-624c-a178-721537893541@linaro.org>
 <20180607093201.GL12198@hirez.programming.kicks-ass.net>
 <20180607093927.GE12235@hirez.programming.kicks-ass.net>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d0d3f817-6cd1-fd4c-91e3-304090270efe@linaro.org>
Date: Thu, 7 Jun 2018 14:31:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607093927.GE12235@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 11:39, Peter Zijlstra wrote:
> On Thu, Jun 07, 2018 at 11:32:01AM +0200, Peter Zijlstra wrote:
>> On Thu, Jun 07, 2018 at 11:09:13AM +0200, Daniel Lezcano wrote:
>>> On 07/06/2018 10:49, Viresh Kumar wrote:
>>>> On 07-06-18, 10:46, Daniel Lezcano wrote:
>>>>> Yes, correct.
>>>>>
>>>>> But if we don't care about who wins to store to value, is there a risk
>>>>> of scramble variable if we just assign a value ?
>>>>
>>>> Normally no, as the compiler wouldn't screw it up badly. But there is no rule
>>>> which stops the compiler from doing this:
>>>>
>>>> idle_duration_ms = 5;
>>>> idle_duration_ms = -5;
>>>> idle_duration_ms = 0;
>>>> idle_duration_ms = <real-value-we-want-to-write>;
>>>>
>>>> So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
>>>> readers.
>>>
>>> Ok understood. Why would a compiler do this kind of things ?
>>
>> I think the above can happen when the compiler uses the variable as a
>> scratch pad -- very rare I would say.
>>
>> In general a compiler needs to proof that doing this makes no observable
>> difference ("as-if" rule). And since it is a regular variable it can
>> assume data-race-free and do the above (or something like that). Because
>> if there is a data-race it is UB and it can still do whatever it
>> pleases.
>>
>> And here I think the point is that regular variables are considered only
>> in the context of a single linear execution context. Locks are assumed
>> to bound observability.
>>
>> And here the "volatile" and "_atomic" type specifiers again tell the
>> compiler something 'special' is going on and you should not muck with
>> things.
> 
> Also, I think, more likely:
> 
> 	if (cond)
> 		X = 5;
> 	else
> 		X = 4;
> 
> is allowed to be transformed into:
> 
> 	X = 4;
> 	if (cond)
> 		X = 5;
> 
> as long as cond doesn't involve a sequence point of sorts (think
> function call).
> 
> For the single execution context case, this transformation is valid, but
> it is not in the threaded case. But then we go back to the assumption
> that regular variables are data-race-free.

Thank you very much for the explanations.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
