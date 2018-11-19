Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23788C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC09220823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZxjchV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC09220823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbeKTJBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:01:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:47031 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730290AbeKTJB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:01:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id f23so22514193lfc.13;
        Mon, 19 Nov 2018 14:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ux2pyNmxIyOzqMlFWi5eeemz5ezqgnqrVxGbZXBCCNo=;
        b=oZxjchV3LcKsZBnS/wWX9ylcuytp6IL23VyaamsIESQK56ZcV+2UVPTP87EpNdtDe1
         KeGnqmGZm9tvTPpzMY8seOt4agDMQjkCjgZdVwTyYGovX1rdMYmTHMUu7whOnmQUQUh0
         2CFHUNItYt1OgQjV6OznpFO07uMMQuRFRSETwQf2FC+M+raTtKOgLn1IdPiMVJmPvskc
         3pM+Ij8+UuRRFxP0rEngwNwhStR+L2iuJ7JiSzz5HbWEgJvyELAaHbD/TlZkIX/x9a7O
         sbav9BXA0K2TfEeS6Blb5l7Gy+VhlkuZPO53jcaoq+bkKEPSk+y4DJaYa8NHQS9am0ww
         wm8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ux2pyNmxIyOzqMlFWi5eeemz5ezqgnqrVxGbZXBCCNo=;
        b=sm7jx5Io5Pyh5xp27VipE6JvH7gg6nMstpND4Xbz1qLSPMras7iFpi5UAT5Rfy9/1A
         2lMseyx0i9udnHTotSi9lVjpkZfETOpTsDLVMzWGUk68BDz7Wj5Rb082WwB1hD0cw1QU
         km9ZzeMzL0EuqsGZr7Z6k0zuCzEdOKlCj9y1sC9j80iuoj6u5yo6Z9BPA5EsmMcM7AIn
         SxmtVjs2uAb+SUClBTbu8fiyAeCezKNbaFYYTgQG9iajqPjOreS1g1EJHXM0NQhDsRok
         wl3fSnhoQ84Ktzw0F2TTxsf7htxjTW1o6zYvVv5XRSUmaSIk/K5yRuiV7HyeZ9/y5N8o
         4QGQ==
X-Gm-Message-State: AGRZ1gJEdSkd7JZU9CUMfx0OavYdBt1QsLaTsgIun+PwgQYQ/i4A0kVi
        HQF5oKF2qyX95vcKI5iMe6RojhXJ
X-Google-Smtp-Source: AJdET5fQy6S60ouefco+WeUEdSZuJ6PzWCS10kqXCt5V7d8ojUHpIGbF6LkFHKTBF3ujHtYDoN1swQ==
X-Received: by 2002:a19:c995:: with SMTP id z143mr10066804lff.79.1542666936015;
        Mon, 19 Nov 2018 14:35:36 -0800 (PST)
Received: from [192.168.2.145] (ppp91-76-171-181.pppoe.mtu-net.ru. [91.76.171.181])
        by smtp.googlemail.com with ESMTPSA id o72sm5948197lfg.33.2018.11.19.14.35.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Nov 2018 14:35:35 -0800 (PST)
Subject: Re: [PATCH v1 4/4] ARM: tegra: Clear EMC interrupts on resume from
 LP1 on Tegra30+
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-5-digetx@gmail.com>
 <9c085248-41df-c8be-294d-6bf8b95c1085@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <60898d23-63a1-caf5-8fd4-2bbd7bb6aaab@gmail.com>
Date:   Tue, 20 Nov 2018 01:35:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <9c085248-41df-c8be-294d-6bf8b95c1085@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.11.2018 1:00, Jon Hunter wrote:
> 
> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>> Two interrupts are raised on resume from LP1 on Tegra30+: first is the
>> clock change completed interrupt which is set after updating timing
>> configuration, second is DLL alarm interrupt which is set when DLL
>> starts re-calibration after being reset. Clear these two interrupts
>> in the end of exiting from the self-refresh mode for consistency, that
>> will also allow to not receive spurious interrupts in the EMC driver
>> after resume from suspend.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  arch/arm/mach-tegra/sleep-tegra30.S | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>> index 828f6c37afde..78c6e9fb56e7 100644
>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>> @@ -26,6 +26,7 @@
>>  #include "irammap.h"
>>  #include "sleep.h"
>>  
>> +#define EMC_INTSTATUS			0x0
>>  #define EMC_CFG				0xc
>>  #define EMC_ADR_CFG			0x10
>>  #define EMC_TIMING_CONTROL		0x28
>> @@ -44,6 +45,9 @@
>>  #define EMC_XM2VTTGENPADCTRL		0x310
>>  #define EMC_XM2VTTGENPADCTRL2		0x314
>>  
>> +#define EMC_CLKCHANGE_COMPLETE_INT	(1 << 4)
>> +#define EMC_DLL_ALARM_INT		(1 << 7)
>> +
>>  #define MC_EMEM_ARB_CFG			0x90
>>  
>>  #define PMC_CTRL			0x0
>> @@ -539,6 +543,9 @@ zcal_done:
>>  
>>  	emc_timing_update r1, r0
>>  
>> +	mov	r1, #(EMC_CLKCHANGE_COMPLETE_INT | EMC_DLL_ALARM_INT)
>> +	str	r1, [r0, #EMC_INTSTATUS]	@ clear interrupts
>> +
>>  	/* Tegra114 had dual EMC channel, now config the other one */
>>  	cmp	r10, #TEGRA114
>>  	bne	__no_dual_emc_chanl
>>
> 
> Where are these interrupts enabled? I did not see where they are
> enabled. I see that the Tegra24 EMC driver does poll these, but it did
> not look like they were enabled. If they are enabled, I wondering if
> they should be masked on entering self-refresh?

EMC interrupt is not enabled on Tegra124. IIRC, it doesn't use the interrupt at all in the driver. Indeed, T124 EMC driver polls the interrupt status, but it clears the status before starting to poll. Probably I was just thinking about to write T30 EMC driver at that time and to utilize the interrupt.. 

Seems it should be okay to drop this patch for now, but maybe then we will have to return to it sometime later. Up to you to decide.
