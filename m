Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752431AbeAaGZm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 01:25:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:44964 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751772AbeAaGZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 01:25:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,438,1511856000";
   d="scan'208";a="14347578"
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
To: platform-driver-x86@vger.kernel.org
Cc: dvhart@infradead.org, andy@infradead.org, linux-kernel@vger.kernel.org,
        vishwanath.somayaji@intel.com,
        Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Subject: [PATCH] platform/x86: intel_pmc_core: Remove unused header file
Date: Wed, 31 Jan 2018 11:50:22 +0530
Message-Id: <1517379622-1142-1-git-send-email-rajneesh.bhardwaj@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently sent patch 'platform/x86: intel_pmc_core: Remove unused EXPORTED
API' missed to remove the header file 'arch/x86/include/asm/pmc_core.h'
which was solely used to declare the EXPORTED API
'intel_pmc_slp_s0_counter_read'. This patch provides the errata fix for the
same.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
---
 arch/x86/include/asm/pmc_core.h       | 27 ---------------------------
 drivers/platform/x86/intel_pmc_core.c |  1 -
 2 files changed, 28 deletions(-)
 delete mode 100644 arch/x86/include/asm/pmc_core.h

diff --git a/arch/x86/include/asm/pmc_core.h b/arch/x86/include/asm/pmc_core.h
deleted file mode 100644
index d4855f11136d..000000000000
--- a/arch/x86/include/asm/pmc_core.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Intel Core SoC Power Management Controller Header File
- *
- * Copyright (c) 2016, Intel Corporation.
- * All Rights Reserved.
- *
- * Authors: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
- *          Vishwanath Somayaji <vishwanath.somayaji@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- */
-
-#ifndef _ASM_PMC_CORE_H
-#define _ASM_PMC_CORE_H
-
-/* API to read SLP_S0_RESIDENCY counter */
-int intel_pmc_slp_s0_counter_read(u32 *data);
-
-#endif /* _ASM_PMC_CORE_H */
diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
index 67e85ee4ab32..180c65fed55a 100644
--- a/drivers/platform/x86/intel_pmc_core.c
+++ b/drivers/platform/x86/intel_pmc_core.c
@@ -30,7 +30,6 @@
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
-#include <asm/pmc_core.h>
 
 #include "intel_pmc_core.h"
 
-- 
2.7.4
