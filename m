Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194D2C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7408206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:20:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="S4zm8p5H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7408206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbeJDXN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:13:58 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:17343 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbeJDXN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:13:58 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bb63db00001>; Thu, 04 Oct 2018 09:20:00 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 04 Oct 2018 09:19:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 04 Oct 2018 09:19:59 -0700
Received: from [10.21.132.143] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 4 Oct
 2018 16:19:58 +0000
Subject: Re: [PATCH] firmware: tegra-bpmp: mark PM function as __maybe_unused
To:     Arnd Bergmann <arnd@arndb.de>, <talho@nvidia.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181002212208.2971433-1-arnd@arndb.de>
 <64a99db8-85e4-52ab-d0fa-0faa5bb7187a@nvidia.com>
 <31707122-ae73-c608-e9f6-c114d6db2b25@nvidia.com>
 <CAK8P3a1j_Gowa-aK=-3cdgvnhReVyJLigQtceDwXYNZH_tMdbQ@mail.gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <14e652c3-53d9-40f3-61fe-74f9983a0bd4@nvidia.com>
Date:   Thu, 4 Oct 2018 17:19:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1j_Gowa-aK=-3cdgvnhReVyJLigQtceDwXYNZH_tMdbQ@mail.gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL106.nvidia.com (172.18.146.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1538670001; bh=ZYhxKGrj2ldQUJeOkuXxs69YFo0WwjVwJioUS2w+V9o=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=S4zm8p5H6X66jG3FisuMQ8WSsuMYogbCcsvya4ImJ/WrUzcXW5X5uei9b7HCwwKBx
         Ls6fFd8d+JTzdazhdMwoiPEzn/ZqEq49ZIQfH15z2ka3Zu9T6z4NFaMzq5Z3hDwOMP
         VZO/Wayh2UPeO8evhc/zpoB+y7U6cOpoYjTlfCSVj/6NNgic+josYShfU90Tac3vCR
         gVNX0V4ige6oMMa8vDsmdYomx4BFOlKWVNhMl2gmhAy8QAjA0e8tBKPIxBEv9jDpq7
         W0NaveMCYc9IClSqNkdkhndystXMu6VhofIgZV0lPVxHIqx/ljNBxi/iDMzKwjveOp
         NT4kbQ+bQ8W/w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 04/10/18 16:31, Arnd Bergmann wrote:
> On Thu, Oct 4, 2018 at 5:11 PM Timo Alho <talho@nvidia.com> wrote:
>> On 03.10.2018 11:26, Jonathan Hunter wrote:
>>> On 02/10/18 22:21, Arnd Bergmann wrote:
>>>> The newly added tegra_bpmp_resume function is unused when CONFIG_PM
>>>> is disabled:
>>>>
>>>> drivers/firmware/tegra/bpmp.c:847:12: error: 'tegra_bpmp_resume' defined but not used [-Werror=unused-function]
>>>>   static int tegra_bpmp_resume(struct device *dev)
>>>>
>>>> Mark it as __maybe_unused to avoid the warning and let the compiler
>>>> drop it silently.
>>>>
>>>> Fixes: cd40f6ff124c ("firmware: tegra: bpmp: Implement suspend/resume support")
>>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>>> ---
>>>>   drivers/firmware/tegra/bpmp.c | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/firmware/tegra/bpmp.c b/drivers/firmware/tegra/bpmp.c
>>>> index 41448ba78be9..a3d5b518c10e 100644
>>>> --- a/drivers/firmware/tegra/bpmp.c
>>>> +++ b/drivers/firmware/tegra/bpmp.c
>>>> @@ -844,7 +844,7 @@ static int tegra_bpmp_probe(struct platform_device *pdev)
>>>>      return err;
>>>>   }
>>>>
>>>> -static int tegra_bpmp_resume(struct device *dev)
>>>> +static int __maybe_unused tegra_bpmp_resume(struct device *dev)
>>>>   {
>>>>      struct tegra_bpmp *bpmp = dev_get_drvdata(dev);
>>>>      unsigned int i;
>>>
>>> Arnd, is this seen with 32-bit ARM configs?
> 
> This was with a randconfig build on 64-bit ARM. I don't know exactly
> what combination of options caused it.
> 
>>> Timo, does it make sense to make BPMP dependent on ARCH_TEGRA_186_SOC
>>> and ARCH_TEGRA_194_SOC instead of just ARCH_TEGRA? For 64-bit Tegra we
>>> have a dependency on PM so this should not be seen for 64-bit Tegra.
> 
> CONFIG_PM does not imply CONFIG_PM_SLEEP, so probably it
> was just broken for PM=y, PM_SLEEP=n.

Yes that would make sense.

>> Jon, there will be eventually a BPMP driver for ARCH_TEGRA_210_SOC as
>> well. So it is probably more appropriate to make BPMP dependent on ARM64
>> & ARCH_TEGRA.
> 
> Generally speaking, we are trying to allow building all drivers at least
> with CONFIG_COMPILE_TEST, in order to get the best build coverage.

True. Thinking some more it is fine with me, so ...

Acked-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
