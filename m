Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753251AbeDUHwD (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:52:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbeDUHwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:52:02 -0400
Date: Sat, 21 Apr 2018 00:51:55 -0700
From: tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-ec3948451e0ba317e66873b48d6cc51d701d4eb0@git.kernel.org>
Cc: acme@redhat.com, jolsa@kernel.org, hpa@zytor.com, ak@linux.intel.com,
        mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de, ak@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20180406203812.3087-4-andi@firstfloor.org>
References: <20180406203812.3087-4-andi@firstfloor.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Remove misleading error suggestion
Git-Commit-ID: ec3948451e0ba317e66873b48d6cc51d701d4eb0
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

Commit-ID:  ec3948451e0ba317e66873b48d6cc51d701d4eb0
Gitweb:     https://git.kernel.org/tip/ec3948451e0ba317e66873b48d6cc51d701d4eb0
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:38:11 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:49 -0300

perf record: Remove misleading error suggestion

When perf record encounters an error setting up an event it suggests
to enable CONFIG_PERF_EVENTS. This is misleading because:

- Usually it is enabled (it is really hard to disable on x86)

- The problem is usually somewhere else, e.g. the CPU is not supported
or an invalid configuration has been used.

Remove the misleading suggestion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-4-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 1ac8d9236efd..66b62570c855 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2894,8 +2894,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
-	"/bin/dmesg may provide additional information.\n"
-	"No CONFIG_PERF_EVENTS=y kernel support configured?",
+	"/bin/dmesg | grep -i perf may provide additional information.\n",
 			 err, str_error_r(err, sbuf, sizeof(sbuf)),
 			 perf_evsel__name(evsel));
 }
