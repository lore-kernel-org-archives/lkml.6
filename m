Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1146594-1518691294-2-4598089403748267613
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518691293; b=mD0eZhra+aOzaR8nl8MsABXnKXjtQX24gMZ+wk1So+6rzL/
    EywIkkfSp7pMGKKGuSa6FM5vl6e2sETcy/RuXdVpt7yUxyS1zrPaeERlYYrA47s5
    iRS7ocrZwFLLMMSChEsqyAhwseySbz0v2aCrOLE7ZaZYQ3FRA2UAZORRzxExmp5T
    5TByq6WyvNP0aiXvvJp3Ih9J/uFOvQj1CwXS2suK8teY5nXNYj6CE32G19l8dvOC
    x9TOT/G/5HmqemBqzkwP+EIXHd9BeGNxzFa+v4d6KIVyw+w6pDCQ4YuZGBYv0V7G
    1mUjnKtJVVb3Y0st1c9rkYBZDPPimWTRwxgqspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1518691293;
    bh=4F2U+m3NXPFsNBtB/Q3Ihy0M/EsFNWCJnTi9FGWFd4c=; b=g35anzjF7dCi
    sdbobbsq49DQgeWxygu0bDAb4l7BDR6RLmg2jAT3zeyfdp3gSOV3r8EOhIzQS5qh
    /pfECT8hXwYV6Vwq8W12B55JOtAe16/ohRHASqr85Hx3GELN/C2r711e34gG0Hnf
    hNbCP60DsB3Bg+v2LL6lKju0kp5FLpdAYctCESuYTjsnMdsJAUj2zXFq8kRHwe33
    888tlck9o3LqXHtiZinN/LywojlHA+XPP54dyVCnMpIp8B8fmM9EjwowwN2LnORH
    FzQlDFXBwZa9U1ocWFrOtVNkaArSV5H62iWJEo0jR5ifDqcfVccAKLHwGL1myqT6
    PZN7nQPW2w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=msfyYUN2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=msfyYUN2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755532AbeBOKlA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 05:41:00 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50940 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755366AbeBOKje (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 15 Feb 2018 05:39:34 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180215103932euoutp029f38bcd5c093c0ec94ad59ff6bd67712~TeZM05zAr1269312693euoutp02a
X-AuditID: cbfec7f4-b4fc79c0000043e4-d3-5a856361b2b3
From: Andrzej Hajda <a.hajda@samsung.com>
To: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS)
Cc: Andrzej Hajda <a.hajda@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH v2 4/6] arm64: dts: exynos: add OF graph between MHL and
 USB connector
