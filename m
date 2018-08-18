Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DECC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292DC218F9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:57:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 292DC218F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbeHRPEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 11:04:37 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55109 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHRPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 11:04:37 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBukjc1291361
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:56:46 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBukxE1291358;
        Sat, 18 Aug 2018 04:56:46 -0700
Date:   Sat, 18 Aug 2018 04:56:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-7ea6e983b2cce9a4277ea602c2976d18bd75a908@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        dsahern@gmail.com, linux-kernel@vger.kernel.org, jolsa@kernel.org,
        alexander.kapshuk@gmail.com, hpa@zytor.com, peterz@infradead.org,
        mpe@ellerman.id.au
Reply-To: peterz@infradead.org, mpe@ellerman.id.au, jolsa@kernel.org,
          hpa@zytor.com, alexander.kapshuk@gmail.com,
          linux-kernel@vger.kernel.org, dsahern@gmail.com,
          mingo@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, acme@redhat.com
In-Reply-To: <20180814072726.GA13931@krava>
References: <20180813111504.3568-1-jolsa@kernel.org>
        <20180814072726.GA13931@krava>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Make check-headers.sh check based on
 kernel dir
Git-Commit-ID: 7ea6e983b2cce9a4277ea602c2976d18bd75a908
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7ea6e983b2cce9a4277ea602c2976d18bd75a908
Gitweb:     https://git.kernel.org/tip/7ea6e983b2cce9a4277ea602c2976d18bd75a908
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Mon, 13 Aug 2018 13:15:03 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 14 Aug 2018 15:08:33 -0300

perf tools: Make check-headers.sh check based on kernel dir

Changing the logic to compare files with paths relative to kernel source
base dir. This way we can keep the output message for 2 unrelated files,
which is coming in following patch.

Committer testing:

Remove a line from tools/arch/x86/lib/memcpy_64.S to have it detected:

make: Entering directory '/home/acme/git/perf/tools/perf'
  BUILD:   Doing 'make -j4' parallel build
Warning: Kernel ABI header at 'tools/arch/x86/lib/memcpy_64.S' differs from latest version at 'arch/x86/lib/memcpy_64.S'
diff -u tools/arch/x86/lib/memcpy_64.S arch/x86/lib/memcpy_64.S
  INSTALL  GTK UI
  INSTALL  binaries

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180813111504.3568-1-jolsa@kernel.org
Link: http://lkml.kernel.org/r/20180814072726.GA13931@krava
[ Do not use pushd/popd, its a bashism, reported by Michael Ellerman, fixed by Jiri Olsa ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/check-headers.sh | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index ea48aa6f8d19..b61f8a4dfca3 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -69,8 +69,8 @@ check_2 () {
 
   test -f $file2 && {
     eval $cmd || {
-      echo "Warning: Kernel ABI header at 'tools/$file' differs from latest version at '$file'" >&2
-      echo diff -u tools/$file $file
+      echo "Warning: Kernel ABI header at '$file1' differs from latest version at '$file2'" >&2
+      echo diff -u $file1 $file2
     }
   }
 }
@@ -80,7 +80,7 @@ check () {
 
   shift
 
-  check_2 ../$file ../../$file $*
+  check_2 tools/$file $file $*
 }
 
 # Check if we have the kernel headers (tools/perf/../../include), else
@@ -88,6 +88,8 @@ check () {
 # differences.
 test -d ../../include || exit 0
 
+cd ../..
+
 # simple diff check
 for i in $HEADERS; do
   check $i -B
@@ -98,3 +100,5 @@ check arch/x86/lib/memcpy_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/ex
 check arch/x86/lib/memset_64.S        '-I "^EXPORT_SYMBOL" -I "^#include <asm/export.h>"'
 check include/uapi/asm-generic/mman.h '-I "^#include <\(uapi/\)*asm-generic/mman-common.h>"'
 check include/uapi/linux/mman.h       '-I "^#include <\(uapi/\)*asm/mman.h>"'
+
+cd tools/perf
