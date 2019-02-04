Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C241C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB93E2073D
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 20:44:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729983AbfBDUoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:44:11 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49381 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbfBDUoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 15:44:10 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x14KhYRB563328
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 4 Feb 2019 12:43:34 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x14KhX9f563325;
        Mon, 4 Feb 2019 12:43:34 -0800
Date:   Mon, 4 Feb 2019 12:43:34 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Yazen Ghannam <tipbot@zytor.com>
Message-ID: <tip-3ad7e748c12cc771df6020a552def3e1727e8a17@git.kernel.org>
Cc:     puwen@hygon.cn, keescook@chromium.org, linux-edac@vger.kernel.org,
        x86@kernel.org, Shirish.S@amd.com, mingo@kernel.org, hpa@zytor.com,
        bp@suse.de, qiuxu.zhuo@intel.com, vishal.l.verma@intel.com,
        yazen.ghannam@amd.com, tony.luck@intel.com, tglx@linutronix.de,
        mingo@redhat.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        mchehab@kernel.org
Reply-To: bp@suse.de, qiuxu.zhuo@intel.com, hpa@zytor.com,
          Shirish.S@amd.com, x86@kernel.org, mingo@kernel.org,
          keescook@chromium.org, linux-edac@vger.kernel.org,
          puwen@hygon.cn, arnd@arndb.de, linux-kernel@vger.kernel.org,
          mchehab@kernel.org, vishal.l.verma@intel.com,
          yazen.ghannam@amd.com, tglx@linutronix.de, mingo@redhat.com,
          tony.luck@intel.com
In-Reply-To: <20190201225534.8177-3-Yazen.Ghannam@amd.com>
References: <20190201225534.8177-3-Yazen.Ghannam@amd.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:ras/core] x86/MCE/AMD, EDAC/mce_amd: Add new McaTypes for CS,
 PSP, and SMU units
Git-Commit-ID: 3ad7e748c12cc771df6020a552def3e1727e8a17
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3ad7e748c12cc771df6020a552def3e1727e8a17
Gitweb:     https://git.kernel.org/tip/3ad7e748c12cc771df6020a552def3e1727e8a17
Author:     Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate: Fri, 1 Feb 2019 22:55:52 +0000
Committer:  Borislav Petkov <bp@suse.de>
CommitDate: Sun, 3 Feb 2019 13:01:57 +0100

x86/MCE/AMD, EDAC/mce_amd: Add new McaTypes for CS, PSP, and SMU units

The existing CS, PSP, and SMU SMCA bank types will see new versions (as
indicated by their McaTypes) in future SMCA systems.

Add the new (HWID, MCATYPE) tuples for these new versions. Reuse the
same names as the older versions, since they are logically the same to
the user. SMCA systems won't mix and match IP blocks with different
McaType versions in the same system, so there isn't a need to
distinguish them. The MCA_IPID register is saved when logging an MCA
error, and that can be used to triage the error.

