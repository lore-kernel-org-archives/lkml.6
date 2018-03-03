Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124303-5-6559221681543783571
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
    t=1520124302; b=dQy55LXfdabZGS0fq7lCocZytd1z7H53nr5mj5X8uvsaaKV
    1hV9wEzv9qGw38XQlzdK7uI7v94TBKXsZCzN+mmWncvezecgRcCabCARmS2jRWRG
    lMSJ4ZrfBgPbKlxd7crDSnXBQG0Z0hU/ZGZiK47v7UN9iC8gplZuZrAsHYARkb1r
    Sgklno/tPOZIJYTBy98Aq3v4ND4zi71E+1iBxd41c3CmL0IZQJWgxLlgSognNfN7
    q5+mrcHVBmNJUILil40BdTPH8jrJJ9b2Ct+BLZzjTSNaQUvN6N6l815LLTslynNj
    ZRhZx0YqLsxup150aKNmbybiXilYOZDRi5z3Raw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124302; bh=tEUM7s
    UO34vp7jMZDgZUZY1S6cGWRsqwrAwh2wuGLDY=; b=Oky+GFNPjJG5t7BYyZ2c4M
    k8cz6T4mixWg/mDDy6c5mZqZUN8EBNZNqJmgPVusHaSTHjfLtJx1LQeOqBOzkZpP
    QsKirVEZpaVtD420MGmgZtdBpWujVtJ0Ayjbdx4A9UsPfHe03XTZz+lyZlwvbDSd
    3hXJ9cuxGfd1U9Oi+ePjnt8v5KKEtAb+/5GlgzPFoT/0GtEZ42eLGGfed+0QwTBJ
    JMgeJ7Rb+MXvDsdFnHFvnXqLkXQC8VwX1G6K8fEk+QvCd1H9CmNXoJ47xEoOHLD8
    T2QohPCOclKVuBjf2OE6ehEF9fkwVQ5OeOMbZegbkie5b3OxT2eRF9YExnb416ng
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SomhNMcg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=SomhNMcg x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932585AbeCDAop (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:44:45 -0500
Received: from mail-bl2nam02on0099.outbound.protection.outlook.com ([104.47.38.99]:14560
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932534AbeCCW0E (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:26:04 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "Andrew F. Davis" <afd@ti.com>, Tony Lindgren <tony@atomide.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 036/102] ARM: dts: omap3-n900: Fix the audio
 CODEC's reset pin
Thread-Topic: [PATCH AUTOSEL for 4.15 036/102] ARM: dts: omap3-n900: Fix the
 audio CODEC's reset pin
Thread-Index: AQHTsz5lt9E9D75AfUKn0wFhozfwSA==
Date: Sat, 3 Mar 2018 22:24:30 +0000
Message-ID: <20180303222318.26006-36-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHSPR01MB353;7:WtKWf9fbPwsB9hUg57VR9GIDp5koa6mstDUS66WURncayBg4FK/oLLgDAtpQ2P9y9B6zTQ1v4TCoYd6y8GNM4m/CdnkoLNyDvndN6w9PtKjOt1kOVLPMI9cioeqe29kJLdy9bpEVlIXYbXsipTU0WN+BxoRkqHmNENezQ0m9hRgC9VN52IdqWf1MMIw89ZYFNRgYvZvJQuKAYZ5GM5ri91eZMEhxOJBQBxpDmSfGK/zovh1e9HPi4gjOCkCsuWno
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8316eac5-75fe-42bc-56e8-08d58155bdc3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MWHSPR01MB353;
x-ms-traffictypediagnostic: MWHSPR01MB353:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MWHSPR01MB353D168BDAEDF320B969126FBC40@MWHSPR01MB353.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHSPR01MB353;BCL:0;PCL:0;RULEID:;SRVR:MWHSPR01MB353;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(199004)(189003)(6506007)(8676002)(59450400001)(8936002)(36756003)(105586002)(2900100001)(3280700002)(81166006)(81156014)(99286004)(6116002)(1076002)(316002)(110136005)(26005)(3846002)(72206003)(5660300001)(102836004)(68736007)(305945005)(10290500003)(76176011)(86612001)(2906002)(478600001)(7736002)(14454004)(86362001)(3660700001)(186003)(97736004)(54906003)(6486002)(6436002)(10090500001)(53936002)(66066001)(6512007)(25786009)(2950100002)(6666003)(2501003)(107886003)(5250100002)(106356001)(4326008)(22452003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHSPR01MB353;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: wVEhQLOzmAFEtw+FhL/dMnRJv5fHgr/npjSSM/cWdRzKR4o8yFeMELHbIWq42F+WUoR+6ykDj8dgKqnxZqnOJ5z19KGVWVHxAa7vv2H0bp0BpssY33baDOWaAyOW6sf46uuTl5xXKxvK6E13f1oJTJuPVDsPwAVMddBLETZEpc0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8316eac5-75fe-42bc-56e8-08d58155bdc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:30.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHSPR01MB353
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
index 669c51c00c00..5362139d5312 100644
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
