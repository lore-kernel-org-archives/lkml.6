Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932218AbeCDJIa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 04:08:30 -0500
Received: from terminus.zytor.com ([198.137.202.136]:34911 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932101AbeCDJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 04:08:25 -0500
Date: Sun, 4 Mar 2018 01:07:15 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-317660940fd9dddd3201c2f92e25c27902c753fa@git.kernel.org>
Cc: peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, torvalds@linux-foundation.org,
        vincent.weaver@maine.edu, acme@redhat.com, kan.liang@linux.intel.com,
        tglx@linutronix.de, eranian@google.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, hpa@zytor.com
Reply-To: torvalds@linux-foundation.org, jolsa@redhat.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        acme@redhat.com, vincent.weaver@maine.edu, eranian@google.com,
        kan.liang@linux.intel.com, tglx@linutronix.de, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1520004150-4855-1-git-send-email-kan.liang@linux.intel.com>
References: <1520004150-4855-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Fix Skylake UPI event
 format
Git-Commit-ID: 317660940fd9dddd3201c2f92e25c27902c753fa
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

Commit-ID:  317660940fd9dddd3201c2f92e25c27902c753fa
Gitweb:     https://git.kernel.org/tip/317660940fd9dddd3201c2f92e25c27902c753fa
Author:     Kan Liang <kan.liang@linux.intel.com>
AuthorDate: Fri, 2 Mar 2018 07:22:30 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 4 Mar 2018 09:59:00 +0100

perf/x86/intel/uncore: Fix Skylake UPI event format

There is no event extension (bit 21) for SKX UPI, so
use 'event' instead of 'event_ext'.

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Link: http://lkml.kernel.org/r/1520004150-4855-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 6d8044ab1060..22ec65bc033a 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3606,7 +3606,7 @@ static struct intel_uncore_type skx_uncore_imc = {
 };
 
 static struct attribute *skx_upi_uncore_formats_attr[] = {
-	&format_attr_event_ext.attr,
+	&format_attr_event.attr,
 	&format_attr_umask_ext.attr,
 	&format_attr_edge.attr,
 	&format_attr_inv.attr,
