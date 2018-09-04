Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD81C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 366722075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="OQIcBIdh";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="e2gQaGhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 366722075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbeIECCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 22:02:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35244 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbeIECCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 22:02:43 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 011E0607DD; Tue,  4 Sep 2018 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536096944;
        bh=3EHbnm0EUfbzNzWmA7usrHpl+MlWqRRpA1waVcLexQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQIcBIdhqG2O/ljBtV95eVtJxAQ6zjyKOD45UYrjhQtxuVdM8UIr2R4d5WGYmpj0r
         7FJzwaDX6/Y/L8kQeDaOYGRx3dSMfnwsgyXkdyG8fgiVq+UMdVx6Ks672m0wu4V9mU
         2d8onYBkOWqzQck9rNEvtdwNOJ1aYXgaj9flShV4=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 415C96063A;
        Tue,  4 Sep 2018 21:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536096943;
        bh=3EHbnm0EUfbzNzWmA7usrHpl+MlWqRRpA1waVcLexQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e2gQaGhcbjs+jSX6maJUpoC8si+r8Tti7eMKuNnNr6fYvSozUtnq34BBnb6cf+of/
         5IuqG/TDXrsO3DEzSwRPB2Al7Yb95wPghrUIPsq56UU9P4pTREYCrfBWBviA/e5c/s
         jByRrk8jPcjI+gVQdiOKb4XpgobDb40QACu4+yoI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 415C96063A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, rnayak@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: [PATCH v2 1/2] dt-bindings: Documentation for qcom,eud
Date:   Tue,  4 Sep 2018 14:34:12 -0700
Message-Id: <1536096853-30473-2-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
References: <1536096853-30473-1-git-send-email-pheragu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for Embedded USB Debugger (EUD) device tree bindings.

Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
new file mode 100644
index 0000000..a03021a
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
@@ -0,0 +1,41 @@
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
+Driver notifies clients for VBUS attach/detach and charger enable/disable
+events. The link between client and EUD is established via a directed
+graph. EUD driver has one endpoint of the graph link mentioning EUD as an
+output link and clients registered for these notifications from the EUD
+should have the other endpoint of the graph link as an input link. Each of
+these endpoints should contain a 'remote-endpoint' phandle property that
+points to the corresponding endpoint in the port of the remote device.
+
+An example for EUD device node:
+
+	eud: qcom,msm-eud@88e0000 {
+		compatible = "qcom,msm-eud";
+		interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x88e0000 0x4000>;
+		port {
+                	eud_output: endpoint {
+                        	remote-endpoint = <&usb3_input>;
+                        };
+        	};
+	};
+
+An example for EUD client:
+
+	usb3 {
+		port {
+                	usb3_input: endpoint {
+                        	remote-endpoint = <&eud_output>;
+                        };
+        	};
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

