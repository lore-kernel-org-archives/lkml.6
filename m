Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752432AbeBEVha (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 16:37:30 -0500
Received: from terminus.zytor.com ([65.50.211.136]:50875 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752088AbeBEVhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 16:37:18 -0500
Date: Mon, 5 Feb 2018 13:35:06 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-8rododhs87x8hv9k83qcdtne@git.kernel.org>
Cc: adrian.hunter@intel.com, acme@redhat.com, dsahern@gmail.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, juri.lelli@gmail.com,
        wangnan0@huawei.com, namhyung@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, hpa@zytor.com
Reply-To: juri.lelli@gmail.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        jolsa@kernel.org, tglx@linutronix.de, wangnan0@huawei.com,
        namhyung@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com,
        acme@redhat.com, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] tools headers: Synchronize uapi/linux/sched.h
Git-Commit-ID: 7a16c7e15f4a3859ca9933d124cdabe51940eb5c
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

Commit-ID:  7a16c7e15f4a3859ca9933d124cdabe51940eb5c
Gitweb:     https://git.kernel.org/tip/7a16c7e15f4a3859ca9933d124cdabe51940eb5c
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 2 Feb 2018 17:14:53 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 2 Feb 2018 17:17:13 -0300

tools headers: Synchronize uapi/linux/sched.h

To get the tools copy updated with the changes in 34be39305a77
("sched/deadline: Implement "runtime overrun signal" support"), that
cause no effect on the tools, will be used when we start copying the
sched_attr struct argument to the sched_get/setattr syscalls.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Juri Lelli <juri.lelli@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8rododhs87x8hv9k83qcdtne@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/sched.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 30a9e51..22627f8 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -49,5 +49,10 @@
  */
 #define SCHED_FLAG_RESET_ON_FORK	0x01
 #define SCHED_FLAG_RECLAIM		0x02
+#define SCHED_FLAG_DL_OVERRUN		0x04
+
+#define SCHED_FLAG_ALL	(SCHED_FLAG_RESET_ON_FORK	| \
+			 SCHED_FLAG_RECLAIM		| \
+			 SCHED_FLAG_DL_OVERRUN)
 
 #endif /* _UAPI_LINUX_SCHED_H */
