Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1131037-1520491408-2-5246583503347920328
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
    t=1520491407; b=TODrPnyoPYGvhUCvKPuRubPRSTPhmX4IIPDjMILOTYE5/Aw
    dEN49Ki7coIue7N7gHSLF2kHMrk8ZkSCmEWoEJloATYthoK0zjAJ0NqKSY4Ac82A
    yE0nfGiCgWUmFJn002ocoqbVlSKw8R31OKpPX6MrMtj+vHZloSvYuSV3R+dYxgmK
    mddUV0gVLJrTNHFyjddsQvEgqxi8fWx1xqBwKyIp3KufuswoOSnxIwUAAKCwx2Ta
    jK2WbqnX9EWWYBiucldMXnQpB6COuWx7u/L7hVyv4fj8RR9MkCXY5YmG0qCWK3Kd
    YThfbEeouszZ1yW66DRD6M9uDh0C7hwWSsnLBHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520491407; bh=6Vgjr8
    QGf03W3wJU9qryVTGOyXqXOw/Ag4yNQ3KqObo=; b=Fq6b11QVL6mKvTaVZS7DZz
    Prw1aINsYa/3ZhvjKgWAu3d4OSE4Utt/3YsySznYa3KpdsttlIXesWqZC2PsUndy
    VEgniQZUxVf2kKqGPxsDNvhUkVjQqEuMUI9JfkXPE6ISy4sbKJY2uPnvwwWO8skF
    Dnu6eegdZs5b6PeT7O4S93mEo2hARQKnjY+DHINs9NXaKl0Q7j2CFAiCb8BtVwAX
    NH9zgTz0l2h9CdhWKRbxul/Y7PSPypCnc6OcWV86eer979UnXKJGxLhzT9oFaad3
    Gpr+oim2+dVTOFIVVhC3nFak6rS+c7CVxZI6mlXJ3Es9s8Q2l5LvDvPGn2lqwr3Q
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LJQANgkc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=LJQANgkc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755449AbeCHGnL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 01:43:11 -0500
Received: from mail-by2nam03hn0215.outbound.protection.outlook.com ([104.47.42.215]:57024
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935353AbeCHE67 (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:58:59 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "H. Nikolaus Schaller" <hns@goldelico.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 41/67] omapdrm: panel: fix compatible vendor
 string for td028ttec1
Thread-Topic: [PATCH AUTOSEL for 4.14 41/67] omapdrm: panel: fix compatible
 vendor string for td028ttec1
Thread-Index: AQHTtpoBjyl5Zv1SI0+6QNx+rDgJEA==
Date: Thu, 8 Mar 2018 04:57:49 +0000
Message-ID: <20180308045641.7814-41-alexander.levin@microsoft.com>
References: <20180308045641.7814-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045641.7814-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:stVWRnV9S3ovbw4FUBbOH+quxHSaq8NZD2EC4BpIsceGwBZCB8hCIBqGHQpNfncUag6s9TfwugJ+0WHX4lARtMCSbe9xP6nutQIt3qw4W0kQbuWcZZ4ptsyJmeQjGt5lMbGjhE4S/O1KtJbhj+O9oTsTmn9uAjuCPE0iggarevDrZTqhyUtMRusnVpNfps/+GvsVSjsJzRii0zkMSYrJdDyyh49A96MJyf/F85psImRjFCjWwVEa0oUoiMTDq3pW;20:Llx3zFzR+cpi27mcztvjslpI22gjb19ab4+cn4UNnSl/T7kqD1nqKoSbpBEAhBatqL1pmlPunMzmA8Fs8gq3xFgLTlYMGFcCykDtxW8tg7HGQMm72LyuPBkDCRkf3FN2tQxnWQ+rPH85AzJfX02PMmcpCvuP6BbMkTAEOuuay24=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 98735a59-2668-45e7-31aa-08d584b14d5c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB101586C4675FDE5875001484FBDF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(10201501046)(3002001)(6055026)(61426038)(61427038)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(39380400002)(346002)(189003)(199004)(6116002)(53936002)(1076002)(107886003)(3846002)(3660700001)(10090500001)(6666003)(2950100002)(2906002)(6512007)(99286004)(8936002)(6486002)(76176011)(6506007)(68736007)(316002)(110136005)(81156014)(81166006)(8676002)(54906003)(3280700002)(2900100001)(6436002)(97736004)(72206003)(25786009)(10290500003)(86612001)(4326008)(305945005)(7736002)(66066001)(22452003)(478600001)(5660300001)(86362001)(575784001)(14454004)(106356001)(36756003)(102836004)(5250100002)(105586002)(26005)(2501003)(186003)(22906009)(138113003);DIR:OUT;SFP:1501;SCL:5;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 0elF7oX2Tgah44xJ4U3obBlbkojW3Ill+th/Q8BSdynlgi8LNKMEoe4W8AzOkpAOvFibz/M1nbg/9I/Mtiwq7MUcs63JZ3Gzs4J9J9aD3Brt5jyvIvui5GL0m5Zz9Y5XxZUNbUpvj4muGHHuZ3GdM2hTYAH8pDYc/9Vi/8bLvyQgvK3dcxnADhCZ1IQiRigQCD5aXp0d6+lbj5oimYFUwLO/QSYRZBrbaKzO5ftJ6wEahqIVYfT9jzWjymgf3SRCqrQHghKDwFVJLtdbbtLKl3fHF4E3j69un4E9VKt7vtE+hpZuC/MnkW+CDK+TXmv9xQkIZDGr6X28asHz4Rtam3dNni5EqVONGpw8lzBAtHmeiam1gst5lUQbqaw06+jmIVWSoyn+oEJjqrp4ari7OQ==
spamdiagnosticoutput: 1:22
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98735a59-2668-45e7-31aa-08d584b14d5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:57:49.4733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
