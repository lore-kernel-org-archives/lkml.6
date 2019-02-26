Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B4AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAAE62184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tkjRpvwg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728835AbfBZR0K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:26:10 -0500
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:56213
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727054AbfBZRZt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=60JaydFlZKAasy9J+w83iyf2SjR4cRY5I0yYVZe7Qy0=;
 b=tkjRpvwghMPHBt+n9Ras1Qsl5NgIWoxQW0qExVD4gejIaT9NgtHDYPN6JV3uaCHiyQ2YLDfNv1+rU5ooJXi3whC/j8euIKWPrUDx7G08jr37XBUyKLdZtWhEhDqMyyDDgiAsFdbuKu2tgR2Wb6QLOK2Nit2eUYSBWG1xwmY4prU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 17:25:46 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:25:46 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 3/6] EDAC/amd64: Use a macro for iterating over Unified
 Memory Controllers
Thread-Topic: [PATCH v2 3/6] EDAC/amd64: Use a macro for iterating over
 Unified Memory Controllers
Thread-Index: AQHUzfhPOnzbEp1j5UuxjNRxQYhp9Q==
Date:   Tue, 26 Feb 2019 17:25:46 +0000
Message-ID: <20190226172532.12924-3-Yazen.Ghannam@amd.com>
References: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
In-Reply-To: <20190226172532.12924-1-Yazen.Ghannam@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0094.namprd05.prod.outlook.com
 (2603:10b6:803:22::32) To SN6PR12MB2639.namprd12.prod.outlook.com
 (2603:10b6:805:6f::16)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 79743eb3-b024-4a4a-b975-08d69c0f718d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2800;
x-ms-traffictypediagnostic: SN6PR12MB2800:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2800;20:qewyLWz1tVFxP1MEu3pDkCdSlo4D+xzi7ivvyEyn0KJTNy5gfOV5vA+tA2fviaHen+RyqCbZp5UDmKx9ohWa2ekdta5SxXAplFkUN1bz0SkaWnCN6+DPu3KIyKlIqp4SMuH5GT87EDMdc8O/Tr/SpW02Y5DZZyT1sl2XnWHDwAKkJvNA0GZD6G2NYAe4B3+cPormcUxQt6HPa+zZWTd7+r6toe+xXND1mIHdmLXUpbfIb61x9ma3Az4rxY13GIjJ
x-microsoft-antispam-prvs: <SN6PR12MB2800CA20AB6900E89AC38AC1F87B0@SN6PR12MB2800.namprd12.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(186003)(478600001)(26005)(3846002)(50226002)(6116002)(4326008)(5640700003)(2906002)(25786009)(102836004)(68736007)(6506007)(386003)(476003)(486006)(11346002)(2616005)(5660300002)(14454004)(72206003)(446003)(966005)(14444005)(97736004)(6916009)(256004)(66066001)(36756003)(81156014)(81166006)(76176011)(71200400001)(8676002)(86362001)(99286004)(8936002)(2351001)(52116002)(1076003)(305945005)(316002)(6306002)(6436002)(6486002)(105586002)(106356001)(71190400001)(7736002)(54906003)(6512007)(53936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 47b+8nbD6Hn9zCiBi+gRvU0v7hNfuvQnCPaFNOsQqLBxhkdenJEl2lhz1xj+Mov4iOWC+KfODRjTZqNNVcXx2P5c/RfplNFvE/AW2z4Rj7csXXwl+rVS7IZzedXC7mL8Lld2eimpWbg5/05cmqsiJhXIPadxcwJor19E951FeXuqg5zEYdypf4vdd2dhTxsf6MlJvtpH5cBsZ5kzF5xgB7PZz/LlaGXjcGxRwcrdOw40/qCRJXAmZW+Qj5EibB6rhGLSSdt2S4DnsrSeCaydO+OQcH0sh2NyqCZArKjs6gxNe/0WqzFWGmPezMZ1NBZlmBecy+cwv+/K+FTINNGbolEqAO567yERR/GG8dHnMfvpvCS2IfpnAxXfgUkptQESq8xlgDFdylRidqmOp/551WgA5OhIArrhkWVZZQ+sSI4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79743eb3-b024-4a4a-b975-08d69c0f718d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:25:45.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Define and use a macro for looping over the number of Unified Memory
Controllers.

No functional change.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190219202536.15462-2-Yazen.Ghannam@amd.com

v1->v2:
* New in V2. Please see comment on Patch 2 V1 at link above.

 drivers/edac/amd64_edac.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 0038fcb0b010..c82aafb7246a 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -449,6 +449,9 @@ static void get_cs_base_and_mask(struct amd64_pvt *pvt,=
 int csrow, u8 dct,
 #define for_each_chip_select_mask(i, dct, pvt) \
 	for (i =3D 0; i < pvt->csels[dct].m_cnt; i++)
=20
+#define for_each_umc(i) \
+	for (i =3D 0; i < num_umcs; i++)
+
 /*
  * @input_addr is an InputAddr associated with the node given by mci. Retu=
rn the
  * csrow that input_addr maps to, or -1 on failure (no csrow claims input_=
addr).
@@ -722,7 +725,7 @@ static unsigned long determine_edac_cap(struct amd64_pv=
t *pvt)
 	if (pvt->umc) {
 		u8 i, umc_en_mask =3D 0, dimm_ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < num_umcs; i++) {
+		for_each_umc(i) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
 				continue;
=20
@@ -811,7 +814,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 	struct amd64_umc *umc;
 	u32 i, tmp, umc_base;
=20
-	for (i =3D 0; i < num_umcs; i++) {
+	for_each_umc(i) {
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
=20
@@ -1388,7 +1391,7 @@ static int f17_early_channel_count(struct amd64_pvt *=
pvt)
 	int i, channels =3D 0;
=20
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
-	for (i =3D 0; i < num_umcs; i++)
+	for_each_umc(i)
 		channels +=3D !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
=20
 	amd64_info("MCT channel count: %d\n", channels);
@@ -2604,7 +2607,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pv=
t)
 	if (pvt->umc) {
 		u8 i;
=20
-		for (i =3D 0; i < num_umcs; i++) {
+		for_each_umc(i) {
 			/* Check enabled channels only: */
 			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
 			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
@@ -2640,7 +2643,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 	u32 i, umc_base;
=20
 	/* Read registers from each UMC */
-	for (i =3D 0; i < num_umcs; i++) {
+	for_each_umc(i) {
=20
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
@@ -3053,7 +3056,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 	if (boot_cpu_data.x86 >=3D 0x17) {
 		u8 umc_en_mask =3D 0, ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < num_umcs; i++) {
+		for_each_umc(i) {
 			u32 base =3D get_umc_base(i);
=20
 			/* Only check enabled UMCs. */
@@ -3106,7 +3109,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci,=
 struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en =3D 1, cpk_en =3D 1;
=20
-	for (i =3D 0; i < num_umcs; i++) {
+	for_each_umc(i) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
--=20
2.17.1

