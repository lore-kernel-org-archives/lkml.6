Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC18FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1352154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P0YhBrZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1352154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbeI0Efl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:35:41 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:57312 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbeI0Efk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:35:40 -0400
Received: from nis-sj1-27.broadcom.com (nis-sj1-27.lvn.broadcom.net [10.75.144.136])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id BB76730C03E;
        Wed, 26 Sep 2018 15:20:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com BB76730C03E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1538000433;
        bh=oNTv90bne+1o656uULNyNO8Qy1vOOkU8r05YPM6dE2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P0YhBrZm7eg55k+2vFL2uSBhg5vRv3HPsHR9y7d2nU4tECmKIXR4Gyd6b8L6p/7l/
         t951M1XzdSoW7jLEV6XdDIWQmPbi2MrbnqmKIb17OdM8X//gvakaYnCGKPo+2d3KWs
         JkHNXsSpO7L4NmIglMJonPhhXvwS+RoKxvWcG61E=
Received: from stbsrv-and-3.and.broadcom.com (stbsrv-and-3.and.broadcom.com [10.28.16.21])
        by nis-sj1-27.broadcom.com (Postfix) with ESMTP id 8EBBBAC074A;
        Wed, 26 Sep 2018 15:20:31 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dmitry Osipenko <digetx@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        James Hogan <jhogan@kernel.org>, Alban Bedel <albeu@free.fr>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Alex Elder <elder@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: [PATCH 1/5] dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI binding document
Date:   Wed, 26 Sep 2018 18:20:10 -0400
Message-Id: <1538000414-24873-2-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
References: <1538000414-24873-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Broadcom STB USB OHCI, EHCI and
XHCI drivers.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/usb/brcm,ehci-brcm.txt     | 22 +++++++++++++++++++++
 .../devicetree/bindings/usb/brcm,ohci-brcm.txt     | 22 +++++++++++++++++++++
 .../devicetree/bindings/usb/brcm,xhci-brcm.txt     | 23 ++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,ohci-brcm.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,xhci-brcm.txt

diff --git a/Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt b/Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
new file mode 100644
index 000000000000..020b5ec40f5b
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,ehci-brcm.txt
@@ -0,0 +1,22 @@
+Broadcom STB USB EHCI controller
+
+Required properties:
+- compatible: should be "brcm,ehci-brcm-v2"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 0 for the OHCI/EHCI PHY and 1 for the XHCI PHY
+
+Optional properties:
+- clocks: A list of phandles for the clocks
+
+Example:
+
+ehci@f0b00300 {
+	compatible = "brcm,ehci-brcm-v2";
+	reg = <0xf0b00300 0xa8>;
+	interrupts = <0x0 0x5a 0x0>;
+	interrupt-names = "usb0_ehci_0";
+	phys = <&usbphy_0 0x0>;
+	clocks = <&usb20>
+};
diff --git a/Documentation/devicetree/bindings/usb/brcm,ohci-brcm.txt b/Documentation/devicetree/bindings/usb/brcm,ohci-brcm.txt
new file mode 100644
index 000000000000..c7bb56f30540
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,ohci-brcm.txt
@@ -0,0 +1,22 @@
+Broadcom STB USB OHCI controller
+
+Required properties:
+- compatible: should be "brcm,ohci-brcm-v2"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 0 for the OHCI/EHCI PHY and 1 for the XHCI PHY
+
+Optional properties:
+- clocks: A list of phandles for the clocks
+
+Example:
+
+ohci@f0b00400 {
+	compatible = "brcm,ohci-brcm-v2";
+	reg = <0xf0b00400 0x58>;
+	interrupts = <0x0 0x5b 0x0>;
+	interrupt-names = "usb0_ohci_0";
+	phys = <&usbphy_0 0x0>;
+	clocks = <&usb20>;
+};
diff --git a/Documentation/devicetree/bindings/usb/brcm,xhci-brcm.txt b/Documentation/devicetree/bindings/usb/brcm,xhci-brcm.txt
new file mode 100644
index 000000000000..7ca5f126c2f6
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,xhci-brcm.txt
@@ -0,0 +1,23 @@
+Broadcom STB USB XHCI controller
+
+Required properties:
+- compatible: should be "brcm,xhci-brcm-v2"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 0 for the OHCI/EHCI PHY and 1 for the XHCI PHY
+
+Optional properties:
+- clocks: A list of phandles for the clocks
+- usb3-lpm-capable: determines if platform is USB3 LPM capable
+
+Example:
+
+xhci_0_0: xhci@f0b01000 {
+	compatible = "brcm,xhci-brcm-v2";
+	reg = <0xf0b01000 0x1000>;
+	interrupts = <0x0 0x5c 0x0>;
+	interrupt-names = "usb0_xhci_0";
+	phys = <&usbphy_0 0x1>;
+	clocks = <&usb30>;
+};
-- 
1.9.0.138.g2de3478

