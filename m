Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751452AbeBUBfR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 20:35:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751376AbeBUBex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 20:34:53 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8D3621785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Jaroslav=20=C5=A0karvada?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 4/5] perf python: Make twatch.py work with both python2 and python3
Date: Tue, 20 Feb 2018 22:34:30 -0300
Message-Id: <20180221013431.11738-5-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180221013431.11738-1-acme@kernel.org>
References: <20180221013431.11738-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
index c235c22b107a..0a29c5c3079f 100755
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
-- 
2.14.3
