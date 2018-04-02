Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbeDBPJW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:09:22 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752531AbeDBPHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:24 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
Date: Mon,  2 Apr 2018 10:06:53 -0500
Message-Id: <20180402150656.101022-6-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74c97b28-7aa3-4b06-a9db-08d598ab6be4
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:+0gWWKEGR8QWwM/CUAU5OuDxRvi2vR6gDknRzL5eXyNUB2y1E9b8DGiFERPfoMgRMXVB0drCFDZjH41BcpEiTkmRHNAZLpujrSGqLzg8B96ckd0mRBv+6X82X3skYaoD2maFKh63aN2EyOLpc54HDaOX3sByicopKbyyWUayIOBgg8aVpMMyiZEqpZyz1Rme/R/GZKcEwaGtgJD11kNTTidBqaeAzf7m86kt6Z82Pwskk4HbNF9NomO329IQcoad;25:EFN/au4Zrfh9AwV9mHfISx3rodRCRnQjCyVolXnoPZcmobR1oPl5ZnQ7hdIuPs+R9t7nhYpEJIKN0ePlzycAVaUJkWkuYdhnpjQ/1slrpyVxJGaFgRqpKedkxYSd2ppn9NVdcqo6FtPuelgYd1Vwpd6l2i5e1SBMelVMWKdbOYnJd8/5m0OA7NgAkVLxG1ZfdEKl+GnE3EXKyavUMCORRMy9I1SjfQ+4Zp+yZIrPzxQYHxKTCHTl+7O8kyWQHruqlyF2oYOub5s3Qulkgkh4w4xtuY+Sj1/BF+yxGuoVEP7UCGvHf6dm/x498zhlT7x8DdCCY5ygDLQjzjhErKIHYg==;31:En0nFT9orQcIiRE00f+UFbRf5uzBeKi8oExa+xqQa2FR+fIRcIpHzQe0ydG1WObnjO3yezZ0DfaCGCYc/mnHBASY+GyKpSjFIYrJ4jURvpqLaYlJ+b45dPpA7nKMv+7PbJPnD2H2RtG/uKujFHXmT1GGvspuclhM6QiUIhpdnQG+ujH8lVmLYhzI+H+OweCkD3e0oNhQWgSFxAJO+Atbh8ECesgLCwJ/quS/GwDSg8s=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:Y+hVAix+oCH0VmiFUAl68f9gh4zMsD4angc1yO+z9w6PfKa8O7J+uGUibgZNgKxOb2KuJHfeSPiJu3k2kgUCbAuDmITq27iIOvTlZp5cRFqGTblGaWY+6RPpFgIMoPoaAbplei9byFAliMjxWZ1wgYOHodoF4uk0wDdSN4YzhVZS73XhgT4sG7QprYDgfsyuDsnERBBHftATrtiZ641Sw5Opot5sTShcVFetF4tSKoV4GDtPzdHrN8JAXaaY0XGMy5e5Mlmevi6R/FHPpzUQp02ISLFbWDoPQLvixBXcQFO8Gzx50DPbBoY6gVk7LkNQfLi+FwreExWh+8WgGLRZB/3jHbkRKFsn9Z5q9VXEDaKvJvtTcd6ZX9mEwChxqQGOlazSXcyUVYDqIeEK+md5qDoAEo4aPYFdbXoB1HX6hRUxVS5J6xIwafwkhZY4yMb5q+ieJrkDkwUNc2aH9oRhemztAGgPqDR680LOOOvDnhcql3nxoJL/NGytGOMAyTvN;4:VTo8aJ8wgBmwPhYCnxjyYWwpMUqzhbOE+l2QbZnFOzX27Nepy0vJcMRuLWaTBt5AfsF6cIJjVh8EWDqkllEHvvQWnk5ZTXyTUuQ/D/hwjAeAz5NrGNBBixHdlmooH4eEve8uEvsZlMfGBM+70fsr7MMycLbMcJTmEJyY3fKb1sG22S+a8GMeP0dobyr7mG13AlaRy7KVziRIZuEO9Y2ZR3WRBxPI1ZHPlit2YbZo0vy2GmEzaC2g7nNUcbFJ6I2BuswNphSna9g0OWsbZ4VM/z71mOwpxZ4+BCKq5NVrkF9AFRZthA+dihjAr1LR+cGXgYpH/r0uZEXFbTmbNdR6AXxaEjOitdBe9tqcd3X7mMM=
X-Microsoft-Antispam-PRVS: <BN6PR12MB19052FC08107F1B25E698860F8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(59450400001)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:TF8MutO6y3BvwfJRC2WCLD+md/O3N02l+QhvrLXOX?=
 =?us-ascii?Q?W/0lBwHvVZ6KoeEeOgA4o8yYR0i4YwuvwPX1cPdQUTI/mIW2fVF3c0+YtK9F?=
 =?us-ascii?Q?HtVjjl+DimSDEDVrceWPJJYxwhkv7FwU8RkU6RwoSbORKUED2JGNJB/iroF3?=
 =?us-ascii?Q?QVO/TgY+gX36CSojz9pn6mLKVMVqG7oIjcmAv/nSv9V6KilZnU9IFq3vzuEB?=
 =?us-ascii?Q?H925XMD5KRk3RqZ324mUb491CSe8iv1KiAjlO5OHI/Fxr+SM7zCBbXzMYFI9?=
 =?us-ascii?Q?TaSZ8BL7XbweZamk5GMlyvYKs/F3AvnSMcgumZDRBYJW5YqpaKOJKdjxOKY+?=
 =?us-ascii?Q?6b/gkxASmMmUs0vN1DMd/FUoJJMckm32GSKujwlmEfHP+78NrRzd1966GU73?=
 =?us-ascii?Q?+sgN2TOiwLxWa3bWBFRWc5ESsHjwRDie2ZjC6mQ6VsXc70F+LAX4VJbzUudc?=
 =?us-ascii?Q?opeQkLDALirbtbMxtTQjOPTubsEwoTTtamhrQI6qhtNc58J5/ts/ri3YbNcE?=
 =?us-ascii?Q?dsv3pnckJ4vdk3g8ZjVry7Ti8t35ogSkDsM/0ajmW0JqZG303FcoXLLF/H/H?=
 =?us-ascii?Q?sCxDkQPRMXroSXOWI9bVVmsPcUp2c76vPolxS6O0MrzmL9k8pFlsFbsJaOoP?=
 =?us-ascii?Q?rRbswPrra5uwgEH3sYNNWRB5bM0at28YjHVR3+35J6FEMAZVvXiP1lJEv+bn?=
 =?us-ascii?Q?IyQWe13yHDPyThuZFEh9xVzXiz2uGtNeb3ZZZ0QAUrAtO0YwEEvuZi1JFJ3j?=
 =?us-ascii?Q?bcpg1c8TWzJL2TRB4dSn/ZT415QYwYCZWdAp85AwPXCZEacaPNbF/1y+xu1a?=
 =?us-ascii?Q?Tmbqb+JFiHNWYRHnxbHyaOxnjGYkcJ4OeL7o5cwz4ozOYi6OJ2XVJ4XICAHt?=
 =?us-ascii?Q?3url1rQPATRkNYbAvgyuDw6j5Z+Zshpl6qFBNTGD2d3JQmwEtkySxt38tmcZ?=
 =?us-ascii?Q?N2+lNjeQidIfVpNc8m5sxjq4YOORlzJPMYRmIatFSI24/51myyVqgVclgCUx?=
 =?us-ascii?Q?g2E3hF7IbGf+awEM0bQw0Y0FzbMZne+THza0TD11b9mJBMaHg/QsbBD5ldFW?=
 =?us-ascii?Q?POVWeSJxId48PUlwnXCeKML6DRRFE37bOMe8mUC7DgDr6CwJpfOWXct608TS?=
 =?us-ascii?Q?Y1sq++kSyF8YKBJsO2YeG9dY89dtzSU2Bv2RhJFWEZBJgg1mb3KeNkYBsYC/?=
 =?us-ascii?Q?B0Adqx9kyv0it/2kHW7R7rAUMpETEhaS1lJqWDm4oEEn8eTR0Ih9RduLDc8W?=
 =?us-ascii?Q?NbUCO/lLaPA64Qo+N6KuK+wLlRAkIALOshVkzrfDR7C+Bcrromqg0pQ1zitk?=
 =?us-ascii?Q?QUsmmDrdzwFu8dpT0COL6qoOGbQBFVQAZ8cv6Mh3O0g?=
