Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7B2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0460206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:33:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389499AbfBOJd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:33:28 -0500
Received: from terminus.zytor.com ([198.137.202.136]:39093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfBOJd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:33:27 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9WxM61116792
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:32:59 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9Wx5V1116789;
        Fri, 15 Feb 2019 01:32:59 -0800
Date:   Fri, 15 Feb 2019 01:32:59 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-w6s00jfo1xabgphzczadl59b@git.kernel.org>
Cc:     tglx@linutronix.de, jolsa@kernel.org, namhyung@kernel.org,
        acme@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com
Reply-To: hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
          tglx@linutronix.de, linux-kernel@vger.kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, acme@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools feature: Undef _GNU_SOURCE at the end of
 feature tests
Git-Commit-ID: 0ec572f05721f430cf8470595da8c3d5e25567de
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

Commit-ID:  0ec572f05721f430cf8470595da8c3d5e25567de
Gitweb:     https://git.kernel.org/tip/0ec572f05721f430cf8470595da8c3d5e25567de
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 12 Feb 2019 09:56:57 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 13:31:11 -0300

tools feature: Undef _GNU_SOURCE at the end of feature tests

Since we get all the tests in a single .c file for a first test,
tools/build/feature/test-all.c, if individual tests set that define and
fail to undef it at its end, then it the test-all.c build will fail due
to defining _GNU_SOURCE multiple times, getting us to the slow path,
so undef it at the end in tests that define it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-w6s00jfo1xabgphzczadl59b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-get_current_dir_name.c | 1 +
 tools/build/feature/test-libpython.c            | 1 +
 tools/build/feature/test-setns.c                | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tools/build/feature/test-get_current_dir_name.c b/tools/build/feature/test-get_current_dir_name.c
index 573000f93212..c3c201691b4f 100644
--- a/tools/build/feature/test-get_current_dir_name.c
+++ b/tools/build/feature/test-get_current_dir_name.c
@@ -8,3 +8,4 @@ int main(void)
 	free(get_current_dir_name());
 	return 0;
 }
+#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-libpython.c b/tools/build/feature/test-libpython.c
index 0c1641b0d9a7..371c9113e49d 100644
--- a/tools/build/feature/test-libpython.c
+++ b/tools/build/feature/test-libpython.c
@@ -7,3 +7,4 @@ int main(void)
 
 	return 0;
 }
+#undef _GNU_SOURCE
diff --git a/tools/build/feature/test-setns.c b/tools/build/feature/test-setns.c
index 1f714d2a658b..4a1581ae7a55 100644
--- a/tools/build/feature/test-setns.c
+++ b/tools/build/feature/test-setns.c
@@ -5,3 +5,4 @@ int main(void)
 {
 	return setns(0, 0);
 }
+#undef _GNU_SOURCE
