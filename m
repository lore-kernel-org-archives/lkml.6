Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74069C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16E472083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="atyrmWUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16E472083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbeIGFQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:16:00 -0400
Received: from mail-bl2nam02on0116.outbound.protection.outlook.com ([104.47.38.116]:36192
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbeIGFP7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2MdMHzc+/3tMEWieVBz3mvAmzC8aNQnYN7oeXEzFcM=;
 b=atyrmWUejm1816dvOHLikRQY78PDtQ8T3ScKBfm4D0qX8oWb/R8e/Ym2xvmDv+q727hKWDEK2ZqhWF64C7RM88BxwiL9shUx19lEhIxbgydiFlv3V4cRONL69qsOToaUWS/VjR3gRXpMCO4Oaebpb7zrljfNy0p7tsbpZWZ+m3s=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Rex Zhu <rex.zhu@amd.com>, Rex Zhu <Rex.Zhu@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 79/88] drm/amd/pp: Set Max clock level to display
 by default
Thread-Topic: [PATCH AUTOSEL 4.18 79/88] drm/amd/pp: Set Max clock level to
 display by default
Thread-Index: AQHURkLcRRSKg/5WIk+/vGWjHBHe9g==
Date:   Fri, 7 Sep 2018 00:36:47 +0000
Message-ID: <20180907003547.57567-79-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:T8nmk5pzb8LqRflHgOBKrgpGWvfJ8jsGo4UFnyecnO5RqdLd/U98I/nW46SyxSttXt2nGp2XjwIFHvd53NEuqpee4TYMn7af89F6c97hlBKVAqpOVQWfDf/O1VCsKgOIsmWP3WMy7W+2yn6KVNkGK9kuqrjFDp5xXfBEGCFVjMN9vKtkjjMmNHN3a7dG6F/eWfyP1RsHYFl+2gA+gRwESoO+eb+061Q3kQQm+mR3kg/mbcm6Ya85gpzauFVfGXQNZwHPLfc9yNQQLnWpUAMl4Jki6xjXmTcuZr5UjyiUiFf5wQimlT0+b+IHK7wg3wxMDD9eyR8MYvg5xXQCYj/xddw0YQvf1oLZ9z4BQV74PK6ZS2P5qyzEicmi83DDV+gAjmc+W068ylAOXc08aq/M/1z4mwGpSOynpGe9UR7iAnqxcXGrRF3AfbXrBDJY+vc67qM03wXn7wi+tbQEZZ78ZA==;5:U/RgKjQP4K3j7N3wT9ti895csLeNOmdrWGdLO9UzIlrEiPs6kcaUnjhYkAJXifEFefo/ap+PAnCfKz4Q669MCRJQQgj7kXZg6A2bPFedQtjfBufRcU1dC+KLMGWQtDosTmLXXLE+emjlqwzAPUFubfSHKqeG03HSqjfJlHMZWtM=;7:Y2BA3ykf6LzMfkrJg6vbSNR8r2yMkT9aOVmNPnEqNHgL+sh9RI63CCfBDxFug1regqCr6GDolMIAv/WB3QDalv1kISEO0Y++5LExbLliBGCV+jY8v3Yqj7hs/ixhqaDXyI9kMracigxUCq/5TRpZwETJ3haigHZLVkokrbJBpA1itJGntGiDwwi17ov4BZV6h+11N0THvgtL32Kr4ttliHROenqcnGEcV1QOnbkydNOiITc3ktESoCeynkV67dyj
x-ms-office365-filtering-correlation-id: 9c9e5c0d-6de0-4be9-3c53-08d6145a1c6b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB0839D59225C373080963EB55FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(767451399110);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(76176011)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: jarg1+HLn1qL1wbMGDu1016Rdmng3JnyKKO5BxkS2M4gn45iYQvsxF8xhrLbk/83X4PTjwPwo7GFCpgQtSDghAXmm3zGtKFgCowJFF1U1lbDeGC5cpqiQn308J8gzEGAqfnGuaHcZ5CzorZKak83LUESJYD8i8oNkBdjJwkXI0/5Vl0yaznN7CPu0i0B86fU4qpKYmcJKU8FYy5Xjg3RkkujzaQapHiDCLOpXILhAHKSZPzpSjZd3S/bLrgwesK93wvHs56ZoXHLM6rrUeoIm8T7BncAA7DMwCnCi/kCf8RRVAGheVs5eLc5IWk7RP/QhpdYy2W88tqeGy0Q4dt1AUwB9r0KyPpd300BsyzqBvw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c9e5c0d-6de0-4be9-3c53-08d6145a1c6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:47.7577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rex Zhu <rex.zhu@amd.com>

[ Upstream commit 97e8f102f5a9123d30258e196c6c1ea29cf52e83 ]

avoid the error in dmesg:
[drm:dm_pp_get_static_clocks]
*ERROR* DM_PPLIB: invalid powerlevel state: 0!

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Rex Zhu <Rex.Zhu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/gpu/drm/amd/powerplay/amd_powerplay.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c b/drivers/gpu/dr=
m/amd/powerplay/amd_powerplay.c
index d567be49c31b..b487774d8041 100644
--- a/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/powerplay/amd_powerplay.c
@@ -1020,7 +1020,7 @@ static int pp_get_display_power_level(void *handle,
 static int pp_get_current_clocks(void *handle,
 		struct amd_pp_clock_info *clocks)
 {
-	struct amd_pp_simple_clock_info simple_clocks;
+	struct amd_pp_simple_clock_info simple_clocks =3D { 0 };
 	struct pp_clock_info hw_clocks;
 	struct pp_hwmgr *hwmgr =3D handle;
 	int ret =3D 0;
@@ -1056,7 +1056,10 @@ static int pp_get_current_clocks(void *handle,
 	clocks->max_engine_clock_in_sr =3D hw_clocks.max_eng_clk;
 	clocks->min_engine_clock_in_sr =3D hw_clocks.min_eng_clk;
=20
-	clocks->max_clocks_state =3D simple_clocks.level;
+	if (simple_clocks.level =3D=3D 0)
+		clocks->max_clocks_state =3D PP_DAL_POWERLEVEL_7;
+	else
+		clocks->max_clocks_state =3D simple_clocks.level;
=20
 	if (0 =3D=3D phm_get_current_shallow_sleep_clocks(hwmgr, &hwmgr->current_=
ps->hardware, &hw_clocks)) {
 		clocks->max_engine_clock_in_sr =3D hw_clocks.max_eng_clk;
@@ -1159,6 +1162,8 @@ static int pp_get_display_mode_validation_clocks(void=
 *handle,
 	if (!hwmgr || !hwmgr->pm_en ||!clocks)
 		return -EINVAL;
=20
+	clocks->level =3D PP_DAL_POWERLEVEL_7;
+
 	mutex_lock(&hwmgr->smu_lock);
=20
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_Platform=
Caps_DynamicPatchPowerState))
--=20
2.17.1
