Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45F5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:37:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79612217D7
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 14:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7nUbK72"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729614AbeLSOhe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 09:37:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42151 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729459AbeLSOhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 09:37:34 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so19753494wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 06:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xGa2ICyEKMipdlDD0WrN11F2swN1FjgUP7+OQw6214E=;
        b=F7nUbK72pxExytCs9g8c4/3cd0hk4vuYfwUK5sCSZwfP/XjiMktS5fVjVadv9aJA2t
         qNk8SVYNG1m0VuAZ8tnepXOVaVLzWY54A9+3IQHOcO1zxWLkJUp03a2zx5ZcRYjB6Ypq
         keBo5swZBl7znMLOeyiQXFxMAdbuTP3WN6hyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xGa2ICyEKMipdlDD0WrN11F2swN1FjgUP7+OQw6214E=;
        b=mILNWu7ddARnz5aHzfhh9jGGYlgIeipFBZZYN3p3meqangx3H1x4UWfge0IhZ3MpgA
         N084APiT8987W+jdnAZdCQeXZxoAl2Sr9waF0MphvaaFnfGvuKrkc9hRFsrnLwq2uTGA
         7TLnnQKkvmXRZnmUAjfcbEPK4hLTmdPOUc6p7SDZrFajjJxbh7kzHk3x3/ZVzfLRoxSg
         C3TC9wGR6wcYvNG56T11qiaUtiRzM3XfJ1CV4hCKFsYaddPXUdjB68KtkwwWgzZj3m+O
         xBvPo2crdBZvnF6cy6bNrtH0csJkNfYMBqJFhL6mmJAUWdHhTPjDLVsPJWI+lXqUUYWb
         bVzQ==
X-Gm-Message-State: AA+aEWa6lbtH6upDQhPIN5DBHzulQnXhKgrwj8vTPzi3QBCI/zWdn72k
        1RTawUgZFunInG8Lw8LrBdAL7w==
X-Google-Smtp-Source: AFSGD/WfdUsK/gKVRPdbxpQhh2R49SedFf3/xaPjTgdwfyup2gFl+WirZYOrpNjbxPXzsSOr+sq+zg==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr18453899wrm.143.1545230251406;
        Wed, 19 Dec 2018 06:37:31 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h16sm12351949wrb.62.2018.12.19.06.37.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 06:37:30 -0800 (PST)
Subject: Re: [PATCH v3 2/3] drm/msm/dpu: Integrate interconnect API in MDSS
To:     Sravanthi Kollukuduru <skolluku@codeaurora.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robdclark@gmail.com,
        seanpaul@chromium.org, sean@poorly.run
References: <20181122090653.3523-1-skolluku@codeaurora.org>
 <20181122090653.3523-3-skolluku@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <bbe80ea8-52ef-3942-9691-eaad19eb996a@linaro.org>
Date:   Wed, 19 Dec 2018 16:37:27 +0200
MIME-Version: 1.0
In-Reply-To: <20181122090653.3523-3-skolluku@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sravanthi,

Thanks for the patch!

On 11/22/18 11:06, Sravanthi Kollukuduru wrote:
> The interconnect framework is designed to provide a
> standard kernel interface to control the settings of
> the interconnects on a SoC.
> 
> The interconnect API uses a consumer/provider-based model,
> where the providers are the interconnect buses and the
> consumers could be various drivers.
> 
> MDSS is one of the interconnect consumers which uses the
> interconnect APIs to get the path between endpoints and
> set its bandwidth/latency/QoS requirements for the given
> interconnected path.
> 
> Changes in v2:
> 	- Remove error log and unnecessary check (Jordan Crouse)
> 
> Changes in v3:
> 	- Code clean involving variable name change, removal
> 	  of extra paranthesis and variables (Matthias Kaehlcke)
> 
> Signed-off-by: Sravanthi Kollukuduru <skolluku@codeaurora.org>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c | 49 ++++++++++++++++++++++++++++----
>  1 file changed, 44 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> index 38576f8b90b6..1387a6b1b39e 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_mdss.c
> @@ -4,10 +4,12 @@
>   */
>  
>  #include "dpu_kms.h"
> +#include <linux/interconnect.h>
>  
>  #define to_dpu_mdss(x) container_of(x, struct dpu_mdss, base)
>  
> -#define HW_INTR_STATUS			0x0010
> +#define HW_INTR_STATUS	0x0010

Unrelated change?

> +#define MAX_BW		6800000

In what units? Maybe add a comment.

