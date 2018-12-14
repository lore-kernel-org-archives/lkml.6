Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E78C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9498A206DD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731030AbeLNUmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:42:21 -0500
Received: from terminus.zytor.com ([198.137.202.136]:48885 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbeLNUmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:42:20 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKftBY1456307
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:41:55 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKftpr1456304;
        Fri, 14 Dec 2018 12:41:55 -0800
Date:   Fri, 14 Dec 2018 12:41:55 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ingo Molnar <tipbot@zytor.com>
Message-ID: <tip-d401b02c41f6afcb8ed32479a016a20cbfd59d6f@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, wangnan0@huawei.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, jolsa@redhat.com, peterz@infradead.org
Reply-To: acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
          wangnan0@huawei.com, peterz@infradead.org, namhyung@kernel.org,
          jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20181203102200.GA104797@gmail.com>
References: <20181203102200.GA104797@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf-loader: Fix debugging message typo
Git-Commit-ID: d401b02c41f6afcb8ed32479a016a20cbfd59d6f
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

Commit-ID:  d401b02c41f6afcb8ed32479a016a20cbfd59d6f
Gitweb:     https://git.kernel.org/tip/d401b02c41f6afcb8ed32479a016a20cbfd59d6f
Author:     Ingo Molnar <mingo@kernel.org>
AuthorDate: Mon, 3 Dec 2018 11:22:00 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 6 Dec 2018 14:12:31 -0300

perf bpf-loader: Fix debugging message typo

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease cherry
picking and/or backporting, split this into multiple patches.

This one has information that is presented to the user, albeit in debug
mode.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 9a280647d829..2f3eb6d293ee 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -99,7 +99,7 @@ struct bpf_object *bpf__prepare_load(const char *filename, bool source)
 			if (err)
 				return ERR_PTR(-BPF_LOADER_ERRNO__COMPILE);
 		} else
-			pr_debug("bpf: successfull builtin compilation\n");
+			pr_debug("bpf: successful builtin compilation\n");
 		obj = bpf_object__open_buffer(obj_buf, obj_buf_sz, filename);
 
 		if (!IS_ERR_OR_NULL(obj) && llvm_param.dump_obj)
