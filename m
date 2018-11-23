Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B659C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA82206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 06:15:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZfztxBi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA82206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502033AbeKWQ6K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 11:58:10 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34654 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387519AbeKWQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 11:58:10 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so6859307wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Nov 2018 22:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VTds35J0GFouJcnffD/GEMrn0+Sw7JBPNZKSRDaR6f4=;
        b=AZfztxBil9zDO5VkPwgWtbooLrgnW1HswAOSk0gPIrY69+9/wP5gYCwJCnFFW4kky1
         jQHnRRj5WBhZOPL+DcHtXfYAEQDItsOlgmOVgal9NrUPddq6Z1EtqVax2PQz2z2r+hd8
         eJVxoUCxKe/KPxsKEO4OWmZWFNcZxkW+1TLZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VTds35J0GFouJcnffD/GEMrn0+Sw7JBPNZKSRDaR6f4=;
        b=bqlIznkNbeyhzG2J6aYydl+ZUN0xDNVyIeEYINUEPFgCWLZ5gfSfGyfDHvty2Kt3yp
         bA2A0k+l/0enAH1rNhToSOY1J6SAIw/PivbUjG3XEviYMa8+hCfmZfjRHC/sr6C9Bc/R
         09JYjl2K6RSZ34AP6amxm6jfOYB0f1Au7KCIsTk0Jc32KZsQmow92CdS12PZ2C9FxVuC
         FsEsO0j3Um85oaJlorspCOpel675Gpnw4zenQknzVO0YVTh2irkEVPXPuZn/80DxwzJf
         7k8zb4hrzlR4Yfrl357/KuR1qz6NVAZF4ls8XXhFv7vF1JbBEAgUZjysDnR41t6DPx3j
         WMsA==
X-Gm-Message-State: AA+aEWblHyFW9QumHQKs96TBCnVPzorLGmW2dLtzmtUzlkevUTgpb5kY
        Pn5O59BXnB7lIPprp/cWyYs0nA==
X-Google-Smtp-Source: AJdET5c2RM0pCfzH23sEPnvsr8lBHJ87u7OL8nrE8MIB1fm48mOCLzZrIGts7zxDAjyQ8uEgE9Kd+w==
X-Received: by 2002:a7b:c315:: with SMTP id k21mr11872552wmj.145.1542953721926;
        Thu, 22 Nov 2018 22:15:21 -0800 (PST)
Received: from [192.168.0.40] (44.65.136.77.rev.sfr.net. [77.136.65.44])
        by smtp.googlemail.com with ESMTPSA id w18sm14428089wru.54.2018.11.22.22.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 22:15:20 -0800 (PST)
Subject: Re: [PATCH v2 0/2] clocksource/meson6_timer: implement ARM delay
 timer
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, linux-arm-kernel@lists.infradead.org
References: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
 <5ff1a888-cce2-8fd8-a98e-14c3d7c33acf@linaro.org>
 <CAFBinCDSLEAzJVVgFxKhN3LCUwgC3Rrr=4ZhtHCdvqEPBLWbJA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a83b92fb-5950-01b8-521d-7b05939dce3a@linaro.org>
Date:   Fri, 23 Nov 2018 07:15:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCDSLEAzJVVgFxKhN3LCUwgC3Rrr=4ZhtHCdvqEPBLWbJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2018 23:12, Martin Blumenstingl wrote:
> Hi Daniel,
> 
> On Sun, Nov 18, 2018 at 2:27 AM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 15/11/2018 23:46, Martin Blumenstingl wrote:
>>> While trying to add support for the ARM TWD Timer and the ARM Global
>>> Timer on Meson8, Meson8b and Meson8m2 (ARM Cortex-A5 and Cortex-A9 SoCs)
>>> I did a review of the existing driver.
>>> Unfortunately I found it hard to review because the pre-processor
>>> #defines did not match the names from the public S805 datasheet. Thus
>>> patch #1 adjusts these. No functional changes here, this is just
>>> preparation work for patch #2.
>>>
>>> Using the ARM Global Timer (drivers/clocksource/arm_global_timer.c)
>>> would have given us a timer-based delay implementation (so udelay() and
>>> friends would use the timer instead of using a loop-based delay
>>> implementation). Unfortunately we can't use the ARM Global Timer yet
>>> because it's input clock is derived from the CPU clock (which can change
>>> once we enable CPU frequency scaling on these SoCs, for which I will be
>>> sending patches in the near future).
>>> Amlogic's 3.10 kernel uses Timer E as delay timer which (with the
>>> current configuration) has a resolution of 1us. So patch #2 uses
>>> register_current_timer_delay() to register Timer E as ARM delay timer
>>> (which will be especially useful as we have to use udelay() when
>>> changing the CPU clocks during DVFS).
>>>
>>>
>>> Changes since v1 at [0]:
>>> - convert the enums for the input clock (meson6_timera_input_clock and
>>>   meson6_timere_input_clock) to simple #defines as these are register
>>>   values and not something driver-internal. All other register values
>>>   are #defines so it makes sense that these are #defines as well.
>>>
>>>
>>> [0] https://patchwork.kernel.org/cover/10658591/
>>>
>>>
>>> Martin Blumenstingl (2):
>>>   clocksource: meson6_timer: use register names from the datasheet
>>>   clocksource: meson6_timer: implement ARM delay timer
>>>
>>>  drivers/clocksource/meson6_timer.c | 128 +++++++++++++++++++----------
>>>  1 file changed, 85 insertions(+), 43 deletions(-)
>>
>> Both applied, thanks!
> thank you for taking my patches
> 
> I have one question more: can you please push these patches to a
> repository/branch which is included in -next?
> I'm asking because I'd like to send patches that enable CPU frequency
> scaling on Meson8, Meson8b and Meson8m2. The code to change the CPU
> clock calls udelay(), which (in this special case) needs a delay timer
> to work properly (we can't use jiffies as we're using udelay() *while*
> changing the CPU clock).

branch pushed [1], should appear in linux-next very soon.

  -- Daniel

[1]
https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=clockevents/next


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

