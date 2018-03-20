Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCTGf0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:35:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50091 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbeCTGfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:35:21 -0400
Date: Mon, 19 Mar 2018 23:33:58 -0700
From: tip-bot for Yisheng Xie <tipbot@zytor.com>
Message-ID: <tip-a08f6dd4190e90dc7b013435acb66770f117e8b0@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, kan.liang@linux.intel.com, acme@redhat.com,
        xieyisheng1@huawei.com, peterz@infradead.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, jolsa@redhat.com, peterz@infradead.org,
        xieyisheng1@huawei.com, acme@redhat.com, kan.liang@linux.intel.com
In-Reply-To: <1520944274-37001-2-git-send-email-xieyisheng1@huawei.com>
References: <1520944274-37001-2-git-send-email-xieyisheng1@huawei.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf debug: Avoid setting 'quiet' to 'true'
 unnecessarily
Git-Commit-ID: a08f6dd4190e90dc7b013435acb66770f117e8b0
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

Commit-ID:  a08f6dd4190e90dc7b013435acb66770f117e8b0
Gitweb:     https://git.kernel.org/tip/a08f6dd4190e90dc7b013435acb66770f117e8b0
Author:     Yisheng Xie <xieyisheng1@huawei.com>
AuthorDate: Tue, 13 Mar 2018 20:31:14 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 16:39:02 -0300

perf debug: Avoid setting 'quiet' to 'true' unnecessarily

When using --quiet to disable messages, we will set the 'quiet' variable
to 'true' first, then check that variable to decide whether we need to
call perf_quiet_option(), so no need to set 'quiet' to 'true' once more
in perf_quiet_option().

Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1520944274-37001-2-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/debug.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/debug.c b/tools/perf/util/debug.c
index f3a71db83947..3d6459626c2a 100644
--- a/tools/perf/util/debug.c
+++ b/tools/perf/util/debug.c
@@ -232,7 +232,6 @@ int perf_quiet_option(void)
 		var++;
 	}
 
-	quiet = true;
 	return 0;
 }
 
