Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B8ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CE962147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="ckYrK80c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CE962147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeIQI3o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:29:44 -0400
Received: from mail-dm3nam03on0109.outbound.protection.outlook.com ([104.47.41.109]:36496
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730225AbeIQI3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/i9zGxEgm97l4zjOLe8VNVntlMkIYzMW7g6oEhmmAY=;
 b=ckYrK80c+sQCSHbZxdocsgvRigjRNPsPg0CeYq7JeDQDt7+rfsNpzVpPD19nJBYIOGHiOXeV9a4svTPAFOn7qHhUWwqVl3nabvITJNy9F06r7V1V7Ly0ZjrZNTRoWHWdYznbIT9hZjj/yd59bRq8LaxjL0WutvMhXGW9+6vCzGY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0774.namprd21.prod.outlook.com (10.173.192.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Mon, 17 Sep 2018 03:04:21 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:04:21 +0000
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
Subject: [PATCH AUTOSEL 4.14 54/87] media: soc_camera: ov772x: correct setting
 of banding filter
Thread-Topic: [PATCH AUTOSEL 4.14 54/87] media: soc_camera: ov772x: correct
 setting of banding filter
Thread-Index: AQHUTjLvfTvW2yYaVUyeNwzSDs/Awg==
Date:   Mon, 17 Sep 2018 03:02:57 +0000
Message-ID: <20180917030220.245686-54-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0774;6:58MKmkHVluRuyUO0mFigCOBzrkPqLOJUtwERuZu5f62M4R1qLRZEHyE1+/7zw+IYN1NNf4WriXu19ZraPuqQfFNjHPz21JaQEY84Co9BStuevAiD2Hrtx3ceiAc4MMqQ1v3CYGgyZRzgTjtkc6IFcQyZ2r16vaCeTko84im2w9WHMyp1IcN1sh0vLBTwr+kMpLvD0FufakFpiv/1XKSeMwL/qRAj427MDTte6D+HKI9J7Z3RT09TV7ntkzRCTaX5AF0fVcdBISg+Ayu9wmRZ8JG5q0F/+Nq4sPyDZyT69zZK4GO1T5Jds8iDE6XOH0kcHv26wQjBaNvYUXu5ZzCNpfEQvmYtWtpMyFUWxEGVG0KEJVdmIdcKpGADzuzx61mKYALQwCCZjDCWkLqU3X5S8fVbZWUN1HKWfl9WbciWUm6s4/RXdtydHMyL/+aef7GHKEZ/OgRRMeJPj4PXdipAug==;5:SOVoh5aWFXEBZpZLnx4V6RS9MepsodqfxhpR79i8PuNUqh0NIKoZwgevqzDN5mTxLp40XgrbYQBdfnz9vAK6li4XHnga11ylKQr3NhrS1pCpa+dNLGzylkfPy0vYCEbIW2IybAXsPCD7P7O08X34C3OiJBEyDF51R99ynNgKNjE=;7:y7354Gvn2rhbfZ4fwEgXSH39/QJ+hbTCBS3GGaV8UuU8oUeoR4dLzsvpHRGtRg0+/upvD1fd9CpWoMLCv/XPz7afkOXzX7dh6i9AJL3Gj2txSVMfYL/LgwCExWFdNFZOWhmoqAiWIWSgLiG6UKM3B/ktRoFLwdRMY8k2ONWmGlRRbPKauYuk3Q5tSgCE54j6J5owiv07EAh6up6ZlflLfz5jAyu+OuinQCEHFvYWgOhZFMN9XEajfWw96jX9d7PI
x-ms-office365-filtering-correlation-id: 65f0565b-3f79-41d0-c43b-08d61c4a43fd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0774;
x-ms-traffictypediagnostic: CY4PR21MB0774:
x-microsoft-antispam-prvs: <CY4PR21MB0774258D434B13A199877180FB1E0@CY4PR21MB0774.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0774;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0774;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(376002)(396003)(39860400002)(346002)(199004)(189003)(54906003)(105586002)(316002)(4326008)(6116002)(1076002)(14454004)(305945005)(7736002)(22452003)(81156014)(66066001)(81166006)(99286004)(8936002)(8676002)(3846002)(478600001)(72206003)(53936002)(10290500003)(68736007)(106356001)(6512007)(25786009)(76176011)(110136005)(11346002)(476003)(2616005)(446003)(6436002)(486006)(39060400002)(6506007)(86612001)(10090500001)(102836004)(86362001)(6346003)(186003)(26005)(36756003)(97736004)(2906002)(256004)(14444005)(2900100001)(6486002)(217873002)(107886003)(2501003)(6666003)(5250100002)(5660300001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0774;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: xc4eoJyHSYwHv3h29bQHJXGN0d7U83ZsPQ1ond3lTrr1ZSzZeaZg6U7xwu/erogETT4Zp3PKaA8AQ9Rym0zojHVx+RRwdx4eB93VpDN0/fJT9qU+5VOokXmEI8ayDPttifgaUeTmog7h6az6nKREDmiBuwK8mbf5jetEllo83WoQZ+KMw2PWHNsQEMupIn7B2VIltHym7L1ln0JVGNCqARXs7L5XyFTg3XrF//nKHAKnfIlPHs//mWulf13VDOv7xa4OzcvfHhiJNfNqCX4hNDpRo2y2gai8U55DnM3jzS8ea7qsij8WGfrNqjYybNJ54XViWPJt0zyL6JdMLROgHV8U4CH72AUbXndeBfRrbaY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f0565b-3f79-41d0-c43b-08d61c4a43fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:57.6498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0774
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
index 806383500313..14377af7c888 100644
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
