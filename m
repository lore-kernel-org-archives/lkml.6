Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735B7C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286F22146E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 22:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yRzOV8W9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727585AbfBAW4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 17:56:18 -0500
Received: from mail-eopbgr690070.outbound.protection.outlook.com ([40.107.69.70]:46228
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727417AbfBAW4D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 17:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ABl3SoClEMA5A50qmKI2LKB2dSQ//u81Gtb3j0ivf3A=;
 b=yRzOV8W9oVWl4jO+jzwGHGSLrbsswiGfjKops+U5UZ+1ShLkJFPc63KaTYutmso2pHoRTFv5ci3u3gj1gUiYM28A0pEp+WiHiJkAczr6VLmsV4qqhVTKE9qkk4TkhgQ3XH+DQYGLlnnKt2a+RICfznwevQ4xjQ8d9II00uO1qf0=
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
Subject: [PATCH 4/5] EDAC, mce_amd: Match error descriptions to latest
 documentation
Thread-Topic: [PATCH 4/5] EDAC, mce_amd: Match error descriptions to latest
 documentation
Thread-Index: AQHUuoFICl2IAHXCx0+0hBtVoyVCSQ==
Date:   Fri, 1 Feb 2019 22:55:53 +0000
Message-ID: <20190201225534.8177-5-Yazen.Ghannam@amd.com>
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
x-microsoft-exchange-diagnostics: 1;BN7PR12MB2628;20:jres0bseztZvZD4WJAD5b/mPKAFrf9QKViQpsUlO7a3eXO/NEbRoFJqJzZzpt8ltJWmAWIjATHvyh60GYNe2JSmmSLxauYczn9s/hGmMk+oG2/jj41sm3vrHSMWB4guznCXvJ6lUetTx3Y1HKFA1aWA/ljRmCRwHfJmPiyJWxFg5JZ66zd1+u+IrHN4Z89SXEm41EY4xlrhDI4PSKFCACZqtZh+5SLOejipe8NWLVzyN0uvED1909vc3JfhUKAa6
x-ms-office365-filtering-correlation-id: b1a8921c-2d54-4e7b-6062-08d688986b3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:BN7PR12MB2628;
x-ms-traffictypediagnostic: BN7PR12MB2628:
x-microsoft-antispam-prvs: <BN7PR12MB26285FA242BFB846C82D578FF8920@BN7PR12MB2628.namprd12.prod.outlook.com>
x-forefront-prvs: 09352FD734
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(136003)(39860400002)(366004)(189003)(199004)(186003)(1076003)(2351001)(106356001)(71190400001)(14444005)(52116002)(256004)(3846002)(105586002)(50226002)(6512007)(6116002)(25786009)(5640700003)(6436002)(66066001)(71200400001)(26005)(478600001)(6486002)(76176011)(316002)(97736004)(2906002)(11346002)(305945005)(7736002)(81166006)(8676002)(81156014)(54906003)(68736007)(446003)(36756003)(6916009)(99286004)(6506007)(2616005)(476003)(386003)(86362001)(102836004)(4326008)(14454004)(72206003)(2501003)(8936002)(53936002)(486006);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR12MB2628;H:BN7PR12MB2593.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vEaYpXJ9yKKi60nXwB9GYc/mSCP8N2K58yhlNpnnS8v17ER8TPaHEDAOIhXRHQUEguuQEo6ILucHenSHecabnDb0JqFJFdmRDcgoU1TntCT9h0pjn7ePQhP1e+Mtf+71i5QKWgVIwARzb9mnHHZUwnSJW5jzGyyr6hci6gjo6L5NXrSe6MF3RdnHSnbhg+ATCP/dSJ3Y+lqHUw+0H9l58imX2mj1/1vh5xr95hdXJbSW1LgRtxTYkFhq7mZnViT6itO9HkkWFWlH8T1By7uO68EKavbaO/V/3biFlciyXhc6XGDNyozvlPEWXCQCHH14JV94tpamf/TO4lXInWwQJlSdlOG19cJ1mFJk2jWEyHTHlO4/YhgWjJAwFA7pyFp6/lNjBo2VMW8aSNBH+Cbu6osbT8khenxJq4aEYSfjuWc=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1a8921c-2d54-4e7b-6062-08d688986b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2019 22:55:53.0204
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

Update the error descriptions to match the latest documentation for
easier searching. In some cases the changes are small and in other cases
the changes may be total rewording of the description.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/edac/mce_amd.c | 166 ++++++++++++++++++++---------------------
 1 file changed, 83 insertions(+), 83 deletions(-)

diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index c79e650aa606..7e29ceabdf6f 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -151,74 +151,74 @@ static const char * const mc6_mce_desc[] =3D {
=20
 /* Scalable MCA error strings */
 static const char * const smca_ls_mce_desc[] =3D {
-	"Load queue parity",
-	"Store queue parity",
-	"Miss address buffer payload parity",
-	"L1 TLB parity",
+	"Load queue parity error",
+	"Store queue parity error",
+	"Miss address buffer payload parity error",
+	"Level 1 TLB parity error",
 	"DC Tag error type 5",
-	"DC tag error type 6",
-	"DC tag error type 1",
+	"DC Tag error type 6",
+	"DC Tag error type 1",
 	"Internal error type 1",
 	"Internal error type 2",
-	"Sys Read data error thread 0",
-	"Sys read data error thread 1",
-	"DC tag error type 2",
-	"DC data error type 1 (poison consumption)",
-	"DC data error type 2",
-	"DC data error type 3",
-	"DC tag error type 4",
-	"L2 TLB parity",
+	"System Read Data Error Thread 0",
+	"System Read Data Error Thread 1",
+	"DC Tag error type 2",
+	"DC Data error type 1 and poison consumption",
+	"DC Data error type 2",
+	"DC Data error type 3",
+	"DC Tag error type 4",
+	"Level 2 TLB parity error",
 	"PDC parity error",
-	"DC tag error type 3",
-	"DC tag error type 5",
-	"L2 fill data error",
+	"DC Tag error type 3",
+	"DC Tag error type 5",
+	"L2 Fill Data error",
 };
=20
 static const char * const smca_if_mce_desc[] =3D {
-	"microtag probe port parity error",
-	"IC microtag or full tag multi-hit error",
-	"IC full tag parity",
-	"IC data array parity",
-	"Decoupling queue phys addr parity error",
-	"L0 ITLB parity error",
-	"L1 ITLB parity error",
-	"L2 ITLB parity error",
-	"BPQ snoop parity on Thread 0",
-	"BPQ snoop parity on Thread 1",
-	"L1 BTB multi-match error",
-	"L2 BTB multi-match error",
-	"L2 Cache Response Poison error",
-	"System Read Data error",
+	"Op Cache Microtag Probe Port Parity Error",
+	"IC Microtag or Full Tag Multi-hit Error",
+	"IC Full Tag Parity Error",
+	"IC Data Array Parity Error",
+	"Decoupling Queue PhysAddr Parity Error",
+	"L0 ITLB Parity Error",
+	"L1 ITLB Parity Error",
+	"L2 ITLB Parity Error",
+	"BPQ Thread 0 Snoop Parity Error",
+	"BPQ Thread 1 Snoop Parity Error",
+	"L1 BTB Multi-Match Error",
+	"L2 BTB Multi-Match Error",
+	"L2 Cache Response Poison Error",
+	"System Read Data Error",
 };
=20
 static const char * const smca_l2_mce_desc[] =3D {
-	"L2M tag multi-way-hit error",
-	"L2M tag ECC error",
-	"L2M data ECC error",
-	"HW assert",
+	"L2M Tag Multiple-Way-Hit error",
+	"L2M Tag or State Array ECC Error",
+	"L2M Data Array ECC Error",
+	"Hardware Assert Error",
 };
=20
 static const char * const smca_de_mce_desc[] =3D {
-	"uop cache tag parity error",
-	"uop cache data parity error",
-	"Insn buffer parity error",
-	"uop queue parity error",
-	"Insn dispatch queue parity error",
-	"Fetch address FIFO parity",
-	"Patch RAM data parity",
-	"Patch RAM sequencer parity",
-	"uop buffer parity"
+	"Micro-op cache tag parity error",
+	"Micro-op cache data parity error",
+	"Instruction buffer parity error",
+	"Micro-op queue parity error",
+	"Instruction dispatch queue parity error",
+	"Fetch address FIFO parity error",
+	"Patch RAM data parity error",
+	"Patch RAM sequencer parity error",
+	"Micro-op buffer parity error"
 };
=20
 static const char * const smca_ex_mce_desc[] =3D {
-	"Watchdog timeout error",
-	"Phy register file parity",
-	"Flag register file parity",
-	"Immediate displacement register file parity",
-	"Address generator payload parity",
-	"EX payload parity",
-	"Checkpoint queue parity",
-	"Retire dispatch queue parity",
+	"Watchdog Timeout error",
+	"Physical register file parity error",
+	"Flag register file parity error",
+	"Immediate displacement register file parity error",
+	"Address generator payload parity error",
+	"EX payload parity error",
+	"Checkpoint queue parity error",
+	"Retire dispatch queue parity error",
 	"Retire status queue parity error",
 	"Scheduling queue parity error",
 	"Branch buffer queue parity error",
@@ -226,36 +226,36 @@ static const char * const smca_ex_mce_desc[] =3D {
 };
=20
 static const char * const smca_fp_mce_desc[] =3D {
-	"Physical register file parity",
-	"Freelist parity error",
-	"Schedule queue parity",
+	"Physical register file (PRF) parity error",
+	"Freelist (FL) parity error",
+	"Schedule queue parity error",
 	"NSQ parity error",
-	"Retire queue parity",
-	"Status register file parity",
+	"Retire queue (RQ) parity error",
+	"Status register file (SRF) parity error",
 	"Hardware assertion",
 };
=20
 static const char * const smca_l3_mce_desc[] =3D {
-	"Shadow tag macro ECC error",
-	"Shadow tag macro multi-way-hit error",
-	"L3M tag ECC error",
-	"L3M tag multi-way-hit error",
-	"L3M data ECC error",
-	"XI parity, L3 fill done channel error",
-	"L3 victim queue parity",
-	"L3 HW assert",
+	"Shadow Tag Macro ECC Error",
+	"Shadow Tag Macro Multi-way-hit Error",
+	"L3M Tag ECC Error",
+	"L3M Tag Multi-way-hit Error",
+	"L3M Data ECC Error",
+	"SDP Parity Error or SystemReadDataError from XI",
+	"L3 Victim Queue Parity Error",
+	"L3 Hardware Assertion",
 };
=20
 static const char * const smca_cs_mce_desc[] =3D {
-	"Illegal request from transport layer",
-	"Address violation",
-	"Security violation",
-	"Illegal response from transport layer",
-	"Unexpected response",
-	"Parity error on incoming request or probe response data",
-	"Parity error on incoming read response data",
-	"Atomic request parity",
-	"ECC error on probe filter access",
+	"Illegal Request",
+	"Address Violation",
+	"Security Violation",
+	"Illegal Response",
+	"Unexpected Response",
+	"Request or Probe Parity Error",
+	"Read Response Parity Error",
+	"Atomic Request Parity Error",
+	"Probe Filter ECC Error",
 };
=20
 static const char * const smca_cs2_mce_desc[] =3D {
@@ -276,30 +276,30 @@ static const char * const smca_cs2_mce_desc[] =3D {
 };
=20
 static const char * const smca_pie_mce_desc[] =3D {
-	"HW assert",
-	"Internal PIE register security violation",
-	"Error on GMI link",
-	"Poison data written to internal PIE register",
+	"Hardware Assert",
+	"Register security violation",
+	"Link Error",
+	"Poison data consumption",
 	"A deferred error was detected in the DF"
 };
=20
 static const char * const smca_umc_mce_desc[] =3D {
 	"DRAM ECC error",
-	"Data poison error on DRAM",
+	"Data poison error",
 	"SDP parity error",
 	"Advanced peripheral bus error",
-	"Command/address parity error",
+	"Address/Command parity error",
 	"Write data CRC error",
 	"DCQ SRAM ECC error",
 	"AES SRAM ECC error",
 };
=20
 static const char * const smca_pb_mce_desc[] =3D {
-	"Parameter Block RAM ECC error",
+	"An ECC error in the Parameter Block RAM array",
 };
=20
 static const char * const smca_psp_mce_desc[] =3D {
-	"PSP RAM ECC or parity error",
+	"An ECC or parity error in a PSP RAM instance",
 };
=20
 static const char * const smca_psp2_mce_desc[] =3D {
@@ -324,7 +324,7 @@ static const char * const smca_psp2_mce_desc[] =3D {
 };
=20
 static const char * const smca_smu_mce_desc[] =3D {
-	"SMU RAM ECC or parity error",
+	"An ECC or parity error in an SMU RAM instance",
 };
=20
 static const char * const smca_smu2_mce_desc[] =3D {
--=20
2.17.1

