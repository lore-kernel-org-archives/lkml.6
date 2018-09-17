Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B22ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D132A208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="MUJsnta6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D132A208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731052AbeIQIlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:41:46 -0400
Received: from mail-eopbgr710091.outbound.protection.outlook.com ([40.107.71.91]:43296
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729676AbeIQIbN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6C50gmcYyKOv1N8lf8W2vsGGpIVZjd7Yy63hMLzo0o=;
 b=MUJsnta6Cp5pVlOPL3nUNvRLvp+VvVHWF9KNVdQ2O6ZMs2cDv2Mte+FpsZ4hN2pVBCyut0mg1qp8X88FY2TAD1R/8utlyyZv/pCkjPvBm8zwAVzy9dyI+yKJw0yedNTlbG1m26p6Gz6rwyhEORjVkZR7K8nOOl/gyq0itZJ2rWM=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0757.namprd21.prod.outlook.com (10.173.192.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.1164.6; Mon, 17 Sep 2018 03:05:48 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:05:48 +0000
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
Subject: [PATCH AUTOSEL 4.9 33/57] media: soc_camera: ov772x: correct setting
 of banding filter
Thread-Topic: [PATCH AUTOSEL 4.9 33/57] media: soc_camera: ov772x: correct
 setting of banding filter
Thread-Index: AQHUTjMWnWQ+IMHN6k6DH++r8A4/WA==
Date:   Mon, 17 Sep 2018 03:04:03 +0000
Message-ID: <20180917030340.378-33-alexander.levin@microsoft.com>
References: <20180917030340.378-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030340.378-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0757;6:oEA+Rv3v31b27PrvfQ01HfliKzsbAqsemgUM1jUpOkvtqmRdOVHJDRNPBxhyQuBHBv8WRvVVWt6pjgcJFdRQZa7vSmwG7d5lWYLeeCfx9n1HFSwdLSEyxwSRdPT68oXaCXg8cdMlffdZnCkcpfJRg0L77DNiuvDJm5jgUkht4snbs7mDuTl79qtKhWpv3tmOGXNgrV8/7k5KGk0DRIjk558LtJWte29is1SRrxnAjGg2RQgc75mtHutSJyYBm6ic8rfAAvVyAA886+8oVG7KCc9aSbyfG/B6cHUM5PtVYf2R0OjtgXrZbTXYbIJXjpNpq+7tyWstyCI4D6nflQBH2nTu0UE/0wsQpxH8UuQeXTeAq6C6+9MI2338cmdmoi+KqK3RL41IHhfRsGG0fVcvZklGBQH8cx5bB+JCSv+sr5chegOueCafrCdV9rFZOoLnXK1ELZ/zQaJDRC2w8m1LkQ==;5:F7nWtGfygzoVRtuFAa4LsvByjpbGMNqEYxRvvyGPg6hp5xbmL2Q8MAFXmGn7CUppYmsE11u7gNQ3Oz4eQzb4S+spZvTA5xcmnkc+ELMoa6yz6Q9Yr8C3ULVJ34atxnKq1XPEVCtIKG0p/fPeemi324ScszhpTdaxlcOohlOkHnw=;7:AH2RGDTKMibdD8y5lgiQl8WqqKqjsqW/DoWfPz1LtjFAWC0pXqv+ppZs6T1hCYFr/ntgPIUF96sQglcT40+VPGeNcT8k49VXyIq8jW0Ocl7zbEHIw68ReRTDDldl31h36MmrqL75lSO0em0kHag9thpUJKqwxiEaacv30qJikSmzVBsZWxOQepJV4MqXoqlBO4y6xWvxvcWvyQDidl2SJAKpiNrLx0kYD1vNZ3HDNIQudZTU5wLkeU8bNaol2Ybg
x-ms-office365-filtering-correlation-id: c1574b23-d8dc-43ba-1080-08d61c4a77c9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0757;
x-ms-traffictypediagnostic: CY4PR21MB0757:
x-microsoft-antispam-prvs: <CY4PR21MB07571506244EB4952119CB8CFB1E0@CY4PR21MB0757.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158)(95692535739014)(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0757;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0757;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(346002)(376002)(396003)(189003)(199004)(8936002)(68736007)(476003)(10290500003)(446003)(53936002)(11346002)(6512007)(486006)(86612001)(6436002)(1076002)(256004)(6486002)(2616005)(14444005)(81156014)(81166006)(7736002)(8676002)(217873002)(478600001)(305945005)(3846002)(6116002)(86362001)(4326008)(106356001)(66066001)(186003)(36756003)(99286004)(76176011)(102836004)(107886003)(26005)(2906002)(5660300001)(110136005)(54906003)(10090500001)(22452003)(72206003)(2900100001)(316002)(14454004)(97736004)(105586002)(6506007)(25786009)(6346003)(6666003)(5250100002)(39060400002)(2501003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0757;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: OJPgkj/PJ8e8QNOvHR6I0w7CLl6EjLdT+USKS+EjfKkAZGt7PhCuupND04zx1nMF4kLJdeL1TTB4dFHlz+f9wqdzubnyBkkGzynTO8O0hAAX0hGfywdxdzARqr9XB//xsEo1IaJbQptXI3EmNxKrTi5XUW+cqAtI7S49p87fx231aLyvALOVTgAHoKCZv0eN8XuZ+1kWwJfQPeZgH3qI8rpQl+UP/lZVC6wZ8V5Jeq6SyuB+CLLlHq9oWkjTpAWxvl7rGLuOBiHcVQ1q2Y+9kTuRf4JZSSkNAHk71QP5UCdOTHO6ZE19p7aqJgcc2v3erJ+qe9Xkfb+zffg7tAlvlcCvQF6wPNxs9QhGS210rxo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1574b23-d8dc-43ba-1080-08d61c4a77c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:04:03.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0757
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
index 7e68762b3a4b..fa1cb246a66a 100644
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
