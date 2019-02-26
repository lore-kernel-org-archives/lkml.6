Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9FC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C163F21848
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jXEHf4ik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfBZRZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:25:50 -0500
Received: from mail-eopbgr780075.outbound.protection.outlook.com ([40.107.78.75]:56213
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727416AbfBZRZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:25:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCzUx9ul1rL0KiaUMRdaVONdAXpMQMyDSeIjaK5mQSQ=;
 b=jXEHf4ikB97qe31or6I2lt7uIOej87/zZmpkHYUsopJJANhGxbJuqT2oxVDeNVhaDBHncj4na0OrMCgoJHJalWDe6Gtr6BgBRpXD5z8jHQSxusMG+JQA6e4aEEaP2wkf3EVh42O0s6R1xQDeqILFRsj8hTPC/9EUvXAuUZTsBHU=
Received: from SN6PR12MB2639.namprd12.prod.outlook.com (52.135.103.16) by
 SN6PR12MB2800.namprd12.prod.outlook.com (52.135.107.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Tue, 26 Feb 2019 17:25:45 +0000
Received: from SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2]) by SN6PR12MB2639.namprd12.prod.outlook.com
 ([fe80::d49d:a1ee:9bcf:20e2%5]) with mapi id 15.20.1643.019; Tue, 26 Feb 2019
 17:25:45 +0000
