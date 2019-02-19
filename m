Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C42372147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:26:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="36QOGX2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbfBSU0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:26:13 -0500
Received: from mail-eopbgr750041.outbound.protection.outlook.com ([40.107.75.41]:46400
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726281AbfBSU0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtIVWpwKOHOG0+RPVlkHWqKUGHwgXuMffejt6al34+4=;
 b=36QOGX2DHt+5RJmBrL+brfcCMRgjmqEIRBQKeyqPr8giKUtxyqoHn5MmxpR6D0VN15lSi32P8ZHZwtWg9MeSDwnpdjkbPMaj3EI4S1d42vsLZbtdJ1S0bwKfoIT4xCUB9UgwM7GjUtOz9vhCCvtpBvmSFBNV64WnpQdSLxSpHV8=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2623.namprd12.prod.outlook.com (52.135.103.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 20:26:09 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::35e5:6f95:dfe:efe%2]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:26:09 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH 3/5] EDAC/amd64: Recognize x16 Symbol Size
Thread-Topic: [PATCH 3/5] EDAC/amd64: Recognize x16 Symbol Size
Thread-Index: AQHUyJFQiE8qczt930CZ7Tvg5kTmBg==
Date:   Tue, 19 Feb 2019 20:25:54 +0000
Message-ID: <20190219202536.15462-3-Yazen.Ghannam@amd.com>
References: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190219202536.15462-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0031.prod.exchangelabs.com (2603:10b6:804:2::41)
 To SN6PR12MB2639.namprd12.prod.outlook.com (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5619cfd4-6e08-4f5a-44ab-08d696a8726b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2623;
x-ms-traffictypediagnostic: SN6PR12MB2623:
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2623;20:+pHx62R9BduafR+jkH5vrmtkOF3siRiY3f2lIjcTlMr3w70dpODBLXbmnH93q2ftJXBr/ClvwwDmALhzjms5DDKcNVWZ4GGhVrJVNi4lLBLH9LxbVb6INgWyECL8IWpF/M8LRfJqLUpbMDuI/6LVTd1owFDd1nJHfm0/pUnDcxQziM1A0UI1Xa+dw/94tvCidHqouEXAPA33sS8+KqelFKuX6AR8kNl3CTe1x5k82x3jLTY5sV3juNtWtYrH5Cuy
x-microsoft-antispam-prvs: <SN6PR12MB2623096A817C4A739AE70B14F87C0@SN6PR12MB2623.namprd12.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(366004)(136003)(376002)(189003)(199004)(2501003)(1076003)(5660300002)(99286004)(52116002)(8936002)(2906002)(36756003)(256004)(6666004)(186003)(76176011)(72206003)(8676002)(3846002)(6116002)(50226002)(81166006)(81156014)(71190400001)(71200400001)(54906003)(2351001)(7736002)(6486002)(106356001)(6512007)(26005)(25786009)(305945005)(446003)(66066001)(386003)(6436002)(6506007)(5640700003)(86362001)(316002)(68736007)(11346002)(102836004)(97736004)(486006)(14454004)(4326008)(478600001)(105586002)(2616005)(476003)(6916009)(53936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2623;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cAhU/2kMgAjbEqqZXY29dCvB1B8qa1g+q+m7b7bwKMj4Voi0krzhDppJ5t4b+010NQadGsCuq9Pgp7FXmoZatN/6imkv/TdhzgUdQcWQRVUY6NJ+15R1n9Tv7Hml2CE0UpvfELTKkfLtxDbvBKl5B1DkUcocClV2QFHFP7rCqKRGkIbO5rQnT8Of3UXXdQW+d6ZPO0m5OId8anOFgAnrZAsnOBBALFTx7aYJoyrH7MdYtYk21gsWi6H5q7F4S+JL9TGQ/YtxBJjP/sspaPCJ37xNoCh1ee71mmjggWOZ0w8lJKTQzTGHND0irY5DPM//lFMxlG9fQQn1vfaYHJ6AkWsnWYQ8fDXi1u3/U5xPcqTuTI138COSttvvW7IUeFLtBo2Fvc5Cs4fHA7mIzI2KhiyGTqS3Jg1PUafgIjC0VPw=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5619cfd4-6e08-4f5a-44ab-08d696a8726b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:25:53.1984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2623
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Future AMD systems may support x16 symbol sizes.

Recognize if a system is using x16 symbol size. Also, simplify the print
statement.

Note that a x16 syndrome vector table is not necessary like with x4 or
x8. This is because systems that support x16 symbol sizes will be SMCA
systems. In which case, the syndrome can be directly extracted from the
MCA_SYND[Syndrome] field.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/amd64_edac.c | 15 +++++++++------
 drivers/edac/amd64_edac.h |  2 +-
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 507d824fe45a..bacd2cb22f29 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -897,8 +897,7 @@ static void dump_misc_regs(struct amd64_pvt *pvt)
=20
 	edac_dbg(1, "  DramHoleValid: %s\n", dhar_valid(pvt) ? "yes" : "no");
=20
-	amd64_info("using %s syndromes.\n",
-			((pvt->ecc_sym_sz =3D=3D 8) ? "x8" : "x4"));
+	amd64_info("using x%u syndromes.\n", pvt->ecc_sym_sz);
 }
=20
 /*
@@ -2609,10 +2608,14 @@ static void determine_ecc_sym_sz(struct amd64_pvt *=
pvt)
=20
 		for_each_umc(i) {
 			/* Check enabled channels only: */
-			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
-			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
-				pvt->ecc_sym_sz =3D 8;
-				break;
+			if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
+				if (pvt->umc[i].ecc_ctrl & BIT(9)) {
+					pvt->ecc_sym_sz =3D 16;
+					break;
+				} else if (pvt->umc[i].ecc_ctrl & BIT(7)) {
+					pvt->ecc_sym_sz =3D 8;
+					break;
+				}
 			}
 		}
=20
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index 435450bf8684..6c6ce783208a 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -364,7 +364,7 @@ struct amd64_pvt {
 	u32 dct_sel_hi;		/* DRAM Controller Select High */
 	u32 online_spare;	/* On-Line spare Reg */
=20
-	/* x4 or x8 syndromes in use */
+	/* x4, x8, or x16 syndromes in use */
 	u8 ecc_sym_sz;
=20
 	/* place to store error injection parameters prior to issue */
--=20
2.17.1

