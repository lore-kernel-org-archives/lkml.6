Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F5DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:46:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B8B7205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:46:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IxxMZnV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B8B7205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030736AbeFSTpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:45:50 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:43150 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030602AbeFSTn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:43:57 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5JJgrvU013969;
        Tue, 19 Jun 2018 14:42:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529437373;
        bh=KhhR4SSjigNeh4SH/4lNjupo+dLgNBFVNkWI94Ab1Qk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=IxxMZnV3HV2OgXVOqUTtJkuOHY83cthmMOcL8CRqcZrOKHH7M/aCF3huz4J5a1NWm
         XMrUHyzFE05Uae9ONYnR8Ci9PCZ8X3B6qZBL35gLrNiVES8D7yIWTyyhbtVzPG5MHS
         waZBVdesGNNRFC6j//ohrSAUrlZj95knEG3pOnYI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgrSH023369;
        Tue, 19 Jun 2018 14:42:53 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 19
 Jun 2018 14:42:53 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 19 Jun 2018 14:42:53 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5JJgr4a017140;
        Tue, 19 Jun 2018 14:42:53 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 1/5] dt-bindings: arm: ti: Add bindings for AM654 SoC
Date:   Tue, 19 Jun 2018 14:42:49 -0500
Message-ID: <20180619194253.27288-2-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180619194253.27288-1-nm@ti.com>
References: <20180619194253.27288-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AM654 SoC is a lead device of the K3 Multicore SoC architecture
platform, targeted for broad market and industrial control with aim to
meet the complex processing needs of modern embedded products.

Some highlights of this SoC are:
* Quad ARMv8 A53 cores split over two clusters
* GICv3 compliant GIC500
* Configurable L3 Cache and IO-coherent architecture
* Dual lock-step capable R5F uC for safety-critical applications
* High data throughput capable distributed DMA architecture under NAVSS
* Three Gigabit Industrial Communication Subsystems (ICSSG), each with dual
  PRUs and dual RTUs
* Hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
* Centralized System Controller for Security, Power, and Resource
  management.
* Dual ADCSS, eQEP/eCAP, eHRPWM, dual CAN-FD
* Flash subsystem with OSPI and Hyperbus interfaces
* Multimedia capability with CAL, DSS7-UL, SGX544, McASP
* Peripheral connectivity including USB3, PCIE, MMC/SD, GPMC, I2C, SPI,
  GPIO

See AM65x Technical Reference Manual (SPRUID7, April 2018)
for further details: http://www.ti.com/lit/pdf/spruid7

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since RFC:
 * Dropped the generic terminology for compatibles

previous RFC: https://patchwork.kernel.org/patch/10447643/

 Documentation/devicetree/bindings/arm/ti/k3.txt | 23 +++++++++++++++++++++++
 MAINTAINERS                                     |  7 +++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/ti/k3.txt

diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
new file mode 100644
index 000000000000..6a059cabb2da
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
@@ -0,0 +1,23 @@
+Texas Instruments K3 Multicore SoC architecture device tree bindings
+--------------------------------------------------------------------
+
+Platforms based on Texas Instruments K3 Multicore SoC architecture
+shall follow the following scheme:
+
+SoCs
+----
+
+Each device tree root node must specify which exact SoC in K3 Multicore SoC
+architecture it uses, using one of the following compatible values:
+
+- AM654
+  compatible = "ti,am654";
+
+Boards
+------
+
+In addition, each device tree root node must specify which one or more
+of the following board-specific compatible values:
+
+- AM654 EVM
+  compatible = "ti,am654-evm", "ti,am654";
diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..fbd93eee41ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2087,6 +2087,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/memory/*emif*
 
+ARM/TEXAS INSTRUMENTS K3 ARCHITECTURE
+M:	Tero Kristo <t-kristo@ti.com>
+M:	Nishanth Menon <nm@ti.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/devicetree/bindings/arm/ti/k3.txt
+
 ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
 M:	Santosh Shilimkar <ssantosh@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.15.1

