Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84106C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54883218D0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 13:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="H91ePaCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfAYN0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 08:26:32 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:2912 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAYN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 08:26:32 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4b0e860000>; Fri, 25 Jan 2019 05:26:30 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 05:26:31 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 05:26:31 -0800
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 13:26:29 +0000
Subject: Re: [PATCH] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>
CC:     Sameer Pujar <spujar@nvidia.com>,
        <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <thierry.reding@gmail.com>,
        <rlokhande@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1548351403-1875-1-git-send-email-spujar@nvidia.com>
 <s5h5zudc1qw.wl-tiwai@suse.de>
 <06c00ce1-32ed-8aa9-0340-d00202a8fa62@nvidia.com>
 <s5hr2d0zz96.wl-tiwai@suse.de>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <b64f5d05-f352-7b46-d70d-3809aab8ddda@nvidia.com>
Date:   Fri, 25 Jan 2019 13:26:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <s5hr2d0zz96.wl-tiwai@suse.de>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548422790; bh=PFxm0QupoaG7oKh+/xHrIXcLL7nFXDBr4VQJxJePcyQ=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=H91ePaCntofN3RWAb0zxLhM3QjxIjNW6395c12fSnxyOkp4t93bQDlSiaURrLheR2
         cmWL10c3twLfxy+GOeb70S8MTFGH63Xtig6nFcpF3jKt+tbvElmLzXv4370dZhGDHp
         RaIJaoe7VICZXTSJisWxyPDGKVN6w3OP3VJOPBJ57uANBg4tRpBLgajUXw4QND97Cl
         yhyZkebXrA4ziph8vWv12IE4S0WOxlxjyM1rmSi8qcqIX0co3YBUZt1TvKK/HEA6ww
         MuvWIe5//bUKPhto0I9sRnxk+AU9dYe0QTn6h/mn2mL80ZPEFjzglOLn49GhY+ZGf2
         cRjnh51CPDIBg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 25/01/2019 12:40, Takashi Iwai wrote:
> On Fri, 25 Jan 2019 12:36:00 +0100,
> Jon Hunter wrote:
>>
>>
>> On 24/01/2019 19:08, Takashi Iwai wrote:
>>> On Thu, 24 Jan 2019 18:36:43 +0100,
>>> Sameer Pujar wrote:
>>>>
>>>> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
>>>> will not be ON. This could cause issue during probe, where hda init
>>>> setup is done. This patch checks whether runtime PM is enabled or not.
>>>> If disabled, clocks are enabled in probe() and disabled in remove()
>>>>
>>>> This patch does following minor changes as cleanup,
>>>>   * return code check for pm_runtime_get_sync() to take care of failure
>>>>     and exit gracefully.
>>>>   * In remove path runtime PM is disabled before calling snd_card_free().
>>>>   * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>>>>   * runtime PM callbacks moved out of CONFIG_PM check
>>>>
>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>> (snip)
>>>> @@ -555,6 +553,13 @@ static int hda_tegra_probe(struct platform_device *pdev)
>>>>  	if (!azx_has_pm_runtime(chip))
>>>>  		pm_runtime_forbid(hda->dev);
>>>>  
>>>> +	/* explicit resume if runtime PM is disabled */
>>>> +	if (!pm_runtime_enabled(hda->dev)) {
>>>> +		err = hda_tegra_runtime_resume(hda->dev);
>>>> +		if (err)
>>>> +			goto out_free;
>>>> +	}
>>>> +
>>>>  	schedule_work(&hda->probe_work);
>>>
>>> Calling runtime_resume here is really confusing...
>>
>> Why? IMO it is better to have a single handler for resuming the device
>> and so if RPM is not enabled we call the handler directly. This is what
>> we have been advised to do in the past and do in other drivers. See ...
> 
> The point is that we're not "resuming" anything there.  It's in the
> early probe stage, and the device state is uninitialized, not really
> suspended.  It'd end up with just calling the same helper
> (hda_tegra_enable_clocks()), though.

Yes and you can make the same argument for every driver that calls
pm_runtime_get_sync() during probe to turn on clocks, handle resets,
etc, because at the end of the day the very first call to
pm_runtime_get_sync() invokes the runtime_resume callback, when we have
never been suspended.

Yes at the end of the day it is the same and given that we have done
this elsewhere I think it is good to be consistent if/where we can.

Furthermore, there are other various drivers in the kernel that do the
same ...

drivers/i2c/busses/i2c-img-scb.c
drivers/dma/xilinx/zynqmp_dma.c
drivers/gpu/drm/arm/malidp_drv.c

Cheers
Jon

-- 
nvpublic
