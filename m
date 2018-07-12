Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E27C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 184CF208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:02:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 184CF208E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeGLOMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:12:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59019 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727497AbeGLOMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:12:17 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE1vpn3934762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:01:57 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE1v0L3934758;
        Thu, 12 Jul 2018 07:01:57 -0700
Date:   Thu, 12 Jul 2018 07:01:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-f6432b9f65001651412dbc3589d251534822d4ab@git.kernel.org>
Cc:     namhyung@kernel.org, acme@redhat.com, kim.phillips@arm.com,
        jolsa@redhat.com, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        brueckner@linux.vnet.ibm.com, mpetlan@redhat.com,
        tmricht@linux.vnet.ibm.com, hpa@zytor.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        sandipan@linux.vnet.ibm.com
Reply-To: kim.phillips@arm.com, acme@redhat.com, namhyung@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          jolsa@redhat.com, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, hpa@zytor.com,
          tmricht@linux.vnet.ibm.com, mpetlan@redhat.com,
          brueckner@linux.vnet.ibm.com, sandipan@linux.vnet.ibm.com,
          mingo@kernel.org
In-Reply-To: <20180629124652.8d0af7e2281fd3fd8262cacc@arm.com>
References: <20180629124652.8d0af7e2281fd3fd8262cacc@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf llvm-utils: Remove bashism from kernel
 include fetch script
Git-Commit-ID: f6432b9f65001651412dbc3589d251534822d4ab
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

Commit-ID:  f6432b9f65001651412dbc3589d251534822d4ab
Gitweb:     https://git.kernel.org/tip/f6432b9f65001651412dbc3589d251534822d4ab
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 29 Jun 2018 12:46:52 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:51 -0300

perf llvm-utils: Remove bashism from kernel include fetch script

Like system(), popen() calls /bin/sh, which may/may not be bash.

Script when run on dash and encounters the line, yields:

 exit: Illegal number: -1

checkbashisms report on script content:

 possible bashism (exit|return with negative status code):
 exit -1

Remove the bashism and use the more portable non-zero failure
status code 1.

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124652.8d0af7e2281fd3fd8262cacc@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/llvm-utils.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/llvm-utils.c b/tools/perf/util/llvm-utils.c
index 976e658e38dc..5e94857dfca2 100644
--- a/tools/perf/util/llvm-utils.c
+++ b/tools/perf/util/llvm-utils.c
@@ -266,16 +266,16 @@ static const char *kinc_fetch_script =
 "#!/usr/bin/env sh\n"
 "if ! test -d \"$KBUILD_DIR\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "if ! test -f \"$KBUILD_DIR/include/generated/autoconf.h\"\n"
 "then\n"
-"	exit -1\n"
+"	exit 1\n"
 "fi\n"
 "TMPDIR=`mktemp -d`\n"
 "if test -z \"$TMPDIR\"\n"
 "then\n"
-"    exit -1\n"
+"    exit 1\n"
 "fi\n"
 "cat << EOF > $TMPDIR/Makefile\n"
 "obj-y := dummy.o\n"
