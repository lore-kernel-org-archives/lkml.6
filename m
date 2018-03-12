Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932322AbeCLM1E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 08:27:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:45873 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751401AbeCLM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 08:27:00 -0400
Date: Mon, 12 Mar 2018 05:26:38 -0700
From: tip-bot for Andy Shevchenko <tipbot@zytor.com>
Message-ID: <tip-02428742639bc3300c8c527b054d0ec0bdf5571d@git.kernel.org>
Cc: peterz@infradead.org, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, jgross@suse.com,
        torvalds@linux-foundation.org, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mingo@kernel.org, ebiederm@xmission.com
Reply-To: tglx@linutronix.de, hpa@zytor.com, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, jgross@suse.com,
        peterz@infradead.org, andriy.shevchenko@linux.intel.com,
        rafael.j.wysocki@intel.com, torvalds@linux-foundation.org
In-Reply-To: <20180220180506.65523-3-andriy.shevchenko@linux.intel.com>
References: <20180220180506.65523-3-andriy.shevchenko@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] x86/platform/intel-mid: Add special handling for ACPI
 HW reduced platforms
Git-Commit-ID: 02428742639bc3300c8c527b054d0ec0bdf5571d
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  02428742639bc3300c8c527b054d0ec0bdf5571d
Gitweb:     https://git.kernel.org/tip/02428742639bc3300c8c527b054d0ec0bdf5571d
Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate: Tue, 20 Feb 2018 20:05:06 +0200
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 12:32:57 +0100

x86/platform/intel-mid: Add special handling for ACPI HW reduced platforms

When switching to ACPI HW reduced platforms we still want to initialize timers.
Override x86_init.acpi.reduced_hw_init to achieve that.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-acpi@vger.kernel.org
Link: http://lkml.kernel.org/r/20180220180506.65523-3-andriy.shevchenko@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 
