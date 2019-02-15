Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DFCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04DFD2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404750AbfBOJwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:52:47 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49431 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393644AbfBOJwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:52:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9qMTH1122045
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:52:22 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9qLIf1122042;
        Fri, 15 Feb 2019 01:52:21 -0800
Date:   Fri, 15 Feb 2019 01:52:21 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-lg3kpd9tzypc797vb1f42u6k@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, ast@fb.com, jolsa@kernel.org,
        adrian.hunter@intel.com, acme@redhat.com, daniel@iogearbox.net,
        songliubraving@fb.com, hpa@zytor.com, tglx@linutronix.de,
        jakub.kicinski@netronome.com, andrii.nakryiko@gmail.com,
        mingo@kernel.org, yhs@fb.com, yao.jin@linux.intel.com,
        namhyung@kernel.org
Reply-To: yhs@fb.com, yao.jin@linux.intel.com, namhyung@kernel.org,
          andrii.nakryiko@gmail.com, mingo@kernel.org, hpa@zytor.com,
          songliubraving@fb.com, daniel@iogearbox.net,
          jakub.kicinski@netronome.com, tglx@linutronix.de,
          acme@redhat.com, jolsa@kernel.org, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, ast@fb.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools build feature sched_getcpu: Undef _GNU_SOURCE
 at the end
Git-Commit-ID: 44ec8396e2dadf0f0806767642cfac9e04d0d5b1
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

Commit-ID:  44ec8396e2dadf0f0806767642cfac9e04d0d5b1
Gitweb:     https://git.kernel.org/tip/44ec8396e2dadf0f0806767642cfac9e04d0d5b1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 14 Feb 2019 13:02:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:39:21 -0300

tools build feature sched_getcpu: Undef _GNU_SOURCE at the end

Since this feature test is included in test-all.c, the feature detection
fast path compile/link phase, it can't leave any defines behind, as it
can affect the tests included after it, so remove it.

Reported-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexei Starovoitov <ast@fb.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Link: https://lkml.kernel.org/n/tip-lg3kpd9tzypc797vb1f42u6k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/feature/test-sched_getcpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/build/feature/test-sched_getcpu.c b/tools/build/feature/test-sched_getcpu.c
index e448deb4124c..48995ac7911e 100644
--- a/tools/build/feature/test-sched_getcpu.c
+++ b/tools/build/feature/test-sched_getcpu.c
@@ -8,3 +8,5 @@ int main(void)
 {
 	return sched_getcpu();
 }
+
+#undef _GNU_SOURCE
