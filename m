Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B9BECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DE921476
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="g7KnL72J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04DE921476
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbeIOGts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:49:48 -0400
Received: from mail-sn1nam02on0127.outbound.protection.outlook.com ([104.47.36.127]:18752
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729115AbeIOGts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nV8wruHdiEfQ7HS9qiMwr59yz2W7MwzDd7ox8aJEWZY=;
 b=g7KnL72Jtz3EURvB5q1VgG5xiyaDDqFYOIno3TqWsMOkbJXuk08UJS5HJiOPg+dvY0U8Y1+IEBUT5k59/WXyRxgHyz6in6WaGefTHh9PEemyhmowTILQ/wMO58798cH2sgpBBFsvAcmtL98gmSM407SwWZaXZ1ZXan0d4x1E7gQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0822.namprd21.prod.outlook.com (10.173.192.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:32:44 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:32:44 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Jan Luebbe <jlu@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 23/57] gpu: ipu-v3: csi: pass back
 mbus_code_to_bus_cfg error codes
Thread-Topic: [PATCH AUTOSEL 4.14 23/57] gpu: ipu-v3: csi: pass back
 mbus_code_to_bus_cfg error codes
Thread-Index: AQHUTJQATvKcAtDOq0+0gt4t0Jwsvw==
Date:   Sat, 15 Sep 2018 01:32:44 +0000
Message-ID: <20180915013223.179909-23-alexander.levin@microsoft.com>
References: <20180915013223.179909-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013223.179909-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0822;6:oCQGZXPFD8hRlsYJN78Zj4aLcMcAxKhc3dHrhgx/WA+sN458MCuhuatRIRMK6sgBBeIWpExCyxbyXiDZX63WH9kZSjz0Hvk8jBONeUzLntINc1Cuu8YMt+6pcxrcCcdsUffUILeHxRCVycwSZ8hyKdPAkqoqThEIQTJjLCSuUBXkC2Iym0Y/ZSXRKac8TTAHkmzhzUBDYIqxELS2/GtDRtvNdtQCaXGOBYHpYtd1LQ9PvZW9e4Dj83NX19DXugDRyXWOsoyZV/qHm6+BTEp7HgbIH22t7zi+cemXD8gWEg8296lLCmSeofBNmd4JHXkTfNiIjD+6sliP5M1W5468MnAxRbQfm6mCjt372IW4ImBuF9xX9ZmZQ48ebsDdeSFAI0IHbUrgFMtvQ9Fyiqq80Q0NH4F8ucpIaQaLGQKHIV92FYUeZmWt7ompQBrFynkCwKVsyR2xHOuZMwWzzM/Vcw==;5:leS6FYXYevQfE2iCTaqC6v5TZiadw+gVdKusJBIZc9PrhwQAHfcAxARDf4xXP/XA8ud2heZcs4jTT9uxVy2x9TCyNktdLOy+LFDtoGRXNPfCAhVL7ekfvB0uEy0F97fws9QEfulackhge/yOm/zSmGafHNxzLY1ttaGCJTc1dPg=;7:8r1j/G/ruu49UMVvo48PiMkx/Z0ssr9W6Ij+qUWDWr5MdELd/J26EhgaRt775teveuVLsEFDhKFxhKjTYxpEdSs5Cm4nI3QTLxescjldIWkO25vFIdxeOOiiTiIE8K7YZwKHzGbQW/O0gfT++OqeaIV3jdf6kFsn8P+iHq+c/u19XHQT3I4kRUF4cXGaDkPeqYqoQUOSvM/CLYZ1ZimmggN/8fiEIaR+i3M4OfVssjrE7b6dJbRtq3mB6Hf2fmEt
x-ms-office365-filtering-correlation-id: 506b1b72-ef96-466b-a112-08d61aab22be
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0822;
x-ms-traffictypediagnostic: CY4PR21MB0822:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB082255D2D06FA3C654AFE8A8FB180@CY4PR21MB0822.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0822;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0822;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(396003)(346002)(376002)(189003)(199004)(1076002)(72206003)(6506007)(102836004)(478600001)(8936002)(10290500003)(2906002)(81166006)(81156014)(5660300001)(22452003)(2900100001)(8676002)(110136005)(54906003)(107886003)(99286004)(25786009)(4326008)(316002)(10090500001)(97736004)(305945005)(7736002)(6116002)(3846002)(256004)(14444005)(66066001)(76176011)(217873002)(6436002)(14454004)(36756003)(476003)(86612001)(6512007)(26005)(5250100002)(53936002)(486006)(106356001)(11346002)(2616005)(6486002)(575784001)(86362001)(446003)(186003)(105586002)(2501003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0822;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: o95oZbMmt39ADu8Oi+ztradJtDQLFt53lEpj9NJk+EK7ebNrrrBeWOuf8LccYxXWjhQAz8NnADUGZrES29iTKxQ24oOIzK+U+FKvWSSPWpvJA8YdxmxK+Xt71zbaaZuzWn2PAB1Xt3eqiYp3mpNojuUXXb7rW/IgKBB2wkDvvoGQ2AoT4LkTnueEvlc1+aAYrN/C+4rBeWGRF9hIjcLvIDIOmOIxwzOqTj+1w1mzQQCRdAyxZ2DDS00SOANEEjuf0OlGk+ATZtOfMqCzawWxbP5Dm+GTMWEh11Oi/ydD2fMH0RLVvgc7eYDVoS94hrEUbWfnbE1Z6/KWLXBVZeX6EDoE8l3Abzh7n05nme6rxUw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 506b1b72-ef96-466b-a112-08d61aab22be
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:32:44.3058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0822
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>

[ Upstream commit d36d0e6309dd8137cf438cbb680e72eb63c81425 ]

mbus_code_to_bus_cfg() can fail on unknown mbus codes; pass back the
error to the caller.

Signed-off-by: Enrico Scholz <enrico.scholz@sigma-chemnitz.de>
Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
[p.zabel@pengutronix.de - renamed rc to ret for consistency]
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/ipu-v3/ipu-csi.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/ipu-v3/ipu-csi.c b/drivers/gpu/ipu-v3/ipu-csi.c
index 24e12b87a0cb..2bc51d4d3f1e 100644
--- a/drivers/gpu/ipu-v3/ipu-csi.c
+++ b/drivers/gpu/ipu-v3/ipu-csi.c
@@ -316,13 +316,17 @@ static int mbus_code_to_bus_cfg(struct ipu_csi_bus_co=
nfig *cfg, u32 mbus_code)
 /*
  * Fill a CSI bus config struct from mbus_config and mbus_framefmt.
  */
-static void fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
+static int fill_csi_bus_cfg(struct ipu_csi_bus_config *csicfg,
 				 struct v4l2_mbus_config *mbus_cfg,
 				 struct v4l2_mbus_framefmt *mbus_fmt)
 {
+	int ret;
+
 	memset(csicfg, 0, sizeof(*csicfg));
=20
-	mbus_code_to_bus_cfg(csicfg, mbus_fmt->code);
+	ret =3D mbus_code_to_bus_cfg(csicfg, mbus_fmt->code);
+	if (ret < 0)
+		return ret;
=20
 	switch (mbus_cfg->type) {
 	case V4L2_MBUS_PARALLEL:
@@ -353,6 +357,8 @@ static void fill_csi_bus_cfg(struct ipu_csi_bus_config =
*csicfg,
 		/* will never get here, keep compiler quiet */
 		break;
 	}
+
+	return 0;
 }
=20
 int ipu_csi_init_interface(struct ipu_csi *csi,
@@ -362,8 +368,11 @@ int ipu_csi_init_interface(struct ipu_csi *csi,
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
 	u32 width, height, data =3D 0;
+	int ret;
=20
-	fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
+	ret =3D fill_csi_bus_cfg(&cfg, mbus_cfg, mbus_fmt);
+	if (ret < 0)
+		return ret;
=20
 	/* set default sensor frame width and height */
 	width =3D mbus_fmt->width;
@@ -584,11 +593,14 @@ int ipu_csi_set_mipi_datatype(struct ipu_csi *csi, u3=
2 vc,
 	struct ipu_csi_bus_config cfg;
 	unsigned long flags;
 	u32 temp;
+	int ret;
=20
 	if (vc > 3)
 		return -EINVAL;
=20
-	mbus_code_to_bus_cfg(&cfg, mbus_fmt->code);
+	ret =3D mbus_code_to_bus_cfg(&cfg, mbus_fmt->code);
+	if (ret < 0)
+		return ret;
=20
 	spin_lock_irqsave(&csi->lock, flags);
=20
--=20
2.17.1
