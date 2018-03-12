Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932487AbeCLPmi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:42:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:43880 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932440AbeCLPmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:42:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,461,1515484800";
   d="scan'208";a="207483919"
From: Kan Liang <kan.liang@linux.intel.com>
To: peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org
Cc: eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/uncore: Add missing filter constraint for SKX CHA event
Date: Mon, 12 Mar 2018 08:41:34 -0700
Message-Id: <1520869294-14176-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephane Eranian <eranian@google.com>

Adding a filter constraint for Intel Skylake CHA event
UNC_CHA_UPI_CREDITS_ACQUIRED (0x38).
The event supports core-id/thread-id and link filtering.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 8ff1aac..d4672ed 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3355,6 +3355,7 @@ static struct extra_reg skx_uncore_cha_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(0x9134, 0xffff, 0x4),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x35, 0xff, 0x8),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x36, 0xff, 0x8),
+	SNBEP_CBO_EVENT_EXTRA_REG(0x38, 0xff, 0x3),
 	EVENT_EXTRA_END
 };
 
-- 
2.7.4
