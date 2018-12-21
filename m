Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A51BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E58E921906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TM13oeX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731981AbeLUHPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:15:10 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46553 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730816AbeLUHPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:15:10 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so4084499wrt.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 23:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6Y999tZFT4KVowGELbP8C8GTRfZSF77FOo8O93TvjWE=;
        b=TM13oeX8/ojpm0DGwVB+zJTWSYmX0uEuJpuKlsjuJREnP4QSE4knUu4USgNhfA7fuO
         JH6mN7ibY1CqyIkFeAle0XMQNOC+eKClAi5+3mqI8CqRQU6foK6Gsg5uGJVywklPnzhU
         ZKW8k4a4Uvr9XWJuxMs3PrEmBGL7N1s4DslNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6Y999tZFT4KVowGELbP8C8GTRfZSF77FOo8O93TvjWE=;
        b=eFkg5ZmxG1gwb4ShY13CCt7DA+/3qFXscSo1Z+9L/+Qe49So+eQSXvN3NdlAYJ/OIA
         odPOq+NBBeaUmmDyZfqxLRpYIgCU8c1gEVTqcpJuRGEdUuInu7CKknSMK2ceW0W9ApUa
         Gfaf/DpskEKWL6jcUJM3VTUYeuWhg8etwRn0Jiit9Ibdh/nAnvxxYHbDblaECyiBgx5N
         /FuoZTOyCpO2HWTybZHPFKkgLhJ1qT1imBmA0kICdDI58mLT1f5m/cnQGfbdgUDcyBYq
         3wXrtDt4oP1Fbli01opx32YzbEH2VFr3EB48Ilz2Hz4q0t+PSeosfNCEaoBqoaYpIIHc
         0vxw==
X-Gm-Message-State: AJcUukdtbvTds6/YeZX0g2LfkRWo0mzaFThhVuHO0cu8W+IYPAEdPxYg
        itFXsa8jbGXwGwG52+MxZa9avujEdvM=
X-Google-Smtp-Source: ALg8bN7TBdc1qH89yzLvwkAJgAemjrA3k7EQ/vErm4YNlhVkQxgp0RyXuKg6BXnY2IygHHMp7JkxuQ==
X-Received: by 2002:a5d:5182:: with SMTP id k2mr1238879wrv.121.1545376508086;
        Thu, 20 Dec 2018 23:15:08 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id a1sm13838089wrw.76.2018.12.20.23.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 23:15:07 -0800 (PST)
Subject: Re: [PATCH v10 17/27] drivers: firmware: psci: Prepare to support PM
 domains
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-18-ulf.hansson@linaro.org>
 <d82f3fe0-7f60-c89a-6503-435cc6dcc5cf@linaro.org>
 <CAPDyKFpfp+d9K-i-ytCqwSq2ToQvqApatH0YyRXbW55wLyU=wA@mail.gmail.com>
 <c5587b35-734c-5c1d-a433-ce78c8583ef1@linaro.org>
 <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <66f0871e-fd1d-2f9a-13ce-1164c04e65ca@linaro.org>
Date:   Fri, 21 Dec 2018 08:15:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAPDyKFqdeSm56hVB+9dwJekNhZU10DE+-WaWa4m=wdUmjAdAdw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 22:37, Ulf Hansson wrote:
> On Thu, 20 Dec 2018 at 19:06, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 20/12/2018 16:49, Ulf Hansson wrote:
>>
>> [ ... ]
>>
>>>>> +#ifdef CONFIG_CPU_IDLE
>>>>
>>>> It would be nicer if you can remove the CONFIG_CPU_IDLE by replacing it
>>>> with a specific one (eg. CONFIG_PSCI_IDLE) and make it depend on
>>>> CONFIG_CPU_IDLE, so the config options stay contained in their
>>>> respective subsystems directory.
>>>
>>> I am all for simplifying the Kconfig options in here, as indeed it's
>>> rather messy. However, I would rather avoid folding in additional
>>> cleanup changes to this series, is already extensive enough.
>>>
>>> Would you be okay if we deal with that on top?
>>
>> IMO, there are patches in this series which can be grouped into a
>> cleanup + set the scene patchset and merged immediately. An option
>> similar to ARM_SCMI_POWER_DOMAIN can be part of it.
> 
> I certainly agree to that. The tricky is, to know what pieces people
> are happy with to go in. :-)
> 
> Earlier, in v9 I tried your suggested approach (kind of), but then
> Lorenzo stated that it's kind of all or nothing. Maybe we can bring up
> that discussion again with him and see what we can figure out.
> 
>>
>> However, if you swear you will do the change after and sign with your
>> blood, I'm fine with that 0:)
>>
> 
> Whatever it takes!
> 
> Anyway, as stated, the reason why I want to tackle that on top, is
> that I don't want to make the series more extensive than it already
> is.
> 
> Agree?

Yes

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

