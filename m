Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752798AbeBTQEF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:04:05 -0500
Received: from mga18.intel.com ([134.134.136.126]:7632 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752410AbeBTQED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:04:03 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="scan'208";a="205573633"
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v4 2/2] x86/platform/intel-mid: Add special handling of ACPI HW reduced platforms
Date: Tue, 20 Feb 2018 18:03:58 +0200
Message-Id: <20180220160358.68832-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180220160358.68832-1-andriy.shevchenko@linux.intel.com>
References: <20180220160358.68832-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When switching to ACPI HW reduced platforms we still want to initialize timers.
Override x86_init.acpi.reduced_hw_init to achieve that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/platform/intel-mid/intel-mid.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 2c67bae6bb53..c556f1e8936e 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -199,6 +199,12 @@ void __init x86_intel_mid_early_setup(void)
 
 	legacy_pic = &null_legacy_pic;
 
+	/*
+	 * Do nothing for now as everything needed done in
+	 * x86_intel_mid_early_setup() below.
+	 */
+	x86_init.acpi.reduced_hw_early_init = x86_init_noop;
+
 	pm_power_off = intel_mid_power_off;
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
-- 
2.15.1
