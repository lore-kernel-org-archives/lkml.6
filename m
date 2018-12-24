Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F90DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403F2218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeLXMDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:03:07 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:58116 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbeLXMDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:03:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D44E80D;
        Mon, 24 Dec 2018 04:03:06 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 27F653F718;
        Mon, 24 Dec 2018 04:03:06 -0800 (PST)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 84ECB680369; Mon, 24 Dec 2018 12:03:04 +0000 (GMT)
Date:   Mon, 24 Dec 2018 12:03:04 +0000
From:   Liviu Dudau <Liviu.Dudau@arm.com>
To:     "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Cc:     "Jonathan Chai (Arm Technology China)" <Jonathan.Chai@arm.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        "Julien Yin (Arm Technology China)" <Julien.Yin@arm.com>,
        "thomas Sun (Arm Technology China)" <thomas.Sun@arm.com>,
        Alexandru-Cosmin Gheorghe <Alexandru-Cosmin.Gheorghe@arm.com>,
        "Lowry Li (Arm Technology China)" <Lowry.Li@arm.com>,
        Ayan Halder <Ayan.Halder@arm.com>,
        "Tiannan Zhu (Arm Technology China)" <Tiannan.Zhu@arm.com>,
        "Jin Gao (Arm Technology China)" <Jin.Gao@arm.com>,
        "Yiqi Kang (Arm Technology China)" <Yiqi.Kang@arm.com>,
        nd <nd@arm.com>, "malidp@foss.arm.com" <malidp@foss.arm.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "maxime.ripard@bootlin.com" <maxime.ripard@bootlin.com>,
        "sean@poorly.run" <sean@poorly.run>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>
Subject: Re: [PATCH v3 4/9] drm/komeda: Add DT parsing
Message-ID: <20181224120304.GF22341@e110455-lin.cambridge.arm.com>
References: <20181221095757.15510-1-james.qian.wang@arm.com>
 <20181221095757.15510-5-james.qian.wang@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181221095757.15510-5-james.qian.wang@arm.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 09:59:44AM +0000, james qian wang (Arm Technology China) wrote:
> Parse DT and initialize corresponding dev/pipeline attributes.
> 
> Changes in v3:
> - Fixed style problem found by checkpatch.pl --strict.
> 
> Changes in v2:
> - Unified abbreviation of "pipeline" to "pipe".
> 
> Signed-off-by: James (Qian) Wang <james.qian.wang@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  .../gpu/drm/arm/display/komeda/komeda_dev.c   | 76 +++++++++++++++++++
>  .../gpu/drm/arm/display/komeda/komeda_dev.h   |  3 +
>  .../drm/arm/display/komeda/komeda_pipeline.c  |  4 +
>  .../drm/arm/display/komeda/komeda_pipeline.h  |  7 ++
>  4 files changed, 90 insertions(+)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> index 887a17005367..d0cc4f758077 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.c
> @@ -12,6 +12,76 @@
>  #include <linux/version.h>
>  #include "komeda_dev.h"
>  
> +static int komeda_parse_pipe_dt(struct komeda_dev *mdev, struct device_node *np)
> +{
> +	struct komeda_pipeline *pipe;
> +	struct clk *clk;
> +	u32 pipe_id;
> +	int ret = 0;
> +
> +	ret = of_property_read_u32(np, "reg", &pipe_id);
> +	if (ret != 0 || pipe_id >= mdev->n_pipelines)
> +		return -EINVAL;
> +
> +	pipe = mdev->pipelines[pipe_id];
> +
> +	clk = of_clk_get_by_name(np, "aclk");
> +	if (IS_ERR(clk)) {
> +		DRM_ERROR("get aclk for pipeline %d failed!\n", pipe_id);
> +		return PTR_ERR(clk);
> +	}
> +	pipe->aclk = clk;
> +
> +	clk = of_clk_get_by_name(np, "pxclk");
> +	if (IS_ERR(clk)) {
> +		DRM_ERROR("get pxclk for pipeline %d failed!\n", pipe_id);
> +		return PTR_ERR(clk);
> +	}
> +	pipe->pxlclk = clk;
> +
> +	/* enum ports */
> +	pipe->of_output_dev =
> +		of_graph_get_remote_node(np, KOMEDA_OF_PORT_OUTPUT, 0);
> +	pipe->of_output_port =
> +		of_graph_get_port_by_id(np, KOMEDA_OF_PORT_OUTPUT);
> +
> +	pipe->of_node = np;
> +
> +	return 0;
> +}
> +
> +static int komeda_parse_dt(struct device *dev, struct komeda_dev *mdev)
> +{
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct device_node *child, *np = dev->of_node;
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get(dev, "mclk");
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	mdev->mclk = clk;
> +	mdev->irq  = platform_get_irq(pdev, 0);
> +	if (mdev->irq < 0) {
> +		DRM_ERROR("could not get IRQ number.\n");
> +		return mdev->irq;
> +	}
> +
> +	for_each_available_child_of_node(np, child) {
> +		if (of_node_cmp(child->name, "pipeline") == 0) {
> +			ret = komeda_parse_pipe_dt(mdev, child);
> +			if (ret) {
> +				DRM_ERROR("parse pipeline dt error!\n");
> +				of_node_put(child);
> +				break;
> +			}
> +		}
> +	}
> +
> +	return ret;
> +}
> +
>  struct komeda_dev *komeda_dev_create(struct device *dev)
>  {
>  	struct platform_device *pdev = to_platform_device(dev);
> @@ -74,6 +144,12 @@ struct komeda_dev *komeda_dev_create(struct device *dev)
>  		goto err_cleanup;
>  	}
>  
> +	err = komeda_parse_dt(dev, mdev);
> +	if (err) {
> +		DRM_ERROR("parse device tree failed.\n");
> +		goto err_cleanup;
> +	}
> +
>  	return mdev;
>  
>  err_cleanup:
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> index 680e3e2cf100..4a27a44e2ec6 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_dev.h
> @@ -72,6 +72,9 @@ struct komeda_dev {
>  	/** @mck: HW main engine clk */
>  	struct clk *mclk;
>  
> +	/** @irq: irq number */
> +	u32 irq;
> +
>  	int n_pipelines;
>  	struct komeda_pipeline *pipelines[KOMEDA_MAX_PIPELINES];
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> index 9293598b0533..e731b2a85c3a 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.c
> @@ -55,6 +55,10 @@ void komeda_pipeline_destroy(struct komeda_dev *mdev,
>  	clk_put(pipe->pxlclk);
>  	clk_put(pipe->aclk);
>  
> +	of_node_put(pipe->of_output_dev);
> +	of_node_put(pipe->of_output_port);
> +	of_node_put(pipe->of_node);
> +
>  	devm_kfree(mdev->dev, pipe);
>  }
>  
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> index 2174796d47c5..d1e0c1140273 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_pipeline.h
> @@ -290,6 +290,13 @@ struct komeda_pipeline {
>  	struct komeda_improc *improc;
>  	struct komeda_timing_ctrlr *ctrlr;
>  	struct komeda_pipeline_funcs *funcs; /* private pipeline functions */
> +
> +	/** @of_node: pipeline dt node */
> +	struct device_node *of_node;
> +	/** @of_output_port: pipeline output port */
> +	struct device_node *of_output_port;
> +	/** @of_output_dev: output connector device node */
> +	struct device_node *of_output_dev;
>  };
>  
>  /**
> -- 
> 2.17.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
