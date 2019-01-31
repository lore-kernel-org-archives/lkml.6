Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457B8C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3417218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 18:09:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HYLJAOKp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbfAaSJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 13:09:04 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42197 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbfAaSJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 13:09:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so3022150lfh.9;
        Thu, 31 Jan 2019 10:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tsmy8npWlyE1stC8H1t9pLtA9B73ZSnxh2/vKngONSc=;
        b=HYLJAOKp9m2bxhGHY2JdKGaEwP7yOQhHtriuXoPfpqoFOxfIO2y3AAOHNP8kewMh0Y
         38ZXiKUrVpu5NJXdNPrZYgzWLfDI4MQL7xZssgbuOqXCLy3rzungQdj6V8OBaP1e6QnD
         QFo9ruNkPVQLF5/fhyjBekOnGcS9o+qp++B+S7fagLkw+BkksL6fj2IWdxzR2gVrmHJF
         Gtr9cq7noPDtWVicVwZcF5TD5dECIidJtAuaMrV+r6jGe6f9zsmZmK3/BgWLEZYoTB8w
         6vEcVGHv3i3niMIeSquhuy+dDfCH27ycNulm8pdBeU18VVv11QRc2mBY0mPzG/O0jOTT
         jLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tsmy8npWlyE1stC8H1t9pLtA9B73ZSnxh2/vKngONSc=;
        b=F0nAKPiWfi05NQvBkJBSM40Q/cpRFeyi103ZUCFfrwPURQoKM7Z4pcvq0wzuuXA778
         yjNiddGl7QXrmVECl9EG262Fn3LymiOBvJlAVvuFHyxaweAsCUzDwErRqcQfpy07S3HF
         4upD6N62zIJPt70a/cDIBl35GctiVlZJjhDxop5pVTjbS6s4MOYdwAoKj52q+oWX/lYe
         MB5AnABix4EbKANqnrcd1EYeGtbW1Wd5bEP0Wz5mJXwgXCqkBR74vkjl9CWRal+1ITrx
         7n7doedcKFGWAXlT6LeHl8VdQdLi0O1gB2QGVuLbwrOmwHgMzNihgkv1ZIoydZxREMmP
         DTOA==
X-Gm-Message-State: AJcUukeKesc6M20oeZxvRPEV+gbc6CSwQyIskCJaEORCCBByWz0bKoM7
        oycLIyGoDhz4T3DtcZdOl7bBIcbD
X-Google-Smtp-Source: ALg8bN6n2Jqj5m/+wHjyRjBL8uUYzIvvskWdknycRyHutvsP1svRaarYhLaeVQsFbxhdq81SDm1Daw==
X-Received: by 2002:a19:4dd0:: with SMTP id a199mr29295026lfb.42.1548958140412;
        Thu, 31 Jan 2019 10:09:00 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id w12sm951815lfe.80.2019.01.31.10.08.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 10:08:59 -0800 (PST)
Subject: Re: [PATCH V7 3/5] i2c: tegra: Add DMA Support
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     jonathanh@nvidia.com, mkarthik@nvidia.com, smohammed@nvidia.com,
        talho@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
References: <1548864096-20974-1-git-send-email-skomatineni@nvidia.com>
 <1548864096-20974-3-git-send-email-skomatineni@nvidia.com>
 <1f10cb76-59a1-93c5-ae03-ccc0cd8db1a3@gmail.com>
 <20190131120640.GF23438@ulmo>
 <0e832fa6-f143-7b24-2685-b88a55e77e51@gmail.com>
 <20190131144344.GP23438@ulmo>
 <bdb5ab9f-b047-6b9e-696a-8d6ef4065c77@gmail.com>
 <6c2909cb-f31c-921d-8449-79ec77c02d9b@gmail.com>
Message-ID: <48135b67-eed7-9a9d-de3e-e400e8ef8176@gmail.com>
Date:   Thu, 31 Jan 2019 21:08:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <6c2909cb-f31c-921d-8449-79ec77c02d9b@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

31.01.2019 19:55, Dmitry Osipenko пишет:
> config I2C_TEGRA
> 	tristate "NVIDIA Tegra internal I2C controller"
> 	depends on ARCH_TEGRA
> 	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_2x_SOC)
> 	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_3x_SOC)
> 	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_114_SOC)
> 	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_124_SOC)
> 	select TEGRA20_APB_DMA if (I2C_TEGRA_DMA_SUPPORT && ARCH_TEGRA_210_SOC)
> 	help
> 	  If you say yes to this option, support will be included for the
> 	  I2C controller embedded in NVIDIA Tegra SOCs
> 
> config I2C_TEGRA_DMA_SUPPORT
> 	bool "NVIDIA Tegra internal I2C controller DMA support"
> 	depends on I2C_TEGRA
> 	help
> 	  If you say yes to this option, DMA engine integration support will
> 	  be included for the I2C controller embedded in NVIDIA Tegra SOCs

Thinking a bit more on it, perhaps this will be an ideal variant:

