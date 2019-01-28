Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88DDAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47FF020989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 06:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="T9prp+Im"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbfA1GHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 01:07:07 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:9257 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfA1GHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 01:07:07 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4e9bee0001>; Sun, 27 Jan 2019 22:06:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sun, 27 Jan 2019 22:07:05 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sun, 27 Jan 2019 22:07:05 -0800
Received: from [10.25.73.128] (172.20.13.39) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 28 Jan
 2019 06:07:01 +0000
Subject: Re: [PATCH] ALSA: hda/tegra: enable clock during probe
To:     Jon Hunter <jonathanh@nvidia.com>, Takashi Iwai <tiwai@suse.de>
CC:     <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <thierry.reding@gmail.com>,
        <rlokhande@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
References: <1548351403-1875-1-git-send-email-spujar@nvidia.com>
 <s5h5zudc1qw.wl-tiwai@suse.de>
 <06c00ce1-32ed-8aa9-0340-d00202a8fa62@nvidia.com>
 <s5hr2d0zz96.wl-tiwai@suse.de>
 <b64f5d05-f352-7b46-d70d-3809aab8ddda@nvidia.com>
 <s5hef90zvo0.wl-tiwai@suse.de>
 <1f4c5185-e518-5674-4a8c-4e7db64aa0d3@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <da021878-5d89-c6d3-e5b2-4ab20f9b573b@nvidia.com>
Date:   Mon, 28 Jan 2019 11:36:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1f4c5185-e518-5674-4a8c-4e7db64aa0d3@nvidia.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548655598; bh=GFZcwXLa6LPwIIvxavnHw88/gvFXO3VncSuyrjhKamY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=T9prp+ImgkKAeujHQRjvvREqpaaJCTgosA8b3uTCWbWWvMNUABuWHGRh7wR61urgt
         UPRiH9+7z/tWex9o9446/61PxsqCCW3iYVQE59lt4xBm/BW40S9Ikdz4BeMaBM0vA6
         Vxnm1xndmRMfQyJTIh2CItoCBfu88sSVLDqrG8sihoJmwCv86pFfAmubemb0+T+2OL
         XeqFgnpHIyNqUX0+edFc/aOZMNzCn2JfQ5qekQo+lJ866CbTz/teWMlZ7U/0xEFOaO
         7s/TaHo5oWH/jUq0cWEpDLMZNhED2huGquDbYV/q4AxxDhwzwfA+sujtd0HpAQ2gay
         uhP1vOEbhq8+g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2019 7:34 PM, Jon Hunter wrote:
> On 25/01/2019 13:58, Takashi Iwai wrote:
>> On Fri, 25 Jan 2019 14:26:27 +0100,
>> Jon Hunter wrote:
>>>
>>> On 25/01/2019 12:40, Takashi Iwai wrote:
>>>> On Fri, 25 Jan 2019 12:36:00 +0100,
>>>> Jon Hunter wrote:
>>>>>
>>>>> On 24/01/2019 19:08, Takashi Iwai wrote:
>>>>>> On Thu, 24 Jan 2019 18:36:43 +0100,
>>>>>> Sameer Pujar wrote:
>>>>>>> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
>>>>>>> will not be ON. This could cause issue during probe, where hda init
>>>>>>> setup is done. This patch checks whether runtime PM is enabled or not.
>>>>>>> If disabled, clocks are enabled in probe() and disabled in remove()
>>>>>>>
>>>>>>> This patch does following minor changes as cleanup,
>>>>>>>    * return code check for pm_runtime_get_sync() to take care of failure
>>>>>>>      and exit gracefully.
>>>>>>>    * In remove path runtime PM is disabled before calling snd_card_free().
>>>>>>>    * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>>>>>>>    * runtime PM callbacks moved out of CONFIG_PM check
>>>>>>>
>>>>>>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>>>>>>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>>>>>>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>>>>>> (snip)
>>>>>>> @@ -555,6 +553,13 @@ static int hda_tegra_probe(struct platform_device *pdev)
>>>>>>>   	if (!azx_has_pm_runtime(chip))
>>>>>>>   		pm_runtime_forbid(hda->dev);
>>>>>>>   
>>>>>>> +	/* explicit resume if runtime PM is disabled */
>>>>>>> +	if (!pm_runtime_enabled(hda->dev)) {
>>>>>>> +		err = hda_tegra_runtime_resume(hda->dev);
>>>>>>> +		if (err)
>>>>>>> +			goto out_free;
>>>>>>> +	}
>>>>>>> +
>>>>>>>   	schedule_work(&hda->probe_work);
>>>>>> Calling runtime_resume here is really confusing...
>>>>> Why? IMO it is better to have a single handler for resuming the device
>>>>> and so if RPM is not enabled we call the handler directly. This is what
>>>>> we have been advised to do in the past and do in other drivers. See ...
>>>> The point is that we're not "resuming" anything there.  It's in the
>>>> early probe stage, and the device state is uninitialized, not really
>>>> suspended.  It'd end up with just calling the same helper
>>>> (hda_tegra_enable_clocks()), though.
>>> Yes and you can make the same argument for every driver that calls
>>> pm_runtime_get_sync() during probe to turn on clocks, handle resets,
>>> etc, because at the end of the day the very first call to
>>> pm_runtime_get_sync() invokes the runtime_resume callback, when we have
>>> never been suspended.
>> Although there are some magical pm_runtime_*() in some places, most of
>> such pm_runtime_get_sync() is for the actual runtime PM management (to
>> prevent the runtime suspend), while the code above is for explicitly
>> setting up something for non-PM cases.
>>
>> And if pm_runtime_get_sync() is obviously superfluous, we should
>> remove such calls.  Really.
> Yes agree.
>
>>> Yes at the end of the day it is the same and given that we have done
>>> this elsewhere I think it is good to be consistent if/where we can.
>> The code becomes less readable, and that's a good reason against it :)
> I don't its less readable. However, I do think it is less error prone :-)

Do we have a consensus here? Request others to provide opinions to help 
close on this.

Thanks,
Sameer.

> Jon
>
