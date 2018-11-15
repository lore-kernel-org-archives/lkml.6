Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E297DC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A710C2086C
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 19:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Eb5ICQVw";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mKZAFlnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A710C2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388836AbeKPFmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 00:42:52 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:51872 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725742AbeKPFmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 00:42:52 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 25CAA6074C; Thu, 15 Nov 2018 19:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542310424;
        bh=bd3aDWywSJVMEIzz/0/t5upE2edTTMdONVG+x7tf1ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb5ICQVwsvOBIFF7bLMf13aRIa+1h8coBUQTWjfkBZtuWl45uqiJgKkvzPKJb9s50
         n+xBEl/NZMXa2VAd4hq19PYmcsIJXZKTGJNCwtHXRVGyw57YM09+AC3V66hyNXmwk0
         HX2W4ErIrOkAPFtDvzh988vrQvqchsjK0X6vXs68=
Received: from pheragu-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pheragu@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D3536020B;
        Thu, 15 Nov 2018 19:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1542310423;
        bh=bd3aDWywSJVMEIzz/0/t5upE2edTTMdONVG+x7tf1ds=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mKZAFlnpZdWVXxiF0BpG38pBgULhPrkSOfTjzljfWlsxTMP2rJ4XefEW9Ku12xbbH
         PscaHLBB0NGJIGXdyd0OTBK58jb23/ZD+HNWrfBIqiUPZOYo3q26FLurREFyCx/hh5
         7V1mUmxKQh9WLrfeZOjpU0qySBr97h96VQqdMkCY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5D3536020B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=pheragu@codeaurora.org
From:   Prakruthi Deepak Heragu <pheragu@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org,
        psodagud@codeaurora.org, rnayak@codeaurora.org,
        Prakruthi Deepak Heragu <pheragu@codeaurora.org>,
        Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Subject: [PATCH v3 1/2] dt-bindings: Documentation for qcom,eud
Date:   Thu, 15 Nov 2018 11:32:53 -0800
Message-Id: <1542310374-18474-2-git-send-email-pheragu@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
References: <1542310374-18474-1-git-send-email-pheragu@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation for Embedded USB Debugger (EUD) device tree bindings.

Signed-off-by: Satya Durga Srinivasu Prabhala <satyap@codeaurora.org>
Signed-off-by: Prakruthi Deepak Heragu <pheragu@codeaurora.org>
---
 .../devicetree/bindings/soc/qcom/qcom,msm-eud.txt  | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
new file mode 100644
index 0000000..6d339e7
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,msm-eud.txt
@@ -0,0 +1,43 @@
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
+EUD notifies clients for VBUS attach/detach and charger enable/disable
+events. The link between client and EUD is established via a directed
+graph. EUD has one endpoint of the graph link mentioning EUD as an
+output link and clients of EUD should have the other endpoint of the
+graph link as an input link.
+
+An example for EUD device node:
+
+	eud: qcom,msm-eud@88e0000 {
+		compatible = "qcom,msm-eud";
+		interrupts = <GIC_SPI 492 IRQ_TYPE_LEVEL_HIGH>;
+		reg = <0x88e0000 0x4000>;
+		usb_con: connector {
+                compatible = "usb-c-connector";
+                label = "USB-C";
+                port {
+                	    eud_usb_output: endpoint {
+                        	    remote-endpoint = <&eud_usb3_input>;
+                        };
+        	    };
+        };
+	};
+
+An example for EUD client:
+
+	usb3 {
+		port {
+                eud_usb3_input: endpoint {
+                        remote-endpoint = <&eud_usb_output>;
+                };
+        };
+	};
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

