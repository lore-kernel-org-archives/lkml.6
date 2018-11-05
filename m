Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A72EC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108662081C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGi6CIUM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108662081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388102AbeKFGyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:54:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37237 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387899AbeKFGyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:54:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id c10-v6so4811832pgq.4;
        Mon, 05 Nov 2018 13:32:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q13zyxjtLMGSvq8CStH7nEQVSyTKekwyvItSN2Yi5X8=;
        b=YGi6CIUMI6nQDd9SzO84BU3STG67c97WvKaRwzV27Ak5c8gVKNszcv+1BycYyx6tZT
         +WB1Xp2t6iUsoJF0MWxVEoTQomQiTKuijCRy7jHEXY4TAKIk3z2BJfafUq/mmeit4Bpn
         OA80/jzMvDVg3jsqMADUTg//v0u+9E64isAjv5IxFPWBsCnbTveLLOCz8K7GOlbMJbdD
         f9DfkJjlMyrpBQHRNuHJDUS9tuC96lDCDF0CzeW31cknfuw3Pm74HHIPEo17XLEmwvy1
         LwXLWOYye51ISK1w7U4Y5VzjlfbPLlKr2Hhip8761afjN/Og72mL60c5rTCsPyehEybw
         AaqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q13zyxjtLMGSvq8CStH7nEQVSyTKekwyvItSN2Yi5X8=;
        b=kAcVmPKhIQSHHVzMWAbKtM5j/r+akO++CkvCF7+2bDgYjhqQ2TNElJUjNo1Wd4L/uS
         V6nNA8je6d7Bk354WvW/3E2PiIOfkshl2a2L0x9XPHvlDkBkbOY8Bak7CRPNFkkUx8b5
         /5FKXpLINtB1OSdVT177KpRRrYIQgUuz61Nyd7NYOebpeOmkPAG56UZ1YVKJsnIIQf+R
         n01IBgXO2qNSJE2Tm5vP5byHXKfHA9R1Q78X5tO3AveqrYeNtlvTnQ4aAWT2eBUzK7nu
         igSi0Q2X0O1Zm8OuSC0Taw2yzptUFIxd/baoDilyi+rjyWy6wmrFGRMHGOU2NynsP5w4
         407g==
X-Gm-Message-State: AGRZ1gKSXXE4GMLlJqREtJfaasd+/NXQjfaOINhsH30WjWHCl/hUv+Yi
        kdspmApDhplPgnLixEmzlKpegOg88mg=
X-Google-Smtp-Source: AJdET5dcNJL23rAjmQVHU50TFh5pokem6sgzPkkYRlhB+ZV7d6XMtWFGkWwECeqJBjfh8YyuPTNFPw==
X-Received: by 2002:a62:b24e:: with SMTP id x75-v6mr24189204pfe.148.1541453578986;
        Mon, 05 Nov 2018 13:32:58 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m129-v6sm14328440pfm.78.2018.11.05.13.32.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:32:58 -0800 (PST)
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
Subject: [PATCH V3 1/6] dt-bindings: Add Broadcom STB OHCI, EHCI and XHCI binding document
Date:   Mon,  5 Nov 2018 16:31:28 -0500
Message-Id: <1541453493-34981-2-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
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

