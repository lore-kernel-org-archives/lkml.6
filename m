Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC59EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B0F020844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ZM/vdSqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B0F020844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbeIGFe1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:34:27 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:48060
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728044AbeIGFPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OCWhcMhm5Jz0+eXtQLn+C8eZscpHTLcr8yilSl+9YDI=;
 b=ZM/vdSqX5czYrPnDe3h6dae7A+ufEH6/JWp2yxtu43Wsp9Q3BKrrHWJm5dGsVnir7DwNiSXmZK/teVRd5lGpazr/NKJzGGM0tYCa4y65tmXzesfROCFxUAcT3O6D+friCkTkriQcNCzGAHbrQS1P2TSJndk5K+LuFefMKuGIrko=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Niklas Cassel <niklas.cassel@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 81/88] regulator: qcom_spmi: Fix warning Bad
 of_node_put()
Thread-Topic: [PATCH AUTOSEL 4.18 81/88] regulator: qcom_spmi: Fix warning Bad
 of_node_put()
Thread-Index: AQHURkLcVQddM5979kCFJf1UZ9oPRg==
Date:   Fri, 7 Sep 2018 00:36:48 +0000
Message-ID: <20180907003547.57567-81-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:KrkavnTiIk6RURPrm0DUATERNNhf+WczCBaweBrnkyxU4fZtcK90SlQkKkYHg0DzCTyhZeMeObgxTsQosu+beznFYH+v9P6hfB3CsLxbAvsJK8HKV3EQYhqw3Sxerh0G+e8ttcsDUiSa2SXfFu0N1+Kri8ebY9oIGeZMP7EMp9PWBsP898zimuNLs5e5xogVK4H03aq/+wqLuLXrLMnPW/7u3M4nrE/efQa4C7DflpfUirBMgrBfxd0DBa/iv/3XDUDeKIrBqxKX2argm+kHS6Z2TCBnid38TXiQGmGa0aHNRYwSkiF79EaICxmVva5TKYJNvg096Q8uLpS/OKaxO4EqGUR7Y++W+a8IZIsYCw4BbhdDs60sC+QfnBZWFyRK7hR5qVCqrt7YzcHkgVZesgTjVsDmeh3TwOgMpot+enJtk/7jJ2tPMAN23pMvjskXG9ogZeOgcHuvmNOtmOS2Tw==;5:ltQ5QWBzjgq7f8+VgChlUg1SyzS4GwydiNA4W9WiMhGnvav4wt80HqfLmFU9gDrUVOe02guJTEIcFfPd2B3jBXypX+30TSwEE0+RgtQASiBaF6LxO9jkPUKLfbyyrjMD2nwXpkzdJJ4YzNmNLsfa8g14/d9MDIUy2ergX0g44Ak=;7:vWP5D8oiGGPQ/2NTPtRskyPoehwFBsFHjl3TiXLrad/ZgTckVkot0rhIApwXO3dmU+/n0Abs35i1+ERAJEcUGLVqDWYk+wVbncxZbSLApV9VnpdFBRlVQaGVXovRhVA6NZOEIuV70g2XTW0HQXOjxNz36Wcy8LsnqdcuQT1XljNJTqgh+8mVFGUEWzr6L5lYfUBZypCl6FXAexOZf8xmHz0I1unYLOcAk1XUix6H1lsQ6UMu8Hlt1aJ957WArFOk
x-ms-office365-filtering-correlation-id: c7cf6e25-46b4-42b8-f334-08d6145a1cce
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB08391C9330FBEBB138E558B1FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(575784001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: hN0xu8E/ya9pZB6xrfiocflnx5Lo+bnxS548olaBRImO7406dvxv8IP3pVY90HqEF3uS6LgN66fGXJ829VzOzyc9eyEe0yZceVl0pdXvjx29acxiW+uQJrkfqwM89rcF0PaknUx9ffvObIjch5s/91TtR8W82o/Dx9OWFkjOXTRcTNSK67+XZy4NsdK9KLVkmLo7ZIlGOTKEM8LkSKV2rwdkxPzO65cq7ioA5fT5Cik6H7VFGDPZXHp54uFmrFG+X7P5unjEOYk1jYZ3fhnaV8koDvstlMZ6jWsG3usp1gmD7wqkOl579iIiBs8KPFtoqx46rbGPm1gwBwS5c/MyB+u9BVC/X4WtFlJEI1LPZq0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7cf6e25-46b4-42b8-f334-08d6145a1cce
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:48.9207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Cassel <niklas.cassel@linaro.org>

[ Upstream commit fffe7f52eb5db41eedadba9a8038e982dcfaee0c ]

For of_find_node_by_name(), you typically pass what the previous call
returned. Therefore, of_find_node_by_name() increases the refcount of
the returned node, and decreases the refcount of the node passed as the
first argument.

of_find_node_by_name() is incorrectly used, and produces a warning.
Fix the warning by using the more suitable function
of_get_child_by_name().

Also add a missing of_node_put() for the returned value, since this was
previously being leaked.

OF: ERROR: Bad of_node_put() on /soc/qcom,spmi@400f000/pmic@3/regulators
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         4.18.0-rc4-00223-=
gefd7b360b70e #12
Hardware name: Qualcomm Technologies, Inc. DB820c (DT)
Call trace:
 dump_backtrace+0x0/0x1a8
 show_stack+0x14/0x20
 dump_stack+0x90/0xb4
 of_node_release+0x74/0x78
 kobject_put+0x90/0x1f0
 of_node_put+0x14/0x20
 of_find_node_by_name+0x80/0xd8
 qcom_spmi_regulator_probe+0x30c/0x508

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/regulator/qcom_spmi-regulator.c | 32 +++++++++++++++----------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qc=
om_spmi-regulator.c
index 8d5cd624b4b8..ba3d5e63ada6 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1752,7 +1752,8 @@ static int qcom_spmi_regulator_probe(struct platform_=
device *pdev)
 	const char *name;
 	struct device *dev =3D &pdev->dev;
 	struct device_node *node =3D pdev->dev.of_node;
-	struct device_node *syscon;
+	struct device_node *syscon, *reg_node;
+	struct property *reg_prop;
 	int ret, lenp;
 	struct list_head *vreg_list;
=20
@@ -1780,10 +1781,13 @@ static int qcom_spmi_regulator_probe(struct platfor=
m_device *pdev)
=20
 	for (reg =3D match->data; reg->name; reg++) {
=20
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-slave", &lenp)) {
-			continue;
+		if (saw_regmap) {
+			reg_node =3D of_get_child_by_name(node, reg->name);
+			reg_prop =3D of_find_property(reg_node, "qcom,saw-slave",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop)
+				continue;
 		}
=20
 		vreg =3D devm_kzalloc(dev, sizeof(*vreg), GFP_KERNEL);
@@ -1816,13 +1820,17 @@ static int qcom_spmi_regulator_probe(struct platfor=
m_device *pdev)
 		if (ret)
 			continue;
=20
-		if (saw_regmap && \
-		    of_find_property(of_find_node_by_name(node, reg->name), \
-				     "qcom,saw-leader", &lenp)) {
-			spmi_saw_ops =3D *(vreg->desc.ops);
-			spmi_saw_ops.set_voltage_sel =3D \
-				spmi_regulator_saw_set_voltage;
-			vreg->desc.ops =3D &spmi_saw_ops;
+		if (saw_regmap) {
+			reg_node =3D of_get_child_by_name(node, reg->name);
+			reg_prop =3D of_find_property(reg_node, "qcom,saw-leader",
+						    &lenp);
+			of_node_put(reg_node);
+			if (reg_prop) {
+				spmi_saw_ops =3D *(vreg->desc.ops);
+				spmi_saw_ops.set_voltage_sel =3D
+					spmi_regulator_saw_set_voltage;
+				vreg->desc.ops =3D &spmi_saw_ops;
+			}
 		}
=20
 		config.dev =3D dev;
--=20
2.17.1
