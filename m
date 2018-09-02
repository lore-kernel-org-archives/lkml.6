Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E87C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FED620841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="G0frCJZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FED620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbeIBRUJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 13:20:09 -0400
Received: from mail-sn1nam02on0123.outbound.protection.outlook.com ([104.47.36.123]:20160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728085AbeIBRUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 13:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+FM5Ai4tXQdt3vuqARbLRyx95scwz7lcIpFXjmMb//g=;
 b=G0frCJZyz8MK5jbGJUFW5u9R/yGAa9yQGbRf6MxmLD9ZcHSh9s2aBkZIEO/hlJ+NYpGy9dNKXBTgafof4KB1Q3sfeiAqCpShI3aa2Ax1H1X7LwvDGV8NPBRZV280rn9MhBKeDw1JwPUQgaYGnBYDbOApT76qVUYuiMFUqgD7Zxk=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0135.namprd21.prod.outlook.com (10.173.189.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Sun, 2 Sep 2018 13:04:14 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.000; Sun, 2 Sep 2018
 13:04:14 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Finn Thain <fthain@telegraphics.com.au>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 051/131] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Topic: [PATCH AUTOSEL 4.18 051/131] macintosh/via-pmu: Add missing mmio
 accessors
Thread-Index: AQHUQr1trZZI0RL82Ei/w9r4TpQEfQ==
Date:   Sun, 2 Sep 2018 13:04:05 +0000
Message-ID: <20180902064601.183036-51-alexander.levin@microsoft.com>
References: <20180902064601.183036-1-alexander.levin@microsoft.com>
In-Reply-To: <20180902064601.183036-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0135;6:vrmVRAGD0Pd8VAwZOtUIh7c2+XUgsH/TLcyK+GWEqAuRzlr4bmaDAAgQiSjwbVyN5Eo0pMozo1jHZ0ojc+8f3uTi9HOurbNQ2atrrz0TBSmXqkH/nt+ABwWCRPc5yJ9y1HOf2x9ylvVo5pSUq+gmZ8FKq8DG7K2MZ96CMJEsXoxU2YJBms0mjGO6A4t4fpImPgZcpyqkmXHT0ZBILJXhY/yVPHelhnflbJPT8CJduKd3nkdd6NfceLfc4l5q/CbU99zMJ4B9K7Z+2oG1APwc4Ouz4NeM2s2r/FAMjRbkkz9NcKRxl/aADph2g6yY2XV61pZ9y/MojwWICf8wXm+crGgaOQ0cwcKuljSHMW1QEp67Y6E6Kn44O8fterQ01XnYYAlCTm+IzV0UIqyTeq4fzlRVu6/b7a2BBJ18wy37q1cjpgq29eGzPKlxwieK+sW0GG12mizM9t2W5OeLSXoFxw==;5:qheYjFoIBwIsxTM6UslaJg+PlNWOw/BtHCZvSy0PGgadLH4iITS/SATwy9cmBoZXtn4KgSikRxbfaQW3lufdrBO1aQBLsGETURmUR/7XxEfuV9d66f6beoh4w3uPTRSoDMsPhtkUiA1nXzI9qBalxHWSEmsGGkAOpAfHHcX87bQ=;7:FNQKG2xKKW6sCN1VqCfG8CuQYDvQgBG7cWDhETXbzy+6L4nowOjca988dZ+Tx93bbjH2CuMFvi5K/sf4KTYOm04CxiOSTuYKeCvdeSoNGEC5zVAO3d/KP3wy2/vmkF1E5RoCfwj9BydFbQNMcDYdPHeTajyIqdS9Umrm2OOP904YVqnTg7wc1slL1Y8FKaueMrK/NPsr5RvZRfQc8XvDV9yxdyQJHCIXuI2BZHnrF7vqH3TwEr8O+T9iFUr4hveP
x-ms-office365-filtering-correlation-id: ba66a15f-567b-4fcc-51b1-08d610d4959f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0135;
x-ms-traffictypediagnostic: CY4PR21MB0135:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB01359EC5190593B1FD789937FB0D0@CY4PR21MB0135.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(46150409022019)(201166117486090);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231340)(944501410)(52105095)(2018427008)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0135;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0135;
x-forefront-prvs: 078310077C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(478600001)(76176011)(53936002)(2616005)(6512007)(476003)(446003)(11346002)(36756003)(486006)(106356001)(305945005)(6486002)(6436002)(97736004)(102836004)(6506007)(5250100002)(2906002)(14444005)(256004)(72206003)(2501003)(10290500003)(14454004)(86612001)(186003)(26005)(217873002)(99286004)(86362001)(2900100001)(22452003)(81156014)(81166006)(10090500001)(316002)(107886003)(8676002)(105586002)(6116002)(8936002)(25786009)(4326008)(7736002)(5660300001)(6666003)(110136005)(54906003)(1076002)(68736007)(66066001)(3846002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0135;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: S7/SVWaoaSizRyKkfNwGYkYkCRoyz9vYyb3MME1KU6cvdKockGvmd66UzQRwtKxK58QQ27e0ZF1zNwr8tbmNAYqGVMQXeUGNPo+x+vv6V9WdrkVLHIQ4yyXq1yJrLy8iZMdI491G/OkV7LuAazUO9vdYEc5IGcIUtFaHmQzxSxhBu2+OpUFIAX5l2UQ6+FvV80nxDgDf/JXpMoAHBLS2KGmyt4QAKopR8Ga0BbRHkS3f4O8gg7j2CLeFMPoFj6s+ebthLtRki0BNbeO2Rff2uHbredX8BvnMcyYVt8LI95EivVV24ShDi8Q46FkpKxpeRKM6bmwuGpW0N9KhCxqhL+fB8YupE/QNaWnjzClhfbk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba66a15f-567b-4fcc-51b1-08d610d4959f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2018 13:04:05.0550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0135
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>

[ Upstream commit 576d5290d678a651b9f36050fc1717e0573aca13 ]

Add missing in_8() accessors to init_pmu() and pmu_sr_intr().

This fixes several sparse warnings:
drivers/macintosh/via-pmu.c:536:29: warning: dereference of noderef express=
ion
drivers/macintosh/via-pmu.c:537:33: warning: dereference of noderef express=
ion
drivers/macintosh/via-pmu.c:1455:17: warning: dereference of noderef expres=
sion
drivers/macintosh/via-pmu.c:1456:69: warning: dereference of noderef expres=
sion

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/macintosh/via-pmu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/via-pmu.c b/drivers/macintosh/via-pmu.c
index 25c1ce811053..1fdd09ebb3f1 100644
--- a/drivers/macintosh/via-pmu.c
+++ b/drivers/macintosh/via-pmu.c
@@ -534,8 +534,9 @@ init_pmu(void)
 	int timeout;
 	struct adb_request req;
=20
-	out_8(&via[B], via[B] | TREQ);			/* negate TREQ */
-	out_8(&via[DIRB], (via[DIRB] | TREQ) & ~TACK);	/* TACK in, TREQ out */
+	/* Negate TREQ. Set TACK to input and TREQ to output. */
+	out_8(&via[B], in_8(&via[B]) | TREQ);
+	out_8(&via[DIRB], (in_8(&via[DIRB]) | TREQ) & ~TACK);
=20
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	timeout =3D  100000;
@@ -1418,8 +1419,8 @@ pmu_sr_intr(void)
 	struct adb_request *req;
 	int bite =3D 0;
=20
-	if (via[B] & TREQ) {
-		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", via[B]);
+	if (in_8(&via[B]) & TREQ) {
+		printk(KERN_ERR "PMU: spurious SR intr (%x)\n", in_8(&via[B]));
 		out_8(&via[IFR], SR_INT);
 		return NULL;
 	}
--=20
2.17.1
