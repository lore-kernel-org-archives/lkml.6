Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520492534-2-595486282401651058
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
    t=1520492533; b=jUfgcq0OCVx/KWzLD6FOPfvoKj2cSUqRKQqr6twP9a8eDfA
    UWNB5H7yUpXg9LUuLQsN2FT88e3qjdwL+6nPjYhHJ59X1P7xH0fcYSaqYnyGtwZR
    0Aqx1/1y4Kr3qLzaFHz07cWGbY/i2IaEZTYZRn6BaHkW+scEfCifPToeQR6UGUJf
    FogydI2aGJeTUiNzEiV2tYrNANZHqARiX1hUHWr0A+cLZIpaYJI829FpgF79H2VM
    R4XB9sJIIrg2UWhkDPVlfgnSKdw2t21PEHGoVK+1bbFCk911jqlWr73/gWSSAnAp
    BQnAKdAvWpwJ8fCLMAm9wN0AHler8FzxydeN+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520492533; bh=6Vgjr8
    QGf03W3wJU9qryVTGOyXqXOw/Ag4yNQ3KqObo=; b=XiV6SNk3paQ5JqJnzxE2jq
    EOq5gPnkHQ9oTK+pKPvfj8lnLfVihsjWgDKkXvSYR8/Fu7jSJrEbeNeTISu+4Nzx
    /dVN9ZC6poMO5odq/pl9OUJrgArllVz73Ia3ccs8NV5dnJQNxtw83Pp003Yg5aPL
    oBypjgLdbUvJT3RTx+Qia2lktbZv+DvZQeUV4GrvqIMP9+pYRhnX3d29QHdBYM+Z
    Zy5RdmPRvdMZNfsEw6N+uSMtEiHMd1hDmzoFueNbeNzfe4SWwyLud1PXiBHeommF
    tKzLMyPT4nv8ks7pn/KepW3MF+qKRPB3JSmarfcxH/5XRYa5xh8fM5/jK1RpySjg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GPsPp1DG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=GPsPp1DG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965025AbeCHHBx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:01:53 -0500
Received: from mail-bn3nam01hn0210.outbound.protection.outlook.com ([104.47.33.210]:63904
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934889AbeCHE5O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:57:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 48/78] omapdrm: panel: fix compatible vendor
 string for td028ttec1
Thread-Topic: [PATCH AUTOSEL for 4.15 48/78] omapdrm: panel: fix compatible
 vendor string for td028ttec1
Thread-Index: AQHTtpnNCoE/n4YffEe0QpVMgtxrdA==
Date: Thu, 8 Mar 2018 04:56:22 +0000
Message-ID: <20180308045525.7662-48-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1079;7:z7/PAAvtSyFO6FUiZ3AN3Gzr81PkwTUPLqoysPoHLfD26aE+9twrOOhwBkyd/dgqwOe+V2JfXYvrPbv3TthQc6gmYTIXIY73ybNXYBBOL3EmC6I2BLDrqEJNTjxX1s+eZpu6Iab1a9Kv3W3+6FJiCQW8mMgdC7kbLsMqGflTqp6AXyRhBlHIa6PZLOTGe+l6ZnRoovkPEM11NEaihy3Q9hUYOLwLa3AUzM/gvPdAEmboNch32MHTw8MKOJnjJ+Kt;20:Jb9FXOP17bgwLjAI7BcEx84Z8/YxuoDVkoWOnZR4enmFf2PJwfDIKja4DIjvGyxCexfSnuj7LM8TIF57FMSyPwvKSlGmMtSSO7VcN9dhvi7viP98e6EnZL40+mNFi3PSdoAY5vY+Ea1UV7PmDQNc/qkUmypasjav39QQeqdpUE0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c8c114e1-5989-4442-7ae8-08d584b10de1
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1079;
x-ms-traffictypediagnostic: DM5PR2101MB1079:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB107996A9FB966196D1A68A3CFBDF0@DM5PR2101MB1079.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3231220)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR2101MB1079;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1079;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(39860400002)(39380400002)(396003)(346002)(366004)(189003)(199004)(36756003)(107886003)(4326008)(97736004)(2906002)(2950100002)(1076002)(6666003)(105586002)(7736002)(186003)(3660700001)(5660300001)(106356001)(305945005)(6512007)(3280700002)(25786009)(14454004)(575784001)(86362001)(86612001)(81156014)(10090500001)(76176011)(26005)(99286004)(66066001)(102836004)(110136005)(81166006)(72206003)(54906003)(5250100002)(478600001)(10290500003)(6116002)(2501003)(8936002)(68736007)(53936002)(6506007)(6486002)(8676002)(6436002)(3846002)(22452003)(316002)(2900100001)(22906009)(138113003);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1079;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: JQKN3DilEWov4IbaMSdnB0o8djAb+FGIVsG9RkTlVi4eEh7fc3fEOOeJOqnX/em7H0bmtm1JK+Z1rzdHKjJ/fGIdF2BIt5iTBDxNwK1rGc1QtY5UskOlhkvQVmUkXonRWh8eHUwRvsghWFpnJFLTITbqZi/dOS5F5Z5Yxy3ubA9RrN3Uo5Hes5DWa5jI3/iZoZpsUK7dVanYbj+MIGRtKpfJLF8BVIlhIQNsJWoFvYDA70SMVYzYKPReO9biP5ngdhaQzM4bjXqYJ22dzaQMqeTC5Z/cPWtDKOnKWzqsipMTUoz22yejTbiX3pIkOqJ3FrK1a0eQ1XDeql9iLLV5rnKFr7xFzt/MSmg6NXTgTpOjajcffjTChDo7ofbJod6Zm0YRS5n9kNdoi2K6gbxoBQ==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c114e1-5989-4442-7ae8-08d584b10de1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:22.6717
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1079
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
index 0a38a0e8c925..a0dfa14f4fab 100644
--- a/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/omapdrm/displays/panel-tpo-td028ttec1.c
@@ -452,6 +452,8 @@ static int td028ttec1_panel_remove(struct spi_device *s=
pi)
 }
=20
 static const struct of_device_id td028ttec1_of_match[] =3D {
+	{ .compatible =3D "omapdss,tpo,td028ttec1", },
+	/* keep to not break older DTB */
 	{ .compatible =3D "omapdss,toppoly,td028ttec1", },
 	{},
 };
@@ -471,6 +473,7 @@ static struct spi_driver td028ttec1_spi_driver =3D {
=20
 module_spi_driver(td028ttec1_spi_driver);
=20
+MODULE_ALIAS("spi:tpo,td028ttec1");
 MODULE_ALIAS("spi:toppoly,td028ttec1");
 MODULE_AUTHOR("H. Nikolaus Schaller <hns@goldelico.com>");
 MODULE_DESCRIPTION("Toppoly TD028TTEC1 panel driver");
diff --git a/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1=
.c b/drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
index 57e9e146ff74..4aeb908f2d1e 100644
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
