Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62BDC282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B572086C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 14:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ckwv2dDv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbfBBOCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 09:02:08 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37595 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfBBOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 09:02:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so4705789pfb.4;
        Sat, 02 Feb 2019 06:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lpNalN9JAmJx2WE7d3q5/LfYlt3kkeQcYw9k8QFKQWc=;
        b=Ckwv2dDvooZrvb2FdnRXv/vCVYY5PdZF+xeNJYzhppk9PFZ3xxS2BZCqSVH2jKgsFR
         tzfvLUzqPV+y5QEeszYhhZaNoVLQw8TJyVgozOw5joIoVU0iFjndSRx1nj9OU1d7FwWw
         8f9kRXrWDH1wbeNc9pEBRdbYqpwzqD/cOw0LmXtBLv0fgnDDRZW6POdditqlYEODdkMV
         v75WOrNE709ddI26eA9cDieiTdFWZ8hDKYEtm/Gdrn6hcbIDpRS4JYFv5mf1VijWlteZ
         jPnBiDDJ1sE6t0Xm/cWZZzy7MYEsmxczoywxG+WkW5t0NuQweMw/43VopBJ/XzKZMdfx
         q2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lpNalN9JAmJx2WE7d3q5/LfYlt3kkeQcYw9k8QFKQWc=;
        b=GI36tZ4alOE7rxSwZ6afMwZgG/tS1gUU28rCJpt0ZDNjFakk8ve326OAaCPb9jyAwM
         dSgWUjaJ6aEQlZiMhCA9xMNtNcR4HJGkjmu7DKt+Qlu/VAFbRmIagZQrcQtmU3YoOTmD
         KeZc2nKf7G0IK9PDAGdOcpw2n8EMHtlo1NfH9mBwzxy4FrPXgmdbvA7662wMmR7R4sbd
         elVtLGvfTURw6zM8mWdWe7F6bp1bWA17QTiYv2U86DvGQb9QbsAwesvzC1aeBIYHfJLf
         ldj1U7XtVgbQTU1YKFC/EL8TJnvxSukvIplbnBltYxJTkmpq5JH5rxhix4+tB81RxTHr
         XWuw==
X-Gm-Message-State: AJcUukc2W+sORglLNNIqc1C6LFgaCO53zs+7hmifGvRD2xNChILgMs7W
        zyjjz2H/iCwVLLyQuC1y1eJpsJBx
X-Google-Smtp-Source: ALg8bN5RDqzqt4bLa024f7QDUTqL3cmVHMtIKe2R/SPh+CijmcASHCqhJICc3Ku5b7vCu4EPvT27MA==
X-Received: by 2002:a63:9402:: with SMTP id m2mr38206663pge.93.1549116127010;
        Sat, 02 Feb 2019 06:02:07 -0800 (PST)
Received: from [192.168.2.145] (ppp91-79-175-49.pppoe.mtu-net.ru. [91.79.175.49])
        by smtp.googlemail.com with ESMTPSA id w3sm13726584pge.8.2019.02.02.06.02.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 06:02:06 -0800 (PST)
Subject: Re: [PATCH V9 3/5] i2c: tegra: Add DMA support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        mkarthik@nvidia.com, smohammed@nvidia.com, talho@nvidia.com
Cc:     linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-i2c@vger.kernel.org
References: <1549040867-18149-1-git-send-email-skomatineni@nvidia.com>
 <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d37e901b-1c26-3d9c-7f68-29e06f4ff993@gmail.com>
Date:   Sat, 2 Feb 2019 17:01:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1549040867-18149-3-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

