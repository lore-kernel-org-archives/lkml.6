Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F14EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC228222A1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="obDF/BGh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502656AbfBNQMm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:12:42 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:52484 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502615AbfBNQMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:12:40 -0500
Received: by mail-wm1-f49.google.com with SMTP id m1so6914145wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nymx3Vre5M6XEnXB5ncvsqDZf0lwUy52Ov5flAUtP3g=;
        b=obDF/BGh+f0OUx9xmimd3aMQ/DZZX3BaslPUUYSPb3pWzJK4ppZhuK9Y1sKgs6Dhsf
         0XejuV+Rl0SYCcvZ1ZEnGSQrk0hlFS7W1nwW0c/BZ1Y0bJTVI3Z31wBLi7bHeCP1DDo8
         QvHWQABpJB7YK+9SgzMIy0zMlUDoNqGMG77ol+QZqu0MkQoXG7DlRLcNNn0ZTkjmJGWe
         kv+QwKbNlKg5jAmMLkYervkqLEd2R2srPYDHJqhND/0ubk78j2iC5l8Lc2gQQM9KVTol
         63TxzU9Ek7mex2SoK1N9ymc/UHXDGpVzLB2lrdssUVR/FGhAf0tz2PkstGbIXD2gmVWR
         7jog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nymx3Vre5M6XEnXB5ncvsqDZf0lwUy52Ov5flAUtP3g=;
        b=WDk8j0S9syOSuOJGIrPLQ4KXO+7MT/Mp32NrRBDdLkBNlflR7cW02ZHavcPyZVcDcm
         qdbVl0Juq2s0aeXWxpWt+M5F2LP/Qbdi0uOGWzU/7jBp7ZKBN5yQ1RL896Ee1fAWPE+u
         LOSnP9Y5fPw6vUrOW3NV+6j3tCHZyh2HzVVhKGurYjVk089jIGIWc0pCBTKVHOKBSUJq
         qoHVhnMYkfM/x2zXGWb7zphZl+mOt/tVsCBmN9oGaeCn5ygp9w4/rxh5OUHDDzbKK+34
         nQrdyi/y1wXKI1ODdIiMPxAJi9tow3AaRuF0P1lhKXEPwHR4oJoJB9Mq8sTMD3PYkgt3
         Srrg==
X-Gm-Message-State: AHQUAuaY73qsS/liiyH+9GVTfRBTMcexR8kvBt1FR9oKr0n3jPFRqZcz
        bIxtVipjBOH5hgCy1ljJ+vQCuQ==
X-Google-Smtp-Source: AHgI3IYItc6x5eDqTt+w96O/PpZ/wxAwo5lyBbdSAZkGmXG/ZoiCnNi8kJRQTWD1Gk+12kjcSb7mqg==
X-Received: by 2002:a7b:c0d5:: with SMTP id s21mr3587827wmh.153.1550160758374;
        Thu, 14 Feb 2019 08:12:38 -0800 (PST)
Received: from [192.168.27.66] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id v6sm4185127wrd.88.2019.02.14.08.12.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:12:37 -0800 (PST)
Subject: Re: How to know if there is a pending interrupt when they are masked?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marc Zyngier <Marc.Zyngier@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <bf2e6e81-7218-05e0-fd6e-27c9c5418813@linaro.org>
 <alpine.DEB.2.21.1902141620510.1561@nanos.tec.linutronix.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <663d069e-55c9-c4f0-dc84-f6145b998192@linaro.org>
Date:   Thu, 14 Feb 2019 17:12:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1902141620510.1561@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Thomas,


On 14/02/2019 16:35, Thomas Gleixner wrote:
> On Thu, 14 Feb 2019, Daniel Lezcano wrote:
>> today we have the possibility to mask the local interrupt with the
>> command local_irq_disable / local_irq_enable.
>>
>> The power management path disables the local interrupt in order to
>> initiate a power down sequence. If there is a pending interrupt this one
>> will make the power down function to abort, thus exiting right after
>> calling the shutdown function after costly operations. It could be
>> interesting to check if there is a pending interrupt before initiating
>> the power down sequence.
>>
>> Is there a way to know if there is a pending interrupt on the current
>> CPU when the local interrupt are disabled? Something like,
>> local_irq_pending() function ?
> 
> We have nothing like that today, but it would be possible to implement this
> at least on x86 by peeking the local APIC registers.
> 
> OTOH, the question is whether it's worth the trouble because the interrupt
> could come in right after the query and the same issue which you want to
> address persists. It only makes sense if it reduces the time window so
> significantly that it actually matters.

Yes, I agree. It should be worth only if we can prove we enter the deep
idle sequence with pending interrupts much more often than what we expect.

Actually, we have a similar action when the need_resched() is true, we
abort the idle sequence and exit the loop.




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

