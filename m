Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379D6C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D5721479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 14:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5D5721479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732662AbeGLOMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 10:12:41 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33147 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeGLOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 10:12:40 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6CE2RBW3934846
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Jul 2018 07:02:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6CE2RjJ3934843;
        Thu, 12 Jul 2018 07:02:27 -0700
Date:   Thu, 12 Jul 2018 07:02:27 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Kim Phillips <tipbot@zytor.com>
Message-ID: <tip-db8fec583f250557ddd6def1505a6c466c9747aa@git.kernel.org>
Cc:     mpetlan@redhat.com, hpa@zytor.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        acme@redhat.com, brueckner@linux.vnet.ibm.com,
        sandipan@linux.vnet.ibm.com, kim.phillips@arm.com,
        linux-kernel@vger.kernel.org, tmricht@linux.vnet.ibm.com,
        mingo@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        namhyung@kernel.org
Reply-To: mingo@kernel.org, tmricht@linux.vnet.ibm.com,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com,
          alexander.shishkin@linux.intel.com, mpetlan@redhat.com,
          kim.phillips@arm.com, acme@redhat.com,
          sandipan@linux.vnet.ibm.com, brueckner@linux.vnet.ibm.com,
          jolsa@redhat.com
In-Reply-To: <20180629124658.15a506b41fc4539c08eb9426@arm.com>
References: <20180629124658.15a506b41fc4539c08eb9426@arm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf test shell: Prevent temporary editor files
 from being considered test scripts
Git-Commit-ID: db8fec583f250557ddd6def1505a6c466c9747aa
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

Commit-ID:  db8fec583f250557ddd6def1505a6c466c9747aa
Gitweb:     https://git.kernel.org/tip/db8fec583f250557ddd6def1505a6c466c9747aa
Author:     Kim Phillips <kim.phillips@arm.com>
AuthorDate: Fri, 29 Jun 2018 12:46:58 -0500
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 11 Jul 2018 10:01:51 -0300

perf test shell: Prevent temporary editor files from being considered test scripts

Allows a perf shell test developer to concurrently edit and run their
test scripts, avoiding perf test attempts to execute their editor
temporary files, such as seen here:

 $ sudo taskset -c 0 ./perf test -vvvvvvvv -F 63
 63: 0VIM 8.0                                              :
 --- start ---
 sh: 1: ./tests/shell/.record+probe_libc_inet_pton.sh.swp: Permission denied
 ---- end ----
 0VIM 8.0: FAILED!

Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>
Link: http://lkml.kernel.org/r/20180629124658.15a506b41fc4539c08eb9426@arm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 2bde505e2e7e..dd850a26d579 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -422,7 +422,7 @@ static const char *shell_test__description(char *description, size_t size,
 
 #define for_each_shell_test(dir, base, ent)	\
 	while ((ent = readdir(dir)) != NULL)	\
-		if (!is_directory(base, ent))
+		if (!is_directory(base, ent) && ent->d_name[0] != '.')
 
 static const char *shell_tests__dir(char *path, size_t size)
 {
