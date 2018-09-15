Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FCD8ECE561
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB85206B2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:35:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BGFfpD/T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB85206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbeIOGwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:52:33 -0400
Received: from mail-eopbgr730091.outbound.protection.outlook.com ([40.107.73.91]:18669
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729943AbeIOGwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1DCLSSPHAPYJxTyyxJhLn7Ejs8lVyMQLBxx8iIMSIc=;
 b=BGFfpD/T7opHFVUfHBNwvkMWBxxPfgrx4aTkfcC1MA75CN947x1HBeNtIKu8DYGm2a2Hv50CPQ/fzmrXXNdPM5fxTbMyiRl832WjgsWl4MaSOHwTayOfvfL6DdjCIdUOWLF/MJgFHAYr02qbH8/Mf0ekwxZOHtUfSnsxBZcrHZY=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0181.namprd21.prod.outlook.com (10.173.193.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:35:23 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:35:23 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 18/20] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Topic: [PATCH AUTOSEL 4.4 18/20] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Index: AQHUTJRaXoiacPSY10WI0q/r4Y7gvA==
Date:   Sat, 15 Sep 2018 01:35:16 +0000
Message-ID: <20180915013502.180110-18-alexander.levin@microsoft.com>
References: <20180915013502.180110-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915013502.180110-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0181;6:bNdNQ+xMHfi7JiCHUB2+ZgQ2uLetU4mL6rjIbNo2n+UH6KgqxnnciCl2r4CCSoV3afXmczTRYjIntvI6FoQ8GFoHb9Zif9qSQ9An257+XBt8x51GFHfMaoBSm/L/Ab7NqbiPj7/hkmcMSHzKO1PAMZDwBtTAfWWi4uupsgbB6VHsoVGHad2Xrds1VOlrISbrPkF5XG/dPz3GPS/0p9/2OFbaFiX+TS9pfKOBS2HYvWT/egbkMgEuffIMQb5QQqsDoaohF9hjLH5TjfIIFdwkRHRWPG6r2qq1L5zT8X6KVBt07sFApk/7M/vxrRP3iZeaqVfjbfLSPnAWVTPbAhN8uiIkZrXMB2Be8Tu53QZbTm5DuPPcl4+vKUCZ7DbvEo1DD+WWWYpVp4ZKuQCwMEu+5u3La3Oa6qIjcncubkqMR275/fi7DMsbgzR9499N6DUTpJwRsxXgnaTa46/K3u9QwA==;5:hITHuphxaRsbv3yC3klChtvs+rvTfYLukh7cnWVHU+VG1iIO5F1lX4oLxb6/tRBOPVuAx4UK8qOaMjELjaMw5/1TBQkW87JGSeyaQhKF1YEbohT36KPRFPxl7reW7MyIaAwnGiUd7+i7FCrBD27TJNOx74nhNHLDTOodUVHm1Lo=;7:hmI4LF6d6YRBtx9oAsP8zV/xT1z2r3J63GFaLjj8hXgcEiTt8Ws7vJn/O9tKEsqs9J2qZC19iXD09cbgQSnSHRzCkV+xW5UXc7GIwOS+N7+S2K7g1FkKCy0K3v6W+oluFYN8pcruIsUoBE232CbEM0wcZRwC8dsPUarEii5VYCVlcPIbzWXgKTgPc1X09CMYaTED5A0NYN3p5+S+1dqXt9fmfIIPU4nEjiDVx8jSLrvo3pgmYOZ+gyEqDPp1DZho
x-ms-office365-filtering-correlation-id: 2234b25b-3270-45cc-c4e4-08d61aab8198
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0181;
x-ms-traffictypediagnostic: CY4PR21MB0181:
x-microsoft-antispam-prvs: <CY4PR21MB0181B491A07B6058F73E1C38FB180@CY4PR21MB0181.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231354)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0181;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0181;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(66066001)(68736007)(6346003)(186003)(3846002)(26005)(1076002)(6116002)(25786009)(97736004)(110136005)(54906003)(6666003)(2906002)(72206003)(316002)(10290500003)(217873002)(476003)(102836004)(478600001)(22452003)(2900100001)(36756003)(256004)(14444005)(10090500001)(4326008)(2616005)(15760500003)(76176011)(14454004)(81166006)(11346002)(2501003)(81156014)(305945005)(5250100002)(6506007)(446003)(106356001)(105586002)(5660300001)(486006)(99286004)(7736002)(8936002)(6486002)(966005)(86612001)(6436002)(6512007)(53936002)(107886003)(8676002)(575784001)(86362001)(6306002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0181;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: Hh5+Foy2S1shlYLVrFD5w/oIeI/jXP8IM9AFXgTPinXvLyV1pMsKPGsNrhdc2yFn+XWF+YHVFKFE0ZiEUDU0vXA3mwV3CAePhYHFL/1aVk/7NFOJ0ShIe1DMz7TDljwyuMnDWEKMLPXUd9igq2JdGqkQPMrl/ZxPz3z+nCEgpp88Gcca3AE7UPvM4AEHF7BFPIwnV7ceiXHOGmmg4vnAlbOA3Yd9mRrwBjnZRoBUJFiTGJj05HcyeQcON20Ye86YTKoeAwYClCN7M9n+s37gAV+AnhKfs2p3uaHFAtaoQWIMdaRIQbcjAtF8F22LZ/GuWm+FU6AP0GGqmNccXHx9g+74D5LpHFawPx0CGZJk2ng=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2234b25b-3270-45cc-c4e4-08d61aab8198
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:35:16.1602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0181
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cd0e0ca69109d025b1a1b6609f70682db62138b0 ]

The ARRAY_SIZE() macro is type size_t.  If s6e8aa0_dcs_read() returns a
negative error code, then "ret < ARRAY_SIZE(id)" is false because the
negative error code is type promoted to a high positive value.

Fixes: 02051ca06371 ("drm/panel: add S6E8AA0 driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20180704093807.s3lqsb2v=
6dg2k43d@kili.mountain
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c b/drivers/gpu/dr=
m/panel/panel-samsung-s6e8aa0.c
index a188a3959f1a..6ad827b93ae1 100644
--- a/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
+++ b/drivers/gpu/drm/panel/panel-samsung-s6e8aa0.c
@@ -823,7 +823,7 @@ static void s6e8aa0_read_mtp_id(struct s6e8aa0 *ctx)
 	int ret, i;
=20
 	ret =3D s6e8aa0_dcs_read(ctx, 0xd1, id, ARRAY_SIZE(id));
-	if (ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
+	if (ret < 0 || ret < ARRAY_SIZE(id) || id[0] =3D=3D 0x00) {
 		dev_err(ctx->dev, "read id failed\n");
 		ctx->error =3D -EIO;
 		return;
--=20
2.17.1
