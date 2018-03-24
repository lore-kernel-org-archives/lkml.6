Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752884AbeCXSuj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 14:50:39 -0400
Received: from mail-bn3nam01on0083.outbound.protection.outlook.com ([104.47.33.83]:57948
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752819AbeCXSuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 14:50:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, x86@kernel.org, bp@suse.de,
        tony.luck@intel.com
Subject: [PATCH v3 8/8] efi: Decode IA32/X64 Context Info structure
Date: Sat, 24 Mar 2018 13:49:40 -0500
Message-Id: <20180324184940.19762-9-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 30f8cc59-a477-44ed-3a23-08d591b81155
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1919;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;3:cVq2swmvmGYpjhYZ0++F3dO+hNqW2RDNileB/UvjpkVpv9mqgx7FpId+Gp9OzYfvkXAm72vH0zvNvM2Zd3Uk/lZZXHntLt6y470hbTdXtyu7lz/q/mfn+xOQRK174DDcOC7kApfyKM4WSEcZ+rFTJlLqsZyQSF+4DmLfz+Z7PIGVCSbCHomIjZqNqdV08TWSH1fx6res2ZifPOVhCIjgje5qvuoJAzPmydidPL5LWkIP2WF1y7Ph41NcPholeBvg;25:OxrUJ4Tpkh2VbVE8LAftlIvCjOIO3HtrM+o88UpUuvfAq1PLJ9/3MB2eZJP0/Il6YixQpNDv/APu+AdtAtbDEZ4xcnHl8hM2TtCM+7GCwZckRgjJwMimjHKsOtd4s4yzPaT7X7DrjRG5KR6Sz6HkVoGZXJpszqE4wQ5gB+xJ13jQaLWJ4qdPM1Fgr/ybo7aBT6wW1cVXjnQ3MOT2gAVOcyckLvQs6la/i4okvoEG2Q9hGlofaUME1skRMqvMYmLUN4JgQDa4VV+YrfVp7JEM0Fc53RN0U4RyvZ8rUavvwd2R2nuKk6xssYgRq2Y1KEA9wGnbAuys6G0OnVArlo9muQ==;31:LbHeyNCR6C/K1qiC6Ir3y4YHs3P6VplpSOa1KgL8oTkHliFdtLgIEwanhZhWgNb7u8RPQuS8adtlM1svX9rTUL3ZyRRRi1BHt5+ZpyNdIto4gZD/8RfthGCv0IIzjBEJwkeEhFSxsavHR270Yyqc7XoNNLpwQ2Bwqwc4tD6ba3S5dBOpiQxiosWjqUdSIS5q8NbwtJsFrHgWtRI+Yveb33X9n4YxfboGXdl0VREyNO8=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1919:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;20:GA7tXVWEUha+GJCFu+PweVxtOYdMq3BlZ2j4dTQT2GllefyfiJvvQGtUx9LZVQGNr8Dcy/nlRu0AoaTvOi9L0KsEISBBObbGlISVRo2IfX+dXgXk6cv65nQPMbCw3+6oNNw7jUYrUo3vC4mya5Nlob+tBqCEAzqBSAh3VgbSe7MQU+vRI9CS/9Z8XVKKr17FEFv9WR4xoz8JkKVG0IyCDw2nwX+YlB8fPRzcZXFGe1wgulsWML9aKg5nkVO46RkAdEzDFjwq4bbUt4j1z0a0FlKy58HaSCT9iljK6IbLbopNCmupBi/IVqZKCmSBEl4Sv2lQpiXInf0SLpWHA1d+dW0S78tPad/NhhAiw2+u3tbR8B2wHPdeVLl2TwmNnHCU8UQj5EgQHzO/T8By9YXd+EjFyJjY7ieICkF8HVoklzJ6A8t1j8vghaaX6aiWNbnQHhC8IqoNY+hWBmd8JjFP+zBq1Td6V1nDz2RXeSS9+g+ZLMGdvC0m1Fae9GVzJ8Av;4:AvGT7j2I/ZJ1b4MjZlagsfENTjf1xGi3eyi/hPEsGPl7S1kK9HkNFrMlHSx94xsSykjTa27JheYm1VMSlms8yhnLCK9odAsR+dVtb+5+UyVsB8y5l62Ub1a7FaZvdVNE30b3Gb8DLgdsHh++BMX5XEho9lkiAcczZ0dkI/QJUapFTI5UL6w6AGx303QUl9fwmLpc5sXFuAU/X/4D1e3Li8tcjpf30vvIoHlYTcMZMrcdT/PqQFe93yIWyKWPG6Crmk6G/y75mdGBJd6Wv6dqmwzP2y0uE0sx91X4jQ1sgzKd4CcrF7sGXJdjRP/fuBoJDAUjrcP+qJ4ZuOD+sKZSNStGhPlyJT6i//hB115wVAI=
X-Microsoft-Antispam-PRVS: <MWHPR12MB1919E59AB25058CBC6B8FAD3F8AF0@MWHPR12MB1919.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1919;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1919;
X-Forefront-PRVS: 0621E7E436
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(346002)(366004)(39380400002)(199004)(189003)(2351001)(2906002)(66066001)(36756003)(52116002)(316002)(4326008)(51416003)(25786009)(7696005)(53416004)(97736004)(5660300001)(106356001)(16586007)(76176011)(68736007)(11346002)(2616005)(386003)(956004)(7736002)(86362001)(47776003)(305945005)(446003)(966005)(186003)(2361001)(48376002)(72206003)(53936002)(1076002)(6116002)(6306002)(3846002)(16526019)(26005)(6486002)(50466002)(105586002)(81156014)(6916009)(8676002)(478600001)(50226002)(8936002)(81166006)(6666003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1919;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1919;23:40QM+Nlx5g3qn4Wd67HUc5EGDf3NptmbunuvblzDT?=
 =?us-ascii?Q?ZNwZTARj/JvOFTfRmJs8vbP6DY470sdY/UC/ndCYEDPmODHmhUV7xSSJtusx?=
 =?us-ascii?Q?xDVQvL4H8mi6dYXizRUAHecJyf5mPf4/0i5G7JQP2kNZIygOxnIpqXIFKPMA?=
 =?us-ascii?Q?gXm+qRuimiX1+T7XEPEbdJDtAUPkZuOIUwFvtuMb4DMJ+6GyTWv9Iyek6wpd?=
 =?us-ascii?Q?LaPXzZQWWX1JK2ij6xbc7LTwocKuTGOp4AriWKgoeBVBWGHsSYMbLCUghBfs?=
 =?us-ascii?Q?+V2x1X3hrPaCP0WBoNxax1ux8rdq87J6jV5SXgTH/aeM12Cm7SPZzltxaYdQ?=
 =?us-ascii?Q?eWn8pbldDnq3uWDhTI8viEOTOJSrMBffmGhrm/3MUvJXxpr3CNURtjcDowww?=
 =?us-ascii?Q?OnYrtQqrn7qlabVoqr2mlKDIp+xpE7OUaqFQmWneUp6ymWj0bhaK+V8luSTx?=
 =?us-ascii?Q?nX/cuNZkhMrlgmJ1nk34flPY9LVWyHeST6ZkkTgvuFlLxEH0GQ1qD68djlaB?=
 =?us-ascii?Q?N9YyvJSezXam6TP8V7ERqJEW9N14PSGcHtaSUPg4REYN5od0Dwq0Kdl/FzEI?=
 =?us-ascii?Q?mec4GanbuO/JLWzq9v6Enbn5iAY211/Kqka7W9ohxp1o3lgM6PohPzvMAK8o?=
 =?us-ascii?Q?cBSALuSY8XGjydOzEPfuqNv93+qZ0km4uctWHHleLKtSqYGA5T2MNdk7ttiG?=
 =?us-ascii?Q?J9oOXVz7M7dmLztrQil6AEqBLEWEXbBlRrQ6rytaW+q+WLOr7WJzdUWj6nUx?=
 =?us-ascii?Q?93wrf/+PW9OgpBZkaJPE3rI+aPIuQDtV7bHJmHES2CL/74YyER3Xh3gRWBYm?=
 =?us-ascii?Q?WI+ld0dO5J23OyiTkL8EHPy0o1cs9oTmJgv2AW2LXwVO4gT/5h5hKVSMutKb?=
 =?us-ascii?Q?kbsEZO01nhKjt/RDJQgapOQFMJJF5GR1/zNgV/0gq94hRNl/3Sp36NxhpfWD?=
 =?us-ascii?Q?jFpWS03jS5kX3X8SrLVKQnCbPuHzZhotE/bipBehDM3XIkZUHBtns3IQ+TQW?=
 =?us-ascii?Q?xF0RUl1r8Sm1pJKV1K7Mf3HWtiq2JEoq70l4BXHN8PSgTxdcAWEpYY98acOM?=
 =?us-ascii?Q?byrZM5wUy/n8AVAChnG4c3w6Pbdgx45z08JMN3/wzhhLi+29+Zu2DPNel+ut?=
 =?us-ascii?Q?CiJI2jzkW3nJUL+uQbTniMfdTmALpafG2Q6ZvpxIbGWVdzp7OKu+azNuJ6Mf?=
 =?us-ascii?Q?iFxWW+MfTxoPnD65MrL4XtBkH+/PW3TmrZLmJDOF0PN564Fqf+Jy3hMGOlD9?=
 =?us-ascii?Q?54x1/trSj8oLk/a8hyjSysjxLEe5VZBEouuUdhI?=
X-Microsoft-Antispam-Message-Info: nEK5zgZa+9tl6IVo44ZXseyrVEfKZmqxzxg2mv0uxk0dZPDEIajNtJrQr3TZT+6MBIaXmD095KIQeNwMUNwaJxQm78g1UfzjKvj70nJ8rZMVBl420rdsGLqJL7qB2UFOmKSRo9pI+HpDlMxD7d2R+temwRAoIFzndo2majwf73t6Zucp3mxSAMcjNiGLsFv+
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;6:UqxxZc8mLz9oh93t8qoEYQG/00QMPbP8j2IGxilt4Phx2cGZ3WsWezp6sVImsB621IdW8UoDuAaR7uHfxzE3LJhm9TGwA4PCnmC2sYTCV0nUw39D8D2AHcSxL1cRAlYTNXbNXTu6Eh+mpKLZDMtor6IWUrwDkm/G45sfJhz/F9RscqyanOiCVwO7bR/yVbxY6ZaEajFFS45NZICzHcxavSCvtAgejuaiA6wpszOMZi+6vDqk660o+8SXMJtbcdjlhrwEqSpZSJrOqGmKl0rMmuWhXWKExeaj7Rw0Dex/J2EH/Rt4gS+95a2dZ672//9FDdmPSVMjm8lCvdVWrW7I82hZ9p5A6BBIxp44anq72jrocy/RO5PxmSdpX1M4VvaMouyNbj5jW8FugIRcy2+rGPu5YDN5KrR6i+2M6r9PNxCuu22dHtTjJD9cwqt4NnZpRRCa0Bu9WxOxgvR9ZaaZ1w==;5:Q+9foNzI5w6XoXGAgMYtfIwn3s0dUiB5u4aVRFI2/KJ6RtEqDTFUw+jnCuIGMD61XYXsf2RZ71E13+o2KT0tKtRpUqV31pYoJ+jLFI94PBlopFpRZts79L4VvuY3QSSNM24MWTIbOS/kWWY+SwWcwhpH6xPtqvOy/IO6RwYhcns=;24:zw6bFUsOLNI85VM/eks7NJXwo2MAOWverkT20PWZhmUCqtQJmeN2zB04sSQjkHOfE0xo6bfqoshdjYD4Pjx4fC1f+1gG+dOiPyIzJ0HDELE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1919;7:0DqnLCRs79lISV4eRVNyqbvT5Au/3M5J2oMTNN0Q2nnuAqpriSqxdQNpzT3yZn7x7/3yLdwOVaY1CDzd+8d3sNeVHCgiCn+6BGKqD+XO0Lhg24c/7orKp4k+1kqsTANgO6cJLbTrAqFudtjQ6CLfYPo30VvLSVNu2PImNQ5Dvn7QhCk3s42rHuHE1JCbMzMZrCicjn6yFCt7iMO99DBxTnIl1s/0UA5tMh9FHODi5COZdYLOVXF0UQPKC5mO1KcR;20:49Gw0NrmeSzG9ZO1Gn9tZ5LjA8xOjiMI9hZyt+q/YFR7JZdO4lHo+E0qa1jyLk7/IIyUoe/Qk7nwR2ZXMGljfo8+FMwqTSes9lzdHbneC+8J+3sjvsVZ964u7LpDroyzVqXYhzHklge/s47ubgZiSmblkmf4pm7AIDfL0lOAqlKHQTdg+Y5nv9AxeO7QP0m9VHa3aOtNJWYlYiWYheeQu04amHBeBHO/j0hlkA7ibDq8X5OstSa+51Fq8Ry+NWSI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2018 18:50:08.2507 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f8cc59-a477-44ed-3a23-08d591b81155
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1919
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the fields of the IA32/X64 Context Information structure.

Print the "Register Array" as raw values. Some context types are defined
in the UEFI spec, so more detailed decoded may be added in the future.

Based on UEFI 2.7 section N.2.4.2.2 IA32/X64 Processor Context
Information Structure.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180226193904.20532-9-Yazen.Ghannam@amd.com

v2->v3:
* No change.

v1->v2:
* Add parantheses around "bits" expression in macro.
* Change VALID_PROC_CNTXT_INFO_NUM to VALID_PROC_CTX_INFO_NUM.
* Fix indentation on multi-line statements.
* Remove conditional to skip unknown context types. The context info
  should be printed even if the type is unknown. This is just like what
  we do for the error information. 

 drivers/firmware/efi/cper-x86.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index ffc01483cac2..fe479cc5a358 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -12,6 +12,7 @@
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
 #define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7, 2)) >> 2)
+#define VALID_PROC_CXT_INFO_NUM(bits)	(((bits) & GENMASK_ULL(13, 8)) >> 8)
 
 #define INFO_ERR_STRUCT_TYPE_CACHE					\
 	GUID_INIT(0xA55701F5, 0xE3EF, 0x43DE, 0xAC, 0x72, 0x24, 0x9B,	\
@@ -73,6 +74,9 @@
 #define CHECK_MS_RESTARTABLE_IP		BIT_ULL(22)
 #define CHECK_MS_OVERFLOW		BIT_ULL(23)
 
+#define CTX_TYPE_MSR			1
+#define CTX_TYPE_MMREG			7
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -136,6 +140,17 @@ static const char * const ia_check_ms_error_type_strs[] = {
 	"Internal Unclassified",
 };
 
+static const char * const ia_reg_ctx_strs[] = {
+	"Unclassified Data",
+	"MSR Registers (Machine Check and other MSRs)",
+	"32-bit Mode Execution Context",
+	"64-bit Mode Execution Context",
+	"FXSAVE Context",
+	"32-bit Mode Debug Registers (DR0-DR7)",
+	"64-bit Mode Debug Registers (DR0-DR7)",
+	"Memory Mapped Registers",
+};
+
 static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
 {
 	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
@@ -244,6 +259,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
+	struct cper_ia_proc_ctx *ctx_info;
 	char newpfx[64], infopfx[64];
 	u8 err_type;
 
@@ -307,4 +323,36 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
 		err_info++;
 	}
+
+	ctx_info = (struct cper_ia_proc_ctx *)err_info;
+	for (i = 0; i < VALID_PROC_CXT_INFO_NUM(proc->validation_bits); i++) {
+		int size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
+		int groupsize = 4;
+
+		printk("%sContext Information Structure %d:\n", pfx, i);
+
+		printk("%sRegister Context Type: %s\n", newpfx,
+		       ctx_info->reg_ctx_type < ARRAY_SIZE(ia_reg_ctx_strs) ?
+		       ia_reg_ctx_strs[ctx_info->reg_ctx_type] : "unknown");
+
+		printk("%sRegister Array Size: 0x%04x\n", newpfx,
+		       ctx_info->reg_arr_size);
+
+		if (ctx_info->reg_ctx_type == CTX_TYPE_MSR) {
+			groupsize = 8; /* MSRs are 8 bytes wide. */
+			printk("%sMSR Address: 0x%08x\n", newpfx,
+			       ctx_info->msr_addr);
+		}
+
+		if (ctx_info->reg_ctx_type == CTX_TYPE_MMREG) {
+			printk("%sMM Register Address: 0x%016llx\n", newpfx,
+			       ctx_info->mm_reg_addr);
+		}
+
+		printk("%sRegister Array:\n", newpfx);
+		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
+			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+
+		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
+	}
 }
-- 
2.14.1
