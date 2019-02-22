Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FA1C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3BD22086D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 08:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qwCCUU+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBVIWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 03:22:12 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38421 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBVIWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 03:22:12 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so1370677wrw.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 00:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qf4hBNmkS6V7WDG41TaKUxOvLC0jTMr+nlTl+iTvfdM=;
        b=qwCCUU+ojj6r2WgjAl/+TBZ8g3bfIp62QMyKTjsfHYZm5nOtrJDLBGeqwf6ujk68c+
         karBhVRJG68UWKKSAuzoyWpaiX90pAyvU3teyMHOSdcyBwNeonFfjQsY7iL1aI/H0CJN
         dybH2hPxFmjT6x/28oKclObGsSy2MWH/xeQlL+OZVan7hfXAeKhnsKLa1cpH9bp/Nm5Q
         nv4Ww5ZMSI5jpE99fKgsdlYUWPxzznDPVzU8P3+XNVgdqjfyKPl6FHMjfBTOYsvtwzrC
         3xcOxuTYQN4qRt8ffESG5wiyWVJ93eZ5usSbDkNQxj3N6DNicAPiRPBXNC9eAavg9zQt
         AisA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qf4hBNmkS6V7WDG41TaKUxOvLC0jTMr+nlTl+iTvfdM=;
        b=UgJNFsjzY9oezbqxm9n1JLVBTsMjUyba5XfTX7RWiwPiUw39JYMz+FMGI6FQfC7OVe
         s5sQ+JCjiuvyxRJ1gqnA5hGIrl/EWIBvxEWbCHzlE5htvg4/NsZr/Sj3odYn3PS2guh4
         YImL14xttmm13JrsXihjUyQYRs0cYgWhi3fLGhtguzdbgJUysL8KjiLMghCMPjzPfnDo
         gNiJBiOINbCZ8SB/1FKBhKa5veM/VBtQ/fIrGql6x5CFFXEV1NLL0mfEIXyIx0ovZecO
         o8UT6jwClukbTvnCWeuHeZa0ORioBHz+GNPq0/vbUFTFvgQX2e8b2OtjrYFXczzeKCt9
         50cw==
X-Gm-Message-State: AHQUAuYfMAIiZjlqRXyDFDXqrWNstHYQyHJywX4F2Qwb7YMFV0gNCyQK
        Mlra9cZPPqddO7IK52X1teDV2ZalLyw=
X-Google-Smtp-Source: AHgI3IYBKffHtcNBwLKS9R+dztRygPF1YiZq6uwigKLONZw8xw+mFjkxEtnjZmgyoMO7kk1BnhWLsw==
X-Received: by 2002:a5d:434f:: with SMTP id u15mr1857041wrr.174.1550823730132;
        Fri, 22 Feb 2019 00:22:10 -0800 (PST)
Received: from [192.168.0.41] (222.51.92.92.rev.sfr.net. [92.92.51.222])
        by smtp.googlemail.com with ESMTPSA id j41sm1593206wre.9.2019.02.22.00.22.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 00:22:09 -0800 (PST)
Subject: Re: [PATCH][RESEND] Make ARM_TIMER_SP804 depend on (ARM || ARM64)
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <20190221160648.29785-1-david.abdurachmanov@gmail.com>
 <cf0a7334-c347-b254-f80d-93640f201b20@linaro.org>
 <CAEn-LTqUcp+xtGHLL6E1BL-GFUeDwJ95RDH=NLegZZwBxixe1Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d8dcf9c9-84c0-d32b-c642-701b470495c1@linaro.org>
Date:   Fri, 22 Feb 2019 09:22:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAEn-LTqUcp+xtGHLL6E1BL-GFUeDwJ95RDH=NLegZZwBxixe1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 22:43, David Abdurachmanov wrote:
> On Thu, Feb 21, 2019 at 9:48 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 21/02/2019 17:06, David Abdurachmanov wrote:
>>> Resending to incl. a proper mailing list and maintainers (not suggested
>>> by scripts/get_maintainer.pl)
>>>
>>> This is only used on arm and arm64 platforms. Other timers also seem
>>> to depend on (ARM || ARM64).
>>>
>>> After I moved Fedora/RISCV kernel to 5.0.0-0.rc2 it keeps asking me to
>>> add CONFIG_ARM_TIMER_SP804=n to my config. This patch resolved the issue.
>>>
>>> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
>>> ---
>>>  drivers/clocksource/Kconfig | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index a9e26f6a81a1..7593d80e1c88 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -369,7 +369,7 @@ config ARM_GLOBAL_TIMER
>>>
>>>  config ARM_TIMER_SP804
>>>       bool "Support for Dual Timer SP804 module"
>>> -     depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
>>> +     depends on (ARM || ARM64) && GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
>>
>> What about adding the COMPILE_TEST option:
>>
>> bool "Support for Dual Timer SP804 module" if COMPILE_TEST
>>
>> but not add the ARM || ARM64 dependency ?
>>
> 
> That would work, but is that consistent with other timers?

Yes, I'm making all timers to converge to COMPILE_TEST option.


> Looks like a number of them have depends on + COMPILE_TEST.
> 
> Some examples:
> 
> config ROCKCHIP_TIMER
> bool "Rockchip timer driver" if COMPILE_TEST
> depends on ARM || ARM64
> 
> config ARMADA_370_XP_TIMER
> bool "Armada 370 and XP timer driver" if COMPILE_TEST
> depends on ARM
> 
> config ORION_TIMER
> bool "Orion timer driver" if COMPILE_TEST
> depends on ARM
> 
> config ARM_GLOBAL_TIMER
> bool "Support for the ARM global timer" if COMPILE_TEST
> select TIMER_OF if OF
> depends on ARM
> 
> config CLKSRC_EXYNOS_MCT
> bool "Exynos multi core timer driver" if COMPILE_TEST
> depends on ARM || ARM64
> 
> david
> 
>>>       select CLKSRC_MMIO
>>>       select TIMER_OF if OF
>>>
>>>
>>
>>
>> --
>>  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

