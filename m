Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933333AbeBWUEi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 15:04:38 -0500
Received: from mail-by2nam03on0063.outbound.protection.outlook.com ([104.47.42.63]:18496
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754713AbeBWUED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 15:04:03 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org
Subject: [PATCH 7/8] efi: Decode IA32/X64 MS Check structure
Date: Fri, 23 Feb 2018 14:03:32 -0600
Message-Id: <20180223200333.6410-8-Yazen.Ghannam@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6da0a53f-1c38-4607-1b7b-08d57af89498
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1906;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;3:yTQ3rc5ykB0D59qMON0rVkpnuemiCRv8HvgqmPujrHaE2pVJmRO2oxsp8cE0sW7inwcAFtDGi2btpCEA/mRLMtCUapyIa737mu2U3KUotye+2OT0WZdtwlcVWG8xI0dSUa8weUj7uOybY4OEPG/RWxJtxZ7Ds5IkZQNQYD/2w+xJyHG0hSlzXGAMbHMTuq4NCy2+8DTGh/lcJW3c65GjkwMeXLoLNorpU5zBrRi21wNSTj09xdzoFzDU+yX2rc8X;25:7D14PdfMFt83LrzBnlUIM2ZkNfmeERyzZ93wH9+noR/92sjDMrPSi39jnA220NxCNADEGJ7BIGBhn2QmmjvpVQRP9DdKbFsWWqREwBkmBVPXOuADTrxKOA/qzBQmBA1TOQLTVBGJzR9R1r4ljfoylfRJVT0TJvYSM5FL78csnMtYmNph9qfB63BnHlm6rdQHV1YyjnIzeP+yBKTEuK/7eHyzySlCeZ2o67pNma0KeHh1cYRKaaypmul7kQxaSq1dAQUoTZGWLYyBIIkaL5AKSXCkamNg3zc4SKGw9nsShkz+Fh+laQaquqB0tkL2W/WDeZDsoiXrUsGx3Z3F5kV9UQ==;31:ONVmC/d3vDH+gOdq9jFaj0xj4Y9+nAlsO6KjZXjhqfTYC6unbs7d8IEASK/G2Wi47ekhqsSAiQeKNf+mRV6FHIA1swJE6Y7H++6g2JkEvdTqPzqfUchMRUDY7epz1srU3K6v0wfLQ0P82sClJeu40+/398tJNec0JUQADazosplozWU3KNlrp9NiALV5IX9ZCWqS54/MW9HdRLrDea8745C3Y4squHlUBEHY/GY5KTg=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1906:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:m2TPeGtKdO/fo8U6XsxxFSxgoRhFyU50FlUMwv3jyF3T1C7847S0b6X2uw+2837DPaN+nGAIXpMr4dY/91IHyk3i4jN8l9euyoVbIc3Okg5WA2akWSC8YZneKrhhiEcjhQVCXG3rB3bguHyLi3JZIonyUxIcANp2N4s0uQ3PYnnl5TPMA/sRm9FQR8WCd8vTOYh8n+lq2avHHgdrUSQQNTqm4uC+Jx6ybM8AIpBuEUoGi0zkmgSHycKR7ec8UQyr0ANbBSt44BCEEspvIheqjOA/xjtehO8gPENj1GOtoMI4B3jKQ/mCwXlLzq/VXJfnz+prmBL8a3FnKH8KvPT/51jwzzBqbiHfxjW81Ru0AVHbM0dDN7/uUIA3VRJe92FScVTpsUDuGP8Y3EKC8JmXHSvdgAhW/nHoVAHyYKYPwCfw0rwYxaBIcrxZ9bOxH7xGPGXMomMit9KJ8tpHwG/vqHzEObwaRra++QBharlG+BynFxRcOljo/FFdzGvV2sGg;4:gHFvoMi9gkNzU3Ajltv+HTTi8nL2OB8Lko7b1ngGcfDVKygQAQghAcRWKYHaEeV5BdYbS7xVecpn0rdf140EMJLfg5SG27IK13LcpbQq2I9RAeozJXm145Rqbv3/OW/XkEv8L2scxdrXxFLJZ6YAO9W3eTfCsWK14x4cuAJUeIMz4WJvk9mI4nrziKFqb16ulxV8fdQAb+9whzjhCetMoe1OVvztT6hZEhVMvGqKo8H3kG7RP2gkq/XK0vhDxgG9bXyU92MCN4d630LgskgeUt64+aKeYasnHIT8QaSdWjznbPJtrWVNSVEq5dkdaWti6QNTG4gNzVbsp3uCpu2rPw==
X-Microsoft-Antispam-PRVS: <BN6PR12MB1906DD07C48D22221B26460FF8CC0@BN6PR12MB1906.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR12MB1906;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1906;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(376002)(39860400002)(366004)(39380400002)(346002)(396003)(189003)(199004)(386003)(50226002)(8676002)(478600001)(8936002)(81166006)(81156014)(106356001)(26005)(4326008)(76176011)(2361001)(53416004)(51416003)(72206003)(2351001)(68736007)(2950100002)(6116002)(6916009)(6666003)(316002)(16586007)(66066001)(25786009)(1076002)(2906002)(3846002)(47776003)(5660300001)(305945005)(7736002)(97736004)(105586002)(48376002)(7696005)(52116002)(36756003)(16526019)(186003)(551934003)(53936002)(59450400001)(50466002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1906;H:yaz-diesel.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1906;23:JepnWiy/wDfJOCp6f5hbN9gLHsYOK60cG7hkALO8v?=
 =?us-ascii?Q?1wNypPbVAJklgVeUiNOjFK43xcZY420wLQY44Aw4Y3m8lnWvX8gAwK1I08vx?=
 =?us-ascii?Q?P1lZSEahzZvdNRScRdvKScFU94cd8nct3/n7MGVEsFghmyMUTGz8vucqKnFJ?=
 =?us-ascii?Q?PuTqZEgPPywjMTKSPGi9pTk43e2IU/Q9jBANgXbWpFwbuN8V4riVmSqLB33m?=
 =?us-ascii?Q?NCXGfKeZWEtmTs31eR6jt/GEIF+FhgTRbjxqjOzIVGbEnqNPwkstpG1K5c/Y?=
 =?us-ascii?Q?hz6OVNSF+0y8CaBz5N5ykiiznKiTTGF4nX8RzgP+lMfv1vFSMA/HuxR5INFV?=
 =?us-ascii?Q?lTQaL1F6jErZBy2ZiAsaPmZ4Wqg3rA9G142DFi5FejNsDGdZugPgJFr2FX9Z?=
 =?us-ascii?Q?J5XUqC5CDeLurorH+HSgmMcOlqwh8ej9/dvEqGNiXYSbh3vacp4GBY/GDEA8?=
 =?us-ascii?Q?JSdaEbL54GzF1SbqhFcwHWLek/EAt40cbA3wYbBBA6JB8Say99hoUnnGMsOL?=
 =?us-ascii?Q?Z19EMClCp1jjI623Z/A+wD/Qdjp9MLtTczXc5eAynZ9abWymU6pCkm6zoxpj?=
 =?us-ascii?Q?pV/NTKztXEWYh4T9mSQZz/BVed7jpY20gxy4ygVNE4WCehKHcp71r7Dj6zfw?=
 =?us-ascii?Q?rHZnHT2IF/6UvTnFM8Gpbqc2Nf5N8Y/hbyJ3yZmKJYwUGvVljiCrk/Agk+LD?=
 =?us-ascii?Q?YjT9bVIFUUfbkSnSg1OEP2YwRspeebk/20D+2084dq/AxCQBAdvH5nIG6nGg?=
 =?us-ascii?Q?gsXuBpVsRK1r6dAqATqSLs4+YB3zEjBLqoCt5NPGbYnRZ4SoM47dIRWfq9Q6?=
 =?us-ascii?Q?8YFZIxU7bUExYDU0U2jncQT/1JuhqiNI50QC0W/DmYh4zIXVTQfnnpl2a9/C?=
 =?us-ascii?Q?0WcH3gsoL8b9HwW+CqMTjCPou8k9cbQJtxhLIRa8D3SjvBREfgNfeXrwvJn5?=
 =?us-ascii?Q?ZKM/l+OD7wX3HIQK5+hCrbXXn9bv6xvbs78GgWRySLBa8XTl20lyCMZlAgD1?=
 =?us-ascii?Q?JH4XwLiunkozohvGVJxFPY12u/AaZKW8P9zLUzXO67VQGK7KsiViLCZTkIb5?=
 =?us-ascii?Q?0o6JXDrGZx6Mj+HYkV45QtmAGCvtRP/OI/b7Ib2K/KMH+a8ZRfaPN6xpftjP?=
 =?us-ascii?Q?CKdkkifbE+sFxR7xwEBiKUy4oiW4tQL4SfpYFVoNlpuqt0jfGtz6eb0VVMxq?=
 =?us-ascii?Q?yJ+X7DhLga71cc3AGoMuQK6f3OcEGbiVGTvEWAnLQ00kEtldkbNxjx7Kg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;6:w0aw/RckLKjfkZJYjuF0Wr10N5T0LQLcWizF38bFrVNRSEJgomT9NRDMzTP3KwElDEc8wul23hVTuSp/+x418ZHK85GkNVUco1J8rFm7JlXPPOJaSDu6+AqVL8OCBQZ5QX/rRYZTMP6+i0w9K0pez/8DEmSOJH4qle7t0/2eqbMxLu35vpFRXbJrT9T8RK7guaqWu8cbRDMtGAEOQXCIFAGSNTd4srNl2RoLgf2H2ZuELgNDKC+mWFN5VHsc/LXF9eBsyUWJuIAW+v8ZAS2ldLuL57z9vBdv+HCdN9ViX1sq3kPo0JGm9eCX8YYNPXmZaTvd/ba2oatYrvJfsrvNaE2JMnVhjQ8lZKqBI0GG5Uw=;5:Da8dgYmSqd2HNTui/I3da/T4OvPZ69CE7JHi/Gp0Bp5hQ+32Uauk8zJ0exLNlMZhhsITYtWaC4wOjAf/i8cDQrtwT/6LihHHx+Zz60RQfKBfsMPLwYC8xyB/fbbXIArheW/waHQq7fME3Y7waj51GIJyvfidfVw4fUmlTXaugwY=;24:IMHLc7Yd3CbdHKFU8OSIFcnFtntOn6UD3w1pkSYr7yvV3tvithUFA7NeONJop0jl7zj5ekMB13aEXpwQ4k5dVfr+8JglgV2yL8o8JR97FD4=;7:xOVyViq+L3b/wAYqP54AiLrBH61H7kTtjT7k5ny/Drzp7P3NRiYUhse1740vlEVedCjrq6envk7xob14IPrkg3WukuXQqJN6SL8oNEDBYA8x7qn1o4sr5ImKN9i/LmeKe4cNmWC3zPFnuVm4PTeLEttARiwFVS1B3ikldNjMg1YZgwO+WucAwNVyu79atcfPJu/q/IstgGn9vn4YtVpRs37yCLqNw6eYBxmais8E/aftccLAxQisKpfXj3YkgaW8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1906;20:iIR2yXd+6t9Nz6JIr6EspgTkjZoD7IBopcD3mlgeg8PNdg1pNzoTBMG576dRWOXaWHJUr940E96rFqBfYg1bdqz1kndxZDGFYooTpZyvCRz+8V7EMGC6npc+MhwUihgEllw5D4PM9IAYXDyEXaOkDKkZ09xNL4Lioqt5WPR7I+Bo0KYsPhxbOte9J3W9ExdS6GvuxnOXXusHuekjheFGUYz4LqsLPWFxd6qrXUl7j8LBhK+MyjD7JORlB0thzTVJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 20:03:59.3455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da0a53f-1c38-4607-1b7b-08d57af89498
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1906
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

The IA32/X64 MS Check structure varies from the other Check structures
in the the bit positions of its fields, and it includes an additional
"Error Type" field.

Decode the MS Check structure in a separate function.

Based on UEFI 2.7 Table 260. IA32/X64 MS Check Field Description.

Cc: <stable@vger.kernel.org> # 4.16.x
Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 drivers/firmware/efi/cper-x86.c | 55 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index df4cf6221d8e..02b1b424f537 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -60,6 +60,20 @@
 #define CHECK_BUS_TIME_OUT		BIT_ULL(32)
 #define CHECK_BUS_ADDR_SPACE(check)	((check & GENMASK_ULL(34, 33)) >> 33)
 
+#define CHECK_VALID_MS_ERR_TYPE		BIT_ULL(0)
+#define CHECK_VALID_MS_PCC		BIT_ULL(1)
+#define CHECK_VALID_MS_UNCORRECTED	BIT_ULL(2)
+#define CHECK_VALID_MS_PRECISE_IP	BIT_ULL(3)
+#define CHECK_VALID_MS_RESTARTABLE_IP	BIT_ULL(4)
+#define CHECK_VALID_MS_OVERFLOW		BIT_ULL(5)
+
+#define CHECK_MS_ERR_TYPE(check)	((check & GENMASK_ULL(18, 16)) >> 16)
+#define CHECK_MS_PCC			BIT_ULL(19)
+#define CHECK_MS_UNCORRECTED		BIT_ULL(20)
+#define CHECK_MS_PRECISE_IP		BIT_ULL(21)
+#define CHECK_MS_RESTARTABLE_IP		BIT_ULL(22)
+#define CHECK_MS_OVERFLOW		BIT_ULL(23)
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -114,19 +128,58 @@ static const char * const ia_check_bus_addr_space_strs[] = {
 	"Other Transaction",
 };
 
+static const char * const ia_check_ms_error_type_strs[] = {
+	"No Error",
+	"Unclassified",
+	"Microcode ROM Parity Error",
+	"External Error",
+	"FRC Error",
+	"Internal Unclassified",
+};
+
 static inline void print_bool(char *str, const char *pfx, u64 check, u64 bit)
 {
 	printk("%s%s: %s\n", pfx, str, (check & bit) ? "true" : "false");
 }
 
+static void print_err_info_ms(const char *pfx, u16 validation_bits, u64 check)
+{
+	if (validation_bits & CHECK_VALID_MS_ERR_TYPE) {
+		u8 err_type = CHECK_MS_ERR_TYPE(check);
+
+		printk("%sError Type: %u, %s\n", pfx, err_type,
+			 err_type < ARRAY_SIZE(ia_check_ms_error_type_strs) ?
+			 ia_check_ms_error_type_strs[err_type] : "unknown");
+	}
+
+	if (validation_bits & CHECK_VALID_MS_PCC)
+		print_bool("Processor Context Corrupt", pfx, check, CHECK_MS_PCC);
+
+	if (validation_bits & CHECK_VALID_MS_UNCORRECTED)
+		print_bool("Uncorrected", pfx, check, CHECK_MS_UNCORRECTED);
+
+	if (validation_bits & CHECK_VALID_MS_PRECISE_IP)
+		print_bool("Precise IP", pfx, check, CHECK_MS_PRECISE_IP);
+
+	if (validation_bits & CHECK_VALID_MS_RESTARTABLE_IP)
+		print_bool("Restartable IP", pfx, check, CHECK_MS_RESTARTABLE_IP);
+
+	if (validation_bits & CHECK_VALID_MS_OVERFLOW)
+		print_bool("Overflow", pfx, check, CHECK_MS_OVERFLOW);
+}
+
 static void print_err_info(const char *pfx, enum err_types err_type, u64 check)
 {
 	u16 validation_bits = CHECK_VALID_BITS(check);
 
 	printk("%sValidation Bits: 0x%04x\n", pfx, validation_bits);
 
+	/*
+	 * The MS Check structure varies a lot from the others, so use a
+	 * separate function for decoding.
+	 */
 	if (err_type == ERR_TYPE_MS)
-		return;
+		return print_err_info_ms(pfx, validation_bits, check);
 
 	if (validation_bits & CHECK_VALID_TRANS_TYPE) {
 		u8 trans_type = CHECK_TRANS_TYPE(check);
-- 
2.14.1
