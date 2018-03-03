Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1310899-1520121499-5-7346980425328899463
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520121499; b=FyUBQgawp+DajXv3n6Umr1uQWG80QnES3iygqGoeYdwcamm
    fU3OFhmLWsvB0ecYmL35nDNbtxSC3IstDYvQsWYt3++g998haRObRvY+3i7w/5KW
    JMIhY7JGge/tIDfap+7lRuy+p67m9cpOs6pJRTUQ2A0D5MXV03TiG1f5bE0Cgyaa
    ts+EhJof3iFFkUHgdZKuUK/e4zLDXOS+Qs8ktqvDJfkeIBYLrxsY52u2iqbXE07y
    oDyhXHemVl+wv10kRY9sZYgdoYWpmSqIelfi6sZUbJJgjxf9lRIeqZ1y1H+SHM4b
    Aw2aQQ/0z+AfRCIc4Xf5ax+wDae7XYsrVjjk5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520121499; bh=PaKcdp
    bW1hbimSjbSQ7UnGN8UKdc3Pn8mV5cd4M3NUE=; b=HQcLFkWgvjkXoD5kvYm5B+
    z/sktguAwXbaHJ46pkRYhWVrlpjQ5rJGl5bxiGAfS3OrASNsfdqc2W3h+q8TXe+X
    ZWeGH3aLtC5OskFh7Yv7kai8rkTfvg7ckaS+k9+7AEfkgE+OY805zyv7xtZ99XdG
    eFmBa/MhX0CrH65XokjCbprCYDm7eWVjnnhXfjFtTk37CP76YtsOJQ+Zzzo9rQUe
    pY2WpX07XCkT64TW+lTO+Wh5CI4fijw5WLMYY+Bl4GLo3zPPp2hK2KlFfuz5BxDY
    Xf/UHSq4R0dGbhpRt9YDl8K0LLPFPWcJZV84d7+XGEozXSrcYjQvaw8rm3uhHJyQ
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jQc1mQbV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jQc1mQbV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751340AbeCCX5n (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:57:43 -0500
Received: from mail-cys01nam02on0103.outbound.protection.outlook.com ([104.47.37.103]:36864
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932956AbeCCWcY (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:32:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Olof Johansson <olof@lixom.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 047/219] ARM: dts: Adjust moxart IRQ
 controller and flags
Thread-Topic: [PATCH AUTOSEL for 4.9 047/219] ARM: dts: Adjust moxart IRQ
 controller and flags
Thread-Index: AQHTsz7wFh3llONr80ekphJAddoJeQ==
Date: Sat, 3 Mar 2018 22:28:23 +0000
Message-ID: <20180303222716.26640-47-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1098;7:jz4hmdNd3eFVUuIYSwcRJK83T8HZvjzAUlRV/S5+mZCAwMN3/LbpDzFkk80nOLIgxZRr/JIr8VNNvPIqWd6qg1EbZpEkieDVZVsDPsqTFmXbuMZNN/xf/ZfIlZ9mtOlvP/YsT/FrhoQQxnuLS6yvilbC11kv7iXuZOkKZ/gL0GBAL4lyaEC0PmAyLa9FSFCJsZ7eVWMhnbHTv5af8Pcl0bLFZlvFdhuTtaiJlvidj4wc1/sCIilpdlCUQ3F6UGI9
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04a0d59c-b9ce-46d7-6556-08d581569912
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1098;
x-ms-traffictypediagnostic: MW2PR2101MB1098:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB109827C5FAA65FA0F20913ECFBC40@MW2PR2101MB1098.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1098;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1098;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(39380400002)(366004)(396003)(346002)(199004)(189003)(2906002)(8936002)(36756003)(6512007)(81156014)(10290500003)(81166006)(99286004)(6436002)(68736007)(39060400002)(478600001)(3846002)(22452003)(53936002)(8676002)(110136005)(54906003)(4326008)(316002)(76176011)(6116002)(7736002)(105586002)(305945005)(3660700001)(1076002)(14454004)(97736004)(575784001)(25786009)(186003)(72206003)(26005)(102836004)(86362001)(6666003)(2501003)(3280700002)(6506007)(5660300001)(10090500001)(59450400001)(66066001)(106356001)(5250100002)(2900100001)(2950100002)(86612001)(6486002)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1098;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: el77+gPVUxOKtv+dkMHBSiNBW4NeJqYFiePta0taE/8QibvxiCDVxtKd8m3eoSzu7TD7w6+qGpRsReyCQs0eV2FE09J7X0TWTpYJKKtqz0bfaqvfsjnDberCVX6vMjfUIzWWLA9/RGDp7GaYCM3Ru7Rriy7t/G57Styq9N3FcQw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a0d59c-b9ce-46d7-6556-08d581569912
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:23.3069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1098
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
---
 arch/arm/boot/dts/moxart-uc7112lx.dts |  2 +-
 arch/arm/boot/dts/moxart.dtsi         | 17 +++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/moxart-uc7112lx.dts b/arch/arm/boot/dts/moxa=
rt-uc7112lx.dts
index 10d088df0c35..4a962a26482d 100644
--- a/arch/arm/boot/dts/moxart-uc7112lx.dts
+++ b/arch/arm/boot/dts/moxart-uc7112lx.dts
@@ -6,7 +6,7 @@
  */
=20
 /dts-v1/;
-/include/ "moxart.dtsi"
+#include "moxart.dtsi"
=20
 / {
 	model =3D "MOXA UC-7112-LX";
diff --git a/arch/arm/boot/dts/moxart.dtsi b/arch/arm/boot/dts/moxart.dtsi
index 1fd27ed65a01..64f2f44235d0 100644
--- a/arch/arm/boot/dts/moxart.dtsi
+++ b/arch/arm/boot/dts/moxart.dtsi
@@ -6,6 +6,7 @@
  */
=20
 /include/ "skeleton.dtsi"
+#include <dt-bindings/interrupt-controller/irq.h>
=20
 / {
 	compatible =3D "moxa,moxart";
@@ -36,8 +37,8 @@
 		ranges;
=20
 		intc: interrupt-controller@98800000 {
-			compatible =3D "moxa,moxart-ic";
-			reg =3D <0x98800000 0x38>;
+			compatible =3D "moxa,moxart-ic", "faraday,ftintc010";
+			reg =3D <0x98800000 0x100>;
 			interrupt-controller;
 			#interrupt-cells =3D <2>;
 			interrupt-mask =3D <0x00080000>;
@@ -59,7 +60,7 @@
 		timer: timer@98400000 {
 			compatible =3D "moxa,moxart-timer";
 			reg =3D <0x98400000 0x42>;
-			interrupts =3D <19 1>;
+			interrupts =3D <19 IRQ_TYPE_EDGE_FALLING>;
 			clocks =3D <&clk_apb>;
 		};
=20
@@ -80,7 +81,7 @@
 		dma: dma@90500000 {
 			compatible =3D "moxa,moxart-dma";
 			reg =3D <0x90500080 0x40>;
-			interrupts =3D <24 0>;
+			interrupts =3D <24 IRQ_TYPE_LEVEL_HIGH>;
 			#dma-cells =3D <1>;
 		};
=20
@@ -93,7 +94,7 @@
 		sdhci: sdhci@98e00000 {
 			compatible =3D "moxa,moxart-sdhci";
 			reg =3D <0x98e00000 0x5C>;
-			interrupts =3D <5 0>;
+			interrupts =3D <5 IRQ_TYPE_LEVEL_HIGH>;
 			clocks =3D <&clk_apb>;
 			dmas =3D  <&dma 5>,
 				<&dma 5>;
@@ -120,7 +121,7 @@
 		mac0: mac@90900000 {
 			compatible =3D "moxa,moxart-mac";
 			reg =3D <0x90900000 0x90>;
-			interrupts =3D <25 0>;
+			interrupts =3D <25 IRQ_TYPE_LEVEL_HIGH>;
 			phy-handle =3D <&ethphy0>;
 			phy-mode =3D "mii";
 			status =3D "disabled";
@@ -129,7 +130,7 @@
 		mac1: mac@92000000 {
 			compatible =3D "moxa,moxart-mac";
 			reg =3D <0x92000000 0x90>;
-			interrupts =3D <27 0>;
+			interrupts =3D <27 IRQ_TYPE_LEVEL_HIGH>;
 			phy-handle =3D <&ethphy1>;
 			phy-mode =3D "mii";
 			status =3D "disabled";
@@ -138,7 +139,7 @@
 		uart0: uart@98200000 {
 			compatible =3D "ns16550a";
 			reg =3D <0x98200000 0x20>;
-			interrupts =3D <31 8>;
+			interrupts =3D <31 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift =3D <2>;
 			reg-io-width =3D <4>;
 			clock-frequency =3D <14745600>;
--=20
2.14.1
