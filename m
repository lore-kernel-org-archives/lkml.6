Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D401CECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D54208DD
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 01:31:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bk9Hjt8J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D54208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbeIOGsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 02:48:52 -0400
Received: from mail-eopbgr720090.outbound.protection.outlook.com ([40.107.72.90]:59680
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728895AbeIOGsu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 02:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1DCLSSPHAPYJxTyyxJhLn7Ejs8lVyMQLBxx8iIMSIc=;
 b=Bk9Hjt8JGcFVrKPVBTUTHTIvYD8vsGl0eMQt7pJF/JuYMc8PCSFZGCLymgQ7O6p7RiiRMLfTW6/dcSUWpE1Vx/jxp7MKC4+in071UO3Qe3oFXfnJS5Uv4J/OClifB9jLTDNtUgXe7XU1JfCwUfF8YQtGcfmAn1gCACivde/51bw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0470.namprd21.prod.outlook.com (10.172.121.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.12; Sat, 15 Sep 2018 01:31:37 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::151:b6fe:32c8:cccd%9]) with mapi id 15.20.1164.008; Sat, 15 Sep 2018
 01:31:37 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 77/92] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Topic: [PATCH AUTOSEL 4.18 77/92] drm/panel: type promotion bug in
 s6e8aa0_read_mtp_id()
Thread-Index: AQHUTJO4sgPpgNUXuEmTdiKcuYRghA==
Date:   Sat, 15 Sep 2018 01:30:43 +0000
Message-ID: <20180915012944.179481-76-alexander.levin@microsoft.com>
References: <20180915012944.179481-1-alexander.levin@microsoft.com>
In-Reply-To: <20180915012944.179481-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0470;6:orS00zJFGZiofyd4yc71f01I0MSq3EJk8cTNI5XhNoDfkgXq6YOYgGR8DNnHdeWl91sKpj5n5CwBMg9bZHK43R/xo8Kkp/l3mtcXrnJqOWb9Fjb4/0hQIubuZ1ESo3cVU2BS8QNrMc82zGmC9fcrTF/seglZKTm+Znu3pJQI98I6YP+5T351UMUj938VqoIJlHA+2zmY6AZkQKT/XEL9ffMGVGPqj/is3NR/9t7WCdqFZIfIPLZUH0Rz8YnktrDXn19f4DndOSsUJVEZN2PoAgBWk4m519gFGPIAQNtjydZu5WyZIyq/Y83vYP6OnsgXbu9nWwuWkM3CqEZhhyQezok24XW8H55dbo10yoCof5YAuLAJyjq88j7mYVftOusRKh/kWIcVvgKkuy6U1oUmGgklGMxp75K4ZLyvaNkUnN3kSeiwzQTJ0C1Wtd/kqAUahnDLkhh+ElSJ/1IHh7aanw==;5:ot0Vz3r08vONDRzKC57sALeXuqXVbqKRG0oA6vNvOY5LOrzcvdfx4vv50VnCiM/yjcmjbSnNOz0FgYqg/s7HJvNpbQBzxs5ZSwPpIQw80h9/LC5/qD6shI6qHiU67wna7bSw1FndXdesjdFYYkJe4wnR4jH/WzbzUNAA0ojhWoE=;7:YvISHS1rSgyRIFxKu7+WfcG1y70cyaRi4UTJEH514bRVhEzOU+3YYywN1wQ2NSZ5h6A4icAGKAfN4cmP1YNbXk36iWohazVEfac1VaGqwO13KuEbIIqySfdDyTQ+lqj+1bD7j+PSHdv6RBhNVePbT7Dv2246z3kZJ68Ru9lzpDnGfpnZFCHPuLp74orz18B10stdwifuXxOBs6/zaUa9mJM/7GBSJP6OHRBKm0Omz0X6boXJhHGFH4xichR6VTBE
x-ms-office365-filtering-correlation-id: 29763e5c-3f3e-4574-4df1-08d61aaafac1
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0470;
x-ms-traffictypediagnostic: CY4PR21MB0470:
x-microsoft-antispam-prvs: <CY4PR21MB04704251FBAC52BAD201BB32FB180@CY4PR21MB0470.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(18589796830644)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231353)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050)(76991041);SRVR:CY4PR21MB0470;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0470;
x-forefront-prvs: 0796EBEDE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(136003)(39860400002)(396003)(346002)(376002)(189003)(199004)(14444005)(6306002)(6506007)(2501003)(2906002)(6486002)(6436002)(5250100002)(99286004)(486006)(14454004)(81156014)(26005)(81166006)(8936002)(6346003)(102836004)(8676002)(186003)(2616005)(476003)(446003)(10290500003)(11346002)(97736004)(15760500003)(478600001)(966005)(72206003)(10090500001)(6666003)(105586002)(217873002)(36756003)(106356001)(22452003)(316002)(256004)(5660300001)(54906003)(110136005)(3846002)(6116002)(25786009)(66066001)(107886003)(4326008)(86362001)(575784001)(2900100001)(68736007)(6512007)(53936002)(86612001)(76176011)(1076002)(305945005)(7736002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0470;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: PCIiaByq/B/Ubgz16ME9LQJLYlepf28XTQWl0ygHsysNmQADrF1Eh7Lq/zW6VNtM80Frzyn/PHIpl0N8gPeN/fE5puL+wSRyEWRcBjIHUACN00KpxKkAIjS9OY1hIoUlpX0WQIrymRQ+TYGqKoQFL6eJkwb2vdhe7NvE0KYuBlnZ52VtOXn38CaqVpn364m2R1tTkwWr/DWUImV6uvosNtNPq7RuLJJ06gx/j3r42fyCdr9UIVTDDI3bmA5SyU+eY/wKdJrb/VoTVVngeks6zpJh8iWm6m3jrn/bgnEuRszkv3hgZ9jQDADK2NR+SNquzOzAsFg+TD84/pltYA55ocnrsFxN66zSzjm45gHh+DI=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29763e5c-3f3e-4574-4df1-08d61aaafac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2018 01:30:43.9792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0470
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
