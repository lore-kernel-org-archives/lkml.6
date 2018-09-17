Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B541DECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E2E7208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="HiLzIy3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2E7208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730276AbeIQIuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 04:50:06 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:17633
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729985AbeIQI3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 04:29:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DFDmBugIiw7jmI9bgrSsSrhchAFpS60o6BM/33qD3Lc=;
 b=HiLzIy3YdB89eBg9JXd17X6BxRMT+ANVXnsCtPT6N7kq+NuqT9TsM4NiKypgGU3e2cJv0YkDx+7vDCcpPpitNpI5P5c7+LC5IIZIYjxhPLZTzAtEtoFQQUWdqQ2l7EReGlhzAtoO2ETGj+npi/QkZ15G9mkuuyU3DQcCSW9SL7c=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Mon, 17 Sep 2018 03:03:38 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::54e2:88e0:b622:b36%5]) with mapi id 15.20.1185.003; Mon, 17 Sep 2018
 03:03:38 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.14 24/87] media: exynos4-is: Prevent NULL pointer
 dereference in __isp_video_try_fmt()
Thread-Topic: [PATCH AUTOSEL 4.14 24/87] media: exynos4-is: Prevent NULL
 pointer dereference in __isp_video_try_fmt()
Thread-Index: AQHUTjLkwygza8RTqUOYesSmMaOBOA==
Date:   Mon, 17 Sep 2018 03:02:39 +0000
Message-ID: <20180917030220.245686-24-alexander.levin@microsoft.com>
References: <20180917030220.245686-1-alexander.levin@microsoft.com>
In-Reply-To: <20180917030220.245686-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:E5aDtnyuGgWM4sZGElAI7MBiWybWxbp8JIFT+yu13RDsGPAhlb7Xb5PxFhp2VZW4keeLk4UXJJgPCyKYVy2Q2oGNyYvrYe214Ll4vy/D9AYTnltsYdlRFKodPzwW31EVS3728MmwTowMi6dAS5UzRp45xeBrritL9Sgd7SrFTp63asosxTz6dvoXW3TNd3kXP1k4/F0FLjleRDtNYTk3v40Q9CgVKE+q7rEpWragAMOw2VeKo2aMpSzT+fSA1RoLIxWdf64GCgoCd1JHGLJoGNbMRuK1u5bYqAu2Klxwg/EH+tG1Jz1oV+ILqvi9lJgfw2yxZIaEYMfMu1Dofi0sVL8rbXe9V0cYKomE0eKmYyW0fHtL8+I4qBsgJ9+MDNiQLffnY9bZIAMV4JUz37qKBGulc8Stw2Z7vLR7AI64IF/ZydlryLrfVc0kWGjh1aG8Uw/JTdFcf6B4QII6D2YrrQ==;5:gpYtoWoarih13N7h17klY82M9cjOfjmMm2bWGSFdrBxJ/Czzw27azAIC96RvNHoIypptZoDBMi8DiqmYVOwN4oYcw2dmyeyjnSl8RzEFuBu+OBKViwFSbZLwXRrY4dBre8sJqQvaElOYOZHGJTFDE7eR5qHsAszGjtO15gdomHg=;7:z9VRpUYn2E+6bJXAjLQ5CztUUgg3JL8xUfSfVkK8srUQ2OMMXoXWqzO5xQwq8/j9CYMy33cKikRSgWoZbxODUWCwwI11utjAjTEynBmo2AJ8CtZQgGDDGZQqKWl4ktV4NERErCj2HWUex40GAi38JY67JC2Z2YZLsJage2B3SGpac4n+p90lun2RpKWxy/+Ismd0pCxSKg5pRI22FUYLwdKY7ylOcz8OdqY5m3rW75Wbh1T3DSpp5WEbcyi4ieeM
x-ms-office365-filtering-correlation-id: 3b796a5f-c4df-47ac-ad74-08d61c4a2a82
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB0470CFD8BE7FFD1087F46DA1FB1E0@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(17755550239193)(7411616537696)(146099531331640)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0798146F16
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(376002)(346002)(39860400002)(366004)(136003)(189003)(199004)(1076002)(25786009)(4326008)(107886003)(5660300001)(3846002)(6116002)(54906003)(110136005)(22452003)(316002)(86612001)(76176011)(53936002)(6512007)(68736007)(7736002)(305945005)(86362001)(575784001)(2900100001)(256004)(66066001)(8936002)(11346002)(446003)(10290500003)(6486002)(14454004)(81156014)(486006)(6506007)(2501003)(99286004)(26005)(2906002)(10090500001)(478600001)(72206003)(105586002)(6436002)(102836004)(186003)(8676002)(2616005)(476003)(5250100002)(36756003)(81166006)(106356001)(6346003)(14444005)(97736004)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: 28pR0/GUcYea+p9C8XPxhvP2BIBOpCacaCdPkfi6FxoM7DZR4K3dYPT/9PWFt2CjveCFKKawdmEcX8fcb2h9fIw6Xba8+JjCBFeJKsPAtZ8N4WOrwVR4kOUU2WuMRR/JZa3Oppj2DAjhnozpB7A7NbLABVerbjyyFApiDAIOcHpFz0ghy84O/5C6sSY6fNgirz3BuJ1iLs1NxDQZfJcngHpek6hTy55D8KFfaca1oM6JCDS9WJM13lOhrFToz3+EazCnrqeorwplXqmPTWWcKhuBxLbmhMs2uD5gPTOYCThNmASVp1gG1FdNPRARqimdap1CVfxxuiRJaBwRIjFEuWCJs17ehsyu9eRQ8066wZ4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b796a5f-c4df-47ac-ad74-08d61c4a2a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2018 03:02:39.1188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 7c1b9a5aeed91bef98988ac0fcf38c8c1f4f9a3a ]

This patch fixes potential NULL pointer dereference as indicated
by the following static checker warning:

drivers/media/platform/exynos4-is/fimc-isp-video.c:408 isp_video_try_fmt_mp=
lane()
error: NULL dereference inside function '__isp_video_try_fmt(isp, &f->fmt.p=
ix_mp, (0))()'.

Fixes: 34947b8aebe3: ("[media] exynos4-is: Add the FIMC-IS ISP capture DMA =
driver")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/media/platform/exynos4-is/fimc-isp-video.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/exynos4-is/fimc-isp-video.c b/drivers/m=
edia/platform/exynos4-is/fimc-isp-video.c
index 55ba696b8cf4..a920164f53f1 100644
--- a/drivers/media/platform/exynos4-is/fimc-isp-video.c
+++ b/drivers/media/platform/exynos4-is/fimc-isp-video.c
@@ -384,12 +384,17 @@ static void __isp_video_try_fmt(struct fimc_isp *isp,
 				struct v4l2_pix_format_mplane *pixm,
 				const struct fimc_fmt **fmt)
 {
-	*fmt =3D fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+	const struct fimc_fmt *__fmt;
+
+	__fmt =3D fimc_isp_find_format(&pixm->pixelformat, NULL, 2);
+
+	if (fmt)
+		*fmt =3D __fmt;
=20
 	pixm->colorspace =3D V4L2_COLORSPACE_SRGB;
 	pixm->field =3D V4L2_FIELD_NONE;
-	pixm->num_planes =3D (*fmt)->memplanes;
-	pixm->pixelformat =3D (*fmt)->fourcc;
+	pixm->num_planes =3D __fmt->memplanes;
+	pixm->pixelformat =3D __fmt->fourcc;
 	/*
 	 * TODO: double check with the docmentation these width/height
 	 * constraints are correct.
--=20
2.17.1
