Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE4BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290962086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 16:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXXWY7JY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfARQUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:20:42 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45001 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728337AbfARQUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 11:20:40 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so15705820wrt.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 08:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4RAzAScFwsXLtNFSIi/0xvW83N3ojDdDXPlpjCSX+xg=;
        b=iXXWY7JY5H0/eLKa9F5YZDxrHSIexcGntP3jMSW8CSR3gzTHaiNguKVguW1CtFLlbn
         EieHjac/QI/wBdvhHBqPpVaGgIaM6UchqHqo7V+y33RCqBwz22NtNCqeo/pvpTJNgac8
         7rEyse/QpXy4QsYnZQrhwZ8khn7zjlHSl1MyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4RAzAScFwsXLtNFSIi/0xvW83N3ojDdDXPlpjCSX+xg=;
        b=ie9UmI2b60QnZjABxev0sHk+TK/UIw6SWqz87BeRCUdS7GYVPAsQNdvhiYTEIbfsQr
         0S9Gt6qlhhpEL54c+2N7q4DwtyauVw4DenQZ42bTKQMb5hz+L7E7TAuyJ2Rfwpd8ePkv
         wjCi/wOlPq8MCGChK8DGWCti1sdEgwLRAGmCUM4M6cBeOuAoQ5mjy4W/gXxnQK/nSmf6
         ifi5tZW3M8bLpUOqNRGrFeECvpp9QXaKPSLjjEWvH/UC5S/ac8f4gNpdWqCZ5NSZMK/q
         3C9r65nMeufSj18Gso6kSMWBdCFp6WqzNYF4xIeebQ289MpTKEMN0M2G8LkzIWaevrCe
         mLhA==
X-Gm-Message-State: AJcUukcpiBJMeNn9Ka4Q7ZcytHgWb2PaMiYCSB7DKQDsruA4vaEbVOSr
        QjStiX/jHymTl8pz0YrGWbBKww==
X-Google-Smtp-Source: ALg8bN5rMpUH51raWPSPHwVKE60gesco3F6fv8iT3D4QlEP4ZL67irNiN2nKoYRqLmB+u8Ieo6P6Vw==
X-Received: by 2002:adf:e247:: with SMTP id n7mr16470866wri.205.1547828437368;
        Fri, 18 Jan 2019 08:20:37 -0800 (PST)
Received: from [192.168.27.209] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id o4sm79642349wrq.66.2019.01.18.08.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:20:36 -0800 (PST)
Subject: Re: [PATCH 1/4] venus: firmware: check fw size against DT memory
 region size
To:     linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
References: <20190109084616.17162-1-stanimir.varbanov@linaro.org>
 <20190109084616.17162-2-stanimir.varbanov@linaro.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <9ce87f3e-ba2b-b961-a874-666d2d72a293@linaro.org>
Date:   Fri, 18 Jan 2019 18:20:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190109084616.17162-2-stanimir.varbanov@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

If you have time please review this patch, I'd like to send a pull
request for this series.

