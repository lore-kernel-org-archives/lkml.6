Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752587AbeDBPH0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 11:07:26 -0400
Received: from mail-co1nam03on0040.outbound.protection.outlook.com ([104.47.40.40]:48864
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752472AbeDBPHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 11:07:16 -0400
From: Yazen Ghannam <Yazen.Ghannam@amd.com>
To: linux-efi@vger.kernel.org
Cc: Yazen Ghannam <Yazen.Ghannam@amd.com>, linux-kernel@vger.kernel.org,
        ard.biesheuvel@linaro.org, bp@suse.de, x86@kernel.org,
        tony.luck@intel.com
Subject: [PATCH v4 2/8] efi: Decode IA32/X64 Processor Error Section
Date: Mon,  2 Apr 2018 10:06:50 -0500
Message-Id: <20180402150656.101022-3-Yazen.Ghannam@amd.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
References: <20180402150656.101022-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN7PR10CA0030.namprd10.prod.outlook.com (20.176.16.43) To
 BN6PR12MB1905.namprd12.prod.outlook.com (10.175.102.11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08a2be6e-e36e-4d62-f71f-08d598ab6a6e
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR12MB1905;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;3:hNC7TpjeF3czrzRQ44urWj6gfhZbxkFt30mb5h5Rq5ZEihO/ogBAtlNDad77IroN9JnOtFwx1wIBRu3CXXFFKQEwow5+d3xemy9hsx33yKwk30xDsTSaEBCmxp24Wle1C4hGI875mAszsnD4bMSc1yElnrs5VtEQg1zPemlLanPPTQGCkKOiRfF+lRynicGi3/n8aWTFLiDqYJAY5ok1h3F/m89MyftFDMswxwmme414CaqeQRHN1d1St0k02aQB;25:2JeItTlnJJtp1S5BejYxd54okB0HUfE4r1iK+u5lBtJ545YrAdBWzkh8bZCCHP2UqlnTgFBocwSnqltMh89ql2EJ81Fq9+PdXsJahzimtoL9LJT5xJD2DV3i1+qGxHbkkQy1RdWJ0OkFcQ6chE94n+JLoOdCRm0BgSSCYldnoe6QOrUGauWM6r1DL6omsrB/5n1MQsyL97EkflVpklH5K5PPZhvsd+XD5xf508GyyefcwwVFy2uYysRlbSzhwfncC0gs6HEgvTFIrR0wlaKg2FQtQjbT8TSdqxZPvaWPQS+ap25IcdnLxlSXkeIhuULRn8YhUv+LuPbUHTY01Ip+Rg==;31:w07Tdq77YaYfiq+1iZcpPyHEHxqxYZplNQp+V8XAxENHnzlYEDGgwQJIm+pHbrdkWoCgtY43pSfiIYoEcHNPU58vRh1CQUt7pULSOU+bGD/m8SoJHXO9uYYkMguAwt3ooiTSCi1+WwqPjaJpxLT/BV6fmVWujRk3C/XV9L2dltbs7AgiDG10ssqswMpxEOkgSO/k0DIGiw9++tOsRaaop8xaQu5ebMeV/1/QRSzw84w=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1905:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yazen.Ghannam@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;20:0u+2PdhuFtNc5cuGQ1ekVISrVSQRSNqJyaRWL1VPtAHuDbk3Cg0jVHKhtQrr3V8HoXYH48C11dT2Vx7UZdinKkmn98zfiDJhcufBjrkwyy0DZOJZbnSjLjAhu9Q2bsrZJ2u8B2oZiTIALBvxBI/eZVxgOIyu7VkYhjMrDTZYYe+Tr1po/UbEJOXo+AQNnSQCY/RgElLe+2jeFaJg98deGAGQRtXanQDYI6naz33tOYyoABIdbXcKRvMKNc4ABR6fBpiGuRkRdA61oRPuNanvcj3ZYUe1BGgqI5m0Ql2ZWa16oy9/9WN/1PnlQeMnmFi62drTg7/e+5B4iXtzJUWPZ/1dJ9ck29xlZIVloNKxow4b+eG5sOmMfqEnM+l/ByA+Kfxb1YbCs0Z1li4Xzzt9Maod7oCFcodY84/QaHUJ2+CGQoHMfUJj92hlSw9LggBrd3zgcCnfO8vhE0IWg5GY7+smbiDFpOFE9uUkK4S7HuYDnl5vkqdmSXD1Z+FOGlPq;4:4nj3Lyh/MC4DiD0Vfs4gP3GQ7f/y2KnBLASfzlHLNmku05tP5AcMM4CveRFewQG/rG9U/4vDhwhE1c1o4UMr87eLPYlJpI2LpmLZ1NIPb+5I9iKN0tVVn2IUNH04RM4cYi/GXJvU/gsz+zUW8n+dXUTqLfReKXQ+3tdvHKkUh6hfkkcTIjUX/eXjpzClUiNxS2i+FnqjOBwemk62HmKnBG3xgFUNeTmDP7UpxxQMBwP8tKDmiiryc1twmVBP889qfZHBZFGJqU5l2YfCRaTmZu1mpi1oti8G01Un605NSIPENO0Ck29hnzBs6BCY32yhlde4tZr2vB1/49ERrs0Vf4kVsyfJUJu3YXjsoV71nxo=
X-Microsoft-Antispam-PRVS: <BN6PR12MB19059AC7D935E5E2B986FC4EF8A60@BN6PR12MB1905.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(42068640409301);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR12MB1905;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1905;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(366004)(39380400002)(39860400002)(396003)(199004)(189003)(2351001)(97736004)(86362001)(575784001)(105586002)(25786009)(26005)(6666003)(6486002)(8676002)(5660300001)(106356001)(50226002)(8936002)(2906002)(16526019)(81156014)(81166006)(2361001)(50466002)(11346002)(6306002)(66066001)(53936002)(386003)(48376002)(1076002)(446003)(6916009)(6116002)(52116002)(68736007)(4326008)(36756003)(3846002)(7736002)(76176011)(316002)(966005)(51416003)(305945005)(7696005)(47776003)(2616005)(478600001)(956004)(16586007)(186003)(53416004)(72206003)(486005)(486005)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1905;H:yaz-diesel.amd.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR12MB1905;23:0DPOYuwbkyKe5X30S2e1plfAoOUiM/LnPcvW9g/Vg?=
 =?us-ascii?Q?YujPNQw6Z42JKZIFNSSJTCwM0imyNx//QlMbTvWSp0j/3eKF3Dp9r5r+4gVB?=
 =?us-ascii?Q?TZq4Rp4UbEY7PLPyGuIXnaRRANuuA5K5L5MuPVO6Hm+snMgGAIo/3ha4u1cH?=
 =?us-ascii?Q?YR4ePjpJrmI2VLTwBEkF4p9IPkMt61l27SVunPm0Y2LrQlO8YdmI4P0xp83B?=
 =?us-ascii?Q?f795Lp3eu6zzQ35osT9/Kus0uHfkFH3at9VH2V1mPc2A0HaS9oAwXwUahPTu?=
 =?us-ascii?Q?0mCvHsxJGY9uNhn6iNIId7vzk+H2g10IWhtayVcDps6TjQH39t4ZqGmu7PVD?=
 =?us-ascii?Q?HVrKtYwBsuzJ7eJOAwLyl0WqPUvCLVim69zhwtofTgghMHVshQpqFTi5V+8C?=
 =?us-ascii?Q?tSuadCCCAznf5luJLw+86Gh0Vhw2g5iqI7pABcWqahmzT0qTqjtcMPQxu9bK?=
 =?us-ascii?Q?RU38gFVCWDl/xFdpmxeObQm2almIzL9enBLLAzxtAc72Izi2kBe666LYl5/y?=
 =?us-ascii?Q?+NSKKZd3Uyf0nAefpvO3+0iygm4er9rTcAKykUkF3VcNdw99rROHO42r7nVo?=
 =?us-ascii?Q?tYE4FALdWH1ou+0NpfTD0ES7Far4xiaHcGFyn+qfvHFhLPhkIhsnIKwr9D8t?=
 =?us-ascii?Q?vkR89zb3ImRU38eNstIBes6vKAsgB1dpIBJwMoIeACVhzOPEU5mrAr+IkD/d?=
 =?us-ascii?Q?fhepOYryYzQL4ZFXwQRqVb5m1yEE8lNYwlfDQlkeCle1hKKpBA9k3n7IacBL?=
 =?us-ascii?Q?thnvFhRXAWHMovzscElMfWFSGKYfdU7jPR1ueNVysL6We2HUJpzjTrbbrPp1?=
 =?us-ascii?Q?Ta0160gdZTXT6Wlw5/0NQJYG51eTzeA3ze6Trt+bZZUqJ6wTACPotD7+/0DG?=
 =?us-ascii?Q?4GialBdBneuEa2tPLOGezdrXeV/DjLarhsQRc9SuXwEBBTYom6v5R36IPH8q?=
 =?us-ascii?Q?AAJ0jEJrG0LcZN1aY5c+Z4KtSvYFibbKv/YpkSNFmys2YGN0e92MeXzzdv3W?=
 =?us-ascii?Q?X4nj0G9AQ1jtLKRx3lZKlOopisprknkMltMEOID3gsSO9vgLs4Yl2bTJScuT?=
 =?us-ascii?Q?T8BL6hEEDzRtilXN/n5hBJ6+tVVFa+EdvUbEhtVUv56wSF8fr8ut/856zdu4?=
 =?us-ascii?Q?XE0XECVHw1hpsT6BVwTTx7mvrhfUsQzry7fe6XlWnhbTv0Ng9EV3e9QoI2Lz?=
 =?us-ascii?Q?pn/9IkzQsxtOlb/KX7GJGnJjINK+/ZPd0no1IokakDLRpRpV2QFuHPVVXbVL?=
 =?us-ascii?Q?i+KGS5L/I+e4/VJ1iEWUPr3Rf1gGQba8ZnOoYoZsNuvogkeMXVsaHmxBcenR?=
 =?us-ascii?Q?p6uPpJtq62YZ896df0dcnLC6tvcnfwf8iykRF383PPk?=
X-Microsoft-Antispam-Message-Info: DCe6Y4eQOFu+pu29JhX4XNnNmL74HYvvRaZvnnWqTY3gt6wBV0y/Ezg/Z3a1Vuk7fuT1OsE7DQNNIX8nEUty6B+cboEIJfNL/2CkkG0EWmzlHdtejKif8/QMwxDmVteZMwyxzV+3tCsfDMnR/dUhjHfWLX7CWbF8SkqihBH45d6P/NCEqD8rqaL+Q9cwELqn
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;6:srXgxh8mKX5mJRcISM1Hknu2X1oTttbO0byKk3D3LzbY68c1hBfDD2i1vPge3227zUxHrUz8wh/Sl3JHaXaGR1w0a8K0WLw7XbXQ3rwM/2pgxjNJ6vSiDLdfAtVKcd2RqxAU25Kn9J33qkpfLnfwRhqlekDwdtpYaecVXzJkhYu/0T+dkPfm8OS7yvjL3z3mlRRAF/wiZrHWWdbT9cR8OxRFBTkczH+7n5ZhLozGRizJNY0b9B4Pm5RMGQ7T7VZAjkNnWUmeom3j9f4OY9EbpOSxLcxh7n3ajEmMVq79yg8WPaHdA3bH7ZwY+IOTc6J5ToomUX5bzWL2OEpeP/LY0UI8Q9s9rWT64NNQxouD0w916o9HhyeZj8x4voWMuvDeTE8f1wTtDzLIfZU6K6RHmHe7LmUO+mvSSC/uCJW+/forNrUvLJQkTG4TqZTxEdDYcvmoZcxHMG1LeWij9iThcA==;5:wkYQuleJwuIqMlV/jNnvVsJ6Fh6pwj+CQ7CHQIHgSXeYMWLncYZhMLfhqcy2mGWKnNMKJNpeVVycN+0V8XWwwrM9LHXSWKXei9KK017rvdHBKRsdNRAuuct6hwKTOEl3T2i5nI86Z1EL+9+e4queBEQNOifKqMnCWuBGO9K/Asg=;24:AFGKMjQpZ/hv+VxaQGl2CUH9rSCtFwOYy2OQdEGMmCXu0W6I0I47Z86NNn7RlPXRefsYiei2Vb9jbFopo7WBBjNKvjL9L/Pp5QD7Ti+g3dI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1905;7:BQ5DeiM31xN6+EBoZ0qxgGk2xsQFjjMCDF7n/JRNPBkWE9vvVaf+3s8N0J2itW6HbWN78KH4Oay7cmFIfJ/pjY02YUnO8fifzkt0McAlMqaOghPc88xiqXYohX1MwMfRY56jwDvsmrN6boimYnMIgM0/mdxt/dzVwpeqSnWAe74QYH+notSJqjJxQu/cJFvAkNf/5ZWNEVy0pyTui0Tq8rgI+byyMnM4o7ah317ld/pzgt1Mb0YRHOuOgEfl9b+s;20:vDyXgjLKiLHj84rRQY2e9U69hjvkaLQRaOaC2IThqUqi3z2mjbNGORc8AyilX5pc4ps7uINcrP5P3yNXtvxhjfRZspCgvorULkRTG0lFGVVSEwpvkPuUAifmWGIhulGYHYAe/Gnxaz7RWC0UPUcoUJvxl1Hi0WPzQFIvAaq3e6vfo6Yc9I0qgV96AZcQCiPa0o82Kh4QnIOxOB5MGI0jKDJC4vtzOFrfF80/GxsrGCiQtQCk9Y2WXefI03cnOkxc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 15:07:13.1186 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a2be6e-e36e-4d62-f71f-08d598ab6a6e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1905
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yazen Ghannam <yazen.ghannam@amd.com>

Recognize the IA32/X64 Processor Error Section.

Do the section decoding in a new "cper-x86.c" file and add this to the
Makefile depending on a new "UEFI_CPER_X86" config option.

Print the Local APIC ID and CPUID info from the Processor Error Record.

The "Processor Error Info" and "Processor Context" fields will be
decoded in following patches.

Based on UEFI 2.7 Table 252. Processor Error Record.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/20180324184940.19762-3-Yazen.Ghannam@amd.com

v3->v4:
* No changes.

v2->v3:
* Fix table number in commit message.
* Don't print raw validation bits.

v1->v2:
* Change config option depends to "X86" instead of "X86_32 || X64_64".
* Remove extra newline in Makefile changes.
* Drop author copyright line.

 drivers/firmware/efi/Kconfig    |  5 +++++
 drivers/firmware/efi/Makefile   |  1 +
 drivers/firmware/efi/cper-x86.c | 23 +++++++++++++++++++++++
 drivers/firmware/efi/cper.c     | 10 ++++++++++
 include/linux/cper.h            |  2 ++
 5 files changed, 41 insertions(+)
 create mode 100644 drivers/firmware/efi/cper-x86.c

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 3098410abad8..781a4a337557 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -174,6 +174,11 @@ config UEFI_CPER_ARM
 	depends on UEFI_CPER && ( ARM || ARM64 )
 	default y
 
+config UEFI_CPER_X86
+	bool
+	depends on UEFI_CPER && X86
+	default y
+
 config EFI_DEV_PATH_PARSER
 	bool
 	depends on ACPI
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index cb805374f4bc..5f9f5039de50 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -31,3 +31,4 @@ obj-$(CONFIG_ARM)			+= $(arm-obj-y)
 obj-$(CONFIG_ARM64)			+= $(arm-obj-y)
 obj-$(CONFIG_EFI_CAPSULE_LOADER)	+= capsule-loader.o
 obj-$(CONFIG_UEFI_CPER_ARM)		+= cper-arm.o
+obj-$(CONFIG_UEFI_CPER_X86)		+= cper-x86.o
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
new file mode 100644
index 000000000000..863f0cd2a0ff
--- /dev/null
+++ b/drivers/firmware/efi/cper-x86.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018, Advanced Micro Devices, Inc.
+
+#include <linux/cper.h>
+
+/*
+ * We don't need a "CPER_IA" prefix since these are all locally defined.
+ * This will save us a lot of line space.
+ */
+#define VALID_LAPIC_ID			BIT_ULL(0)
+#define VALID_CPUID_INFO		BIT_ULL(1)
+
+void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
+{
+	if (proc->validation_bits & VALID_LAPIC_ID)
+		printk("%sLocal APIC_ID: 0x%llx\n", pfx, proc->lapic_id);
+
+	if (proc->validation_bits & VALID_CPUID_INFO) {
+		printk("%sCPUID Info:\n", pfx);
+		print_hex_dump(pfx, "", DUMP_PREFIX_OFFSET, 16, 4, proc->cpuid,
+			       sizeof(proc->cpuid), 0);
+	}
+}
diff --git a/drivers/firmware/efi/cper.c b/drivers/firmware/efi/cper.c
index c165933ebf38..5a59b582c9aa 100644
--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -469,6 +469,16 @@ cper_estatus_print_section(const char *pfx, struct acpi_hest_generic_data *gdata
 			cper_print_proc_arm(newpfx, arm_err);
 		else
 			goto err_section_too_small;
+#endif
+#if defined(CONFIG_UEFI_CPER_X86)
+	} else if (guid_equal(sec_type, &CPER_SEC_PROC_IA)) {
+		struct cper_sec_proc_ia *ia_err = acpi_hest_get_payload(gdata);
+
+		printk("%ssection_type: IA32/X64 processor error\n", newpfx);
+		if (gdata->error_data_length >= sizeof(*ia_err))
+			cper_print_proc_ia(newpfx, ia_err);
+		else
+			goto err_section_too_small;
 #endif
 	} else {
 		const void *err = acpi_hest_get_payload(gdata);
diff --git a/include/linux/cper.h b/include/linux/cper.h
index 4b5f8459b403..9c703a0abe6e 100644
--- a/include/linux/cper.h
+++ b/include/linux/cper.h
@@ -551,5 +551,7 @@ const char *cper_mem_err_unpack(struct trace_seq *,
 				struct cper_mem_err_compact *);
 void cper_print_proc_arm(const char *pfx,
 			 const struct cper_sec_proc_arm *proc);
+void cper_print_proc_ia(const char *pfx,
+			const struct cper_sec_proc_ia *proc);
 
 #endif
-- 
2.14.1
