Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525706603-2-9766110330433721694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525706602; b=mOcxGlHenhG8fTzTnr2dw0NCU1rJrws+H2+d0wn5+xxLDp2/Ug
    b+ua6J5A49BQrQu3cZSlb+RVLKOqRBymumzrPCJHoZACIY0s5Xl5D2iMvCSa1tPr
    cFSkhr0hASozdf/E4lOXmB5oGSDvEXAcpGEJf439Nnzkg67c393xVf5Y4BqthVHt
    FedSwj+OYp0DtP2I1XiP0kyeNeiY68+v1WPN8h7P2PqI0d7n367wMM5Y3nvqAREu
    OdqdHvHeAas83MsfwIY5unsIJyGBLcaLcJM9JSsbLHLFo2OSc6p6CRzfOF1OtINz
    isdFMjCusr0ekPQxVQcglTs6gkgumXmN5xvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525706602; bh=
    XNWTR6vpFHwsfJ/UKVocdOqZLVpXxPD4/F4N9za7a7o=; b=RltlwykMi5eDMZjP
    kVit2lmH5LDL1PVgFYYQnCITVc02dMNVDp5qzS5yaLX8zA6w6w+6uqBWy15PFXW4
    iYjxfBQEsF3lZ6UixC+bijO0RCnxAZyshDdxWU7WsfHSmVXhLya54lhxudeBEchT
    BvaaCS4JSQUf+Xu3CiS/N72pNSe9L0GK+YsH1shyRYjhg5KsdLybiPhKVp1DBOOW
    +pFxcFWX0jl69wKhRNEQyJrhiPA62rEzNhNF3/u/fo4hPAWMSwh8AfjmfFpl9eJY
    EVc54ZmkkRlx//MGTqRiUjYCqtDPjQqAHmpXdl5+RanH+3EK8vMMurxdaTmfsHEW
    fYc1Ng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=aosc.io;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=aosc.io header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFVR3lZfcIJ5bhIYiRHKMAu/gVoq1OQtEGj0zVgp55fmTCioNatOjaIz4xDuORFZPA5pPXo/Xx7nFbLlEUDpFKcgdLTdjwtg+Dgk0fJfzW+dKB7wrdv4
    VfdCpUubSmw1DxHGSMg9/5FPDibIoRynuN8fufFWJDNZ3KZ53wX4cuuGkgehc0RlR6Q0yrfLLLmRkgdsGlLcavS+igj974vp8V8KeGrl0GjLmLgBmuY8pcJd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=T9tvk05W3M3BFl53G_MA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeEGPXO (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:23:14 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48457 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbeEGPXN (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 11:23:13 -0400
From: Icenowy Zheng <icenowy@aosc.io>
To: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Felipe Balbi <balbi@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-sunxi@googlegroups.com, Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH 2/5] dt-bindings: usb: add binding for the DWC3 controller on Allwinner SoC
Date: Mon,  7 May 2018 23:18:14 +0800
Message-Id: <20180507151817.55663-3-icenowy@aosc.io>
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The Allwinner H6 SoC uses DWC3 controller for USB3.

Add its device tree binding document.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../bindings/usb/allwinner,dwc3.txt           | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/allwinner,dwc3.txt

diff --git a/Documentation/devicetree/bindings/usb/allwinner,dwc3.txt b/Documentation/devicetree/bindings/usb/allwinner,dwc3.txt
new file mode 100644
index 000000000000..3f7714636785
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/allwinner,dwc3.txt
@@ -0,0 +1,39 @@
+Allwinner SuperSpeed DWC3 USB SoC controller
+
+Required properties:
+- compatible:	should contain "allwinner,sun50i-h6-dwc3" for H6 SoC
+- clocks:	A list of phandle + clock-specifier pairs for the
+		clocks listed in clock-names
+- clock-names:	Should contain the following:
+  "bus"		The bus clock of the DWC3 part
+- resets:	A list of phandle + reset-specifier pairs for the
+		resets listed in reset-names
+- reset-names:	Should contain the following:
+  "bus"		The bus reset of the DWC3 part
+
+Required child node:
+A child node must exist to represent the core DWC3 IP block. The name of
+the node is not important. The content of the node is defined in dwc3.txt.
+
+Phy documentation is provided in the following places:
+Documentation/devicetree/bindings/phy/sun50i-usb3-phy.txt
+
+Example device nodes:
+	usb3: usb@5200000 {
+		compatible = "allwinner,sun50i-h6-dwc3";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		clocks = <&ccu CLK_BUS_XHCI>;
+		clock-names = "bus";
+		resets = <&ccu RST_BUS_XHCI>;
+		reset-names = "bus";
+
+		dwc3: dwc3 {
+			compatible = "snps,dwc3";
+			reg = <0x5200000 0x10000>;
+			interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+			phys = <&usb3phy>;
+			phy-names = "usb3-phy";
+		};
+	};
-- 
2.17.0

