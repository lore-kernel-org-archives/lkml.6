Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C16ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FA3B20866
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="kdTb2nef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FA3B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbeIOG5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:57:42 -0400
Received: from mail-by2nam01on0130.outbound.protection.outlook.com ([104.47.34.130]:13056
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729609AbeIOGvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:51:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rq5AfmPM6TnV1g3g7a6J0wPwVT8PXFuBFLwY6iVqoB8=;
 b=kdTb2nefQHfp1iGwPlsQtP8ynpSzOmilnWo3baVrGX1WFyxQRvopORdDSjICNiSE6ikvoJHv5AcyBQMJYnDL9UdKR51hYTUKwIjfwrXG6l8C9fSRubKeP178qPJBnzZGOLHyE+wRjaSc2QJwZQrpg/YmPkB//o8gxbmhfi5PomE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0823.namprd21.prod.outlook.com (10.173.192.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.9; Sat, 15 Sep 2018 01:34:33 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:34:33 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Enrico Scholz <enrico.scholz@sigma-chemnitz.de>,
        Jan Luebbe <jlu@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.9 13/34] gpu: ipu-v3: csi: pass back
 mbus_code_to_bus_cfg error codes
Thread-Topic: [PATCH AUTOSEL 4.9 13/34] gpu: ipu-v3: csi: pass back
 mbus_code_to_bus_cfg error codes
Thread-Index: AQHUTJRBAMY7HPrL0kamznsdyXUCrg==
Date:   Sat, 15 Sep 2018 01:34:33 +0000
Message-ID: <20180915013422.180023-13-alexander.levin@microsoft.com>
References: <20180915013422.180023-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013422.180023-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0823;6:X0ni2VHtHIaNoubzTd4WRoyVjlfis+qU6MnJA/2JzahM7Dkkszr1fzB7pyoilkC9YyLfaI9YZDDnximVBYHVFhLEqcsvAhwKNVc/lF352ip26pqADmiZhvjLkbYAaIX89MMQXtDxNb12qKtTuEe3HAqjIzt/9jwHCwrhroXhgLh1MJnouQRNwobLaOxORKdutYqNpTvliy0Ewf9WYxYZU5RyrEf0y2+ZGkjj9/MHZgSdrSkCwPbi0KqviMBFAoRoNmBVbbOVbm6nW0IZ3axDBe4pc29A1o4xMhIUkvJuq+9Emk5gAv2mYc+1WP0ORSZBMC/rIA6n6b4n76ZxdcxaCWrDxcNa+toqeGju18plpGR/YlhNU+sJlLCaH349Sn9Yn+MN8xGNZFHr/wKS5K+MHpIp1cL6We7bkszzsYsMeyMCJ9x/QJxZLJx02Ge2fBaM6TYv8g74OpS/IF0jzj7BQQ==;5:/hGt7AqR9bkwm7/cvPCF13FikYq9G2f2z8E0BxfI92XN1xLeilH1zDEuPAncX+wN5g/XH9Y5DuTRjHK8tZHRNL/3DYTchfM9sO2rJs7M1vxLdsPlyvG9zHd1dwMECTNpVftXBS5opeBAo0Ml1OYp/HF2GFnA2974VhOI47LC/Go=;7:PZYuvk26lBlUVlcIrYOpUamopAbve56IGujMnI73HEfB7y5My16nLO/eesax99+Lni+3qZI6CMOrjM+B1PVixsahLVhkdLwcm6wI5OADXq4LLiXRWwpkIlpW95C3EPh4SQ+UYV8IPTZhTNL6qr5OnBJvIuN+KW+FGpRhW9tDtbK2rEqOvWQRtDHDFjd0BoJOhJ+LVlfkPdC24XigwzlPvtrYBeLmTZhEelCsUtESt1N78n6Y/SzrHOtxny93EH/X
x-ms-office365-filtering-correlation-id: de2f2f30-c99c-4f92-7e67-08d61aab63f6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0823;
x-ms-traffictypediagnostic: CY4PR21MB0823:
x-microsoft-antispam-prvs: <CY4PR21MB0823FE09B75F9A5A5391644AFB180@CY4PR21MB0823.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0823;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0823;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(136003)(39860400002)(366004)(189003)(199004)(53936002)(14454004)(2900100001)(3846002)(6116002)(14444005)(256004)(10290500003)(81166006)(81156014)(217873002)(76176011)(72206003)(478600001)(8936002)(25786009)(8676002)(86362001)(66066001)(6512007)(86612001)(575784001)(7736002)(305945005)(97736004)(11346002)(5660300001)(5250100002)(102836004)(54906003)(2616005)(446003)(6436002)(6506007)(476003)(186003)(110136005)(2501003)(2906002)(105586002)(22452003)(10090500001)(36756003)(4326008)(68736007)(26005)(107886003)(6486002)(486006)(106356001)(1076002)(6346003)(316002)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0823;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: ISffRyvoZ0xFczXtwcytUjQdcI927sR5P6NFfQ5gb47GqM1xdszAvXjJF72PEe22TCqZ4lPvssyNIAuYZ0dGiGrrv8sv6CtNq2ujFrknA9x7JfB9+Cs1uyU2JULZIwhh8vZZSft/UbY7pbq+LvXdmU4PEpmzwcQfKPnqQ0/OkIpjwWTMHTx145a/Q4RJH/qjh75ZsjuOD+2Gmj5hPDCbQSbZgzWE0hpLVzqBPauT720SDJ43Gy6IvxzgPWi36U80PYabbZXWAGAC/hlfppM37/tLv7yk5WJVQd8ejXBrdfXg25ym0aTAR4ztIOPI26aNicuXgnxIcdPfuf7vd0vosEf2rOjh2eupIDTBKWZVNLk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de2f2f30-c99c-4f92-7e67-08d61aab63f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:34:33.7551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0823
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
index d6e5ded24418..8774bf17c853 100644
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
@@ -567,11 +576,14 @@ int ipu_csi_set_mipi_datatype(struct ipu_csi *csi, u3=
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
