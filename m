Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B36AECDE30
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FF2521527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 15:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="nOAcawzP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JzOB1on/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF2521527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbeJQXOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 19:14:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45514 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbeJQXOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 19:14:53 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 18CAE61400; Wed, 17 Oct 2018 15:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539789522;
        bh=Ge/ix3rPwp7OV6G7lRxhwn7ZtlGb1juzK85QIoaK0Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOAcawzPsqfsDA0R7NzdQS1HXMXMHOqT2pc3ZMEGfpOueQnpTjkmQAN5sy5QrameZ
         z7gj/LGuQLICVt9PGANC501BWlHtzyGMb/cCvjfjPCk0qWQjqC9VJfFesS9gt+2pEh
         gX6IMy8sLnH3de/MzkAaPsuPf2kB2ygovJQJW9b8=
Received: from hydsecbld01.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: anilc@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B539A61306;
        Wed, 17 Oct 2018 15:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1539789519;
        bh=Ge/ix3rPwp7OV6G7lRxhwn7ZtlGb1juzK85QIoaK0Y4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzOB1on/xj9FwHbNQuP6cDx/HCgzW+5ea0ayWNIEZb3cwYlUsSbLJhlJW4f2TIti+
         CKswmwUTeKyrjgp3WVN3NqUFF3/JeErfmsBeERjPBtYQznBKHwVM2IsA+fDlVVak25
         eE7LgM15RPlIASt1gUquLMTEBPGo0lfMA1spe9T0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B539A61306
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=anilc@codeaurora.org
From:   AnilKumar Chimata <anilc@codeaurora.org>
To:     andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        AnilKumar Chimata <anilc@codeaurora.org>
Subject: [PATCH 2/3] dt-bindings: Add ICE device specific parameters
Date:   Wed, 17 Oct 2018 20:47:55 +0530
Message-Id: <1539789476-6098-3-git-send-email-anilc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
References: <1539789476-6098-1-git-send-email-anilc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt parameters information specific to the Inline
Crypto Engine (ICE) device.

Signed-off-by: AnilKumar Chimata <anilc@codeaurora.org>
---
 .../devicetree/bindings/crypto/msm/ice.txt         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/msm/ice.txt

diff --git a/Documentation/devicetree/bindings/crypto/msm/ice.txt b/Documentation/devicetree/bindings/crypto/msm/ice.txt
new file mode 100644
index 0000000..86eed5e
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/msm/ice.txt
@@ -0,0 +1,34 @@
+* Inline Crypto Engine (ICE)
+
+Required properties:
+  - compatible			: should be "qcom,ice"
+  - reg 			: <register mapping>
+
+Optional properties:
+  - interrupt-names     	: name describing the interrupts for ICE IRQ
+  - interrupts          	: <interrupt mapping for ICE IRQ>
+  - qcom,enable-ice-clk 	: should enable clocks for ICE HW
+  - clocks              	: List of phandle and clock specifier pairs
+  - clock-names         	: List of clock input name strings sorted in the same
+				  order as the clocks property.
+  - qcom,op-freq-hz     	: max clock speed sorted in the same order as the clocks
+				  property.
+  - qcom,instance-type  	: describe the storage type for which ICE node is defined
+				  currently, only "ufs" and "sdcc" are supported storage type
+  - power-domains		: regulator supply to be used by ICE HW
+
+Example:
+	ufs_ice: ufsice@1d90000 {
+		compatible = "qcom,ice";
+		reg = <0x1d90000 0x8000>;
+		qcom,enable-ice-clk;
+		clock-names = "ufs_core_clk", "bus_clk",
+				"iface_clk", "ice_core_clk";
+		clocks = <&gcc GCC_UFS_PHY_AXI_CLK>,
+			 <&gcc GCC_UFS_MEM_CLKREF_CLK>,
+			 <&gcc GCC_UFS_PHY_AHB_CLK>,
+			 <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
+		qcom,op-freq-hz = <0>, <0>, <0>, <300000000>;
+		power-domains = <&gcc UFS_PHY_GDSC>;
+		qcom,instance-type = "ufs";
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

