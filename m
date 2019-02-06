Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4CCC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B5E2080D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 15:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ehXb9wYf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731365AbfBFPRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 10:17:10 -0500
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41956 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726726AbfBFPRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 10:17:09 -0500
Received: by mail-yb1-f194.google.com with SMTP id n6so2600316ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 07:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZkcE4sKmTKPifhk6h7j1EEIJitiKEOOaAtV2z40Cqyg=;
        b=ehXb9wYf/sxx+zZmh9jOs2WwMTHPNL+KIIXO3NnpRDWa+Qaj4JgxN9HRzRCy7ucCoU
         aESHz90JQ71x4MkbH9zsDWzTNxwHPMVUCtH1JdG+fmUnaRdWqQ2hH7vGhauf10X3bUyT
         JO6KCXIJEi7fNyxLm6dh7ahYePxXaJg3+DRaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZkcE4sKmTKPifhk6h7j1EEIJitiKEOOaAtV2z40Cqyg=;
        b=OK6OkmQxDpInX9yGo1QgPB7aPqxQksvajXp0aLVbnpjmcci7CmqQxXMuYrnBKD+tNK
         b+z8+osCyAqrOrNCzYXHqPAR1fds/5+3GyLS7SMWkvUMddX0G0zQeDcfstIKY2ya+MFC
         K/R0FIYFkokZM+A6+RvE5gFclJTF57XHcHHKJp9PHjaPy8um4JuYUT0Wlq8Q6czoeVl2
         unE2qPpOpeE7t/Vmg9E+VNHcba4X3eXx91wRSTGoRjrer6IXDuznINafeEva7OSOGaP4
         0rlJkbGz1/Le7W7XuTAmh+p/FNsVKoU5dg2GPWFfuROoPdckrY65g2ffgzGrceKyOMsC
         h94w==
X-Gm-Message-State: AHQUAuYlg6FxV2Xs33dvMnOw540r9VYPyBCXycCi6nqtVGL4+KidULGO
        xNxotRU5BEfVLz1quroBF99jHA==
X-Google-Smtp-Source: AHgI3IYvSueXReBgAp4tu7rofaf3YdAGh/DZ13FBINnEhhNU6CWnGj+tLylTihc6IqhwV0B+lfBW0w==
X-Received: by 2002:a25:807:: with SMTP id 7mr1734758ybi.367.1549466227940;
        Wed, 06 Feb 2019 07:17:07 -0800 (PST)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r124sm557617ywb.39.2019.02.06.07.17.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Feb 2019 07:17:07 -0800 (PST)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tejun Heo <tj@kernel.org>,
        "Jayachandran C --cc=devicetree @ vger . kernel . org" 
        <jnair@caviumnetworks.com>, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3 1/3] dt-bindings: phy: Add Stingray USB PHY binding document
Date:   Wed,  6 Feb 2019 20:46:45 +0530
Message-Id: <1549466207-3190-2-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549466207-3190-1-git-send-email-srinath.mannam@broadcom.com>
References: <1549466207-3190-1-git-send-email-srinath.mannam@broadcom.com>
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

