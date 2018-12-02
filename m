Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984EDC64EB4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5437420851
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:23:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSodrmB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5437420851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725920AbeLBVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:23:44 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36492 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbeLBVXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:23:42 -0500
Received: by mail-wm1-f68.google.com with SMTP id a18so3762734wmj.1;
        Sun, 02 Dec 2018 13:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7yyznife34qc5hftjhmlPj2tKij05JG3MZXRdWCCZxQ=;
        b=hSodrmB7WNhYM3hepxJhG1wSZHTijT3Gbx2FV/H4g9443iGNczH6BCaRngFkTJU7UH
         mKfOg+nl7tbkbvcjQ6UeeH5D28YFZWezCy7llRmdQ+WPSGRb07k9dxB/iS++QO9GpeHY
         pS3sJOgnEOWiNFyYMEtI6oBBVRiu9tWGmppSKrGsky+qIXcGtVVdyzFMUYed6qNYR6vG
         NbA5DGKB/MEEp7zgxbyVbn946gsswRWmBwbyFuMdxXuC1gdrAJnkAG605aDeHzVUhwvw
         j31DXqi/8GlfrUNmMFLo6XoM4ofPM4O5Tc0Rg0epWvwJ0z0epKeVs94OGnf/kNSmAp5A
         TNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7yyznife34qc5hftjhmlPj2tKij05JG3MZXRdWCCZxQ=;
        b=pTWNWzsKFTpzf1+zJapCccaOsgsYiTERGOHUyZFIKKSkkScWq9V/O/eT3u14bHaRGM
         d+m+9Hsu9qYsE1+TzGZbpbYNbpVicICWFLk3Y32h5XBfspMgxDS27vUP3hQcU1hvLfTE
         1Y5+fKZneGsRtV/9qaGGtOhH1a1ujGoZnWGPJpzMhg0Nq6raGDXQpYYQ+WTI/2vPAJ2O
         CwQB+hFTqS/S1Gn+l1oCpPrc5uRIVphHLXetPo0FzMczXBQ04pDAFxfg4VnmzBCJjueG
         7mt9XC7mJpBAz+h3LzqjLPUqPkDQfUghHDNlX2zonFRGaZtZGQn7/M3mYZN9IF5vhPU0
         ph1Q==
X-Gm-Message-State: AA+aEWZGjsXH8MUSYUzowhSZpIdNOsvSlJJgS1rmQCzpaCu5vYb2i14F
        FjhaUgD8t9xjhH4x+LzsHf4zRIHF9cY=
X-Google-Smtp-Source: AFSGD/V3b5skn+Nmeueq22w0VIu9mzLvFEgabPR8VlTqgRZ/sfDWX1UAvvzx1vlUrXlHhUCpW6PWDg==
X-Received: by 2002:a1c:1903:: with SMTP id 3-v6mr5716302wmz.141.1543785817487;
        Sun, 02 Dec 2018 13:23:37 -0800 (PST)
Received: from ThinkPad.home ([185.219.177.152])
        by smtp.gmail.com with ESMTPSA id d2sm9551043wrs.97.2018.12.02.13.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 02 Dec 2018 13:23:37 -0800 (PST)
From:   Mesih Kilinc <mesihkilinc@gmail.com>
To:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-sunxi@googlegroups.com
Cc:     Mesih Kilinc <mesihkilinc@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [RFC PATCH 04/10] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
Date:   Mon,  3 Dec 2018 00:23:11 +0300
Message-Id: <df1e5fbb2b04b0e5d392ce988d04a39f1d8e5f8d.1543782328.git.mesihkilinc@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1543782328.git.mesihkilinc@gmail.com>
References: <cover.1543782328.git.mesihkilinc@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA of Allwinner suniv F1C100s is similar to sun4i. It has 4 NDMA, 4
DDMA channels and endpoints are different. Also F1C100s has reset bit
for DMA in CCU. Add support for it.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 drivers/dma/Kconfig     |  4 ++--
 drivers/dma/sun4i-dma.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index de511db..f8a65d2 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -163,8 +163,8 @@ config DMA_SA11X0
 
 config DMA_SUN4I
 	tristate "Allwinner A10 DMA SoCs support"
-	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I
-	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I)
+	depends on MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV
+	default (MACH_SUN4I || MACH_SUN5I || MACH_SUN7I || MACH_SUNIV)
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
diff --git a/drivers/dma/sun4i-dma.c b/drivers/dma/sun4i-dma.c
index d267ff9..c0452c9 100644
--- a/drivers/dma/sun4i-dma.c
+++ b/drivers/dma/sun4i-dma.c
@@ -36,7 +36,11 @@
 #define SUN4I_DMA_CFG_SRC_ADDR_MODE(mode)	((mode) << 5)
 #define SUN4I_DMA_CFG_SRC_DRQ_TYPE(type)	(type)
 
+#define SUNIV_DMA_CFG_DST_DATA_WIDTH(width)	((width) << 24)
+#define SUNIV_DMA_CFG_SRC_DATA_WIDTH(width)	((width) << 8)
+
 #define SUN4I_MAX_BURST	8
+#define SUNIV_MAX_BURST	4
 
 /** Normal DMA register values **/
 
