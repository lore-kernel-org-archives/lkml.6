Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932759AbeBPJvV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 04:51:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58777 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932716AbeBPJvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 04:51:05 -0500
Date: Fri, 16 Feb 2018 01:35:22 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-f92c8cbe597a5a2ccec702dff824f3fe0f3623eb@git.kernel.org>
Cc: peterz@infradead.org, mingo@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, yao.jin@linux.intel.com,
        ak@linux.intel.com, jolsa@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, acme@redhat.com, namhyung@kernel.org,
        tglx@linutronix.de
Reply-To: mingo@kernel.org, kan.liang@intel.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, wangnan0@huawei.com, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, namhyung@kernel.org,
        ak@linux.intel.com, yao.jin@linux.intel.com, jolsa@kernel.org
In-Reply-To: <1516310792-208685-4-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-4-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf mmap: Cleanup perf_mmap__push()
Git-Commit-ID: f92c8cbe597a5a2ccec702dff824f3fe0f3623eb
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

Commit-ID:  f92c8cbe597a5a2ccec702dff824f3fe0f3623eb
Gitweb:     https://git.kernel.org/tip/f92c8cbe597a5a2ccec702dff824f3fe0f3623eb
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:18 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Feb 2018 09:52:05 -0300

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
