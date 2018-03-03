Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1254417-1520119789-2-18173838493896791107
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
    t=1520119789; b=i1ZhcGp2UViiFkFrrKR/KWcKojT9Wp2sRF4JzQnWTzMQcBf
    QdqYLSw4P73QNW3CN4ApKR2B5a1EJ3V8ByMTFFhg19XOdUiOWYJmW4w9GnGtCKHd
    CiwLHr76NJk9SfbAvaOkZ0qBiWCldRkVp20e530WSpsz2qKQlG6qx2EIDYOf/stO
    NXWA21mHKqg3MRYn105LxeLAIultfBX+kttY6uQLPEWFbd1XRMmf14DAx5v+IUwU
    lO6KgTzCPmmjmLJAf32cTXIPuqqKs0h7KVgvIMEmEny+7Zlr+b2oCeLLWCa6ODjl
    X0UmN8+Q2LHRQeFyG0b8b272xg+z3yRAzySLSLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520119789; bh=tepF3N
    5Acvpgio5j3j9pbBzn9WwcYg95/30lwtLCJm8=; b=tkN5rwennQqdWZTk/97Mt4
    EZOXjSaFcADN9rraDAlz11oUnIk5kxC6kxMqVbl015ZAStgmw7ph9l1ws0O3wqvj
    AIDbOLxyHuInK0UqmMyqd/HkQbVBE2vnxmlrO13r6L+sOqCLNRali6fLcFhlFHqk
    +yvcE8P5b3QoXIz4tYEo79PFJ9Dx4j0s0AT+kU+4eeOdJW7hqAh4re01F2VaJTDC
    c+aISds48ALQIk0Ux34VzIqDCVGuH8/QaH7NaHwDX9oru4V846uTKnP+fSnrg0KT
    mSlRTU+OAWBEkoTejxzS/4uFj+WlesF2kJd+VtgHIYJjQGxLJ2gtBDXPdrjyDe/Q
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RupO2Vak x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=RupO2Vak x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeCCX3R (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 18:29:17 -0500
Received: from mail-bn3nam01on0115.outbound.protection.outlook.com ([104.47.33.115]:41088
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932649AbeCCWgr (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:36:47 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 186/219] ARM: dts: omap3-n900: Fix the audio
 CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.9 186/219] ARM: dts: omap3-n900: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz8hTZ6DFiyxg0uxFxlct+CRTg==
Date: Sat, 3 Mar 2018 22:29:45 +0000
Message-ID: <20180303222716.26640-186-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1020;6:y9uipNF2ulmMbnd7xyGraqQm9IS0dha6mURjspakxKQSswFPYPKjg3fiXmldH3N0v32HACr/MTNGia6z2b7v0YnFCR+JKxnN0ghfXxUewzvHnH0wSOQmNrReEUuE7UHKyf04+URdGpmihNvSTWsrzz3C1DNmSebWwm7kfb4e9U6X6ft5zsPNXiVq35H+DrY/NBQ7OefhyfOhOpeHR4+qgxW9LMQ1tXA2lVIyqDoYk4hGrQFM0tIw6zxZZwnYkCcvUq1LMzcdFqgiLb7sOcSry69lD9Ovi9n4Sn2ZWUg21wWlOO9qn7jd5emS8/H+v4BjyFhdgweDemtWAHq8V4A3YBUTinU5Q6EvQ7F76KhucQwQduqnCC3uW3D7LHbFkVy+;5:ocmxTm7VVH2N6o/o6SRyyCzwgWcYoE7lFPYawlYMKcPQOhLTNBUcnpnRkGkB4EzOK+ykZcZMDrKyYpdj0y7QlrVCZnm9rNzkLndXQgGN93EtNPgDRav8hPtsoA39AOvwRWOT5RCrVwm9Y/v/6/hYDbHUX9VSWV2SYRndnbHgmuI=;24:PTPlIWAD0/RcST+lnWj5G4caRkhEKAlFSQ/sdA+vFHW/M+xNkhgJWpE9UupRh+YVZ/InFgdgl6HfGAB4/MYycZZu3djZyOrEIIzF+j3k6tA=;7:GwZJ4noLDY2G6lbAG0/rnoNfFx2QSzZSYC91qCJrv6GvxgDeIwQMVoTy9Aquaek/miZLN5/cbZ5hLqjVR1VHLHTpSpeQW0lRLmft8qxwMVa3PKDEwmAsSd/WktSPtEX+9NbYm1V/6fpULEl0dcg13JPfSFnGmGAOw6lmAVD2DvKxK2EGj8phAeNRXeFKwP82PqYcWqY3Yj2taNGncr51jfxGbtvwy791Aeu/BfxN80zJvti4zgXs2aRkH+zb5jLM
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 394f04ac-ab1d-41da-f1ae-08d581573cd6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1020;
x-ms-traffictypediagnostic: MW2PR2101MB1020:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1020BE2D5FB7D2AF5EA6AED4FBC40@MW2PR2101MB1020.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1020;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1020;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(366004)(346002)(376002)(39860400002)(199004)(189003)(6436002)(5250100002)(99286004)(3846002)(6116002)(8936002)(22452003)(86612001)(86362001)(575784001)(4326008)(10090500001)(68736007)(6512007)(7736002)(97736004)(25786009)(76176011)(1076002)(6486002)(2501003)(66066001)(36756003)(107886003)(2950100002)(8676002)(305945005)(5660300001)(105586002)(53936002)(3280700002)(81166006)(6506007)(106356001)(2906002)(81156014)(316002)(478600001)(72206003)(10290500003)(2900100001)(54906003)(110136005)(59450400001)(186003)(102836004)(26005)(14454004)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1020;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: p1ZsLxGBbBWcL8UScsJYNpOXAirrGu4iIR5rQHl1JhoWAJQQoxwuRoEpFdxTkZaQXexnXukY62nny58Nq0+PObgxT+5JjvQWV0oh6mivzQVklWDcO8uwe4WkqAfJbV8gRL/hnlosanej1YEDsaPXGuPZ84XN2HMB8MdZn81vuD8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394f04ac-ab1d-41da-f1ae-08d581573cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:29:45.4320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1020
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
index 4d448f145ed1..6003b29c0fc0 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -510,7 +510,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible =3D "ti,tlv320aic3x";
 		reg =3D <0x18>;
-		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func =3D <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -527,7 +527,7 @@
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