On top of V8:
diff --git a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
index 046aeb92a467..520ead24fb51 100644
--- a/drivers/i2c/busses/Kconfig
+++ b/drivers/i2c/busses/Kconfig
@@ -1016,11 +1016,23 @@ config I2C_SYNQUACER
 
 config I2C_TEGRA
 	tristate "NVIDIA Tegra internal I2C controller"
-	depends on (ARCH_TEGRA && TEGRA20_APB_DMA)
+	depends on ARCH_TEGRA
 	help
 	  If you say yes to this option, support will be included for the
 	  I2C controller embedded in NVIDIA Tegra SOCs
 
+config I2C_TEGRA_DMA_SUPPORT
+	bool "NVIDIA Tegra internal I2C controller DMA support"
+	depends on I2C_TEGRA
+	depends on TEGRA20_APB_DMA && ARCH_TEGRA_2x_SOC
+	depends on TEGRA20_APB_DMA && ARCH_TEGRA_3x_SOC
+	depends on TEGRA20_APB_DMA && ARCH_TEGRA_114_SOC
+	depends on TEGRA20_APB_DMA && ARCH_TEGRA_124_SOC
+	depends on TEGRA20_APB_DMA && ARCH_TEGRA_210_SOC
+	help
+	  If you say yes to this option, DMA engine integration support will
+	  be included for the I2C controller embedded in NVIDIA Tegra SOCs
+
 config I2C_TEGRA_BPMP
 	tristate "NVIDIA Tegra BPMP I2C controller"
 	depends on TEGRA_BPMP
diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index fe5b89abc576..bce7283b027b 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -225,6 +225,7 @@ struct tegra_i2c_hw_feature {
 	u32 setup_hold_time_std_mode;
 	u32 setup_hold_time_fast_fast_plus_mode;
 	u32 setup_hold_time_hs_mode;
+	bool has_gpc_dma;
 };
 
 /**
@@ -389,51 +390,51 @@ static int tegra_i2c_dma_submit(struct tegra_i2c_dev *i2c_dev, size_t len)
 	return 0;
 }
 
-static int tegra_i2c_init_dma_param(struct tegra_i2c_dev *i2c_dev)
+static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 {
-	struct dma_chan *dma_chan;
-	u32 *dma_buf;
-	dma_addr_t dma_phys;
+	struct device *dev = i2c_dev->dev;
+	int err;
 
 	if (!i2c_dev->has_dma)
-		return -EINVAL;
-
-	if (!i2c_dev->rx_dma_chan) {
-		dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
-		if (IS_ERR(dma_chan))
-			return PTR_ERR(dma_chan);
+		return 0;
 
-		i2c_dev->rx_dma_chan = dma_chan;
+	i2c_dev->rx_dma_chan = dma_request_slave_channel_reason(dev, "rx");
+	if (IS_ERR(i2c_dev->rx_dma_chan)) {
+		err = PTR_ERR(i2c_dev->rx_dma_chan);
+		goto err_out;
 	}
 
-	if (!i2c_dev->tx_dma_chan) {
-		dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "tx");
-		if (IS_ERR(dma_chan))
-			return PTR_ERR(dma_chan);
-
-		i2c_dev->tx_dma_chan = dma_chan;
+	i2c_dev->tx_dma_chan = dma_request_slave_channel_reason(dev, "tx");
+	if (IS_ERR(i2c_dev->tx_dma_chan)) {
+		err = PTR_ERR(i2c_dev->tx_dma_chan);
+		goto err_release_rx;
 	}
 
-	if (!i2c_dev->dma_buf && i2c_dev->msg_buf_remaining) {
-		dma_buf = dma_alloc_coherent(i2c_dev->dev,
-					     i2c_dev->dma_buf_size,
-					     &dma_phys, GFP_KERNEL);
+	i2c_dev->dma_buf = dma_alloc_coherent(dev, i2c_dev->dma_buf_size,
+					      &i2c_dev->dma_phys,
+					      GFP_KERNEL | __GFP_NOWARN);
+	if (!i2c_dev->dma_buf) {
+		dev_err(dev, "failed to allocate the DMA buffer\n");
+		err = -ENOMEM;
+		goto err_release_tx;
+	}
 
-		if (!dma_buf) {
-			dev_err(i2c_dev->dev,
-				"failed to allocate the DMA buffer\n");
-			dma_release_channel(i2c_dev->tx_dma_chan);
-			dma_release_channel(i2c_dev->rx_dma_chan);
-			i2c_dev->tx_dma_chan = NULL;
-			i2c_dev->rx_dma_chan = NULL;
-			return -ENOMEM;
-		}
+	return 0;
 
-		i2c_dev->dma_buf = dma_buf;
-		i2c_dev->dma_phys = dma_phys;
+err_release_tx:
+	dma_release_channel(i2c_dev->tx_dma_chan);
+err_release_rx:
+	dma_release_channel(i2c_dev->rx_dma_chan);
+err_out:
+	if (err == -ENODEV) {
+		i2c_dev->has_dma = false;
+		i2c_dev->tx_dma_chan = NULL;
+		i2c_dev->rx_dma_chan = NULL;
+		i2c_dev->dma_buf = NULL;
+		return 0;
 	}
 
-	return 0;
+	return err;
 }
 
 static int tegra_i2c_flush_fifos(struct tegra_i2c_dev *i2c_dev)
@@ -991,8 +992,8 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	size_t xfer_size;
 	u32 *buffer = 0;
 	int err = 0;
-	bool dma = false;
-	struct dma_chan *chan;
+	bool dma;
+	struct dma_chan *chan = NULL;
 	u16 xfer_time = 100;
 
 	tegra_i2c_flush_fifos(i2c_dev);
@@ -1016,14 +1017,7 @@ static int tegra_i2c_xfer_msg(struct tegra_i2c_dev *i2c_dev,
 	xfer_time += DIV_ROUND_CLOSEST(((xfer_size * 9) + 2) * 1000,
 					i2c_dev->bus_clk_rate);
 
-	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN);
-	if (dma) {
-		err = tegra_i2c_init_dma_param(i2c_dev);
-		if (err < 0) {
-			dev_dbg(i2c_dev->dev, "switching to PIO transfer\n");
-			dma = false;
-		}
-	}
+	dma = (xfer_size > I2C_PIO_MODE_MAX_LEN) && i2c_dev->has_dma;
 
 	i2c_dev->is_curr_dma_xfer = dma;
 	spin_lock_irqsave(&i2c_dev->xfer_lock, flags);
@@ -1245,7 +1239,10 @@ static void tegra_i2c_parse_dt(struct tegra_i2c_dev *i2c_dev)
 	i2c_dev->is_multimaster_mode = of_property_read_bool(np,
 			"multi-master");
 
-	i2c_dev->has_dma = of_property_read_bool(np, "dmas");
+	if (IS_ENABLED(CONFIG_I2C_TEGRA_DMA_SUPPORT) &&
+	    IS_ENABLED(CONFIG_TEGRA20_APB_DMA) &&
+	    !i2c_dev->hw->has_gpc_dma)
+		i2c_dev->has_dma = true;
 }
 
 static const struct i2c_algorithm tegra_i2c_algo = {
@@ -1280,6 +1277,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_gpc_dma = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -1302,6 +1300,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_gpc_dma = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -1324,6 +1323,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_gpc_dma = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -1346,6 +1346,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_gpc_dma = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -1368,6 +1369,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.setup_hold_time_std_mode = 0,
 	.setup_hold_time_fast_fast_plus_mode = 0,
 	.setup_hold_time_hs_mode = 0,
+	.has_gpc_dma = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
@@ -1390,6 +1392,7 @@ static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.setup_hold_time_std_mode = 0,
 	.setup_hold_time_fast_fast_plus_mode = 0,
 	.setup_hold_time_hs_mode = 0,
+	.has_gpc_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -1412,6 +1415,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.setup_hold_time_std_mode = 0x08080808,
 	.setup_hold_time_fast_fast_plus_mode = 0x02020202,
 	.setup_hold_time_hs_mode = 0x090909,
+	.has_gpc_dma = true,
 };
 
 /* Match table for of_platform binding */
