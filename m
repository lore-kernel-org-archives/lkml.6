Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525706754-2-13126942642773089935
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='io',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525706752; b=cAAEPw+eS6+YZ0O1lge0f8/CXed3v8Lpo06Bh4WqO+dyc56jLI
    fGEe4/rOo+4kDBE0m5TSHhSot3qDfJpZBBeLTwpQ6yEOyDWVajct7xSO+d+sTUj5
    H9qGK0Grfs0n3jm5RQPpmCrjN0XKzrkxMPJtByH7Tu2IdVlbrK4IljRaLtRx6g2S
    dxjzYO1k6ISyydTZ+s0cv97NQTwmraKoOsBZnRZMVs5LBUk4B9UlBYwV+Gd10Lbr
    s1cn1SdU7Owf9HIB+s/WD0w31VRmCdjYvpIXDRvHpWExyVcTaI0y4Pa8Rn+wv5j0
    svsKrxfLley53wALFiGTPJC3BTvV/vftNYfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525706752; bh=
    JRu2rPTZBouiUOIQHhgSuySDl7HvB1h1eKp+RHudcNY=; b=FyjPnDS1ULoxhb3B
    9MDkdUyl04inOm6aUyq2L8nc7aDyFlvVzplTChDksB46YyGU21/FCTj7zuvktfLh
    OUVKDoS6WzWAMyi7lB36nusNdc6JUgicA4gZsuCjZRrFIBpPJZ5sNNB6zL9a3U60
    raU+xiZiu/g5NrAHlN3d0fOULKSjGPSPz6VeXFU/0dVhBPO8NTE43LrHqlYTKXeh
    afJJqO3wd9lGiVU51Xn37q6Ee+wc0EYfcfv0D5E/gI2YUqeTi6WIgpXI7CA7BUtr
    tz5VkWpF4To4dgScT/AyDPx/8fwZ2O2RqDHuJX2k7vIeB8ZLEBTn6D2OjlaYccOm
    lrx1MQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfEyjzR+tEFhn85VxiXd7bjm9/AmT0UO15K6gqXt00/57DWG3aUpPctSpEHlvw8zM61WY0kq1f6ZGXQ3oPiZCgHdcoraXtbDbfT5u80PpXkrKYUL9mB9I
    5XrxHRROrWUMqtn8q1sQlFdL/Nc8H30vn/0z+M6xPCdfmrmWCQTURnuvcqT/Y1FOmD9yWnLvbWNUXAvLsGsdCZo5qnjAsGFcV8+rmVfX3YjnSaqJw9njjnLJ
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=h4d7X72yrffl6ku9K-wA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752227AbeEGPZi (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:25:38 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48574 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751860AbeEGPZi (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 11:25:38 -0400
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
Subject: [PATCH 4/5] arm64: allwinner: h6: add USB3 device nodes
Date: Mon,  7 May 2018 23:18:16 +0800
Message-Id: <20180507151817.55663-5-icenowy@aosc.io>
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allwinner H6 SoC features USB3 functionality, with a DWC3 controller and
a custom PHY.

Add device tree nodes for them.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 38 ++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index c72da8cd9ef5..9564c938717c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -174,6 +174,44 @@
 			status = "disabled";
 		};
 
+		usb3: usb@5200000 {
+			compatible = "allwinner,sun50i-h6-dwc3";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+			clocks = <&ccu CLK_BUS_XHCI>;
+			clock-names = "bus";
+			resets = <&ccu RST_BUS_XHCI>;
+			reset-names = "bus";
+			status = "disabled";
+
+			dwc3: dwc3 {
+				compatible = "snps,dwc3";
+				reg = <0x5200000 0x10000>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				/*
+				 * According to Wink from Allwinner, the
+				 * USB3 port on H6 is not capable of OTG;
+				 * the datasheet doesn't mention OTG at all
+				 * either, so the dr_mode is default to
+				 * "host" here.
+				 */
+				dr_mode = "host";
+				phys = <&usb3phy>;
+				phy-names = "usb3-phy";
+				status = "disabled";
+			};
+		};
+
+		usb3phy: phy@5210000 {
+			compatible = "allwinner,sun50i-h6-usb3-phy";
+			reg = <0x5210000 0x10000>;
+			clocks = <&ccu CLK_USB_PHY1>;
+			resets = <&ccu RST_USB_PHY1>;
+			#phy-cells = <0>;
+			status = "disabled";
+		};
+
 		r_ccu: clock@7010000 {
 			compatible = "allwinner,sun50i-h6-r-ccu";
 			reg = <0x07010000 0x400>;
-- 
2.17.0

