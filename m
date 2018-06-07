Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1IHVIUD2GFtCQwAAmS7hNA
	; Thu, 07 Jun 2018 09:09:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6CDC9607F7; Thu,  7 Jun 2018 09:09:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hebXUYnW"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id BA2A06063F;
	Thu,  7 Jun 2018 09:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA2A06063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeFGJJR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:09:17 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40130 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbeFGJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:09:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id n5-v6so17290274wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 02:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i5+dDbox0dsFguYCwuRboG468m/HPJp+3Ojdj907BxA=;
        b=hebXUYnWQTI9sgXLyDlAqBUKtMcFsJKU+18OXxvSrz2XX5QvULLBD7bATe32HdB1/P
         Z0sr797q5io+h3XZvAXbYTbJDeP/l4ioL+tJREyqL7/jceNkvvuACTPFKrzeE9Ud42al
         S6nDuhGfXxzp4tE7scAwpFLEA15gN8UeAzHxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i5+dDbox0dsFguYCwuRboG468m/HPJp+3Ojdj907BxA=;
        b=Ti2Fm8XmfnnCztCMkRrJvRM6tZSJ/+sF6Dl6kITGsETB8CZ4Ja9UXTMTQn8sKLe0ou
         EhFGM/jD/IgUxXSjNzp5N2WbqjGo6PzZMMG+7zK+lOu6yJU8b+xKKAlTFBdOKXn4o3Bv
         YM00fr8LkWZ05eULHk080u1TFWawrEqDOQfuOMtaKRhCqwbYlbkBLVDqG2ysLsL2rHPf
         QTC9UkmIQ6TEYX1Y4OzclbheprDf4J9GVMyaEtzAFecIAr1ypYGaKyUH6t/ErkPTDDCK
         A+E3FC41xJQJG/CDN6p8BrR0q/GqC8qigoOMYNGVnhv+b5g44j+g5P/Fg5fVFEALzr6c
         MbZA==
X-Gm-Message-State: APt69E2w+OS3+xOpCT3EbC81Ejgrcj9eA0hfYCJ0+MXlrzJe6H5k+etW
        bM2lnVMROEZvUKDtQD/cshOiqg==
X-Google-Smtp-Source: ADUXVKKm8xZfpFBr1/3nkXuIokZAT06veZVfSqxxqt28AhBnezW6E1eZzSwI8cSSd1estGbsj40FSg==
X-Received: by 2002:a1c:8409:: with SMTP id g9-v6mr1099860wmd.90.1528362553953;
        Thu, 07 Jun 2018 02:09:13 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id u15-v6sm1575729wma.37.2018.06.07.02.09.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 02:09:13 -0700 (PDT)
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
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
 <ea347237-7cef-095a-5ddb-19c181d10c23@linaro.org>
 <20180607083229.GJ12198@hirez.programming.kicks-ass.net>
 <20180607084251.rv2tg3kgz4aohlpd@vireshk-i7>
 <9996fb40-c7aa-db61-5445-52c146f44d85@linaro.org>
 <20180607084921.toctrooftl6y7kkx@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d2b8c964-ea0f-624c-a178-721537893541@linaro.org>
Date: Thu, 7 Jun 2018 11:09:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607084921.toctrooftl6y7kkx@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2018 10:49, Viresh Kumar wrote:
> On 07-06-18, 10:46, Daniel Lezcano wrote:
>> Yes, correct.
>>
>> But if we don't care about who wins to store to value, is there a risk
>> of scramble variable if we just assign a value ?
> 
> Normally no, as the compiler wouldn't screw it up badly. But there is no rule
> which stops the compiler from doing this:
> 
> idle_duration_ms = 5;
> idle_duration_ms = -5;
> idle_duration_ms = 0;
> idle_duration_ms = <real-value-we-want-to-write>;
> 
> So we *must* use READ/WRITE_ONCE() to make sure garbage values aren't seen by
> readers.

Ok understood. Why would a compiler do this kind of things ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
