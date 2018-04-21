Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDUHwb (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 03:52:31 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47827 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751366AbeDUHwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 03:52:30 -0400
Date: Sat, 21 Apr 2018 00:52:24 -0700
From: tip-bot for Andi Kleen <tipbot@zytor.com>
Message-ID: <tip-ccbb6afe0890b09cc828373a9a5fffab40ec85df@git.kernel.org>
Cc: ak@linux.intel.com, jolsa@kernel.org, tglx@linutronix.de,
        mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Reply-To: jolsa@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com,
        tglx@linutronix.de
In-Reply-To: <20180406203812.3087-5-andi@firstfloor.org>
References: <20180406203812.3087-5-andi@firstfloor.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf record: Remove suggestion to enable APIC
Git-Commit-ID: ccbb6afe0890b09cc828373a9a5fffab40ec85df
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

Commit-ID:  ccbb6afe0890b09cc828373a9a5fffab40ec85df
Gitweb:     https://git.kernel.org/tip/ccbb6afe0890b09cc828373a9a5fffab40ec85df
Author:     Andi Kleen <ak@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:38:12 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 18 Apr 2018 15:35:50 -0300

perf record: Remove suggestion to enable APIC

'perf record' suggests to enable the APIC on errors.

APIC is practically always used today and the problem is usually
somewhere else.

Just remove the outdated suggestion.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: http://lkml.kernel.org/r/20180406203812.3087-5-andi@firstfloor.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 66b62570c855..3e87486c28fe 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2870,8 +2870,7 @@ int perf_evsel__open_strerror(struct perf_evsel *evsel, struct target *target,
 #if defined(__i386__) || defined(__x86_64__)
 		if (evsel->attr.type == PERF_TYPE_HARDWARE)
 			return scnprintf(msg, size, "%s",
-	"No hardware sampling interrupt available.\n"
-	"No APIC? If so then you can boot the kernel with the \"lapic\" boot parameter to force-enable it.");
+	"No hardware sampling interrupt available.\n");
 #endif
 		break;
 	case EBUSY:
