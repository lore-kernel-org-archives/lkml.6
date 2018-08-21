Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BF63C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F03C7214EE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsEQgOKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03C7214EE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbeHUQ2A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:28:00 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51998 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeHUQ2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:28:00 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so2881936wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+tj8g8CEwH0ii2HD/7oGWIcbYrAYR2G430aaJPRBKTc=;
        b=jsEQgOKLwAtzJhYechrpYiYpthRlJycxbeHZ1VMY2IGbKdZgRO0/qyDN9UbPOXreay
         bEnOUaePrZju589owi9m0nHt3bIWBX0SM9fFn5nh2sAZAXJdigB/Y2fxmAWVhh7FiX5H
         ILecnyhXzh1gU0fJqViSCOoB9ssER3scg5T/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+tj8g8CEwH0ii2HD/7oGWIcbYrAYR2G430aaJPRBKTc=;
        b=PtC3WMZUCi9pQvjAcUWmPDG7g5ckjGnwvKh8fn5oIfP/mXm8M7u3kfW1ku6BoJB+Qj
         YlvuKPInX3Dk81+Xqgmz4wcwqAs620GEJ8EKNRdqUWTJwESxLT6Nk0w8TEhdihoJB6uG
         5pKz72RDgWqEneoyFn7/DfrvUBRDzS+MzcwsAOT5ZoUUwutfOja+8RFD/lT9Wmv/R8yk
         xmbGkrWqv7Ki5W5pF0kiLuMGa/rtral2QBEoA68IPcoBJWS3ZyXUTIS834oT9rxh/yCi
         lA2uakKVdoOJr9h9WvOFsPrXjto+BsJSeYX7TzsZTeegrF+Pd+eezUrqk/ysjbJO72ol
         z+hQ==
X-Gm-Message-State: AOUpUlE01ww31fPuobkye4BUF3v1Ep+hyinbWeyKfavRQ5ETaC99dbaL
        07kXLRSYnSlz/X6mh7WN50Y7lQ==
X-Google-Smtp-Source: AA+uWPwa++erXTkvEy4hgJkG8gmB2NJZ79+QrDsYfc0dhEpqJpoYqY2Dss7UAiRPxFyIMcKjQUNBvA==
X-Received: by 2002:a1c:f703:: with SMTP id v3-v6mr24952666wmh.48.1534856873039;
        Tue, 21 Aug 2018 06:07:53 -0700 (PDT)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id a11-v6sm12608454wrr.81.2018.08.21.06.07.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 06:07:52 -0700 (PDT)
Subject: Re: [PATCH v4 3/4] venus: firmware: add no TZ boot and shutdown
 routine
To:     Vikash Garodia <vgarodia@codeaurora.org>, hverkuil@xs4all.nl,
        mchehab@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, acourbot@chromium.org
References: <1533562085-8773-1-git-send-email-vgarodia@codeaurora.org>
 <1533562085-8773-4-git-send-email-vgarodia@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <a8df5189-fe17-0437-6706-f689efd2655e@linaro.org>
Date:   Tue, 21 Aug 2018 16:07:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533562085-8773-4-git-send-email-vgarodia@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On 08/06/2018 04:28 PM, Vikash Garodia wrote:
> Video hardware is mainly comprised of vcodec subsystem and video
> control subsystem. Video control has ARM9 which executes the video
> firmware instructions whereas vcodec does the video frame processing.
> This change adds support to load the video firmware and bring ARM9
> out of reset for platforms which does not have trustzone.
> 
> Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c         |  6 +-
>  drivers/media/platform/qcom/venus/core.h         |  6 ++
>  drivers/media/platform/qcom/venus/firmware.c     | 91 +++++++++++++++++++++++-
>  drivers/media/platform/qcom/venus/firmware.h     |  2 +-
>  drivers/media/platform/qcom/venus/hfi_venus_io.h |  1 +
>  5 files changed, 99 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 75b9785..393994e 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -76,7 +76,7 @@ static void venus_sys_error_handler(struct work_struct *work)
>  	hfi_core_deinit(core, true);
>  	hfi_destroy(core);
>  	mutex_lock(&core->lock);
> -	venus_shutdown(core->dev);
> +	venus_shutdown(core);
>  
>  	pm_runtime_put_sync(core->dev);
>  
> @@ -323,7 +323,7 @@ static int venus_probe(struct platform_device *pdev)
>  err_core_deinit:
>  	hfi_core_deinit(core, false);
>  err_venus_shutdown:
> -	venus_shutdown(dev);
> +	venus_shutdown(core);
>  err_runtime_disable:
>  	pm_runtime_set_suspended(dev);
>  	pm_runtime_disable(dev);
> @@ -344,7 +344,7 @@ static int venus_remove(struct platform_device *pdev)
>  	WARN_ON(ret);
>  
>  	hfi_destroy(core);
> -	venus_shutdown(dev);
> +	venus_shutdown(core);
>  	of_platform_depopulate(dev);
>  
>  	pm_runtime_put_sync(dev);
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index eb5ee66..8c64177 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -81,6 +81,11 @@ struct venus_caps {
>  	bool valid;	/* used only for Venus v1xx */
>  };
>  
> +struct video_firmware {
> +	struct device *dev;
> +	struct iommu_domain *iommu_domain;
> +};
> +
>  /**
>   * struct venus_core - holds core parameters valid for all instances
>   *
> @@ -129,6 +134,7 @@ struct venus_core {
>  	struct device *dev;
>  	struct device *dev_dec;
>  	struct device *dev_enc;
> +	struct video_firmware fw;
>  	bool no_tz;
>  	struct mutex lock;
>  	struct list_head instances;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 4577043..30130d4 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -12,8 +12,10 @@
>   *
>   */
>  
> +#include <linux/platform_device.h>

please keep includes alphabetically ordered.

>  #include <linux/device.h>
>  #include <linux/firmware.h>
> +#include <linux/iommu.h>

and here too

>  #include <linux/kernel.h>
>  #include <linux/io.h>
>  #include <linux/of.h>
> @@ -118,6 +120,76 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	return ret;
>  }
>  
> +static int venus_boot_no_tz(struct venus_core *core, phys_addr_t mem_phys,
> +			size_t mem_size)
> +{
> +	struct iommu_domain *iommu_dom;
> +	struct device *dev;
> +	int ret;
> +
> +	dev = core->fw.dev;
> +	if (!dev)
> +		return -EPROBE_DEFER;
> +
> +	iommu_dom = iommu_domain_alloc(&platform_bus_type);
> +	if (!iommu_dom) {
> +		dev_err(dev, "Failed to allocate iommu domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	ret = iommu_attach_device(iommu_dom, dev);
> +	if (ret) {
> +		dev_err(dev, "could not attach device\n");
> +		goto err_attach;
> +	}
> +
> +	ret = iommu_map(iommu_dom, VENUS_FW_START_ADDR, mem_phys, mem_size,
> +			IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV);
> +	if (ret) {
> +		dev_err(dev, "could not map video firmware region\n");
> +		goto err_map;
> +	}
> +
> +	core->fw.iommu_domain = iommu_dom;
> +	venus_reset_cpu(core);
> +
> +	return 0;
> +
> +err_map:
> +	iommu_detach_device(iommu_dom, dev);
> +err_attach:
> +	iommu_domain_free(iommu_dom);
> +	return ret;
> +}
> +
> +static int venus_shutdown_no_tz(struct venus_core *core)
> +{
> +	struct iommu_domain *iommu;
> +	size_t unmapped = 0;

no need to initialize unmapped variable.

> +	u32 reg;
> +	struct device *dev = core->fw.dev;

could you move longer lines at the beginning of the function

> +	void __iomem *reg_base = core->base;

renaming reg_base to base will give you shorter line(s), otherwise I
think you should use core->base directly

> +
> +	/* Assert the reset to ARM9 */
> +	reg = readl_relaxed(reg_base + WRAPPER_A9SS_SW_RESET);
> +	reg |= WRAPPER_A9SS_SW_RESET_BIT;
> +	writel_relaxed(reg, reg_base + WRAPPER_A9SS_SW_RESET);
> +
> +	/* Make sure reset is asserted before the mapping is removed */
> +	mb();
> +
> +	iommu = core->fw.iommu_domain;
> +
> +	unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, VENUS_FW_MEM_SIZE);
> +	if (unmapped != VENUS_FW_MEM_SIZE)
> +		dev_err(dev, "failed to unmap firmware\n");
> +
> +	iommu_detach_device(iommu, dev);
> +	iommu_domain_free(iommu);
> +

the function doesn't return error why don't make it to return void? Up
to you.

> +	return 0;
> +}

-- 
regards,
Stan