X-Microsoft-Antispam-Message-Info: N5BY1m6jgzfkP4r8sLvu9dd+Z9r0rdgYvuakPp7FFxLACgBsad1+surUJyvXGfzLiirfNJvB9/XVFQROQWzFS6I3G5HDC3Qoq92r7I0Ust4gIEzxFKpg7kN6M86QQgle0r5l2fJNBB9IpiWhhj514kGl+oZcnZHg2geZ2rhc26MJ9bUdf67x1VorPnOjURv5
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:sWMSgnlkGV0M7jp/zakjfrfVFlH0I2vz2VzwaEEyxuLv1HR0Tpg1MFsDSS0IGsZqlCKuh5IwUJgQaQVZOJToXKEAZxGuKNSmEa2A4MBkpCDjgU0eJYz6PRKK6D9/OoTgY6jq5eGrUcpP37wbed+93i5HMQdEUxTgfSLydgvQh435IFQ5cKs8ryGO9L3U/CJbf7AF1QzHS9SLjDRdZxki93wsHkYV6murJbM6DOnZjFr8B6e5igShO0pkz0ppQkYSCrZqWLidmc5f0va8BSbhPuNQys0XGdIkmKXdCF0Wv0lT+0Qo8pEMCCqt0PLI5x+1xS14N/uSH/o2ZlNC93cA6AuDozzHNVbDXA2IlByQEz+s0S2UWryQW3A5khATu+8CPAncsY3eBtUhvITcB90cnivVj/c+G0Sba1EvrQZO25baP7FwN705PYEPVRx+LNFQu7lhzQWqrfJUW2SNlEVluA==;5:zmY0VH2wBqGs/8peWilTiiepe9+5Ls7r+2XNRaIPnpc7a6SbFpSmjpfQ85AG8c6hj6r8jw+TLseA6Gfzo53ckEKI20vdnE+b7ikR3cZ3USdwu81bcSkKjq18ZPsomknr0jeZEBZqzNIsjR+PmakKXZeMWeowi8yOZ/7WAddDzUM=;24:zj4yhtx0u7vzXPcq7hCk7njUEQD4yLoXxfkSlrgSrMYP/KyLXd9r4HxCJ01Xql4Nkd9mSuAQgEqNiD3D86AN9yrTzWP+kJDDxjbyICQPMUY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:PIvzw/pAV6u9FhCApeBrsYG8N9SoktWPL4yVVrZoPUcuQGt6nAFWERjnxiGl58u54QeNvn42M+QCmAYmbG84PnDYNGj+7Gqu+q8RER5SRdddw8w/zHB/vk2wUfNtenXX6KYpn0LW3O1k7husD+WeUALhgqp1/cMFoaU+hO8jK46mjt3ZCPpUPjHAVRaOVA73qBfaZI2mEBUfxv5XMmqHNi45cSvAL96z3EpYT5elI1W0MSL9E9JqC25S3k04xc1O;20:S1iYgnSeEIskTRtElWYJzf/LPzWWvYXuImMUHEZjGX701Uv2Ht5iScBzNE/UYx3kdOwbLve0gZvMa9FnHSL62Ro87WD1nMqs8KvXLsR14u8FAVt4eJoiprYlu2FVkqZ6Srv5unJg38zVUU0+8WLN3aqSQeImxInw7OuyYgnXfaqd7HzXMFWME2H4X3svE1dFwcq0uOXfNbKP0F9wbX4Lhy1MRLKrx80TELC4lHUdP1LhjsM48phEs5rX+4ADdnpb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:15.5687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c97b28-7aa3-4b06-a9db-08d598ab6be4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
https://lkml.kernel.org/r/20180324184940.19762-6-Yazen.Ghannam@amd.com

v3->v4:
* Drop INDENT_SP use.

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
index 5438097b93ac..f70c46f7a4db 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -30,6 +30,25 @@
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
@@ -52,11 +71,81 @@ static enum err_types cper_get_err_type(const guid_t *err_type)
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
@@ -87,6 +176,14 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 		if (err_info->validation_bits & INFO_VALID_CHECK_INFO) {
 			printk("%sCheck Information: 0x%016llx\n", newpfx,
 			       err_info->check_info);
+
+			if (err_type < N_ERR_TYPES) {
+				snprintf(infopfx, sizeof(infopfx), "%s ",
+					 newpfx);
+
+				print_err_info(infopfx, err_type,
+					       err_info->check_info);
+			}
 		}
 
 		if (err_info->validation_bits & INFO_VALID_TARGET_ID) {
-- 
2.14.1
