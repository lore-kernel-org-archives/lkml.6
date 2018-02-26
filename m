Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeBZTkK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:40:10 -0500
Received: from mail-by2nam03on0053.outbound.protection.outlook.com ([104.47.42.53]:36592
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751752AbeBZTji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:39:38 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH v2 8/8] efi: Decode IA32/X64 Context Info structure
Date: Mon, 26 Feb 2018 13:39:04 -0600
Message-Id: <20180226193904.20532-9-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
References: <20180226193904.20532-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BL0PR1501CA0034.namprd15.prod.outlook.com
 (2603:10b6:207:17::47) To MWHPR12MB1917.namprd12.prod.outlook.com
 (2603:10b6:300:114::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef2f6bcc-ece1-4c6a-467b-08d57d50ab4d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:MWHPR12MB1917;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;3:tf0ZWNrYD1vJlHkCZDvQxjxHGkr9o8SinUOgz0cMlS1GyntxuhD98cAorxsV5SYREvqjKyZnBlmttxqL9dEXq3cjSqLO3ArFf8Q5ffx6hbunWeoOytn3c+Gxwj7csc/+luo2huy9w9ftSr1WUzcWIjNzQdgr/OGaQhQ1Pij4devhT33JHv9KkKps/fVLimwH7IMbIR5pcBEs3BHLFuOYLbBwqJVoPh30mnqP2vsBL2//vvH0RITcAMNIanCfSlED;25:kXEoVwaDSVuzxMftLAJz8QQyq7stWIpEw5vJCrh7jgI56qgcemTd5f3h08rUVFII1hjP0eTa7n0GAFZxEln9hrtJBV/Z/ddEaozSKJPVZzwlmJBOpHFM5r41eGiUL2qNERghl9Zh2gcFQ7FqSwYDDN7BsLcVggnZEkMN3P83w+rDL4ZSx5NVr+R4Xr03wD/EZe8vtFDEf3rgNIZ6qQucihrLQ+m5bVc3Nd1gY31W366yHXdrsTMJFx+NYu8ctlxKUP5C2Q1OOQjX7iro4Kp4kDoUUjJiMqM34EiM1kw2zFn07Qoq4vaDqC8uqJ/HiTcnwJ9RkC7MO+ED9snnd0V7WQ==;31:H5e8iWANZEufxqXFY91mrDWCF/du0taFYj4DfZBfGFa8swjpnHephtzk8sO6GSL6z4eKGIxyuflFU4jI7nmEbrMO4pAER1jDFlfbGyVyG2ujwPY3gVDYp1uJplqID5iTxgfdcMHfNbQRnpOT+OpJhAhUrMfIRAVm2kCRm4IoatxZPM9n2QCqQE69hXTVvql6qTAbiyyXfS7p5ULFYFxC7qSk2CcNZLY02WiX8akKQpc=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1917:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:9ETAa0Vah0P85WKd7dWN6YE4sWI4uQUOs/yJYKwN2EX3j+Vv2VV2HlG8PRAobGdd6yrIOkYwRpHzdoSVHx0m09AF9b/UvL5sHrRTFgBlOeMojkg80Ggs6cCRYFh9e/2gBi4fkKSzVW/HCWyrTwZnwE3Ed5dtnglG6VrJZRR2cJhFfz51dEFPHl9sobmQlIVSotwT7t+UHt6AmWcizpEhWzoCO7a7+zrcWymMA411TEcR+Abp6Tey0bGERFzo63YecHkKIhwrE8Lz6Yyr5yaE1MioN1FuupUbg79Q0WDP383JrIWysIwsTkROWB+90GePFCRN3R1TU587W6H25X8E3c1YFXzz1Hm4Kfaoza862UVekQv60rftzS0gtxITC1Qh/9J4rYTzGxc37gKyb/GKLyW5mfh0KzdbES4pPV+qqTAn2edTFBS86VQDJJIhq/vkTtEY7w7ePLAZTjwn+hSrIp3ywvCunw916CL9NqmhFM+XFGzk6yNhv2IBi3SgRZvy;4:iF9/uRze8tuk+gk5UtwSRTLB65ELZMbRUwg7nJTD57hMmwxK2NfDDm+BH9QnXTq9i8oR23JcgQWCVfQEvQiXLB2LJlHWGssm4h4nZFKCO3d2UK5EVceyElZALoooXqcXS2Vn9Ux1iAAjfllRdSfeDSo732iyh5tt58HqWXPz/CYlwQ8eJAgetmVWrMO42TmLJ4FTZq+NMmxQ3oK6mGOAc6TcSNEpx0AreVHCMeSylqrf+g26prd9LCMdBdsHhJooOAq10tnziUmHO0C4tcwhnZokudNc4YHVYYtJ3KZsNB7xc3rF6pJZkcXpoB/syuffNnHvSvctqmrwZYgByjH6vw==
X-Microsoft-Antispam-PRVS: <MWHPR12MB1917599A1C0B096E2E3C810AF8C10@MWHPR12MB1917.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231220)(944501161)(52105095)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:MWHPR12MB1917;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1917;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(366004)(39860400002)(346002)(189003)(199004)(72206003)(2351001)(105586002)(386003)(16526019)(478600001)(86362001)(25786009)(50466002)(6486002)(97736004)(36756003)(48376002)(53416004)(66066001)(106356001)(68736007)(51416003)(50226002)(47776003)(7736002)(305945005)(3846002)(6116002)(53936002)(6666003)(2950100002)(6916009)(76176011)(5660300001)(1076002)(8936002)(52116002)(7696005)(2906002)(6306002)(2361001)(8676002)(316002)(81156014)(81166006)(26005)(186003)(4326008)(16586007)(966005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1917;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR12MB1917;23:sjX5ccjXKfhUgdeNlpDeDT1VdmhFu4NsU90sqfT4n?=
 =?us-ascii?Q?LAEvlPCFZC5VBx8rRi4ZTm759gSnWAE0U0mlNNWvQlpPCbxQ11VnwJw4b89O?=
 =?us-ascii?Q?bz24ASeH18g8FC5HCyeYA81rVp7VbDqeKr/YEC4uCCaURA+tc3TqI0ttndZr?=
 =?us-ascii?Q?05CxGnwwJ5r4Xyvi3vhmMLK5hL8BDS4SaT3zRYcZSoXL1Vkrmca1ny6YJLaG?=
 =?us-ascii?Q?1sAdksXG6IxFJNuFMywdpWG+nDvIPsDp33gTnUDXpueRyW6qb/E0iL02FW1j?=
 =?us-ascii?Q?MfEIL4M3zjWjO8g/7Rv8mxsXdaiB4Xc7M5I9Ne2LYbNQiwqEl2jqz50J34Yv?=
 =?us-ascii?Q?p4rhkw0ah51PvSl/iwakm121RhEDgoQy/ZUHkKmcCgeNE/m59ll0sUvIZuF6?=
 =?us-ascii?Q?7RXxmFCYA627cNW4/rdo08GUyaEfrRZSBHDtmx/4i/Jr9Kxdd3xGbcYTvpVi?=
 =?us-ascii?Q?7DMUnJ1WKXd8MQthSqKY3RA0ivPTeiXQNHoxtB1M3Abapo47CzJfphZcEfzI?=
 =?us-ascii?Q?jCtprx31vDUiXaM+EpEs027gqqOELXeAiT78uBRqqaSZ9GBlyr2jvgvRm34+?=
 =?us-ascii?Q?ztiW00L2GxgVZmbS90iarf3IOeF+csisyt9WOjSDA20T5ojBSsHmV20dlXXf?=
 =?us-ascii?Q?5mrjtyrAAYYBJpvbo5OY8/xiJvbv2T+L5q/irXCopb/DJ4jNFFmudgrywmsW?=
 =?us-ascii?Q?f0fxqe5+jMHPH6jF6Xqp9kOdtkOjNSLBaopYsFgPlIAoBgjA/C4ExqSxcYSk?=
 =?us-ascii?Q?DQ420lbeLf+w3biT3nSJUhE0x1Ewom16VF5e4SEiatv4Tt95QS6k0OFdo74/?=
 =?us-ascii?Q?Fl4NHFyci8FDAL0BYhoRs+FL+rz+kPpIRCfPN32z2Ru94LJPIWkYzl0fIDU4?=
 =?us-ascii?Q?b2fW6kkwo8f5PKpeAiJZ3an+CUs1kckpnwC3N9+ygWjT6k6E2HPllhgwPdFN?=
 =?us-ascii?Q?8shAwREj8oLzgxBgXxGS4O9uH2c4gkv9/gBvFbRYQqBjUH90SZcKF9tdi7PY?=
 =?us-ascii?Q?ljk2CGg0qSZFVB12ILh/wvbizk5zkq52blQPKayDfPjtz0dPwvrxoWIlKBbe?=
 =?us-ascii?Q?uVsa8xtH4eT+LsCAo/est0zLVADJadMpf8NW9dXL319natJWohnlaaglM/AT?=
 =?us-ascii?Q?5QPdViFahJ3iHzcwLt1D4JC0yff0dqPwp7zDR7D3MBCu5tU9ZpL8P0UGPLVS?=
 =?us-ascii?Q?PgqZ97nBjgZHZIGyYSi3Ncx8MaJj29B8wco?=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;6:wpAEoHB5C2TqNR4wLzcB+fyEbfxGFPRq4skKUo1YgWtroPQA5a4t8nw9oSavJYM2pW1vNUoLL83+QAkXyFsxW2e6TRHF2KAEdgeZr0x+hJwHKaJwIqf33FbwBL/nSMfV87OeRprktZQM8GvMMIIM5rSnEEbhwBpNLBvXOSCwoyPEE6ujpfPEhV6J2mNP2Ws763DILcEgwCI7GIE4wMBZZEbMKwoqm0ALaw6Nyx3dQNpHwdXxWzWcqFlUqORbJjRNkb1q5alsoF+jaSCg8VzCwRe22TFDURl7+++1Uuy4ZReW9Dc+sB1OZWU/z0RVP093gPUzG0eYnxUGjCMXuSenA4CsFr8y/fXBxG1JD7WOOKA=;5:Wa5bs96ncc27qvnZIjUSRLrxX3Tn2hNaqEjs1s+d0fUcqHTVzsWBT7Xfte9p3lsa237mhimWdtMQowqGj4u5K0YYMbgWEc0e+rW7oK94SOMFM+s6qnjusTFeI9DVUcYDnVJiEZIbGVYHkD+rVfQYnPsQp7aM0rqdSrzFwL6hPN0=;24:63SUvcVo/BWqY76EnLZ+rxoqg+aRcFjqZSrGVr2tjMCVLfCYXTpERrY1VqYK/0kCCSzSEpZWwOcKXgVQaNmu2f/hWTCu/ZSUGeFI2yGe2lE=;7:qVB64Zje2LDjS1PpFrnpbsF4+qwG/3gOH45UVnOb80xBbyVoX6kHKwf75bIKfHQxIUB1ogLPzuRz2O9aqACzY4wlzaswbdoV4RjUr/SiT882WIYBLrLlAjOTK4+QQMj2H6Vp8XI1iFfPjcZCHbuWk6WfnSgUuuaZL5wASEcDKDXblxN0Anau+Ww+fQqTf674PiYKyXqDxvmKA4tiJbv30n5XHR3v4qhU+uQ3peXGt9pPXwF1k03fYfZX2Zc7Gkb/
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1917;20:Qn2j92hPK7qHdTg8B3S52G+4umhSbZh59YYJuLacmi3CvYLSemA+QGsfrjHFlB8RDfz2ejefBNOxFRJjzrYH2JJ/rgzoF3Ny5kbHFC07glySPzBE8Vn4CWrrQKbWDC9a27zPtKRBPz5McsJYP6COneAY0EVTXQK+jRxaQ92bnRcVlQAhTGbp11LPHuGE8xCFZ11AvfWaFSrC//03pfsEYZoLRmGA8J27Cnk/W84X/UohpwSg0YMt2m4RjL/rbih2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 19:39:35.7148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef2f6bcc-ece1-4c6a-467b-08d57d50ab4d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1917
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
https://lkml.kernel.org/r/20180223200333.6410-9-Yazen.Ghannam@amd.com

v1->v2:
* Add parantheses around "bits" expression in macro.
* Change VALID_PROC_CNTXT_INFO_NUM to VALID_PROC_CTX_INFO_NUM.
* Fix indentation on multi-line statements.
* Remove conditional to skip unknown context types. The context info
  should be printed even if the type is unkown. This is just like what
  we do for the error information. 

 drivers/firmware/efi/cper-x86.c | 48 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 4c79401aace0..0407671ad7e6 100644
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
@@ -246,6 +261,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
+	struct cper_ia_proc_ctx *ctx_info;
 	char newpfx[64], infopfx[64];
 	u8 err_type;
 
@@ -312,4 +328,36 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
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
