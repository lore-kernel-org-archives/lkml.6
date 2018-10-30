Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C659C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D9020831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 10:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu6E+PjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D9020831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbeJ3TEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 15:04:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:43010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbeJ3TEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 15:04:43 -0400
Received: from localhost.localdomain (unknown [171.61.91.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF57F20848;
        Tue, 30 Oct 2018 10:11:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540894314;
        bh=ksgJod3Y6Uh4QPsHmGBFOp6UvYTyuRIF1LvDd9CO43o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lu6E+PjDy8KS4osbBpHq7TdjAw8U2Liy6pZBE0VWx+25rD8dydTrf+z5SIIcJiqZs
         YHodIZYfCMVlev6UKCj1OzW29CSmAJ1tTmGSkVXECRPVNsq5xgF+Wdrca+EAUUJpdl
         LWgbYAoYnGs20s2BH7d0fnWm/Q+xeEp4KdBqlyC8=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 08/17] arm64: dts: qcom: pms405: add spmi node
Date:   Tue, 30 Oct 2018 15:40:59 +0530
Message-Id: <20181030101108.11041-9-vkoul@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181030101108.11041-1-vkoul@kernel.org>
References: <20181030101108.11041-1-vkoul@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pms405 DT file with spmi node.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/pms405.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pms405.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
new file mode 100644
index 000000000000..8a585180f102
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2018, Linaro Limited
+
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	pms405_0: pms405@0 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+	};
+};
-- 
2.14.4

