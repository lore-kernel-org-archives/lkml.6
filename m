Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422887AbeBOVLI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 16:11:08 -0500
Received: from mail-bl2nam02on0077.outbound.protection.outlook.com ([104.47.38.77]:8944
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755877AbeBOVKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 16:10:09 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-edac@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        bp@suse.de, tony.luck@intel.com, x86@kernel.org
Subject: [PATCH v2 2/4] x86/MCE/AMD, EDAC/mce_amd: Enumerate Reserved SMCA bank type
Date: Thu, 15 Feb 2018 15:09:41 -0600
Message-Id: <20180215210943.11530-2-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
References: <20180215210943.11530-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR21CA0011.namprd21.prod.outlook.com
 (2603:10b6:404:8e::21) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 29fd3f53-ccf7-46aa-76b5-08d574b87cdb
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:XYfCA0QllAHwzjsa876wT+a/bWvl4YGu4Yh7RB66QpNRjCvIRmSYtD4kguaQhWAVl1sJ2PzCHFBCQaFjWuZuqaNffw145+sFVaLLlqWR+8UOgEZJ5H6HSFrb2FUzTbqe82qIqZk4UmoNmdoTxIEUIfww/F1NWCbF/TnoblNoxTqGcKVTKkJSSRLp8TVu9NVXZJljJ/WSylGAx0hEo4yuMnWUc5bt1BLNZfyrInhh8xq55Se115Ns1Xau0QGbtnRD;25:vpnhab68Alc90ScqPgrwaB45g3ptbAmUfRWihyDagBwXWN9xUm8CgGJOXSCnLDBDhU0HqDnyAnJdsi67wtRG1f1KofNv5yjX6YNcLgitfLnK04HuW3AofTVQqVjyfD+9URcqSvYiuyXAXtTNfJzom37Wf/r6QBlMfx7XaxPiz1vAoLXC8Qp/qnoho2d3La0lxTnjDW9lsh7iNH/Q6llnZvJlzzPML9Ub1M0kA7oIxIWhYeX/MnxhEyd3EY/px5hip2SQij/Dp3Nk7uQntKN7EfJctc2xHPUxrCh/slmSWEe3R/rV9WT4ItnmiF4Sp9HsgMum3hEneeIJ8qYMtPbvLw==;31:3ZPuQBnYjagBX4y+ynhbcGoxLzGjG+B0LdjXovxEQB7m6gBLSD1NZRnz1TMJCbCGJEBGNTQa1ZSZCuCkK56/y0d9ThqfQY/YsSqY9Wv7vsGofCdSk6k4uL6F4vraQz3Qrtu4h3ez5TAdZe1RMd48tMz8pY0OLdbo86sND6rQfj0XC0Ohnk7u059Vdz2xiRGaLK6OWVX32NL03/KQWDTinf4+OoKBtl4I4cK/bjSL/pE=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:C/9b9k7SHVtz0ml/KJWrLO/aj6OyjDHdoQOvCsivz5GzMg3/M6ahwdj3gea8ThG4ayiWPpUDv/gSzE0qrxsH4yk8ppNIClCZSDZi9iemgyoDx45Gzuc5CyseFRzXly1Ww0oCyN0MTqAD0Id+RMibCMXTS16voShpEnhNPSNJvdk24pB0L3vOF6gnca1yj/3QDxBxKnDzvA8wWHogojfI/XF4q/BilURhYXgw3kxX+6K1bY/LrEJG3rdXevDFcvlQzDB44kBImPVFpO1jlZNH94nEtrsA1iBpFXjprjyegyShr/ZmGK4cqe/nuizXfLco9SArHgagVSlqD0Romxmi/3Et9TdYq0N9Rq4P/iAAtkjStLap/mcMAhOxvecY7nsP3NWomkDQYhumeODVDSBCZSXBS101BuTwrpvOSjxmvYyDDCZ+ahl6jQnydp43YNtB8O21p5lA7Nx3YVI8Z9aWJCC+JB+pjELxvR625jnamd4/dOzGHs8jPj1MmKBLjxo3;4:tM6Obv47diirtuMXEtD8SQ03hiS3G/uDjlk5zgTFhDNWCiN/e5YIFpkLsCqIFADkpUoA080kLPfig788lEOanNSrhDUuY1VBFgFGNMib5+MEOUSau+eu/D5Nx0g/guWM9TZrKDWNBGWuRQMkw0kDIlX0zH0sC6HA0q69Kw9oIc5splYKJKKH+HdtjL6nRzjMKQpUdkxqRBHOj7+OVaXscuAQw/Ty9rKy7AiA5UVLtAteW+09nfH24D8yOQCMJaRECRY0nQqp+pic7aEKovbiqoB6B24nQT6zVlNAClH1QiNzGyIVP12OP/n8PN8QL3dWuf8vv/pqOIXZo6OAyMQHFkx4L450kkPUiUX52HN9/q7z8W85u5Ybkaqbs7IkAJFI
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917F77421EB2BE31C54694BF8F40@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 058441C12A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(189003)(199004)(76176011)(50466002)(5660300001)(2361001)(97736004)(6306002)(48376002)(53416004)(6666003)(305945005)(2950100002)(6486002)(2906002)(4326008)(1076002)(53936002)(966005)(6116002)(7736002)(3846002)(2351001)(106356001)(16586007)(66066001)(47776003)(86362001)(316002)(575784001)(478600001)(7696005)(51416003)(50226002)(15650500001)(386003)(72206003)(6916009)(105586002)(26005)(8936002)(8676002)(81166006)(186003)(52116002)(81156014)(68736007)(59450400001)(16526019)(25786009)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:OYSlIbUkV2i37/nN52VypkHBTKWVM0Ns3fpe7m/pm?=
 =?us-ascii?Q?opj//K0LEQEpvZRTMohbLWBAbtALpmY4bgngyWUxLlCW4G1YDzGrXANPCSSP?=
 =?us-ascii?Q?MEMBJzQgTfgLBknulzP3+6OGnzgNlKphmiP01i4hMWFeCQ8EDvZ/96/TRov4?=
 =?us-ascii?Q?jsy7T5e+XpriR/Jx/i6tD5zNEftSy9Bt+9FPSNl01rr7pK8dcLCwGuoX/3s+?=
 =?us-ascii?Q?lVrDD5DrD1gMj+PWWBkSkGaZWAthCIOpcBG1wmgt/0TCtmiD/+G+h4JxO2/b?=
 =?us-ascii?Q?cV5I/DtAEai1dsSHTdmCqj9ol4vZuY56WBjetgw9A3Op6ruxH9ibNYDF3WDX?=
 =?us-ascii?Q?VMVYhh6o9v8mLo4d8MaeYTNFHjDByaPgPYKvSZMbKIJm+fuMCF1TU7goX92k?=
 =?us-ascii?Q?sN7R3zHmfqbtj+uNC8L8/Bjfw1AjFyuwn/YUzgosX2Rl+/GpntRruXvm/Wg+?=
 =?us-ascii?Q?XH+pV6JhlOLnp0SuSKi61rn8EcVUDplY0zKztiLmRopMwroJVFKbRuxBMFaJ?=
 =?us-ascii?Q?ReNxiltDgE5UFQa2IVRa5npUfLDImfMxcAZiLcFothHe/wn8q7bROq61EKJJ?=
 =?us-ascii?Q?M0h3Je2KO6hmmWwOq3ZUns7Iwue1RA5SdKcto/wTmbVZhoaEnbihQeSVOZ+9?=
 =?us-ascii?Q?mi4jU851V0uTJNtChHlBXNu1T0Nhd0bkICnwS3ToTdNP6DSQ4sJ5+/f4V6KK?=
 =?us-ascii?Q?3Iw+0GM8oGOo6acM4nmT01rogcL6DamYo7k5c94hO/mjc+3V/tcA1FQ0Pi5p?=
 =?us-ascii?Q?vuoelXYmhDKPrRvQj5C2LCxUdBq2j654OQk7XXFtn7oVzRGTd6Q6YUOEjOLA?=
 =?us-ascii?Q?XZs/ziIr6IJcfDSodiFYjHTfU8MWx/VZHtVXJUaiLBfW51kxEbFBuj5Y5bg6?=
 =?us-ascii?Q?OXbBGYVHjJl5T19t9FkA6rZTGtP1xBZMn17o/D9KV6gzREMXsJpL0SOKE5qy?=
 =?us-ascii?Q?hTnltjp21J3xZXBebnGIHxPAOuUO2FGPY1QMTEko+zsq2Bx1r1FnqYfFvI+u?=
 =?us-ascii?Q?c4CUlLgWk3j9nl4sLhfwVVeSr20KQ9/w3F8oMQEytNiZKzmmwSHx1LciaFSl?=
 =?us-ascii?Q?juqUly0Q9LUJR3Mct+e+0O2C9FHO0ZVz5BgPfBGIL6IxAeixKd/FQCXGD15O?=
 =?us-ascii?Q?rZqPAnxp2kKL5EjMPVIkmkMKWQxYw4ctIv8+q0Dfqaq8NZqC2ZoCHHDbwmit?=
 =?us-ascii?Q?NOkbTWSrOpS35E/MmChhoT1NJVtD8J47pXg7REzYr0h3WWu8y7cBIEBhZcvO?=
 =?us-ascii?Q?6vFZOCPN07XadMThA1GfAZuujXF6GyB6hnzUZ5BnfxuqqkkjSvEgyitb6Yqx?=
 =?us-ascii?B?UT09?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:9dhum1EfVa6oSc2833vhvobTwX2zE9yvxd7mIjV0qJ5RbbbPhJU/4lZr/agc/SjqpcofQwHT19SQ43RiYYWUh8oBZJ73hvOWorxlmLhSdifGCEeO5eABva1Ad+1QYB3jrUV2cE+do8Ae2H60chViPZgq2ZsSGb0UTGp3pFnXeFkoMuDqqoTvI4gOGE6e2QJVqNXMG7mxJ2eC1zADjpe/I3t3xkWL+MaAl/QVuKA5cNz+qgvXmxVBiKL5Xp6LfRpisVnN3DOUeJ/YWR9glGjb+sutE1ZfcOqqp8ILCzwvfbjTDC17pMLJD8ezxs0Uy+R6SwoAZqGyZzPZeQnpKhwFcUKhJKve08jBSdJ5zKMrM2A=;5:6GFzR0OcmlQ8yy+Mv/ohSq8kiiQxhno88/KUSr9fQlMrbHUfSYy/AzxvT1ZeGo/9uK5bHBgmp5dPPKdNj/HrpWsF/+PsKhFGBhn4KPaQ4LJE6DJqXLV0BSTZjfCS/nTUtfAONEM9Xjl6wuAHV2Br0QH8r7i/9qn82Jj4O9utpME=;24:e7nvgPjlcULchcyKt0ID8x7qiCUntMTUJa+6N45YG5+mt5Ri3bI3ynPVq65LRR6lpWBL80R/XUjWXra8Y/TJ4ySzyjg/9VRpUcJ8LmOjc2Q=;7:s801RjdN89d7YQRWOgsxYz6lMsXkJzRocYJj2fRCZgZJOt7sqaA2CT1xHTHVAsMQR0vTpIVC2slELxCG7p0b7B9Uj+iEJMun8zqDYty3Cn75feDnqwAR3wZwSH1M7ERTzjZlVfaBtvdVvNaUJA9joqW4NPm1LzuEbWmX219P3bM3djheqozC2mgTN3A4KWyZ7Oixcdx3ICPOEMJSq6zUTqlicrGD9iUaEA4wCIvUO1phhgqwXbMxzKRZivbqUh9z
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:BddNSU8uT5ed1BVqxyW3TGyz2GcyOmlUSUrQSu8cp320KsXffZyIwQH/zY92/yPhRGpZyjraw6lFvJsmCwoInN0D+PI8ywTAQJ38k77FZzOkkw6tB5J2dS1926F7Ck8TeQ1hYI5BDWxyuUPdBf4oClRyLjeJzbrSuKoVzmnnRDypLIsUgzbQ0DiA7zT4lGIY1uDqUnFwFCO6yZ5YdqcsCC7haTbKyim+HJ+Zu2azsswFAaqYFdHJmDdGsxdTGUrc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2018 21:10:05.0199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fd3f53-ccf7-46aa-76b5-08d574b87cdb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Currently, bank 4 is reserved on Fam17h, so we chose not to initialize
bank 4 in the smca_banks array. This means that when we check if a bank
is initialized, like during boot or resume, we will see that bank 4 is
not initialized and try to initialize it.

This will cause a call trace, when resuming from suspend, due to
rdmsr_*on_cpu() calls in the init path. The rdmsr_*on_cpu() calls issue
an IPI but we're running with interrupts disabled. This triggers:

WARNING: CPU: 0 PID: 11523 at kernel/smp.c:291
smp_call_function_single+0xdc/0xe0

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
Link:
https://lkml.kernel.org/r/20180201184813.82253-2-Yazen.Ghannam@amd.com

v1->v2:
* Give more detail on call trace issue.

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
index 7fbb19cb1859..d8ba9d0c3f01 100644
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
