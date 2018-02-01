Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeBASuO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 13:50:14 -0500
Received: from mail-dm3nam03on0054.outbound.protection.outlook.com ([104.47.41.54]:29401
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753153AbeBASsj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 13:48:39 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH 2/3] x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
Date: Thu,  1 Feb 2018 12:48:12 -0600
Message-Id: <20180201184813.82253-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
References: <20180201184813.82253-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR1101CA0010.namprd11.prod.outlook.com (10.174.237.20)
 To BN6PR12MB1907.namprd12.prod.outlook.com (10.175.102.13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fbe03e14-b8a7-4394-1a4c-08d569a461c8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1907;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;3:YUjEo2f5fWuvw6MORu+qOKCOVg/e0+6l8b9qnYWH75TPp8cPURnArvHEvfZpOuh5S1WfHcZf+txYk2uvTECDifHZLfFk2zqR82nSVdxOV7fA71bXnTYTjLPwx8WCjVdbmSrMfBf0GkdfuyCogawOBU5c3ZCWW3C4nU1vjKI12iOa17YCwzut8iwW6i+66kmSJhmp/QC1x8Ub6z4W8RvkWB0kgJL/nsbahIT00J9gIK+G+m/oAe9ZA0CXZ7ksPV7g;25:7qM1EROKA+x5hqrFK/e8fwzpJ7yFzcX8kUHB1Mzby7lNUs2wqUF/arKGHQJdP5iARjEwx1sHZIe8/2cOl/baWiN8kd72IGeg1WHi8DBE8/frw/zWP/pA3qWe1+DsG/AAVXUFp4dGEWC1m6Rh4E4ajP4mEUEVxzoxpB+4QNB6QM8B/5YbY/6v7njBrcPYIoHKWzj4Cyax6wzfSO3blSdMKrLT5GHqvUujk27rtgMfdYt+0c+gDWTB0OX2xk6Iqz6kWXx3DxmpNiUOlHAaGnzizBE5cog6U0CC6Hm8BxiRr6oudM/D3M9wFU4aWc0Je9vYk5/zGQD4ekmlGaiBP2Jmmw==;31:Rji1NunfxGpFpYh+OtbDeQtklxRjwbO3Zmzqnq7JweGSNU0GGNzUHQaRllKm6K6FQLLYn+tHMCP53WABuw7kURnkEY2WAUZRv5QZk8dIIzu7eqc47cLZRXfdwrzWUuseEPnqVzPWn5n8MctZrp1p+VBPh73yvlS5fsVlj/04La2MY/eacK8q3kxn7qhcXuaQeaDiL8LzZHw/hAoKSpW4RiZsKDMIlbtEbrQwg/E6o9I=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1907:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;20:txRBQinxnntyOE9IGlfhNrThiJHzlmNNW+GtgWqt2Cjn/1iWyEOLpGZFzGD/pX+fWYVzQQRiPQlI/3SytqPgXx3IrEMFIHaCX4ebhaQ30rlY/87BK4b7Rk+ZVcbsWF6XbsnegON2uSm6t7HSWaMvx5rAyBo8opxXsUD0CLsRmZ6hAZZGtD+JAHlWk36sc0J9VmcT+d7mV+0M/MLhe1YMkgSKVpj2hfumxhorbHnt6BEXVOovH3RbNKiwO1YYnwbuQXR5b3R6a3tRp6cgNJ2dRVgg5RAC7VsggMZdP6NILpmOviR+5DJDDmdsw32eAsyN7raNlHPQ8DALfW8FggKFvFOFtVywN0hN4vgwt15zH9tSMSOZZIBgTIXnI6vFrs6IXlea+GU5YIk93XbWASSlKCtrBMEVOZvgvipDPd3pE2b3i0w/w/1q2RRfl1pk2utTdCAQ7tyjSGO9Z92fhXYtUIWzLGwuhLc1rnLw3QHycmQ2j9ebmL+RFhSQixpBTvXW;4:kWbU1Uu/9mTk8rnMTrvdubLII0Nvhn1IhiOrDWcvchGdRBUAmEGvDjZzWSL8ztr3W8dkh02Lr2cMoyzpFHx4xQdcb/8znQWj8dhX0SurAg/ONeMT3vfJ3rQhA10+b856qto2eDU3dSxsh1o4H+JKbJRDEJ82wFhNSNC9QCbA6Ilfe1D6NX+m1lo/rPAF/+phs0o9xtDp2Woxw2xojT4gD2D6ffg0mtYEGsbn+Ai2tAIGwM2ttj9rVaFp3PD0gzaVxzCj848WJaqSPSnkAXkyZxq6FkDHRSXRZ1H8omuaIhq2oehc0ih8BBXOJOUVE1POtWnd08d8FHVxNtVdWf3KOA==
X-Microsoft-Antispam-PRVS: <BN6PR12MB19073538C16235882A090FE9F8FA0@BN6PR12MB1907.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1907;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1907;
X-Forefront-PRVS: 0570F1F193
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(16526019)(3846002)(81166006)(53416004)(68736007)(7736002)(4326008)(6486002)(36756003)(53936002)(6116002)(2906002)(305945005)(1076002)(97736004)(386003)(59450400001)(6666003)(7696005)(15650500001)(25786009)(47776003)(6916009)(26005)(2950100002)(52116002)(2351001)(76176011)(316002)(51416003)(72206003)(66066001)(105586002)(8936002)(106356001)(50226002)(478600001)(8676002)(5660300001)(186003)(86362001)(48376002)(50466002)(81156014)(2361001)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1907;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1907;23:BsJf7ru2QDlS5+qC08N4BsN6XEBYOrGabfgVxWLbW?=
 =?us-ascii?Q?u35v2r8sPTFeA/gsiVSnW8Nnf4doiRak2CULGXCIr0tnb/u98mioGKhDlus0?=
 =?us-ascii?Q?5NzgfsL/jsW52QijxKjwJILQ2xuhwvr/22nCKqdVPLqSCr/5YQCN3QtS7cp6?=
 =?us-ascii?Q?FgF0Xtc6RGnIAEcOJMEKnrchQR5O+giFZLUePyLlBKZEC3MVY+RuLcYoYJqj?=
 =?us-ascii?Q?tEyXrZQs9SHeL2TQepHepvAW0NgfTOJ9azdSSum3PSpsBF6scPN4+lrc0Bpv?=
 =?us-ascii?Q?E3ghUHOWfENomMwtyDfD5eJ26Ed6v81sJqWa0+Zj436cjvs5StrwVsVkoHPh?=
 =?us-ascii?Q?TrJvlgPNUVUZpGGyB75r2chq1pkhoeFnGgtxkEMwOOlQUfPxJrmazNibR5Kn?=
 =?us-ascii?Q?fXtATShDvnHPNJ0UAZBLb+9aWlFNL9bpqiFfkjMY4S4GMXb1/Mj/x4Mcr3eH?=
 =?us-ascii?Q?atWO1/t9g6HY6v3v51RCA4qd+vzAf/yA4f8zIr2WvBeaNUZY5LJD9vn7FTaJ?=
 =?us-ascii?Q?JZChErb3FKsa8/Nni09gfBQ86XfKB5JXlXIJiYfbvJwTJWTHgD4tHb3vbg+L?=
 =?us-ascii?Q?FXw9W0bFsYLHzRt2SgrgsdOpZvpr56YqZmPZWHvFUH6TTQIYQ9VP5LCxlFsO?=
 =?us-ascii?Q?KyMt2CvQZZJ1ZNBb1eicn4VrrToWBoRLGVRV70NsKTy2wF34+myhj6y0GjLr?=
 =?us-ascii?Q?Ew7h81i02cvgROKYcYQEYSVgcOnT78LZeLdkOCg910jfFVuAePPvwtvPmx6M?=
 =?us-ascii?Q?okKq1T7FHkj61CEoSAkHP21h1dUR2l0eyjs8ZG/7/M5B3XusU7IcCjf9KVgh?=
 =?us-ascii?Q?wss7PtW1i6emOxinr0MQoQ0Qlyf66RJJLj7zIufAyKiJ62gRzdYVro81a27L?=
 =?us-ascii?Q?23FOvQEu7EfmjkyN8u+jQaCp69xRdoLghb7zxjui0hMhLmkQ6P3G+fazWII4?=
 =?us-ascii?Q?454g5yOFtyxCxWvi9n32mOBFlfyOQjB1ppMh4thi6QMxMDxBcT7/L363OD8E?=
 =?us-ascii?Q?TZ0vuehD149AZtZ4r44xALOBS4sfrA/ra9b6ebYfFv3WjQwAY6Yw22f9TN4j?=
 =?us-ascii?Q?ia3PSJ7qB/URbJF/hqv/kxPjs8X5RbBoEvGkfWCSPnifJfI3Mj6XvP26T+Eu?=
 =?us-ascii?Q?FxWYqbKAvOJ8cFu8QcUz3iJFSRL26pd+ZMnvv9Fz9P2pPwdYMUVC0lpaDoAU?=
 =?us-ascii?Q?OUOyoKHe3I6AXRFl09cV28sSUL22v125wjK58jOXdX2G+Cq6bdreRN63g=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;6:T8jB0kym7hksNNw/OTD+q2x8/KSou/zTb+OAlPvAiiFcr+uQbtktDQpHr7xMdu1XQBZOGcT2139fyo5Gg/F9pgzYFoYa3kX2PH62YuEOgPWWqKzUzEkMcSVKXNTOObByRZGkQBta5i8ZKcGacAQOaSIIwltN41t//SnFX+aLt103skaQC+6joGkb256gQpMbp35ggCfZFxqywT9GvCp3yrlDWhiAn3BbnY/hqIywlXyClR5eQ5Ex5jEMVhTTCQFxPlVRg3WnG6w7ynueEYTBkQw9JTib4S+Uuu8mkZ5vBzp+0pgcqE65qyWK8qG/oC7pOOUhaOacRRtE7eLiRALVjUfpgXEbEhYi5uNX1//ZjVk=;5:7Qv/7ZQca78e2Dykt9cBF9bsjhddF8v2I8TUI8/MmKG3zvZagQyxWIcmuVmRuIanKGm3bczjORyQ9w5CASd+l/sM9mcM76vfddrjeZMdAsCa6LAYeEtw5NplU9YoMIcPp2xtpkM0JCuKGZCduM6cErzxd+LcxfF7hs72VcyW5t8=;24:42p5TN//VlXKbuSLWrkwv3dQShpo7Pb6U44XL5eIwQq2z1CjUANNrSsoRL+9r85TpwtU9jQr3SU4knLJU72M1ySp/X4YCHh0ntHWu98L0Wc=;7:nTNObtf5TBwOFQZ+xNd5s4AviySN2CGY0F3nDeM8b4uE+B5Qp4uj6Q8wrEqBwr5YFbbt8hjPS6fvXoS41+10jFz5DclyT5yqZ0fTX2dhSfr7E0zuaQgZAEtTGW2+4qnHV8vn9zH3rvkZJ4locof6tKLaK3OH1SUx3keSL897R1nktgyQWgaZTbVexf8UsIeDlXUtv/f+mJv9q3Dm1k+NVTkugEM3xUE3QXHM4UDU5KG/srpxqPAlxbllaSmjWByw
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1907;20:aK74L1awBm7aJqVZDDABp39KjZeCSNN9HBt9qzBRLJHD5g9v/7aeK0U0jwa9DMgnsTdNUyIeQ47S7OyrxTnzRRePt5Qh+VMs5JSRgfzYro1lEYkstwBLzBOaQ3yO/AJKWJD3uX42ZwR5Hg6toebuHGJsNedcpudpo5IBO9+k+EEZcv5J88n03wGPvwesHE/Ao0ei8+x84rg3+RFMy/VTqAy36C2Qh0Fz3FpR6fFR/xoPUJDTcdaSQ/SDXajT8cvL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2018 18:48:27.1818 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe03e14-b8a7-4394-1a4c-08d569a461c8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1907
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
bank 4 in the smca_banks array. This means that when we check if a bank
is initialized, like during boot or resume, we will see that bank 4 is
not initialized and try to initialize it. This may cause a call trace,
when resuming from suspend, due to *on_cpu() calls in the init path.

Reserved banks will be read-as-zero, so their MCA_IPID register will be
zero. So, like the smca_banks array, the threshold_banks array will not
have an entry for a reserved bank since all its MCA_MISC* registers will
be zero.

Enumerate a "Reserved" bank type that matches on a HWID_MCATYPE of 0,0.

Use the "Reserved" type when checking if a bank is reserved. It's
possible that other bank numbers may be reserved on future systems.

Don't try to find the block address on reserved banks.

Cc: <stable@vger.kernel.org> # 4.14.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/include/asm/mce.h           |  1 +
 arch/x86/kernel/cpu/mcheck/mce_amd.c |  7 +++++++
 drivers/edac/mce_amd.c               | 11 +++++++----
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 96ea4b5ba658..340070415c2c 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -346,6 +346,7 @@ enum smca_bank_types {
 	SMCA_IF,	/* Instruction Fetch */
 	SMCA_L2_CACHE,	/* L2 Cache */
 	SMCA_DE,	/* Decoder Unit */
+	SMCA_RESERVED,	/* Reserved */
 	SMCA_EX,	/* Execution Unit */
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
diff --git a/arch/x86/kernel/cpu/mcheck/mce_amd.c b/arch/x86/kernel/cpu/mcheck/mce_amd.c
index 4e16afc0794d..bf53b4549a17 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_amd.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_amd.c
@@ -82,6 +82,7 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_IF]	= { "insn_fetch",	"Instruction Fetch Unit" },
 	[SMCA_L2_CACHE]	= { "l2_cache",		"L2 Cache" },
 	[SMCA_DE]	= { "decode_unit",	"Decode Unit" },
+	[SMCA_RESERVED]	= { "reserved",		"Reserved" },
 	[SMCA_EX]	= { "execution_unit",	"Execution Unit" },
 	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
@@ -127,6 +128,9 @@ static enum smca_bank_types smca_get_bank_type(unsigned int bank)
 static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* { bank_type, hwid_mcatype, xec_bitmap } */
 
+	/* Reserved type */
+	{ SMCA_RESERVED, HWID_MCATYPE(0x00, 0x0), 0x0 },
+
 	/* ZN Core (HWID=0xB0) MCA types */
 	{ SMCA_LS,	 HWID_MCATYPE(0xB0, 0x0), 0x1FFFEF },
 	{ SMCA_IF,	 HWID_MCATYPE(0xB0, 0x1), 0x3FFF },
@@ -433,6 +437,9 @@ static u32 get_block_address(unsigned int cpu, u32 current_addr, u32 low, u32 hi
 	u32 addr = 0, offset = 0;
 
 	if (mce_flags.smca) {
+		if (smca_get_bank_type(bank) == SMCA_RESERVED)
+			return addr;
+
 		if (!block) {
 			addr = MSR_AMD64_SMCA_MCx_MISC(bank);
 		} else {
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index a11a671c7a38..2ab4d61ee47e 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -854,21 +854,24 @@ static void decode_mc6_mce(struct mce *m)
 static void decode_smca_error(struct mce *m)
 {
 	struct smca_hwid *hwid;
-	unsigned int bank_type;
+	enum smca_bank_types bank_type;
 	const char *ip_name;
 	u8 xec = XEC(m->status, xec_mask);
 
 	if (m->bank >= ARRAY_SIZE(smca_banks))
 		return;
 
-	if (x86_family(m->cpuid) >= 0x17 && m->bank == 4)
-		pr_emerg(HW_ERR "Bank 4 is reserved on Fam17h.\n");
-
 	hwid = smca_banks[m->bank].hwid;
 	if (!hwid)
 		return;
 
 	bank_type = hwid->bank_type;
+
+	if (bank_type == SMCA_RESERVED) {
+		pr_emerg(HW_ERR "Bank %d is reserved.\n", m->bank);
+		return;
+	}
+
 	ip_name = smca_get_long_name(bank_type);
 
 	pr_emerg(HW_ERR "%s Extended Error Code: %d\n", ip_name, xec);
-- 
2.14.1
