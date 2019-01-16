Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9747C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA017206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="036IGn7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393903AbfAPPKo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:10:44 -0500
Received: from mail-eopbgr820053.outbound.protection.outlook.com ([40.107.82.53]:39875
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729301AbfAPPKn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ogtu2k4YpJiOhnV5Ky3VddFsXcLWMx6llEq06QESUw=;
 b=036IGn7+pS4J5n1EFGJrzCHxt0kZRMBrU3v64rP0e8w5PNuSW3g9VOj6GFZMe0Xqh6M8kweZZe21fp4W6hbP95swmiYvanHS3lfJjr5IIG6y2Q7q9C4/ZQ8+isS9q8/wXxqx3Tt4LQVKG8Rq6JPnWm90AxD4cFK8K8DDYyQgMhE=
Received: from MN2PR12MB3248.namprd12.prod.outlook.com (20.179.82.219) by
 MN2PR12MB2878.namprd12.prod.outlook.com (20.179.80.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1516.15; Wed, 16 Jan 2019 15:10:36 +0000
Received: from MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f]) by MN2PR12MB3248.namprd12.prod.outlook.com
 ([fe80::c818:e3a0:c248:802f%3]) with mapi id 15.20.1537.018; Wed, 16 Jan 2019
 15:10:36 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "maintainer : X86 ARCHITECTURE" <x86@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "open list : X86 ARCHITECTURE" <linux-kernel@vger.kernel.org>,
        "S, Shirish" <Shirish.S@amd.com>
Subject: [PATCH 1/2] x86/mce/amd: apply MC4_MISC thresholding to all models of
 family 15
Thread-Topic: [PATCH 1/2] x86/mce/amd: apply MC4_MISC thresholding to all
 models of family 15
Thread-Index: AQHUra2i3BBjQq/m2ESmUT0QXLYpQA==
Date:   Wed, 16 Jan 2019 15:10:36 +0000
Message-ID: <1547651417-23583-2-git-send-email-shirish.s@amd.com>
References: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
In-Reply-To: <1547651417-23583-1-git-send-email-shirish.s@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR01CA0087.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::27) To MN2PR12MB3248.namprd12.prod.outlook.com
 (2603:10b6:208:103::27)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Shirish.S@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.7.4
x-originating-ip: [165.204.156.251]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MN2PR12MB2878;20:eNRolBupgTsD3qG18FU5/RF6MlIEiogXLMUhQUuU1zUG1zZYRBdwdkWVpApuLkXZ0WI97Iqr0+uYjI30LXwjqGmjjmV7W+nGGfM2/vhwAS/fFWiLI1Zf0NPDvpcQ6kEuyGthDxOkD52E0tJlv/1dVQwKsz5ZK8CfS7FvIg/truahq0ZVEF2+tWvxRs3VaCySf330jsFEEr6PJRLkPdqYV5DxpDKdt7nO2MyauX6vXDS7cR3WMtFMKRm30V86CRPj
x-ms-office365-filtering-correlation-id: ec7c173b-147f-4d69-62ee-08d67bc4c495
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:MN2PR12MB2878;
x-ms-traffictypediagnostic: MN2PR12MB2878:
x-microsoft-antispam-prvs: <MN2PR12MB2878131CBC1F0C9E3BA16973F2820@MN2PR12MB2878.namprd12.prod.outlook.com>
x-forefront-prvs: 091949432C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(346002)(376002)(366004)(396003)(54534003)(199004)(189003)(25786009)(26005)(5660300001)(14454004)(7736002)(486006)(305945005)(105586002)(54906003)(99286004)(446003)(11346002)(476003)(2616005)(52116002)(53936002)(4326008)(76176011)(102836004)(6506007)(386003)(186003)(3846002)(6116002)(72206003)(6512007)(478600001)(2906002)(316002)(86362001)(6916009)(81166006)(36756003)(81156014)(8676002)(68736007)(50226002)(6486002)(97736004)(8936002)(256004)(6436002)(106356001)(71200400001)(71190400001)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR12MB2878;H:MN2PR12MB3248.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nRWaCno0lZzp2rHRaZZHrWhi3Dpz85wzrq8NzcJB3yFoifwowGVHIBIuD5drLpt7HOPBy/Tj1n2uf1jK08w67cr5M1FhS2ilz9nEN1af0k2ohrImsiAPar38wkz5YKleqw8uHJVKsVZyEwza4XFK6JkYMzeP5SqR+VBtk7Du3sOgE7hjiv6ekHNU2IJxTIBklpmaOECCOJ6xN4jUFnrqItpvoULD9b9vylXklEvt86YdJQXNtnQCwD4/tF1uiLnOdlLgxEpsTTSE695I5BHt46/Kbak2gL/G5J3heNOlvdcTQ4solDDBhIIUBjoh8x3IFTadikCd8jAw7jRdRSInCyq9sKO3cg0OJ3M2/2BeVI+hSArfn1ecppGKREFI+XO3FdxeqnFoHPmhdExKA1D2eDIc4eDEbMOL1x4AfDNsuFg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7c173b-147f-4d69-62ee-08d67bc4c495
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2019 15:10:32.9421
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2878
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Its evident from various forums and logs that MC4_MISC thresholding is not
supported for the family 15 processors, hence skip the x86_model check
while applying quirk.

Changelog[v2]:
 - reword commit message to adhere to coding standards
 - remove check of model range

Signed-off-by: Shirish S <shirish.s@amd.com>
---
 arch/x86/kernel/cpu/mce/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.=
c
index 672c722..d0c5416 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1612,11 +1612,10 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo=
_x86 *c)
 			mce_flags.overflow_recov =3D 1;
=20
 		/*
-		 * Turn off MC4_MISC thresholding banks on those models since
+		 * Turn off MC4_MISC thresholding banks on all models since
 		 * they're not supported there.
 		 */
-		if (c->x86 =3D=3D 0x15 &&
-		    (c->x86_model >=3D 0x10 && c->x86_model <=3D 0x1f)) {
+		if (c->x86 =3D=3D 0x15) {
 			int i;
 			u64 hwcr;
 			bool need_toggle;
--=20
2.7.4

