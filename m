Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D0F78C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89414208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 22:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkpOCzCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89414208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932932AbeFKWsG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 18:48:06 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35368 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932108AbeFKWrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 18:47:35 -0400
Received: by mail-qk0-f196.google.com with SMTP id d130-v6so13980783qkc.2;
        Mon, 11 Jun 2018 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=83n27sg7B3V32StygSAif6s7jSaLdGWiAA3GUPmLvms=;
        b=dkpOCzCnqFDHUyCuLnmCREReM5a8368aObi6ZnyYBNEiqMOuPQI1IUTTuoGLVKFt74
         p9g0pfz6gxsUQ3B+a7XZxuUt7bbU2zTw/JciYyX7qGLR8KE+U9dlu0zZpDjozi4L1nu9
         iurYuNYCAct1GOYL5qO/OqgYwvaCZzKTaE1f175UMSKZcRtOh5AK3qQBNt7qvG/QNQNa
         xr3o25m5cAbanglHNpFKjkD0sQNDTXiRnExjDH/SkXTjs+KOgpWBnrnYx6GBXTnuOth8
         WJ3648dOGEiRsvrU9s3xvTVyIkkb/SpcIJZbTcSFETeqwDpG7iMO3GgB1sIb06wLDUqc
         /5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=83n27sg7B3V32StygSAif6s7jSaLdGWiAA3GUPmLvms=;
        b=GsmuZNnBVFl1j/OfEV0p9Cj9hYdN/QxTFw6lIyEIIyADhTkbuszRH6eIqcv/j4GZEw
         zMEC3el8ZLDCZ/yMP/XAckAHwsFpTUP0aL+B6v4fZuExNwWlYyUQeA0aHLyzpCaQHuUH
         KoIvuZ7Iv0y8Ah5cHFCuOi48SBfUcXyArjbxyhedsYOXdTMaIwlFI1+A3iudEITRrMZZ
         ugmLzMLiKvG1QDBtMa3AJh6NICny4wu/pctnOZY+uszzVPmOFfIz9fK0kkwiTzLp8z3i
         3Dwip8VfaWN4f3E4mzfFaxQ5MIE52i+izs8hOWJz17IvKznw76hw9kGG4VWW6wEF7N+f
         VsIQ==
X-Gm-Message-State: APt69E0y3dPRWmpoE/hmODVbOWK/TnA71Y1nfvc4vUQHVYEDf3Rrd8jP
        4CbAXz4ZLKu35knaH3XhNko=
X-Google-Smtp-Source: ADUXVKLEg+IYky1HGGNYiQA+hO61PNpkLyPj//tDCZPya9PMkfAT93iZDAhOZMlDLbkVoBQcV4bfKg==
X-Received: by 2002:a37:9605:: with SMTP id y5-v6mr1067544qkd.236.1528757254748;
        Mon, 11 Jun 2018 15:47:34 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i10-v6sm35645869qtf.20.2018.06.11.15.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 15:47:33 -0700 (PDT)
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
Subject: [PATCH 3/3] ARM: dts: HR2: Fix interrupt types for i2c and PCIe
Date:   Mon, 11 Jun 2018 15:47:14 -0700
Message-Id: <20180611224714.7007-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180611224714.7007-1-f.fainelli@gmail.com>
References: <20180611224714.7007-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The i2c and PCIe controllers had an incorrect type which should have
been set to IRQ_TYPE_LEVEL_HIGH, fix that.

Fixes: b9099ec754b5 ("ARM: dts: Add Broadcom Hurricane 2 DTS include file")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm-hr2.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-hr2.dtsi b/arch/arm/boot/dts/bcm-hr2.dtsi
index 3f9cedd8011f..3084a7c95733 100644
--- a/arch/arm/boot/dts/bcm-hr2.dtsi
+++ b/arch/arm/boot/dts/bcm-hr2.dtsi
@@ -264,7 +264,7 @@
 			reg = <0x38000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 95 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 		};
 
@@ -279,7 +279,7 @@
 			reg = <0x3b000 0x50>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clock-frequency = <100000>;
 		};
 	};
@@ -300,7 +300,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 186 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <0>;
 
@@ -322,10 +322,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 182 IRQ_TYPE_NONE>,
-				     <GIC_SPI 183 IRQ_TYPE_NONE>,
-				     <GIC_SPI 184 IRQ_TYPE_NONE>,
-				     <GIC_SPI 185 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 182 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 183 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
@@ -336,7 +336,7 @@
 
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_NONE>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
 
 		linux,pci-domain = <1>;
 
@@ -358,10 +358,10 @@
 			compatible = "brcm,iproc-msi";
 			msi-controller;
 			interrupt-parent = <&gic>;
-			interrupts = <GIC_SPI 188 IRQ_TYPE_NONE>,
-				     <GIC_SPI 189 IRQ_TYPE_NONE>,
-				     <GIC_SPI 190 IRQ_TYPE_NONE>,
-				     <GIC_SPI 191 IRQ_TYPE_NONE>;
+			interrupts = <GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 191 IRQ_TYPE_LEVEL_HIGH>;
 			brcm,pcie-msi-inten;
 		};
 	};
-- 
2.14.1

