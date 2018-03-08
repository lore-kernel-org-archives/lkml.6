Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488230-2-425768867929479905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: AXB_X_FF_SEZ_S 3.299, BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488229; b=ri5YEdwh2/B+kdG4xCt5J+bhVit7dHMfWjlx3/flzOENNGZ
    VpQWGSm64XSIdj13anI7SNRcvdJk4c4U2FoI2q0mpgZhgMuHP/lhFStEWyMHKZYc
    27Y6fI4fw078IvwCcX4J9xLr1mdfVx9wMzdwNgAfKg1ytiytxUpcJBjl58Tlf7ur
    lQNL+yitkndGHTDUJuVyGCiiJRWmqaeg2EV3ONDiWI47ALRZgCKmglw+oX2VR6BI
    W0yMhUnYwM+vDMU/pcC2Z/UlhLlph6C0Gabk7nb8IZAwdfuWj46URjOo61xnpCz1
    TD9t6Q3JCfJtOVhXCHVQ3+DMwbcr5ObtmTb+tVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488229; bh=8kmCpb
    HvO0E+iPlQOAWC3H9BG1JSzB+M0Yy6eDQ8UeY=; b=boDys/kFXYZNSlqfmJ2zjU
    n8mD2l0Zw++NGvPSccRi3Ui4nzXVgbD/BHirBgBiPrzQRIR0wxV3RA71MrvgZNNd
    jc6LuUxlyz80DqwfY3cFwrqz44buMjQcTUKZ31Vinxyb8EyHY/ffSOrGZTnV/2TO
    qdsI6SKDC7/9anK6yqDYdtl545IUDJIeJN9FObFm595KLkFLU/kCZs22l0h4eaNw
    mGSB8kVeRcLHDvkLkkt+LAtFxNMCvB9li5lwEXqxChU8uG29CeGdSioVOe5/X3H0
    52bXa9yyaqPUHSR+0xlssF+WcGSTw7B5K8sniuLXy3Htu5b6+Mohcg9/iLZNb9Eg
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IHHPZNMh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IHHPZNMh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966441AbeCHFty (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:49:54 -0500
Received: from mail-co1nam03hn0202.outbound.protection.outlook.com ([104.47.40.202]:7427
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935496AbeCHFEV (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:04:21 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 176/190] omapdrm: panel: fix compatible vendor
 string for td028ttec1
Thread-Topic: [PATCH AUTOSEL for 4.9 176/190] omapdrm: panel: fix compatible
 vendor string for td028ttec1
Thread-Index: AQHTtppVCyF6WSxkMU6f8WqIbkI8Pw==
Date: Thu, 8 Mar 2018 05:00:10 +0000
Message-ID: <20180308045810.8041-176-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:jRJHh/bDznK/ahrBQDFOxn1t1L/6hKA+YdZuobj1AN73paOER9E6tCR4mQnPOLwhsW/NCrSRdmFMQzO5BPCAY20mykhz/WF+23EHjz69Nau9ny9hGk3hrm41Sx0aWymUb4u/C02TywmBuRhIWbBNvA6/xsci6cCtyDhtbPyUWf10BmDUCpntPaSAQvfd882SylHbHkOwZ/vu6V6Bbga+a+jqsQb5vvBCKZO09Rs69ezqAnZbpG/Cd0EDK2o8mCrK;20:zSTRoN1A9M32ZRcuyi2vrqZzZfFsBbB8Myz9LXRSt7g3UCLaDEyK//7ycg4SZfGwfXzv4A9qtl5fNAZls60bCk6dF+DqSNezKEOmHRlL8tlFzw1oyjN8vsFug7Bj14Nkk7lUZA0GTeD+KAufHClF+Z3RBWbO7U2xUOjEmDrfVlE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 41ab5c79-c397-43a2-547c-08d584b20cfa
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB091966482A5BC3822F7DE371FBDF0@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(346002)(396003)(366004)(39380400002)(39860400002)(199004)(189003)(3846002)(305945005)(2501003)(26005)(6116002)(7736002)(186003)(2906002)(316002)(3660700001)(5250100002)(8936002)(4326008)(86362001)(76176011)(107886003)(25786009)(5660300001)(10090500001)(66066001)(10290500003)(22452003)(3280700002)(36756003)(86612001)(1076002)(478600001)(68736007)(110136005)(14454004)(54906003)(99286004)(6666003)(2950100002)(106356001)(6512007)(2900100001)(6436002)(6506007)(97736004)(102836004)(53936002)(72206003)(81156014)(6486002)(81166006)(8676002)(105586002)(22906009)(138113003);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: Q+dB+mUj4mKbY820gYNuN6sKFosrVVb6WQlAlh12PUSsaQlJ3n4cH2tG1w5ERTcKyV/pnBXGOMqu0p3xkcTztDnIaxpW2WG+SjG61Bn+T9eebACippjZvyzASISo1xiKQdjGwFUjJfEBI7VMADx2j80N0TzAEPqYoZmYJmD9wuRdZqAWjQk+aObZ6HuyBU1IK0e+FNRae5xGJjNQXxNWHCM4xRUrPj24vevsqiIn8CzbM0Ad2TNbLU8WaJJXKFWZnocTCVUCvjU3IDCZnHGc9QLPXBGSIWWfkgp7rBSTUbb6LEbzXcQUvpr71mwGBIsnsxUZLaL/yRR9W96bO50loA3jMJWbBGR/IZXXc84NmB/6Exc2SYr7GaXjTvElJDj9GXeBu/nwrFApp181JUuJnQ==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ab5c79-c397-43a2-547c-08d584b20cfa
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:00:10.5298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "H. Nikolaus Schaller" <hns@goldelico.com>

[ Upstream commit c1b9d4c75cd549e08bd0596d7f9dcc20f7f6e8fa ]

The vendor name was "toppoly" but other panels and the vendor list
have defined it as "tpo". So let's fix it in driver and bindings.

We keep the old definition in parallel to stay compatible with
potential older DTB setup.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 .../display/panel/{toppoly,td028ttec1.txt =3D> tpo,td028ttec1.txt}      | =
4 ++--
 drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c               | 3 =
+++
 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c      | 3 =
+++
 3 files changed, 8 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/display/panel/{toppoly,td028ttec1=
.txt =3D> tpo,td028ttec1.txt} (84%)

diff --git a/Documentation/devicetree/bindings/display/panel/toppoly,td028t=
tec1.txt b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.t=
xt
similarity index 84%
rename from Documentation/devicetree/bindings/display/panel/toppoly,td028tt=
ec1.txt
rename to Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.tx=
t
index 7175dc3740ac..ed34253d9fb1 100644
--- a/Documentation/devicetree/bindings/display/panel/toppoly,td028ttec1.tx=
t
+++ b/Documentation/devicetree/bindings/display/panel/tpo,td028ttec1.txt
@@ -2,7 +2,7 @@ Toppoly TD028TTEC1 Panel
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Required properties:
-- compatible: "toppoly,td028ttec1"
+- compatible: "tpo,td028ttec1"
=20
 Optional properties:
 - label: a symbolic name for the panel
@@ -14,7 +14,7 @@ Example
 -------
=20
 lcd-panel: td028ttec1@0 {
-	compatible =3D "toppoly,td028ttec1";
+	compatible =3D "tpo,td028ttec1";
 	reg =3D <0>;
 	spi-max-frequency =3D <100000>;
 	spi-cpol;
diff --git a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c b/driv=
ers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
index e859b3f893f7..6112c32b994f 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -456,6 +456,8 @@ static int td028ttec1_panel_remove(struct spi_device *s=
pi)
 }
=20
 static const struct of_device_id td028ttec1_of_match[] =3D {
+	{ .compatible =3D "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible =3D "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -475,6 +477,7 @@ static struct spi_driver td028ttec1_spi_driver =3D {
=20
 module_spi_driver(td028ttec1_spi_driver);
=20
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1=
.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index b529a8c2b652..3984716096aa 100644
--- a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
+++ b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
@@ -455,6 +455,8 @@ static int td028ttec1_panel_remove(struct spi_device *s=
pi)
 }
=20
 static const struct of_device_id td028ttec1_of_match[] =3D {
+	{ .compatible =3D "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible =3D "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -474,6 +476,7 @@ static struct spi_driver td028ttec1_spi_driver =3D {
=20
 module_spi_driver(td028ttec1_spi_driver);
=20
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
--=20
2.14.1
