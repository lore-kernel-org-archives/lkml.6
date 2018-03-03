Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1204544-1520118056-2-11098253853101792559
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
    t=1520118055; b=Vitbt5TY7/k8jN22YOe10ewqfgn9fgBC4wI38Zmi1GHD7wE
    VHhmerEyx2sTVx29w37aPhLFxeUH7LEa/n3olpfaVYua1O1QDIvOPcmflcHMfUMo
    M405tvdYg+Vs0QJ+BgkoCjMzu6lT6ZEIZr92kLlmKkm5Yv5SkqX+UOQVvWwPw5Ir
    frMNNlEZs3C6TUcafAQrFsCEWweL9LMEPvICWGYZ7goEwHYN6X7qp49qVBtGZmpU
    hvSPvMiTZgdoEPo4cvjbKH+SV5+GSpjcjirHpJEB7ehvi+YxTECqte7o0WdZDNT6
    zDU25JlkOheXD3Y1Tl97NhmWCaJWPj7Ra7gX3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520118055; bh=RC4ybO
    3ZYIGdhueoVYNSK322hzh5yN/XcrutaXWhO5w=; b=kPMH4WASBiC6b5L96cBa2I
    hIjkD6W4EX3APBCxz0Q3R9Rb9WRcRYHfDrHWQ1hZ0Yc3Pd/Ft45hRg+7Y/ueAOpW
    fc9pe2zUzPPJ8dqMIi5BjzYWeCaSdIohVX9r3+U6PwjEqT3mykn0+lw55w6cfhh0
    4oCno6IdPhVcyTzp0kFwtis7J3pzqHngyFslyCq9A8FqYDqYDyRAtWlWj2F9bALM
    hCJGUCXo/zWAmkgv32zOD4s2XuqQOAdS2eAyEXh5Gm9AAIEZbnj1vYIUchbJy9Gt
    imTry4IT0XKsZ8nLwcSgjfxXSIda2cwhzJ0uTSA1cgkUntV6zwwMdtowdvRDy6DQ
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hHRKyFjF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hHRKyFjF x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935117AbeCCWku (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:40:50 -0500
Received: from mail-co1nam03on0111.outbound.protection.outlook.com ([104.47.40.111]:9680
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934394AbeCCWkr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:40:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 094/115] ARM: dts: omap3-n900: Fix the audio
 CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.4 094/115] ARM: dts: omap3-n900: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz9ppvdUZ2tpXk6HpvtmmVhQhQ==
Date: Sat, 3 Mar 2018 22:31:45 +0000
Message-ID: <20180303223010.27106-94-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0939;7:kPu4D77PnWExnGwrSdwWE/9hdW1OhvBDh+wp5MUOp1P3H/iI5oB55aGz5oNUDi5WMvtdbwYTEHTNADvw5J3k69CK+3TBheBBguf9fFveB8GRkTcUDCjze2RgiJ3Hfnn8JWGyRbfFM5wrS0y/JaTxN+xUzkTfnFgvHnFlkNxGuhulck6a0f1v6jP7f65lMCLmjHjE0obvkF2KhdaaNap7wnzj3A9FBkCHv8l1eY8yJuWVlI+3MjVxqd3LvupJNVYw
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1a285111-8ac4-4319-4efc-08d58157ccb6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB0939;
x-ms-traffictypediagnostic: MW2PR2101MB0939:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0939FF3C61623C7283BFC66BFBC40@MW2PR2101MB0939.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0939;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0939;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39380400002)(39860400002)(189003)(199004)(86612001)(76176011)(478600001)(81166006)(81156014)(72206003)(5660300001)(8936002)(25786009)(59450400001)(26005)(6506007)(102836004)(316002)(22452003)(6486002)(8676002)(14454004)(4326008)(6436002)(107886003)(10090500001)(6512007)(53936002)(36756003)(10290500003)(86362001)(2900100001)(3660700001)(305945005)(2950100002)(5250100002)(99286004)(3280700002)(97736004)(54906003)(110136005)(2501003)(186003)(106356001)(7736002)(66066001)(3846002)(2906002)(6116002)(105586002)(68736007)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0939;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: pTcj7fG2XWRNVSE3O3Nk7jgSxwQTppupbX+LoTBRvv37wmYofdpYJu809kGMn3cFF5gyaXsHWht8mzjIUEDtURvHZmsDWx42CgHNrUl/Rmdr+QO3avAGI3EuZ5UAUBqbeiwsyHg/O8x/LDWycihkw11pFEjl04o+4wXhCTq2i6E=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a285111-8ac4-4319-4efc-08d58157ccb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:31:45.7145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0939
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
index 27cd4abfc74d..731860314ab5 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -488,7 +488,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible =3D "ti,tlv320aic3x";
 		reg =3D <0x18>;
-		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func =3D <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -505,7 +505,7 @@
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
