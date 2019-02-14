Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3308BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6D7221B24
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 20:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="QWlKv6+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503169AbfBNUs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 15:48:27 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:34475 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408083AbfBNUsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 15:48:24 -0500
Received: by mail-qt1-f193.google.com with SMTP id w4so8555140qtc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 12:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GneO+662dvgEVfHBE4flzPB1dAILormUzzmyDMsEYyU=;
        b=QWlKv6+fUmSJeFFYEzNRW5NhgclPr5wskbK3IIzM1FQ0gnJAxZCel2NVUqZ1VZgC1w
         ir0QXanpcBaHEk1J+P4J5AZvP7tG0DxvMykAC17sxGbI/huFHiX0GCSkS/o0YlIlmQfQ
         u5+Wb5wm0g85Ll+6XJeJpInp8E4/DkHmUR/hhB5wiiXlCWuEcMVNXJDFgitq2HZ7h9Le
         gg/4Bmb7H1qALWnybnhIQft2+gE/kTXD5Ac5nNTqXfUJ/o7WrXPR2FYTFagNgXwXNRNY
         8k01i4+4XM9WNlXCm1NPuBMqHtYPnI1IzDgEVoF9igtt2r3gSY1fojOfjJ+bt9W96Ufl
         m4Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GneO+662dvgEVfHBE4flzPB1dAILormUzzmyDMsEYyU=;
        b=sz4wa7ad98frIN5n+p4fkZmRppARVfNaaY/hySJ8DUjt3A+Ke5R5Mt90LhZNbAvNHi
         mlIZjYowTjQEsiEDziMxcH+n/ttT1Xs8cImxViVJ2cU3kgf2gdB5hva3CnNXPFjzNXOf
         LaB+hJyyir93USo0wDelOniuTyMfO+QJ1N3If/1jY7phUkVYL2BWA+M1SjcgwKZqpYNE
         e3jVj3453z2L6isxvA4dawqlIEmTqftGdXwDZFS+qmBd2qZvXZmCf4aWc6futq/ihmDq
         09ZneWDt3S4QmytbWx3abifoGKcjPD6Sc/qyNlbj7FPwuD7/OlolHYZKeYP5BRcYmD9I
         8DnA==
X-Gm-Message-State: AHQUAuaKgJrM+AwV4gwx28yIIFtz4hmaaBpmoZHsh2RBByOMGDiN2I8M
        ju9FTcYSV6VoC3xLdHXo7vyAMw==
X-Google-Smtp-Source: AHgI3IYAktSAVcy0WAZehwS5gnft0O1Zek9k3dgnK2EMjWqP6Z/b3AlExS2AN649A8lcU/s1ao/+cQ==
X-Received: by 2002:aed:3f05:: with SMTP id p5mr4791939qtf.114.1550177302625;
        Thu, 14 Feb 2019 12:48:22 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id p127sm1587057qke.97.2019.02.14.12.48.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 12:48:22 -0800 (PST)
Date:   Thu, 14 Feb 2019 15:48:21 -0500
From:   Sean Paul <sean@poorly.run>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, linux-pwm@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        drinkcat@chromium.org, Thierry Reding <treding@nvidia.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Rahul Sharma <rahul.sharma@samsung.com>,
        Sean Paul <seanpaul@chromium.org>,
        Vincent Palatin <vpalatin@chromium.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        cawa.cheng@mediatek.com, bibby.hsieh@mediatek.com,
        ck.hu@mediatek.com, stonea168@163.com
Subject: Re: [PATCH 1/3] drm/mediatek: move mipi_dsi_host_register to probe
Message-ID: <20190214204821.GP114153@art_vandelay>
References: <20190214044243.129920-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190214044243.129920-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 12:42:41PM +0800, Jitao Shi wrote:
> DSI panel driver need attach function which is inculde in
> mipi_dsi_host_ops.

Which function is required from dsi_host?

Sean

