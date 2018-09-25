Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526EEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E157720867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E157720867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbeIYPiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:38:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52537 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeIYPix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:38:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w8P9UcPK3386070
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 25 Sep 2018 02:30:38 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w8P9UcHA3386067;
        Tue, 25 Sep 2018 02:30:38 -0700
Date:   Tue, 25 Sep 2018 02:30:38 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ding Xiang <tipbot@zytor.com>
Message-ID: <tip-e381d1c21eea186daed6834af444575e06841355@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, dingxiang@cmss.chinamobile.com,
        jolsa@redhat.com, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, peterz@infradead.org,
          alexander.shishkin@linux.intel.com, namhyung@kernel.org,
          dingxiang@cmss.chinamobile.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
          hpa@zytor.com
In-Reply-To: <1536284082-23466-2-git-send-email-dingxiang@cmss.chinamobile.com>
References: <1536284082-23466-2-git-send-email-dingxiang@cmss.chinamobile.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf bpf-loader: use PTR_ERR_OR_ZERO inetead of
 return code
Git-Commit-ID: e381d1c21eea186daed6834af444575e06841355
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

Commit-ID:  e381d1c21eea186daed6834af444575e06841355
Gitweb:     https://git.kernel.org/tip/e381d1c21eea186daed6834af444575e06841355
Author:     Ding Xiang <dingxiang@cmss.chinamobile.com>
AuthorDate: Fri, 7 Sep 2018 09:34:42 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 19 Sep 2018 10:25:09 -0300

perf bpf-loader: use PTR_ERR_OR_ZERO inetead of return code

Use PTR_ERR_OR_ZERO() in bpf__setup_stdout() return code instead of open
coded equivalent.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1536284082-23466-2-git-send-email-dingxiang@cmss.chinamobile.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-loader.c b/tools/perf/util/bpf-loader.c
index 47aac41349a2..f9ae1a993806 100644
--- a/tools/perf/util/bpf-loader.c
+++ b/tools/perf/util/bpf-loader.c
@@ -1615,7 +1615,7 @@ struct perf_evsel *bpf__setup_output_event(struct perf_evlist *evlist, const cha
 int bpf__setup_stdout(struct perf_evlist *evlist)
 {
 	struct perf_evsel *evsel = bpf__setup_output_event(evlist, "__bpf_stdout__");
-	return IS_ERR(evsel) ? PTR_ERR(evsel) : 0;
+	return PTR_ERR_OR_ZERO(evsel);
 }
 
 #define ERRNO_OFFSET(e)		((e) - __BPF_LOADER_ERRNO__START)