@@ -44,6 +48,9 @@
 #define SUN4I_NDMA_DRQ_TYPE_SDRAM		0x16
 #define SUN4I_NDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
 
+#define SUNIV_NDMA_DRQ_TYPE_SDRAM		0x11
+#define SUNIV_NDMA_DRQ_TYPE_LIMIT		(0x17 + 1)
+
 /** Normal DMA register layout **/
 
 /* Dedicated DMA source/destination address mode values */
@@ -57,6 +64,9 @@
 #define SUN4I_NDMA_CFG_BYTE_COUNT_MODE_REMAIN	BIT(15)
 #define SUN4I_NDMA_CFG_SRC_NON_SECURE		BIT(6)
 
+#define SUNIV_NDMA_CFG_CONT_MODE		BIT(29)
+#define SUNIV_NDMA_CFG_WAIT_STATE(n)		((n) << 26)
+
 /** Dedicated DMA register values **/
 
 /* Dedicated DMA source/destination address mode values */
@@ -69,6 +79,9 @@
 #define SUN4I_DDMA_DRQ_TYPE_SDRAM		0x1
 #define SUN4I_DDMA_DRQ_TYPE_LIMIT		(0x1F + 1)
 
+#define SUNIV_DDMA_DRQ_TYPE_SDRAM		0x1
+#define SUNIV_DDMA_DRQ_TYPE_LIMIT		(0x9 + 1)
+
 /** Dedicated DMA register layout **/
 
 /* Dedicated DMA configuration register layout */
@@ -122,6 +135,11 @@
 #define SUN4I_DMA_NR_MAX_VCHANS						\
 	(SUN4I_NDMA_NR_MAX_VCHANS + SUN4I_DDMA_NR_MAX_VCHANS)
 
+#define SUNIV_NDMA_NR_MAX_CHANNELS	4
+#define SUNIV_DDMA_NR_MAX_CHANNELS	4
+#define SUNIV_NDMA_NR_MAX_VCHANS	(24 * 2 - 1)
+#define SUNIV_DDMA_NR_MAX_VCHANS	10
+
 /* This set of SUN4I_DDMA timing parameters were found experimentally while
  * working with the SPI driver and seem to make it behave correctly */
 #define SUN4I_DDMA_MAGIC_SPI_PARAMETERS \
@@ -236,6 +254,16 @@ static void set_src_data_width_a10(u32 *p_cfg, s8 data_width)
 	*p_cfg |= SUN4I_DMA_CFG_SRC_DATA_WIDTH(data_width);
 }
 
+static void set_dst_data_width_f1c100s(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUNIV_DMA_CFG_DST_DATA_WIDTH(data_width);
+}
+
+static void set_src_data_width_f1c100s(u32 *p_cfg, s8 data_width)
+{
+	*p_cfg |= SUNIV_DMA_CFG_SRC_DATA_WIDTH(data_width);
+}
+
 static int convert_burst_a10(u32 maxburst)
 {
 	if (maxburst > 8)
@@ -245,6 +273,15 @@ static int convert_burst_a10(u32 maxburst)
 	return (maxburst >> 2);
 }
 
+static int convert_burst_f1c100s(u32 maxburst)
+{
+	if (maxburst > 4)
+		return -EINVAL;
+
+	/* 1 -> 0, 4 -> 1 */
+	return (maxburst >> 2);
+}
+
 static int convert_buswidth(enum dma_slave_buswidth addr_width)
 {
 	if (addr_width > DMA_SLAVE_BUSWIDTH_4_BYTES)
@@ -1364,8 +1401,31 @@ static struct sun4i_dma_config sun4i_a10_dma_cfg = {
 	.has_reset		= false,
 };
 
+static struct sun4i_dma_config suniv_f1c100s_dma_cfg = {
+	.ndma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS,
+	.ndma_nr_max_vchans	= SUNIV_NDMA_NR_MAX_VCHANS,
+
+	.ddma_nr_max_channels	= SUNIV_DDMA_NR_MAX_CHANNELS,
+	.ddma_nr_max_vchans	= SUNIV_DDMA_NR_MAX_VCHANS,
+
+	.dma_nr_max_channels	= SUNIV_NDMA_NR_MAX_CHANNELS +
+		SUNIV_DDMA_NR_MAX_CHANNELS,
+
+	.set_dst_data_width	= set_dst_data_width_f1c100s,
+	.set_src_data_width	= set_src_data_width_f1c100s,
+	.convert_burst		= convert_burst_f1c100s,
+
+	.ndma_drq_sdram		= SUNIV_NDMA_DRQ_TYPE_SDRAM,
+	.ddma_drq_sdram		= SUNIV_DDMA_DRQ_TYPE_SDRAM,
+
+	.max_burst		= SUNIV_MAX_BURST,
+	.has_reset		= true,
+};
+
 static const struct of_device_id sun4i_dma_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-dma", .data = &sun4i_a10_dma_cfg },
+	{ .compatible = "allwinner,suniv-f1c100s-dma",
+		.data = &suniv_f1c100s_dma_cfg },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, sun4i_dma_match);
-- 
2.7.4

