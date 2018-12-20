Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4E9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AC3220643
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388825AbeLTSWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:22:15 -0500
Received: from terminus.zytor.com ([198.137.202.136]:38961 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730855AbeLTSWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:22:15 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIM3dj3683967
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:22:03 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIM3lc3683962;
        Thu, 20 Dec 2018 10:22:03 -0800
Date:   Thu, 20 Dec 2018 10:22:03 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jab52t1dcuh6vlztqle9g7u9@git.kernel.org>
Cc:     acme@redhat.com, lclaudio@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        jolsa@kernel.org, wangnan0@huawei.com
Reply-To: lclaudio@redhat.com, acme@redhat.com, hpa@zytor.com,
          mingo@kernel.org, namhyung@kernel.org, tglx@linutronix.de,
          linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
          jolsa@kernel.org, wangnan0@huawei.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Enclose strings with double quotes
Git-Commit-ID: 721f5326fb35dcba18ee4d9ef2b32394f86d403e
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

Commit-ID:  721f5326fb35dcba18ee4d9ef2b32394f86d403e
Gitweb:     https://git.kernel.org/tip/721f5326fb35dcba18ee4d9ef2b32394f86d403e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 14 Dec 2018 14:02:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:07:41 -0300

perf trace: Enclose strings with double quotes

To match 'strace' output, helping with upcoming regression tests
comparing both outputs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jab52t1dcuh6vlztqle9g7u9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 2d8fd48a4727..dc8cadeb3fa5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1149,7 +1149,7 @@ static size_t syscall_arg__scnprintf_augmented_string(struct syscall_arg *arg, c
 {
 	struct augmented_arg *augmented_arg = arg->augmented.args;
 
-	return scnprintf(bf, size, "%.*s", augmented_arg->size, augmented_arg->value);
+	return scnprintf(bf, size, "\"%.*s\"", augmented_arg->size, augmented_arg->value);
 }
 
 static size_t syscall_arg__scnprintf_filename(char *bf, size_t size,
