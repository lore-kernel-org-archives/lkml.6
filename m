Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B97C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:22:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC48208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:22:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HVQocukH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FC48208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeGIDWY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:22:24 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46164 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932996AbeGIDWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:22:22 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so810701pgv.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=HVQocukHUClXSNSLDRggehh7ZXaV5tKZvDVso0NG2+//TwzyQ25zBJtb9G1pZ6noaW
         CcsriR4t4VIsbF8tN0z1S7EznEF1KN82eI1wcUhXgm9evKggdK+mrYRqeP6m3W581eRS
         HJzOs6N0YIh/Ujz3PPfVDKKM3G7U/iIF2wQAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=gK3Nxn0/x1KCE4EiIDXTTblZUd2cRvZHPbyGBpP+Ez+lI/HUlz8bn7zrBWGlovhUPZ
         Uaa7Ypwv2L085mjAwSCz/EFlPCf34O2W96mDBTvkwenpm5r3Lo6irgaHQJYXb6LVEFaX
         KPtEURufPiUiKuzl2T2FLbq1IEl9uykayhkyaxhJIy85Jmk4lSkLjcTh0vxiTUdcdphx
         2nWm/T96+sXXcQbtzlzabH3B7FJZdoAk8y+EX46Y8AvzzGfn+/5EAT2m7KEJs3yjPYGl
         rcKkzjbAtX54ujGEGsUGnDw0uhyIDCwVV79so/xKJk5myYfp9iXMARz5GOv/4O+gWqNp
         RuDg==
X-Gm-Message-State: APt69E3p+ifZcaB1aMA6YYgaHxl0GOO1vQMcIa/bF5IK9+GMckIhT9tD
        4icWZAoM3eW27TuB+z/w7eFevQ==
X-Google-Smtp-Source: AAOMgpdBKo3AJI9fieipaoqhpt7v+52Wl6nh2la/LE0PwaXvs/sStzEz5Lvi+f0RjUP5dmaT1wbuvg==
X-Received: by 2002:a63:6004:: with SMTP id u4-v6mr17248394pgb.441.1531106541708;
        Sun, 08 Jul 2018 20:22:21 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.22.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:22:20 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 7/7] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Mon,  9 Jul 2018 11:19:58 +0800
Message-Id: <1531106398-14062-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

This patch adds the device-tree binding documentation for Spreadtrum
SDHCI driver.

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 .../devicetree/bindings/mmc/sdhci-sprd.txt         | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
new file mode 100644
index 0000000..45c9978
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
@@ -0,0 +1,41 @@
+* Spreadtrum SDHCI controller (sdhci-sprd)
+
+The Secure Digital (SD) Host controller on Spreadtrum SoCs provides an interface
+for MMC, SD and SDIO types of cards.
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-sprd driver.
+
+Required properties:
+- compatible: Should contain "sprd,sdhci-r11".
+- reg: physical base address of the controller and length.
+- interrupts: Interrupts used by the SDHCI controller.
+- clocks: Should contain phandle for the clock feeding the SDHCI controller
+- clock-names: Should contain the following:
+	"sdio" - SDIO source clock (required)
+	"enable" - gate clock which used for enabling/disabling the device (required)
+
+Optional properties:
+- assigned-clocks: the same with "sdio" clock
+- assigned-clock-parents: the default parent of "sdio" clock
+
+Examples:
+
+sdio0: sdio@20600000 {
+	compatible  = "sprd,sdhci-r11";
+	reg = <0 0x20600000 0 0x1000>;
+	interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+
+	clock-names = "sdio", "enable";
+	clocks = <&ap_clk CLK_EMMC_2X>,
+		 <&apahb_gate CLK_EMMC_EB>;
+	assigned-clocks = <&ap_clk CLK_EMMC_2X>;
+	assigned-clock-parents = <&rpll CLK_RPLL_390M>;
+
+	bus-width = <8>;
+	non-removable;
+	no-sdio;
+	no-sd;
+	cap-mmc-hw-reset;
+	status = "okay";
+};
-- 
2.7.4

