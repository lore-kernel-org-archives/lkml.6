Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752599AbeBEVlb (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:41:31 -0500
Received: from terminus.zytor.com ([65.50.211.136]:49521 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbeBEVlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:41:16 -0500
Date: Mon, 5 Feb 2018 13:36:52 -0800
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-11974914e8e6d44387b4b23fa6dbd40c94baeb8d@git.kernel.org>
Cc: jolsa@kernel.org, kan.liang@intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, alexander.shishkin@linux.intel.com,
        peterz@infradead.org, dsahern@gmail.com, acme@redhat.com,
        eranian@google.com, namhyung@kernel.org
Reply-To: ak@linux.intel.com, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, kan.liang@intel.com,
        jolsa@kernel.org, namhyung@kernel.org, eranian@google.com,
        acme@redhat.com, dsahern@gmail.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com
In-Reply-To: <20180201083812.11359-4-jolsa@kernel.org>
References: <20180201083812.11359-4-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into
 PEBS_FREERUNNING_FLAGS
Git-Commit-ID: 11974914e8e6d44387b4b23fa6dbd40c94baeb8d
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

Commit-ID:  11974914e8e6d44387b4b23fa6dbd40c94baeb8d
Gitweb:     https://git.kernel.org/tip/11974914e8e6d44387b4b23fa6dbd40c94baeb8d
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Thu, 1 Feb 2018 09:38:12 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Feb 2018 13:48:44 -0300

x86/events/intel/ds: Add PERF_SAMPLE_PERIOD into PEBS_FREERUNNING_FLAGS

Stephane reported that we don't support period for enabling large PEBS
data, which there's no reason for. Adding PERF_SAMPLE_PERIOD into
freerunning flags.

Tested it with:

  # perf record -e cycles:P -c 100 --no-timestamp -C 0 --period

Reported-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Kan Liang <kan.liang@intel.com>
Tested-by: Stephane Eranian <eranian@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180201083812.11359-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 8e4ea143..78f91ec 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -93,7 +93,8 @@ struct amd_nb {
 	PERF_SAMPLE_ID | PERF_SAMPLE_CPU | PERF_SAMPLE_STREAM_ID | \
 	PERF_SAMPLE_DATA_SRC | PERF_SAMPLE_IDENTIFIER | \
 	PERF_SAMPLE_TRANSACTION | PERF_SAMPLE_PHYS_ADDR | \
-	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER)
+	PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER | \
+	PERF_SAMPLE_PERIOD)
 
 #define PEBS_REGS \
 	(PERF_REG_X86_AX | \
