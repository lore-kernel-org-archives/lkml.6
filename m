Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeCIOhs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:37:48 -0500
Received: from 123-192-241-158.dynamic.kbronet.com.tw ([123.192.241.158]:45038
        "EHLO E6440" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751147AbeCIOhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:37:47 -0500
From: Harry Pan <harry.pan@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: gs0622@gmail.com, Harry Pan <harry.pan@intel.com>, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        kan.liang@linux.intel.com, vincent.weaver@maine.edu,
        peterz@infradead.org, colin.king@canonical.com
Subject: [PATCH 2/3] perf/x86/intel: Add Cannon Lake support of RAPL profiling
Date: Fri,  9 Mar 2018 20:15:47 +0800
Message-Id: <20180309121549.630-2-harry.pan@intel.com>
X-Mailer: git-send-email 2.13.5
In-Reply-To: <20180309121549.630-1-harry.pan@intel.com>
References: <20180309121549.630-1-harry.pan@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables RAPL counters (energy consumption counters)
support for Cannon Lake processors.

ESU and power domains refer to Intel Software Developers' Manual,
Vol. 4, Order No. 335592.

Usage example:

$ perf list
$ perf stat -a -e power/energy-cores/,power/energy-pkg/ sleep 10

Signed-off-by: Harry Pan <harry.pan@intel.com>
---
 arch/x86/events/intel/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index a2efb490f743..32f3e9423e99 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -774,6 +774,8 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_MOBILE,  skl_rapl_init),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_KABYLAKE_DESKTOP, skl_rapl_init),
 
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_CANNONLAKE_MOBILE,  skl_rapl_init),
+
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_GOLDMONT, hsw_rapl_init),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_ATOM_DENVERTON, hsw_rapl_init),
 
-- 
2.13.5