Date: Thu, 15 Feb 2018 11:39:18 +0100
Message-id: <20180215103920.32017-5-a.hajda@samsung.com>
X-Mailer: git-send-email 2.16.1
In-reply-to: <20180215103920.32017-1-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSWUhUURjHPXd3auQwCh5MLAYqE3IJo1OaGUjeBx+ix8GWm95UmhllrktG
        2CSau6lpThYaNWqoLY4iMZjWaBoKjqYkSiohWQzuGlSo5e3q2+/7L+fjg8ORmmXKh0sypoom
        o6DXMiqqo++386gQl6sL/tLoiydfDtE4O3+Bxq2WVzQeX/9O47rebW3s5xKDK2bKKOx0vmZx
        QbmVxbbZzzQetT9msMXZReCnDbkkftE7xeL68REC577tZSMh31LbAvjR0hKCf5T/kOZtTQUM
        P1PUT/Bt1tt8aXsT4Ndsfuc5nSo8XtQnpYumoIgrqsTF7ntsyqbqRvdUCTCDKq4QuHMIhqLV
        STNRCFScBj4H6M68mVWGNYCWB+aI3ZRl8wFQjAaAOtd+7VT+blc6yyg5xcAjaLNtgpHZC15E
        i5/spBwi4TCFhgddrGx4wljUvjb0nyl4EL2r7tguc5waYtT19ZaybT/qmc+mZdkdnkSVdVh+
        BsEZBtXOVpBKJgpN5bWyCnsiV3/7Dvui0ftFlFIoAmigq4BUhkqAnK7RnXvCUE//CC0zCT1Q
        RUc1KW9DUI3y72qUCI/Ka38ART6LJqbPKAcXA7RRUkWUAZ8nwK0JeItpkiFBlI4ZxYxASTBI
        acaEwLhkgw1s/4PBrf71N8C+cdUBIAe0e9XB4Tk6DS2kS5kGB0AcqfVSr+hydRp1vJB5UzQl
        Xzal6UXJAfZxlNZbfck/S6eBCUKqeF0UU0TTrktw7j5mUFyzlbdnNse64hf9zPohKWQS2snY
        gENzeUz5hVCbIdLqMCx4Dx5YzJ5ujrhWGBUW1l4bNNHDnoiJWdWX/2k8V20bHzjt4aFy5ViW
        A7ho+8eIoeap0I0ON6Nfn2ryW02G1itlLvJ4Vv3hgFNzjrElf1v6+2CqLTFP42H26l5xaikp
        UQgJIE2S8A9joLaAAwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsVy+t/xq7rxya1RBleWqlncWneO1aKp4y2r
        xcYZ61ktrn95zmox/whQ7MrX92wWk+5PYLE4f34Du0XnxCXsFpseX2O1uLxrDpvFjPP7mCwW
        LWtltlh75C67xdLrF5ksWvceYXcQ8Fgzbw2jx+W+XiaP2R0zWT02repk87jffZzJY/OSeo++
        LasYPT5vkgvgiOKySUnNySxLLdK3S+DKeLe/n73gL1fF/ru9jA2MUzm6GDk5JARMJGb8ncYI
        YgsJLGGUuPLYqouRC8huZJI48b2PFSTBJqAp8XfzTTYQW0QgVuLtqc/MIEXMAhdYJH5PnMkO
        khAWiJHY8vkcmM0ioCpxYPo2li5GDg5eAQuJfQ9rIJbJSxx+08QKEuYUsJSYMt8CYq+FxMbJ
        81gnMPIsYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERiu24793LKDsetd8CFGAQ5GJR5e
        A5uWKCHWxLLiytxDjBIczEoivB+jWqOEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8543qIwSEkhP
        LEnNTk0tSC2CyTJxcEo1MM4Wt3m/4OBPh0M6nabJf4Rf39USruHSWF9/7rXqVNbsrwuSOD3V
        WvPWpX3hUJ3YHvXwkfA0oYBL7jPOHv4iF+b+deaEybWzRAJkbTcF3toYKv4mSGzBlNuPFr2T
        vXFyirSgjXilUe0J5Q2/fLfabZ3xgvlQmWXettP8Ns7m03O128oblTUu6iqxFGckGmoxFxUn
        AgBR5RgcUwIAAA==
X-CMS-MailID: 20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944
X-RootMTR: 20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944
References: <20180215103920.32017-1-a.hajda@samsung.com>
        <CGME20180215103927eucas1p24785b56277ed6c9fa2fd70058096b944@eucas1p2.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

OF graph describes MHL data lanes between MHL and respective USB
connector.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
---
 .../boot/dts/exynos/exynos5433-tm2-common.dtsi     | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
index 7e49fadee412..ef758f7337e9 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2-common.dtsi
@@ -779,9 +779,22 @@
 		clocks = <&pmu_system_controller 0>;
 		clock-names = "xtal";
 
-		port {
-			mhl_to_hdmi: endpoint {
-				remote-endpoint = <&hdmi_to_mhl>;
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				mhl_to_hdmi: endpoint {
+					remote-endpoint = <&hdmi_to_mhl>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				mhl_to_musb_con: endpoint {
+					remote-endpoint = <&musb_con_to_mhl>;
+				};
 			};
 		};
 	};
@@ -804,6 +817,18 @@
 					     "usb-b-connector";
 				label = "micro-USB";
 				type = "micro";
+
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@3 {
+						musb_con_to_mhl: endpoint {
+							remote-endpoint = <&mhl_to_musb_con>;
+						};
+					};
+				};
+			};
 			};
 		};
 
-- 
2.16.1

