Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeCXSvI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:51:08 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752731AbeCXSuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
Date: Sat, 24 Mar 2018 13:49:37 -0500
Message-Id: <20180324184940.19762-6-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
References: <20180324184940.19762-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0036.namprd14.prod.outlook.com
 (2603:10b6:404:13f::22) To MWHPR12MB1919.namprd12.prod.outlook.com
 (2603:10b6:300:114::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a68188d8-3c39-41b1-0f64-08d591b80e7e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:Tfu/NvWScy0I4uwOj3bNlZKsmii6Ocg6QHMxzBNxo9Hg2VgOqkuiGFwBzjq2FVsTs0XePqiUW0j3QOxrQPMDr2AUbguor0TiMuHnelTiG2sGSSjePFDWUVqOh+XSsx1j2BjS0hM89TySHLv6W8sAcZDVYKzk5ZUsES8drSQpj213uuhPC4Vx+M91sdVhsZ05o5KLn6NeFDao0xZh1PNYvz4nW832Jht8Uuz9JxyhGm5feBG+NBeRhw3SnOTyMQdu;25:HiJR/ZEZwcKOz77GyzEOR5xyOZ7OHXA/SQU9v3Xmt7lXQdhMb2qhf8kARjP5qcLB7cpriR20pZLvc31aWaT4+bQLPNYxUR454PBI2U7+/Bt5lWg0lllV1l5rBkk6TvPM5RcUc0QU7Mom+rX5NFkFdPb+GrxPDvc6dUqMLR78s86cNrlAkrjFNRIY7p5HQTnXHHjtPEKqT2UbhdOWrH+LvJJHMhiwH6I0NYYCGGIl8Ql1oFbKgAp3HvgyEyl0qaZaQDUDF22YZ5YDGhiyrgrs5Ko59CwLgr67Z64MU2G19XZYHv1S+fqdhk59zMc0JuebcItAWQ1uyVvv8XZrN1/Qqw==;31:t6b3/2LrhL/SuHSZahQr+XKB6JsavbATFu7fQq0dhc5eeR5uH/I3AmeHv9om267qHAyTEtJnwZckSliZAM51cfi3iGXPjfSp/KRJHsYUr8WQl5JGPPbARpcNzfj5WHBIcP133r+gf+vyptoOq18gcVzRpm86iRkiJmBouwKSNzazKrLgQhWCIKdxbQhxxNDQldSI5a7pXrXzXTJZ+H6o3675t5f5DV3546DsXcWVBbk=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:ktNdhSE1Fnk0kumRJrUuJgM6tysC8CJ/VDxnjf452eOGxvts3Idt1+HZvS0UpgIGdRlX7kay+FD2h6O2ribg3GEau7WD+UlHufAIWHOZ9bewWUuKI7EjAd7Tn0ohfh91cJrtH9zTM4l6aeNWBny43sJBhVo/cm8t4mfqG1kasBD6SLHb6ggn97zk/nShJXC9KzKkXL+sObh8xSjg3RNnYndGLpULTCJiKXi61HFLDE7c1tOqs/NasMxolaBg3Ds9W3VmkGuh2HSb0ZlJicmcYVMI6vlH1ZrN0sXLK/xwu81aaQgYWnxDqnnd0FuZXWgoLJNVYo6Ss7K3u82LMU2Jpu6IOu6ZeATvLL9L+hTgcbjSyQ44LaqhQ9KNMLdL0xAcgvYRY7qnOaIUVmBeHA2oAug81aLgpxbT/I4dm7NNw+PgJQC6fRzooD0BZ/z1S7Ax/erxmiagR6uzCqrPL9h65onTMY+irOcRZT2rzPuvZtwm9Ef/3VIiUqUIWAeEXMJS;4:dNl1iE42WfvLnyWJBrm5hl3JS9wS9+JGHAU+88xaI9k2t8joahfVnlMiZ1vQingDDbGrXO3QVja5vu1aa9DWnVsUt4bKZm6dBFjqo1r3G3Bm9rkqcoCtRPcQeRNwvnJ0kfhNnCHsCCxgvDiPthfsixkLeKU8igZA/lyASk8rjliz8yfWxzvU5cj5i0G/S+rd+EOJpvenRq6ETQBkr7siBMCxzn3iGbwDR3/9GyECCkWx5lR9JxwNvkr5yN1BtNhY/AmA9Rjog8cusJE3WziDpmtSV/qsY/NOnItCwuEE7CCkXLNkQu57O7syEfekJUIJJJgpvxbKZPYbY9IcyjD7HvZktNrSq8KTcDk8aHcDBmU=
X-Microsoft-Antispam-PRVS: <MWHPR12MB191946D73D03AF43B060A406F8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(59450400001)(11346002)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:l8ytNaBKuQTDOszySawH3/bGal2y67UHBUI0U0GGq?=
 =?us-ascii?Q?34XpmwPZqDA19wAWlbUKUYpVXrs+GQdKY6dA29jdwc7o7O/2VQgyZg/bKBxc?=
 =?us-ascii?Q?xUDv9zy+Kx7xOgZZRMLtxZn5uU7Ep3FtO+/Irrd3qC9rTIb5akzhdTZiiCdA?=
 =?us-ascii?Q?nWazXqyPqtAWi9bfXi0TX6QPxBgcecfMsRpLn3noXxsVffisiw3XE/79qxsB?=
 =?us-ascii?Q?MM+LP+1n6CL1rVOHgqI67wc7O7CsvikCH+osyLKYMTTBn6jZ3vPH7VsBQxTB?=
 =?us-ascii?Q?fRLi4LXnWA7eIn6yGYYiW65oeru+sdAJT/szRQo7qyRMkg8BER7w2X/7bxs9?=
 =?us-ascii?Q?7B1vTYM7yOKHAzDPRant2ydGY7+2DJgWfD3J5bx6/T0oM5tORdQd0z1qDKX0?=
 =?us-ascii?Q?BAe3mmENJEwl7WHHv2EmA/M+o8lTCSRij/UfK1bIqAhMzbA5fJU+rZA6V9ME?=
 =?us-ascii?Q?6I03WH89hMJJrOxCgneOPb5dPlXTTbEs41v7DB4OjAME79dXLJk3ruit4KEv?=
 =?us-ascii?Q?1Fx43OiGen2yjCTnGDH4ozMOcLDULuKHdrRpzxpxE0jzNH7IPJ7XZgfe0yT0?=
 =?us-ascii?Q?1kSWD0FQ3bK7knLzgaCBx7ymrvxuDDPhkmoX9FDNA+AEVCYHEdQ5gH5YaGnd?=
 =?us-ascii?Q?iW18eNXCHsJjW5kE+v1kA5g6rhMbbTHhJ4i52Z6G95RklvQ7B516dUG2IMY5?=
 =?us-ascii?Q?im9I40ruNN+YuGUnzBsij6sfhMba0Tq7bwMSWgID6uUDLNimfMnALktc4rbp?=
 =?us-ascii?Q?qn913QxN36UGdKjwilROerMDFGS+hmpPnwiKoSG2QBXdeCrg0/XnkGaoCaJ2?=
 =?us-ascii?Q?OHoLmYLOltwgnFmuJKIC5eNfVwCIOZXo1+wvBK0dQ7SabxrCExQH7JwQ7RW5?=
 =?us-ascii?Q?HnIueALxl0voJMumsxoMtpKZ7boV9b5pCVlEUfkFSTN2NGDuUveCEse5rr4r?=
 =?us-ascii?Q?R1+ec3A3aYF8EtGfdzeGwXVBRkj8V0twX1mE6a4SqShgT7xygwPXli1SgpRG?=
 =?us-ascii?Q?P9KK1pOpE3JUqmaQ6MNlvirZWhSEGXUf3OcX8FePW6dGsZ5EZR0arAVfS3AN?=
 =?us-ascii?Q?pcB+WZVNDMLBe5d6O7ITTx9KC9FxByknjhSglXYoy2qF/IyNiL5rtAkAIjvw?=
 =?us-ascii?Q?eeCab5ExmcBNGJnAgXCmpjpHXh/VHTrOpyOfPbgRe0j3JbFYM03m0jFPslb7?=
 =?us-ascii?Q?4H6uPllXr0O0+SiwJXy7zuqn1zry1lmvkqgdxVS2DoWd0F981jxlXglrSgdR?=
 =?us-ascii?Q?r1Iq3t1DBMIx9zfr331B3gaLKykNkzIIW5rUwQPqH7/yEEfItrX5Ta26RIsa?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: GBh1k5ymSEa0xNYlEVM9kx7p7cyNP0NHk+HzIHXcObtqlF1I/wkseSnCCJB/telre9hfKk9Jme/C55yGN9xwE7ZRcQVqd6JfPTbqJYTbugDpzhOjobyJ/HLcR0+KFlkwM3xOVSbRwnQ9vvppI/aB3aNW5KTPs3GkQp456/q6L2a/3PkPJeDlX6tXy3XtX3pH
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:vwVTKb4lCIgqQT59p3s+PnLifGEx2yDhggGufkP2u96SAv9soBtfZpbn6RuoY2MJINqYGtbdxxQIBRxEX7uepiz6XMVuzW66QxgXoyceE4fyyCJeBbrUQqtqwkd5qY97Ygp/l5iS5cm6i/lLLBooLgzpa72H9PYobBacvJYYHyiy6/oAWdRo1JuZTT1t09hm0IW2fCvzKf8zpcZEyPvGgt6TuGql2FF1vsVEPyeyesA4yUrpHL9Vz283LbD25AVCkt3m6eZ1BH5kpoweN5U//S2psXUJ6HMAc+DDCoWzQ9LPHIh0ClMv8L7EMC72bABRM9fqwyQEMuVS2bL/4svqP0MB7RCaeRvRqoGO0a3hlDabi31CwmPpMa5eKDh9dLk/OCGhgyYw7UQWDLM8ckWJnpuPxeknBJR+komYtv/xK+9w4koJfn5fhNELldlxXQy3i7B1AhLQUTW92vlc5aXmBw==;5:ApqeIT1RQS/KeTeNhaT/Z6gcyzcOTBpeZMeFbDQ1u7d8dsuAJyG2GfPYKs8ihImFcghYbFilFFTpurhRX14/sIfumIxiINaIvGavmQ1ROeOd/O6xtZSieSVUuy3slX83OARpDInFkXD8vhj3nsV3Hxaqx2lb5Ke4d5KOXbjW1II=;24:tRfE5asybICNLWBzViuYcCvA97JSX6fYl6GVJGH6tBvCSe9ghxUEsCbH/cquahSzlCXvTambPSmctPOj8qhIDCxhwF0gFUhyDicMt03FE40=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:hMsEjCgobnCzcfz4welf+ES6z1fL9keXwtWM8QF5ViOb91dBRkM/5JKTX9Xnup3BYUUSvp6dHmYlDsZn/eBXGxtNT8vR7iw47MBUD8Hww1hmsB3uCQJuOF0LqOQnXeb4mlBVO47e8+rUxY3q1aTL98ybAORww3DBWoBzuBzkJtcwVyi4y1vOf3lDxx5x8BzoIzaGEa2+cIiaauNJxkka7V2DCK9Y4j+C9g8mPPRrxgSajUtnN3SrhPXmz62+QOYy;20:MWWPJdxsM0BaDdqkObU1vWpX7etcQ6Vy3Jw5rs/mOw8/70G1NBeLKOZOiOdTptVjLvYUWqYYCCrNBjy6AVyZ8OvkNkoplBw8qKv8QngZAlufvkvdgldzeVjF4sxIuyw/MIPIno/WXPJx469pTmNV//dYcvi5eMfNEUZr+1Brcjn75jQXw/iCIcW5TvgN6rXQFj/B5PGQObAzjRjual1+FF6jOP/E5EJAH/3JD3cZX69V1ptExovZTWEGzwlTSmgL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:50:03.2820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a68188d8-3c39-41b1-0f64-08d591b80e7e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the common fields of the Cache, TLB, and Bus check structures.The
fields of these three check types are the same except for a few more
fields in the Bus check structure. The remaining Bus check structure
fields will be decoded in a following patch.

Based on UEFI 2.7,
Table 254. IA32/X64 Cache Check Structure
Table 255. IA32/X64 TLB Check Structure
Table 256. IA32/X64 Bus Check Structure

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-6-Yazen.Ghannam@amd.com

v2->v3:
* Fix table numbers in commit message.
* Don't print raw validation bits.

v1->v2:
* Add parantheses around "check" expression in macro.
* Change use of enum type to u8.
* Fix indentation on multi-line statements.

 drivers/firmware/efi/cper-x86.c | 99 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 57fbea5b3a8c..260e4bf7773c 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -32,6 +32,25 @@
 #define INFO_VALID_RESPONDER_ID		BIT_ULL(3)
 #define INFO_VALID_IP			BIT_ULL(4)
 
+#define CHECK_VALID_TRANS_TYPE		BIT_ULL(0)
+#define CHECK_VALID_OPERATION		BIT_ULL(1)
+#define CHECK_VALID_LEVEL		BIT_ULL(2)
+#define CHECK_VALID_PCC			BIT_ULL(3)
+#define CHECK_VALID_UNCORRECTED		BIT_ULL(4)
+#define CHECK_VALID_PRECISE_IP		BIT_ULL(5)
+#define CHECK_VALID_RESTARTABLE_IP	BIT_ULL(6)
+#define CHECK_VALID_OVERFLOW		BIT_ULL(7)
+
+#define CHECK_VALID_BITS(check)		(((check) & GENMASK_ULL(15, 0)))
+#define CHECK_TRANS_TYPE(check)		(((check) & GENMASK_ULL(17, 16)) >> 16)
+#define CHECK_OPERATION(check)		(((check) & GENMASK_ULL(21, 18)) >> 18)
+#define CHECK_LEVEL(check)		(((check) & GENMASK_ULL(24, 22)) >> 22)
+#define CHECK_PCC			BIT_ULL(25)
+#define CHECK_UNCORRECTED		BIT_ULL(26)
+#define CHECK_PRECISE_IP		BIT_ULL(27)
+#define CHECK_RESTARTABLE_IP		BIT_ULL(28)
+#define CHECK_OVERFLOW			BIT_ULL(29)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -54,11 +73,81 @@ static enum err_types cper_get_err_type(const guid_t *err_type)
 		return N_ERR_TYPES;
 }
 
