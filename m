Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752814AbeDBPIF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:08:05 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752654AbeDBPHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:32 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 8/8] efi: Decode IA32/X64 Context Info structure
Date: Mon,  2 Apr 2018 10:06:56 -0500
Message-Id: <20180402150656.101022-9-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 699f2b3e-0454-476c-98b1-08d598ab6d3a
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:lP2eAi7eoajGERnRy1/ki1X8MHm9iDd5TokBKQdMHxjyPmLvl4bymIdX55MbDxWZ4LPL8hoDcX+FjdYIGamjiGOMI9Exqa7CG25hTGb6e+bgPLzBU6uu/+pg8REa6zO0VntxYLl40Zi7HUCUZsz+D7xvlLhgL4MAqyG3UBbcNb7Y2zobTGecbVzuw4wSrkibaZjgC8FXAv964G8Q/H9+DVZofb+vEVE0VbC4Q4IL6Q+O6o7nbgTjqho3EEDCM7K7;25:a04mCKPJ34Zep0mBlqIAW6rfrhSPOkbGEBZVD52FMIkqPOmPIH3DsyRlkiR2cv2YeMmZU9tLUxnr2OCqAqLltDRZScwTTFzkVYI0UUaURw5fqdCHrp5X9hOYbBGasdQQguDk3rCD2k9Do2zJRHGvVMYOhYBSupbB9eCfJLDDaiLpVwIYtaNCfYU6DnAR0XEgnwNNb70stLSt2cPtDbAJ7ekaqmF6e+9PqIa9osU6ZOWPbrsV4evXuG1yfZUol+QEgq1S3p75ONqsYLHbeQ6De/ylfII16zS2gy/SXva4jXNTZXhOAStd61ViNgq0EgtS252HKpSGziE2dsVicujHZQ==;31:BJRDrLBH/bpGZB7WmKGl8S9H5jK8bC8hZ/a/ke7nEy6gJu6hqSMzcxn2JF+vmPasTDnzFndJbYYyY62xmoXliDzdx2AZM/aN0mYWLhpQ/e4LM0SwD7L3QON+0mQI/zYKmlyXOnlw0MMJBAIDnHKsN6cyp7JeJRbx4NeNU08zqFX7OR+2LcEBgHr4UigYud2UaSNjVEWnSi4iHjlReivrcIHgqfkisItWSYiiQYxx/NE=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:NN1Ev4GuAABJ/zk453EdTpDtuNdo1SR2TK14cHiXUecvqSeyVoGZgdbZsR1W6FQ8IUoJYvgSPtSbHzQraiCztreXNo0OR2GnFADO50zDJBfkh8EGyeIciM+pAhENZa3O47efzjD2rg5I+OaCl6oJ301fRdNN/zDRVphP+9KX3r5hyi/czS3OhLRlxLONjBQsjqMmy7rTu/AYqqKBeXFTJYN4OwDB+MuHbdUUqgw/MVMTR3l/AKYFJIQnjg/B6oDhKcJ/pGvanjfsxgx8G2S0efxh01Upu5gKwZlm/zlDiRtLVJx55j94oR10PMD+gcFpNMs4+L5ZlPb9UljIR0RyYptkb5Y+N2IKHbKVLr0+s5RZ6Uk+pXB/SI7SfDPlxMYW8AbjkcgygBSFi4LUlfqvCR95vNGDjZlV/wFTRmUMcUTymPBpMnTXHPdiBx2MjMUoyYPwRlpjD0XhNDdwcdg6ooUhZTzXw11y68JxW9YxGef8p14EsqdqYbxp1OqtjV+d;4:IYvZmDXi93ls6zVeQh5sK3fJmj9ZKNNgAUoWaEMVW0OY9j92vx9oyHspM0EQ0EVuDGAlcezhMGx8hRBlAQQzXVoWLIhODXDnh7naljnbvxEXboVe+4QRXW2dQeyYYI3mJWyL7l5BvewaaWeuuLia1H30hmiWOQB0ea8ygf3vhCE8mmoOI6XwZlQgqj/dEAbtqNC4EIJ3bu3TYSoCsNw/Z5jF3ap67Ay6nQvDuSypx/QsUqKSMZC1Bcj2a8b7IC+ZYDkqTBs8QwXhJggE8RoA8hT4tMfLrT687GSOX/YdqLCDZJquD7jefeyWPpcoVyPeO+0cF51pnhcz6E3d0D1n1FCRgckST4kppShTWH+UEHg=
X-Microsoft-Antispam-PRVS: <BN6PR12MB19053ED953F768A48B860473F8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:j6oG4bFAsrHl2C+YpacOrTS7sSX903q3uYDStyRft?=
 =?us-ascii?Q?24N+BzttFiUb39mfqRAhpGoxJAfAw/8NkJ4YEKSZnZupNFkLq+lI+lehiySf?=
 =?us-ascii?Q?QB836C8Jty6OHpFpCgyEu+p3nyD41XWARyfsTq1I4k4dFmKiTmgViaEKFY1a?=
 =?us-ascii?Q?jKHTBVIvtlwZu9WZ1Hxub+7L7CGvg5FI6HXZjiLDumOmKCpCB7Ki93/fPZ+q?=
 =?us-ascii?Q?ZtJqbDwNmI/O4MlILWjA5jUlChUQov69vqa98QL0g0u+XF508d3aAjCVSXNb?=
 =?us-ascii?Q?0SKFH7V003n268v4drWMsA1U74vi1dLk5EsB2RvV0XHUdPS+LgCTrBxRWUjj?=
 =?us-ascii?Q?i0JqLmo9Ox8ONlxJZci76ejAUApSjCpI4tl01xq295mY6oGOyjIuGXRkqkku?=
 =?us-ascii?Q?9Or0U6myfPI9ZfyQ9Cz5AymShvlDAkitT+SZjzL67wllg9dvy18ogVsUb3Mt?=
 =?us-ascii?Q?fHs8hamd++Gk5BEpSQ9eZkw7DVJWOOS7NJNjnUCZPFJwbZ0Twjc67yv4kf45?=
 =?us-ascii?Q?q8y7ReKMhckq1nLdZnjzRwXQWGab4E0gdLgIMDE+4DyIkXVODIh40ttDO+JA?=
 =?us-ascii?Q?bq4Sn3MuyKjoSiTJRX42pwzByLfs24ViMxttDgu2CjkccqY1x8TWHqXGnJ5i?=
 =?us-ascii?Q?/eUpbYLyVQs4GVAXozvH0160lY+ltBfqWhqo22xfAHCN4YZ8U2xh4GyMUqW9?=
 =?us-ascii?Q?fy70sIAyKwgmT6sn8gfmtfHqgHAv6F/X7I5fJ8W/KQyP/KimQKg2FtvTuQWL?=
 =?us-ascii?Q?Gb22zl9apY6cL6UHBjgNXrkNYoan0wlwbKgH90H+2Dkz5unsBHCajXZqC4ek?=
 =?us-ascii?Q?HTBZiFjPoNurO4mQnoCPYYqg2U3cTqh6MMUDkZj9NweMm/hAWGdQp4zgsNmq?=
 =?us-ascii?Q?2OEBT3QJgh7mSIvxBLbKxBev0EEctxOcXh1GUXLKnC8zZ4oXLNCBkcPk4qN9?=
 =?us-ascii?Q?YOnHwUq3mi3R/qsMycytyF55fit3jPP5V9kObUHXMJJCCp3ijaU56/gLWP4l?=
 =?us-ascii?Q?q2Np87qOwaKHSQDtWvYLmgqtIG7sn0CJgoSukisHIWtwKhDNsYovNTBttaav?=
 =?us-ascii?Q?VNRvlmVqAq3mxlhJHaclhpcNnYskWAea5EAjEewHjJDFoSTLCU+czVuMyDxq?=
 =?us-ascii?Q?fSixTbPIh78Wq1X4E7g/pCmH3n/hWgwraNLr5HSl5CbnvbLq26NRWgH7WxUV?=
 =?us-ascii?Q?TgzZw9n3w7HBZj45y3vSSEUm6V7eIx0YQo1VJJ2I6OKbF7UsPbVkSqywiGBk?=
 =?us-ascii?Q?xg7+q/F5XCepZkyp28noTAB1p8lrhHyOwLhOzF0a/SEgczscyj2Ky8jSwFPa?=
 =?us-ascii?Q?8k9daZ3rudS1HYlOu9Mxfk=3D?=