> 
> If mipi_dsi_host_register is not in probe, dsi panel will
> probe fail or more delay.
> 
> So move the mipi_dsi_host_register to probe from bind.
> 
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 49 ++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
> index 27b507eb4a99..93fa255b4aad 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1045,12 +1045,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>  		return ret;
>  	}
>  
> -	ret = mipi_dsi_host_register(&dsi->host);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to register DSI host: %d\n", ret);
> -		goto err_ddp_comp_unregister;
> -	}
> -
>  	ret = mtk_dsi_create_conn_enc(drm, dsi);
>  	if (ret) {
>  		DRM_ERROR("Encoder create failed with %d\n", ret);
> @@ -1060,8 +1054,6 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>  	return 0;
>  
>  err_unregister:
> -	mipi_dsi_host_unregister(&dsi->host);
> -err_ddp_comp_unregister:
>  	mtk_ddp_comp_unregister(drm, &dsi->ddp_comp);
>  	return ret;
>  }
> @@ -1097,31 +1089,37 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  
>  	dsi->host.ops = &mtk_dsi_ops;
>  	dsi->host.dev = dev;
> +	dsi->dev = dev;
> +	ret = mipi_dsi_host_register(&dsi->host);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register DSI host: %d\n", ret);
> +		return -EPROBE_DEFER;
> +	}
>  
>  	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
>  					  &dsi->panel, &dsi->bridge);
>  	if (ret)
> -		return ret;
> +		goto err_unregister_host;
>  
>  	dsi->engine_clk = devm_clk_get(dev, "engine");
>  	if (IS_ERR(dsi->engine_clk)) {
>  		ret = PTR_ERR(dsi->engine_clk);
>  		dev_err(dev, "Failed to get engine clock: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	dsi->digital_clk = devm_clk_get(dev, "digital");
>  	if (IS_ERR(dsi->digital_clk)) {
>  		ret = PTR_ERR(dsi->digital_clk);
>  		dev_err(dev, "Failed to get digital clock: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	dsi->hs_clk = devm_clk_get(dev, "hs");
>  	if (IS_ERR(dsi->hs_clk)) {
>  		ret = PTR_ERR(dsi->hs_clk);
>  		dev_err(dev, "Failed to get hs clock: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> @@ -1129,33 +1127,35 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  	if (IS_ERR(dsi->regs)) {
>  		ret = PTR_ERR(dsi->regs);
>  		dev_err(dev, "Failed to ioremap memory: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	dsi->phy = devm_phy_get(dev, "dphy");
>  	if (IS_ERR(dsi->phy)) {
>  		ret = PTR_ERR(dsi->phy);
>  		dev_err(dev, "Failed to get MIPI-DPHY: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DSI);
>  	if (comp_id < 0) {
>  		dev_err(dev, "Failed to identify by alias: %d\n", comp_id);
> -		return comp_id;
> +		ret = comp_id;
> +		goto err_unregister_host;
>  	}
>  
>  	ret = mtk_ddp_comp_init(dev, dev->of_node, &dsi->ddp_comp, comp_id,
>  				&mtk_dsi_funcs);
>  	if (ret) {
>  		dev_err(dev, "Failed to initialize component: %d\n", ret);
> -		return ret;
> +		goto err_unregister_host;
>  	}
>  
>  	irq_num = platform_get_irq(pdev, 0);
>  	if (irq_num < 0) {
>  		dev_err(&pdev->dev, "failed to request dsi irq resource\n");
> -		return -EPROBE_DEFER;
> +		ret = -EPROBE_DEFER;
> +		goto err_unregister_host;
>  	}
>  
>  	irq_set_status_flags(irq_num, IRQ_TYPE_LEVEL_LOW);
> @@ -1163,14 +1163,25 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>  			       IRQF_TRIGGER_LOW, dev_name(&pdev->dev), dsi);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to request mediatek dsi irq\n");
> -		return -EPROBE_DEFER;
> +		ret = -EPROBE_DEFER;
> +		goto err_unregister_host;
>  	}
>  
>  	init_waitqueue_head(&dsi->irq_wait_queue);
>  
>  	platform_set_drvdata(pdev, dsi);
>  
> -	return component_add(&pdev->dev, &mtk_dsi_component_ops);
> +	ret = component_add(&pdev->dev, &mtk_dsi_component_ops);
> +	if (ret) {
> +		ret = -EPROBE_DEFER;
> +		goto err_unregister_host;
> +	}
> +
> +	return 0;
> +
> +err_unregister_host:
> +	mipi_dsi_host_unregister(&dsi->host);
> +	return ret;
>  }
>  
>  static int mtk_dsi_remove(struct platform_device *pdev)
> -- 
> 2.20.1
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
