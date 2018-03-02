Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1427455AbeCBPXl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 10:23:41 -0500
Received: from mga02.intel.com ([134.134.136.20]:63442 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1427201AbeCBPXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 10:23:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,412,1515484800";
   d="scan'208";a="21585475"
From: kan.liang@linux.intel.com
To: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org
Cc: ak@linux.intel.com, eranian@google.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] perf/x86/intel/uncore: Fix Skylake UPI event format
Date: Fri,  2 Mar 2018 07:22:30 -0800
Message-Id: <1520004150-4855-1-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

There is no event extension (bit 21) for SKX UPI.

Using event instead of event_ext.

Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 5be5e15..8ff1aac 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3618,7 +3618,7 @@ static struct intel_uncore_type skx_uncore_imc = {
 };
 
 static struct attribute *skx_upi_uncore_formats_attr[] = {
-	&format_attr_event_ext.attr,
+	&format_attr_event.attr,
 	&format_attr_umask_ext.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
-- 
2.7.4
