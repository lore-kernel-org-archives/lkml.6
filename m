Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA3AC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C87320835
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:32:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="cCuyFCpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C87320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbeIBRsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:48:22 -0400
Received: from mail-eopbgr700093.outbound.protection.outlook.com ([40.107.70.93]:58944
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727495AbeIBRUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4TYWnHFff13cry22N/YF76e/4CXky+ZM3RMMX0SpmYo=;
 b=cCuyFCpzaFY1tYRSIwF/QIMIBc5mQUTNMQjTSjtdlgctJGNRy32rO/SNaPDg/IdhTiOP+0ieGwyhjbiiql0m2RfkE/gkJhQbtR8uhQ8xp3O1nHhR5jRIVKZotvD5ko982WVB1IJ1ya4Mnmbipl2AbQz1aqUabqI/4c36neCHzEI=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0120.namprd21.prod.outlook.com (10.173.189.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:50 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:50 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Huaisheng Ye <yehs1@lenovo.com>, Dave Jiang <dave.jiang@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 065/131] tools/testing/nvdimm: kaddr and pfn can
 be NULL to ->direct_access()
Thread-Topic: [PATCH AUTOSEL 4.18 065/131] tools/testing/nvdimm: kaddr and pfn
 can be NULL to ->direct_access()
Thread-Index: AQHUQr14PZFi1zgWskWI984c/w5Yyg==
Date:   Sun, 2 Sep 2018 13:04:23 +0000
Message-ID: <20180902064601.183036-65-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0120;6:5iqf6y/5SzXcmZUbInke602z5ff2ouJORrRHKN/rSSIPGqYwfTknxguRHyNU2YWBEoz9Vc2wgv7JHYYTINwna8cqRHpwTdT1owHvw2yk4CcIE0iRHdVK5xzYctbHBG+kPlknnuuZJIaGTM5QJRQwhKMOXqHKPOImXdzhkIt9QXfQn1frZpK63qyHH/IQVJYyB+ByvbU38rXlXKphwVOXqRORTam6aURguzmDEB1ESy98gGvHEidzLv5565kyH19OX/o2ZThC3uhC4Ct+ghCB++GZD5Mloliqmt7/Rh+aJK9getCpximzt5etfcupzzl7adZeT6kkni9vy6uFDZVXl6Apc3H4afbKjTpsyC8j+TpLRseABjvYixdgnSL1Ym9Q8+EaotpcaWemzpdEkccSsOkrpycGCrweLuua3Vg3i3ZHpb9/04ljgqIyoC69rT3L2SftRlx3BMPDmb2rSrGKDQ==;5:sGWPnVcSkSDG7/0uSkymmiYciN9YbcB/QC/aIZtzIOp8UOT2Kv9hav4bqd5o5GPGYJOP9LgNZIac4ZrZI6EtCSy1GlXBKJ/3d3h/2qawnu1tfOXwFcFbslVreMoZ4QmuSxeIRvZpFXvMi1uKz1gZ2Qnl86E/n0HuVpcimTB6fm4=;7:qRubSf/s0GjLwOQCYo4UlyoOgZomLT71JqARJ6ySGD9GCrJebAq5JWxeUTy6WLZmL+JRevTx/EXe/DvD0K0/UKo7NFsoI+d4A0Lsxr6KHp4OyOB+jfwhuZPw+YfB3F+5wxi57PW9qGU8nDxbYUthebDA61xKUd4ESsERX75q/BvE84G34p1DJbdmpyRfzQllTXIUQ5Dw7cZP4yygMylqi876wOVkn4GUrl0LlveMEe+vjB3dkkFFUsNbkI8hbDN6
x-ms-office365-filtering-correlation-id: 25d7e673-d6c7-40b3-be9d-08d610d4aaea
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0120;
x-ms-traffictypediagnostic: CY4PR21MB0120:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01208ECC44195231D46954BCFB0D0@CY4PR21MB0120.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(3940261145250)(89211679590171)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231340)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0120;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(376002)(366004)(346002)(39860400002)(199004)(189003)(110136005)(5660300001)(107886003)(26005)(6506007)(6666003)(2900100001)(8936002)(68736007)(66066001)(99286004)(76176011)(217873002)(2906002)(1076002)(316002)(3846002)(6116002)(86612001)(14444005)(54906003)(6436002)(305945005)(7736002)(256004)(575784001)(86362001)(6486002)(25786009)(10290500003)(478600001)(14454004)(476003)(22452003)(5250100002)(97736004)(106356001)(72206003)(53936002)(2501003)(2616005)(446003)(11346002)(6512007)(10090500001)(4326008)(36756003)(105586002)(102836004)(8676002)(81156014)(81166006)(186003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0120;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PpCp5iU7x0vs9e+Vuvjpp1Z62A4fo3JsFkWo9PhFe+KDuDg8aiU+c+sSMbDTqGFy3SpvLksP11TfV7JY7FKMqC5H2QMow7YRnjkTC+sIns/A/6dllXEUoKZd7jhvsqCPgqm01hzS+gwvHjnKsP4eaLW9o89iq5mu6r90kDYBBGfNvNqUhAf3a6ue6kH/yFtHGouvskIDUS/r00lQ9q3epitB3PVJYaWQboqf/sr5H97EE8q1iakFfTzIzlNT1rtFgoBMn5j/BVQ65tWOlH1uPc8888O8XyrvzLOIqZkVkYY0YyYuwhrnjz8WRKbjOyEEFdm2QQ4o0lfIWl80gM+ZCTu86veRLn+xN8+o8ON3zOU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d7e673-d6c7-40b3-be9d-08d610d4aaea
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:23.3451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

[ Upstream commit 45df5d3dc0c7289c1e67afe6d2ba806ad5174314 ]

The mock / test version of pmem_direct_access() needs to check the
validity of pointers kaddr and pfn for NULL assignment. If anyone
equals to NULL, it doesn't need to calculate the value.

If pointer equals to NULL, that is to say callers may have no need for
kaddr or pfn, so this patch is prepared for allowing them to pass in
NULL instead of having to pass in a local pointer or variable that
they then just throw away.

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Reviewed-by: Ross Zwisler <ross.zwisler@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 tools/testing/nvdimm/pmem-dax.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/testing/nvdimm/pmem-dax.c b/tools/testing/nvdimm/pmem-da=
x.c
index b53596ad601b..2e7fd8227969 100644
--- a/tools/testing/nvdimm/pmem-dax.c
+++ b/tools/testing/nvdimm/pmem-dax.c
@@ -31,17 +31,21 @@ long __pmem_direct_access(struct pmem_device *pmem, pgo=
ff_t pgoff,
 	if (get_nfit_res(pmem->phys_addr + offset)) {
 		struct page *page;
=20
-		*kaddr =3D pmem->virt_addr + offset;
+		if (kaddr)
+			*kaddr =3D pmem->virt_addr + offset;
 		page =3D vmalloc_to_page(pmem->virt_addr + offset);
-		*pfn =3D page_to_pfn_t(page);
+		if (pfn)
+			*pfn =3D page_to_pfn_t(page);
 		pr_debug_ratelimited("%s: pmem: %p pgoff: %#lx pfn: %#lx\n",
 				__func__, pmem, pgoff, page_to_pfn(page));
=20
 		return 1;
 	}
=20
-	*kaddr =3D pmem->virt_addr + offset;
-	*pfn =3D phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
+	if (kaddr)
+		*kaddr =3D pmem->virt_addr + offset;
+	if (pfn)
+		*pfn =3D phys_to_pfn_t(pmem->phys_addr + offset, pmem->pfn_flags);
=20
 	/*
 	 * If badblocks are present, limit known good range to the
--=20
2.17.1
