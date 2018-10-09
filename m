Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E63C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B88D20C0A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 05:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B88D20C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbeJIMoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 08:44:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41647 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbeJIMoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 08:44:13 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w995SscH909865
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 8 Oct 2018 22:28:54 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w995SsQb909862;
        Mon, 8 Oct 2018 22:28:54 -0700
Date:   Mon, 8 Oct 2018 22:28:54 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Thomas Richter <tipbot@zytor.com>
Message-ID: <tip-0e24147d69c9357b1ccb54a9bc028eb9a9f9ed1a@git.kernel.org>
Cc:     hpa@zytor.com, schwidefsky@de.ibm.com,
        brueckner@linux.vnet.ibm.com, heiko.carstens@de.ibm.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, acme@redhat.com,
        mingo@kernel.org, ravi.bangoria@linux.ibm.com,
        tmricht@linux.ibm.com
Reply-To: tmricht@linux.ibm.com, ravi.bangoria@linux.ibm.com,
          mingo@kernel.org, acme@redhat.com, linux-kernel@vger.kernel.org,
          heiko.carstens@de.ibm.com, tglx@linutronix.de,
          brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
          hpa@zytor.com
In-Reply-To: <20180928105335.67179-1-tmricht@linux.ibm.com>
References: <20180928105335.67179-1-tmricht@linux.ibm.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf test: S390 does not support watchpoints in
 test 22
Git-Commit-ID: 0e24147d69c9357b1ccb54a9bc028eb9a9f9ed1a
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

Commit-ID:  0e24147d69c9357b1ccb54a9bc028eb9a9f9ed1a
Gitweb:     https://git.kernel.org/tip/0e24147d69c9357b1ccb54a9bc028eb9a9f9ed1a
Author:     Thomas Richter <tmricht@linux.ibm.com>
AuthorDate: Fri, 28 Sep 2018 12:53:35 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 8 Oct 2018 14:23:44 -0300

perf test: S390 does not support watchpoints in test 22

S390 does not support the perf_event_open system call for
attribute type PERF_TYPE_BREAKPOINT. This results in test
failure for test 22:

  [root@s8360046 perf]# ./perf test 22
  22: Watchpoint                                :
  22.1: Read Only Watchpoint                    : FAILED!
  22.2: Write Only Watchpoint                   : FAILED!
  22.3: Read / Write Watchpoint                 : FAILED!
  22.4: Modify Watchpoint                       : FAILED!
  [root@s8360046 perf]#

Add s390 support to avoid these tests being executed on
s390 platform:

  [root@s8360046 perf]# ./perf test 22
  [root@s8360046 perf]# ./perf test -v 22
  22: Watchpoint                                : Disabled
  [root@s8360046 perf]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180928105335.67179-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c |  1 +
 tools/perf/tests/tests.h        |  1 +
 tools/perf/tests/wp.c           | 12 ++++++++++++
 3 files changed, 14 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54ca7d87236f..12c09e0ece71 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -123,6 +123,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Watchpoint",
 		.func = test__wp,
+		.is_supported = test__wp_is_supported,
 		.subtest = {
 			.skip_if_fail	= false,
 			.get_nr		= test__wp_subtest_get_nr,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 8e26a4148f30..b82f55fcc294 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -109,6 +109,7 @@ int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
+bool test__wp_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
 #ifdef HAVE_DWARF_UNWIND_SUPPORT
diff --git a/tools/perf/tests/wp.c b/tools/perf/tests/wp.c
index 017a99317f94..f89e6806557b 100644
--- a/tools/perf/tests/wp.c
+++ b/tools/perf/tests/wp.c
@@ -227,3 +227,15 @@ int test__wp(struct test *test __maybe_unused, int i)
 
 	return !wp_testcase_table[i].target_func() ? TEST_OK : TEST_FAIL;
 }
+
+/* The s390 so far does not have support for
+ * instruction breakpoint using the perf_event_open() system call.
+ */
+bool test__wp_is_supported(void)
+{
+#if defined(__s390x__)
+	return false;
+#else
+	return true;
+#endif
+}
