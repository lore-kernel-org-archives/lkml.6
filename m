Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC525C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF98A218D9
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 12:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SpCQq6XH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfAYMTR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 07:19:17 -0500
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8468 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfAYMTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 07:19:17 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c4afe9e0000>; Fri, 25 Jan 2019 04:18:38 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 25 Jan 2019 04:19:14 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 25 Jan 2019 04:19:14 -0800
Received: from [10.25.74.160] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 12:19:10 +0000
Subject: Re: [PATCH v2] ALSA: hda/tegra: enable clock during probe
To:     Jon Hunter <jonathanh@nvidia.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>
CC:     <thierry.reding@gmail.com>, <rlokhande@nvidia.com>,
        <sharadg@nvidia.com>, <mkumard@nvidia.com>,
        <alsa-devel@alsa-project.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1548414418-5785-1-git-send-email-spujar@nvidia.com>
 <ae87a09f-2922-9a9d-3ad3-e9abe7fb20c2@nvidia.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <c18a8c49-8696-318d-50c8-d5c6a0a5a7d2@nvidia.com>
Date:   Fri, 25 Jan 2019 17:49:07 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ae87a09f-2922-9a9d-3ad3-e9abe7fb20c2@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1548418718; bh=THNupmAxbHQ9zJlUhh3neVSsqXi4Tf+Anwu6Wj3+n8I=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=SpCQq6XH1tUTA37IpmTMIzN5PIQd9vdZ2812YK8ooijmKpj6ZEH3F9C0zoCJsyftL
         1+GcDsqYkIeFNMbocTdhj9/KFGbPj8L/lI0aCwdcf6U7M9tDXZ/90DWqLKgWqin11V
         EDT5HmVR7APBZV8K0R0JukpC47kqjiD8ImuF40PyPO2+YgNqSjpWen2gGVjqpfM4To
         BP62TNeT0s4eFjTxy55qyig1klRRY6TdtpiDHLVBk7p3WW8Do8JAdpxZluG8n+NqDF
         JUPjw8C1xMWEM/w7Zq3SjS3Fbczwerhqs5dRzf5mvPdk9pNPCeL+IVzKc5HGKUYpX1
         iOR2v4WzRp4vQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/25/2019 5:12 PM, Jon Hunter wrote:
> On 25/01/2019 11:06, Sameer Pujar wrote:
>> If CONFIG_PM is disabled or runtime PM calls are forbidden, the clocks
>> will not be ON. This could cause issue during probe, where hda init
>> setup is done. This patch enables clocks unconditionally during probe.
>>
>> Along with above, follwoing changes are done.
>>    * enable runtime PM before exiting from probe work. This helps to avoid
>>      usage of pm_runtime_get_sync/pm_runtime_put() in probe work.
>>    * hda_tegra_disable_clocks() is moved out of CONFIG_PM_SLEEP check.
>>    * runtime PM callbacks moved out of CONFIG_PM check
>>
>> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
>> Reviewed-by: Ravindra Lokhande <rlokhande@nvidia.com>
>> Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
>> ---
>>   sound/pci/hda/hda_tegra.c | 26 +++++++++++++++++---------
>>   1 file changed, 17 insertions(+), 9 deletions(-)
>>
>> diff --git a/sound/pci/hda/hda_tegra.c b/sound/pci/hda/hda_tegra.c
>> index c8d18dc..ba6175f 100644
>> --- a/sound/pci/hda/hda_tegra.c
>> +++ b/sound/pci/hda/hda_tegra.c
>> @@ -219,7 +219,6 @@ static int hda_tegra_enable_clocks(struct hda_tegra *data)
>>   	return rc;
>>   }
>>   
>> -#ifdef CONFIG_PM_SLEEP
>>   static void hda_tegra_disable_clocks(struct hda_tegra *data)
>>   {
>>   	clk_disable_unprepare(data->hda2hdmi_clk);
>> @@ -227,6 +226,7 @@ static void hda_tegra_disable_clocks(struct hda_tegra *data)
>>   	clk_disable_unprepare(data->hda_clk);
>>   }
>>   
>> +#ifdef CONFIG_PM_SLEEP
>>   /*
>>    * power management
>>    */
>> @@ -257,7 +257,6 @@ static int hda_tegra_resume(struct device *dev)
>>   }
>>   #endif /* CONFIG_PM_SLEEP */
>>   
>> -#ifdef CONFIG_PM
>>   static int hda_tegra_runtime_suspend(struct device *dev)
>>   {
>>   	struct snd_card *card = dev_get_drvdata(dev);
>> @@ -283,7 +282,7 @@ static int hda_tegra_runtime_resume(struct device *dev)
>>   	int rc;
>>   
>>   	rc = hda_tegra_enable_clocks(hda);
>> -	if (rc != 0)
>> +	if (rc)
>>   		return rc;
>>   	if (chip && chip->running) {
>>   		hda_tegra_init(hda);
>> @@ -292,7 +291,6 @@ static int hda_tegra_runtime_resume(struct device *dev)
>>   
>>   	return 0;
>>   }
>> -#endif /* CONFIG_PM */
>>   
>>   static const struct dev_pm_ops hda_tegra_pm = {
>>   	SET_SYSTEM_SLEEP_PM_OPS(hda_tegra_suspend, hda_tegra_resume)
>> @@ -551,9 +549,9 @@ static int hda_tegra_probe(struct platform_device *pdev)
>>   
>>   	dev_set_drvdata(&pdev->dev, card);
>>   
>> -	pm_runtime_enable(hda->dev);
>> -	if (!azx_has_pm_runtime(chip))
>> -		pm_runtime_forbid(hda->dev);
>> +	err = hda_tegra_enable_clocks(hda);
>> +	if (err)
>> +		goto out_free;
>>   
>>   	schedule_work(&hda->probe_work);
>>   
>> @@ -571,7 +569,6 @@ static void hda_tegra_probe_work(struct work_struct *work)
>>   	struct platform_device *pdev = to_platform_device(hda->dev);
>>   	int err;
>>   
>> -	pm_runtime_get_sync(hda->dev);
>>   	err = hda_tegra_first_init(chip, pdev);
>>   	if (err < 0)
>>   		goto out_free;
>> @@ -592,8 +589,15 @@ static void hda_tegra_probe_work(struct work_struct *work)
>>   	chip->running = 1;
>>   	snd_hda_set_power_save(&chip->bus, power_save * 1000);
>>   
>> +	/* set device state as active */
>> +	if (pm_runtime_set_active(hda->dev) < 0)
>> +		goto out_free;
>> +	/* enable runtime PM */
>> +	pm_runtime_enable(hda->dev);
>> +	if (!azx_has_pm_runtime(chip))
>> +		pm_runtime_forbid(hda->dev);
>> +
>>    out_free:
>> -	pm_runtime_put(hda->dev);
>>   	return; /* no error return from async probe */
>>   }
>>   
>> @@ -603,6 +607,10 @@ static int hda_tegra_remove(struct platform_device *pdev)
>>   
>>   	ret = snd_card_free(dev_get_drvdata(&pdev->dev));
>>   	pm_runtime_disable(&pdev->dev);
>> +	if (!pm_runtime_status_suspended(&pdev->dev)) {
>> +		hda_tegra_runtime_suspend(&pdev->dev);
>> +		pm_runtime_set_suspended(&pdev->dev);
>> +	}
> I think that we need to be consistent in the above with what is done in
> the probe. If in the probe we call hda_tegra_enable_clocks(), then here
> we should call hda_tegra_disable_clocks(). However, my preference is
> still to all hda_tegra_runtime_resume() in probe and then leave the
> above as-is. Let's see what everyone else thinks.
Though it is good to have the handling at a single place, it is slightly 
confusing to call
runtime_resume() in probe. When runtime PM is not yet enabled, why call 
something that is related
to it(not logically but intuitively)!

What we can possibly follow is,
1. Till probe() completes, handle things explicitly.
2. Before returning from successful probe, handle control to runtime PM.

Nevertheless, shall go with the majority of the opinion.

Thanks,
Sameer.

> Cheers
> Jon
>