X-Microsoft-Antispam-Message-Info: dhT8aesxkHU3z/I0ulUFnYvHg6DKGqp65qrraP8F/2YKZYDw/Q3kMfghZTFNVZqnsPop9r20smlwFunPoZVzMm1i5t1uKYyuNJ1NlDIaX51ioIgotBq1IR9/DTOD38RXXJdWTfrfMCSirX3rGdzKsYgfR6JG0RaPBQs6hmaKVZYVOKdkBvTOW4Wb2KayhBrk
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:TuTOgN7udCnEq1VWuE37Fi7LDBy5KoOEJEes80zanjr/5bIWI1pc1uY2hCPpvBbNX4FZQq6T5dCdeoGDxjIJxxRHUBUNJonY4vM6htHBq2lmkgH394IDbGOcfhEFly/xwLNu6voDy43a6tT6XVDVzbLAMwNAhpXwWFikbClWc2TxHRAIT2+5WuLlcasIKBhIpaXb/KLTbtE4+yI1x3HoNrLxQFWcFgZVYFV2DH0g9v3QU8uwJwxedmLeYXl0buP6HhsiyumNshHCLnjytPlId3y9r5fzKBJxud4guEGNi3qb+2x8gho7c7Wn4CCoxyX1bh/uWKj3Ify4jvDEqDQuPTp19Ap+NEqjaa3iU3TJuSrmeDWuXVgPLlnlc6e0V4fuzHjfSLD/ZObHoPdX0w8Xf+YEds522Gr3D92lpJeh0B5sg4xFk+XyswTHNAB2q4Rm13RCydtZkuIYWPO7rrYDkg==;5:yzVnGyj+pJWDKe3h6E77v+jmg7OCEyQIaJCo9Pa86EtRsUsDIjExe+tSb9Qg0iitO4l7ljsySgUTA0LPuGBrD1NSo/wLza6IX4YBF1lPkQ0Xbt46uCebZsrzdCN8IZgelGVkfL4EcrluAshlkxqxVRpaa2/MG8sAxHTgwAiwU+g=;24:kDNEiu7grMtFwLRuLKta90VLwOY6p0xtXo0wX68thuHDL4BIXNQ+Ld6mK0mtgcNn6mP9ZrqlyPv3UE/k0gWSS0RvVHgbAuQ4xxeV+wliluQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:UQz5d8uR2+FqCyYrpKmXkeS7U9mDZeECytCyx3hzLv44zRBi+2ZiOCENlasXHpC6UfxjyPR6z9jdKhWqXyezju+O/R7ooOsmW83+UtmxsbeJeSASRQMCWOnL2zwfCeXLvfWVcjWafqUkYMbDxhofF3uyzZ8yEsp2UWNYCIwwDO0CExkpP3opdzXO1+0WXMsC9IvdEWlsumQ968umL4QqhBkYcWKKaRjyp18GbhISLriDt440buLOXkQhaRBz+CzB;20:f8RazQMcLyRaUwJoB55+qn/qcBQf2JLIQLtYWcwYnzcEGujoSHeMgl49UkYwGmdin73Z4A1TqMB4r87bJiX452uIc07SU6t15EqMuFm/gZuninmqPasAJ/51CD2ZnmxLpzJBxAYpQVlP2azYoyeMrn4smi0/rGMuV1KVRbecwQr6L0adi9EMU2pmSr5V7+zcMx6KdetiIqWpuuUlSzlBZ+7No46Rn95mSrdFmCu8rqnYzBkKd0MX+z+O6PhW3Hpp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:17.8086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 699f2b3e-0454-476c-98b1-08d598ab6d3a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
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
https://lkml.kernel.org/r/20180324184940.19762-9-Yazen.Ghannam@amd.com

