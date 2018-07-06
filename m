Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80ECFC3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5223FF6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FB5223FF6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932338AbeGFI3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:29:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40086 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932168AbeGFI31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:29:27 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w668TAEu049680
        for <linux-kernel@vger.kernel.org>; Fri, 6 Jul 2018 04:29:26 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2k24u688hf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 04:29:26 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <aneesh.kumar@linux.ibm.com>;
        Fri, 6 Jul 2018 04:29:25 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Jul 2018 04:29:22 -0400
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w668TL8U9699724
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 6 Jul 2018 08:29:21 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 36FEF112065;
        Fri,  6 Jul 2018 04:29:13 -0400 (EDT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C81C112063;
        Fri,  6 Jul 2018 04:29:11 -0400 (EDT)
Received: from skywalker.in.ibm.com (unknown [9.124.31.51])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Fri,  6 Jul 2018 04:29:11 -0400 (EDT)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     akpm@linux-foundation.org, Dan Williams <dan.j.williams@intel.com>,
        Oliver <oohall@gmail.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [RFC PATCH 1/2] mm/nvidmm: Drop x86 dependency on nvdimm e820 device
Date:   Fri,  6 Jul 2018 13:59:10 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 18070608-0052-0000-0000-00000309FD48
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009318; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01057295; UDB=6.00542444; IPR=6.00835215;
 MB=3.00022021; MTD=3.00000008; XFM=3.00000015; UTC=2018-07-06 08:29:24
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18070608-0053-0000-0000-00005D43791C
Message-Id: <20180706082911.13405-1-aneesh.kumar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-06_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1807060094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds new Kconfig variable PMEM_PLATFORM_DEVICE and use that to select
the nvdimm e820 device. The x86 config is now named X86_PMEM_LEGACY_DEVICE.

Not-Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/x86/Kconfig                  | 5 +----
 arch/x86/include/asm/e820/types.h | 2 +-
 arch/x86/include/uapi/asm/e820.h  | 2 +-
 drivers/nvdimm/Kconfig            | 5 ++++-
 drivers/nvdimm/Makefile           | 2 +-
 tools/testing/nvdimm/Kbuild       | 2 +-
 6 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f1dbb4ee19d7..1186e1330876 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1641,13 +1641,10 @@ config ILLEGAL_POINTER_VALUE
 source "mm/Kconfig"
 
 config X86_PMEM_LEGACY_DEVICE
-	bool
-
-config X86_PMEM_LEGACY
 	tristate "Support non-standard NVDIMMs and ADR protected memory"
 	depends on PHYS_ADDR_T_64BIT
 	depends on BLK_DEV
-	select X86_PMEM_LEGACY_DEVICE
+	select PMEM_PLATFORM_DEVICE
 	select LIBNVDIMM
 	help
 	  Treat memory marked using the non-standard e820 type of 12 as used
diff --git a/arch/x86/include/asm/e820/types.h b/arch/x86/include/asm/e820/types.h
index c3aa4b5e49e2..0fb25d04dd26 100644
--- a/arch/x86/include/asm/e820/types.h
+++ b/arch/x86/include/asm/e820/types.h
@@ -20,7 +20,7 @@ enum e820_type {
 	 * NVDIMM regions that persist over a reboot.
 	 *
 	 * The kernel will ignore their special capabilities
-	 * unless the CONFIG_X86_PMEM_LEGACY=y option is set.
+	 * unless the CONFIG_X86_PMEM_LEGACY_DEVICE=y option is set.
 	 *
 	 * ( Note that older platforms also used 6 for the same
 	 *   type of memory, but newer versions switched to 12 as
diff --git a/arch/x86/include/uapi/asm/e820.h b/arch/x86/include/uapi/asm/e820.h
index 2f491efe3a12..b8ae7c221269 100644
--- a/arch/x86/include/uapi/asm/e820.h
+++ b/arch/x86/include/uapi/asm/e820.h
@@ -38,7 +38,7 @@
 /*
  * This is a non-standardized way to represent ADR or NVDIMM regions that
  * persist over a reboot.  The kernel will ignore their special capabilities
- * unless the CONFIG_X86_PMEM_LEGACY option is set.
+ * unless the CONFIG_X86_PMEM_LEGACY_DEVICE option is set.
  *
  * ( Note that older platforms also used 6 for the same type of memory,
  *   but newer versions switched to 12 as 6 was assigned differently.  Some
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 9d36473dc2a2..50d2a33de441 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -27,7 +27,7 @@ config BLK_DEV_PMEM
 	  Memory ranges for PMEM are described by either an NFIT
 	  (NVDIMM Firmware Interface Table, see CONFIG_NFIT_ACPI), a
 	  non-standard OEM-specific E820 memory type (type-12, see
-	  CONFIG_X86_PMEM_LEGACY), or it is manually specified by the
+	  CONFIG_X86_PMEM_LEGACY_DEVICE), or it is manually specified by the
 	  'memmap=nn[KMG]!ss[KMG]' kernel command line (see
 	  Documentation/admin-guide/kernel-parameters.rst).  This driver converts
 	  these persistent memory ranges into block devices that are
@@ -112,4 +112,7 @@ config OF_PMEM
 
 	  Select Y if unsure.
 
+config PMEM_PLATFORM_DEVICE
+       bool
+
 endif
diff --git a/drivers/nvdimm/Makefile b/drivers/nvdimm/Makefile
index e8847045dac0..94f7f29146ce 100644
--- a/drivers/nvdimm/Makefile
+++ b/drivers/nvdimm/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
 obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
 obj-$(CONFIG_ND_BTT) += nd_btt.o
 obj-$(CONFIG_ND_BLK) += nd_blk.o
-obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
+obj-$(CONFIG_PMEM_PLATFORM_DEVICE) += nd_e820.o
 obj-$(CONFIG_OF_PMEM) += of_pmem.o
 
 nd_pmem-y := pmem.o
diff --git a/tools/testing/nvdimm/Kbuild b/tools/testing/nvdimm/Kbuild
index 0392153a0009..82e84253a6ae 100644
--- a/tools/testing/nvdimm/Kbuild
+++ b/tools/testing/nvdimm/Kbuild
@@ -27,7 +27,7 @@ obj-$(CONFIG_LIBNVDIMM) += libnvdimm.o
 obj-$(CONFIG_BLK_DEV_PMEM) += nd_pmem.o
 obj-$(CONFIG_ND_BTT) += nd_btt.o
 obj-$(CONFIG_ND_BLK) += nd_blk.o
-obj-$(CONFIG_X86_PMEM_LEGACY) += nd_e820.o
+obj-$(CONFIG_PMEM_PLATFORM_DEVICE) += nd_e820.o
 obj-$(CONFIG_ACPI_NFIT) += nfit.o
 ifeq ($(CONFIG_DAX),m)
 obj-$(CONFIG_DAX) += dax.o
-- 
2.17.1

