Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC8AC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03626218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:08:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EHEdKHHI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728125AbfAYHIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:08:47 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:9735 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbfAYHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:08:47 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4ab5d80001>; Thu, 24 Jan 2019 23:08:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 24 Jan 2019 23:08:44 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 24 Jan 2019 23:08:44 -0800
Received: from [10.24.44.159] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 07:08:41 +0000
Subject: Re: [PATCH] ALSA: hda/tegra: enable clock during probe
To:     Takashi Iwai <tiwai@suse.de>
CC:     <pierre-louis.bossart@linux.intel.com>, <perex@perex.cz>,
        <alsa-devel@alsa-project.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <rlokhande@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>
References: <1548351403-1875-1-git-send-email-spujar@nvidia.com>
 <s5h5zudc1qw.wl-tiwai@suse.de>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <4e4ef149-66b1-ce44-76a1-0221a8a7f5a7@nvidia.com>
Date:   Fri, 25 Jan 2019 12:38:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <s5h5zudc1qw.wl-tiwai@suse.de>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548400088; bh=V3jp7H4r1Cp8deGK/HW+TwiMXrynlODHIpWhYPoKaJk=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=EHEdKHHIdhuDWyl5wudx3xEEBV3+j18W/pF/JhDp/hrkvq3d3eIAAYAImtARLmjXd
         9EmKxgvCGJHWt2wf1TGH7fBcS5u46GVh1/4KfJBiHi9d0Mp0EzCi/Rkza5f4qD3mhV
         yDVN4iCxl4iEyLjCYX6TkCKlI6xkAH4VUOKurYEPQqS0nqYmSfBk/nxIvrAxMD03Jy
         zbZVOjs2K1VKwEroTpHrF6XPjcCpasW/Z6czr0rAWwxzxgXhLyG1nokmUjMIN9bY88
         HyNIT6JixObF2Eu0YPWWx/WzLKy7X2/vPXBKLstu0Y1YzxFY56uwcCHomF5u/5Zd9a
         WOHOalnUSmmUQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2019 12:38 AM, Takashi Iwai wrote:
> On Thu, 24 Jan 2019 18:36:43 +0100,
> Sameer Pujar wrote:
>> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
>> will not be ON. This could cause issue during probe, where hda init
>> setup is done. This patch checks whether runtime PM is enabled or not.
>> If disabled, clocks are enabled in probe() and disabled in remove()
>>
>> This patch does following minor changes as cleanup,
>>    * return code check for pm_runtime_get_sync() to take care of failure
>>      and exit gracefully.
>>    * In remove path runtime PM is disabled before calling snd_card_free().
>>    * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>>    * runtime PM callbacks moved out of CONFIG_PM check
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
> (snip)
>> @@ -555,6 +553,13 @@ static int hda_tegra_probe(struct platform_device *pdev)
>>   	if (!azx_has_pm_runtime(chip))
>>   		pm_runtime_forbid(hda->dev);
>>   
>> +	/* explicit resume if runtime PM is disabled */
>> +	if (!pm_runtime_enabled(hda->dev)) {
>> +		err = hda_tegra_runtime_resume(hda->dev);
>> +		if (err)
>> +			goto out_free;
>> +	}
>> +
>>   	schedule_work(&hda->probe_work);
> Calling runtime_resume here is really confusing...
>
>
>> @@ -571,7 +576,14 @@ static void hda_tegra_probe_work(struct work_struct *work)
>>   	struct platform_device *pdev = to_platform_device(hda->dev);
>>   	int err;
>>   
>> -	pm_runtime_get_sync(hda->dev);
>> +	err = pm_runtime_get_sync(hda->dev);
>> +	if (err < 0) {
>> +		dev_err(hda->dev,
>> +			"failed in pm_runtime_get_syc with err = %d\n",
>> +			err);
>> +		return;
>> +	}
> This pm_runtime_get_sync() is needed just because you enabled runtime
> PM before probe_work.  Why not deferring the runtime PM enablement
> after probing done?
I think what you are suggesting can be done and simplify things further.
I can get rid of pm_runtime_get_sync/pm_runtime_put in probe work.
> That is what we need is the hda_tegra_enable_clocks() call at probe
> unconditionally before enabling runtime PM.
>
>>   	err = hda_tegra_first_init(chip, pdev);
>>   	if (err < 0)
>>   		goto out_free;
>> @@ -599,12 +611,13 @@ static void hda_tegra_probe_work(struct work_struct *work)
>>   
>>   static int hda_tegra_remove(struct platform_device *pdev)
>>   {
>> -	int ret;
>> -
>> -	ret = snd_card_free(dev_get_drvdata(&pdev->dev));
>>   	pm_runtime_disable(&pdev->dev);
>> +	if (!pm_runtime_status_suspended(&pdev->dev)) {
>> +		hda_tegra_runtime_suspend(&pdev->dev);
>> +		pm_runtime_set_suspended(&pdev->dev);
>> +	}
>> -	return ret;
>> +	return snd_card_free(dev_get_drvdata(&pdev->dev));
>
> Forcing the suspend *before* snd_card_free() doesn't sound right.
> It's the point before the disconnect and release procedure of all the
> rest.  That is, the other hardware components are still active at this
> point.

Ok, I will keep the sequence same and publish updated version.

Thanks,
Sameer.

>
> thanks,
>
> Takashi
