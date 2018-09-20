Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7904EECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D68821535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 23:57:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hWwFs/hN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D68821535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388725AbeIUFnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 01:43:31 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43348 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbeIUFnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 01:43:31 -0400
Received: by mail-pl1-f196.google.com with SMTP id 38-v6so5077055plc.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 16:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhClBqP/Ljz1lJD7ND2S3D4MHxFuo3tnUmUwiTE2ap4=;
        b=hWwFs/hNEbbg5zhIsin4DaDbSU3CPpPVpeeP7M2wzPdfes08uPYE8L8svqdVLvrBnl
         pF5GWQeFhEmRRwfY/ohH+fAJkIq5DsN2svEYbHFWpW5X919Kq2x10YpT3uyS50sobPLG
         vznx6I179W7VQCO9rhs9vKXc2OkwtarVsKs+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhClBqP/Ljz1lJD7ND2S3D4MHxFuo3tnUmUwiTE2ap4=;
        b=EIsgwWsDS81lRoQuR87M5pINAHt932RZ+tmE6JuP0d9Q0KNl+h4AetEU5Xh/RQW9NB
         IJUYJApNj5An4IFLnq0MWXc4QaQng24WnidH/1yYDknvKc0A5O6yrEeUTakj4TF/0oSS
         Qd3QpW1LiJGh2NIQkz/kJLmdf3EXfPnpPVksksAnrDq/wafWtP3d5KcpX9/fmpbjuaiv
         tAhtx1US8/sKxoMlyzN3VKtrZK6PqReQpQAXUsaPO9lSSAc5njkBNWkC1Z98akBBQz5n
         8yvIKmGpPubpUn0eiJgy9D3ZGk3es4K/OimV3a2qi2fcPRQFiSXVUMJWLRcopwBoc5mw
         z/XQ==
X-Gm-Message-State: APzg51ASy4CiwzBVP+0X+gpSUhe3HUU0zIAgFz9o0B7RVhmp7bc9VMjL
        oRj+HchbMe6SymRYHyYsPpONQw==
X-Google-Smtp-Source: ANB0VdYVUlFxGypSG04C5GXCRkOYqYVaKvSP9fVF+ugC3pOY2GgmdqxLDM+H65sk6cwkB2f4ZfDq2A==
X-Received: by 2002:a17:902:bcc6:: with SMTP id o6-v6mr41640554pls.117.1537487849373;
        Thu, 20 Sep 2018 16:57:29 -0700 (PDT)
Received: from [10.21.2.196] ([209.121.128.187])
        by smtp.googlemail.com with ESMTPSA id p4-v6sm35062991pgs.75.2018.09.20.16.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 16:57:28 -0700 (PDT)
Subject: Re: [PATCH V8 1/2] clocksource: add gx6605s SOC system timer
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     tglx@linutronix.de, robh+dt@kernel.org, mark.rutland@arm.com,
        arnd@arndb.de, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, c-sky_gcc_upstream@c-sky.com,
        green.hu@gmail.com
References: <cover.1537412072.git.ren_guo@c-sky.com>
 <4d409a1fdecf1c376e8cc6b55308cd3c522047b0.1537412072.git.ren_guo@c-sky.com>
 <6c31f9b2-d536-1cee-8024-b52eb862fd9d@linaro.org>
 <20180920233103.GA8891@guoren-Inspiron-7460>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <271900ce-0019-b96d-7833-4ea5ae0721a6@linaro.org>
Date:   Fri, 21 Sep 2018 01:57:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180920233103.GA8891@guoren-Inspiron-7460>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 01:31, Guo Ren wrote:
> On Thu, Sep 20, 2018 at 06:06:19PM +0200, Daniel Lezcano wrote:
>> On 20/09/2018 10:03, Guo Ren wrote:
>>> Changelog:
>>>  - Add License and Copyright
>>>  - Use timer-of framework
>>>  - Change name with upstream feedback
>>>  - Use clksource_mmio framework
>>>
>>> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
>>> ---
>>>  drivers/clocksource/Kconfig         |   8 ++
>>>  drivers/clocksource/Makefile        |   1 +
>>>  drivers/clocksource/timer-gx6605s.c | 150 ++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 159 insertions(+)
>>>  create mode 100644 drivers/clocksource/timer-gx6605s.c
>>>
>>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>>> index a11f4ba..6d0f18d 100644
>>> --- a/drivers/clocksource/Kconfig
>>> +++ b/drivers/clocksource/Kconfig
>>> @@ -620,4 +620,12 @@ config RISCV_TIMER
>>>  	  is accessed via both the SBI and the rdcycle instruction.  This is
>>>  	  required for all RISC-V systems.
>>>  
>>> +config GX6605S_TIMER
>>> +	bool "Gx6605s SOC system timer driver"
>>> +	depends on CSKY
>>> +	select CLKSRC_MMIO
>>> +	select TIMER_OF
>>> +	help
>>> +	  This option enables support for gx6605s SOC's timer.
>>> +
>>>  endmenu
>>
>> Please make the option not visible as default. There are currently two
>> approaches look at MTK_TIMER and SPRD_TIMER.
> Em ... (ot sure why COMPILE_TEST?):
> 	bool "Gx6605s SOC system timer driver" if COMPILE_TEST
> Hmm?

Because by enabling the COMPILE_TEST, you give the opportunity to
someone without the hardware to cross-compile test your driver and catch
errors very soon before the changes hit your tree.

There are several Continuous Integration loop around running the latest
changes in the kernel (kernelci, 01.org, etc ...) and all drivers with
this flag are compiled tested.

If the option is not set, the timer is silently selected by your
platform's Kconfig only, without giving the opportunity to an non-expert
user to unselect the timer leading to, maybe, an unbootable board.


>>> +static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
>>> +{
>>> +	struct clock_event_device *ce = (struct clock_event_device *) dev;
>>
>> nit: no cast is needed.
> Yes, change to:
> 	struct clock_event_device *ce = dev;
> 
> 
>>> +static u64 notrace gx6605s_sched_clock_read(void)
>>> +{
>>> +	void __iomem *base;
>>> +
>>> +	base = timer_of_base(&to) + CLKSRC_OFFSET;
>>> +
>>> +	return (u64) readl_relaxed(base + TIMER_VALUE);
>>
>> nit: extra space after '(u64)'
> Ok
> 	return (u64)readl_relaxed(base + TIMER_VALUE);
> 
> Best Regards
>  Guo Ren
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

