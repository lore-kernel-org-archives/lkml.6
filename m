Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2654392-1519381280-2-14418417933901603980
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001,
  LANGUAGES ensvro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519381279; b=KAXxLN8kux+0zVCVd+Y9Sn0wiHp+zZoHd7QreHJIuvzmxSc
    aq4n28xSgKzpW9BehkhwEhgpnSxJu/IjaWOFUXjEKa1onuuZHi1pZmFOtgLzI+SG
    6tiDlW2BpbSOiEnB7IUyWaGk4HqPAHAHiXmc+uXmDwxA9SBEl7wCEttIwk/l2vsT
    6InUitRVBhsq6gehGfpSlhCnEPGIHGJTxkjXJrdSRGr5bv/XrEh17Jk81zE3VJM7
    qzyNhEO6FnSHZPQbln3V/Nau0IX/NJRBTrr17tFBzApgG6ddknA9+3tJI+w2fkk5
    hu5MaQ9gbAmPAwchQFK+lqP2FmCLHn7ENUcP7Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519381279; bh=QcZMIZehtzdncqnY7bsmB7kr/p
    U+mYMawR9fTuZR5Xk=; b=j9Qy/0hjbHzWj/d3ExHgiDz4kxXMydi9S21+bFDPPX
    Qbcthke+MCWyl4DPfjmmbDH/urJwhX/f+qTXRMdra0OC1Mi386G8FrwA93aHkpYX
    SGx3VpJc252+YL++Bpc/v2EYMN2+GNnjF5MZEiIwCMrZF4gASpLTeoCp5HfP4Ufm
    pLCUJv/6jeGCejvr/OTwUS5KBWuRl04bIJUijIbxg3c4h+GzMSlM8i/Nl90D5iMA
    DQ6TPzdkaL3EYIb8UwKBijr6vw1Fa/AQm2euCyWgBqvqXDNOLLdNZSYlAIq1yE/l
    kEXRvlI9d/2kUcomOffH63+ybLVH1mSmkVRUt9mZocJg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=mediatek.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeBWKUl (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 05:20:41 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:59743 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751430AbeBWKQy (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 05:16:54 -0500
X-UUID: 45d2a05a60c9416f8f15ce30672286be-20180223
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <matthias.bgg@gmail.com>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
CC: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v1 06/19] arm: dts: mt7623: fix USB initialization fails on bananapi-r2
Date: Fri, 23 Feb 2018 18:16:26 +0800
Message-ID: <bcb9dbeb1389e71f4eaba0c2def1c991703e10c4.1519378872.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1519378871.git.sean.wang@mediatek.com>
References: <cover.1519378871.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sean Wang <sean.wang@mediatek.com>

Fix that USB initialization fails as below runtime log is present during
booting on bananapi-r2 board by adding missing regulators the USB device
requires. Current regulators USB device uses are being updated with the
correct ones to reflect real configurations which are all from fixed
regulators rather than MT6323 one's output.

[    6.473958] xhci-mtk 1a1c0000.usb: fail to get vbus
[    6.479313] xhci-mtk 1a240000.usb: fail to get vbus

Cc: stable@vger.kernel.org
Fixes: f4ff257cd160 ("arm: dts: mt7623: add support for Bananapi R2 (BPI-R2) board")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
index ec11e14..f660d15 100644
--- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
+++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
@@ -39,6 +39,24 @@
 		};
 	};
 
+	reg_3p3v: regulator-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_5v: regulator-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-5V";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	gpio_keys {
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
@@ -502,12 +520,14 @@
 };
 
 &usb1 {
-	vusb33-supply = <&mt6323_vusb_reg>;
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
 	status = "okay";
 };
 
 &usb2 {
-	vusb33-supply = <&mt6323_vusb_reg>;
+	vusb33-supply = <&reg_3p3v>;
+	vbus-supply = <&reg_5v>;
 	status = "okay";
 };
 
-- 
2.7.4
