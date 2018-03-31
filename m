Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753440AbeCaKUm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:20:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38429 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752962AbeCaKUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:20:40 -0400
Date: Sat, 31 Mar 2018 03:19:05 -0700
From: tip-bot for Harry Pan <tipbot@zytor.com>
Message-ID: <tip-490d03e83da2a5e9d7db84b1ec30a9c95415787e@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, vincent.weaver@maine.edu,
        torvalds@linux-foundation.org, harry.pan@intel.com,
        bleung@chromium.org, hpa@zytor.com, jolsa@redhat.com,
        puthik@chromium.org, acme@redhat.com, tglx@linutronix.de,
        eranian@google.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org
Reply-To: torvalds@linux-foundation.org, harry.pan@intel.com,
        bleung@chromium.org, vincent.weaver@maine.edu, mingo@kernel.org,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, eranian@google.com,
        tglx@linutronix.de, acme@redhat.com, puthik@chromium.org,
        jolsa@redhat.com, hpa@zytor.com
In-Reply-To: <20180309121549.630-2-harry.pan@intel.com>
References: <20180309121549.630-2-harry.pan@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/x86/intel: Add Cannon Lake support for RAPL
 profiling
Git-Commit-ID: 490d03e83da2a5e9d7db84b1ec30a9c95415787e
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

Commit-ID:  490d03e83da2a5e9d7db84b1ec30a9c95415787e
Gitweb:     https://git.kernel.org/tip/490d03e83da2a5e9d7db84b1ec30a9c95415787e
Author:     Harry Pan <harry.pan@intel.com>
AuthorDate: Fri, 9 Mar 2018 20:15:47 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sat, 31 Mar 2018 11:28:36 +0200

perf/x86/intel: Add Cannon Lake support for RAPL profiling

This patch enables RAPL counters (energy consumption counters)
support for Cannon Lake processors.

( ESU and power domains refer to Intel Software Developers' Manual,
  Vol. 4, Order No. 335592. )

Usage example:

  $ perf list
  $ perf stat -a -e power/energy-cores/,power/energy-pkg/ sleep 10

Tested-by: Puthikorn Voravootivat <puthik@chromium.org>
Signed-off-by: Harry Pan <harry.pan@intel.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: colin.king@canonical.com
Cc: gs0622@gmail.com
Cc: kan.liang@linux.intel.com
Link: http://lkml.kernel.org/r/20180309121549.630-2-harry.pan@intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
 
