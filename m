Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05818C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC23B20657
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 09:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="k8cHyPB4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfAQJLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 04:11:05 -0500
Received: from mail-eopbgr40085.outbound.protection.outlook.com ([40.107.4.85]:45177
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfAQJLA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 04:11:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZyPCHjFs2TaAsK44ofIRN5x+XjAgXPjL2gMQBoN9cs=;
 b=k8cHyPB4Rt1UifOSzRtfNwUI2RgCYg8gRSnlZ2L7Wm6J2goRgvFAKrK60H+PgPDepOmC7q5X/64DGBPL5bDgz4eZwqbEhVm8LB4NZjur/uapmmkSHM5OXDnoqkhG/lIe4lhe96Tf47WiCMWuHS/CRoJOIW5OS7+LkIO1DPahDfM=
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com (10.175.41.148) by
 AM5PR0402MB2900.eurprd04.prod.outlook.com (10.175.42.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1537.24; Thu, 17 Jan 2019 09:10:56 +0000
Received: from AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626]) by AM5PR0402MB2865.eurprd04.prod.outlook.com
 ([fe80::1c0c:51da:f585:5626%2]) with mapi id 15.20.1537.018; Thu, 17 Jan 2019
 09:10:56 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v2 3/3] drivers: usb :fsl: Remove USB Errata checking code
Thread-Topic: [PATCH v2 3/3] drivers: usb :fsl: Remove USB Errata checking
 code
Thread-Index: AQHUrkSNUYxOdWSl/EKOZYXltk4TRg==
Date:   Thu, 17 Jan 2019 09:10:55 +0000
Message-ID: <20190117091135.44209-3-ran.wang_1@nxp.com>
References: <20190117091135.44209-1-ran.wang_1@nxp.com>
In-Reply-To: <20190117091135.44209-1-ran.wang_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK0PR03CA0043.apcprd03.prod.outlook.com
 (2603:1096:203:2f::31) To AM5PR0402MB2865.eurprd04.prod.outlook.com
 (2603:10a6:203:99::20)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=ran.wang_1@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM5PR0402MB2900;6:nEpWLx8jsm1I3HlGyF84CC3cgu4WT31JBrM8F/v3TKmmS7tJavpIGXoqP2O3TxYIJ8+fgZVmQeY2H51Qwrn1B/cd7RvA2hNNiuhG6w0wMQEXp5HAlXj74lkvLtztKTQOBSKfNvTsgXmfvzFG9mO63aG1JkJ0P3j82U4VG4HG1qSqKrxbO5wnhHcwjwl8jhP38dZxDkMkIv5o65PIc0lGXumNEIq6856+ofz50avNLZvj+3R0cImH02qzlP/Ygm/EaO465vkxO/ldHdamvc16c2tb7aM6814K98ySXkyiP/qwY23sYrA1deqipAfYppEzP84LOqCmSZ5+R6bKQipaZKUZOoeK25Vgw88ESoaOkuu3tgs5iPXBXMhv4ymm7AHQFv4vfyin3ZGsSBtP7fIQqDKrcw4IB1joiQXLjdo62Mmt7kfi6XZLfPSIstv2YxlJOJs4G4Ghni3HUmGOGnJcew==;5:m+9wMhpA0AHmAX3SUId2FhgQu2CypJXCAmDvv5XGLZf93E7adpdgwruDXoNT5nt1onIPDMdzjsZzWhDvthBrKFGGBkMMF907RzzANRxgRB7Bdp2bawuSte4UM+UhYpfz8Sit75b/Q+SXal3FiMK6lBDbnwOYaWIeeWrvBlrrzujUeRb4FIcmgj2xzD92u+7MD5zUFuKORtCgzi+bgkxVSw==;7:0lphOBf12uMPrlDo8ZHoCBL7RVF/TOuskmvCDTgZ3FdoTi4l0KXT619+FT3567UqSJ8nwWTeDYJCJsZHyspKv/1hS6OdqZExvibgX0sGKVCjnC9/N/0XqHsRjgSKQY2VTJa59SX5/pEUKM7bRp++8g==