@@ -1479,8 +1483,6 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		return PTR_ERR(i2c_dev->rst);
 	}
 
-	tegra_i2c_parse_dt(i2c_dev);
-
 	i2c_dev->hw = of_device_get_match_data(&pdev->dev);
 	i2c_dev->is_dvc = of_device_is_compatible(pdev->dev.of_node,
 						  "nvidia,tegra20-i2c-dvc");
@@ -1488,6 +1490,8 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	init_completion(&i2c_dev->dma_complete);
 	spin_lock_init(&i2c_dev->xfer_lock);
 
+	tegra_i2c_parse_dt(i2c_dev);
+
 	if (!i2c_dev->hw->has_single_clk_source) {
 		fast_clk = devm_clk_get(&pdev->dev, "fast-clk");
 		if (IS_ERR(fast_clk)) {
@@ -1543,7 +1547,7 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 		}
 	}
 
-	ret = tegra_i2c_init_dma_param(i2c_dev);
+	ret = tegra_i2c_init_dma(i2c_dev);
 	if (ret == -EPROBE_DEFER)
 		goto disable_div_clk;
 
@@ -1611,18 +1615,11 @@ static int tegra_i2c_remove(struct platform_device *pdev)
 	if (!i2c_dev->hw->has_single_clk_source)
 		clk_unprepare(i2c_dev->fast_clk);
 
-	if (i2c_dev->dma_buf)
+	if (i2c_dev->has_dma) {
 		dma_free_coherent(i2c_dev->dev, i2c_dev->dma_buf_size,
 				  i2c_dev->dma_buf, i2c_dev->dma_phys);
-
-	if (i2c_dev->tx_dma_chan) {
 		dma_release_channel(i2c_dev->tx_dma_chan);
-		i2c_dev->tx_dma_chan = NULL;
-	}
-
-	if (i2c_dev->rx_dma_chan) {
 		dma_release_channel(i2c_dev->rx_dma_chan);
-		i2c_dev->rx_dma_chan = NULL;
 	}
 
 	return 0;
