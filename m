Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeEBRwg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 13:52:36 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34837 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750947AbeEBRwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 13:52:33 -0400
Date: Wed, 2 May 2018 10:52:23 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-eya0jvmu26qvro0nxxd49xia@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, hpa@zytor.com, wangnan0@huawei.com,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        acme@redhat.com
Reply-To: namhyung@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        tglx@linutronix.de, jolsa@kernel.org, mingo@kernel.org,
        adrian.hunter@intel.com, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf ui stdio: Use map_groups__fprintf()
Git-Commit-ID: b0867f0c624ca48886ae5bbe0574dbc3eef8c694
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

Commit-ID:  b0867f0c624ca48886ae5bbe0574dbc3eef8c694
Gitweb:     https://git.kernel.org/tip/b0867f0c624ca48886ae5bbe0574dbc3eef8c694
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Wed, 25 Apr 2018 12:52:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 26 Apr 2018 13:47:13 -0300

perf ui stdio: Use map_groups__fprintf()

Instead of the variant that allows asking for just a specific map_type,
because that map_type split will go away.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-eya0jvmu26qvro0nxxd49xia@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/stdio/hist.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/ui/stdio/hist.c b/tools/perf/ui/stdio/hist.c
index 6832fcb2e6ff..c1eb476da91b 100644
--- a/tools/perf/ui/stdio/hist.c
+++ b/tools/perf/ui/stdio/hist.c
@@ -819,8 +819,7 @@ size_t hists__fprintf(struct hists *hists, bool show_header, int max_rows,
 		}
 
 		if (h->ms.map == NULL && verbose > 1) {
-			__map_groups__fprintf_maps(h->thread->mg,
-						   MAP__FUNCTION, fp);
+			map_groups__fprintf(h->thread->mg, fp);
 			fprintf(fp, "%.10s end\n", graph_dotted_line);
 		}
 	}
