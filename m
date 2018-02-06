Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeBFL4v (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 06:56:51 -0500
Received: from terminus.zytor.com ([65.50.211.136]:41383 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFL4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 06:56:48 -0500
Date: Tue, 6 Feb 2018 03:52:59 -0800
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-0d8dd67be013727ae57645ecd3ea2c36365d7da8@git.kernel.org>
Cc: jolsa@redhat.com, peterz@infradead.org, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com, songliubraving@fb.com,
        rostedt@goodmis.org, namhyung@kernel.org, hpa@zytor.com,
        davem@davemloft.net, jbacik@fb.com, kernel-team@fb.com,
        torvalds@linux-foundation.org, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: rostedt@goodmis.org, daniel@iogearbox.net, songliubraving@fb.com,
        yhs@fb.com, ast@kernel.org, peterz@infradead.org, jolsa@redhat.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        acme@redhat.com, torvalds@linux-foundation.org, kernel-team@fb.com,
        davem@davemloft.net, hpa@zytor.com, jbacik@fb.com, namhyung@kernel.org
In-Reply-To: <20171206224518.3598254-5-songliubraving@fb.com>
References: <20171206224518.3598254-5-songliubraving@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/headers: Sync new perf_event.h with the
 tools/include/uapi version
Git-Commit-ID: 0d8dd67be013727ae57645ecd3ea2c36365d7da8
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

Commit-ID:  0d8dd67be013727ae57645ecd3ea2c36365d7da8
Gitweb:     https://git.kernel.org/tip/0d8dd67be013727ae57645ecd3ea2c36365d7da8
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Wed, 6 Dec 2017 14:45:14 -0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:18:05 +0100

perf/headers: Sync new perf_event.h with the tools/include/uapi version

perf_event.h is updated in previous patch, this patch applies the same
changes to the tools/ version. This is part is put in a separate
patch in case the two files are back ported separately.

Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Yonghong Song <yhs@fb.com>
Reviewed-by: Josef Bacik <jbacik@fb.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: <daniel@iogearbox.net>
Cc: <davem@davemloft.net>
Cc: <kernel-team@fb.com>
Cc: <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20171206224518.3598254-5-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index c77c9a2..5d49cfc 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -380,10 +380,14 @@ struct perf_event_attr {
 	__u32			bp_type;
 	union {
 		__u64		bp_addr;
+		__u64		kprobe_func; /* for perf_kprobe */
+		__u64		uprobe_path; /* for perf_uprobe */
 		__u64		config1; /* extension of config */
 	};
 	union {
 		__u64		bp_len;
+		__u64		kprobe_addr; /* when kprobe_func == NULL */
+		__u64		probe_offset; /* for perf_[k,u]probe */
 		__u64		config2; /* extension of config1 */
 	};
 	__u64	branch_sample_type; /* enum perf_branch_sample_type */
