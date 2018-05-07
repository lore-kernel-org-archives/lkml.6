Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1216624-1525706871-2-354083602474095324
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
    1525706871; b=gD/EXDP8IowFRTOEhAdGm0FQwNX2vdEf1K+AsHMFjkuuhgNFyi
    9Oq0El3mId0FkC6XaS5U13ajk8qEd5Qa2REsgIHxVDil/w1kzAFaiBlu/nEKx4iF
    ZXObZWxoQgppLMymaXMlulGtQ/XoQAVtUdyCDjaUHHGHsqXpD9Xwj9gqfrRQKECg
    o9Sj3scUu/EOq7nX6P9WYsPM6lFrGaTbp6CS1x7hAVFfVkYF/2RgnS4d3eSEAu+w
    kLwhr6xxTnhFY8b/LQu9vrHxUqeQ+FjydsJlPZlJcHugJH6SVjxiXwOD+waz+luM
    +FAYwc04TjbsP0K3j6M1FCFP612H/54ppBVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525706871; bh=
    fYH3bFRFTDt2H9SUjCuxHl839IdPowdTQRjip40/dwY=; b=funQ38LPhlnvZOxW
    0grZJP9NBW/RtQtvNizOrZPAkPStDVeLIlJGSjqM0VGGNjF2JVJYR/CNexsIgCN0
    +iS1sLpYCQRs9Y1zV0EoGv6lyPSWSwU7FKq0FNtLiIYR/UoAZNgy7q2xF6FSNYis
    ykI/mIORCJPt5mAzL9nTLGzLp4MUBcIRq6kzDjYkY7r8OolBaM7E2djJyyYm08QX
    r836NnLF4z1qdk3/waiSSLfSabNwcFFS7GnZRLv8GQh2Bpm7NE+pg46bSaTP4+HF
    fgJB5qiRVZrDFoyzpkQyR1gj8vgb7ePeDpuh/0oC+lFuSIdDbJ54bnkAyOfwvBqI
    XqG7fg==
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
X-CM-Envelope: MS4wfOPJEqCFFLxaYE1zXFKmGpCL7x8yJAYq+abUYuuGAOyWXrdTjiliuXbRomdS9RnHlo+BBriXwU315oXjStF41VPrqg++Il0SXuP48VJQkg/FCAIBxzuV
    pcsOQ7N9x3lBKhzUv49/5SbupGV9tf4lf8izu5LQpn+2srMjr+umUIvTLw4AmT8gwaDcriOjwPn/cMkhmtXarJqLGNX9gbJUrEEQOH3ur/AcLms6tga106UR
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=nVfyDn07q3JEeB4pMtoA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752158AbeEGP1f (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 11:27:35 -0400
Received: from hermes.aosc.io ([199.195.250.187]:48658 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751926AbeEGP1e (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 7 May 2018 11:27:34 -0400
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
Subject: [PATCH 5/5] arm64: allwinner: h6: enable USB3 port on Pine H64
Date: Mon,  7 May 2018 23:18:17 +0800
Message-Id: <20180507151817.55663-6-icenowy@aosc.io>
In-Reply-To: <20180507151817.55663-1-icenowy@aosc.io>
References: <20180507151817.55663-1-icenowy@aosc.io>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pine H64 board have a USB3 port, which is connected to the USB3 pins of
the H6 SoC, and the 5V power supply is controlled via GPIO (shared with
the power USB ports).

Enable this port.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index b6f2d6b2ecae..e2e262b4e3d8 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -20,6 +20,20 @@
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	reg_usb_vbus: vbus {
+		compatible = "regulator-fixed";
+		regulator-name = "usb-vbus";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		startup-delay-us = <100000>;
+		gpio = <&r_pio 0 5 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&dwc3 {
+	status = "okay";
 };
 
 &r_i2c {
@@ -37,3 +51,12 @@
 	pinctrl-0 = <&uart0_ph_pins>;
 	status = "okay";
 };
+
+&usb3 {
+	status = "okay";
+};
+
+&usb3phy {
+	phy-supply = <&reg_usb_vbus>;
+	status = "okay";
+};
-- 
2.17.0

