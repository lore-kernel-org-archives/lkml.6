Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45BA5214C6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TvtA+J0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbfBAW4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:56:06 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:46228
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727047AbfBAW4B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:56:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7NN/nK9IrLO2jmM4GojzUvwtz0KX9sa/AlqBxkaxck=;
 b=TvtA+J0c2S2Jr9Z4PJdewO60BBZPJS7bFZf7fTVXwmLGm5NAVdtFIZ2yLj8/7bDeDsl58FUTFZJz3V/MDJsNkOhnaIWeLQs2uiZMmxO+oXeCzDXJ34jQLZyNyk2+7+kbWrztbMRbu+REO9NXArNnNbIOlUc3B690GvOEm4kGwpU=
Received: from BN7PR12MB2593.namprd12.prod.outlook.com (20.176.176.31) by
 BN7PR12MB2628.namprd12.prod.outlook.com (20.176.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.16; Fri, 1 Feb 2019 22:55:53 +0000
Received: from BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5]) by BN7PR12MB2593.namprd12.prod.outlook.com
 ([fe80::b9f3:7490:d57d:8dc5%2]) with mapi id 15.20.1580.019; Fri, 1 Feb 2019
 22:55:53 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: [PATCH 3/5] EDAC, mce_amd: Add new error descriptions for some SMCA
 bank types
Thread-Topic: [PATCH 3/5] EDAC, mce_amd: Add new error descriptions for some
 SMCA bank types
Thread-Index: AQHUuoFI0R4iy7Jsy0STSYEwj3y6kg==
Date:   Fri, 1 Feb 2019 22:55:52 +0000
Message-ID: <20190201225534.8177-4-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190201225534.8177-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To BN7PR12MB2593.namprd12.prod.outlook.com (2603:10b6:408:28::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2628;20:aogiIu+AT7Uj+qzCfV2B0SfSLXMSw+swX47aFxcdQZpX8sD5vgS2CQMBPZiYRRjJheMVBujxNt8uEqG5IrxpzVMQfMxb+Ow9EeWFP9pE4otRRSNLVhihdvxiUuwlcxkmshSS9ZQtZaktRrDsLIIFPOF0lQD9IzpsiJatiL1ULH+ews49qzdoGCsuIIndyhcTQ+H2O553UnsUQJytIdiJj2rtbvHUUt2/C3z68ts1VV2M3AcOuHcIENd2Lwn7hmbA
x-ms-office365-filtering-correlation-id: 7c2534b8-afdb-4fe8-ce5d-08d688986ab9
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
x-ms-traffictypediagnostic: BN7PR12MB2628:
x-microsoft-antispam-prvs: <BN7PR12MB26285906C3E0A82789A695B7F8920@BN7PR12MB2628.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(186003)(1076003)(2351001)(106356001)(71190400001)(14444005)(52116002)(256004)(15650500001)(3846002)(105586002)(50226002)(6512007)(6116002)(25786009)(5640700003)(6436002)(66066001)(71200400001)(26005)(478600001)(6486002)(76176011)(316002)(97736004)(2906002)(11346002)(305945005)(7736002)(81166006)(8676002)(81156014)(54906003)(68736007)(446003)(36756003)(6916009)(99286004)(6506007)(2616005)(476003)(386003)(86362001)(102836004)(4326008)(14454004)(72206003)(2501003)(8936002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: DCLkU7ASKzGCEjrZyDbB1pxyPnLCnJZuCMd9noqUPRapYsviRJuYADLgqY9PImc2R/XTUz5D8sFR++zwS5nX2kmy1zwaxO2+KyB2Y/FaN94MH9fiwirTO9wOr02so7QCV5Ji4KYBB/mpC9fOpWnIQztwUP5I5QjG7iTz+XOd1BBoyMF3oCUnZSVyrBqcpkrd5Dy5cqmYpeCnfV+i3wycqS+Gws0vYlQADbVju3Qj5CxW01LIOSeqqSEuOaZsO54TChe0CTPdcx1slGnS3mi19if0RqgxnJZAWEq0EkOPS7O9AZ7SD4JgpkaXYvpBuYsXA4jxuNWYHOJN3EHqzSyvsSoipca2KNBYl2LYjaT+DVTGRIaKcQhr7nbhOmlv9AyAXhgJTS5EHAUEnoNBrjxkFSJZg7mn0Zpcl8fmiXNDo3Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c2534b8-afdb-4fe8-ce5d-08d688986ab9
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 22:55:52.1578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR12MB2628
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Some SMCA bank types on future systems will report new error types even
though the bank type is not treated as a new version. These new error
types will reported by bits that are reserved in past systems.

Add the new error descriptions to the lists in edac_mce_amd.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/cpu/mce/amd.c | 8 ++++----
 drivers/edac/mce_amd.c        | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index bd1331b241ca..e64de5149e50 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -144,22 +144,22 @@ static struct smca_hwid smca_hwid_mcatypes[] =3D {
 	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
=20
 	/* ZN Core (HWID=3D0xB0) MCA types */
-	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
+	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFFF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
 	{ SMCA_L2_CACHE, HWID_MCATYPE(0xB0, 0x2), 0xF },
 	{ SMCA_DE,	 HWID_MCATYPE(0xB0, 0x3), 0x1FF },
 	/* HWID 0xB0 MCATYPE 0x4 is Reserved */
-	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5), 0x7FF },
+	{ SMCA_EX,	 HWID_MCATYPE(0xB0, 0x5), 0xFFF },
 	{ SMCA_FP,	 HWID_MCATYPE(0xB0, 0x6), 0x7F },
 	{ SMCA_L3_CACHE, HWID_MCATYPE(0xB0, 0x7), 0xFF },
=20
 	/* Data Fabric MCA types */
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0), 0x1FF },
-	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0xF },
+	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0x1F },
 	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2), 0x3FFF },
=20
 	/* Unified Memory Controller MCA type */
-	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0x3F },
+	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0xFF },
=20
 	/* Parameter Block MCA type */
 	{ SMCA_PB,	 HWID_MCATYPE(0x05, 0x0), 0x1 },
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 184c90172d17..c79e650aa606 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -155,7 +155,7 @@ static const char * const smca_ls_mce_desc[] =3D {
 	"Store queue parity",
 	"Miss address buffer payload parity",
 	"L1 TLB parity",
-	"Reserved",
+	"DC Tag error type 5",
 	"DC tag error type 6",
 	"DC tag error type 1",
 	"Internal error type 1",
@@ -222,6 +222,7 @@ static const char * const smca_ex_mce_desc[] =3D {
 	"Retire status queue parity error",
 	"Scheduling queue parity error",
 	"Branch buffer queue parity error",
+	"Hardware Assertion error",
 };
=20
 static const char * const smca_fp_mce_desc[] =3D {
@@ -279,6 +280,7 @@ static const char * const smca_pie_mce_desc[] =3D {
 	"Internal PIE register security violation",
 	"Error on GMI link",
 	"Poison data written to internal PIE register",
+	"A deferred error was detected in the DF"
 };
=20
 static const char * const smca_umc_mce_desc[] =3D {
@@ -288,6 +290,8 @@ static const char * const smca_umc_mce_desc[] =3D {
 	"Advanced peripheral bus error",
 	"Command/address parity error",
 	"Write data CRC error",
+	"DCQ SRAM ECC error",
+	"AES SRAM ECC error",
 };
=20
 static const char * const smca_pb_mce_desc[] =3D {
--=20
2.17.1

