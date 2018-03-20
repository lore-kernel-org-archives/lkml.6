Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeCTLQc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:16:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49195 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751913AbeCTLQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:16:28 -0400
Date: Tue, 20 Mar 2018 04:16:06 -0700
From: tip-bot for Stephane Eranian <tipbot@zytor.com>
Message-ID: <tip-e340895c9ed0b44548f08bbaaee4afc7bfacd354@git.kernel.org>
Cc: alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        peterz@infradead.org, eranian@google.com, tglx@linutronix.de,
        vincent.weaver@maine.edu, linux-kernel@vger.kernel.org,
        jolsa@redhat.com, mingo@kernel.org, kan.liang@linux.intel.com,
        torvalds@linux-foundation.org
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com, acme@redhat.com,
        eranian@google.com, peterz@infradead.org, tglx@linutronix.de,
        vincent.weaver@maine.edu, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        kan.liang@linux.intel.com, torvalds@linux-foundation.org
In-Reply-To: <1520869294-14176-1-git-send-email-kan.liang@linux.intel.com>
References: <1520869294-14176-1-git-send-email-kan.liang@linux.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/x86/intel/uncore: Add missing filter
 constraint for SKX CHA event
Git-Commit-ID: e340895c9ed0b44548f08bbaaee4afc7bfacd354
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

Commit-ID:  e340895c9ed0b44548f08bbaaee4afc7bfacd354
Gitweb:     https://git.kernel.org/tip/e340895c9ed0b44548f08bbaaee4afc7bfacd354
Author:     Stephane Eranian <eranian@google.com>
AuthorDate: Mon, 12 Mar 2018 08:41:34 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:53:32 +0100

perf/x86/intel/uncore: Add missing filter constraint for SKX CHA event

Adding a filter constraint for Intel Skylake CHA event
UNC_CHA_UPI_CREDITS_ACQUIRED (0x38).

The event supports core-id/thread-id and link filtering.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/1520869294-14176-1-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index 22ec65bc033a..0876798f2ac9 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3343,6 +3343,7 @@ static struct extra_reg skx_uncore_cha_extra_regs[] = {
 	SNBEP_CBO_EVENT_EXTRA_REG(0x9134, 0xffff, 0x4),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x35, 0xff, 0x8),
 	SNBEP_CBO_EVENT_EXTRA_REG(0x36, 0xff, 0x8),
+	SNBEP_CBO_EVENT_EXTRA_REG(0x38, 0xff, 0x3),
 	EVENT_EXTRA_END
 };
 
