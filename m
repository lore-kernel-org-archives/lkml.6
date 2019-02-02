Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60202C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD9620857
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 16:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="USbVWc+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbfBBQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 11:07:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4188 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbfBBQHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 11:07:15 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c55c0140000>; Sat, 02 Feb 2019 08:06:44 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 02 Feb 2019 08:07:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 02 Feb 2019 08:07:13 -0800
Received: from [10.19.108.132] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Sat, 2 Feb
 2019 16:07:11 +0000
Subject: Re: [PATCH V5 2/7] clocksource: tegra: add Tegra210 timer support
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Thierry Reding <treding@nvidia.com>
References: <20190201033621.16814-1-josephl@nvidia.com>
 <20190201033621.16814-3-josephl@nvidia.com>
 <9370a0e4-2c76-6e9e-9219-121f92cdb14a@gmail.com>
 <46a1a62f-29b1-caac-ba68-e1394a76b3af@gmail.com>
 <85988378-0c88-6b71-00df-0700a7b4cdf7@nvidia.com>
 <4c89fd38-eacd-4643-52d3-da4760ecb4c5@nvidia.com>
 <57549882-4d0a-64ac-da04-7e790ac2d80e@gmail.com>
 <9437d5b5-5af0-9393-169c-2ebaf384c75c@nvidia.com>
 <705a0eff-cb1e-0e7d-add7-fb1a993291dc@gmail.com>
 <a24d9152-2bcd-7276-478c-63ee6923178e@nvidia.com>
 <0a5721cc-6cbf-9f1f-6282-36b7175ce9a2@gmail.com>
From:   Joseph Lo <josephl@nvidia.com>
Message-ID: <0458731d-e245-8362-2b62-92aa5e1b7fe3@nvidia.com>
Date:   Sun, 3 Feb 2019 00:07:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <0a5721cc-6cbf-9f1f-6282-36b7175ce9a2@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL108.nvidia.com (172.18.146.13) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549123604; bh=U/hgPA9gjzdAN6f2gb2IoqoLDUP0nEaBYXEHVFU8JrM=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=USbVWc+ElA+QaTA4dYfSOs56/f5V0CR7Uu5XYpacjIiQ9QeY2FBzbTtJp79D07dyI
         cmhl2WBNPhlcGAXA8ZhAOLG/vXan1CngoNS657o5UumVUwg0rGHy3rm4cVy6WFZY4v
         niLmmde35OxD2vw6C6QKF7iiWsrek4ylB7onUGYCfzTGbSOS4e7zBCRbN2Rh3wQriw
         xyJHasE+T5j/oFBXndLoi1jJHRftJB8SopLMkk9N76gxheV1jiJIjDswhgGUQSmHQI
         tpRRbawYgNxj/utC7OQ7HeTxY4i7F7l+kxBzHSqwQv2HeHZJJBug2iT/3sN1RoiX3E
         L+drCnBIgcCfw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/19 9:38 PM, Dmitry Osipenko wrote:
> 02.02.2019 2:53, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> On 2/2/19 2:08 AM, Dmitry Osipenko wrote:
>>> 01.02.2019 18:37, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>> On 2/1/19 11:13 PM, Dmitry Osipenko wrote:
>>>>> 01.02.2019 17:13, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>> On 2/1/19 9:54 PM, Jon Hunter wrote:
>>>>>>>
>>>>>>> On 01/02/2019 13:11, Dmitry Osipenko wrote:
>>>>>>>> 01.02.2019 16:06, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>>> 01.02.2019 6:36, Joseph Lo =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>>>> Add support for the Tegra210 timer that runs at oscillator clock
>>>>>>>>>> (TMR10-TMR13). We need these timers to work as clock event devic=
e and to
>>>>>>>>>> replace the ARMv8 architected timer due to it can't survive acro=
ss the
>>>>>>>>>> power cycle of the CPU core or CPUPORESET signal. So it can't be=
 a wake-up
>>>>>>>>>> source when CPU suspends in power down state.
>>>>>>>>>>
>>>>>>>>>> Also convert the original driver to use timer-of API.
>>>>>>>>>>
>>>>>>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>>>>>>> Cc: Thomas Gleixner <tglx@linutronix.de>
>>>>>>>>>> Cc: linux-kernel@vger.kernel.org
>>>>>>>>>> Signed-off-by: Joseph Lo <josephl@nvidia.com>
>>>>>>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>>>>>>> ---
>>>> snip.
>>>>>>>>>> +}
>>>>>>>>>> +TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra=
210_timer_init);
>>>>>>>>>> +#else /* CONFIG_ARM */
>>>>>>>>>> +static int __init tegra20_init_timer(struct device_node *np)
>>>>>>>>>> +{
>>>>>>>>> What about T132? Isn't it ARM64 which uses tegra20-timer IP? At l=
east T132 DT suggests so and seems this change will break it.
>>>>>>>>>
>>>>>>>>> [snip]
>>>>>>>>>
>>>>>>>>
>>>>>>>> Ah, noticed the "depends on ARM" in Kconfig.. Seems okay then.
>>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> This is a good point, because even though we had 'depends on ARM', =
this
>>>>>>> still means that the Tegra132 DT is incorrect.
>>>>>>>
>>>>>>> Joseph, can you take a quick look at Tegra132?
>>>>>>
>>>>>> Hi Jon and Dmitry,
>>>>>>
>>>>>> No worry about T132, T132 uses arch timer (v7). The tegra20 timer dr=
iver has never been used. We should fix the dtsi file later.
>>>>>
>>>>> Hi Joseph,
>>>>>
>>>>> So is T132 HW actually incompatible with the tegra20-timer? If it's c=
ompatible, then I think the driver's code should be made more universal to =
support T132.
>>>>>
>>>>
>>>>  =C2=A0From HW point of view, the TIMER1 ~ TIMER4 is compatible with "=
nvidia,tegra20-timer". But Tegra132 actually has 10 timers which are exactl=
y the same as Tegra30. So it should backward compatible with "nvidia,tegra3=
0-timer", which is tegra_wdt driver now. And Tegra132 should never use this=
 driver.
>>>>
>>>> The Tegra timer driver should only be used on Tegra20/30/210, three pl=
atforms only. Others use arch timer driver for system timer driver.
>>>>
>>>> So we don't really need to take care the usage on other Tegra platform=
s.
>>>
>>> Doesn't Linux kernel put in use all of available timers? If yes, then w=
e probably would want to expose all available timers. It looks to me that r=
ight now tegra20-timer exposes only a single-shared timer to the system [pl=
ease correct me if I'm wrong]. Wouldn't make sense at least to give a timer=
 per CPU core?
>>>
>>
>> No, only one timer driver works at a time. ( see /proc/timer_list to che=
ck which timer is working.)
>=20
> Okay, thanks for the clarification.
>=20
>>> It looks to me that right now tegra20-timer exposes only a single-share=
d timer to the system [please correct me if I'm wrong]. Wouldn't make sense=
 at least to give a timer per CPU core?
>>
>> Yes, it's correct. the timer-tegra20 only provides a single-shared timer=
. And yes, ,it should provide a timer per CPU core. But that is another tas=
k, this patch only introduce the timer support for Tegra210. Others that or=
iginally from timer-tegra20 driver still remain the same.
>=20
> I may take a look at it. Could be better for older Tegra's to use tegra20=
-timer for the per-CPU timer since TWD timer has some time-jitter due to DV=
FS.
>=20

That would be great, thank you.
Joseph
