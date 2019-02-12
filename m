Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5756FC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147F7222BE
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 21:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="YHVVS2go"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732492AbfBLVYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 16:24:33 -0500
Received: from mail-eopbgr750081.outbound.protection.outlook.com ([40.107.75.81]:48296
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728468AbfBLVYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 16:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhsQ1Y0mhMswZSynWB4iuXqsbXvmOMC6lsHWD9UauSE=;
 b=YHVVS2gosrZb5LvYBnX4+OOY+qmD4MlAeUmK6EUUmOEXQrF6RlLBDx+6sY8A+x85r0jYT+GN2qx981ycg3F30otVlgy0gT4Ir1Jt6W200fFDFCptIHJ7UB50DDBMhwFKkR3TIUpT46Vp2Wisxgo2cMYZDlHgbw6V4+reLgPvqVw=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2659.namprd12.prod.outlook.com (20.176.176.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 12 Feb 2019 21:24:30 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 21:24:30 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>
Subject: [PATCH 2/2] EDAC/mce_amd: Decode MCA_STATUS in bit definition order
Thread-Topic: [PATCH 2/2] EDAC/mce_amd: Decode MCA_STATUS in bit definition
 order
Thread-Index: AQHUwxlW2N5u0SxnrECM32V1r2S92A==
Date:   Tue, 12 Feb 2019 21:24:29 +0000
Message-ID: <20190212212417.107049-2-Yazen.Ghannam@amd.com>
References: <20190212212417.107049-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190212212417.107049-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR02CA0015.namprd02.prod.outlook.com
 (2603:10b6:805:a2::28) To BN7PR12MB2593.namprd12.prod.outlook.com
 (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e7656648-3396-4c1c-c740-08d69130790a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2659;
x-ms-traffictypediagnostic: BN7PR12MB2659:
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2659;20:teFp6BuJXuxoKa20dBq/h9G2AP14SZpcUd6MD+t1xaIEdgB5YB8g/4L/m5dLLyrIkCdzBtd8WFCYnWaA5EETYJluWXvBrXrV3BAQVsOhP4K826x+z7HsueiRlHKyXrInPoB8I5cVNH7F0yTb2eQB5e0HcZFIqbwlmGnKqZFLwsTWJxXrG9NhD0XJ2j3AtJOL+XnVWA4XnFh8tLDb/mdlo7jlUlZi+0QUQ4TbxinB9qp4I3WlahT98VYT9e3nM1eV
x-microsoft-antispam-prvs: <BN7PR12MB26593A6BA622782888572292F8650@BN7PR12MB2659.namprd12.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(396003)(366004)(136003)(346002)(189003)(199004)(3846002)(26005)(72206003)(68736007)(6116002)(6506007)(386003)(6916009)(102836004)(8676002)(81156014)(186003)(478600001)(97736004)(105586002)(81166006)(106356001)(6512007)(1076003)(2501003)(25786009)(66066001)(53936002)(2906002)(14444005)(256004)(71200400001)(71190400001)(36756003)(6486002)(6436002)(5640700003)(4326008)(8936002)(2351001)(52116002)(14454004)(86362001)(2616005)(316002)(486006)(99286004)(305945005)(7736002)(446003)(54906003)(11346002)(476003)(76176011)(50226002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2659;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MQJc+L5Xh3U+U4yM99nBaeHCEW0n2QVCXzvxF1vD9A0FKjaNo2N3BqSKACQ/SQ8Rln5Hi1Gcl4UM/VQ4wmOcZiP6qenbhjFRzyliXheAdEl84MHytF9dQPMxZKdrmDnbvNRb6gOxCaT7dz+XSUA/+/GwcyBy6mALw45Wor259MHZIVekT7wXTDhey7oPiqd6Qfeq2olP/x+0gSEcHSoyC4UW4k825W7a7AvMCvI7RN4T1mi7NYvgCNQ06/HsU6QBT8YRWcut311i9kdw3dyyMDcKFPQuncQLoGCuALyZzE7e47N3NxO5Xc5ZgzVPNzyJcrz7FRb7DgskG/aKa5DPGkV7lArXmSsUFrZ997WffhBdRkipRcrhfP+IQb3nuCJX1AepV6jx6AhBqnXCpu8hQsxHhXjLTYONUgHeUzcD+qM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7656648-3396-4c1c-c740-08d69130790a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 21:24:29.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Reorder how we decode the bits in MCA_STATUS to follow how their defined
in the register.

The order is as follows:

Bit : Decode
61  : UC
59  : MiscV
58  : AddrV
57  : PCC
55  : TCC
53  : SyndV
46  : CECC
45  : UECC
44  : Deferred
43  : Poison
40  : Scrub

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index b349c22bb386..0a1814dad6cf 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -1051,26 +1051,18 @@ amd_decode_mce(struct notifier_block *nb, unsigned =
long val, void *data)
 		((m->status & MCI_STATUS_UC)	? "UE"	  :
 		 (m->status & MCI_STATUS_DEFERRED) ? "-"  : "CE"),
 		((m->status & MCI_STATUS_MISCV)	? "MiscV" : "-"),
-		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"),
-		((m->status & MCI_STATUS_ADDRV)	? "AddrV" : "-"));
-
-	if (fam >=3D 0x15) {
-		pr_cont("|%s", (m->status & MCI_STATUS_DEFERRED ? "Deferred" : "-"));
-
-		/* F15h, bank4, bit 43 is part of McaStatSubCache. */
-		if (fam !=3D 0x15 || m->bank !=3D 4)
-			pr_cont("|%s", (m->status & MCI_STATUS_POISON ? "Poison" : "-"));
-	}
+		((m->status & MCI_STATUS_ADDRV)	? "AddrV" : "-"),
+		((m->status & MCI_STATUS_PCC)	? "PCC"	  : "-"));
=20
 	if (boot_cpu_has(X86_FEATURE_SMCA)) {
 		u32 low, high;
 		u32 addr =3D MSR_AMD64_SMCA_MCx_CONFIG(m->bank);
=20
-		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
-
 		if (!rdmsr_safe(addr, &low, &high) &&
 		    (low & MCI_CONFIG_MCAX))
 			pr_cont("|%s", ((m->status & MCI_STATUS_TCC) ? "TCC" : "-"));
+
+		pr_cont("|%s", ((m->status & MCI_STATUS_SYNDV) ? "SyndV" : "-"));
 	}
=20
 	/* do the two bits[14:13] together */
@@ -1078,6 +1070,14 @@ amd_decode_mce(struct notifier_block *nb, unsigned l=
ong val, void *data)
 	if (ecc)
 		pr_cont("|%sECC", ((ecc =3D=3D 2) ? "C" : "U"));
=20
+	if (fam >=3D 0x15) {
+		pr_cont("|%s", (m->status & MCI_STATUS_DEFERRED ? "Deferred" : "-"));
+
+		/* F15h, bank4, bit 43 is part of McaStatSubCache. */
+		if (fam !=3D 0x15 || m->bank !=3D 4)
+			pr_cont("|%s", (m->status & MCI_STATUS_POISON ? "Poison" : "-"));
+	}
+
 	if (fam >=3D 0x17)
 		pr_cont("|%s", (m->status & MCI_STATUS_SCRUB ? "Scrub" : "-"));
=20
--=20
2.17.1

