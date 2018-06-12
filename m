Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id BF470C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BB7208AE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="em1dpKNY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BB7208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934516AbeFLUWw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:22:52 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:42250 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933517AbeFLUVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:21:49 -0400
Received: by mail-qk0-f194.google.com with SMTP id j80-v6so178091qke.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NmtYejaVr49vUkSDCF8993I3P1Hvc+o6t8lYihInN8g=;
        b=em1dpKNYVT8/MjLbpaM3F6FZaEMPcVBp+pSJrLy3V6fmuXoV4J8auTAybr2v/oens5
         MLO/94O++RxM6UBTdsAxMDa7qyXXcGiC6vTPNQMNBC2Om9Qj3wb6jzEr2rpabHKR2bT5
         CdPOg2HWsNNM3xrBMEvvLgZrID5E4PY7pzkzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NmtYejaVr49vUkSDCF8993I3P1Hvc+o6t8lYihInN8g=;
        b=fUrYzQAIBzdITpjMOZSTJMy4ZqlPmFUUVwPqmObj3rCzcJQ32sIZXu+err/6mJY9eI
         jdIVwrTNYwOxbb5KWZ9Qm5cL9u7CupgplfusM0MHhZHxmY1YWbAlJbsSgFE+UUorqHwF
         nr00//bZAg4Katyofk+oCvPgmTgPq/8MJNH0XvVzKmDskkD4npntcVjEtiaqNi4As0PJ
         jlbNZEjuPPSNYe4W78qLsnU9FE/MCnvHtm4Ubk3NWRO+NEkDdVv3rubPFBGw4AJzIylc
         4SlqV3kMO2vQ8M6/dC4XwXySVOJZUBPilM89lAb8PCGCnmOWdro5jEo+omY6OL1B+IMF
         pWFw==
X-Gm-Message-State: APt69E2Z3LBEkMOQ34B+xpfebXYbnIsNA0OTPfn9ln42e81c+3y6HqkN
        a6emPeY6fJ3drZ6txchRslMg8Q==
X-Google-Smtp-Source: ADUXVKIABZFkypNvdCWSLCZJaVqGmF5QlWgOg2jEmWFEk9ELP4PsSo13evXvQd62BMxWQs7ljk1ZZw==
X-Received: by 2002:a37:84c3:: with SMTP id g186-v6mr1904420qkd.346.1528834908676;
        Tue, 12 Jun 2018 13:21:48 -0700 (PDT)
Received: from lbrmn-lnxub44-1.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l9-v6sm635080qtp.25.2018.06.12.13.21.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jun 2018 13:21:47 -0700 (PDT)
From:   Ray Jui <ray.jui@broadcom.com>
To:     linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 2/5] ARM: dts: cygnus: Fix PCIe controller interrupt type
Date:   Tue, 12 Jun 2018 13:21:28 -0700
Message-Id: <1528834891-17807-3-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
References: <1528834891-17807-1-git-send-email-ray.jui@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
Cygnus SoC

Fixes: cd590b50a936 ("ARM: dts: enable PCIe support for Cygnus")
Fixes: 0f0b21a83ad2 ("ARM: dts: Move all Cygnus peripherals into axi
bus")
Fixes: 9c5101f7a253 ("ARM: dts: Reorder Cygnus peripherals")
Fixes: f6b889358a82 ("ARM: dts: Enable MSI support for Broadcom Cygnus")

Signed-off-by: Ray Jui <ray.jui@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 835a6f7..2c4df2d 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -256,7 +256,7 @@
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 
 			linux,pci-domain = <0>;
 
@@ -278,10 +278,10 @@
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 96 IRQ_TYPE_NONE>,
-					     <GIC_SPI 97 IRQ_TYPE_NONE>,
-					     <GIC_SPI 98 IRQ_TYPE_NONE>,
-					     <GIC_SPI 99 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
@@ -291,7 +291,7 @@
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 
 			linux,pci-domain = <1>;
 
@@ -313,10 +313,10 @@
 				compatible = "brcm,iproc-msi";
 				msi-controller;
 				interrupt-parent = <&gic>;
-				interrupts = <GIC_SPI 102 IRQ_TYPE_NONE>,
-					     <GIC_SPI 103 IRQ_TYPE_NONE>,
-					     <GIC_SPI 104 IRQ_TYPE_NONE>,
-					     <GIC_SPI 105 IRQ_TYPE_NONE>;
+				interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
 
-- 
2.1.4

