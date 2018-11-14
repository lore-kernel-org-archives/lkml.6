Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C60C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BFDF2175B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 23:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=marek-ca.20150623.gappssmtp.com header.i=@marek-ca.20150623.gappssmtp.com header.b="kkT6n/5N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BFDF2175B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=marek.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbeKOJPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 04:15:55 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43138 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728285AbeKOJPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 04:15:54 -0500
Received: by mail-qk1-f193.google.com with SMTP id r71so28921419qkr.10
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 15:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=marek-ca.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TSDLuQ3uNX0dHUkhTI/OCK0jMt29KgrxyOBCpxWICMg=;
        b=kkT6n/5Ndg1bYIJmu5cCAYfDeuzgTCu83WyALl1e6MmxuT17bAeD+hDp25O0+GbWdP
         sCPj5ricFj6sdwdvm86CcD7AlcHdldXuBE5D5aUDkELClBWlNMBaEo1mNhqo1dePCNDa
         gb5Y1I/wadGwm5DcaIe1bKpaveAN0dKzWjB6x+oJTXbngKniAPWWx4RQtaAiexYl6yce
         xZVjTlsJf/oDDbngVjGo26OX64s33z3kpfTcJPbFrnDuCo6pk+KtzMzAD2VsXHKYnTxx
         Oj0OZVs1U4d9fTNdyGz923hHZCAne2KtUHFf88b/453D1B+N6uTid9D0yGF9IZVP9Zb0
         /WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TSDLuQ3uNX0dHUkhTI/OCK0jMt29KgrxyOBCpxWICMg=;
        b=Qu/Nv4klyDXbIzIgr3TfwzS6/l0h19rRJ86y+7bq9gdQ5xvfdtynURRSGJisxNzOYi
         HdtShej2Cd+FAtjxuj+bI4EJwcC6roiCMj6VSlcvQ2fkdYfjCGWNvEb73EAtBAygZnpC
         +fBj/fhX3xDwDuSlZxdTe7MxWG3Jwe2TvjJcJ+zUe5WG+BjKHiXZ+bR6hi/ksxsuczQX
         FNKYQvIW4MOOXbFV1pBP+mwCmI+KAVCRPkGR2AYGQ6+KbWuxVLfF7z6nBMOR8DXioqav
         IS7ImR6TvHpgoFkrX06syUCqt/5KIv2dqf9Igpz2C+uEjEZjI68YGxakysnL+xB5puD8
         QS5A==
X-Gm-Message-State: AGRZ1gLgOTDiCbsIilnu33VXh4+7RO64rflY2QQlLLkovs3U8MGpGcGd
        fTSrNEQ9YI4Y6oKFOHpRX5EOVLAoG6Emhw==
X-Google-Smtp-Source: AJdET5eYdSpAnCkJB9v+oPJns1vufhrHstSaKqs3ZBL0tdPTNleQgn7j4z0tm5thRLZlJKMMiWK+Mg==
X-Received: by 2002:a0c:c927:: with SMTP id r36mr4012797qvj.51.1542237034998;
        Wed, 14 Nov 2018 15:10:34 -0800 (PST)
Received: from [192.168.0.189] (modemcable014.247-57-74.mc.videotron.ca. [74.57.247.14])
        by smtp.gmail.com with ESMTPSA id 6sm10936681qtn.31.2018.11.14.15.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 15:10:34 -0800 (PST)
Subject: Re: [PATCH 5/9] drm/msm: add headless gpu device (for imx5)
To:     freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        Govind Singh <govinds@codeaurora.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181114222418.15960-1-jonathan@marek.ca>
 <20181114222418.15960-5-jonathan@marek.ca>
 <20181114224729.GA6285@jcrouse-lnx.qualcomm.com>
From:   Jonathan marek <jonathan@marek.ca>
Message-ID: <c4960412-691d-c6f4-9c56-9ab0b706c72f@marek.ca>
Date:   Wed, 14 Nov 2018 18:08:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181114224729.GA6285@jcrouse-lnx.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/14/2018 05:47 PM, Jordan Crouse wrote:
> Thanks for  the patch. Perhaps a small blurb here for the commit log to let
> folks know what your intent was.
> 

I will add an explanation. The intent is clear to me from the commit 
message, but perhaps not for everyone.

> On Wed, Nov 14, 2018 at 05:24:12PM -0500, Jonathan Marek wrote:
>> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
>> ---
>>   drivers/gpu/drm/msm/Kconfig       |  4 ++--
>>   drivers/gpu/drm/msm/msm_debugfs.c |  2 +-
>>   drivers/gpu/drm/msm/msm_drv.c     | 15 +++++++++++----
>>   include/linux/qcom_scm.h          |  3 +++
>>   4 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/Kconfig b/drivers/gpu/drm/msm/Kconfig
>> index 843a9d40c05e..cf549f1ed403 100644
>> --- a/drivers/gpu/drm/msm/Kconfig
>> +++ b/drivers/gpu/drm/msm/Kconfig
>> @@ -2,7 +2,7 @@
>>   config DRM_MSM
>>   	tristate "MSM DRM"
>>   	depends on DRM
>> -	depends on ARCH_QCOM || (ARM && COMPILE_TEST)
>> +	depends on ARCH_QCOM || SOC_IMX5 || (ARM && COMPILE_TEST)
>>   	depends on OF && COMMON_CLK
>>   	depends on MMU
>>   	select QCOM_MDT_LOADER if ARCH_QCOM
>> @@ -11,7 +11,7 @@ config DRM_MSM
>>   	select DRM_PANEL
>>   	select SHMEM
>>   	select TMPFS
>> -	select QCOM_SCM
>> +	select QCOM_SCM if ARCH_QCOM
>>   	select WANT_DEV_COREDUMP
>>   	select SND_SOC_HDMI_CODEC if SND_SOC
>>   	select SYNC_FILE
>> diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
>> index f0da0d3c8a80..1ca99ca356a4 100644
>> --- a/drivers/gpu/drm/msm/msm_debugfs.c
>> +++ b/drivers/gpu/drm/msm/msm_debugfs.c
>> @@ -235,7 +235,7 @@ int msm_debugfs_init(struct drm_minor *minor)
>>   	debugfs_create_file("gpu", S_IRUSR, minor->debugfs_root,
>>   		dev, &msm_gpu_fops);
>>   
>> -	if (priv->kms->funcs->debugfs_init) {
>> +	if (priv->kms && priv->kms->funcs->debugfs_init) {
>>   		ret = priv->kms->funcs->debugfs_init(priv->kms, minor);
>>   		if (ret)
>>   			return ret;
>> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
>> index 9f219e02f3c7..a10cc0298d38 100644
>> --- a/drivers/gpu/drm/msm/msm_drv.c
>> +++ b/drivers/gpu/drm/msm/msm_drv.c
>> @@ -344,6 +344,7 @@ static int msm_drm_uninit(struct device *dev)
>>   	return 0;
>>   }
>>   
>> +#define KMS_HEADLESS 1
>>   #define KMS_MDP4 4
>>   #define KMS_MDP5 5
>>   #define KMS_DPU  3
>> @@ -495,6 +496,9 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>>   	msm_gem_shrinker_init(ddev);
>>   
>>   	switch (get_mdp_ver(pdev)) {
>> +	case KMS_HEADLESS:
>> +		priv->kms = kms = NULL;
> 
> I don't think you need to set priv->kms, it should come in as NULL. I would
> normally say that you should set kms to NULL when it is declared, but I kind of
> like pointing it out to the user.
> 

It comes as NULL, but initializing it here matches the other cases in 
the switch (at the cost of 12 characters).

>> +		break;
>>   	case KMS_MDP4:
>>   		kms = mdp4_kms_init(ddev);
>>   		priv->kms = kms;
>> @@ -633,7 +637,7 @@ static int msm_drm_init(struct device *dev, struct drm_driver *drv)
>>   	drm_mode_config_reset(ddev);
>>   
>>   #ifdef CONFIG_DRM_FBDEV_EMULATION
>> -	if (fbdev)
>> +	if (kms && fbdev)
>>   		priv->fbdev = msm_fbdev_init(ddev);
>>   #endif
>>   
>> @@ -1315,9 +1319,11 @@ static int msm_pdev_probe(struct platform_device *pdev)
>>   	struct component_match *match = NULL;
>>   	int ret;
>>   
>> -	ret = add_display_components(&pdev->dev, &match);
>> -	if (ret)
>> -		return ret;
>> +	if (get_mdp_ver(pdev) != KMS_HEADLESS) {
>> +		ret = add_display_components(&pdev->dev, &match);
>> +		if (ret)
>> +			return ret;
>> +	}
>>   
>>   	ret = add_gpu_components(&pdev->dev, &match);
>>   	if (ret)
>> @@ -1342,6 +1348,7 @@ static int msm_pdev_remove(struct platform_device *pdev)
>>   }
>>   
>>   static const struct of_device_id dt_match[] = {
>> +	{ .compatible = "qcom,adreno-headless", .data = (void *)KMS_HEADLESS },
>>   	{ .compatible = "qcom,mdp4", .data = (void *)KMS_MDP4 },
>>   	{ .compatible = "qcom,mdss", .data = (void *)KMS_MDP5 },
>>   	{ .compatible = "qcom,sdm845-mdss", .data = (void *)KMS_DPU },
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index 06996ad4f2bc..1637385bcc17 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -67,6 +67,9 @@ extern int qcom_scm_iommu_secure_ptbl_init(u64 addr, u32 size, u32 spare);
>>   extern int qcom_scm_io_readl(phys_addr_t addr, unsigned int *val);
>>   extern int qcom_scm_io_writel(phys_addr_t addr, unsigned int val);
>>   #else
>> +
>> +#include <linux/errno.h>
>> +
> 
> This looks like a separate patch, albeit a useful one.
> 

Yes, that isn't part of this patch. Oops.

>>   static inline
>>   int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
>>   {
> 
> Jordan
> 

Jonathan
