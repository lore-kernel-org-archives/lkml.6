Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0ED9C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DEC22083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DZHJfMny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DEC22083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbeIGFQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:46 -0400
Received: from mail-bl2nam02on0139.outbound.protection.outlook.com ([104.47.38.139]:49760
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730003AbeIGFQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hZf72DjFMOPgpPeBEZKZspQ60Zt002lVgbhosjloBbc=;
 b=DZHJfMnyTejUGEOlLbew6ajzQp1YDPidtCgu3weeaqY+OAYdXDI2JGL8WwWK3Zi91ztWxVKTRUgWLY9lPLAw8UmbN5OWp6YApr2hHrqiFSQy12YIdVe4g27FKdbL7aJMgnMH1aE5HhG0mBk3yzVMwUGi17nG7MWTSWC+rT0DY50=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1143.1; Fri, 7 Sep 2018 00:38:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:38:21 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Todor Tomov <todor.tomov@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/67] media: ov5645: Supported external clock is
 24MHz
Thread-Topic: [PATCH AUTOSEL 4.14 24/67] media: ov5645: Supported external
 clock is 24MHz
Thread-Index: AQHURkL59gzUPA3AUk6ghOpkAzUblQ==
Date:   Fri, 7 Sep 2018 00:37:36 +0000
Message-ID: <20180907003716.57737-24-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:7CLtiRmvE79NdyuUWFvlN/QnqayJyKyPTYQt+lVh2lFDIRaHpYP9KRytpwSRl727i1tCF3QW6FrUwHBBK7MeMR5MeKPoHouF0ZFe+akPr1g/tHx0MNygdqSFfgWNaQGfYAVMZyzuZEjU3NTGblUHNDrQRt9FNh0eBqt8esgZBz59Hwe++S38eD8vmyJxG4VlfPeCuP3c/mregHMxwqwePPsd+Ex5ccK4xMDo/uVDqCaaoBFBk/GC1HdQRI8WGZSO7kvPbfHnPkypsS+hQ6hAhvFzXGwzs6tf6Iw0MfvqrtEBsxvMagiJviqi54dVkds1d3eEwh75nISOUs5VXiZT17ifHJ20zMsPcMXwYKXdvlTPe+md6vN+OuvS2KjJv1PLkBnFAya3jb5KMF2iMEhzNdeUCNWFUwYC8qYvZYRsFIS5toouCeR4wZYzMSK6T8HSgK6NxkrrOngXbqhjaX8G+g==;5:HBlK0lBaKawuB/y+wXkDgw5Gk4N2wKK2ysGg5Dm4XKnDgR2dAE47x4YP0mLJXpSIuMBbN6A8oqttR2eXfq+70WGUCeRoBsroG2Su3RoQT2z/NeFhOti7XGBsCkX1PfazqghFZQKD65LNT2pJSEc8YYG8A3cnIg1tcKzj1hefWRo=;7:J0nJGKcGPPHbvWAcIkkUNTg2617+ussBxhRvpnlRvWtqvhT1zshs/8NaayBkGFg37L1w4DLsKBMpKG1VWml5Cv4gK+6cU2z/45LnzWNz2BZVVR4hErhGS9x2aoVRk9CQyebc2Ysrga3vGx4oYqXIQW5eSQkDV+hmW3R2gvaQVGK4mbxGiloHl+gJkjwx9pEMMjZeeWEJfigG9WUKATiiObXlOoBs8I8TGxZ4JypqNCuQQvEZh3WvlH3NdEcdLXmG
x-ms-office365-filtering-correlation-id: 6de4031c-1f0c-413d-0c7e-08d6145a36b5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB0757F6C490F51804DD67640EFB000@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(136003)(346002)(376002)(199004)(189003)(8936002)(3846002)(81166006)(86612001)(6666003)(5250100002)(81156014)(486006)(99286004)(6486002)(106356001)(10290500003)(107886003)(256004)(26005)(11346002)(14454004)(446003)(76176011)(6346003)(5660300001)(10090500001)(110136005)(2616005)(66066001)(186003)(476003)(72206003)(2501003)(54906003)(575784001)(316002)(6436002)(86362001)(97736004)(53936002)(22452003)(6506007)(102836004)(8676002)(6512007)(2900100001)(68736007)(305945005)(7736002)(217873002)(6116002)(1076002)(25786009)(2906002)(36756003)(4326008)(105586002)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: GGd+T2nUlOgev27NCI51bNbS64jwweOCDp/tEALNflhX0u1beS0tCJN4lMi3cwuFFJ3IFoACNdPd4S4SxBh+PSFtqA9v3xCe5lG8e82mipmQUs5EK443g0Y5lufVyejl1cHVLtRE2gj6ZlWr9L8map7CvyyKRuO/rAlE10fV9SQVZneUkmQcPnl39dqJWOvrC4FrgTJta/CgLDR/3ma1zSPAL6SyvodusvPKFWmYC0Gqthvo9iJHuve91NpsxTxtEoJJi07H991pngvy0XeGoUKkoJgl4RK/Bf2gukBsqqMAt21lmDqTgDAlfnT0QtVFXHsV8zuefA7JSi7s90tE/RRsBof/Cr9+NinVBRkd0FM=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6de4031c-1f0c-413d-0c7e-08d6145a36b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:37:36.8680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index a31fe18c71d6..2d96c1849759 100644
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
@@ -1157,7 +1157,8 @@ static int ov5645_probe(struct i2c_client *client,
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
