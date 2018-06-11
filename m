Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 39399C004E4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E098B208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDuE+VRc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E098B208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932769AbeFKWrl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:47:41 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34796 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754271AbeFKWrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:47:33 -0400
Received: by mail-qk0-f194.google.com with SMTP id q70-v6so13985235qke.1;
        Mon, 11 Jun 2018 15:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dZGuCioGeLlhwG6sYu2CUMSMj88mc6K72QSOKYPVhy0=;
        b=MDuE+VRc718MerxiXlMCY81zHlwGeWLKRTHkkAMqFjY0JWjHB4n2O+x9ziCh8Yyndk
         Hu7X+F2pz1Be5YQE9kIarFRxxprmbuB0d3zEBigZ6hcCkioKGd6FMrV8FSnvcEWtydow
         hoL4C6JatQVyUyBvR9cZbu3II1feuEozYBtM2R3U0tKVjVFgGn9yzJRElMzSQkSt5CAP
         awPKm5EoUFy23kbbMww0vL16Lv4pcxY2YfQBhww9yXvtfKnyb1yFn2IZdkYVXwPx9phV
         hv8OEroD2i0q6/Bp6oO/zHBCYd9khd197aFZz+ma7EcrWUGlZuWWRnImC8VQicL8IIOH
         tmxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dZGuCioGeLlhwG6sYu2CUMSMj88mc6K72QSOKYPVhy0=;
        b=K36CEg6FoKKF4mnq2+6tr3gKb/Wn6J8PclpNscT0pU5YGJ7PkEVFrr82aWxItFoZYP
         dGVt/SIS3LSKZVhJosnc/MrHwB3oRyWSW0BEm0+m+VxyhqCb6WiswAYrXfIac2o+xTHa
         K3Hp62Vfad/q0vOQP3cKki+lSK3IPmotz52/y0kHiB0dUOoxEuNSyLcBNESbv5tC55eG
         RoHBk4zxDAL4W9GfDwQGX5DdBunQOLlVakpklPvwfbcqPY8m2HTp00x+eD4BqAfhJpYc
         DJHqD/EFDv0rJxSZORt8hIob+3sFZVk9C2xSp4l+/97EBCwFVqiFN7iQOS+ItmUHd1wL
         wcfg==
X-Gm-Message-State: APt69E3//DGtahCCv1VK0t/D/MIz8Aflfdm8NuYHtwzxtbGLx9EWOyc5
        X1yniudSCCmvArXQV0g3NFmiw6y0
X-Google-Smtp-Source: ADUXVKJIdU0Sqxt4X4uWUwf0didS06PSQmwNCJNiXdF0cY45vwUlMVzWAW4gHkHzAmuudsLO6N1L9g==
X-Received: by 2002:a37:ddce:: with SMTP id u75-v6mr1047014qku.147.1528757252459;
        Mon, 11 Jun 2018 15:47:32 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i10-v6sm35645869qtf.20.2018.06.11.15.47.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 15:47:31 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM IPROC ARM
        ARCHITECTURE),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] ARM: dts: NSP: Fix PCIe controllers interrupt types
Date:   Mon, 11 Jun 2018 15:47:13 -0700
Message-Id: <20180611224714.7007-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611224714.7007-1-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The interrupts for the PCIe controllers should all be of type
IRQ_TYPE_LEVEL_HIGH instead of IRQ_TYPE_NONE.

Fixes: d71eb9412088 ("ARM: dts: NSP: Add MSI support on PCI")
Fixes: 522199029fdc ("ARM: dts: NSP: Fix PCIE DT issue")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-nsp.dtsi | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-nsp.dtsi b/arch/arm/boot/dts/bcm-nsp.dtsi
index c6aa62386941..09ba85046322 100644
--- a/arch/arm/boot/dts/bcm-nsp.dtsi
+++ b/arch/arm/boot/dts/bcm-nsp.dtsi
@@ -496,7 +496,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <0>;
 
@@ -519,10 +519,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 127 IRQ_TYPE_NONE>,
-				     <GIC_SPI 128 IRQ_TYPE_NONE>,
-				     <GIC_SPI 129 IRQ_TYPE_NONE>,
-				     <GIC_SPI 130 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
@@ -533,7 +533,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <1>;
 
@@ -556,10 +556,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 133 IRQ_TYPE_NONE>,
-				     <GIC_SPI 134 IRQ_TYPE_NONE>,
-				     <GIC_SPI 135 IRQ_TYPE_NONE>,
-				     <GIC_SPI 136 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
@@ -570,7 +570,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <2>;
 
@@ -593,10 +593,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 139 IRQ_TYPE_NONE>,
-				     <GIC_SPI 140 IRQ_TYPE_NONE>,
-				     <GIC_SPI 141 IRQ_TYPE_NONE>,
-				     <GIC_SPI 142 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
-- 
2.14.1

