Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48987C4161D
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE9420671
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 10:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Iw5UHwKs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFE9420671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbeKTUzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:55:51 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17521 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbeKTUzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:55:50 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bf3e1820000>; Tue, 20 Nov 2018 02:27:14 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 20 Nov 2018 02:27:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 20 Nov 2018 02:27:25 -0800
Received: from [10.26.11.164] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Nov
 2018 10:27:23 +0000
Subject: Re: [PATCH v1 4/4] ARM: tegra: Clear EMC interrupts on resume from
 LP1 on Tegra30+
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180830185404.7224-1-digetx@gmail.com>
 <20180830185404.7224-5-digetx@gmail.com>
 <9c085248-41df-c8be-294d-6bf8b95c1085@nvidia.com>
 <60898d23-63a1-caf5-8fd4-2bbd7bb6aaab@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <d60c4888-c95a-4ec5-ba0d-992970089449@nvidia.com>
Date:   Tue, 20 Nov 2018 10:27:21 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <60898d23-63a1-caf5-8fd4-2bbd7bb6aaab@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1542709634; bh=B/31CnwNetj8+IB1ODAnubZpXRiH87TrIOdSrP+95JY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Iw5UHwKsWZRYm15LTkCAYhKMimlpXb1lOtFzmN4yVOQFp5XtgjYub0ARPOrRGcv8/
         Qpudu8gZ0F5oB2IZqiYaWkuMVQ+/OG0YsFf2lBYF8z1SAGGo9hLApaiVwC4k+L/0oG
         FtMM3jUDgGJryoOwawKHEOIshUGSvmUAdztZUOfJiSjt3X1xpkniFeHaOLf9ikzZHc
         hQk8mVcdxFAK9yaLm1lZsh9YMw8Zmqota6IoNl0SDyQKsu/qNXs31ieJlRyvsFgAou
         ikmaDI7r6xIHuJhssm5uDhAgFtIZRVOTp2t4Ae4G/o7tqS9zJPSGh71RYGXyBI9Cts
         4n7krj0HwAJcg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/11/2018 22:35, Dmitry Osipenko wrote:
> On 20.11.2018 1:00, Jon Hunter wrote:
>>
>> On 30/08/2018 19:54, Dmitry Osipenko wrote:
>>> Two interrupts are raised on resume from LP1 on Tegra30+: first is the
>>> clock change completed interrupt which is set after updating timing
>>> configuration, second is DLL alarm interrupt which is set when DLL
>>> starts re-calibration after being reset. Clear these two interrupts
>>> in the end of exiting from the self-refresh mode for consistency, that
>>> will also allow to not receive spurious interrupts in the EMC driver
>>> after resume from suspend.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  arch/arm/mach-tegra/sleep-tegra30.S | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-tegra/sleep-tegra30.S b/arch/arm/mach-tegra/sleep-tegra30.S
>>> index 828f6c37afde..78c6e9fb56e7 100644
>>> --- a/arch/arm/mach-tegra/sleep-tegra30.S
>>> +++ b/arch/arm/mach-tegra/sleep-tegra30.S
>>> @@ -26,6 +26,7 @@
>>>  #include "irammap.h"
>>>  #include "sleep.h"
>>>  
>>> +#define EMC_INTSTATUS			0x0
>>>  #define EMC_CFG				0xc
>>>  #define EMC_ADR_CFG			0x10
>>>  #define EMC_TIMING_CONTROL		0x28
>>> @@ -44,6 +45,9 @@
>>>  #define EMC_XM2VTTGENPADCTRL		0x310
>>>  #define EMC_XM2VTTGENPADCTRL2		0x314
>>>  
>>> +#define EMC_CLKCHANGE_COMPLETE_INT	(1 << 4)
>>> +#define EMC_DLL_ALARM_INT		(1 << 7)
>>> +
>>>  #define MC_EMEM_ARB_CFG			0x90
>>>  
>>>  #define PMC_CTRL			0x0
>>> @@ -539,6 +543,9 @@ zcal_done:
>>>  
>>>  	emc_timing_update r1, r0
>>>  
>>> +	mov	r1, #(EMC_CLKCHANGE_COMPLETE_INT | EMC_DLL_ALARM_INT)
>>> +	str	r1, [r0, #EMC_INTSTATUS]	@ clear interrupts
>>> +
>>>  	/* Tegra114 had dual EMC channel, now config the other one */
>>>  	cmp	r10, #TEGRA114
>>>  	bne	__no_dual_emc_chanl
>>>
>>
>> Where are these interrupts enabled? I did not see where they are
>> enabled. I see that the Tegra24 EMC driver does poll these, but it did
>> not look like they were enabled. If they are enabled, I wondering if
>> they should be masked on entering self-refresh?
> 
> EMC interrupt is not enabled on Tegra124. IIRC, it doesn't use the interrupt at all in the driver. Indeed, T124 EMC driver polls the interrupt status, but it clears the status before starting to poll. Probably I was just thinking about to write T30 EMC driver at that time and to utilize the interrupt.. 
> 
> Seems it should be okay to drop this patch for now, but maybe then we will have to return to it sometime later. Up to you to decide.

I would be tempted to drop for now. If you have such a driver maybe the
driver should mask any interrupts it uses on suspending.

Cheers
Jon
-- 
nvpublic
