Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA5C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13E5D20700
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NM1hsxe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E5D20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbeLFPSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:18:47 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40956 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbeLFPSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:18:43 -0500
Received: by mail-wm1-f65.google.com with SMTP id q26so1412842wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 07:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFuzQAonVH5LBUCWgd9kxnQqOxUMhbJSx8M/Xm/UTNE=;
        b=NM1hsxe20rGBoKEM0JaW2QIYofsAFl0EeGKtnT2NnuqP0PzMp5TF7JSaBz5V3odkY3
         pPUQ76CO16LVvd9exqW4s3b97+TfNK/ryjW27OvZSy9ZFvPVjpKhogSbJFp5ORBm/k9n
         j2raMNxBEMjSFw0SR4qLVdn1Stzi42R+3CC0WiLZDBJeJJR6zJt5nlFOVbUg/pR482Tx
         gWHDv+xH78uosEKO/46RRa3OYXlErksskp29L6ga6u2/A5BsTOr/bD5Ed9bY9HDqZLUg
         /fwB9HtbEAcuFr99Ga2DnOxcLWTVYWACBChB3eNYyZvmpY/xYZmabqLcfLIrfYO9I+1y
         0Mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFuzQAonVH5LBUCWgd9kxnQqOxUMhbJSx8M/Xm/UTNE=;
        b=nTux/Xz4GO5vPvhRStHCj5MjQJFghMgYl/W/q8CQ8LTuSnLbUlXjaHOCtYo+q6sfNj
         es1bIAS8rKl2clzWZqfbguQefjBE3z6BaI0adbWFvkdi2SvU+s0EiCdXszST11zadbZS
         ob45jhz5WWLp7b8Cfq9zbl/ZjdsdLg3YFKgvMg4nKKs9Oxr+cRC4JThz3uHsd7CdFDuJ
         MsNtlZh+pO/0Iw0GKq8ZMFtR7rEff8uLx2LOuiHXtaBjyCHxGj3spAADkewWrGVOpjQe
         rrBkyhMz/H/JJ8d7JGBSPF/b2zFnUCeuIYkaB2RdpH/Z5gqeXdvhe3iRdntjgdjDea3Y
         rMtQ==
X-Gm-Message-State: AA+aEWaGNNnRFQ1EPGuJLpWlXortALRlY/gzI9i8Xzx3hoL9jXayUYfZ
        U+KG7FONF4xSUUbrz0loeoEpIw==
X-Google-Smtp-Source: AFSGD/WPuB8R+c4BlfluBlJMpa2T2e3fr20rQlDhnG1K/3zIfrNTc9/AYDvHDgs3Zf4DS2ZlivQvbQ==
X-Received: by 2002:a1c:e513:: with SMTP id c19mr21131061wmh.101.1544109522035;
        Thu, 06 Dec 2018 07:18:42 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id j33sm939652wre.91.2018.12.06.07.18.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 07:18:41 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-mmc@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFT PATCH 4/4] mmc: meson-gx: add signal resampling
Date:   Thu,  6 Dec 2018 16:18:28 +0100
Message-Id: <20181206151828.24417-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206151828.24417-1-jbrunet@baylibre.com>
References: <20181206151828.24417-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With some eMMC devices, there is still issues with the new phase
settings. Enabling signal resampling seems to solve the problem
for these.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/mmc/host/meson-gx-mmc.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 837bed0b8c01..c2690c1a50ff 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -66,6 +66,9 @@
 
 #define SD_EMMC_DELAY 0x4
 #define SD_EMMC_ADJUST 0x8
+#define   ADJUST_ADJ_DELAY_MASK GENMASK(21, 16)
+#define   ADJUST_DS_EN BIT(15)
+#define   ADJUST_ADJ_EN BIT(13)
 
 #define SD_EMMC_DELAY1 0x4
 #define SD_EMMC_DELAY2 0x8
@@ -143,6 +146,7 @@ struct meson_mmc_data {
 	unsigned int tx_delay_mask;
 	unsigned int rx_delay_mask;
 	unsigned int always_on;
+	unsigned int adjust;
 };
 
 struct sd_emmc_desc {
@@ -1162,7 +1166,7 @@ static int meson_mmc_get_cd(struct mmc_host *mmc)
 
 static void meson_mmc_cfg_init(struct meson_host *host)
 {
-	u32 cfg = 0;
+	u32 cfg = 0, adj = 0;
 
 	cfg |= FIELD_PREP(CFG_RESP_TIMEOUT_MASK,
 			  ilog2(SD_EMMC_CFG_RESP_TIMEOUT));
@@ -1173,6 +1177,10 @@ static void meson_mmc_cfg_init(struct meson_host *host)
 	cfg |= CFG_ERR_ABORT;
 
 	writel(cfg, host->regs + SD_EMMC_CFG);
+
+	/* enable signal resampling w/o delay */
+	adj = ADJUST_ADJ_EN;
+	writel(adj, host->regs + host->data->adjust);
 }
 
 static int meson_mmc_card_busy(struct mmc_host *mmc)
@@ -1396,12 +1404,14 @@ static const struct meson_mmc_data meson_gx_data = {
 	.tx_delay_mask	= CLK_V2_TX_DELAY_MASK,
 	.rx_delay_mask	= CLK_V2_RX_DELAY_MASK,
 	.always_on	= CLK_V2_ALWAYS_ON,
+	.adjust		= SD_EMMC_ADJUST,
 };
 
 static const struct meson_mmc_data meson_axg_data = {
 	.tx_delay_mask	= CLK_V3_TX_DELAY_MASK,
 	.rx_delay_mask	= CLK_V3_RX_DELAY_MASK,
 	.always_on	= CLK_V3_ALWAYS_ON,
+	.adjust		= SD_EMMC_V3_ADJUST,
 };
 
 static const struct of_device_id meson_mmc_of_match[] = {
-- 
2.19.2

