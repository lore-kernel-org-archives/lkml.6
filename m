Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3440611-1521482954-2-16198376729269454374
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521482953; b=XGmhFsDEzA/sS+RfYc9Fro8yqTLEcaTrkW1025mneH4jv9A
    8lhBUdxe7pjydlsC+Ri8UVP9HXg3BzZHJa5YcMc8y9QkBbnc5ffamGHmL5HgIG4Z
    yZSm90tL6/w3CvSttofh+mdPDr2LfaVl9do26hmCq5buMHR268GW6xCxDSmv3Qak
    VUNFLrBrG6s6im4DKhje/Le/wZzeGBt0aS5HmyN2gtJzN6sFjXEOarKFfm7098Sf
    GC3/BDEAU4p6/ZmuAzyalhZ8iSJMl2Hx61XRf5fMggdaQzEWG1d5KADzuZLTRLHs
    21rkB9S4BfBx1ok8CPztCAA7hqgnV83c5AWGBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521482953; bh=cWgoy8qmmY2ms77RPe68MhUAWJ
    nasDvQyQyfwOx479k=; b=YunltM3t/brnr1P0cWwWM57JzIVJ4O0c+AvWGiGw30
    QidLHsUmhcDz4HWZI1Ev9Zv1mXbzCnnFmi3wRJ9p7RhdI9bJnN9R1h1GJX9ujb70
    2D87auLnfiDHOXN100UezrXR43LtMhFH/oVzqpozQdoGpRdXKoFA1rm/KQYTe+7F
    t/AcKDt4yg5AgLLNiwXZnyT9L5kxnPnU4IygcOxRPJbia6piNFIbHsEK40y+2sZO
    9KrgsIa81N+rcOyyYiytIDKEHsKcu3bAzMT97WeQyavrJoAaaX0gYjtWjXiiXLxv
    t7oKC2G4TYBpsyLkVAacKq9OWoHGD5C4Uh9EySqUZ1WA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegleduieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutdelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucfkphepvddtledrudefvddrudektddrieejpdeltddrledvrdeiuddrvddtvdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegleduieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933654AbeCSSJK (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:09:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968594AbeCSSJG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:09:06 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jonas Jensen <jonas.jensen@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 11/68] ARM: dts: Adjust moxart IRQ controller and flags
Date: Mon, 19 Mar 2018 19:05:49 +0100
Message-Id: <20180319171829.545765332@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171827.899658615@linuxfoundation.org>
References: <20180319171827.899658615@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Linus Walleij <linus.walleij@linaro.org>


[ Upstream commit c2a736b698008d296c5010ec39077eeb5796109f ]

The moxart interrupt line flags were not respected in previous
driver: instead of assigning them per-consumer, a fixes mask
was set in the controller.

With the migration to a standard Faraday driver we need to
set up and handle the consumer flags correctly. Also remove
the Moxart-specific flags when switching to using real consumer
flags.

Extend the register window to 0x100 bytes as we may have a few
more registers in there and it doesn't hurt.

Tested-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/moxart-uc7112lx.dts |    2 +-
 arch/arm/boot/dts/moxart.dtsi         |   17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -6,7 +6,7 @@
  */
 
 /dts-v1/;
-/include/ "moxart.dtsi"
+#include "moxart.dtsi"
 
 / {
 	model = "MOXA UC-7112-LX";
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -6,6 +6,7 @@
  */
 
 /include/ "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	compatible = "moxa,moxart";
@@ -36,8 +37,8 @@
 		ranges;
 
 		intc: interrupt-controller@98800000 {
-			compatible = "moxa,moxart-ic";
-			reg = <0x98800000 0x38>;
+			compatible = "moxa,moxart-ic", "faraday,ftintc010";
+			reg = <0x98800000 0x100>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			interrupt-mask = <0x00080000>;
@@ -59,7 +60,7 @@
 		timer: timer@98400000 {
 			compatible = "moxa,moxart-timer";
 			reg = <0x98400000 0x42>;
-			interrupts = <19 1>;
+			interrupts = <19 IRQ_TYPE_EDGE_FALLING>;
 			clocks = <&clk_apb>;
 		};
 
@@ -80,7 +81,7 @@
 		dma: dma@90500000 {
 			compatible = "moxa,moxart-dma";
 			reg = <0x90500080 0x40>;
-			interrupts = <24 0>;
+			interrupts = <24 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells = <1>;
 		};
 
@@ -93,7 +94,7 @@
 		sdhci: sdhci@98e00000 {
 			compatible = "moxa,moxart-sdhci";
 			reg = <0x98e00000 0x5C>;
-			interrupts = <5 0>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_apb>;
 			dmas =  <&dma 5>,
 				<&dma 5>;
@@ -120,7 +121,7 @@
 		mac0: mac@90900000 {
 			compatible = "moxa,moxart-mac";
 			reg = <0x90900000 0x90>;
-			interrupts = <25 0>;
+			interrupts = <25 IRQ_TYPE_LEVEL_HIGH>;
 			phy-handle = <&ethphy0>;
 			phy-mode = "mii";
 			status = "disabled";
@@ -129,7 +130,7 @@
 		mac1: mac@92000000 {
 			compatible = "moxa,moxart-mac";
 			reg = <0x92000000 0x90>;
-			interrupts = <27 0>;
+			interrupts = <27 IRQ_TYPE_LEVEL_HIGH>;
 			phy-handle = <&ethphy1>;
 			phy-mode = "mii";
 			status = "disabled";
@@ -138,7 +139,7 @@
 		uart0: uart@98200000 {
 			compatible = "ns16550a";
 			reg = <0x98200000 0x20>;
-			interrupts = <31 8>;
+			interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
 			clock-frequency = <14745600>;
