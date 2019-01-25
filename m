Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E354C282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB99D2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 03:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="JJWeXQsJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfAYDXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 22:23:17 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1601 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbfAYDXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 22:23:16 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4a810a0018>; Thu, 24 Jan 2019 19:22:50 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 19:23:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 24 Jan 2019 19:23:15 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 03:23:13 +0000
Subject: Re: [PATCH 1/6] dt-bindings: timer: add Tegra210 timer
To:     Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-arm-kernel@lists.infradead.org>
References: <20190107032810.13522-1-josephl@nvidia.com>
 <20190107032810.13522-2-josephl@nvidia.com>
 <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <285bd3f7-e1c0-0767-6381-4b1d748bd6db@nvidia.com>
Date:   Fri, 25 Jan 2019 11:23:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <a5fec080-d388-5362-7f44-b50f7d7e1adf@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548386570; bh=Vf5raOr5Nltjpm3Hj7ObWfFqyEkrUq7A+aU6p8IhhSw=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=JJWeXQsJZvBtgdeg0lEZYjrUZfoLupOTw+CSme5n4wQ1ilgtNeLTxtahC5PaS0FXt
         vYu+UV4vgc874NHCR54sgBuxYHX5WtH1a9fCxvUFMtSEGytIEAaax0MdaIkMASBemH
         iEWIfD2WlgrJn5mVP9Vm3d5B/apbgR9MikHyZBwxo7jzd1VrF6JpQvSpztV0Zr+VJl
         WBNQlAfEPlrgX/70ICRtUYtYkzU5j7MXJlg1qjb/1qOCgH+oylsJKzjY5r4a1duXHF
         m40+9C7pWDca/dYaYtBa4cmxduVeXs096siOqPKslstig7VlNWA0FZeiZjarH1zkis
         ehmylk8fCgb3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

Thanks for reviewing.

On 1/24/19 6:30 PM, Jon Hunter wrote:
> 
> On 07/01/2019 03:28, Joseph Lo wrote:
>> The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
>> timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
>> from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
>> (TMR10-TMR13). Each TMR can be programmed to generate one-shot periodic,
>> or watchdog interrupts.
>>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>> ---
>>   .../bindings/timer/nvidia,tegra210-timer.txt  | 25 +++++++++++++++++++
>>   1 file changed, 25 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>>
>> diff --git a/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>> new file mode 100644
>> index 000000000000..ba511220a669
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/nvidia,tegra210-timer.txt
>> @@ -0,0 +1,25 @@
>> +NVIDIA Tegra210 timer
>> +
>> +The Tegra210 timer provides fourteen 29-bit timer counters and one 32-bit
>> +timestamp counter. The TMRs run at either a fixed 1 MHz clock rate derived
>> +from the oscillator clock (TMR0-TMR9) or directly at the oscillator clock
>> +(TMR10-TMR13). Each TMR can be programmed to generate one-shot, periodic,
>> +or watchdog interrupts.
>> +
>> +Required properties:
>> +- compatible : "nvidia,tegra210-timer".
>> +- reg : Specifies base physical address and size of the registers.
>> +- interrupts : A list of 4 interrupts; one per each of TMR10 through TMR13.
> 
> Why do we only add the interrupts for TMR10 - TMR13? What about the others?
> 

The others (TMR0-TMR9) are occupied for other usages. TMR5 is occupied 
for the watchdog timer in the upstream kernel. And others (still in 
TMR0-TMR9) are occupied for different usages in our downstream kernel.

And notice that only TMR10-TMR13 are running at the oscillator clock 
(clk_m). With the Tegra210 timer driver, we introduce in this series, 
which only replace the clock event device function that was originally 
owned by the arch timer (armv8 timer) and it also running at the 
oscillator clock. The sched_timer still owns by the arch timer. So the 
timer resolution will be the same. That's why we choose TMR10-TMR13 as 
the timer for Tegra210.

Thanks,
Joseph
