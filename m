Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbeBUK07 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 05:26:59 -0500
Received: from terminus.zytor.com ([198.137.202.136]:42795 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932807AbeBUK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 05:26:56 -0500
Date: Wed, 21 Feb 2018 02:26:38 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-c2ynv0ozr3eifzsyit6qgh3h@git.kernel.org>
Cc: mingo@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
        dsahern@gmail.com, jskarvad@redhat.com, hpa@zytor.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Reply-To: wangnan0@huawei.com, jolsa@kernel.org, namhyung@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, mingo@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jskarvad@redhat.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf python: Make twatch.py work with both python2
 and python3
Git-Commit-ID: d2ed5d2bdc5cd30b44dc52c44c63f08c0a31b845
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

Commit-ID:  d2ed5d2bdc5cd30b44dc52c44c63f08c0a31b845
Gitweb:     https://git.kernel.org/tip/d2ed5d2bdc5cd30b44dc52c44c63f08c0a31b845
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 19 Feb 2018 12:24:13 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 19 Feb 2018 12:28:08 -0300

perf python: Make twatch.py work with both python2 and python3

Will be used to test patches allowing to build perf with python3, so
that we make sure that we can build with both versions.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jaroslav Škarvada <jskarvad@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-c2ynv0ozr3eifzsyit6qgh3h@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/python/twatch.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/python/twatch.py b/tools/perf/python/twatch.py
index c235c22..0a29c5c 100755
--- a/tools/perf/python/twatch.py
+++ b/tools/perf/python/twatch.py
@@ -42,10 +42,10 @@ def main(context_switch = 0, thread = -1):
 			event = evlist.read_on_cpu(cpu)
 			if not event:
 				continue
-			print "cpu: %2d, pid: %4d, tid: %4d" % (event.sample_cpu,
-								event.sample_pid,
-								event.sample_tid),
-			print event
+			print("cpu: {0}, pid: {1}, tid: {2} {3}".format(event.sample_cpu,
+                                                                        event.sample_pid,
+                                                                        event.sample_tid,
+                                                                        event))
 
 if __name__ == '__main__':
     """
