Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933544AbeBWUEF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:04:05 -0500
Received: from mail-by2nam03on0043.outbound.protection.outlook.com ([104.47.42.43]:12992
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933271AbeBWUD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:03:59 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 5/8] efi: Decode IA32/X64 Cache, TLB, and Bus Check structures
Date: Fri, 23 Feb 2018 14:03:30 -0600
Message-Id: <20180223200333.6410-6-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
References: <20180223200333.6410-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR04CA0033.namprd04.prod.outlook.com (10.172.163.19) To
 BN6PR12MB1906.namprd12.prod.outlook.com (10.175.102.12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 58273bb6-7f2d-4e66-825c-08d57af89278
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:Y8AfGjjBcdZEHATK5UDA1X3aFzoPzJ5q+X5nKE/DfmMVStoSbid9bbeerddojidIPKyL5IvmMLuyvoUM1Ka68I6hXjxIYATK3i424WD2Dvl9yFQ1qRbCf+JecZkfYwo7sdzNF/7iFt4gxwjhtdmjTnArVAklyLJ6c54tnO9cI1sflH+ECAiMLsc+0F3aEYrnzZiQHAJ0x2TSmhl/ZgAcQtxX5K/OWFiLZ9+tEqJGw1z5DtYYdu0wyZgZNNOeef6d;25:nWEp0rec5tNiszXazs56U6Kx6TMNq3aID4kT85+Kgy2dXBISKTLIv7wjyJmZjkkplaqeyVjpzGFQYOR+mUcnsP5RSxJq8LFsJC38JCgc1WoX6Ng01TcMzT7Lh2n5j6xfA17LiP2wjNVzxr+sxqnC2G3rq5PkBfHQZ8To73Zcfb9nU3XCYeESsjgevFrov65SLmcfJi2XZoR2i+a1k2p1996tg+ajJveHZCygsgnkP5O+4ZmtorwHyOAhvJtq+83MZYa0D+oijyQzNPB51VHKjAdIONAWgjHkV5Vu6m+iw8nxILjyvglF1X3GHtwvnH0SMOB1WnvFIu9flCqdn8XaeQ==;31:rT/LzeGOs3lpr2Zpjdc9ymEGrDx/SLYbu4B4UdHQLu/yduf/V/KL3+xRLGYUdce23B3HaJnHkiOvT2WttakogqUVwAaxKMWMg/VZh3AT9oJ4YSbLWDMhkoejEuY8VX5XbqBPOatURkCm8yf8q/U7KssNznIchvdDmTt8jGARp3kHLGYDSCnRjk0YR2Jhh4iSA4R9hkdekypxIUQtTPlLKrsxcHpEloA1IDcwSwZE/1M=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:Qlfr38KCT0K5jUK6NjsYZh3kg2Lde/EjaP/RKub3H5ZNpX9wE+abbDW445RXfImAni0WxqG2FbX3j4NqMXOk6pzDDQqgg1b2L+33W8S8vxK5je6B29IBVJopWq8jwIF9D7HBGKNMEp9yLTxDL2wckPEobR2B2HzN5dMLoLm4UcxdkVUnntqoH5CeUUUub/ehCEoufZ6V8cGohG7hKdqNPRU4aMYcEdc7qSpD1wAY+ptUg4/c31euUv9ObWx8T+oE3JuPsTnWj2II/j8IDl6Uo0KgpY4BD9ydjhHuSn/t542rpBI2viqloM3bGRWHP4gIv0IBaiBqVtJ/ddsXLSzt9m4RD+/7vj6DyWngcoEHIDmtbNCm0RudbPoEa0LxHR6W58Oa4O1XJpEQ2cXA8bQsv6NIH+zZ0gbFIqCQkNktm0FhMMprWew7zOSKDRC0Oof6zrsj5dURUdhKxSWPAGguRPZdxnjTr2iqbIaVMAhy4oRjfTeHOyqZLWPed1QqRPNS;4:Q2OKZHD70FN1Y1GfcvkIf/3UgQC+qDpSZVT/ll0I+686SnWAAzyNQeysqXEi49tEhRVobIt/pkwVeff1SEreIpvbF8chhimC0/Oi85cM2xNG0joEb4xVZleETYEOUxswZcuL97nYoPLUlmN6OX9kKqbmiuTEtdwBgBD3r3P2xAcWEaq5A68ktv4WZYZm/FdEYmHsJNRP3wi20uA3Xz4zIWSNq6Pf2kxD4JLzOb7g64ZG3Svm61rgqCmYTeGGYMySquV4BAFy8OlyAf8WbBEPFgacs0F3fsH6piLpgDYmzfKGaq8nXyVa1Ya58z81SXJKAjrxgn3dNynlgmPNIXsR9g==
X-Microsoft-Antispam-PRVS: <BN6PR12MB190647E87770F5D1E98F9AE1F8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(53936002)(59450400001)(50466002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:l9XZMuNfcV9OHNWdoqw8dCTL/PZof7iY4ifUi+toT?=
 =?us-ascii?Q?kvpEBcsraAzhDlOPzxQEx5+nFIqkIvy1+Y6cRIYlHjQl3aRmP9AnZHPlMcfA?=
 =?us-ascii?Q?h+U6oijy6wIJsAIgj29/T6OlklzcJoaUEEQexsy24FNjXqNa4xNGrv3I8uYn?=
 =?us-ascii?Q?B46VvgaytXhbF+R4e7v0u57PDFuLsT/xn0yNuMP+Ov0HvT1Ht7gVCXp+YUwp?=
 =?us-ascii?Q?aKFSpVjDoq7Qw8fwReyiI3Mbw99NHig857InLag/aJvCGq2tiHzN3AigQm7i?=
 =?us-ascii?Q?WiZaMjkD5C50w41agVonlGXqblSbI6hOqBiRh4epbv8V2giMLQV8YZdtK3Oq?=
 =?us-ascii?Q?9S4aFOVEMxTACWLvA17x8bP/dwnc/ttU4nTBU6xuR3jKGAjbJ59WLKh6mPHH?=
 =?us-ascii?Q?vdBFlvEBVeMUf6IBm1/pGd6INRKOVhkN63D9J/IAZrb1Dkbdj9t6d+mzx1CS?=
 =?us-ascii?Q?OJsVRg/EsksCT+RQg1c/ra3Dg6ucHVGTPJEo12qcv0GYHRGVwZUgZnJK7A69?=
 =?us-ascii?Q?e3qIa+6hYrfjGpm2JBPgJewQIIlcpi4jZ4UCwxulmIfGZ6cJUe4VyJ2XtTL0?=
 =?us-ascii?Q?PE0JmxWFWAXp5VRFxtUX8vY3YkEZ1IyXL+jwlxPimTbs95PbblyM48ahih8h?=
 =?us-ascii?Q?U6MJRg7GKXAyFNWx8tjkg3LJFoX9XXJX/FkVdh7Becnsy43KJ9d/QM0Nze63?=
 =?us-ascii?Q?bAfiWEkCWpXlfbwbdiQW9nLljlpsDVatiBdW6u/Nxjl++HW8wCDKqJUYvf5X?=
 =?us-ascii?Q?DVKKVhs0dhUDh37gSGPkvJx0zFFknXFdNpH5CZPvmg1/E/pxyaJIZKryzPzI?=
 =?us-ascii?Q?bvrcix44BTSEgKAFDqKwRXC0sq/09pmKS9+Dh68l9kGJrVQDK9bQ9yku7tDD?=
 =?us-ascii?Q?UxPW3dmpjMDlWxLqjNtV2SukjeUNssz2hY6J/zPv5E7GNK3tdZEmc5ft/als?=
 =?us-ascii?Q?jWZa19Qa5RgHGy8SVQUMb6PNkIk1eba6UnHQvjOpN9yfDe1rTPa1vJ9SJ5J6?=
 =?us-ascii?Q?K1QRDSb0ZFKKCFWgwZVFxJr56cw6NlwalcYMFpYqTEz5Q1xuztUC4BtrAMQ/?=
 =?us-ascii?Q?CJhCnO5PmVNdNfi725a/vnBtTWqp1wcdVERhlY5VN8TO6pMAGoFF7/MFVw8+?=
 =?us-ascii?Q?hBqydJhXhmcOwc/2d1rxaW1MCKlOghGR4tZHWITfrmDbGg75SZnnymoYA0yd?=
 =?us-ascii?Q?cpMSS6ydoKag9u4Io0aaitrd/GtHvJp7SGV?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:fo4AJYSob/E49ia1vUOP1OFpymiiM2oEyJfVtvRRN33dxOL6y48sxQNTBFnYUzASt3srEMD3LjVcw5+huMsDgI2z3QceO2CzPfmRva2h5Ni25obP2zhdDq+nX3UGSmLg0Qg0rq8wUNupmpuZ4atp/c6zi+LoBVuQ/80mNnGTZ5ZzpRueP46+3pE+KrhprA9jhiuY+MWXiVdWu7Bc92sdjZ6vHUJA8M3bhZLmqaHLJ7ZYi6Sm7c4zkYeouznZbzxGvEiRniWA//deCj3cx/Qw2fPlWXsxDtX41WzJLBTyYl7DWQ1QmRl4tJWrRG1nF1ASDTD6G8RRWaaOvsOLZ2OWB3oN/YNRW7T1ip49G74EY2k=;5:1Vhak/r4GO9/AwWNdspQL3ixgtvZS2p8StRpi/atyGaQXWfwsO353rlorKKgeCBAHwufkGnOkOPBL24X0GYZJLeqd1XXLEM2u97XhMafoUqeG+3pAAMMp5Sh0pIR0p9ResU34Ouo4Pt1ukSHz+xwP+DxpRe2lDhLpQJVsIxmZ/I=;24:x0an0J71a1BycLb5reiJTIEHMNDQ0yH2LhpH6074Jr3QvaC4mK9RkE8rAaKCoSPscty6XLtBXxYzMbxTMjCxdFHfNWJeTyL7vGectvrkLaU=;7:pwz91STJ8aVv16rNQYs4CNVlr2g2O87yD+bELIz3KnL7FLkLhFepuT7wL0eDZaS7P1LCrA4gOKc39CfSAU542t1N4KpZgCi4X+WN2qMqVFGRAJOGHZU6x2ULFoa9duLXFRowC6fBJITZSNzwpIubHRuBx/6kH0MHOIjyP6uDN57sY/aASqnRzcAagMBKHzFSWmy9wbNNrjjp4lzUJ6tsssNtwRwZ9nNo/LUC3zymTHeWYg8YqBKj2qNVKSTB0eys
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:iYw0QFGgAMJq7OpwtiAWyK3vV4H2l1er+/IGPnf2we2zMAjYD8rTLDfk1ibavTurtrDBjL1moTQd3Mwe2gw+3StxPVPr5yuyQ+jdD7CUosTELsYaMbBEbrA8EiYeUGE2kUU/weJdRHwzvNHHpLIA22oxptSRjXELwV3fTT21umUy1idZb8h5XbCQBM1AuXqIoGn7pDkxlXHcYYsodoLYWxNwVeRav5JzJln+ne/DZDRdtPy6PHE8OjNQfdDp3sFz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:55.7673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58273bb6-7f2d-4e66-825c-08d57af89278
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the common fields of the Cache, TLB, and Bus check structures.The
fields of these three check types are the same except for a few more
fields in the Bus check structure. The remaining Bus check structure
fields will be decoded in a following patch.

Based on UEFI 2.7,
Table 257. IA32/X64 Cache Check Structure
Table 258. IA32/X64 TLB Check Structure
Table 259. IA32/X64 Bus Check Structure

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/cper-x86.c | 101 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 100 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 3b86223bdb67..75f664043076 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -33,6 +33,25 @@
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
+#define CHECK_VALID_BITS(check)		((check & GENMASK_ULL(15, 0)))
+#define CHECK_TRANS_TYPE(check)		((check & GENMASK_ULL(17, 16)) >> 16)
+#define CHECK_OPERATION(check)		((check & GENMASK_ULL(21, 18)) >> 18)
+#define CHECK_LEVEL(check)		((check & GENMASK_ULL(24, 22)) >> 22)
+#define CHECK_PCC			BIT_ULL(25)
+#define CHECK_UNCORRECTED		BIT_ULL(26)
+#define CHECK_PRECISE_IP		BIT_ULL(27)
+#define CHECK_RESTARTABLE_IP		BIT_ULL(28)
+#define CHECK_OVERFLOW			BIT_ULL(29)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -55,11 +74,83 @@ static enum err_types cper_get_err_type(const guid_t *err_type)
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
+static void print_err_info(const char *pfx, enum err_types err_type, u64 check)
+{
+	u16 validation_bits = CHECK_VALID_BITS(check);
+
+	printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
+
+	if (err_type == ERR_TYPE_MS)
+		return;
+
+	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
+		u8 trans_type = CHECK_TRANS_TYPE(check);
+
+		printk("%sTransaction Type: %u, %s\n", pfx, trans_type,
+			 trans_type < ARRAY_SIZE(ia_check_trans_type_strs) ?
+			 ia_check_trans_type_strs[trans_type] : "unknown");
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
+			 op < max_ops ? ia_check_op_strs[op] : "unknown");
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
 	enum err_types err_type;
 
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
@@ -93,6 +184,14 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
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
