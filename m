Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_MIXED_ES autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6F2C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CE820839
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 13:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFCmDfOf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6CE820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeLLNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 08:52:30 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45968 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbeLLNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 08:52:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so13534497lfa.12;
        Wed, 12 Dec 2018 05:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cDcfoEyKqgqxq0f4H6ShPhCBOXCyALx65ifdUSwOIM4=;
        b=RFCmDfOff30EI04t1FxT2aNi3s7RzOrTGRYX+nAwF5ISntKDLo3RsKBDrWGE6kGe+s
         7ERYgl9QGah0XFWhAQmE/8VUy6spVwUceQg44jFMZBBA0HYdx32YzUwCf2RyfYkyCGd1
         jrcptHmAdYrj1OBAJ7AAoutPYD4wHhUo1RqPBd7JdbC0I0yDuKyl+u62TYKj6HLCLQGE
         HAQfpkk5w2Tcdb/8A4BphXg/hh6el7fCxgfdY1necYUBNClf3DMZ9YIRRrPn4m7Mxt0v
         1znESBVBS2VubZ401N7iD/Mx5iNAlnOAuQds5b4GFXPsTJpNE7X5A9VJb/iaTrTBateg
         bgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cDcfoEyKqgqxq0f4H6ShPhCBOXCyALx65ifdUSwOIM4=;
        b=o3KKOApmjO0JoYUkFiabh6004Ozd65ncynuZjuUC7u1SoVyELyd4KebiTN72D1bAbD
         LwuOf4+k56sG1TnqgYgybHIAxSnHpwTzxmrQBFtxX9FlIvyEz2qLpb4oPBOl9OPUvylN
         JaCk3IhvA2owEFGA/hiPKeMD5QPUVJuWYAce1hIick7W5NwKaTb0HmFBTvYMHV4hAIbD
         4T7mxAvqo04vbXM8P8jzcxvYcLu808A+wWOv+Ws0wU14elNnT84hTbJGmN4nie7aheJy
         dqZhKAWBoK+C5G1wowgR05sUFjtuqovB8NegTL1yLg2s7p4xJ7ECr3bOodrTZhdJ384P
         MJ/g==
X-Gm-Message-State: AA+aEWbNuZ+i55+U4apduZ96T9yagBQYHaH6KsjPpTj2/Bc13nRBY2c4
        u43KSDsMCH+gcRm4nHhAarXQlSVS
X-Google-Smtp-Source: AFSGD/UPXT3AOWiFbKQNGRYFoUGi36F3ogrX5kg90wttHCt3vKFHEEMg04nXgT2baxHP0xinPc/Hhg==
X-Received: by 2002:a19:2106:: with SMTP id h6mr11418069lfh.29.1544622744857;
        Wed, 12 Dec 2018 05:52:24 -0800 (PST)
Received: from [192.168.2.145] ([94.29.36.169])
        by smtp.googlemail.com with ESMTPSA id n16sm3226628lfl.35.2018.12.12.05.52.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 05:52:24 -0800 (PST)
Subject: Re: [PATCH v6 13/21] iommu/tegra: gart: Integrate with Memory
 Controller driver
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181209202950.31486-1-digetx@gmail.com>
 <20181209202950.31486-14-digetx@gmail.com> <20181212101407.GJ15092@ulmo>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ee3cc3cc-e046-62b8-0f55-243e9a3ef9d0@gmail.com>
