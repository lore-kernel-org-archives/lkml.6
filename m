Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53BB4C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 083CC20671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 10:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HSoAhcds"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 083CC20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbeGSLht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 07:37:49 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43471 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeGSLhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 07:37:48 -0400
Received: by mail-pf0-f196.google.com with SMTP id j26-v6so3738085pfi.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 03:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zD+732wJGoyhaZG9GQ1m66dYgDFzqDgbF+9C92Le6nc=;
        b=HSoAhcdsQ/3mEwI0FYFs9T6p4Aai0YxHEX/PWWvX43Ax3vf+Gln9+rGdmsAyAq68Vm
         Q7LiDmpYn31GXzmCb+aH8O7eKzUFMFllUGVQJcwFpBSmnNgU8XyVeF4Rr7f/WdUhUxH6
         jfEBv3pC+NpF0HuwgQwyheBcSmHCpcOKzNXCU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zD+732wJGoyhaZG9GQ1m66dYgDFzqDgbF+9C92Le6nc=;
        b=t7AZJo78pzPQNqLuuO5I7S9Q/GR3SxkPftXJxuOaAWz7znMERi+YGM2DL/zjxPSli5
         an6fq5NPJuufiuzx8zlRd6+97e/73+sO/7i6401BF3tfS0QsK++L9ysnxH+njH1EfVwC
         ouYvFyXTSMsI0D5sbITgaa5ptsXfVR8JQJLBTkHdRsOfN68RzIOvfu8diSeDuEO1I3l+
         Zoec5mK4Co54vWHQ2stF0hNI90eWQkwsRXJ7Dqy7c9mLWVcJyUAu/GZz+d7Y0ZHVkAhR
         fAo7tqklDH5SyPy4vSbvDD4jKjCbEqfaw/mKXlBVzAeVTuNL8eG5oAvwE1AqFXlWCEfA
         SmKg==
X-Gm-Message-State: AOUpUlF4hfZI7XrGVKNyFlxcbbyHyLpddV5iYH0HLB/nlIf6u1bCe8tC
        MV8/BCpd43YgHj9nL3BFuezC
X-Google-Smtp-Source: AAOMgpcUh6t2cgCdft8fhk5AXBPcv9iC5xvIsinpWtZfCiWHsD2qMNKOvxGRGU4UqxImduLmkfHuyg==
X-Received: by 2002:a63:7b4d:: with SMTP id k13-v6mr9477266pgn.64.1531997712185;
        Thu, 19 Jul 2018 03:55:12 -0700 (PDT)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.googlemail.com with ESMTPSA id 85-v6sm3653262pgd.81.2018.07.19.03.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 03:55:11 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     matthias.bgg@gmail.com, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, taiten.peng@linaro.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 2/2] arm64: dts: Add Mediatek X20 Development Board support
Date:   Thu, 19 Jul 2018 16:24:50 +0530
Message-Id: <1531997690-6040-3-git-send-email-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1531997690-6040-1-git-send-email-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial device tree support for Mediatek X20 Development Board
based on MT6797 Deca core SoC. This board is one of the 96Boards
Consumer Edition platform.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/mediatek/Makefile           |  1 +
 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts | 33 +++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts

diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dts/mediatek/Makefile
index ac17f60..5b7fd6a 100644
--- a/arch/arm64/boot/dts/mediatek/Makefile
+++ b/arch/arm64/boot/dts/mediatek/Makefile
@@ -3,5 +3,6 @@ dtb-$(CONFIG_ARCH_MEDIATEK) += mt2712-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6755-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6795-evb.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-evb.dtb
+dtb-$(CONFIG_ARCH_MEDIATEK) += mt6797-x20-dev.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt7622-rfb1.dtb
 dtb-$(CONFIG_ARCH_MEDIATEK) += mt8173-evb.dtb
diff --git a/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
new file mode 100644
index 0000000..742938a
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6797-x20-dev.dts
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device Tree Source for MediaTek X20 Development Board
+ *
+ * Copyright (C) 2018, Linaro Ltd.
+ *
+ */
+
+/dts-v1/;
+
+#include "mt6797.dtsi"
+
+/ {
+	model = "Mediatek X20 Development Board";
+	compatible = "archermind,mt6797-x20-dev", "mediatek,mt6797";
+
+	aliases {
+		serial0 = &uart1;
+	};
+
+	memory@40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x80000000>;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&uart1 {
+	status = "okay";
+};
-- 
2.7.4

