Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3228C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D77218D3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389221AbeLTSaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 13:30:18 -0500
Received: from terminus.zytor.com ([198.137.202.136]:50167 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbeLTSaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 13:30:16 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBKIU7Xq3686969
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 20 Dec 2018 10:30:07 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBKIU7BM3686966;
        Thu, 20 Dec 2018 10:30:07 -0800
Date:   Thu, 20 Dec 2018 10:30:07 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-va0qe95xbhep5hy52aq5qe0v@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, namhyung@kernel.org,
        lclaudio@redhat.com, jolsa@kernel.org, mingo@kernel.org,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: namhyung@kernel.org, acme@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, wangnan0@huawei.com, mingo@kernel.org,
          jolsa@kernel.org, lclaudio@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf beauty mmap: Print PROT_READ before PROT_EXEC
 to match strace output
Git-Commit-ID: 1355e09ab04bc583df9c4b2b68d445c535c8b66b
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

Commit-ID:  1355e09ab04bc583df9c4b2b68d445c535c8b66b
Gitweb:     https://git.kernel.org/tip/1355e09ab04bc583df9c4b2b68d445c535c8b66b
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 18 Dec 2018 11:22:34 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 18 Dec 2018 16:15:19 -0300

perf beauty mmap: Print PROT_READ before PROT_EXEC to match strace output

Helps with comparing 'strace' and 'perf trace' output, for mutual
regression testing.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-va0qe95xbhep5hy52aq5qe0v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/trace/beauty/mmap.c b/tools/perf/trace/beauty/mmap.c
index 138f36a47fb1..eb31089790e3 100644
--- a/tools/perf/trace/beauty/mmap.c
+++ b/tools/perf/trace/beauty/mmap.c
@@ -17,8 +17,8 @@ static size_t syscall_arg__scnprintf_mmap_prot(char *bf, size_t size,
 		prot &= ~PROT_##n; \
 	}
 
-	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(READ);
+	P_MMAP_PROT(EXEC);
 	P_MMAP_PROT(WRITE);
 	P_MMAP_PROT(SEM);
 	P_MMAP_PROT(GROWSDOWN);