Also, add the new error descriptions to edac_mce_amd. Some error types
(positions in the list) are overloaded compared to the previous
McaTypes. Therefore, just create new lists of the error descriptions to
keep things simple even if some of the error descriptions are the same
between versions.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: linux-edac <linux-edac@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Pu Wen <puwen@hygon.cn>
Cc: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Cc: Shirish S <Shirish.S@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: x86-ml <x86@kernel.org>
Link: https://lkml.kernel.org/r/20190201225534.8177-3-Yazen.Ghannam@amd.com
---
 arch/x86/include/asm/mce.h    |  3 +++
 arch/x86/kernel/cpu/mce/amd.c |  6 +++++
 drivers/edac/mce_amd.c        | 55 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 91b65d859ca8..299a38536567 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -307,11 +307,14 @@ enum smca_bank_types {
 	SMCA_FP,	/* Floating Point */
 	SMCA_L3_CACHE,	/* L3 Cache */
 	SMCA_CS,	/* Coherent Slave */
+	SMCA_CS_V2,	/* Coherent Slave */
 	SMCA_PIE,	/* Power, Interrupts, etc. */
 	SMCA_UMC,	/* Unified Memory Controller */
 	SMCA_PB,	/* Parameter Block */
 	SMCA_PSP,	/* Platform Security Processor */
+	SMCA_PSP_V2,	/* Platform Security Processor */
 	SMCA_SMU,	/* System Management Unit */
+	SMCA_SMU_V2,	/* System Management Unit */
 	SMCA_MP5,	/* Microprocessor 5 Unit */
 	SMCA_NBIO,	/* Northbridge IO Unit */
 	SMCA_PCIE,	/* PCI Express Unit */
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 00f60b8c7e4f..bd1331b241ca 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -88,11 +88,14 @@ static struct smca_bank_name smca_names[] = {
 	[SMCA_FP]	= { "floating_point",	"Floating Point Unit" },
 	[SMCA_L3_CACHE]	= { "l3_cache",		"L3 Cache" },
 	[SMCA_CS]	= { "coherent_slave",	"Coherent Slave" },
+	[SMCA_CS_V2]	= { "coherent_slave",	"Coherent Slave" },
 	[SMCA_PIE]	= { "pie",		"Power, Interrupts, etc." },
 	[SMCA_UMC]	= { "umc",		"Unified Memory Controller" },
 	[SMCA_PB]	= { "param_block",	"Parameter Block" },
 	[SMCA_PSP]	= { "psp",		"Platform Security Processor" },
+	[SMCA_PSP_V2]	= { "psp",		"Platform Security Processor" },
 	[SMCA_SMU]	= { "smu",		"System Management Unit" },
+	[SMCA_SMU_V2]	= { "smu",		"System Management Unit" },
 	[SMCA_MP5]	= { "mp5",		"Microprocessor 5 Unit" },
 	[SMCA_NBIO]	= { "nbio",		"Northbridge IO Unit" },
 	[SMCA_PCIE]	= { "pcie",		"PCI Express Unit" },
@@ -153,6 +156,7 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 	/* Data Fabric MCA types */
 	{ SMCA_CS,	 HWID_MCATYPE(0x2E, 0x0), 0x1FF },
 	{ SMCA_PIE,	 HWID_MCATYPE(0x2E, 0x1), 0xF },
+	{ SMCA_CS_V2,	 HWID_MCATYPE(0x2E, 0x2), 0x3FFF },
 
 	/* Unified Memory Controller MCA type */
 	{ SMCA_UMC,	 HWID_MCATYPE(0x96, 0x0), 0x3F },
@@ -162,9 +166,11 @@ static struct smca_hwid smca_hwid_mcatypes[] = {
 
 	/* Platform Security Processor MCA type */
 	{ SMCA_PSP,	 HWID_MCATYPE(0xFF, 0x0), 0x1 },
+	{ SMCA_PSP_V2,	 HWID_MCATYPE(0xFF, 0x1), 0x3FFFF },
 
 	/* System Management Unit MCA type */
 	{ SMCA_SMU,	 HWID_MCATYPE(0x01, 0x0), 0x1 },
+	{ SMCA_SMU_V2,	 HWID_MCATYPE(0x01, 0x1), 0x7FF },
 
 	/* Microprocessor 5 Unit MCA type */
 	{ SMCA_MP5,	 HWID_MCATYPE(0x01, 0x2), 0x3FF },
diff --git a/drivers/edac/mce_amd.c b/drivers/edac/mce_amd.c
index 5ab4ab3f0ce6..184c90172d17 100644
--- a/drivers/edac/mce_amd.c
+++ b/drivers/edac/mce_amd.c
@@ -257,6 +257,23 @@ static const char * const smca_cs_mce_desc[] = {
 	"ECC error on probe filter access",
 };
 
+static const char * const smca_cs2_mce_desc[] = {
+	"Illegal Request",
+	"Address Violation",
+	"Security Violation",
+	"Illegal Response",
+	"Unexpected Response",
+	"Request or Probe Parity Error",
+	"Read Response Parity Error",
+	"Atomic Request Parity Error",
+	"SDP read response had no match in the CS queue",
+	"Probe Filter Protocol Error",
+	"Probe Filter ECC Error",
+	"SDP read response had an unexpected RETRY error",
+	"Counter overflow error",
+	"Counter underflow error",
+};
+
 static const char * const smca_pie_mce_desc[] = {
 	"HW assert",
 	"Internal PIE register security violation",
@@ -281,10 +298,45 @@ static const char * const smca_psp_mce_desc[] = {
 	"PSP RAM ECC or parity error",
 };
 
+static const char * const smca_psp2_mce_desc[] = {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Instruction Cache Bank 0 ECC or parity error",
+	"Instruction Cache Bank 1 ECC or parity error",
+	"Instruction Tag Ram 0 parity error",
+	"Instruction Tag Ram 1 parity error",
+	"Data Cache Bank 0 ECC or parity error",
+	"Data Cache Bank 1 ECC or parity error",
+	"Data Cache Bank 2 ECC or parity error",
+	"Data Cache Bank 3 ECC or parity error",
+	"Data Tag Bank 0 parity error",
+	"Data Tag Bank 1 parity error",
+	"Data Tag Bank 2 parity error",
+	"Data Tag Bank 3 parity error",
+	"Dirty Data Ram parity error",
+	"TLB Bank 0 parity error",
+	"TLB Bank 1 parity error",
+	"System Hub Read Buffer ECC or parity error",
+};
+
 static const char * const smca_smu_mce_desc[] = {
 	"SMU RAM ECC or parity error",
 };
 
+static const char * const smca_smu2_mce_desc[] = {
+	"High SRAM ECC or parity error",
+	"Low SRAM ECC or parity error",
+	"Data Cache Bank A ECC or parity error",
+	"Data Cache Bank B ECC or parity error",
+	"Data Tag Cache Bank A ECC or parity error",
+	"Data Tag Cache Bank B ECC or parity error",
+	"Instruction Cache Bank A ECC or parity error",
+	"Instruction Cache Bank B ECC or parity error",
+	"Instruction Tag Cache Bank A ECC or parity error",
+	"Instruction Tag Cache Bank B ECC or parity error",
+	"System Hub Read Buffer ECC or parity error",
+};
+
 static const char * const smca_mp5_mce_desc[] = {
 	"High SRAM ECC or parity error",
 	"Low SRAM ECC or parity error",
@@ -328,11 +380,14 @@ static struct smca_mce_desc smca_mce_descs[] = {
 	[SMCA_FP]	= { smca_fp_mce_desc,	ARRAY_SIZE(smca_fp_mce_desc)	},
 	[SMCA_L3_CACHE]	= { smca_l3_mce_desc,	ARRAY_SIZE(smca_l3_mce_desc)	},
 	[SMCA_CS]	= { smca_cs_mce_desc,	ARRAY_SIZE(smca_cs_mce_desc)	},
+	[SMCA_CS_V2]	= { smca_cs2_mce_desc,	ARRAY_SIZE(smca_cs2_mce_desc)	},
 	[SMCA_PIE]	= { smca_pie_mce_desc,	ARRAY_SIZE(smca_pie_mce_desc)	},
 	[SMCA_UMC]	= { smca_umc_mce_desc,	ARRAY_SIZE(smca_umc_mce_desc)	},
 	[SMCA_PB]	= { smca_pb_mce_desc,	ARRAY_SIZE(smca_pb_mce_desc)	},
 	[SMCA_PSP]	= { smca_psp_mce_desc,	ARRAY_SIZE(smca_psp_mce_desc)	},
+	[SMCA_PSP_V2]	= { smca_psp2_mce_desc,	ARRAY_SIZE(smca_psp2_mce_desc)	},
 	[SMCA_SMU]	= { smca_smu_mce_desc,	ARRAY_SIZE(smca_smu_mce_desc)	},
+	[SMCA_SMU_V2]	= { smca_smu2_mce_desc,	ARRAY_SIZE(smca_smu2_mce_desc)	},
 	[SMCA_MP5]	= { smca_mp5_mce_desc,	ARRAY_SIZE(smca_mp5_mce_desc)	},
 	[SMCA_NBIO]	= { smca_nbio_mce_desc,	ARRAY_SIZE(smca_nbio_mce_desc)	},
 	[SMCA_PCIE]	= { smca_pcie_mce_desc,	ARRAY_SIZE(smca_pcie_mce_desc)	},