01.02.2019 20:07, Sowjanya Komatineni пишет:
> This patch adds DMA support for Tegra I2C.
> 
> Tegra I2C TX and RX FIFO depth is 8 words. PIO mode is used for
> transfer size of the max FIFO depth and DMA mode is used for
> transfer size higher than max FIFO depth to save CPU overhead.
> 
> PIO mode needs full intervention of CPU to fill or empty FIFO's
> and also need to service multiple data requests interrupt for the
> same transaction. This adds delay between data bytes of the same
> transfer when CPU is fully loaded and some slave devices has
> internal timeout for no bus activity and stops transaction to
> avoid bus hang. DMA mode is helpful in such cases.
> 
> DMA mode is also helpful for Large transfers during downloading or
> uploading FW over I2C to some external devices.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  [V9] : Rebased to 5.0-rc4
> 	Removed dependency of APB DMA in Kconfig and added conditional check
> 	in I2C driver to decide on using DMA mode.
> 	Changed back the allocation of dma buffer during i2c probe.
> 	Fixed FIFO triggers depending on DMA Vs PIO.
>  [V8] : Moved back dma init to i2c probe, removed ALL_PACKETS_XFER_COMPLETE
> 	interrupt and using PACKETS_XFER_COMPLETE interrupt only and some
> 	other fixes
> 	Updated Kconfig for APB_DMA dependency
>  [V7] : Same as V6
>  [V6] : Updated for proper buffer allocation/freeing, channel release.
> 	Updated to use exact xfer size for syncing dma buffer.
>  [V5] : Same as V4
>  [V4] : Updated to allocate DMA buffer only when DMA mode.
> 	Updated to fall back to PIO mode when DMA channel request or
> 	buffer allocation fails.
>  [V3] : Updated without additional buffer allocation.
>  [V2] : Updated based on V1 review feedback along with code cleanup for
> 	proper implementation of DMA.
> 
>  drivers/i2c/busses/i2c-tegra.c | 368 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 335 insertions(+), 33 deletions(-)


[snip]


> +static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
> +{
> +	struct dma_chan *dma_chan;
> +	u32 *dma_buf;
> +	dma_addr_t dma_phys;
> +	int err = 0;
> +
> +	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
> +		return -ENODEV;

Another detail is that we need to keep older kernels working on T186+ after its device-tree will get the "dmas" property, device-tree changes shall be backwards-compatible with older kernels. Hence we need to check that platform actually wants the APB DMA driver, otherwise T186+ will be failing with -EPROBE_DEFER.

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 32d5744bce45..822a84013a6d 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -227,6 +227,7 @@ struct tegra_i2c_hw_feature {
 	u32 setup_hold_time_std_mode;
 	u32 setup_hold_time_fast_fast_plus_mode;
 	u32 setup_hold_time_hs_mode;
+	bool has_apb_dma;
 };
 
 /**
@@ -396,7 +397,7 @@ static int tegra_i2c_init_dma(struct tegra_i2c_dev *i2c_dev)
 	dma_addr_t dma_phys;
 	int err = 0;
 
-	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA))
+	if (!IS_ENABLED(CONFIG_TEGRA20_APB_DMA) || !i2c_dev->hw->has_apb_dma)
 		return -ENODEV;
 
 	dma_chan = dma_request_slave_channel_reason(i2c_dev->dev, "rx");
@@ -1283,6 +1284,7 @@ static const struct tegra_i2c_hw_feature tegra20_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
@@ -1306,6 +1308,7 @@ static const struct tegra_i2c_hw_feature tegra30_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
@@ -1329,6 +1332,7 @@ static const struct tegra_i2c_hw_feature tegra114_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
@@ -1352,6 +1356,7 @@ static const struct tegra_i2c_hw_feature tegra124_i2c_hw = {
 	.setup_hold_time_std_mode = 0x0,
 	.setup_hold_time_fast_fast_plus_mode = 0x0,
 	.setup_hold_time_hs_mode = 0x0,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
@@ -1375,6 +1380,7 @@ static const struct tegra_i2c_hw_feature tegra210_i2c_hw = {
 	.setup_hold_time_std_mode = 0,
 	.setup_hold_time_fast_fast_plus_mode = 0,
 	.setup_hold_time_hs_mode = 0,
+	.has_apb_dma = true,
 };
 
 static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
@@ -1398,6 +1404,7 @@ static const struct tegra_i2c_hw_feature tegra186_i2c_hw = {
 	.setup_hold_time_std_mode = 0,
 	.setup_hold_time_fast_fast_plus_mode = 0,
 	.setup_hold_time_hs_mode = 0,
+	.has_apb_dma = false,
 };
 
 static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
@@ -1421,6 +1428,7 @@ static const struct tegra_i2c_hw_feature tegra194_i2c_hw = {
 	.setup_hold_time_std_mode = 0x08080808,
 	.setup_hold_time_fast_fast_plus_mode = 0x02020202,
 	.setup_hold_time_hs_mode = 0x090909,
+	.has_apb_dma = false,
 };
 
 /* Match table for of_platform binding */
