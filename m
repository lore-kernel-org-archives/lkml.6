Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF1C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD9612186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Ba9DGJrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfBFRdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:33:22 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35369 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfBFRdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:33:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id s198so3205248pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkcE4sKmTKPifhk6h7j1EEIJitiKEOOaAtV2z40Cqyg=;
        b=Ba9DGJrTWLtntMKhq3b37Uz0Sgn2gRhL+oAr2BsD4asfu7tDYxlyN0QCsjEXBXyj2U
         Q2MFY6cxeFhPs0xCQLMwzDHU9b/uI+mPbnIs3dLh3VzfLwXyb5N46LQHXqLeDiyDcvcy
         lXMAnoPGwrMj7/cv9Fd81fGuDX53Oe5Sl0KTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkcE4sKmTKPifhk6h7j1EEIJitiKEOOaAtV2z40Cqyg=;
        b=NikFpA4ww0Xdlk7cye5c8AF1WYeIf8I4Yt/Q/2T/ZfJhDmmjLilbU009QHZWPHYu32
         +r+Gij0J/egRxra85eYtQq5jEA9C5YY/gzIq6tsHFL81xd7lxahtzMCtvggGKROn2dyJ
         rXK+u1Po+jEnligo7sDDCsG5xOSqN3tbmVigxYgLiHX7TE2oE0Q69CtgHXFNB9df0otl
         VaLdGiTiqOA5dvc69kmfRNY9FwoIzfyERWYHP/uC7LAChcIPYYWgbnyNbqvTLzHLcIEW
         o1Hh5T8ovNQIocWTvhgUUv4P2hE8F19XINnC3oFJ0UexigfsY5vozm2Vmy27rcWQJ5ll
         2WOw==
X-Gm-Message-State: AHQUAubJ/xSrskQ7ECKmgXwX6KGHK4Spv2PgXuMeLRNS3D5M2BYsjlZ6
        sRYSI3Fvg3MyqjBFN4b3Rp/vVQ==
X-Google-Smtp-Source: AHgI3IYRcKFY2K04u3XYS+moU5DnAf9TTP3OJ/xivjCgM4wDGng6zigSE8RTUWTv6lEWc9yE+O/xOQ==
X-Received: by 2002:a65:610f:: with SMTP id z15mr817975pgu.153.1549474400540;
        Wed, 06 Feb 2019 09:33:20 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id s6sm9270281pgo.4.2019.02.06.09.33.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 09:33:19 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        Jayachandran C <jnair@caviumnetworks.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
Date:   Wed,  6 Feb 2019 23:02:25 +0530
Message-Id: <1549474347-7224-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549474347-7224-1-git-send-email-srinath.mannam@broadcom.com>
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
index 0000000..bfe1367
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
@@ -0,0 +1,62 @@
+Broadcom Stingray USB PHY
+
+Required properties:
+ - compatible : should be one of the listed compatibles
+	- "brcm,sr-usb-phy"
+	- "brcm,sr-usb-phy-v2"
+ - reg: offset and length of the PHY blocks registers
+ - address-cells: should be 1
+ - size-cells: should be 0
+
+Sub-nodes:
+  Each port's PHY should be represented as a sub-node.
+
+Sub-nodes required properties:
+ - reg: required for brcm,sr-usb-phy model phy.
+	reg value 0 is HS phy and 1 is SS phy.
+ - phy-cells: generic PHY binding; must be 0
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties
+
+Example:
+	usbphy0: usb-phy@0 {
+		compatible = "brcm,sr-usb-phy";
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
+		compatible = "brcm,sr-usb-phy";
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
+		compatible = "brcm,sr-usb-phy-v2";
+		reg = <0x00020000 0x100>,
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#phy-cells = <0>;
+	};
-- 
2.7.4

