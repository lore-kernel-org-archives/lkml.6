Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24307C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C196D20844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="jgyfc7zj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C196D20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729560AbeIGFPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:15:50 -0400
Received: from mail-eopbgr690092.outbound.protection.outlook.com ([40.107.69.92]:60896
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727962AbeIGFPs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/lJQle53xxL2Spdt67mhIMHemc7+1wSIXqOdMIrGTI=;
 b=jgyfc7zjSqpMT2K6CdW8M547d7K5jiuj7PMW7udApe+o4GeGPCT2HSxr/2Gha8+zoBfnvj8dG0wofAjAU81xa/WQudj55pbF6YDdLdT6SYLBI2EokICGrRkdySsKI7NNyXxhO9OaOZHQkEh0I/0H0zd5p5XlIo60+2O7YAR75kw=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.8; Fri, 7 Sep 2018 00:37:40 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:37:40 +0000
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
Subject: [PATCH AUTOSEL 4.18 86/88] x86/pti: Check the return value of
 pti_user_pagetable_walk_pmd()
Thread-Topic: [PATCH AUTOSEL 4.18 86/88] x86/pti: Check the return value of
 pti_user_pagetable_walk_pmd()
Thread-Index: AQHURkLe7723AeOjFkq8IrB4nNdPTQ==
Date:   Fri, 7 Sep 2018 00:36:52 +0000
Message-ID: <20180907003547.57567-86-alexander.levin@microsoft.com>
References: <20180907003547.57567-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003547.57567-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:snK9TWyKiNIHg7phMKAfqkl6Ug/OcTccAfco7zMzX9AcZLpKwjwci5OSbAVZre8b1aqhhl6BSmZXlQIU09qCV/zdMpJ2P9imgiTTGAqNxrYBuxMMD8Vkz1VcD6WjBPezcEq42GbAEJEPw/C+oqa1asF7+LtuTSGnEY9OjYuQbu1O1NI9tUtnZLd2NRbSRJGC6DW4poFXWD3FfcKYQOoqpdHOG4OLZamTXMT2C8SF662ipq7oDzR3n0lGnLdBf2mIWembMc36BNmFFAjQDcXQFp/moacOR4umg5Pdmw0pIj9CXsQ5l54oXyeXZvJjeHxI7iry6S56PFoLV0MsRWgawtKLZB7PCo0TjluzKosgBXEJvBwc6ozwVtZycC2x3wLX5DASdLw43hWfF2TYSCp1qlsZ4xJDAd0XxOP5OQ6ULAz3wbkpw3hCoYFSCixKhp8eJO6cMC0dzimqTKlYaBmHfA==;5:6yr6mVmA5wudnnbdqUPVQ3FZX9+PISq5nDJHDzEmm4ffYhuMaoprwNz1dwJZ5b0DjxdcZ+PL9RKkG1/6MMP1j38I+BHdgRRllGCnh9kZp2l+dmelK5nUM4C/N30YnIHy9t2GHIb3kW4AwVKS7V3tJRX3KONEZGRJNBras2Glp30=;7:jNoUY8a/2BipCfyAEmWbCSFcWnMjyrrgI4Vr4IKDtE7BTsFFBo3Wu9zmdd52A50RcAMFxc9FKI8fOYeW1hgrk0TEyw9bBycyZHaGYTkd7GYNbsfHTP5hH59L8TF6S9jU6VPklN/BrDBRMKTITIQQtxO7/5XZgsc4d4loybwpLWGEaV4H9hZQCB8V2e2/v+ASLG+rhQ3sx51cYQDMxtC6aBZ32+BQI41NXVTVGzhUw5QmwET3p9EX4FwUA9JJU0UU
x-ms-office365-filtering-correlation-id: 148ccaf9-5e4b-4588-f58d-08d6145a1e0b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB05039C307A2493C08F80FB7EFB000@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(8121501046)(5005006)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(93006095)(93001095)(3231344)(944501410)(52105095)(2018427008)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(376002)(136003)(39860400002)(396003)(189003)(199004)(76176011)(2906002)(217873002)(107886003)(256004)(5250100002)(6512007)(22452003)(6306002)(14454004)(86612001)(316002)(6436002)(486006)(110136005)(2501003)(6486002)(54906003)(81156014)(39060400002)(81166006)(14444005)(8676002)(86362001)(575784001)(10290500003)(2616005)(25786009)(476003)(8936002)(97736004)(5660300001)(102836004)(106356001)(966005)(11346002)(68736007)(6666003)(4326008)(6116002)(3846002)(446003)(305945005)(7736002)(66066001)(1076002)(6506007)(478600001)(53936002)(2900100001)(99286004)(10090500001)(105586002)(186003)(72206003)(36756003)(6346003)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: v8flNkU2R6Py2g7sVATnj3Q/aD6En7MraIDcS8p6FmRHcAWttWFPLWYILId3ImF3Jg85rZWZRCLI1W6lH8EQLegcSTQn0sv7whzp5glkQIodfTaiAWNkne6SiiXRn0wyq7rmDic0DjutCZwtVAKU5Tag6yimwtS42DfiHHFVDd3bb1RtpbQq2WuJ5TLyynKv7ecGv64JvsmceCQLZdj6aEgkVPActObnp+btK/A72qQ99Q13hPk89YZFWlAXcyOjJq0ZBVOF1AJcU3yiLaVVUB1CZw4FxE5WklbFd+IqvPCmmnXoflxSUPCLg8zFyHfsDXQHeHERke00QBsZTGcvtVPVEnH6bPHRg8dTmvcaUZc=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148ccaf9-5e4b-4588-f58d-08d6145a1e0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:36:52.1523
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiang Biao <jiang.biao2@zte.com.cn>

[ Upstream commit 8c934e01a7ce685d98e970880f5941d79272c654 ]

pti_user_pagetable_walk_pmd() can return NULL, so the return value should
be checked to prevent a NULL pointer dereference.

Add the check and a warning when the PMD allocation fails.

Signed-off-by: Jiang Biao <jiang.biao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com
Cc: luto@kernel.org
Cc: hpa@zytor.com
Cc: albcamus@gmail.com
Cc: zhong.weidong@zte.com.cn
Link: https://lkml.kernel.org/r/1532045192-49622-2-git-send-email-jiang.bia=
o2@zte.com.cn
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/mm/pti.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 51abd8292b6d..ffa2f0f67904 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -206,7 +206,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long=
 address)
 	BUILD_BUG_ON(p4d_large(*p4d) !=3D 0);
 	if (p4d_none(*p4d)) {
 		unsigned long new_pud_page =3D __get_free_page(gfp);
-		if (!new_pud_page)
+		if (WARN_ON_ONCE(!new_pud_page))
 			return NULL;
=20
 		set_p4d(p4d, __p4d(_KERNPG_TABLE | __pa(new_pud_page)));
@@ -220,7 +220,7 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned long=
 address)
 	}
 	if (pud_none(*pud)) {
 		unsigned long new_pmd_page =3D __get_free_page(gfp);
-		if (!new_pmd_page)
+		if (WARN_ON_ONCE(!new_pmd_page))
 			return NULL;
=20
 		set_pud(pud, __pud(_KERNPG_TABLE | __pa(new_pmd_page)));
@@ -242,9 +242,13 @@ static pmd_t *pti_user_pagetable_walk_pmd(unsigned lon=
g address)
 static __init pte_t *pti_user_pagetable_walk_pte(unsigned long address)
 {
 	gfp_t gfp =3D (GFP_KERNEL | __GFP_NOTRACK | __GFP_ZERO);
-	pmd_t *pmd =3D pti_user_pagetable_walk_pmd(address);
+	pmd_t *pmd;
 	pte_t *pte;
=20
+	pmd =3D pti_user_pagetable_walk_pmd(address);
+	if (!pmd)
+		return NULL;
+
 	/* We can't do anything sensible if we hit a large mapping. */
 	if (pmd_large(*pmd)) {
 		WARN_ON(1);
--=20
2.17.1
