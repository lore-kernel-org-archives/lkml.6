Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FE6C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C35E621872
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 12:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Y4Jt/4xM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730256AbfBAMuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 07:50:12 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34717 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfBAMuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 07:50:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so4478313wmd.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yI5dyFXD0eCpqICzl94AW1c+UhnXLPpf4lVwvl+KCoM=;
        b=Y4Jt/4xMCEgiOTu0QPE/DzgKbL1z6clS0ZyJp2ss28pRxNNk8n/gvQxw9aezLog4Im
         MCD6T0mleFBR6kE8SS7sKd75uy7R+O4VzYqrGPcBMXrgX/kwqd/lQDLoJtGpy7NZ/C5v
         QzCRY8mAxq3vnjeE/8Hn/VixXd5dj7LKoAVz6wV9zB+pmyPV0WhJPMvyyvdlK8m4FdDh
         VhMddhv0WvdddG8aBgzVfVP9D3hsdCFyjlRW6Os+IBdJjJfQu1Uj0VY2jKJmucAy0bff
         QFBNK23SMOdAaXINh2qyO0CENUH/fbWnqY1y4MemREIropXR5JJPcz4wbJMLxamrYkjl
         Ux8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yI5dyFXD0eCpqICzl94AW1c+UhnXLPpf4lVwvl+KCoM=;
        b=uAL36O/bN3sP4PwfdYhdV/9Fi953Gj8YQcYElqbf/5mPuV+ja68SCQE9S+vAmREiFO
         9n7jQRwDUTtMcERPYYU/jpT4xRZuy2OVghSPG1T40SyST3OfCkpJbHuD0+iyRaTRrVNM
         PZD3LDZpoCLOgfQxY5UiD7cR2RdQhK74bj84c2nQr1+AfODm+7cqRDE1K7ANM3gwFk8L
         hF2kJIpAWW6/6vGy3VIdXO3YPHcd3TJB/7hoPIyEad/FXteNH5MWf30VUEaHWFu3yraR
         XBokBKWxOqhd0RMX7ECK0sqcvxQKi89V/3FTzz+iLTs0Qg48HoWrgqprP0nOsDS0ZKZL
         Pc0A==
X-Gm-Message-State: AHQUAuYHkdpLXqAgUpNMAtG5gAXMSQmOmEJ6DkfAlmIxWOeLvZS4Z9OU
        eYExBitusFkLla0B4y535CIgWw==
X-Google-Smtp-Source: AHgI3Iagcxe5g+mTm+PlYI+lapgobHLUmmz5WFNAIkFaWEE4g5QJgWZZLBmL7mXUlnjN1TJFipaTGg==
X-Received: by 2002:a1c:b455:: with SMTP id d82mr2425856wmf.78.1549025409830;
        Fri, 01 Feb 2019 04:50:09 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id w10sm4115884wmb.1.2019.02.01.04.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 04:50:09 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3] dt-bindings: reset: meson: add g12a bindings
Date:   Fri,  1 Feb 2019 13:50:03 +0100
Message-Id: <20190201125003.25022-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.20.1
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

Changes since v2 [0]:
* Dropped useless g12a compatible

[0]: https://lkml.kernel.org/r/20190128181316.30814-1-jbrunet@baylibre.com

 .../reset/amlogic,meson-g12a-reset.h          | 134 ++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-reset.h

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

