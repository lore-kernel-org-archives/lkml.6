Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E73EECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6E82147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="euOV/1SP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F6E82147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbeIQIf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:35:26 -0400
Received: from mail-eopbgr720091.outbound.protection.outlook.com ([40.107.72.91]:17664
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731446AbeIQIdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:33:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hsooG36r76oAZjB3VjNMFpvfCODt54KIlcKHNjIS9Pw=;
 b=euOV/1SPPrRQgHb/6fLDqEGo6lHtwzeWn98IXXnWl/KfL8xEQLwlh1rMKCFIqu0THdbx1sor5qVp5kjP1p09K4wW4zz+79CHIv5HkpBjo/sdDQEoVqUt8vh4mwSyhH8csFj29jHJh3id7DpToa5xcBUyb4FzB26QeEyVfSjhVhQ=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0150.namprd21.prod.outlook.com (10.173.189.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Mon, 17 Sep 2018 03:07:53 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:07:53 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Akinobu Mita <akinobu.mita@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 3.18 16/29] media: soc_camera: ov772x: correct setting
 of banding filter
Thread-Topic: [PATCH AUTOSEL 3.18 16/29] media: soc_camera: ov772x: correct
 setting of banding filter
Thread-Index: AQHUTjNUvAOdRFQljUejOUaxLvCI1w==
Date:   Mon, 17 Sep 2018 03:05:47 +0000
Message-ID: <20180917030533.592-16-alexander.levin@microsoft.com>
References: <20180917030533.592-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030533.592-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0150;6:X4GCkkYL/qr3fbaiRNan7/gOPOMAkPMmuFaf16wHV+5mpWGWDMwEMU6g9Oj0nLWePg1Pqn6F/9vAUtTAvIWMB+IrP4o/PbuV/xjIzxi9Ydn6seRkt3B27RzkLc6IsSFK1/tB62msr+PMnUF9LXY0bZXnAJ97l+OMRc758c5OG8davK9AyaZ49Ec/RdmOPukdEywkU2u6mFZB3ADrHBc9+1vzMctW2oeSuQNqV7jrbfrg0G1AXeUoevHU5IZPlU5bLzVC2EkHWxCEXdIbihE0opFYDjPA9A13UrqzCasYd4e+5vfi9nCUkFj+seFDgeNMh2euTcN1o2Kqp5Yrr7gavlUvQUCxab4ZxEYNZQAjsYXmt4juJLOHUCopUBr9PX4+B+qFUq14ndgc1x7I6ye3scOHXY4pvT5KaY4Q5AQzn++wPeFjwbiEo9P2pH/zbYZcug1PcjRQKCT50JFMEbDzsA==;5:UZC2UY5cTeRN28GglhORjSnlfRrcy6s4FvuT7ntUTcw51+vCL03TsbKMFH0bPV2wXfTLU6HJ8n1EVPtBSYtU908bHTKD7V6gEmQy1VCWQz1JMQOQ+BbAQAlpE7mHEDHu9iYhxVCsqw6yerI8CPTuohNgDh4cw5JmwNSRsNsYMbY=;7:81ueP81QzXQ1OHBIacrqDhM2daEqJxObmTepRpzhpJeffk6UYGhaK88uvfi5dxCY+Oue6/F7s+8IYg+dlxI+tGmLvMZAOLNP4gCls7H4Z+h9jjrGq2fXpE1nbgsHuXDArlCCb6t4U0CWBEI3b4Wpg40cPuquMhmQUYimQ2X2xFAQ59Xr5bKsimt1RxEDcdUE2h2D+dLdYPWKdv7bkkCN6GaJHgeW7dG0vNRYGpHvLkU9ifcv+KlAWOayH9o7zo/0
x-ms-office365-filtering-correlation-id: a4b1ced9-5912-4971-8c21-08d61c4ac270
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0150;
x-ms-traffictypediagnostic: CY4PR21MB0150:
x-microsoft-antispam-prvs: <CY4PR21MB0150B8236CE602FD4B566606FB1E0@CY4PR21MB0150.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0150;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0150;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(136003)(346002)(366004)(39860400002)(199004)(189003)(478600001)(2900100001)(39060400002)(2501003)(6666003)(11346002)(107886003)(5250100002)(14454004)(26005)(10290500003)(36756003)(217873002)(7736002)(99286004)(305945005)(102836004)(72206003)(2616005)(86612001)(476003)(6346003)(186003)(14444005)(486006)(54906003)(110136005)(446003)(6436002)(5660300001)(4326008)(256004)(86362001)(10090500001)(2906002)(6486002)(316002)(6512007)(53936002)(22452003)(66066001)(97736004)(76176011)(81156014)(81166006)(8676002)(3846002)(6116002)(8936002)(25786009)(6506007)(68736007)(105586002)(106356001)(1076002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0150;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: qE3igRhWVagBX59fjSo+STzrKY8NijXTzE3NUFO8Y7iBi4z7aGIi5FtMS8GVK3xswGTbLe+SAqp+cx0RTIx3yfcQuPZ973Yx6i+uHIW0REvHAlfNOoIueEEaugwtQEaNMQCha+L3i8tvwU0Z9UhmaPYstwywxO44Q5MqHO1LUvJ4hTvddgYxVJSYKGSpni59QoHlHx1/4AERnjPdOPc004etkvHLFeaWYHIu8vnKuNvJmEZP87dJfpnScHlIJ34bLHDqhx/S1oYTN8wiOxCE3cl+f2iGig2Zx7J4ASBXfd7L3jXRJmGiOYPUtmp5MFoDqe8Hh+lYdO4mGEqU5K32zBnl4iYh1LitQSmfnDMzqjc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4b1ced9-5912-4971-8c21-08d61c4ac270
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:05:47.4046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

[ Upstream commit 22216ec41e919682c15345e95928f266e8ba6f9e ]

The banding filter ON/OFF is controlled via bit 5 of COM8 register.  It
is attempted to be enabled in ov772x_set_params() by the following line.

	ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, 1);

But this unexpectedly results disabling the banding filter, because the
mask and set bits are exclusive.

On the other hand, ov772x_s_ctrl() correctly sets the bit by:

	ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, BNDF_ON_OFF);

The same fix was already applied to non-soc_camera version of ov772x
driver in the commit commit a024ee14cd36 ("media: ov772x: correct setting
of banding filter")

Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Hans Verkuil <hans.verkuil@cisco.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/i2c/soc_camera/ov772x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/soc_camera/ov772x.c b/drivers/media/i2c/soc_=
camera/ov772x.c
index 970a04e1e56e..a08502766474 100644
--- a/drivers/media/i2c/soc_camera/ov772x.c
+++ b/drivers/media/i2c/soc_camera/ov772x.c
@@ -834,7 +834,7 @@ static int ov772x_set_params(struct ov772x_priv *priv,
 	 * set COM8
 	 */
 	if (priv->band_filter) {
-		ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, 1);
+		ret =3D ov772x_mask_set(client, COM8, BNDF_ON_OFF, BNDF_ON_OFF);
 		if (!ret)
 			ret =3D ov772x_mask_set(client, BDBASE,
 					      0xff, 256 - priv->band_filter);
--=20
2.17.1
