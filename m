Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77292C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AC0214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TNUY490V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30AC0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389712AbeHPKwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37927 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389699AbeHPKwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id u11-v6so1700148plq.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=TNUY490V5PaPYtEl4kRP+eAAGofj223txKV/xltMRjW9UAIF0Gjyt7nVgWjdZID9hC
         yw6eBWwK8OLJhR0GxzAiuL+DVBApl3Xg9DEYJl/qQp3waWKcfy3x5YZVNx5n1lP1yBXN
         b3yEThJhvCcBrNh8rYxmV4iVCoT5i0Y/BShvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMrql5pChvk0l0OVuaoPU9zdtIybInbwoq7vsafDp1A=;
        b=YGNQbR66xnYpc3aPbL2kg7V514Ccw9/FzmwnCv+jN5A12xCth8J2/md9iuBBiImrsm
         WKtR2+yux1G/WeW5MzJNbKv8uH3reNFmwF3AKjtW7DIaMHIwiCNb8qVCp4eeByFSzJmp
         ZiaRKHBHN2e+o97NPqykgyglVZdVYfBp/b1zyQa/T79gpNbiRisVY++Txd9VxQp2rT7W
         PAygmXwSDylcRPQeTGjrCa5ogj7h1bXchFW6lmRRPSLrYUJTxM4DQcQaZPyc+0pwWYU6
         bOEcIVE1BFMtjq5jMpnhVUL2KJ0bOsJY548IIL5jEf4H0CRBKl3966YBAHKYOXPYl/x4
         LC0w==
X-Gm-Message-State: AOUpUlHQsES5ofZuU4o4aLsjr5iIPUI426eM40goeA2xVFw1J+zGtguw
        ypJiBR+NixdJ0JxpV2GJ3VWicg==
X-Google-Smtp-Source: AA+uWPxcIK8e/9mdlU2/2/lZHOtX5G0V4N8dBfiEmc9LrUAImsLWFv6J+kaKwp2z1xN2yuAcZGszVQ==
X-Received: by 2002:a17:902:1101:: with SMTP id d1-v6mr27431120pla.131.1534406160234;
        Thu, 16 Aug 2018 00:56:00 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:59 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 10/10] dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller
Date:   Thu, 16 Aug 2018 15:54:24 +0800
Message-Id: <1534406064-10065-11-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
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

