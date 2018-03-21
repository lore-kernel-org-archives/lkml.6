Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeCUOFT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:05:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751856AbeCUOFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:05:18 -0400
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH] perf check-headers.sh: Fix check-headers.sh opts assignment
Date: Wed, 21 Mar 2018 15:05:15 +0100
Message-Id: <20180321140515.2252-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently opts variable is not zero-ed and we keep
on adding to it, ending up with:

  $ check-headers.sh 2>&1
  + opts=' "-B"'
  + opts=' "-B" "-B"'
  + opts=' "-B" "-B" "-B"'
  + opts=' "-B" "-B" "-B" "-B"'
  + opts=' "-B" "-B" "-B" "-B" "-B"'
  + opts=' "-B" "-B" "-B" "-B" "-B" "-B"'

Fixing this by initializing the opts variable.

Link: http://lkml.kernel.org/n/tip-chyv198z0tc2knnm2zdn4ms1@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/check-headers.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index bf206ffe5c45..9aff89bc7535 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -59,6 +59,7 @@ check () {
   file=$1
 
   shift
+  opts=
   while [ -n "$*" ]; do
     opts="$opts \"$1\""
     shift
-- 
2.13.6