+static const char * const ia_check_trans_type_strs[] = {
+	"Instruction",
+	"Data Access",
+	"Generic",
+};
+
+static const char * const ia_check_op_strs[] = {
+	"generic error",
+	"generic read",
+	"generic write",
+	"data read",
+	"data write",
+	"instruction fetch",
+	"prefetch",
+	"eviction",
+	"snoop",
+};
+
+static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
+{
+	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
+}
+
+static void print_err_info(const char *pfx, u8 err_type, u64 check)
+{
+	u16 validation_bits = CHECK_VALID_BITS(check);
+
+	if (err_type == ERR_TYPE_MS)
+		return;
+
+	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
+		u8 trans_type = CHECK_TRANS_TYPE(check);
+
+		printk("%sTransaction Type: %u, %s\n", pfx, trans_type,
+		       trans_type < ARRAY_SIZE(ia_check_trans_type_strs) ?
+		       ia_check_trans_type_strs[trans_type] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_OPERATION) {
+		u8 op = CHECK_OPERATION(check);
+
+		/*
+		 * CACHE has more operation types than TLB or BUS, though the
+		 * name and the order are the same.
+		 */
+		u8 max_ops = (err_type == ERR_TYPE_CACHE) ? 9 : 7;
+
+		printk("%sOperation: %u, %s\n", pfx, op,
+		       op < max_ops ? ia_check_op_strs[op] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_LEVEL)
+		printk("%sLevel: %llu\n", pfx, CHECK_LEVEL(check));
+
+	if (validation_bits & CHECK_VALID_PCC)
+		print_bool("Processor Context Corrupt", pfx, check, CHECK_PCC);
+
+	if (validation_bits & CHECK_VALID_UNCORRECTED)
+		print_bool("Uncorrected", pfx, check, CHECK_UNCORRECTED);
+
+	if (validation_bits & CHECK_VALID_PRECISE_IP)
+		print_bool("Precise IP", pfx, check, CHECK_PRECISE_IP);
+
+	if (validation_bits & CHECK_VALID_RESTARTABLE_IP)
+		print_bool("Restartable IP", pfx, check, CHECK_RESTARTABLE_IP);
+
+	if (validation_bits & CHECK_VALID_OVERFLOW)
+		print_bool("Overflow", pfx, check, CHECK_OVERFLOW);
+}
+
 void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
-	char newpfx[64];
+	char newpfx[64], infopfx[64];
 	u8 err_type;
 
 	if (proc->validation_bits & VALID_LAPIC_ID)
@@ -89,6 +178,14 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
 			printk("%sCheck Information: 0x%016llx\n", newpfx,
 			       err_info->check_info);
+
+			if (err_type < N_ERR_TYPES) {
+				snprintf(infopfx, sizeof(infopfx), "%s%s",
+					 newpfx, INDENT_SP);
+
+				print_err_info(infopfx, err_type,
+					       err_info->check_info);
+			}
 		}
 
 		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
-- 
2.14.1