From:   "Ghannam, Yazen" <Yazen.Ghannam@amd.com>
To:     "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
CC:     "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>
Subject: [PATCH v2 2/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Thread-Topic: [PATCH v2 2/6] EDAC/amd64: Support more than two Unified Memory
 Controllers
Thread-Index: AQHUzfhOIhDa6JtR/UibM5UUWxzWkQ==
Date:   Tue, 26 Feb 2019 17:25:45 +0000
Message-ID: <20190226172532.12924-2-Yazen.Ghannam@amd.com>
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
x-ms-office365-filtering-correlation-id: ad176b3d-72e1-4544-f61f-08d69c0f7107
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR12MB2800;
x-ms-traffictypediagnostic: SN6PR12MB2800:
x-ms-exchange-purlcount: 1
x-microsoft-exchange-diagnostics: 1;SN6PR12MB2800;20:uQqUKlcAcaGodcyZuFHdt6Ag/IUa9pp3j5IalJqk7+BnYEzNxzkbUHS1basuf/+6Tnad2KDZtXmJ5G4DjYHLz8VwFbCwkrq23vBfO610BJrPB/3Xz0rZ3TLjHFcXqX+jaPrchIPbYyrz/T1rdYgzGBl3a03hGBPlCHFMCBLUSSnBR1CQTjH7UwIbFuaHsc2UKvxQpmzAdNiH8lElLA1ZzxnwTV6bMxGSOD815Dsf2LBwll3KahBUTcvBCItgN5N2
x-microsoft-antispam-prvs: <SN6PR12MB28004A5A33E9F923E6FD78B4F87B0@SN6PR12MB2800.namprd12.prod.outlook.com>
x-forefront-prvs: 096029FF66
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(346002)(376002)(136003)(366004)(199004)(189003)(186003)(478600001)(26005)(3846002)(50226002)(6116002)(4326008)(5640700003)(2906002)(25786009)(114624004)(102836004)(68736007)(6506007)(386003)(476003)(486006)(11346002)(2616005)(5660300002)(14454004)(72206003)(446003)(966005)(14444005)(97736004)(6916009)(256004)(66066001)(36756003)(81156014)(81166006)(76176011)(71200400001)(8676002)(86362001)(99286004)(8936002)(2351001)(52116002)(1076003)(305945005)(316002)(6306002)(6436002)(6486002)(105586002)(106356001)(71190400001)(7736002)(54906003)(6512007)(53936002)(2501003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2800;H:SN6PR12MB2639.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fy6rvFQM7dxYhjqQamY3TPRvzoEdmfvoF6BLVOu0y5arnlMkzOu4d7vsi1CFr5uCAEf+TxS0FCdUTCqgSbild0GZHmoq9U2lYBqKjby3oEKPVC9L3lUgHk/PGubKZpsw+0p4PQAuQL/s44snUOcAo9pSO7WlT8AQyCP7yVUMAqQnz2OgdByO+MnWQJmHWJ0cVnnpYJ1cNkivLXWswg6qSKUGUSIDjLGI4A1yZnuzoKKkea2t9kN+RR0nfkieiiJWEfj1ZC3IkcLn7IE9tvsjctu6+mbz+Sd7STwB3oWhENwfdsQwbNsemwiok3xBWAzGOww/BtWCdHRtgA73CNUd94w937+A5mHE2gYsYAajJHpkPMmQ0ONRMy1gn2oJrnJoj2BpmqpVXjGVBZBUSHOR56bncpnTQ7FtBsdj9NIBhN4=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad176b3d-72e1-4544-f61f-08d69c0f7107
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2019 17:25:45.0881
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

The first few models of Family 17h all had 2 Unified Memory Controllers
per Die, so this was treated as a fixed value. However, future systems
may have more Unified Memory Controllers per Die.

Related to this, the channel number and base address of a Unified Memory
Controller were found by matching on fixed, known values. However,
current and future systems follow this pattern for the channel number
and base address of a Unified Memory Controller: 0xYXXXXX, where Y is
the channel number. So matching on hardcoded values is not necessary.

Set the number of Unified Memory Controllers at driver init time based
on the Family/Model. Also, update the functions that find the channel
number and base address of a Unified Memory Controller to support more
than two.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20190219202536.15462-2-Yazen.Ghannam@amd.com

v1->v2:
* Fix tone in commit message.
* Clarify pattern used for finding channel numbers.
* Remove macro for looping over number of UMCs.
* Move function to find number of UMCs to single driver init function.
* Rename function that finds the number of UMCs.
* Add comments for new variables and functions.
* Move function to find number of UMCs out of header.

 drivers/edac/amd64_edac.c | 56 +++++++++++++++++++++++----------------
 drivers/edac/amd64_edac.h | 10 ++++---
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 98e8da9d9f5b..0038fcb0b010 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -722,7 +722,7 @@ static unsigned long determine_edac_cap(struct amd64_pv=
t *pvt)
 	if (pvt->umc) {
 		u8 i, umc_en_mask =3D 0, dimm_ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for (i =3D 0; i < num_umcs; i++) {
 			if (!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT))
 				continue;
=20
@@ -811,7 +811,7 @@ static void __dump_misc_regs_df(struct amd64_pvt *pvt)
 	struct amd64_umc *umc;
 	u32 i, tmp, umc_base;
=20
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for (i =3D 0; i < num_umcs; i++) {
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
=20
@@ -1388,7 +1388,7 @@ static int f17_early_channel_count(struct amd64_pvt *=
pvt)
 	int i, channels =3D 0;
=20
 	/* SDP Control bit 31 (SdpInit) is clear for unused UMC channels */
-	for (i =3D 0; i < NUM_UMCS; i++)
+	for (i =3D 0; i < num_umcs; i++)
 		channels +=3D !!(pvt->umc[i].sdp_ctrl & UMC_SDP_INIT);
=20
 	amd64_info("MCT channel count: %d\n", channels);
@@ -2473,18 +2473,14 @@ static inline void decode_bus_error(int node_id, st=
ruct mce *m)
  * To find the UMC channel represented by this bank we need to match on it=
s
  * instance_id. The instance_id of a bank is held in the lower 32 bits of =
its
  * IPID.
+ *
+ * Currently, we can derive the channel number by looking at the 6th nibbl=
e in
+ * the instance_id. For example, instance_id=3D0xYXXXXX where Y is the cha=
nnel
+ * number.
  */
-static int find_umc_channel(struct amd64_pvt *pvt, struct mce *m)
+static int find_umc_channel(struct mce *m)
 {
-	u32 umc_instance_id[] =3D {0x50f00, 0x150f00};
-	u32 instance_id =3D m->ipid & GENMASK(31, 0);
-	int i, channel =3D -1;
-
-	for (i =3D 0; i < ARRAY_SIZE(umc_instance_id); i++)
-		if (umc_instance_id[i] =3D=3D instance_id)
-			channel =3D i;
-
-	return channel;
+	return (m->ipid & GENMASK(31, 0)) >> 20;
 }
=20
 static void decode_umc_error(int node_id, struct mce *m)
@@ -2506,11 +2502,7 @@ static void decode_umc_error(int node_id, struct mce=
 *m)
 	if (m->status & MCI_STATUS_DEFERRED)
 		ecc_type =3D 3;
=20
-	err.channel =3D find_umc_channel(pvt, m);
-	if (err.channel < 0) {
-		err.err_code =3D ERR_CHANNEL;
-		goto log_error;
-	}
+	err.channel =3D find_umc_channel(m);
=20
 	if (umc_normaddr_to_sysaddr(m->addr, pvt->mc_node_id, err.channel, &sys_a=
ddr)) {
 		err.err_code =3D ERR_NORM_ADDR;
@@ -2612,7 +2604,7 @@ static void determine_ecc_sym_sz(struct amd64_pvt *pv=
t)
 	if (pvt->umc) {
 		u8 i;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for (i =3D 0; i < num_umcs; i++) {
 			/* Check enabled channels only: */
 			if ((pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) &&
 			    (pvt->umc[i].ecc_ctrl & BIT(7))) {
@@ -2648,7 +2640,7 @@ static void __read_mc_regs_df(struct amd64_pvt *pvt)
 	u32 i, umc_base;
=20
 	/* Read registers from each UMC */
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for (i =3D 0; i < num_umcs; i++) {
=20
 		umc_base =3D get_umc_base(i);
 		umc =3D &pvt->umc[i];
@@ -3061,7 +3053,7 @@ static bool ecc_enabled(struct pci_dev *F3, u16 nid)
 	if (boot_cpu_data.x86 >=3D 0x17) {
 		u8 umc_en_mask =3D 0, ecc_en_mask =3D 0;
=20
-		for (i =3D 0; i < NUM_UMCS; i++) {
+		for (i =3D 0; i < num_umcs; i++) {
 			u32 base =3D get_umc_base(i);
=20
 			/* Only check enabled UMCs. */
@@ -3114,7 +3106,7 @@ f17h_determine_edac_ctl_cap(struct mem_ctl_info *mci,=
 struct amd64_pvt *pvt)
 {
 	u8 i, ecc_en =3D 1, cpk_en =3D 1;
=20
-	for (i =3D 0; i < NUM_UMCS; i++) {
+	for (i =3D 0; i < num_umcs; i++) {
 		if (pvt->umc[i].sdp_ctrl & UMC_SDP_INIT) {
 			ecc_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_ENABLED);
 			cpk_en &=3D !!(pvt->umc[i].umc_cap_hi & UMC_ECC_CHIPKILL_CAP);
@@ -3249,6 +3241,22 @@ static const struct attribute_group *amd64_edac_attr=
_groups[] =3D {
 	NULL
 };
=20
+/* Set the number of Unified Memory Controllers in the system. */
+static void compute_num_umcs(void)
+{
+	u8 model =3D boot_cpu_data.x86_model;
+
+	if (boot_cpu_data.x86 < 0x17)
+		return;
+
+	if (model >=3D 0x30 && model <=3D 0x3f)
+		num_umcs =3D 8;
+	else
+		num_umcs =3D 2;
+
+	edac_dbg(1, "Number of UMCs: %x", num_umcs);
+}
+
 static int init_one_instance(unsigned int nid)
 {
 	struct pci_dev *F3 =3D node_to_amd_nb(nid)->misc;
@@ -3273,7 +3281,7 @@ static int init_one_instance(unsigned int nid)
 		goto err_free;
=20
 	if (pvt->fam >=3D 0x17) {
-		pvt->umc =3D kcalloc(NUM_UMCS, sizeof(struct amd64_umc), GFP_KERNEL);
+		pvt->umc =3D kcalloc(num_umcs, sizeof(struct amd64_umc), GFP_KERNEL);
 		if (!pvt->umc) {
 			ret =3D -ENOMEM;
 			goto err_free;
@@ -3494,6 +3502,8 @@ static int __init amd64_edac_init(void)
 	if (!msrs)
 		goto err_free;
=20
+	compute_num_umcs();
+
 	for (i =3D 0; i < amd_nb_num(); i++) {
 		err =3D probe_one_instance(i);
 		if (err) {
diff --git a/drivers/edac/amd64_edac.h b/drivers/edac/amd64_edac.h
index de8dbb0b42b5..40e63cea2d81 100644
--- a/drivers/edac/amd64_edac.h
+++ b/drivers/edac/amd64_edac.h
@@ -274,7 +274,11 @@
=20
 #define UMC_SDP_INIT			BIT(31)
=20
-#define NUM_UMCS			2
+/*
+ * Number of Unified Memory Controllers
+ * Set during driver init based on family/model.
+ */
+static u8 num_umcs;
=20
 enum amd_families {
 	K8_CPUS =3D 0,
@@ -399,8 +403,8 @@ struct err_info {
=20
 static inline u32 get_umc_base(u8 channel)
 {
-	/* ch0: 0x50000, ch1: 0x150000 */
-	return 0x50000 + (!!channel << 20);
+	/* chY: 0xY50000 */
+	return 0x50000 + (channel << 20);
 }
=20
 static inline u64 get_dram_base(struct amd64_pvt *pvt, u8 i)
--=20
2.17.1