Date:   Wed, 12 Dec 2018 16:52:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181212101407.GJ15092@ulmo>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.12.2018 13:14, Thierry Reding wrote:
> On Sun, Dec 09, 2018 at 11:29:42PM +0300, Dmitry Osipenko wrote:
>> The device-tree binding has been changed. There is no separate GART device
>> anymore, it is squashed into the Memory Controller. Integrate GART module
>> with the MC in a way it is done for the SMMU of Tegra30+.
>>
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/iommu/Kconfig      |  1 +
>>  drivers/iommu/tegra-gart.c | 77 ++++++++++++--------------------------
>>  drivers/memory/tegra/mc.c  | 41 ++++++++++++++++++++
>>  include/soc/tegra/mc.h     | 27 +++++++++++++
>>  4 files changed, 93 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> index d9a25715650e..83c099bb7288 100644
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -282,6 +282,7 @@ config ROCKCHIP_IOMMU
>>  config TEGRA_IOMMU_GART
>>  	bool "Tegra GART IOMMU Support"
>>  	depends on ARCH_TEGRA_2x_SOC
>> +	depends on TEGRA_MC
>>  	select IOMMU_API
>>  	help
>>  	  Enables support for remapping discontiguous physical memory
>> diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
>> index 835fea461c59..0a72b6afa842 100644
>> --- a/drivers/iommu/tegra-gart.c
>> +++ b/drivers/iommu/tegra-gart.c
>> @@ -19,16 +19,17 @@
>>   * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
>>   */
>>  
>> -#include <linux/init.h>
>>  #include <linux/io.h>
>>  #include <linux/iommu.h>
>>  #include <linux/list.h>
>>  #include <linux/moduleparam.h>
>> -#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>>  #include <linux/slab.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/vmalloc.h>
>>  
>> +#include <soc/tegra/mc.h>
>> +
>>  /* bitmap of the page sizes currently supported */
>>  #define GART_IOMMU_PGSIZES	(SZ_4K)
>>  
>> @@ -397,9 +398,8 @@ static const struct iommu_ops gart_iommu_ops = {
>>  	.iotlb_sync	= gart_iommu_sync,
>>  };
>>  
>> -static int tegra_gart_suspend(struct device *dev)
>> +int tegra_gart_suspend(struct gart_device *gart)
>>  {
>> -	struct gart_device *gart = dev_get_drvdata(dev);
>>  	unsigned long iova;
>>  	u32 *data = gart->savedata;
>>  	unsigned long flags;
>> @@ -411,9 +411,8 @@ static int tegra_gart_suspend(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int tegra_gart_resume(struct device *dev)
>> +int tegra_gart_resume(struct gart_device *gart)
>>  {
>> -	struct gart_device *gart = dev_get_drvdata(dev);
>>  	unsigned long flags;
>>  
>>  	spin_lock_irqsave(&gart->pte_lock, flags);
>> @@ -422,41 +421,39 @@ static int tegra_gart_resume(struct device *dev)
>>  	return 0;
>>  }
>>  
>> -static int tegra_gart_probe(struct platform_device *pdev)
>> +struct gart_device *tegra_gart_probe(struct device *dev,
>> +				     const struct tegra_smmu_soc *soc,
>> +				     struct tegra_mc *mc)
>>  {
>>  	struct gart_device *gart;
>> -	struct resource *res, *res_remap;
>> +	struct resource *res_remap;
>>  	void __iomem *gart_regs;
>> -	struct device *dev = &pdev->dev;
>>  	int ret;
>>  
>>  	BUILD_BUG_ON(PAGE_SHIFT != GART_PAGE_SHIFT);
>>  
>> +	/* Tegra30+ has an SMMU and no GART */
>> +	if (soc)
>> +		return NULL;
> 
> This looks weird. Why do we even call tegra_gart_probe() on anything but
> Tegra20?

Probably because I just wanted to replicate the weirdness of calling tegra_smmu_probe() on Tegra20.. for consistency.

>> +
>>  	/* the GART memory aperture is required */
>> -	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> -	res_remap = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> -	if (!res || !res_remap) {
>> +	res_remap = platform_get_resource(to_platform_device(dev),
>> +					  IORESOURCE_MEM, 1);
>> +	if (!res_remap) {
>>  		dev_err(dev, "GART memory aperture expected\n");
>> -		return -ENXIO;
>> +		return ERR_PTR(-ENXIO);
>>  	}
>>  
>>  	gart = devm_kzalloc(dev, sizeof(*gart), GFP_KERNEL);
>>  	if (!gart) {
>>  		dev_err(dev, "failed to allocate gart_device\n");
>> -		return -ENOMEM;
>> +		return ERR_PTR(-ENOMEM);
>>  	}
>>  
>> -	gart_regs = devm_ioremap(dev, res->start, resource_size(res));
>> -	if (!gart_regs) {
>> -		dev_err(dev, "failed to remap GART registers\n");
>> -		return -ENXIO;
>> -	}
>> -
>> -	ret = iommu_device_sysfs_add(&gart->iommu, &pdev->dev, NULL,
>> -				     dev_name(&pdev->dev));
>> +	ret = iommu_device_sysfs_add(&gart->iommu, dev, NULL, "gart");
>>  	if (ret) {
>>  		dev_err(dev, "Failed to register IOMMU in sysfs\n");
>> -		return ret;
>> +		return ERR_PTR(ret);
>>  	}
>>  
>>  	iommu_device_set_ops(&gart->iommu, &gart_iommu_ops);
>> @@ -468,7 +465,8 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>  		goto remove_sysfs;
>>  	}
>>  
>> -	gart->dev = &pdev->dev;
>> +	gart->dev = dev;
>> +	gart_regs = mc->regs + GART_REG_BASE;
>>  	spin_lock_init(&gart->pte_lock);
>>  	spin_lock_init(&gart->client_lock);
>>  	INIT_LIST_HEAD(&gart->client);
>> @@ -483,46 +481,19 @@ static int tegra_gart_probe(struct platform_device *pdev)
>>  		goto unregister_iommu;
>>  	}
>>  
>> -	platform_set_drvdata(pdev, gart);
>>  	do_gart_setup(gart, NULL);
>>  
>>  	gart_handle = gart;
>>  
>> -	return 0;
>> +	return gart;
>>  
>>  unregister_iommu:
>>  	iommu_device_unregister(&gart->iommu);
>>  remove_sysfs:
>>  	iommu_device_sysfs_remove(&gart->iommu);
>>  
>> -	return ret;
>> -}
>> -
>> -static const struct dev_pm_ops tegra_gart_pm_ops = {
>> -	.suspend	= tegra_gart_suspend,
>> -	.resume		= tegra_gart_resume,
>> -};
>> -
>> -static const struct of_device_id tegra_gart_of_match[] = {
>> -	{ .compatible = "nvidia,tegra20-gart", },
>> -	{ },
>> -};
>> -
>> -static struct platform_driver tegra_gart_driver = {
>> -	.probe		= tegra_gart_probe,
>> -	.driver = {
>> -		.name	= "tegra-gart",
>> -		.pm	= &tegra_gart_pm_ops,
>> -		.of_match_table = tegra_gart_of_match,
>> -		.suppress_bind_attrs = true,
>> -	},
>> -};
>> -
>> -static int __init tegra_gart_init(void)
>> -{
>> -	return platform_driver_register(&tegra_gart_driver);
>> +	return ERR_PTR(ret);
>>  }
>> -subsys_initcall(tegra_gart_init);
>>  
>>  module_param(gart_debug, bool, 0644);
>>  MODULE_PARM_DESC(gart_debug, "Enable GART debugging");
>> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
>> index 55ecfb2d8cfd..4cae1c3a853b 100644
>> --- a/drivers/memory/tegra/mc.c
>> +++ b/drivers/memory/tegra/mc.c
>> @@ -702,13 +702,54 @@ static int tegra_mc_probe(struct platform_device *pdev)
>>  				PTR_ERR(mc->smmu));
>>  	}
>>  
>> +	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART)) {
>> +		mc->gart = tegra_gart_probe(&pdev->dev, mc->soc->smmu, mc);
>> +		if (IS_ERR(mc->gart))
>> +			dev_err(&pdev->dev, "failed to probe GART: %ld\n",
>> +				PTR_ERR(mc->gart));
>> +	}
> 
> Perhaps if we add a check for for !mc->soc->smmu here we can avoid
> passing this data structure to tegra_gart_probe() and remove the
> corresponding check from tegra_gart_probe(). That seems more like a
> more logical sequence than attempting to probe GART on device that may
> not have one and return.

