Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9735FC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5577720700
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 06:04:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="SpL0QW1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727906AbfAHGEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 01:04:36 -0500
Received: from mail-eopbgr10049.outbound.protection.outlook.com ([40.107.1.49]:38188
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727831AbfAHGEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 01:04:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFQEZhckWRmIWiBApFW50QSsHMlZ8CUuEZuECppRnuA=;
 b=SpL0QW1hGVRRcjsYiyTVEVtzy8dlSK7l5/K3RK0QVDxggI8MXYCxINn2l/LawBDdDX9DzbDE0U71pVMT2SwuB1Yrd1MrTIyJ5cSCO62xDR57YeK92c+2TC7ylSoV+gmPslgT7V5QkztjLjNsIndMXpY/mSjq//uuraXZu0klfrU=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2915.eurprd04.prod.outlook.com (10.175.42.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.13; Tue, 8 Jan 2019 06:04:29 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1495.011; Tue, 8 Jan 2019
 06:04:29 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yinbo Zhu <yinbo.zhu@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Topic: [PATCH 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Index: AQHUpxgE3SCqMwWaSU2qZS5l4UGPMA==
Date:   Tue, 8 Jan 2019 06:04:29 +0000
Message-ID: <20190108060426.11581-3-ran.wang_1@nxp.com>
References: <20190108060426.11581-1-ran.wang_1@nxp.com>
In-Reply-To: <20190108060426.11581-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:203:92::26) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2915;6:kXcS879goJAnoTMa/evy+f/2Y1ARU++/kpZzZAC8YBj2OLdqyn+t2zVhpsA3UZkNguEe5/bfhsgdt7Q5M7yIBToTZXZ5AvFl5k8+mgpTYPVzX35FIfeUVSM9wPHuDFmqoKzxvUla7xTqv3HTHgV4/t7/wMxs9O2Lz4T5qLHeROdwyVjcWXlb8IHN5WC+bO5mSdPK09TXtLVcOL3Wz0m/hvdAO7MljZHX+7k9fjfWzjvYLpDFUbRtx5v0E0BleG32YhHI3MeuSze6x0ujmB7Dpj5zdnoih4DL3hhDDqbPPSdeYIH9x7KSWsqOv/12GOEDOjrfkG08jmjNsPPCj6zAZVxpDVRDUKnc7Y8JQ91QZ5fKw+MLoTPj5zVFrCT/3iy1TuQfCPGNWWQMOHcDF4bDjL2Dh/7ZDz5EDTfT7Lot8wCWZjZdDdgpiO+xEmKnZ/B/3sjHipESkrQTHb3WbIe4ew==;5:aLmcwValxqs5sQeiV/wA+RCykGV13eX+r6clOwR2bSBjxdw9OTDJ5BQdq5pTQ1eYbp/M5vA0xvDT52Jmtbj5tE4rDBttM2/c3KoqE9fSRISDbQqL1LgbUcLsF50FwdmeIpc9Xx6R14DDzM4o/qNdyu4f7WvAf7ot1IAg92eOaDu0UNQAqd4tGxmZC/qmlUOaZoIdLkd9cdpxqemL4cueOg==;7:OqXGtVBSlzP26iogidGn8eBTutnTqWHtscuQXpI8vsTzUMcn9DP5QuLGxtVZbTOWkm57B5Gqxo1bj3V6v2rpUacZHl/YOrfT3WIonP9sHMHFFczFxdC52OPlJUk/ETqNSa9Cdf5BR/wFjTWn01Z7bg==
x-ms-office365-filtering-correlation-id: e2e168d0-36d8-4769-56bd-08d6752f26a3
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2915;
x-ms-traffictypediagnostic: AM5PR0402MB2915:
x-microsoft-antispam-prvs: <AM5PR0402MB29151116F077D5A1D1D17506F18A0@AM5PR0402MB2915.eurprd04.prod.outlook.com>
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(908002)(999002)(5005026)(6040522)(8220060)(2401047)(8121501046)(10201501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM5PR0402MB2915;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0402MB2915;
x-forefront-prvs: 0911D5CE78
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(366004)(136003)(199004)(189003)(68736007)(97736004)(36756003)(478600001)(66066001)(476003)(81156014)(81166006)(25786009)(6436002)(8676002)(2616005)(446003)(11346002)(54906003)(6486002)(110136005)(186003)(1076003)(14444005)(106356001)(256004)(105586002)(2906002)(3846002)(71200400001)(6116002)(486006)(7736002)(71190400001)(14454004)(2171002)(50226002)(4326008)(5660300001)(99286004)(305945005)(102836004)(76176011)(53936002)(52116002)(386003)(6506007)(26005)(8936002)(316002)(86362001)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2915;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: t8fbkTOzBhaD6cvvMCD5lmCUFWOeqfNBsWVUdRzXTMBDm89I8ONR4fz/zn8pxZTiUmXOmP/9JgGtHzWYK4nlttLasjMzVEdt5WsXyNmeCVgYZK+5dm7vcEHSLFcdZK6oo4LvJrl80j0C4b0r9FjJfkU+xauUVGUL+YbOZLGS3CUEY83cuAjbuAt0F8t1D88YApYyG2vUXnTk795zKmfnGN0qS9N97XTHjqu81EDj3bqjBmk5ymoZfNVwbBH6ZnA1GWhPsAZ9UB+19LpBP6FUuwu0ZvUupFfAdWH77GZ2UU6j+6QJUcUNmue6TpDG2KXA
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e168d0-36d8-4769-56bd-08d6752f26a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2019 06:04:26.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yinbo.zhu <yinbo.zhu@nxp.com>

Remove USB errata checking code from driver. Applicability of erratum
is retrieved by reading corresponding property in device tree.
This property is written during device tree fixup.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@freescale.com>
Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
 drivers/usb/host/ehci-fsl.c      |    7 +------
 drivers/usb/host/fsl-mph-dr-of.c |    6 ++++++
 include/linux/fsl_devices.h      |    7 ++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 59ebe1b..2aa408a 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -304,14 +304,9 @@ static int ehci_fsl_usb_setup(struct ehci_hcd *ehci)
 			return -EINVAL;
=20
 	if (pdata->operating_mode =3D=3D FSL_USB2_MPH_HOST) {
-		unsigned int chip, rev, svr;
-
-		svr =3D mfspr(SPRN_SVR);
-		chip =3D svr >> 16;
-		rev =3D (svr >> 4) & 0xf;
=20
 		/* Deal with USB Erratum #14 on MPC834x Rev 1.0 & 1.1 chips */
-		if ((rev =3D=3D 1) && (chip >=3D 0x8050) && (chip <=3D 0x8055))
+		if (pdata->has_fsl_erratum_14 =3D=3D 1)
 			ehci->has_fsl_port_bug =3D 1;
=20
 		if (pdata->port_enables & FSL_USB2_PORT0_ENABLED)
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr=
-of.c
index 677f9d5..4f8b8a0 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -225,6 +225,12 @@ static int fsl_usb2_mph_dr_of_probe(struct platform_de=
vice *ofdev)
 	pdata->has_fsl_erratum_a005697 =3D
 		of_property_read_bool(np, "fsl,usb_erratum-a005697");
=20
+	if (of_get_property(np, "fsl,usb_erratum_14", NULL))
+		pdata->has_fsl_erratum_14 =3D 1;
+	else
+		pdata->has_fsl_erratum_14 =3D 0;
+
+
 	/*
 	 * Determine whether phy_clk_valid needs to be checked
 	 * by reading property in device tree
diff --git a/include/linux/fsl_devices.h b/include/linux/fsl_devices.h
index 60cef82..7aa51bc 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -98,10 +98,11 @@ struct fsl_usb2_platform_data {
=20
 	unsigned	suspended:1;
 	unsigned	already_suspended:1;
-	unsigned        has_fsl_erratum_a007792:1;
-	unsigned        has_fsl_erratum_a005275:1;
+	unsigned    has_fsl_erratum_a007792:1;
+	unsigned    has_fsl_erratum_14:1;
+	unsigned    has_fsl_erratum_a005275:1;
 	unsigned	has_fsl_erratum_a005697:1;
-	unsigned        check_phy_clk_valid:1;
+	unsigned    check_phy_clk_valid:1;
=20
 	/* register save area for suspend/resume */
 	u32		pm_command;
--=20
1.7.1

