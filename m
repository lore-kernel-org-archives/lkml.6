Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE85BC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F5312083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:36:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="C/J8ngy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F5312083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbeIGFOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:14:54 -0400
Received: from mail-cys01nam02on0131.outbound.protection.outlook.com ([104.47.37.131]:1824
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727776AbeIGFOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:14:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6t77QX2AGsSdKUUZzV6XElAzxnvW2Eoz0aaKf9cjRQ=;
 b=C/J8ngy/wxD1Y8cuLpDvxqxempgEbhHo2qGjeytNyxWWd9ryjKrlbUkL3/AD9vLwfD1FSgLCF2wjjG1FpImGRYdKCPD1piST5QBSqpiSPj733lco3kL7HEj2Em72344m+/XKEwKY0/1jigo6qVEMyDcuF1jQMTKI8BnGh3eBXYE=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0469.namprd21.prod.outlook.com (10.172.121.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:36:45 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:36:45 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 32/88] media: ov5645: Supported external clock is
 24MHz
Thread-Topic: [PATCH AUTOSEL 4.18 32/88] media: ov5645: Supported external
 clock is 24MHz
Thread-Index: AQHURkLIvYlZYLQ7M0W/N1KAaslVcA==
Date:   Fri, 7 Sep 2018 00:36:15 +0000
Message-ID: <20180907003547.57567-32-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0469;6:o34vQE5HckpW0gskzrzj5qj4BtbOjcJfvXZm5ROiAXWQjlZoa6X+rsy+Zp7dQ8lsxxxZyPBcDa7ea9ZwZ2gDjOyQbmJtFSQrKu7iPal+8HbdK/qnF70+tyNfgsw5r3PZqN69O6ieWRduxMc6J58Q7tYCMV1HyA62SouyVvmvdMD3E0JKDzghvRjPMpIb/QApknJ+cdD/LoPkAg27ldsPHLeOs9Vp/DSOOTz2xxUwZIC+qzJNIPJVLkDEoBgnfAQiCeExmn6hjBXEkD+R5M25Gnjp5M82Nx8BL0T8NV+QGmVnQ/iYGQKq2J8oGPhlCF038v6Nt5QXilPDcgKRb+wkQwmxw6DFcp1Ub+FYAFv6fGmNgurAgsZmF8HhkjgCvycvLzcm/5CWaHKwJjTp+fpmo4F9eg1v2Gxl4h/Bb1Kdt091ZaHGxRPA2crwjAg1FF+HffVyrrpXK50Ou+kyi7/dKg==;5:ndCw0vtV1/d+uCIffQaPMvHLiSOSevQAzMuMFDkMFHnMGYAy4Jom24HwGJFc/JR86yHg4k++kgMZige2ds8WO/L0pWxgNCIi8oABi1Np+9vy5PeJoQRZ4FBRQf0Rz0hasQLtv/L0BD1Ubi/Fz1DJ9IEjc0Tj4+5eb3evnpUShD8=;7:rTiyQ3l4aKkh3caZC+QxN1KdFAk9pyl7arXVubGw/PGT5KnDSM+6BAfNDQSXbbfTpPdbjkdeEgRhS68msN9ACV5wn2sx5RH4efHUN7ihc2hHFC1wy3hhXpf9RPhdgu0hWd3/RXiQm5RzygM2ZKcCwUHGA4hDrodwOlOipL4X7n4TTFq2nuunk40ZtMOkaMJj9F2w8GHSfuPxfmv3QzTsa7NAOz1n/d6T7J/LuqQMfUBG1NHOqaAWTPQMPGpbBBPM
x-ms-office365-filtering-correlation-id: 80bfc6a1-83d7-46a1-6827-08d61459fd1a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0469;
x-ms-traffictypediagnostic: CY4PR21MB0469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0469642B844350FB8A896A5EFB000@CY4PR21MB0469.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0469;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0469;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(346002)(136003)(376002)(199004)(189003)(25786009)(446003)(316002)(86612001)(54906003)(76176011)(86362001)(110136005)(256004)(6486002)(10090500001)(26005)(2900100001)(476003)(2616005)(102836004)(5250100002)(22452003)(186003)(6506007)(11346002)(53936002)(217873002)(66066001)(4326008)(575784001)(486006)(6512007)(107886003)(2906002)(8676002)(105586002)(72206003)(99286004)(1076002)(6666003)(68736007)(2501003)(7736002)(10290500003)(106356001)(305945005)(14454004)(6116002)(3846002)(5660300001)(36756003)(478600001)(81166006)(6436002)(97736004)(81156014)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0469;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: +IcbZXo+RRhpw1oTBuWHlKKYx0ggezh4qq5ux6xU6nuqXzveAV4zbHsI2f1qBQCdkWaJWegSwqthcM1ZJ10KmzsMNBZ4ufsFk0gr3CwZu6yoWYtUCEP2zhwpudHyTHwqgFVavrEfpAL2Scp8M/yGTpqM/uN/j7jyzR3cJYdV0WtqRQzmpYX4O0RQYWMVqO6VslB4eTO4PPDV/YdZseIgXAKuGhcN1g5UhdESiCwdr0LIZgRSKWck/KVu5SwLDJBqi8O5c31b4gnRA8mAaUadQ7TJog6Oyybkoj4XYAAAiOVU3hwpUY0SEtv1Q+S2MUd9D4iHNpNtiMWG5zPiOxvYSn0fyM8uV4YR1obsvplbbLY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80bfc6a1-83d7-46a1-6827-08d61459fd1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:15.1176
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todor Tomov <todor.tomov@linaro.org>

[ Upstream commit 4adb0a0432f489c5eb802b33dae7737f69e6fd7a ]

The external clock frequency was set to 23.88MHz by mistake
because of a platform which cannot get closer to 24MHz.
The supported by the driver external clock is 24MHz so
set it correctly and also fix the values of the pixel
clock and link clock.
However allow 1% tolerance to the external clock as this
difference is small enough to be insignificant.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/ov5645.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/media/i2c/ov5645.c b/drivers/media/i2c/ov5645.c
index b3f762578f7f..1722cdab0daf 100644
--- a/drivers/media/i2c/ov5645.c
+++ b/drivers/media/i2c/ov5645.c
@@ -510,8 +510,8 @@ static const struct reg_value ov5645_setting_full[] =3D=
 {
 };
=20
 static const s64 link_freq[] =3D {
-	222880000,
-	334320000
+	224000000,
+	336000000
 };
=20
 static const struct ov5645_mode_info ov5645_mode_info_data[] =3D {
@@ -520,7 +520,7 @@ static const struct ov5645_mode_info ov5645_mode_info_d=
ata[] =3D {
 		.height =3D 960,
 		.data =3D ov5645_setting_sxga,
 		.data_size =3D ARRAY_SIZE(ov5645_setting_sxga),
-		.pixel_clock =3D 111440000,
+		.pixel_clock =3D 112000000,
 		.link_freq =3D 0 /* an index in link_freq[] */
 	},
 	{
@@ -528,7 +528,7 @@ static const struct ov5645_mode_info ov5645_mode_info_d=
ata[] =3D {
 		.height =3D 1080,
 		.data =3D ov5645_setting_1080p,
 		.data_size =3D ARRAY_SIZE(ov5645_setting_1080p),
-		.pixel_clock =3D 167160000,
+		.pixel_clock =3D 168000000,
 		.link_freq =3D 1 /* an index in link_freq[] */
 	},
 	{
@@ -536,7 +536,7 @@ static const struct ov5645_mode_info ov5645_mode_info_d=
ata[] =3D {
 		.height =3D 1944,
 		.data =3D ov5645_setting_full,
 		.data_size =3D ARRAY_SIZE(ov5645_setting_full),
-		.pixel_clock =3D 167160000,
+		.pixel_clock =3D 168000000,
 		.link_freq =3D 1 /* an index in link_freq[] */
 	},
 };
@@ -1145,7 +1145,8 @@ static int ov5645_probe(struct i2c_client *client,
 		return ret;
 	}
=20
-	if (xclk_freq !=3D 23880000) {
+	/* external clock must be 24MHz, allow 1% tolerance */
+	if (xclk_freq < 23760000 || xclk_freq > 24240000) {
 		dev_err(dev, "external clock frequency %u is not supported\n",
 			xclk_freq);
 		return -EINVAL;
--=20
2.17.1