Then we also want to invoke tegra_smmu_probe only if mc->soc->smmu != NULL, don't we? Seems it makes sense to factor out that change into a separate patch that will remove soc->smmu checks from both SMMU and GART drivers, moving out the checks into the MC driver.

> Also, since there's no error return here, do we want to set mc->gart to
> NULL on error to avoid crashing later on...

Good catch, thanks!

>> +
>> +	return 0;
>> +}
>> +
>> +static int tegra_mc_suspend(struct device *dev)
>> +{
>> +	struct tegra_mc *mc = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	if (mc->gart) {
> 
> ... like here?
> 
>> +		err = tegra_gart_suspend(mc->gart);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>>  	return 0;
>>  }
>>  
>> +static int tegra_mc_resume(struct device *dev)
>> +{
>> +	struct tegra_mc *mc = dev_get_drvdata(dev);
>> +	int err;
>> +
>> +	if (mc->gart) {
> 
> And here?
> 
>> +		err = tegra_gart_resume(mc->gart);
>> +		if (err)
>> +			return err;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct dev_pm_ops tegra_mc_pm_ops = {
>> +	.suspend = tegra_mc_suspend,
>> +	.resume = tegra_mc_resume,
>> +};
>> +
>>  static struct platform_driver tegra_mc_driver = {
>>  	.driver = {
>>  		.name = "tegra-mc",
>>  		.of_match_table = tegra_mc_of_match,
>> +		.pm = &tegra_mc_pm_ops,
>>  		.suppress_bind_attrs = true,
>>  	},
>>  	.prevent_deferred_probe = true,
>> diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
>> index db5bfdf589b4..5da42e3fb801 100644
>> --- a/include/soc/tegra/mc.h
>> +++ b/include/soc/tegra/mc.h
>> @@ -77,6 +77,7 @@ struct tegra_smmu_soc {
>>  
>>  struct tegra_mc;
>>  struct tegra_smmu;
>> +struct gart_device;
>>  
>>  #ifdef CONFIG_TEGRA_IOMMU_SMMU
>>  struct tegra_smmu *tegra_smmu_probe(struct device *dev,
>> @@ -96,6 +97,31 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
>>  }
>>  #endif
>>  
>> +#ifdef CONFIG_TEGRA_IOMMU_GART
>> +struct gart_device *tegra_gart_probe(struct device *dev,
>> +				     const struct tegra_smmu_soc *soc,
>> +				     struct tegra_mc *mc);
>> +int tegra_gart_suspend(struct gart_device *gart);
>> +int tegra_gart_resume(struct gart_device *gart);
>> +#else
>> +static inline struct gart_device *
>> +tegra_gart_probe(struct device *dev, const struct tegra_smmu_soc *soc,
>> +		 struct tegra_mc *mc)
>> +{
>> +	return NULL;
>> +}
>> +
>> +static inline int tegra_gart_suspend(struct gart_device *gart)
>> +{
>> +	return -ENODEV;
>> +}
>> +
>> +static inline int tegra_gart_resume(struct gart_device *gart)
>> +{
>> +	return -ENODEV;
>> +}
>> +#endif
> 
> That doesn't look right. If we don't enable GART, then the dummy
> implementations will be used, but they return error codes, so
> suspend/resume of MC will also fail, causing the whole system to
> not be able to suspend if GART is disabled.

That's not true because the dummy implementations won't be used at all if GART is disabled, unless something horribly wrong happens that makes mc->gart != NULL.

> I think it'd be better to avoid the dummy functions and instead add
> extra checks for IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) where these are
> called. That way references to these functions should be discarded
> at translation time.
> 
> To be specific, tegra_mc_suspend() and tegra_mc_resume() would change
> like this:
> 
> 	if (IS_ENABLED(CONFIG_TEGRA_IOMMU_GART) && mc->gart)

Okay, thanks!
