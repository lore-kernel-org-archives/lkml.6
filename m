Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC2C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838E82083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="PonWIs3t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838E82083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730022AbeIGFdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:33:15 -0400
Received: from mail-eopbgr710095.outbound.protection.outlook.com ([40.107.71.95]:48060
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729651AbeIGFPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZtqEo0auScFL5ZGU3snpMFuS81tNGBB0cUb/5OYotk=;
 b=PonWIs3tAD0D/jsg5WZOoQUxsTGhJZXfYimwEn+fVOInkR63r7Ekh8Gi2aDan0nLRa9kbQMYGe/YhHRHZG5jB5vM5oeOyU3i5nM9bbYIecfAP/MnsbjAij8kxJIfAauqpl9ga6siIaoKMzBf7/+xCkdpTVLLA47+v1jZqqzTAAs=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0839.namprd21.prod.outlook.com (10.173.192.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.6; Fri, 7 Sep 2018 00:37:39 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:39 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jiang Biao <jiang.biao2@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "albcamus@gmail.com" <albcamus@gmail.com>,
        "zhong.weidong@zte.com.cn" <zhong.weidong@zte.com.cn>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL 4.18 85/88] x86/pti: Check the return value of
 pti_user_pagetable_walk_p4d()
Thread-Topic: [PATCH AUTOSEL 4.18 85/88] x86/pti: Check the return value of
 pti_user_pagetable_walk_p4d()
Thread-Index: AQHURkLeadmGhlrCUkGnKUGrVIDcQw==
Date:   Fri, 7 Sep 2018 00:36:51 +0000
Message-ID: <20180907003547.57567-85-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0839;6:UDmbvS7uVjV5+OurezpBKhLQUGtn0Dj5Lo4IUNYUDrTVp2+ecqrWOeCRuBQWVve651QkUaAyyXULLVAhavTPboq92ApC/gOyQuFOC7LwkyvoDYdHTS9JAknzr4pqJnNgWFtLVjvpEdiZfG9EbDl/zCHTCDXiuLJa+g4uV5ikxP4JKkaoPIwwt61aZ5uGU9le4HQb7aPIpjbLJFQuijxuvUoYKpo9tsNJU9+z05toj1ZAdWw51nD6LHU80ceduhgfTU9hnmzXT6BEIBDbgFB8zEG7JbdLgLloZOd44w6z+OHic4FdlUZkhKB6hJ4gDGh8eclfb6AcGZ6Gkt9jqSBhRdJrAKdbulHQye3go0iOydeMoLX56338h79Y/pDSYhc4ZoA2RNQzGwy9PKxTCk292kQLPvVYGuoPsvXO3eEz05qQH1GISAIFfM7R1BCVp1dW03Dkk+3khsuc7cnv5BUCWg==;5:kBOVvTFRtaBpPiZBbm8nTfGiddSJpHWq61ZYNRSlnw+gMv+UKzyoLOrc9zYEnFFsn90OYfvEPoKX9oQEr0EP/sw1aqf+MMsvL+NeCfg14NnSFm2f/tIZpaGoA7Ev/zaNpqks3adnM/ODk0HJDeB1I3qANqaNAMq3Ihidv6BXyDs=;7:K8b/RdZSFNnC+XeGWLZIutivXSjD70Vfcx6Tn/fqd32XdiXYmAZZvJ+ZZ4h+JvVb2DLs7RYIdyhbfn6gqlqrOIlId7ZT+xAK60QYJLD8oUkpLdZRez2O+Q9Sa/pRfnyC8mXnWGbcba91pRTwRzih28tCu0IQ1LuDsjPdrdPoqwOXbv/+6Qt4gUVDQXwEGYxC/zjVePcwyfZ4HWBP8QEONzGy2u3El5YeTPsEo9ghOHPYvCDz4Czcx8Ljh0KJ4Ii+
x-ms-office365-filtering-correlation-id: 5d7af250-98c8-4847-c16a-08d6145a1dca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0839;
x-ms-traffictypediagnostic: CY4PR21MB0839:
x-microsoft-antispam-prvs: <CY4PR21MB083914F1B92CA5F70C8C0370FB000@CY4PR21MB0839.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0839;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0839;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(136003)(346002)(39860400002)(189003)(199004)(10290500003)(99286004)(10090500001)(105586002)(106356001)(102836004)(15760500003)(76176011)(6306002)(97736004)(6512007)(53936002)(2900100001)(6346003)(316002)(54906003)(110136005)(256004)(14444005)(26005)(6436002)(107886003)(2906002)(86362001)(186003)(478600001)(5660300001)(6486002)(446003)(476003)(68736007)(7736002)(86612001)(11346002)(8936002)(1076002)(966005)(22452003)(25786009)(2501003)(36756003)(2616005)(486006)(81166006)(81156014)(66066001)(6666003)(217873002)(4326008)(6506007)(5250100002)(6116002)(3846002)(305945005)(8676002)(72206003)(14454004)(39060400002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0839;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: yJJaLvdW1Qt8TAqoFe7sZNHqo6Te6itG5wLknkgGiX/tkB1hiG3GwoXp84XMX9wmbgIrZUoa2XqXaP2LPLvfX71cs4I5FBLVgtpZxkXQZcJOZxyNdVTRTXtgoqBisddeb0HYJMi4mIeBm/pjYHPvS0jWlfkIquBa4zcxyKCw1eQrM+13ehNpKTtiFDQwAgNtWhdh19yxaAW4N4A/871dX7FUhhB/t0Rg1XuJt39vNHYfw+mYJfby7U22j7dNv/ehQoiz7ot/pqUm0J2lkOB2cRES9bTuxj6jOXQ9pVgobrvCG6CcG3MNLsl+SRX5d4O89Kb6fnDh1w1c1Qh9w5K68LRC8NG0I8/05gf8R8rwXxE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7af250-98c8-4847-c16a-08d6145a1dca
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:51.4157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0839
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <jiang.biao2@zte.com.cn>

[ Upstream commit b2b7d986a89b6c94b1331a909de1217214fb08c1 ]

pti_user_pagetable_walk_p4d() can return NULL, so the return value should
be checked to prevent a NULL pointer dereference.

Add the check and a warning when the P4D allocation fails.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532045192-49622-1-git-send-email-jiang.bia=
o2@zte.com.cn
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/pti.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 946455e9cfef..51abd8292b6d 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -177,7 +177,7 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned long=
 address)
=20
 	if (pgd_none(*pgd)) {
 		unsigned long new_p4d_page =3D __get_free_page(gfp);
-		if (!new_p4d_page)
+		if (WARN_ON_ONCE(!new_p4d_page))
 			return NULL;
=20
 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
@@ -196,9 +196,13 @@ static p4d_t *pti_user_pagetable_walk_p4d(unsigned lon=
g address)
 static pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
 {
 	gfp_t gfp =3D (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	p4d_t *p4d =3D pti_user_pagetable_walk_p4d(address);
+	p4d_t *p4d;
 	pud_t *pud;
=20
+	p4d =3D pti_user_pagetable_walk_p4d(address);
+	if (!p4d)
+		return NULL;
+
 	BUILD_BUG_ON(p4d_large(*p4d) !=3D 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page =3D __get_free_page(gfp);
@@ -355,6 +359,9 @@ static void __init pti_clone_p4d(unsigned long addr)
 	pgd_t *kernel_pgd;
=20
 	user_p4d =3D pti_user_pagetable_walk_p4d(addr);
+	if (!user_p4d)
+		return;
+
 	kernel_pgd =3D pgd_offset_k(addr);
 	kernel_p4d =3D p4d_offset(kernel_pgd, addr);
 	*user_p4d =3D *kernel_p4d;
--=20
2.17.1
