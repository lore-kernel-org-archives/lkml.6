Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA07C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F7E720857
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 00:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="oFFfoXPY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7E720857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeIGFSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 01:18:09 -0400
Received: from mail-bn3nam01on0105.outbound.protection.outlook.com ([104.47.33.105]:26432
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728752AbeIGFSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 01:18:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0koyuHsAwRLwIpQW63OaJBYf05xCW+QRgGW7hJEeZU=;
 b=oFFfoXPYIF4sCJR5K64s+8f2eORIzPfIctQ0NF73kJezci0Js9ThobwHRSSSMOX2mTCx65qy2S/cf5mqVdXCfs+NiiD2xM4cq3TYVyXZFmLqclpXStk8/wf7vg7ERyxeU+SRwsHTkbkHm/6tekOYfZiLkTDZCx/9//+ucDH6gZ8=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0855.namprd21.prod.outlook.com (10.173.192.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.1; Fri, 7 Sep 2018 00:39:42 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1143.008; Fri, 7 Sep 2018
 00:39:42 +0000
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
Subject: [PATCH AUTOSEL 4.14 65/67] x86/pti: Check the return value of
 pti_user_pagetable_walk_p4d()
Thread-Topic: [PATCH AUTOSEL 4.14 65/67] x86/pti: Check the return value of
 pti_user_pagetable_walk_p4d()
Thread-Index: AQHURkMLDEAinPG6XE+0Fy8CP8C/4w==
Date:   Fri, 7 Sep 2018 00:38:07 +0000
Message-ID: <20180907003716.57737-65-alexander.levin@microsoft.com>
References: <20180907003716.57737-1-alexander.levin@microsoft.com>
In-Reply-To: <20180907003716.57737-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0855;6:AufpvvTiHnXq+f4HL0ZKiEV88r+u1br95xiTpyLZcs2TYepfL9WYCsqi6EeSh0wv5wkLj/Eo6xuP3D7opc8rIp2XsCFUYMG5QDmsxMfSBPyNvwZXfGDNOTSoGrU8iYFZAQAmfKLOGikzT6mK0mTqRKUuzsoAyVkAUbrt+yGBZ6Xn4xdPSX5y7JJW25pyhkH1LOzHJLJfWMcUYwBDiPsPa3bjgO8ty5iZfjBiDavNIbECzA3coHTrxdXgR66GUpY9XO1JYtb4CVWlSMMlBOKFinc1m/9rPsJpXY586IYmsFmrcn//yah1Xb9SBStlp9h04mAuFxiIVG4j3fw2vAe4dokDgei0Yg3VVyYcLidN24jgMDr9lgQp+w6b2GXTbdL5hELKeOzEstQVFREt7E0ly0N95ff+fk3KimQMXCo521or1c9r5BftR9+5YjWYEgi/xmi8QJo0vKAgq1UeuCPZMA==;5:TR8/L1cEemsElbSsbmFnrxX48ALuXTZmT3IiYSpnSTlxImIVFn87zyHmG92MdM2Uj9xuLk0rWhCc9JfWDawLkhpoAWVMkarLwEIfSZXQbdhl7b8JZ/Hx1xTQM7o7EJuZkUhLrTY70Vbbdl6j9+I8U9+Oe8684cG8EonKqvbx170=;7:Y9+OVpH1uw3XNKnjB5csANkx7mQfY8dWP+e20TQgtqA26M1SlMNvLc2xIYKd83FjY519XQPHP9vT/uVe9XwOh+HTwnfab9r1FvS30Ic1lOyc2AcLg2togHglz7LRY0r39JW+OYKhLWbw7yRjNl73pIy2ZeZUH+w/4pLU00UMsO8GXMCwdioq+t6HRISICA9ZWCKBj2f8WCDx1as/yW1P0toepXbPy3bz8otZDfSY/lcewPXBNBZMiCnRjRMZJcOW
x-ms-office365-filtering-correlation-id: cfbeac79-ce1f-4830-31e5-08d6145a669b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(4534165)(4627221)(201703031133081)(201702281549075)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0855;
x-ms-traffictypediagnostic: CY4PR21MB0855:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-prvs: <CY4PR21MB0855F088D3CCAA7D88206EA9FB000@CY4PR21MB0855.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(42068640409301)(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231344)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0855;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0855;
x-forefront-prvs: 07880C4932
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(53936002)(316002)(97736004)(2900100001)(86612001)(25786009)(86362001)(2906002)(6306002)(6512007)(54906003)(39060400002)(107886003)(68736007)(110136005)(4326008)(81156014)(10290500003)(14454004)(8936002)(66066001)(81166006)(8676002)(3846002)(966005)(6116002)(478600001)(72206003)(7736002)(305945005)(1076002)(106356001)(105586002)(6506007)(76176011)(10090500001)(6486002)(99286004)(256004)(36756003)(2501003)(26005)(186003)(6666003)(5250100002)(14444005)(6436002)(5660300001)(102836004)(217873002)(476003)(2616005)(486006)(15760500003)(22452003)(11346002)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0855;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: yFyveFOH3ReIfB6IBzJrIMuZevB4Mol3Sd9D34E/E5Nsz0P5TNqdD3nInWPbyksn6/eNwLNO4zvNEVDhWHCYWuk/ZREJ4nG08N8wkBBeHTIjilsTfgsbtfvM2p7BhIG1FrFKUvqXJBtOWq+EyEc91/pmgzjY/dcqSZ5XBks6nnepe20SUvkNWo/iS9bnPVzaqltMtOQouksjXp1+uaA80nRlDLmBglvVzGf6YJNWB0aLCjNA30nfeRTHkwSzE1j47SRjxH/oXNNw8vXE91/NKplL1nmTnuTEXiog4Iu++NZINISqtKTmqHDls4MhNlYpcauI5nK2wmdWs+0zzhhCGl3jJ5PbbAnnmhPg6j0gKqo=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfbeac79-ce1f-4830-31e5-08d6145a669b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2018 00:38:07.8424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0855
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
index d6f11accd37a..63afd15b32a5 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -162,7 +162,7 @@ static __init p4d_t *pti_user_pagetable_walk_p4d(unsign=
ed long address)
=20
 	if (pgd_none(*pgd)) {
 		unsigned long new_p4d_page =3D __get_free_page(gfp);
-		if (!new_p4d_page)
+		if (WARN_ON_ONCE(!new_p4d_page))
 			return NULL;
=20
 		set_pgd(pgd, __pgd(_KERNPG_TABLE | __pa(new_p4d_page)));
@@ -181,9 +181,13 @@ static __init p4d_t *pti_user_pagetable_walk_p4d(unsig=
ned long address)
 static __init pmd_t *pti_user_pagetable_walk_pmd(unsigned long address)
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
@@ -319,6 +323,9 @@ static void __init pti_clone_p4d(unsigned long addr)
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
