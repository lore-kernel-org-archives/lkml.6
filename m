Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E678C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7EF20700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cQiU4jdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbfBTKek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:34:40 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42344 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTKei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:34:38 -0500
Received: by mail-pf1-f195.google.com with SMTP id n74so11709262pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lgoiu2t/jzkJA5/PieX0YxtG8m8fWvSawqBQFKAyYB0=;
        b=cQiU4jdGHl29UfTjZRMio3i5b5uxtr+1x2r63wgOlsDEGWBUUOQRl8JpN4TYc3/LcN
         AIkJV+vagv9dxDUElb8TdPnHi+0V5jr0gBHeu4vjSWAb9QxvIcuOXyfYWPBt/wdBQUhq
         CY3U5/mcVj+wvkFwQtOgnRHQMyxbDz7DtRU5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lgoiu2t/jzkJA5/PieX0YxtG8m8fWvSawqBQFKAyYB0=;
        b=Q7LZodyAXYUOAvx3KbHCLtzsCGWPwc9OFrjpBIQ5Cqk4qtNOVxZdrw3/+2mJL7G+41
         B/SvdL3cbSaF4OwUp4zCWpe/84TzNRcKA4p+izmKJ2OITc6xFdhFzSZPnJfXYY7vB3iR
         BjTu60RsGVU7iiJMGNbmsuq1oY/p45VrCSYrAnBvTWg58HMzVPAyp7LMx7ZWMl1yyylb
         6XL6IJTFOR+qGn+kDNC/YC0ekgKqGQ7lqh0HlBOoPYje56BQFXuoVi+5tgYDeemtU0Yn
         a4QhwmPxBR7GVxbQBsx1ZtDpZtg9ulNI+oln2uHLTAh3kG9p8eZSuxYbToTvJBezL3Ox
         WyJw==
X-Gm-Message-State: AHQUAuYXhltO5/gijWnSu/luR7jP2zqXkJZCmlC5ODhXYBvjNGBJazWy
        5GV53sKPFn08fcMJk0L80i/DPg==
X-Google-Smtp-Source: AHgI3IbzjzS1JajSSk6mGcbU6F51YLwnaQhjUZpG7gFX50HLjW1K28stvvCmDQnyJkTegO6sb1JkKw==
X-Received: by 2002:a63:be4d:: with SMTP id g13mr28652836pgo.378.1550658877895;
        Wed, 20 Feb 2019 02:34:37 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id i71sm57426796pfi.170.2019.02.20.02.34.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Feb 2019 02:34:37 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v4 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
Date:   Wed, 20 Feb 2019 16:04:00 +0530
Message-Id: <1550658842-19167-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
References: <1550658842-19167-1-git-send-email-srinath.mannam@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT binding document for Stingray USB PHY.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
---
 .../bindings/phy/brcm,stingray-usb-phy.txt         | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt

diff --git a/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
new file mode 100644
index 0000000..da19236
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
@@ -0,0 +1,62 @@
+Broadcom Stingray USB PHY
+
+Required properties:
+ - compatible : should be one of the listed compatibles
+	- "brcm,sr-usb-combo-phy" is a combo PHY has one SS PHY and one HS PHY.
+	- "brcm,sr-usb-hs-phy" has a single HS PHY.
+ - reg: offset and length of the PHY blocks registers
+ - address-cells: should be 1
+ - size-cells: should be 0
+
+Sub-nodes:
+  brcm,sr-usb-combo-phy have two sub-nodes for one SS PHY and one HS PHY.
+
+Sub-nodes required properties:
+ - reg: required for brcm,sr-usb-phy model PHY.
+	reg value 0 is HS PHY and 1 is SS PHY.
+ - phy-cells: generic PHY binding; must be 0
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usbphy0: usb-phy@0 {
+		compatible = "brcm,sr-usb-combo-phy";
+		reg = <0x00000000 0x100>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb0_phy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		usb0_phy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
+
+	usbphy1: usb-phy@10000 {
+		compatible = "brcm,sr-usb-combo-phy";
+		reg = <0x00010000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		usb1_phy0: phy@0 {
+			reg = <0>;
+			#phy-cells = <0>;
+		};
+
+		usb1_phy1: phy@1 {
+			reg = <1>;
+			#phy-cells = <0>;
+		};
+	};
+
+	usbphy2: usb-phy@20000 {
+		compatible = "brcm,sr-usb-hs-phy";
+		reg = <0x00020000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <0>;
+	};
-- 
2.7.4