>  
>  struct dpu_mdss {
>  	struct msm_mdss base;
> @@ -16,8 +18,30 @@ struct dpu_mdss {
>  	u32 hwversion;
>  	struct dss_module_power mp;
>  	struct dpu_irq_controller irq_controller;
> +	struct icc_path *path[2];
> +	u32 num_paths;
>  };
>  
> +static int dpu_mdss_parse_data_bus_icc_path(
> +		struct drm_device *dev, struct dpu_mdss *dpu_mdss)

Nit: Lines should not end with a '('. Please move the first argument up:

static int dpu_mdss_parse_data_bus_icc_path(struct drm_device *dev,
					    struct dpu_mdss *dpu_mdss)

> +{
> +	struct icc_path *path0 = of_icc_get(dev->dev, "port0");
> +	struct icc_path *path1 = of_icc_get(dev->dev, "port1");

In DT it's preferred that the name contains both the source and
destination, so maybe of_icc_get(dev->dev, "mdp0-mem") etc.

> +
> +	if (IS_ERR(path0))
> +		return PTR_ERR(path0);
> +
> +	dpu_mdss->path[0] = path0;
> +	dpu_mdss->num_paths = 1;
> +
> +	if (!IS_ERR(path1)) {
> +		dpu_mdss->path[1] = path1;
> +		dpu_mdss->num_paths++;
> +	}
> +
> +	return 0;
> +}
> +
>  static irqreturn_t dpu_mdss_irq(int irq, void *arg)
>  {
>  	struct dpu_mdss *dpu_mdss = arg;
> @@ -127,7 +151,11 @@ static int dpu_mdss_enable(struct msm_mdss *mdss)
>  {
>  	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
>  	struct dss_module_power *mp = &dpu_mdss->mp;
> -	int ret;
> +	int ret, i;
> +	u64 avg_bw = dpu_mdss->num_paths ? MAX_BW/dpu_mdss->num_paths : 0;

Nit: Please add spaces around "/"

> +
> +	for (i = 0; i < dpu_mdss->num_paths; i++)
> +		icc_set(dpu_mdss->path[i], avg_bw, MAX_BW);

Now we have macros in the header, that can be used to specify the
bandwidth units. So please use kBps_to_icc or MBps_to_icc etc. If we
decide in the future to change the internal units, we will be able to do
it without touching the users.

Thanks,
Georgi

>  
>  	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, true);
>  	if (ret)
> @@ -140,12 +168,15 @@ static int dpu_mdss_disable(struct msm_mdss *mdss)
>  {
>  	struct dpu_mdss *dpu_mdss = to_dpu_mdss(mdss);
>  	struct dss_module_power *mp = &dpu_mdss->mp;
> -	int ret;
> +	int ret, i;
>  
>  	ret = msm_dss_enable_clk(mp->clk_config, mp->num_clk, false);
>  	if (ret)
>  		DPU_ERROR("clock disable failed, ret:%d\n", ret);
>  
> +	for (i = 0; i < dpu_mdss->num_paths; i++)
> +		icc_set(dpu_mdss->path[i], 0, 0);
> +
>  	return ret;
>  }
>  
> @@ -155,6 +186,7 @@ static void dpu_mdss_destroy(struct drm_device *dev)
>  	struct msm_drm_private *priv = dev->dev_private;
>  	struct dpu_mdss *dpu_mdss = to_dpu_mdss(priv->mdss);
>  	struct dss_module_power *mp = &dpu_mdss->mp;
> +	int i;
>  
>  	pm_runtime_disable(dev->dev);
>  	_dpu_mdss_irq_domain_fini(dpu_mdss);
> @@ -162,6 +194,9 @@ static void dpu_mdss_destroy(struct drm_device *dev)
>  	msm_dss_put_clk(mp->clk_config, mp->num_clk);
>  	devm_kfree(&pdev->dev, mp->clk_config);
>  
> +	for (i = 0; i < dpu_mdss->num_paths; i++)
> +		icc_put(dpu_mdss->path[i]);
> +
>  	if (dpu_mdss->mmio)
>  		devm_iounmap(&pdev->dev, dpu_mdss->mmio);
>  	dpu_mdss->mmio = NULL;
> @@ -200,6 +235,10 @@ int dpu_mdss_init(struct drm_device *dev)
>  	}
>  	dpu_mdss->mmio_len = resource_size(res);
>  
> +	ret = dpu_mdss_parse_data_bus_icc_path(dev, dpu_mdss);
> +	if (ret)
> +		return ret;
> +
>  	mp = &dpu_mdss->mp;
>  	ret = msm_dss_parse_clock(pdev, mp);
>  	if (ret) {
> @@ -221,14 +260,14 @@ int dpu_mdss_init(struct drm_device *dev)
>  		goto irq_error;
>  	}
>  
> +	priv->mdss = &dpu_mdss->base;
> +
>  	pm_runtime_enable(dev->dev);
>  
>  	pm_runtime_get_sync(dev->dev);
>  	dpu_mdss->hwversion = readl_relaxed(dpu_mdss->mmio);
>  	pm_runtime_put_sync(dev->dev);
>  
> -	priv->mdss = &dpu_mdss->base;
> -
>  	return ret;
>  
>  irq_error:
> 
