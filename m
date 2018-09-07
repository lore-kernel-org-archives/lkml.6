Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 950C2C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4539E2083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="GMjNCVD4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4539E2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbeIGFXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:23:51 -0400
Received: from mail-eopbgr700133.outbound.protection.outlook.com ([40.107.70.133]:49024
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731105AbeIGFUL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:20:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M/Xny0xHHZkT62t509vAq30IrSBUPvZNRWn//IUkcE=;
 b=GMjNCVD4SRI8B+cxPUV0oflRfzCWjF0JOiY66CKgDy3Euj8uIN7WSKdL6FeQk+CnEnhdg4FbxA1HaLHZj88QPSiIge19MTwX4LLBkY6sJk4w6QqWyuiUoebAiSK1ivZXNhjWfySNRm+ZS3yT2MVomExj1oCpJghjdSdiIQ/1M7U=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:42:01 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:42:01 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Dan Carpenter <dan.carpenter@oracle.com>,
        Imre Deak <imre.deak@solidboot.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.4 15/30] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Topic: [PATCH AUTOSEL 4.4 15/30] fbdev: omapfb: off by one in
 omapfb_register_client()
Thread-Index: AQHURkMuN/ezsvNLPke5bQtqdb/d5A==
Date:   Fri, 7 Sep 2018 00:39:06 +0000
Message-ID: <20180907003853.57942-15-alexander.levin@microsoft.com>
References: <20180907003853.57942-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003853.57942-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0776;6:AsXB0ioLCUC1ZBqWmyTA5/Vwmz61O6dz9tNc+2F2JUl9acCspZwK79q/r1HRPVUCStDGovZ8HqJPf/WvhJYK20/x4qa9CzrrsC2gu7LkdkOPSLfjwHTPQesgdYPnqui6aPWwFA/iOQ7FTyhv5cYj2aIMRt2kU0oQY2flvz4nX+rDSmVGUiOISC9JquyH1XGGJm0LXU+7m37aKuAy4tdPH4Poj7qUOgQKUSfTjZ1l7yUPnv4gUM/gU4B6rsjlF+T/CnkkoFNfmrHTdU6nAVfpEmNrGoPJsMA9bwy0SjN1nh7e6fc/skhNXgwDeJ1dAKixyMlJMYXHWwOyCrE1EKcj6PxggjPhvAgo8SoQVj5p90xxpbp9w7NJahoPS+cq7+5fRHDtp/CnGup5bttpD7Zm5WW9MGh9DjukcdjFezeNDScGRce4m57/P8O83TrcGYjG8gk6gznWWO8nRR9YBJw7ig==;5:KzCNurloDiUzlS2oZ4mHfOeOyhYz2kpEUv+ubRUgtk6JskqOy8RAnc71nhp8fdz+vZboOFTWR7MOL74NeFDABQnfA+3TmUDSLM6wtzF4uo/nZO2PsAYQIBr7k4qXl1RMqoG16c3P7I6xIapOAFKuJWc9Ap8YrQCTgib0kZIPBZw=;7:NWB8lzihY0gGVyKva8bfJHnZp1lm7M/cORRUdyMzMjn9CKn+ancC7tAflxyw4np+o2Ue85oSwivwtyGfPOGOIxRqk3jFJX+zbHhbFs3xW8+c2yhrIbQnkSQSxyNBU5fOspHHhlRBietHFvvgUjZBOhR7tG3bblT1jydSxSefVjEIhHVcoIdPu/BpYUAqcFuA//Z/j1/u3foDqh1ED247t/4edeKj/xbIQNH7/ftYG8J1kcgOsuNFeVl3B7JKYhRD
x-ms-office365-filtering-correlation-id: 2569f8a5-5423-4cfb-5959-08d6145ab9a6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0776;
x-ms-traffictypediagnostic: CY4PR21MB0776:
x-microsoft-antispam-prvs: <CY4PR21MB0776F8D679A5E251560FCDAEFB000@CY4PR21MB0776.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(131327999870524)(146099531331640)(7411616537696);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231344)(944501410)(52105095)(2018427008)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0776;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0776;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(6436002)(99286004)(2900100001)(76176011)(6486002)(105586002)(54906003)(110136005)(316002)(106356001)(81156014)(81166006)(8676002)(217873002)(256004)(14444005)(305945005)(7736002)(66066001)(2906002)(6506007)(3846002)(107886003)(14454004)(10090500001)(5250100002)(2501003)(6346003)(6116002)(102836004)(1076002)(186003)(26005)(478600001)(72206003)(4326008)(25786009)(10290500003)(36756003)(5660300001)(6512007)(22452003)(53936002)(97736004)(476003)(575784001)(446003)(486006)(8936002)(86362001)(68736007)(2616005)(11346002)(86612001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0776;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: JARKulzO+y976FxaDUFyzPhUCeM4bYiAT91QytUS5DE6Q9zElLnEfvwO/LgJCdga3oOOx6z6d0c+/xb6OKu+zfkJtEjhdWlzj5wvePbQpe3Bgmh7nG5WM6m57AW4r4qZqB99KmLvcQJijjnSggY3ICn8Astz65daWskOBmNBkaZxFGdwA4/+9MvvpvKjNZKcx7UEJqZ/cPguXSze/RW9FqdaH16tNC4lEk6sCulVh7NF5CAzZ/vuKFd1p6l9iOq1SZ61bgrEh/bK5gEqTHh3KFbPfb9+mU8feOjSUwlyWGgJAOwXV4E1ye9Zt06JHn5qWuKfAveFKPxgr8Wlq8g+BezS6Uql7jXeOP1QG8XTI80=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2569f8a5-5423-4cfb-5959-08d6145ab9a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:39:06.4610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0776
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 5ec1ec35b2979b59d0b33381e7c9aac17e159d16 ]

The omapfb_register_client[] array has OMAPFB_PLANE_NUM elements so the
> should be >=3D or we are one element beyond the end of the array.

Fixes: 8b08cf2b64f5 ("OMAP: add TI OMAP framebuffer driver")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Imre Deak <imre.deak@solidboot.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/video/fbdev/omap/omapfb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/o=
map/omapfb_main.c
index 393ae1bc07e8..a8a6f072fb78 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -977,7 +977,7 @@ int omapfb_register_client(struct omapfb_notifier_block=
 *omapfb_nb,
 {
 	int r;
=20
-	if ((unsigned)omapfb_nb->plane_idx > OMAPFB_PLANE_NUM)
+	if ((unsigned)omapfb_nb->plane_idx >=3D OMAPFB_PLANE_NUM)
 		return -EINVAL;
=20
 	if (!notifier_inited) {
--=20
2.17.1
