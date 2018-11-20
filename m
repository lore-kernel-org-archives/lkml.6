Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C708C4161B
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4118E2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 11:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scRpg9ao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4118E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbeKTWAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 17:00:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40839 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbeKTWAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 17:00:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so1078254lfe.7;
        Tue, 20 Nov 2018 03:32:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uhw1sUpgQSTG0IBqcQMsPrfFM1/Orv0BAbIhIkfvVAY=;
        b=scRpg9aow4DT0etuX/g3W3/sg6UCx1wyfEAIO0B9bOvryxJ7HLqbRoOOcjeOXtZ/r5
         bKn2We2H7CusPGp7cQa/DClw1vu4BrdP2AZqK653Fw4aRX+OLEwpO5qExt+R6jNhkn5K
         MwAElfeEZQa7iW2m5j5f3yugLjp6UpGIXjWJfYk4qIieQ7XBsXVYLIPGOmsmuUPaNbD3
         zL5/XDLAqAZAKBaeBE6F417zWKPQCjk8IghgL077AdgHg9fUWpkiBnbQ8FkJapBX8/1j
         3RDh8vSCgzUcuHgV9vEXqtD7WGCmngv4F3gPVK0ca7f0MHk2FTrr1Ldg871VwVbdxZaJ
         Csag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uhw1sUpgQSTG0IBqcQMsPrfFM1/Orv0BAbIhIkfvVAY=;
        b=YLA0fRnwO3C3VGW+fDW4byRFX3uelAQDtLt99/mgo5KgQrRoabbbJegSKwFLJ7Fkfk
         T9ltUa4SIICtMFq31fTLU8QKkkfNvuK2tLY6KxeQXiHvlBXk8IVX345JMvwQjZFQXts8
         hQYemZtbKAoJBWFbRqhsMRRo6V6Q9iPdvhMQAt8hl8CKm4WN3YU+UFoumsRbWLgzBw0d
         44MQ7uHAQg/mVNaWRAktCHeO7gMYfDYqMbNjSuuAC2YV1NPOHQtIJ2HrLGH42JCJW+Rv
         XHXu4QWRNGOBjPY/7DGtj4suMJcXjfL0euR7j7JcbpmGikXOatldePFBmqRUbATssGaw
         OolA==
X-Gm-Message-State: AGRZ1gICC+gZe0tKFKaHeHuD4wvBdIIPDwK1PG04YMESxjNrVaxjcL0r
        4lN+1bMsKyy/gDzmrSvBXHLsBcvr
X-Google-Smtp-Source: AJdET5f72LJuohBerisM3nOcXEdGwMZzn0yTx2OrXNzoKBTmIclfJ3fsdZ4HXtI0In/WtZ+WHqsLCw==
X-Received: by 2002:a19:4bc9:: with SMTP id y192mr916681lfa.49.1542713531364;
        Tue, 20 Nov 2018 03:32:11 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id s8-v6sm5092481ljh.14.2018.11.20.03.32.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 03:32:10 -0800 (PST)
Subject: Re: [PATCH v1 4/4] ARM: tegra: Clear EMC interrupts on resume from
 LP1 on Tegra30+
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-5-digetx@gmail.com>
 <9c085248-41df-c8be-294d-6bf8b95c1085@nvidia.com>
 <60898d23-63a1-caf5-8fd4-2bbd7bb6aaab@gmail.com>
 <d60c4888-c95a-4ec5-ba0d-992970089449@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0f4dfa92-e534-4ea5-cdad-1a68465384e5@gmail.com>
Date:   Tue, 20 Nov 2018 14:32:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <d60c4888-c95a-4ec5-ba0d-992970089449@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 13:27, Jon Hunter wrote:
> 
> On 19/11/2018 22:35, Dmitry Osipenko wrote:
>> On 20.11.2018 1:00, Jon Hunter wrote:
>>>
>>> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>>>> Two interrupts are raised on resume from LP1 on Tegra30+: first is the
>>>> clock change completed interrupt which is set after updating timing
>>>> configuration, second is DLL alarm interrupt which is set when DLL
>>>> starts re-calibration after being reset. Clear these two interrupts
>>>> in the end of exiting from the self-refresh mode for consistency, that
>>>> will also allow to not receive spurious interrupts in the EMC driver
>>>> after resume from suspend.
>>>>
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  arch/arm/mach-tegra/sleep-tegra30.S | 7 +++++++
>>>>  1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>>>> index 828f6c37afde..78c6e9fb56e7 100644
>>>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>>>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>>>> @@ -26,6 +26,7 @@
>>>>  #include "irammap.h"
>>>>  #include "sleep.h"
>>>>  
>>>> +#define EMC_INTSTATUS			0x0
>>>>  #define EMC_CFG				0xc
>>>>  #define EMC_ADR_CFG			0x10
>>>>  #define EMC_TIMING_CONTROL		0x28
>>>> @@ -44,6 +45,9 @@
>>>>  #define EMC_XM2VTTGENPADCTRL		0x310
>>>>  #define EMC_XM2VTTGENPADCTRL2		0x314
>>>>  
>>>> +#define EMC_CLKCHANGE_COMPLETE_INT	(1 << 4)
>>>> +#define EMC_DLL_ALARM_INT		(1 << 7)
>>>> +
>>>>  #define MC_EMEM_ARB_CFG			0x90
>>>>  
>>>>  #define PMC_CTRL			0x0
>>>> @@ -539,6 +543,9 @@ zcal_done:
>>>>  
>>>>  	emc_timing_update r1, r0
>>>>  
>>>> +	mov	r1, #(EMC_CLKCHANGE_COMPLETE_INT | EMC_DLL_ALARM_INT)
>>>> +	str	r1, [r0, #EMC_INTSTATUS]	@ clear interrupts
>>>> +
>>>>  	/* Tegra114 had dual EMC channel, now config the other one */
>>>>  	cmp	r10, #TEGRA114
>>>>  	bne	__no_dual_emc_chanl
>>>>
>>>
>>> Where are these interrupts enabled? I did not see where they are
>>> enabled. I see that the Tegra24 EMC driver does poll these, but it did
>>> not look like they were enabled. If they are enabled, I wondering if
>>> they should be masked on entering self-refresh?
>>
>> EMC interrupt is not enabled on Tegra124. IIRC, it doesn't use the interrupt at all in the driver. Indeed, T124 EMC driver polls the interrupt status, but it clears the status before starting to poll. Probably I was just thinking about to write T30 EMC driver at that time and to utilize the interrupt.. 
>>
>> Seems it should be okay to drop this patch for now, but maybe then we will have to return to it sometime later. Up to you to decide.
> 
> I would be tempted to drop for now. If you have such a driver maybe the
> driver should mask any interrupts it uses on suspending.

I don't have such driver yet. Masking interrupts on suspend and clearing status on resume within the driver should result in possibility to miss some trouble that happened between "CPU wake"->"EMC driver resuming", but probably that's not too important and unlikely to happen.
