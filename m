Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B56CCC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787B521738
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YRQETM0X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfA1SNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:13:34 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46383 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727215AbfA1SN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:13:29 -0500
Received: by mail-wr1-f67.google.com with SMTP id l9so19096514wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:13:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f+siZGaqzfEOtCfLeqpMHf07nouZzS+CPt9j+Rvk54A=;
        b=YRQETM0XWxsZO05aLbJ7qWGxVsNgBzHQ8LFJyIJLvU0Y2tl4o6c383lct8UwfoE72+
         VIUy81E5q4+P0va/N8lsEtl8Vo/If7PK71R/0dyJL0+IhLYuMxvO1bNiVPzd9Og+UuRf
         u7jHuvhbR2xxvrh2z9cN1MgWXks8H8ECUvz4BMiF3vCT7WK4XRU7tOMvjnOLdrESVv+S
         RrdSjdQopun7ZIv3tGaV2RVx1n73inpWwoa16s7DX1TZu/qnsAFGdKUO3jlThsotY1qi
         GOzf2yQy47EVNaNTl3YwMzN3PAdOkxOjrSl5hd6c6HA+hUOTxQFKUQp3RE/ZwhKnvy7B
         TH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f+siZGaqzfEOtCfLeqpMHf07nouZzS+CPt9j+Rvk54A=;
        b=F8qCKda8R5PBeZCOygqJLbQhoS7ZJYNLOCQSP+yflUUUTAE90Z29Vo418wMAgQS/i0
         XKvsNsrkFmOoe1aYBQePpxwhfsn8n1xGfe+TC2dqVH57MwC6m4v1pW2pGeeAx6qA+SZe
         LNmC2MnYbSVX1FpZOR95a/NfcgIXajhg8W5s/jTvqIXhGiM4URMZym0oTL+74FQyETgq
         CkExixntLOksfrQSrR+2oRAkZNuTt0RvZ8mpAGMb6NxsJzwOdw4S00Kq6G0Hik5pobJ/
         QAMOYWTDIJZbwz3IGoEoBCMDROx9NoN0mrfmorpsHU9qjTr2C7EpftHoVy0jzlU+7cz7
         tYcA==
X-Gm-Message-State: AJcUukdEldMv/P8OALJpo204t3CZiDx/Z2NVyUFIUauQQ/8sO31jxyt/
        WqTfvUx2NdK88nmO+Mn+Q6pCfA==
X-Google-Smtp-Source: ALg8bN7CFXVea4C3ZJW9W2BZyyvBqeO7Rc+w/E6iZYJsQ65gx3wKGA0S3RjSk9ODXPmRBrVn0/wG3g==
X-Received: by 2002:adf:8228:: with SMTP id 37mr22227459wrb.160.1548699208064;
        Mon, 28 Jan 2019 10:13:28 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id y185sm110654wmg.34.2019.01.28.10.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:13:26 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v2 1/2] dt-bindings: reset: meson: add g12a bindings
Date:   Mon, 28 Jan 2019 19:13:14 +0100
Message-Id: <20190128181316.30814-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190128181316.30814-1-jbrunet@baylibre.com>
References: <20190128181316.30814-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for the reset controller of g12a SoC family.

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 .../bindings/reset/amlogic,meson-reset.txt    |   7 +-
 .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
 2 files changed, 139 insertions(+), 2 deletions(-)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h

diff --git a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
index 28ef6c295c76..053cb1322ee3 100644
--- a/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
+++ b/Documentation/devicetree/bindings/reset/amlogic,meson-reset.txt
@@ -5,8 +5,11 @@ Please also refer to reset.txt in this directory for common reset
 controller binding usage.
 
 Required properties:
-- compatible: Should be "amlogic,meson8b-reset", "amlogic,meson-gxbb-reset" or
-	"amlogic,meson-axg-reset".
+- compatible: Should be
+ * "amlogic,meson8b-reset" or
+ * "amlogic,meson-gxbb-reset" or
+ * "amlogic,meson-axg-reset" or
+ * "amlogic,meson-g12a-reset"
 - reg: should contain the register address base
 - #reset-cells: 1, see below
 
diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
new file mode 100644
index 000000000000..8063e8314eef
--- /dev/null
+++ b/include/dt-bindings/reset/amlogic,meson-g12a-reset.h
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
+/*
+ * Copyright (c) 2019 BayLibre, SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ */
+
+#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
+#define _DT_BINDINGS_AMLOGIC_MESON_G12A_RESET_H
+
+/*	RESET0					*/
+#define RESET_HIU			0
+/*					1	*/
+#define RESET_DOS			2
+/*					3-4	*/
+#define RESET_VIU			5
+#define RESET_AFIFO			6
+#define RESET_VID_PLL_DIV		7
+/*					8-9	*/
+#define RESET_VENC			10
+#define RESET_ASSIST			11
+#define RESET_PCIE_CTRL_A		12
+#define RESET_VCBUS			13
+#define RESET_PCIE_PHY			14
+#define RESET_PCIE_APB			15
+#define RESET_GIC			16
+#define RESET_CAPB3_DECODE		17
+/*					18	*/
+#define RESET_HDMITX_CAPB3		19
+#define RESET_DVALIN_CAPB3		20
+#define RESET_DOS_CAPB3			21
+/*					22	*/
+#define RESET_CBUS_CAPB3		23
+#define RESET_AHB_CNTL			24
+#define RESET_AHB_DATA			25
+#define RESET_VCBUS_CLK81		26
+/*					27-31	*/
+/*	RESET1					*/
+/*					32	*/
+#define RESET_DEMUX			33
+#define RESET_USB			34
+#define RESET_DDR			35
+/*					36	*/
+#define RESET_BT656			37
+#define RESET_AHB_SRAM			38
+/*					39	*/
+#define RESET_PARSER			40
+/*					41	*/
+#define RESET_ISA			42
+#define RESET_ETHERNET			43
+#define RESET_SD_EMMC_A			44
+#define RESET_SD_EMMC_B			45
+#define RESET_SD_EMMC_C			46
+/*					47-60 */
+#define RESET_AUDIO_CODEC		61
+/*					62-63	*/
+/*	RESET2					*/
+/*					64	*/
+#define RESET_AUDIO			65
+#define RESET_HDMITX_PHY		66
+/*					67	*/
+#define RESET_MIPI_DSI_HOST		68
+#define RESET_ALOCKER			69
+#define RESET_GE2D			70
+#define RESET_PARSER_REG		71
+#define RESET_PARSER_FETCH		72
+#define RESET_CTL			73
+#define RESET_PARSER_TOP		74
+/*					75-77	*/
+#define RESET_DVALIN			78
+#define RESET_HDMITX			79
+/*					80-95	*/
+/*	RESET3					*/
+/*					96-95	*/
+#define RESET_DEMUX_TOP			105
+#define RESET_DEMUX_DES_PL		106
+#define RESET_DEMUX_S2P_0		107
+#define RESET_DEMUX_S2P_1		108
+#define RESET_DEMUX_0			109
+#define RESET_DEMUX_1			110
+#define RESET_DEMUX_2			111
+/*					112-127	*/
+/*	RESET4					*/
+/*					128-129	*/
+#define RESET_MIPI_DSI_PHY		130
+/*					131-132	*/
+#define RESET_RDMA			133
+#define RESET_VENCI			134
+#define RESET_VENCP			135
+/*					136	*/
+#define RESET_VDAC			137
+/*					138-139 */
+#define RESET_VDI6			140
+#define RESET_VENCL			141
+#define RESET_I2C_M1			142
+#define RESET_I2C_M2			143
+/*					144-159	*/
+/*	RESET5					*/
+/*					160-191	*/
+/*	RESET6					*/
+#define RESET_GEN			192
+#define RESET_SPICC0			193
+#define RESET_SC			194
+#define RESET_SANA_3			195
+#define RESET_I2C_M0			196
+#define RESET_TS_PLL			197
+#define RESET_SPICC1			198
+#define RESET_STREAM			199
+#define RESET_TS_CPU			200
+#define RESET_UART0			201
+#define RESET_UART1_2			202
+#define RESET_ASYNC0			203
+#define RESET_ASYNC1			204
+#define RESET_SPIFC0			205
+#define RESET_I2C_M3			206
+/*					207-223	*/
+/*	RESET7					*/
+#define RESET_USB_DDR_0			224
+#define RESET_USB_DDR_1			225
+#define RESET_USB_DDR_2			226
+#define RESET_USB_DDR_3			227
+#define RESET_TS_GPU			228
+#define RESET_DEVICE_MMC_ARB		229
+#define RESET_DVALIN_DMC_PIPL		230
+#define RESET_VID_LOCK			231
+#define RESET_NIC_DMC_PIPL		232
+#define RESET_DMC_VPU_PIPL		233
+#define RESET_GE2D_DMC_PIPL		234
+#define RESET_HCODEC_DMC_PIPL		235
+#define RESET_WAVE420_DMC_PIPL		236
+#define RESET_HEVCF_DMC_PIPL		237
+/*					238-255	*/
+
+#endif
-- 
2.20.1

