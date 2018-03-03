Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520117236-2-5587191628738410516
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
    t=1520117235; b=EVsrYisYKJN5AQOXrY3dt5lY4R7jNt8fdg/tCjSSbGCUTXb
    X9NSlw1XRH4E50SWpuHhWD8OiL/9uoPzH6ZWlCExbPV7/OXEuMuTTJIwtnq6rwly
    SqLlLp6gkJQydxMBCfofof+VvGjXC7PChxzuxeUhyo8oQyDgXitTl9sy9jSfFMOi
    cLLwNx0O5g00WrEMlFesa7qEMvRUCd0vIuRtCRWN4XxeE3ZRLqzlYsXsjiiNcdb0
    xXG65YDdu4/AROjw0TgldElOvzeO3Qjeo+Iw50aIAq5tqiF9DG7uektgKZ4rTrF6
    CssDiwSVwnJ8ERsPp71kglCAAu/Y49rXCg/+09A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520117235; bh=NEnTOr
    EzApyY7g9zRGCu7uBqrgVWQI/5IMMKlFzomXs=; b=PoGEZYvnbKzT29zHj7wEIN
    usl8/NC0xEaSp4cYJLE4CbAXggbzZdVtAoQgXvmJoJS3gTomf5tR4Ag4hL3ORmie
    A+j5h32ipy82XMrsPcYN9AobEDuu2CZmAqRX7azvm5VYc4vZRHSX5ktFc9hHKttu
    cTbjoXc3l3XKEoV16ICs6YtSGHBGPo0frqg6x3ui4N0U4QKAJaaKA/Oi/Rj57Rtw
    oA/h3qJNHnbVkwiUgomghlwOpsg3aRhRiAB4KL7ENW4EMmzoxP7VEsoBufLptLqq
    eVHjVIFBE7YEbjMN9qv2Z+NAx3AMWNFAStV8TO6fTbtgZ/Meb9tXUBugERg3inPA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aahWfN8T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=aahWfN8T x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeCCWpJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:45:09 -0500
Received: from mail-co1nam03on0134.outbound.protection.outlook.com ([104.47.40.134]:59904
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935573AbeCCWl7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:41:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 52/63] ARM: dts: omap3-n900: Fix the audio
 CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 3.18 52/63] ARM: dts: omap3-n900: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz+uFoio9RFDoUiZ+dVfveCKjw==
Date: Sat, 3 Mar 2018 22:33:41 +0000
Message-ID: <20180303223228.27323-52-alexander.levin@microsoft.com>
References: <20180303223228.27323-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223228.27323-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1018;7:U1J9rrm2Tq3818/17rVqf4S2ffGmZ648H9ITLYCiHdw1qe1BhHlSIlBmcGmqtyFnpqEoqxNrG0nX174kkfPRFiwsBC4S2iymuGPlR44cv5uVF32yfFbqcVcmJOHBiWTrmM2J/PwQoIbbhzGBAyRTfzHexi9cBDCbqEKiANdRHOFSvg/iTOJeqGtMZ0QZiNZH6Pr4EEk9VVnyBBqD2zoL1ZqI1gYAEhMlj7txLcz9z9imnclchhvvtbaV4ff1dGuY
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 60b17ad0-d2ee-49ce-90f7-08d58157f7f6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7193020);SRVR:MW2PR2101MB1018;
x-ms-traffictypediagnostic: MW2PR2101MB1018:
x-microsoft-antispam-prvs: <MW2PR2101MB1018E9B3A73A6BDC5F589DAAFBC40@MW2PR2101MB1018.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1018;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1018;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(39860400002)(39380400002)(366004)(346002)(199004)(189003)(26005)(25786009)(3280700002)(10290500003)(4326008)(107886003)(81156014)(5660300001)(8676002)(6512007)(2950100002)(59450400001)(305945005)(97736004)(186003)(54906003)(6436002)(7736002)(72206003)(76176011)(6506007)(106356001)(110136005)(575784001)(86362001)(102836004)(6486002)(66066001)(36756003)(6116002)(3846002)(14454004)(6666003)(105586002)(99286004)(478600001)(1076002)(3660700001)(2906002)(10090500001)(86612001)(5250100002)(81166006)(6346003)(2900100001)(68736007)(2501003)(8936002)(316002)(53936002)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1018;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: shXy1OGR/tMRgaVQxoF7TmiEBjlxVMSvhH+WtYi1WKY7lB85zzCJTYzfboJaN6Q9KXpOb+XCzQtG9IouyyQiQ77U+KLiriq7VlC0vniJ1znIOGSo8xinwnsYCP/trzLsPX+h22Xhpxmy3Sbwt/sPwB9Oyno4HUWa7hxW4GLdObs=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b17ad0-d2ee-49ce-90f7-08d58157f7f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:33:41.8886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1018
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
index 6e1cea55d0ec..70bb75ec9c7d 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -435,7 +435,7 @@
 	tlv320aic3x: tlv320aic3x@18 {
 		compatible =3D "ti,tlv320aic3x";
 		reg =3D <0x18>;
-		gpio-reset =3D <&gpio2 28 GPIO_ACTIVE_HIGH>; /* 60 */
+		reset-gpios =3D <&gpio2 28 GPIO_ACTIVE_LOW>; /* 60 */
 		ai3x-gpio-func =3D <
 			0 /* AIC3X_GPIO1_FUNC_DISABLED */
 			5 /* AIC3X_GPIO2_FUNC_DIGITAL_MIC_INPUT */
@@ -452,7 +452,7 @@
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
