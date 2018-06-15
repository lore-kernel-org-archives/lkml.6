Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5C169C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11B4A208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X6+l5p/j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11B4A208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756040AbeFOINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:13:41 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42175 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755819AbeFOINj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:13:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id w10-v6so9001554wrk.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 01:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TscHnC8B090qoRFOh8rHdcMaVcJBgvaWrkd3SOYPsRQ=;
        b=X6+l5p/jLbOonTwyewlPfA2Pigjk6s8C8pgK2BgwsLVOCj2iTG0zMa5PcQAK2yMOvx
         cvSfTdyE0r71+iDbGail1jFKZ51L/dPDIxbk+xWrTwNSj+sQ5kJuT8ETUq56zBWzkyAW
         FPMpWEDlqN2haI/IipnlduwGqLoTkSLqWD8jA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TscHnC8B090qoRFOh8rHdcMaVcJBgvaWrkd3SOYPsRQ=;
        b=sw+NqmKjRhYhaRZvkkyUevSjRowJGQY+WOT3JdNfOdrqPRWgCnjgqxFHa4/QrjMApA
         c9nuLvaKZgqNSW+0b0PqU0Rg+i8zjcn7v687DiibOpSSeAEsCdIsvF0yZYsfuxF1NbJ8
         C8ZonCGRhhuhgMBGvio3XsUAnOyVsV+fJ3yw6s5SrmZ3i3AN/SDzkgqCHESZAj7M34nW
         2becTBE46uSW42Qm3L5g3Pjoi38kgGXeNckuRakYEZIcjYky2s15flD4W8QwAHmMuyXP
         8Xo6sD4k3Ou5KAzwIaOZrB/NLf188XEazo/sgg75rKmtppHuzT81MmA4LpCqK5dx4+tC
         LQMQ==
X-Gm-Message-State: APt69E0sShnmHae0WMPGTb7EFo88iOuKSRy0GueT3pmPyqDW/1T5Pv9v
        sj3s+1X/GtfXfoJNfBQTWwX1Xg==
X-Google-Smtp-Source: ADUXVKI4VOvasioXl+bCcbdvTR1xQpvHl5yjivNe7iwYZHIxf5q0qRCBh8Rwzd40iVq41DSHTy1xcg==
X-Received: by 2002:adf:be09:: with SMTP id n9-v6mr714749wrh.267.1529050417882;
        Fri, 15 Jun 2018 01:13:37 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:c420:d140:2202:2512? ([2001:41d0:fe90:b800:c420:d140:2202:2512])
        by smtp.googlemail.com with ESMTPSA id n56-v6sm16133436wrn.72.2018.06.15.01.13.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 01:13:37 -0700 (PDT)
Subject: Re: [PATCH V6] powercap/drivers/idle_injection: Add an idle injection
 framework
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>
References: <1528804816-32636-1-git-send-email-daniel.lezcano@linaro.org>
 <20180612123036.GJ12180@hirez.programming.kicks-ass.net>
 <16d5649d-863c-10c7-9287-202568e713e6@linaro.org>
 <20180612125247.GO12217@hirez.programming.kicks-ass.net>
 <16770447-afe3-0fd7-19f9-1bd52c4c8ced@linaro.org>
 <20180612140654.GQ12217@hirez.programming.kicks-ass.net>
 <cce05d92-d51a-ab4f-83f2-37dcdee0cd6a@linaro.org>
 <20180612155841.GT12217@hirez.programming.kicks-ass.net>
 <7190a58e-05f2-216c-8b36-70692fa722bf@linaro.org>
 <20180612173514.GV12217@hirez.programming.kicks-ass.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4eaf5987-4532-5c81-ec3a-89614bf339f5@linaro.org>
Date:   Fri, 15 Jun 2018 10:13:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612173514.GV12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2018 19:35, Peter Zijlstra wrote:

[ ... ]

>>>> Yes, drifting is not an issue if that happens. This scheme is simpler
>>>> and safer than setting the timer ahead before waking up the tasks with
>>>> the risk it expires before all the tasks ended their idle cycles.
>>>
>>> sloppy though..
>>
>> Ok, do you prefer to see the timer set in the wakeup function and thus
>> having a periodic tick for the idle injection ?
> 
> I think having a HRTIMER_RESTART handler that does hrtimer_forward() is
> the most sensible. You will end up having to deal with threads not being
> ready, but I think that's not a real problem.

Thanks for the restartable timer suggestion. I'm finishing polishing the
code and definitively the result is much more nicer.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

