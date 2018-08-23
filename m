Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444BAC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C422064E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:07:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C422064E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbeHWLgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:36:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728006AbeHWLgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:36:09 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3CC66BB6;
        Thu, 23 Aug 2018 08:07:43 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ray Jui <ray.jui@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 013/130] ARM: dts: Cygnus: Fix PCIe controller interrupt type
Date:   Thu, 23 Aug 2018 09:52:09 +0200
Message-Id: <20180823074928.252706881@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ray Jui <ray.jui@broadcom.com>

[ Upstream commit 6cb1628ad3506b315cdddd7676db0ff2af378d28 ]

Fix PCIe controller interrupt to use IRQ_TYPE_LEVEL_HIGH for Broadcom
Cygnus SoC

Fixes: cd590b50a936 ("ARM: dts: enable PCIe support for Cygnus")
Fixes: f6b889358a82 ("ARM: dts: Enable MSI support for Broadcom Cygnus")
Signed-off-by: Ray Jui <ray.jui@broadcom.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -168,7 +168,7 @@
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_NONE>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 
 			linux,pci-domain = <0>;
 
@@ -190,10 +190,10 @@
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
 
@@ -203,7 +203,7 @@
 
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_NONE>;
+			interrupt-map = <0 0 0 0 &gic GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>;
 
 			linux,pci-domain = <1>;
 
@@ -225,10 +225,10 @@
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
 