On 1/9/19 10:46 AM, Stanimir Varbanov wrote:
> By historical reasons we defined firmware memory size to be 6MB even
> that the firmware size for all supported Venus versions is 5MBs. Correct
> that by compare the required firmware size returned from mdt loader and
> the one provided by DT reserved memory region. We proceed further if the
> required firmware size is smaller than provided by DT memory region.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.h     |  1 +
>  drivers/media/platform/qcom/venus/firmware.c | 54 +++++++++++---------
>  2 files changed, 31 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 6382cea29185..79c7e816c706 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -134,6 +134,7 @@ struct venus_core {
>  	struct video_firmware {
>  		struct device *dev;
>  		struct iommu_domain *iommu_domain;
> +		size_t mapped_mem_size;
>  	} fw;
>  	struct mutex lock;
>  	struct list_head instances;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index c29acfd70c1b..6b509ffd022a 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -35,14 +35,15 @@
>  
>  static void venus_reset_cpu(struct venus_core *core)
>  {
> +	u32 fw_size = core->fw.mapped_mem_size;
>  	void __iomem *base = core->base;
>  
>  	writel(0, base + WRAPPER_FW_START_ADDR);
> -	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_FW_END_ADDR);
> +	writel(fw_size, base + WRAPPER_FW_END_ADDR);
>  	writel(0, base + WRAPPER_CPA_START_ADDR);
> -	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_CPA_END_ADDR);
> -	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_NONPIX_START_ADDR);
> -	writel(VENUS_FW_MEM_SIZE, base + WRAPPER_NONPIX_END_ADDR);
> +	writel(fw_size, base + WRAPPER_CPA_END_ADDR);
> +	writel(fw_size, base + WRAPPER_NONPIX_START_ADDR);
> +	writel(fw_size, base + WRAPPER_NONPIX_END_ADDR);
>  	writel(0x0, base + WRAPPER_CPU_CGC_DIS);
>  	writel(0x0, base + WRAPPER_CPU_CLOCK_CONFIG);
>  
> @@ -74,6 +75,9 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	void *mem_va;
>  	int ret;
>  
> +	*mem_phys = 0;
> +	*mem_size = 0;
> +
>  	dev = core->dev;
>  	node = of_parse_phandle(dev->of_node, "memory-region", 0);
>  	if (!node) {
> @@ -85,28 +89,30 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  	if (ret)
>  		return ret;
>  
> +	ret = request_firmware(&mdt, fwname, dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	fw_size = qcom_mdt_get_size(mdt);
> +	if (fw_size < 0) {
> +		ret = fw_size;
> +		goto err_release_fw;
> +	}
> +
>  	*mem_phys = r.start;
>  	*mem_size = resource_size(&r);
>  
> -	if (*mem_size < VENUS_FW_MEM_SIZE)
> -		return -EINVAL;
> +	if (*mem_size < fw_size || fw_size > VENUS_FW_MEM_SIZE) {
> +		ret = -EINVAL;
> +		goto err_release_fw;
> +	}
>  
>  	mem_va = memremap(r.start, *mem_size, MEMREMAP_WC);
>  	if (!mem_va) {
>  		dev_err(dev, "unable to map memory region: %pa+%zx\n",
>  			&r.start, *mem_size);
> -		return -ENOMEM;
> -	}
> -
> -	ret = request_firmware(&mdt, fwname, dev);
> -	if (ret < 0)
> -		goto err_unmap;
> -
> -	fw_size = qcom_mdt_get_size(mdt);
> -	if (fw_size < 0) {
> -		ret = fw_size;
> -		release_firmware(mdt);
> -		goto err_unmap;
> +		ret = -ENOMEM;
> +		goto err_release_fw;
>  	}
>  
>  	if (core->use_tz)
> @@ -116,10 +122,9 @@ static int venus_load_fw(struct venus_core *core, const char *fwname,
>  		ret = qcom_mdt_load_no_init(dev, mdt, fwname, VENUS_PAS_ID,
>  					    mem_va, *mem_phys, *mem_size, NULL);
>  
> -	release_firmware(mdt);
> -
> -err_unmap:
>  	memunmap(mem_va);
> +err_release_fw:
> +	release_firmware(mdt);
>  	return ret;
>  }
>  
> @@ -135,6 +140,7 @@ static int venus_boot_no_tz(struct venus_core *core, phys_addr_t mem_phys,
>  		return -EPROBE_DEFER;
>  
>  	iommu = core->fw.iommu_domain;
> +	core->fw.mapped_mem_size = mem_size;
>  
>  	ret = iommu_map(iommu, VENUS_FW_START_ADDR, mem_phys, mem_size,
>  			IOMMU_READ | IOMMU_WRITE | IOMMU_PRIV);
> @@ -151,7 +157,7 @@ static int venus_boot_no_tz(struct venus_core *core, phys_addr_t mem_phys,
>  static int venus_shutdown_no_tz(struct venus_core *core)
>  {
>  	struct iommu_domain *iommu;
> -	size_t unmapped;
> +	size_t unmapped, mapped = core->fw.mapped_mem_size;
>  	u32 reg;
>  	struct device *dev = core->fw.dev;
>  	void __iomem *base = core->base;
> @@ -166,8 +172,8 @@ static int venus_shutdown_no_tz(struct venus_core *core)
>  
>  	iommu = core->fw.iommu_domain;
>  
> -	unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, VENUS_FW_MEM_SIZE);
> -	if (unmapped != VENUS_FW_MEM_SIZE)
> +	unmapped = iommu_unmap(iommu, VENUS_FW_START_ADDR, mapped);
> +	if (unmapped != mapped)
>  		dev_err(dev, "failed to unmap firmware\n");
>  
>  	return 0;
> 

-- 
regards,
Stan
