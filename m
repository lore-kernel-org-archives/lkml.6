Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935142AbeBMMPn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:15:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58177 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:15:40 -0500
Date: Tue, 13 Feb 2018 04:05:13 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-0ecec70a6aae6fc128549b28b33da7f7f82b45bd@git.kernel.org>
Cc: ak@linux.intel.com, yao.jin@linux.intel.com, wangnan0@huawei.com,
        jolsa@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, namhyung@kernel.org, kan.liang@intel.com,
        mingo@kernel.org, peterz@infradead.org, hpa@zytor.com
Reply-To: namhyung@kernel.org, tglx@linutronix.de, kan.liang@intel.com,
        hpa@zytor.com, peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
        wangnan0@huawei.com, jolsa@kernel.org, ak@linux.intel.com
In-Reply-To: <1516310792-208685-4-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-4-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Cleanup perf_mmap__push()
Git-Commit-ID: 0ecec70a6aae6fc128549b28b33da7f7f82b45bd
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

Commit-ID:  0ecec70a6aae6fc128549b28b33da7f7f82b45bd
Gitweb:     https://git.kernel.org/tip/0ecec70a6aae6fc128549b28b33da7f7f82b45bd
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:18 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:49 -0300

perf mmap: Cleanup perf_mmap__push()

The first assignment for 'start' and 'end' is redundant.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-4-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 97cf4fa..fbbbe87 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -272,7 +272,7 @@ int perf_mmap__push(struct perf_mmap *md, bool overwrite,
 {
 	u64 head = perf_mmap__read_head(md);
 	u64 old = md->prev;
-	u64 end = head, start = old;
+	u64 end, start;
 	unsigned char *data = md->base + page_size;
 	unsigned long size;
 	void *buf;
