Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id fL8eGGQ4GVvaegAAmS7hNA
	; Thu, 07 Jun 2018 13:51:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 734A1607DC; Thu,  7 Jun 2018 13:51:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bMB9ImVt"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB87F601D2;
	Thu,  7 Jun 2018 13:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB87F601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932783AbeFGNvo (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 09:51:44 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46899 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932152AbeFGNvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 09:51:42 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so4949468pff.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 06:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dgUgUhzX89BwZOr9iAeWJ8NNdhzvOfoC3eGWVhZrlIc=;
        b=bMB9ImVt3SKX9T2hf+IkBov1Q2J8orxgtoak3+YP2HiAKBJaBXOljiz5v81xhgJzui
         SZnyDbzPatTz545M4lh9ATRBa9ravkv6FtlsZ+hFhBLfej6i0CL4qEXpImoKL7tluBdy
         OdCPlnJN4e3XWtem1zel606Wq9FN/AH0xqXyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dgUgUhzX89BwZOr9iAeWJ8NNdhzvOfoC3eGWVhZrlIc=;
        b=eIPboKIWN81D5ePJRPVBLkDTXQz9rIqUcxiJeb8NDxNVJMA1LgLSw6ogB9JhBvFrIa
         jo22SaDNH7cLxKHP3svlUfWhejxHuIj4CBsNAZoyaEWc0rEDA/YGO1ZoxzfaBPz2ibZe
         GOLB2Vs+P+YlunL4XRiulVXPRVJdID2mFRKKKMJmsNb3ApqCrsLvhaKrCWjzlTOE3po6
         EEZzpGDEk2T2XyIxQVl4NpY3JZSJbQYkqV69Kowyj65b2oXplJfS8DZ5BdFvaQd82PNe
         ETpujhWQMAGHwvKFou1agSWmHY5zirU3IzQGRhuGX67WwkqAua2UexpYHlamYkGrPBkR
         UsKA==
X-Gm-Message-State: APt69E0NbuNfPchF4UiUOJKOMZ+JYm+iGJ/fdDdFjQYcaaAOx126pdkP
        KrxxxixEIEJVFb3kRC7KlZjiMA==
X-Google-Smtp-Source: ADUXVKJ+lTzSva1ovJjARRh/YElCtQJsiB97ApnamovGQEOj1I/zg+vQyTaEh3ECBPGU8QgiXJh+1g==
X-Received: by 2002:a63:3201:: with SMTP id y1-v6mr1709887pgy.419.1528379501489;
        Thu, 07 Jun 2018 06:51:41 -0700 (PDT)
Received: from localhost.localdomain ([115.97.190.51])
        by smtp.gmail.com with ESMTPSA id b3-v6sm56455901pgn.44.2018.06.07.06.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 06:51:40 -0700 (PDT)
From: Jagan Teki <jagan@amarulasolutions.com>
To: Shawn Guo <shawnguo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Jagan Teki <jagan@amarulasolutions.com>
Subject: [PATCH 1/3] ARM: dts: imx6dl: Add Engicam i.CoreM6 1.5 Quad/Dual MIPI starter kit support
Date: Thu,  7 Jun 2018 19:21:31 +0530
Message-Id: <20180607135133.3104-1-jagan@amarulasolutions.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.CoreM6 1.5 is an another i.CoreM6 QDL cpu modules which can be connected
to EDIMM starter kit design with eMMC and MIPI-CSI interfaces suitable for
Android and video capture application.

notable features:
CPU                 NXP i.MX6 S/DL/D/Q, Up to 4 x Cortex-A9@800MHz
Memory              Up to 2 GB DDR3-1066
Video Interfaces    Up to 1 Parallel Up to 2 LVDS HDMI 1.4
                    port 8 bit CSI INPUT MIPI-CSI INPUT
1 x 10/100 Ethernet interface, 2 x USB, 1 x PCIe, 1 x I2S etc

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm/boot/dts/Makefile              |  1 +
 arch/arm/boot/dts/imx6dl-icore-mipi.dts | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6dl-icore-mipi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37a3de760d40..2dead792ba9d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -400,6 +400,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
 	imx6dl-hummingboard2-emmc-som-v15.dtb \
 	imx6dl-hummingboard2-som-v15.dtb \
 	imx6dl-icore.dtb \
+	imx6dl-icore-mipi.dtb \
 	imx6dl-icore-rqs.dtb \
 	imx6dl-mamoj.dtb \
 	imx6dl-nit6xlite.dtb \
diff --git a/arch/arm/boot/dts/imx6dl-icore-mipi.dts b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
new file mode 100644
index 000000000000..bf53f0552aa1
--- /dev/null
+++ b/arch/arm/boot/dts/imx6dl-icore-mipi.dts
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (C) 2018 Engicam S.r.l.
+ * Copyright (C) 2018 Amarula Solutions B.V.
+ * Author: Jagan Teki <jagan@amarulasolutions.com>
+ */
+
+/dts-v1/;
+
+#include "imx6dl.dtsi"
+#include "imx6qdl-icore.dtsi"
+
+/ {
+	model = "Engicam i.CoreM6 DualLite/Solo MIPI Starter Kit";
+	compatible = "engicam,imx6-icore", "fsl,imx6dl";
+};
+
+&hdmi {
+	ddc-i2c-bus = <&i2c2>;
+	status = "okay";
+};
+
+&usdhc3 {
+	status = "okay";
+};
-- 
2.14.3
