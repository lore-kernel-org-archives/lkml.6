Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933563AbeBWUEJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:04:09 -0500
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:18496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933271AbeBWUEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:04:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 8/8] efi: Decode IA32/X64 Context Info structure
Date: Fri, 23 Feb 2018 14:03:33 -0600
Message-Id: <20180223200333.6410-9-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9a6d0f66-6c27-4c4e-e805-08d57af895a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:Oo596kq2H2xZZGNK5RkJijHR0rd8+q8iXvZGPPb2SWiURpLqajM0hD6Ke0z9J4EBZk3ajMutkMQeclg8AlL/YnNLol6zo4aFtDrgsQxp8OU5YIgU1iVoGR8mvnSAUovYEwcjqxfcGsdAhg2LmeQDHjJXLrs7vkBUJ4SrZ5MWlheWtGfVL4+Hi03geZCSoJKlxS9KY4Geqk0HuRJ5PKIQzfBr9k27slbIb8kbLpyjqvy3hYtVQ4cR/Hnz6EX3vYcH;25:EDL90LqW1Q3O8VGY86EVwwed2yP7Be+XeGpuxOZP3rNlPuablCfy3zdxgOLzQYpVEfWFvZafbu41Ad4WElfvL9XuDDi0gXWCeeL0hfQhWAZYii36aP1ocsbFIklshfJDN/Ejqbz6i9c7vbR4NKK3cKW65MDZsMJ8YA1vThIEA2eTIwzYefNem4mxX2e2H6voPeLe/5sZ2yEL8j9hoVMEIUN/JPIwz0JPdO87+O2M0zoVXHwoj+wJnQODkZVqfu+UxgvZl8G3S8Sf2MUFDXeFdK7+EmzX2PMbSmsU678QM+PyImUUbiaPXYtq5Gm3T5FB+y1hGKePKwP5abeiK95Yrg==;31:eKnl+2/O52eZ22EmCVNJLQr1GEI/9q5dRnHVgNhxTe5thTs6Xu3JYeEvjpaZEI0vTvfe2vj9LKFYP8Qb2k3BP2OcqZwa+8telcZffaF8jQJthquAWAKXII9G53IsX1RwKPBVC0w6nV1StgBQnJzMB43k3kbbUDmIJh6inSWZwIM/m49y416E/9MOaUHzBC9WacFZbnYpY+HGpKovz2M9C9/+nbox+gz+YKcs3msMIqE=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:QdAr517x4tYaqPK1QFFX7mt8trGgHlj6FmQf6ZMkino3FjliQDrrhBkEvRwpx73yw4h+hKJudjNKevu25dBZE8FMaolDYI7CuCJef2SA6KLBX7vD9hrdEdfGNmE0elCzb28pNBergZ0KdP3TMPQAo7mc5HOuTuNz/eDmMoWjQVOZsYRLYH/N5rfGVfYp/MLviP7cvMygFTk5F9k+RUsUeC8GsoQIT4OV70A7ZyEikqP+jWXmz1uj+YxjW22O8o5un89SfhPMR1uTpQyQBv6K3VF0XZXfoHpCgYazKBMe28cSL4akg14L8gpHhUG02qcOrJE0htCol8UxS9hpmoGKlJgVyfwvJN8/7XYUhSUkBUTwtGrBkx40zzbL3BFv1RtIaeu20WGFg/Manc71NtEDE/RBdBO7sxhcDBErF2Qwv0YAxIe9xBAmo50uOroDOnFoaNwKAQBKaH8XlHaJugQV0GbG8GqIpePTcdAxz+wTFjcnQBzmqnG77pZayJOlZCEG;4:xWN9Gr8qnbyJ74BNeM3KscJVck0alRqf04oqT8aidH3GJJke4Osbselkr5wIO5THScp3/HZAZbzsh7MsYI6rlb+pQ7iMpGu26Z4maZqgu7NjgbAygZs2qTIhPP+1DVSYsN/Xw+HO9MirFgjW9festaPp1/Q9aSl8TL+vMa5YmV103hSPAsFudZ4pihfbcJUKA/8RJ1WIxpOxbtfSH3XNdXnkt/5LT2qNNsTrrqALJsRaOuxT6X3g+07CpttNoYEcgAn/V/yiHrj3UBJdZS0JdXjWWKxxdDDRZqWfhJRJvCRmYC25tVjKJotF0InO7dqVLu2vUvtgJTe7nT2ENqaDbg==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1906CCAE1CFCA991E19236AAF8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(53936002)(50466002)(86362001)(575784001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:mG4ejvz2JZ9ySIS0r1SuVlXJnLY0kkpPwzXSJXVxy?=
 =?us-ascii?Q?VEq4Eflfua7YdHQ6FbkXGYAI6r58V7LadIcgeh8teFVRn/upPuqMlGBfDh3V?=
 =?us-ascii?Q?4y+WdI48LTK/VnfF+i0XELeRSw7UtXRymMdfu/v+iwncT2Oy/R3lImEEHhww?=
 =?us-ascii?Q?5A2dpOW5TxNuRuSFIKdWVbX66ACkTh/cRnnTZIaOP018kKhvrQOwXWio23D4?=
 =?us-ascii?Q?yEDdFS0/MTaPCVQm6zGMLcx1mSvKNvrsS8n4nFcArxbONWu7M0LF/yyeC8iq?=
 =?us-ascii?Q?foAQyCZV5Q4OesjEbbKQAUjVHLq93HnS1FjuiiE/9Zb+PV5m74SiuiKgkjzE?=
 =?us-ascii?Q?J5iA9rQ7V8ONBh9aTEyBIvtvFK1uw+Qft1i+IHPUNfY9w3ncWPinlVuFBPzM?=
 =?us-ascii?Q?/0a6Y1su6IMo4dBoUjxcDzYNVSx6gUnMQQRNvmW1W6lUsgYRIKxrkkWnBmNx?=
 =?us-ascii?Q?mHSMq3ZVY4DHeSAeuOahR1hA4bj5eLFvt0DTq0c6o3AQ6OV2tDl4bhy8FnCl?=
 =?us-ascii?Q?I0WlJO/Q5NpZGK5KqOK1SPWEVr9U1fsAdGkdzHXmp+pq707DRfKbP2wIBsKg?=
 =?us-ascii?Q?Metb9XnVUO4oLqceDAuOItqGywdlUit6XoDDNyIJveKxFTdgAO0tAGOINnY5?=
 =?us-ascii?Q?i3E5X9YHzlOKMYojmiPPDYtZLvKfWSuEG5+YmaNM1MzDdguwv0XzMUXZgs3+?=
 =?us-ascii?Q?tlF6NY6JJucVLWVBX6xGtbZfObmq7/PsiREmFrQVb5kG0madf1uIYDsF7ytN?=
 =?us-ascii?Q?RPqXxJjrTCatPooQdEVD27/JJxIJ7X52phDk9h2e2StvcmSauevGxSjPlUMe?=
 =?us-ascii?Q?uZsx5ge5SOaSOogpyKgGk3HQwiooBBlnIB+WRQFrDI/g8H7p907KMM1OC6l0?=
 =?us-ascii?Q?wjuGIguUo7NzM4RxIPGn9QBdLZlwT5ZyUCjD1qSMvlG0EtQEgQKXevDYAetq?=
 =?us-ascii?Q?O4H0EFS6ZQ4oUd3BnLVtDDhuBleV/C5GRgDHvqMRT49MxhyWpMXhFAvncoQL?=
 =?us-ascii?Q?X2OplBB1uTqoR7jeiwD/8D85x72YMm4slhlbqiHJlf3tRlantAlFbbBh4OE2?=
 =?us-ascii?Q?L11MkYRvz4JJKfALUr4JYUiOWU3uMAMyZg9uLPSuIOzX4PnAqkKozr/Bj2Fw?=
 =?us-ascii?Q?vXRNsyA6V0IeCzQf+mvH/rvJSwI2T5CxWqc7YeU8diJdrL563c1f+qnvKO92?=
 =?us-ascii?Q?LqTKpIWeQuO7KdiM/pgM+yhKjUHVhfekW7T?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:13YNhrZabTMuGHYybwzGqgD4LFOqPQu3S6W6RG2bro6LMSriUgmfJbtuUwk1RnTCLYHjIsj/dU9kdT0AWAtwbG2O2vh+FtXxduQ7PiDvKp4cVSeLKuOZwZeg0cVcsxf/3nWzriez7t9QoJcOkNtVUOCJkoB05UGjPuHQCKJmDOM9corqx8sq5a+BpoxU8JR/Xj0wXaTHTBLNuiekY5Nd3cd5EVj0AyyH/hdPKkdPQEro0V9ovlUqelwZtw12PI7JthR4i/tgTy3P0lL7yYhEQhZm+AuMJtsXKisg/52z5QQv5SC7CU1mI/IJSz7pJX1+sprcKXVtTtC0BaP88QTpXMYofktNshrSLRTnGeSWFC4=;5:0I8kpuslfJ374J+SAWfLuJ368BmxWXB8nMjRJfccbSokbrFgvLIlO2L0W6Ko98aRIGfWQEvL/pK0wAawd4goQypi4VgdaSx6R9thxWcbRMRcOAqXGWACf/vqDLoYtlG1RKUeIQBAkUcWwT4is3Efx5YNn/tCX40B9tCp890oJ5Q=;24:7Aambu1khtgoCJ5YQXwxMECUQGmVFcVjxVBQcitEJQpAX9XI9BoFzbNdeDi5fXm/l3lIHCd2vdHKgLWZBTjOLy1oHS9NxPNaW82R+5CFPBQ=;7:K+DzEI3qWSOaTRNmJpkOjux4UrKyWAana3FGjGur5+gFCnMOM4BnFiMvoRpsdS9BynLlE0O7eU/q8mSwFtspMY5ccs7GO5HrfNKAnJTCIIx8IAcKN/jTWTCwdbHEkUNaHxztENiaiHv2d8mueQQlwMuOdrdOXVECxKnkkUfqEsPXCZOaJ+61RLrgkgMJLX6iA2U0arCdgzg6ybrLml8JSXzAHWqHyyG5jD5yhHOE8opFAV47g0ZqWhwIK6U6807x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:wcYXFeLd/t4cVDypowmxQGULN98BTQachU5EUzDkgkZX2Lnl2aqTAINpoHxBCKhiuGus6EPUlhieVSth7Zxxnfb0I8z9V/f5KNkzd8FEe1wWbetsm9C0gtD64FCISkFs9+XnOYLA1Z7NEYvfWGiVYKb6MoL3oybbS56tVJh+5bXShvunaCn8qE6h5N1VW3ej1qW7h9YRnha9zhYtBlhFSjnzXZ0D3gdomcOG11biKGjRzfBfWSNLh2eoSExmhWPa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:04:01.1111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6d0f66-6c27-4c4e-e805-08d57af895a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Print the fields of the IA32/X64 Context Information structure.

Print the "Register Array" as raw values. Some context types are defined
in the UEFI spec, so more detailed decoded may be added in the future.

Based on UEFI 2.7 section N.2.4.2.2 IA32/X64 Processor Context
Information Structure.

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/cper-x86.c | 55 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 02b1b424f537..bb6cef0b5e53 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -13,6 +13,7 @@
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
 #define VALID_PROC_ERR_INFO_NUM(bits)	((bits & GENMASK_ULL(7, 2)) >> 2)
+#define VALID_PROC_CNXT_INFO_NUM(bits)	((bits & GENMASK_ULL(13, 8)) >> 8)
 
 #define INFO_ERR_STRUCT_TYPE_CACHE					\
 	GUID_INIT(0xA55701F5, 0xE3EF, 0x43DE, 0xAC, 0x72, 0x24, 0x9B,	\
@@ -74,6 +75,9 @@
 #define CHECK_MS_RESTARTABLE_IP		BIT_ULL(22)
 #define CHECK_MS_OVERFLOW		BIT_ULL(23)
 
+#define CTX_TYPE_MSR			1
+#define CTX_TYPE_MMREG			7
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -137,6 +141,17 @@ static const char * const ia_check_ms_error_type_strs[] = {
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
@@ -247,8 +262,10 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
+	struct cper_ia_proc_ctx *ctx_info;
 	char newpfx[64], infopfx[64];
 	enum err_types err_type;
+	unsigned int max_ctx_type = ARRAY_SIZE(ia_reg_ctx_strs) - 1;
 
 	printk("%sValidation Bits: 0x%016llx\n", pfx, proc->validation_bits);
 
@@ -313,4 +330,42 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
 		err_info++;
 	}
+
+	ctx_info = (struct cper_ia_proc_ctx *)err_info;
+	for (i = 0; i < VALID_PROC_CNXT_INFO_NUM(proc->validation_bits); i++) {
+		int size = sizeof(*ctx_info) + ctx_info->reg_arr_size;
+		int groupsize = 4;
+
+		printk("%sContext Information Structure %d:\n", pfx, i);
+
+		if (ctx_info->reg_ctx_type > max_ctx_type) {
+			printk("%sInvalid Register Context Type: %d (max: %d)\n",
+				 newpfx, ctx_info->reg_ctx_type, max_ctx_type);
+			goto next_ctx;
+		}
+
+		printk("%sRegister Context Type: %s\n", newpfx,
+			 ia_reg_ctx_strs[ctx_info->reg_ctx_type]);
+
+		printk("%sRegister Array Size: 0x%04x\n", newpfx,
+			 ctx_info->reg_arr_size);
+
+		if (ctx_info->reg_ctx_type == CTX_TYPE_MSR) {
+			groupsize = 8; /* MSRs are 8 bytes wide. */
+			printk("%sMSR Address: 0x%08x\n", newpfx,
+				 ctx_info->msr_addr);
+		}
+
+		if (ctx_info->reg_ctx_type == CTX_TYPE_MMREG) {
+			printk("%sMM Register Address: 0x%016llx\n", newpfx,
+				 ctx_info->mm_reg_addr);
+		}
+
+		printk("%sRegister Array:\n", newpfx);
+		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
+			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+
+next_ctx:
+		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
+	}
 }
-- 
2.14.1