v3->v4:
* No changes.

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
index 356b8d326219..2531de49f56c 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -10,6 +10,7 @@
 #define VALID_LAPIC_ID			BIT_ULL(0)
 #define VALID_CPUID_INFO		BIT_ULL(1)
 #define VALID_PROC_ERR_INFO_NUM(bits)	(((bits) & GENMASK_ULL(7, 2)) >> 2)
+#define VALID_PROC_CXT_INFO_NUM(bits)	(((bits) & GENMASK_ULL(13, 8)) >> 8)
 
 #define INFO_ERR_STRUCT_TYPE_CACHE					\
 	GUID_INIT(0xA55701F5, 0xE3EF, 0x43DE, 0xAC, 0x72, 0x24, 0x9B,	\
@@ -71,6 +72,9 @@
 #define CHECK_MS_RESTARTABLE_IP		BIT_ULL(22)
 #define CHECK_MS_OVERFLOW		BIT_ULL(23)
 
+#define CTX_TYPE_MSR			1
+#define CTX_TYPE_MMREG			7
+
 enum err_types {
 	ERR_TYPE_CACHE = 0,
 	ERR_TYPE_TLB,
@@ -134,6 +138,17 @@ static const char * const ia_check_ms_error_type_strs[] = {
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
@@ -242,6 +257,7 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 {
 	int i;
 	struct cper_ia_err_info *err_info;
+	struct cper_ia_proc_ctx *ctx_info;
 	char newpfx[64], infopfx[64];
 	u8 err_type;
 
@@ -305,4 +321,36 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 
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
