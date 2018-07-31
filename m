Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6B1C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AC4820857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 18:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RbXsQyov";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RbXsQyov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AC4820857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731868AbeGaUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:04:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45444 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeGaUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:04:23 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id E2505606AC; Tue, 31 Jul 2018 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533061370;
        bh=kf46LpFwMRS7QqSKB+ttsXGFiA62Tpq5UM1Lmq3As8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbXsQyovB+RNap0ugNT6//WcSy41I0fdjbcoW89gUSTZdFgN/Jnt8sB7HamDZ/ViC
         YgRRZZySZl/rlQkiPagZPDeH4JYbl/S/uircB29S/sR4i0ywRvoPcorujJAlcdG5VL
         HDSBGN4NvGtMttDUwSMY9cFNbz51h3cJCp/idnBI=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 42D64602D7;
        Tue, 31 Jul 2018 18:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1533061370;
        bh=kf46LpFwMRS7QqSKB+ttsXGFiA62Tpq5UM1Lmq3As8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RbXsQyovB+RNap0ugNT6//WcSy41I0fdjbcoW89gUSTZdFgN/Jnt8sB7HamDZ/ViC
         YgRRZZySZl/rlQkiPagZPDeH4JYbl/S/uircB29S/sR4i0ywRvoPcorujJAlcdG5VL
         HDSBGN4NvGtMttDUwSMY9cFNbz51h3cJCp/idnBI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 42D64602D7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: Documentation for qcom,eud
Date:   Tue, 31 Jul 2018 11:22:12 -0700
Message-Id: <1533061333-7680-2-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org>
References: <1533061333-7680-1-git-send-email-pheragu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for Embedded USB Debugger (EUD) device tree bindings.

Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
new file mode 100644
index 0000000..ea63f1c
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
@@ -0,0 +1,28 @@
+* Qualcomm Technologies Inc Embedded USB Debugger (EUD)
+
+The EUD (Embedded USB Debugger) is a mini-USB hub implemented
+on chip to support the USB-based debug and trace capabilities.
+
+Required properties:
+
+ - compatible:  Should be "qcom,msm-eud"
+ - interrupts:  Interrupt number
+ - reg: Should be address and size of EUD register space
+
+Driver notifies clients via extcon for VBUS attach/detach
+and charger enable/disable events. Clients registered for these
+notifications should have extcon property set to eud.
+
+An example for EUD device node:
+
+	eud: qcom,msm-eud@88e0000 {
+		compatible = "qcom,msm-eud";
+		interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x88e0000 0x4000>;
+	};
+
+An example for EUD extcon client:
+
+	usb3 {
+		extcon = <&eud>;
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

