Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC59ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:51:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA50320817
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 17:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLuUYF/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA50320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbeKID2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 22:28:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbeKID2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 22:28:21 -0500
Received: from localhost.localdomain (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4C220817;
        Thu,  8 Nov 2018 17:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541699505;
        bh=GMg1XEoOp0IvjcuhyeNGWYKWecigbIiHWp3bML/11Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TLuUYF/rTIGT27uaRBe4Q2BVlI1K3w25Ojhx2zwP88fjKyfWE00EOd7V9hYCCxCa1
         z7pLRbxLnI7/4qnaHy3plT0h3ZKEtZ64NYMjgJpoXmJsjmFB898TVJCxQKOC3iD3cR
         LmkqQ9KlSvDyupK+1BuJeWOq2wYeLc/4EEWu3KD4=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v3 02/18] arm64: dts: qcom: qcs404-evb: add dts files for EVBs
Date:   Thu,  8 Nov 2018 23:20:33 +0530
Message-Id: <20181108175049.7090-3-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181108175049.7090-1-vkoul@kernel.org>
References: <20181108175049.7090-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QCS404 has two EVBs, EVB-1000 and EVB-4000. These boards are mostly
similar with few differences in the peripherals used.

So use a common qcs404-evb.dtsi which contains the common parts and use
qcs404-evb-1000.dts and qcs404-evb-4000.dts for diffs

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/Makefile            |  2 ++
 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts | 11 +++++++++++
 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts | 11 +++++++++++
 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi     | 14 ++++++++++++++
 4 files changed, 38 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
 create mode 100644 arch/arm64/boot/dts/qcom/qcs404-evb.dtsi

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index a658c07652a7..21d548f02d39 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -8,3 +8,5 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8994-angler-rev-101.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8996-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-mtp.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm845-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
new file mode 100644
index 000000000000..2c14903d808e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-1000.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+/dts-v1/;
+
+#include "qcs404-evb.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
+	compatible = "qcom,qcs404-evb";
+};
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
new file mode 100644
index 000000000000..11269ad3de0d
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb-4000.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+/dts-v1/;
+
+#include "qcs404-evb.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. QCS404 EVB 4000";
+	compatible = "qcom,qcs404-evb";
+};
diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
new file mode 100644
index 000000000000..91ecbdf0ecda
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include "qcs404.dtsi"
+
+/ {
+	aliases {
+		serial0 = &blsp1_uart2;
+	};
+
+	chosen {
+		stdout-path = "serial0";
+	};
+};
-- 
2.14.4