x-ms-office365-filtering-correlation-id: 83e9554e-2afe-4af9-807f-08d67c5bafff
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0402MB2900;
x-ms-traffictypediagnostic: AM5PR0402MB2900:
x-microsoft-antispam-prvs: <AM5PR0402MB290073BC5B7835FFB0D4E50AF1830@AM5PR0402MB2900.eurprd04.prod.outlook.com>
x-forefront-prvs: 0920602B08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(346002)(39860400002)(136003)(396003)(376002)(189003)(199004)(446003)(102836004)(26005)(2616005)(476003)(11346002)(2906002)(478600001)(14454004)(6506007)(386003)(76176011)(71200400001)(71190400001)(1076003)(105586002)(6486002)(106356001)(186003)(52116002)(6436002)(86362001)(50226002)(110136005)(68736007)(66066001)(3846002)(6116002)(8936002)(256004)(81156014)(81166006)(8676002)(54906003)(305945005)(316002)(7736002)(5660300001)(97736004)(4326008)(2171002)(25786009)(99286004)(53936002)(6512007)(14444005)(36756003)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0402MB2900;H:AM5PR0402MB2865.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1Z3bEuB+HP96MI2lmuAPSrdbmFnCehL6Pnx/TokGBGsYhPunLm682zDogMFyndL83aGfFh4dFCpURfnEp1TB8LLtE5rl9FjjpXXmFu5AXd/wC6s6Gircr2eJGRsTcqvHDgy00WTr0hnTeQH4iPKd1YlJdOPzgw40XuWX4REEU3IiQOHXR/FWIDp1U59VJX9mZx26DPSuYEszYCmI0uQsjHax1LIz/pV6uamKbg3TSpY78hLU9A5zIP9SP9VbEOEjHHuuvMBRh3rQ6g38e8H6ZKRVZEWTjZnwB2xyvkU5VnJW7hCNrY3bfrg6736RZ0BVYBwRNDJHQ33u+fqjVmfyw4XINEPIxqBfRC1rBVlF753c/rcL573DWPbfAZU+Bmc8P1hWjPVkWlhG27QjJksmlPqIiFFyd/Toe+SLe8fyqi4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e9554e-2afe-4af9-807f-08d67c5bafff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2019 09:10:53.5982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0402MB2900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove USB errata checking code from driver. Applicability of erratum
is retrieved by reading corresponding property in device tree.
This property is written during device tree fixup.

Besides, replace spaces with tabs to make code aligned.

Signed-off-by: Ramneek Mehresh <ramneek.mehresh@nxp.com>
Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Changes in v2:
  - Correct signed-off name.
  - Use tabs rather than spaces to make code aligned.

 drivers/usb/host/ehci-fsl.c      |    7 +------
 drivers/usb/host/fsl-mph-dr-of.c |    6 ++++++
 include/linux/fsl_devices.h      |    7 ++++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 0a867d9..e3d0c1c 100644
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
index 60cef82..5da56a6 100644
--- a/include/linux/fsl_devices.h
+++ b/include/linux/fsl_devices.h
@@ -98,10 +98,11 @@ struct fsl_usb2_platform_data {
=20
 	unsigned	suspended:1;
 	unsigned	already_suspended:1;
-	unsigned        has_fsl_erratum_a007792:1;
-	unsigned        has_fsl_erratum_a005275:1;
+	unsigned	has_fsl_erratum_a007792:1;
+	unsigned	has_fsl_erratum_14:1;
+	unsigned	has_fsl_erratum_a005275:1;
 	unsigned	has_fsl_erratum_a005697:1;
-	unsigned        check_phy_clk_valid:1;
+	unsigned	check_phy_clk_valid:1;
=20
 	/* register save area for suspend/resume */
 	u32		pm_command;
--=20
1.7.1

