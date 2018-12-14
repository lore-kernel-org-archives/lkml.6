Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE99C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01EAA2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 20:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbeLNU1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 15:27:00 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44041 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730123AbeLNU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 15:26:59 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wBEKQXJc1453328
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 14 Dec 2018 12:26:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wBEKQX5R1453325;
        Fri, 14 Dec 2018 12:26:33 -0800
Date:   Fri, 14 Dec 2018 12:26:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Wen Yang <tipbot@zytor.com>
Message-ID: <tip-132efb95080bcf690bdfea1b6f0d57853ee4d48f@git.kernel.org>
Cc:     jolsa@redhat.com, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
        julia.lawall@lip6.fr, yellowriver2010@hotmail.com,
        wen.yang99@zte.com.cn, mingo@kernel.org, acme@redhat.com,
        peterz@infradead.org, alexander.shishkin@linux.intel.com
Reply-To: tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          namhyung@kernel.org, jolsa@redhat.com,
          yellowriver2010@hotmail.com, julia.lawall@lip6.fr,
          wen.yang99@zte.com.cn, mingo@kernel.org, acme@redhat.com,
          alexander.shishkin@linux.intel.com, peterz@infradead.org
In-Reply-To: <20181127090610.28488-1-wen.yang99@zte.com.cn>
References: <20181127090610.28488-1-wen.yang99@zte.com.cn>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf: Use ERR_CAST instead of
 ERR_PTR(PTR_ERR())
Git-Commit-ID: 132efb95080bcf690bdfea1b6f0d57853ee4d48f
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

Commit-ID:  132efb95080bcf690bdfea1b6f0d57853ee4d48f
Gitweb:     https://git.kernel.org/tip/132efb95080bcf690bdfea1b6f0d57853ee4d48f
Author:     Wen Yang <wen.yang99@zte.com.cn>
AuthorDate: Tue, 27 Nov 2018 17:06:10 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 29 Nov 2018 20:42:48 -0300

perf bpf: Use ERR_CAST instead of ERR_PTR(PTR_ERR())

Use ERR_CAST inlined function instead of ERR_PTR(PTR_ERR(...)).  This
makes it more readable and also fix this warning detected by
err_cast.cocci:

  tools/perf/util/bpf-loader.c:1606:11-18: WARNING: ERR_CAST can be used with op

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Julia Lawall <julia.lawall@lip6.fr>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wen Yang <yellowriver2010@hotmail.com>
Cc: zhong.weidong@zte.com.cn
Link: http://lkml.kernel.org/r/20181127090610.28488-1-wen.yang99@zte.com.cn
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index f9ae1a993806..9a280647d829 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1603,7 +1603,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 
 			op = bpf_map__add_newop(map, NULL);
 			if (IS_ERR(op))
-				return ERR_PTR(PTR_ERR(op));
+				return ERR_CAST(op);
 			op->op_type = BPF_MAP_OP_SET_EVSEL;
 			op->v.evsel = evsel;
 		}
