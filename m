Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id +YPNEgQ/Glv+SwAAmS7hNA
	; Fri, 08 Jun 2018 08:32:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2E6FA6089E; Fri,  8 Jun 2018 08:32:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LPuenH0s"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 94F6B601C3;
	Fri,  8 Jun 2018 08:32:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 94F6B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752969AbeFHIcB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:32:01 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51871 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752886AbeFHIbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:31:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id r15-v6so1855432wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 01:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3KrAf/h+4Bv+j/cg5jNr741Bkz4qPUij/iYLWT5ILzU=;
        b=LPuenH0seR6JBxB9U3O7OQMFeVHK3pevV3M+EFJQHT5hUS0ZBGghfEimCb11MrbGyv
         01gkzae1CPaaGcZvDyCoTnC3Mcy+6QXLnKgbv8tNT7UYo2+wb3F59BawPSwFh0QUqueR
         ZLVo4EcX5wUHg6WBNjmKVLAYf5aATnEwb346U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3KrAf/h+4Bv+j/cg5jNr741Bkz4qPUij/iYLWT5ILzU=;
        b=WWuXfMjmBPxM1Y0+5SZtgPrw0gJ9S2fa1WgnLmcN1R3g5uQ+ScBW9298eZJspMqJZ2
         dy6fsRvzIfU2I5T07KjvqNBUZajXrP58GGxbrA1g4wt1T5wXT+N5SyxUJeIUsQWgOAs0
         ztZG491te/lARXTwn07yozjMtlgrnCNvGzOjXnuKVDEVxNy3bjTXUsPtJJXHrvJYzzeW
         nUGOzyz30oOmmPkVPI7fj9kPXFfgPIoqFpynYaRhZ/0zLaL7oVGYJh65o3aH+FfReMYo
         xUpGas13cUnSDxZPOvkOUmnGRyT2aJ5XjdWzyhhqcCCgKIlrd/5nrMzeZiZ92rO/5Bvw
         0VJA==
X-Gm-Message-State: APt69E3yZNF1j+Kh6PnmEzdvLuQ2SVCOiWTlcDSns1utAEfKOijnFiw2
        es8IfhGhX75dgztORPBHPROJWw==
X-Google-Smtp-Source: ADUXVKLxd3AqSMqwZ9Khb23ov3Y/MjcGhOMIgcZo76t68YESnkcVb6TFI8HuE6vVRIm3QEAd1FzRXQ==
X-Received: by 2002:a1c:4a5d:: with SMTP id x90-v6mr835676wma.67.1528446714214;
        Fri, 08 Jun 2018 01:31:54 -0700 (PDT)
Received: from [192.168.1.75] (lft31-1-88-121-166-205.fbx.proxad.net. [88.121.166.205])
        by smtp.googlemail.com with ESMTPSA id l69-v6sm5306303wma.45.2018.06.08.01.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 01:31:53 -0700 (PDT)
Subject: Re: [PATCH V5] powercap/drivers/idle_injection: Add an idle injection
 framework
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Kevin Wangtao <kevin.wangtao@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rui Zhang <rui.zhang@intel.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "open list:POWER MANAGEMENT CORE" <linux-pm@vger.kernel.org>
References: <1528190208-22915-1-git-send-email-daniel.lezcano@linaro.org>
 <20180605103917.pyhhcobdvaivqv6g@vireshk-i7>
 <57d769f8-46ea-512e-8f89-a0439c9d053f@linaro.org>
 <20180606042708.mtwd66ecy2cnjp7a@vireshk-i7>
 <2bebd1bc-e1ad-6d22-ad1e-aee2cf8ba878@linaro.org>
 <20180606104528.nhwcd2qnxeouk6il@vireshk-i7>
 <1d542490-fcb5-33fd-ab3b-eddf3d300bd4@linaro.org>
 <20180608044839.eyaib5gkbw7biu2a@vireshk-i7>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <39960620-dc59-92a5-0e57-f00a4d930f7f@linaro.org>
Date: Fri, 8 Jun 2018 10:31:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180608044839.eyaib5gkbw7biu2a@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2018 06:48, Viresh Kumar wrote:
> On 07-06-18, 16:11, Daniel Lezcano wrote:
>>>> I'm wondering if we can have a CPU hotplugged right after the
>>>> 'put_online_cpus', resulting in the 'should park' flag set and then the
>>>> thread goes in the kthread_parkme instead of jumping back the idle
>>>> injection function and decrease the count, leading up to the timer not
>>>> being set again.
>>>
>>> True. That looks like a valid problem to me as well.
>>>
>>> What about starting the hrtimer right from this routine itself, after taking
>>> into account running-time, idle-time, delay, etc ? That would get rid of the
>>> count stuff, this get_online_cpus(), etc.
>>>
>>> Even if we restart the next play-idle cycle a bit early or with some delay, sky
>>> wouldn't fall :)
>>
>> We won't be able to call completion() in this case.
> 
> I was just having a look at smpboot.h and saw the park/unpark callbacks. I think
> you can very much use them to align things with CPU hotplug.

Hmm, perhaps. I will have a look at it.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
