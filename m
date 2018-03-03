Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520122997-2-9688868578180188509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520122996; b=gHDuKIqrIm7kMXwmGS6KkRzMEWPc1LGBh3euGC4t6gDgfvp
    bIDM0gQLmEQeULsoenks3+WX/+3j5hNfnmwNaZOt7wcZSyTq1RcRjSWIYk+/CYn6
    oVgdiKxPljt8uCTXp532n1kHWuJwhK/zV9f27re28cUjZhEBPiPSqTkVN9aCjEIL
    2QJ8peaTSfS8cO8y8lIfu2urRn7PeH2GsIkAexNQXCkS0SNVQHq9hDfspx0e0HFu
    yACvxmMsvI88u+udYvgBXbl99Q2ldzdASOPdcg9tjROEcu319B7miYYU53XM24yO
    0Fy6B4dklIHuEjg3zjlCI8T3nUGbvB63q0Qzodg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520122996; bh=nyQDXH
    gxQAJ9wsY+cSa7Xtnf2IjMv6jqLHRb+fsYcjQ=; b=JqKXFQQ6T4LtEe02Njiig6
    DCNEQy/Htq8GqOBOz6YDVbK0kXVMTkbsexYtuwcfOfWPI70sTbqYfr0vIv9JbTkq
    Wr1Odcq6c6JOe4LByxNRKjcy3DeE+KtxCgwKR/Hf7L0h+IcEf0VA/AfqMPDUsXyu
    6zrylE9t77CIJ0QFk7eysPi7fwynGE3SIjF6rLwC6zFf45No160xSIGGsVZXmS6M
    qgWERXNR3Rcot68avVVcn8QjRWc1I9OQthugKGRBSiGD258415Npj+PzgL6rmhhf
    HUiGvseV5ybU8xUllgkphdilcjgI9IlOLp3VFFWEZEVuBa+Gf8ZitKGRZrzerHgg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lT6wGqcp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lT6wGqcp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933249AbeCDAWv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:22:51 -0500
Received: from mail-sn1nam01on0095.outbound.protection.outlook.com ([104.47.32.95]:42182
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933234AbeCCW2Y (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:24 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 26/84] ARM: dts: omap3-n900: Fix the audio
 CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.14 26/84] ARM: dts: omap3-n900: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz6kPfQy/jBQUE2s0fdPjzkhrA==
Date: Sat, 3 Mar 2018 22:26:15 +0000
Message-ID: <20180303222518.26271-26-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1115;7:MWCCAFQKAIwpVxBLc+njd4NC4MOKmgoWs20ZBf+99i45UtAbVi79jBkDNIGR6H/beCa8JY3d1iCcZOul1hiNOYfDzJYOw9KBcYr4fFuKk6HBagfpYqWb4XCMt+K1wRfu2AjaNv07+zLL19NHtkQc5ElSFgLrJH81GE1Vzi0W/3z1L/J+m+RmEYST6f5k58KajEWmIOxY8Y/mEFLHmR3nBJK0n9hSIg8zYpPIKIp/C0EUuTkr6chfZqLMUnbzoj/l
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17e70b91-e8ea-4c0e-0ddc-08d581561157
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1115;
x-ms-traffictypediagnostic: MW2PR2101MB1115:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1115EC4FB4BEC98CC72FC1EDFBC40@MW2PR2101MB1115.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(3231220)(944501244)(52105095)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1115;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1115;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39860400002)(346002)(366004)(39380400002)(189003)(199004)(26005)(97736004)(186003)(2900100001)(316002)(59450400001)(6506007)(102836004)(36756003)(110136005)(106356001)(54906003)(72206003)(4326008)(8676002)(81156014)(25786009)(2950100002)(6666003)(305945005)(10290500003)(5660300001)(107886003)(14454004)(8936002)(3660700001)(3280700002)(105586002)(81166006)(478600001)(2906002)(6116002)(3846002)(1076002)(2501003)(6436002)(5250100002)(6486002)(68736007)(7736002)(10090500001)(6512007)(66066001)(53936002)(99286004)(86612001)(76176011)(22452003)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1115;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: +0+ghYhZc3uzgwWsfq9B1CGH9VzQ/7Az2YZaTAiUJIUljs0pspyKg+a6+4gnaoDmCIeTptinoIp8lRp8uoOb8e1n3R1hpDHJ+7Ycw5YsqXJHTRfsXfPLcjYfNEVdOWOiLTbs7IKYVLr1XA1Dar98f3toFOhNAbRJZCnPedTlJJY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e70b91-e8ea-4c0e-0ddc-08d581561157
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:15.0879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1115
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Andrew F. Davis" <afd@ti.com>

[ Upstream commit 7be4b5dc7ffa9499ac6ef33a5ffa9ff43f9b7057 ]

The correct DT property for specifying a GPIO used for reset
is "reset-gpios", fix this here.

Fixes: 14e3e295b2b9 ("ARM: dts: omap3-n900: Add TLV320AIC3X support")

Signed-off-by: Andrew F. Davis <afd@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm/boot/dts/omap3-n900.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n90=
0.dts
index 4acd32a1c4ef..c66ee8432a85 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -558,7 +558,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible =3D "ti,tlv320aic3x";
 		reg =3D <0x18>;
-		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func =3D <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -575,7 +575,7 @@
 	tlv320aic3x_aux: tlv320aic3x@19 {
 		compatible =3D "ti,tlv320aic3x";
 		reg =3D <0x19>;
-		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
=20
 		AVDD-supply =3D <&vmmc2>;
 		DRVDD-supply =3D <&vmmc2>;
--=20
2.14.1
