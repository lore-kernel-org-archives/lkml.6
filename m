Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E0EFECDE3B
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 194332145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 22:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rXzBEFOC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 194332145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbeJRG1s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 02:27:48 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45045 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRG1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 02:27:48 -0400
Received: by mail-pf1-f193.google.com with SMTP id r9-v6so13861759pff.11;
        Wed, 17 Oct 2018 15:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q13zyxjtLMGSvq8CStH7nEQVSyTKekwyvItSN2Yi5X8=;
        b=rXzBEFOCXmSuTpy86h+k29rs6cpy+aXNQnInZy+sVSGhqkkG3RwBXoqWXKFiUoILbG
         7wdTAO+RqFJkduxvF2rYFVTlZciqM0gKzkZ4wq5odC92Q4bY23cIKyOIisgRznLa8EI0
         gUeGJmOcWjsD3AtJ7wY36La7ySulKMQtjulat7XrQ4rKafm0uCXg0zi0JkqY6Tqv/y+C
         AnO2WWmSIy8NXBim9rQD9/tTHuM307yVg7f/ckulZrD4i6GHRgbYjafca1APPThRhCu4
         77hdVqkEZv2z1EBen2Zrjpgs0QBt+c/22RFBNl27csCkkvtyVdUOP8x0AnJQsBPGYqMP
         UoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q13zyxjtLMGSvq8CStH7nEQVSyTKekwyvItSN2Yi5X8=;
        b=PtpYlciSW5yTzH1C4fgYynvdyvMHE/PTVM/qLfCwiTRAjHMiCEILo/uet7mt2OXVNb
         brwak/c4N1KFapBvoDaHN+f4OIBcQg4G7cEaUh5vWNK6yYpeNdy5UZ3zhSa5cB2M/2ye
         /arcCkU2rLq5uWpX5YK9AEcVaj1EV1oitqNgzlWjz+G6xPoNX4VfC/FaiPANWlV3Zgea
         1D3LFY2eglbiqCDvwjg92zw5Ed7Lh9pUjNdAHXL43VBhnuutL/VDooSaqfMAlMIhdKkw
         YEalToQMnq0V1y0qgRH/uQkvcPN2kV7x1v7mBEPi2pRHVHXfbrXnm1kpw+eumk7u8dBj
         gzeA==
X-Gm-Message-State: ABuFfohGqbDQtvR0nEBTAx8SbMxlIyD6t0MfSbeVjKDVLrmajRgaU600
        ZNmieVm1r46mC5gBN2pol/qiTAmXxM0=
X-Google-Smtp-Source: ACcGV62qsmkmCO95yEo9x3h/6HQzSOlO36LG/8xYfHMjaTWd6n7QJKj5zsW59XYcR6Jaxov0SURmEQ==
X-Received: by 2002:a62:3641:: with SMTP id d62-v6mr19200367pfa.97.1539815401214;
        Wed, 17 Oct 2018 15:30:01 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id p3-v6sm352597pgl.2.2018.10.17.15.29.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 15:30:00 -0700 (PDT)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V2 1/6] dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI binding document
Date:   Wed, 17 Oct 2018 18:29:04 -0400
Message-Id: <1539815349-24126-2-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
References: <1539815349-24126-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings document for Broadcom STB USB OHCI, EHCI and
XHCI drivers.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/usb/brcm,bcm7445-ehci.txt  | 22 +++++++++++++++++++++
 .../devicetree/bindings/usb/brcm,bcm7445-ohci.txt  | 22 +++++++++++++++++++++
 .../devicetree/bindings/usb/brcm,bcm7445-xhci.txt  | 23 ++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt
 create mode 100644 Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt

diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
new file mode 100644
index 000000000000..824f4bf5d07c
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ehci.txt
@@ -0,0 +1,22 @@
+Broadcom STB USB EHCI controller
+
+Required properties:
+- compatible: should be "brcm,bcm7445-ehci"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 0 for the OHCI/EHCI PHY
+
+Optional properties:
+- clocks: A phandle for the EHCI clock
+
+Example:
+
+ehci@f0b00300 {
+	compatible = "brcm,bcm7445-ehci";
+	reg = <0xf0b00300 0xa8>;
+	interrupts = <0x0 0x5a 0x0>;
+	interrupt-names = "usb0_ehci_0";
+	phys = <&usbphy_0 0x0>;
+	clocks = <&usb20>
+};
diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt
new file mode 100644
index 000000000000..de5a22b3d138
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-ohci.txt
@@ -0,0 +1,22 @@
+Broadcom STB USB OHCI controller
+
+Required properties:
+- compatible: should be "brcm,bcm7445-ohci"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 0 for the OHCI/EHCI PHY
+
+Optional properties:
+- clocks: A phandle for the OHCI clock
+
+Example:
+
+ohci@f0b00400 {
+	compatible = "brcm,bcm7445-ohci";
+	reg = <0xf0b00400 0x58>;
+	interrupts = <0x0 0x5b 0x0>;
+	interrupt-names = "usb0_ohci_0";
+	phys = <&usbphy_0 0x0>;
+	clocks = <&usb20>;
+};
diff --git a/Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt b/Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt
new file mode 100644
index 000000000000..c41f3f8d836d
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/brcm,bcm7445-xhci.txt
@@ -0,0 +1,23 @@
+Broadcom STB USB XHCI controller
+
+Required properties:
+- compatible: should be "brcm,bcm7445-xhci"
+- reg: should contain one register range i.e. start and length
+- interrupts: description of the interrupt line
+- phys: phandle + phy specifier pair
+  The specifier should be 1 for the XHCI PHY
+
+Optional properties:
+- clocks: A phandle for the XHCI clock
+- usb3-lpm-capable: determines if platform is USB3 LPM capable
+
+Example:
+
+xhci_0_0: xhci@f0b01000 {
+	compatible = "brcm,bcm7445-xhci";
+	reg = <0xf0b01000 0x1000>;
+	interrupts = <0x0 0x5c 0x0>;
+	interrupt-names = "usb0_xhci_0";
+	phys = <&usbphy_0 0x1>;
+	clocks = <&usb30>;
+};
-- 
1.9.0.138.g2de3478

