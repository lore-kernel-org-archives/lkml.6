Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88120C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAD220C0E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 00:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mb1K/d+F";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Mb1K/d+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAD220C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbeHQDHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 23:07:25 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34942 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbeHQDHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 23:07:24 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AC1F761EB8; Fri, 17 Aug 2018 00:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534464377;
        bh=3EHbnm0EUfbzNzWmA7usrHpl+MlWqRRpA1waVcLexQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mb1K/d+Fd2K7endEtA1BKMsgFL1j1clZqGS+y59W/2Nqt9B9FgjCoatS0kpwlk5DI
         2+tkyAXgm+FPST8iUSbE6TyetpoA/jZW3hoqESPFoh8NW4A1gqA2CZXSpe70NRsvZY
         zI/DDz3OrQEzY3D9ctXQpcBbYLwrUcQSoCLO1LNk=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE76E61EB2;
        Fri, 17 Aug 2018 00:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1534464377;
        bh=3EHbnm0EUfbzNzWmA7usrHpl+MlWqRRpA1waVcLexQk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mb1K/d+Fd2K7endEtA1BKMsgFL1j1clZqGS+y59W/2Nqt9B9FgjCoatS0kpwlk5DI
         2+tkyAXgm+FPST8iUSbE6TyetpoA/jZW3hoqESPFoh8NW4A1gqA2CZXSpe70NRsvZY
         zI/DDz3OrQEzY3D9ctXQpcBbYLwrUcQSoCLO1LNk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE76E61EB2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org, rnayak@codeaurora.org,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>
Subject: [PATCH v1 1/2] dt-bindings: Documentation for qcom,eud
Date:   Thu, 16 Aug 2018 17:05:47 -0700
Message-Id: <1534464348-8227-2-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
References: <1534464348-8227-1-git-send-email-pheragu@codeaurora.org>
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

