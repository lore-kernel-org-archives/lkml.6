Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F16C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B177B217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170980;
	bh=yM4VZALYjFY5aKveXnYgHjcQHYRdkqmmR/TenOImj+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TAdI0g9cReWGBHoMcGtEP5n5rRTAW6mOdGQDYWwPJuqETGHPhnxTeptGYWL6fnCZd
	 IYJNK/6TYL0X4HzJJu43Fsz6wjfdpwaG7CufFIua2DBtRrIGCa9RJJSm/fcZoFpJ1t
	 0CwBOSrErq5tMuCRmxx1ZDC88lcE1jc+fFnV+Wtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeLRWJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:37882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbeLRWJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:37 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 971EA217D9;
        Tue, 18 Dec 2018 22:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170976;
        bh=yM4VZALYjFY5aKveXnYgHjcQHYRdkqmmR/TenOImj+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1URekfQAWlskQbHZIMfTHBSZ4HaTrX0uRqi+uB1op1aHZ8SzfFeTugAieUYjdNu8T
         b752sxK4lxQSZi5L2rTcgeGka7Q4yydljxJUSCe5S4ckiWo66FkWDkC/KexioEFCDF
         RNZ7NSvzHqS1EC5yshAwigfUPG8Fe5rpzcevLbok=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 20/63] perf trace: Rename set_ev_qualifier_filter to clarify its a tracepoint filter
Date:   Tue, 18 Dec 2018 19:06:50 -0300
Message-Id: <20181218220733.15839-21-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Rename it to trace__set_ev_qualifier_tp_filter(), as this just sets up
tracepoint filters on the raw_syscalls:sys_{enter,exit} tracepoints, and
since we're going to do the same for the augmented_raw_syscalls
codepath, when used, rename it to clarify.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8bjsul8x7osw7nxjodnyfn14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a14ee4ed2c9f..76e4fa04d824 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2553,7 +2553,7 @@ static int trace__add_syscall_newtp(struct trace *trace)
 	goto out;
 }
 
-static int trace__set_ev_qualifier_filter(struct trace *trace)
+static int trace__set_ev_qualifier_tp_filter(struct trace *trace)
 {
 	int err = -1;
 	struct perf_evsel *sys_exit;
@@ -2578,6 +2578,11 @@ static int trace__set_ev_qualifier_filter(struct trace *trace)
 	goto out;
 }
 
+static int trace__set_ev_qualifier_filter(struct trace *trace)
+{
+	return trace__set_ev_qualifier_tp_filter(trace);
+}
+
 static int bpf_map__set_filter_pids(struct bpf_map *map __maybe_unused,
 				    size_t npids __maybe_unused, pid_t *pids __maybe_unused)
 {
-- 
2.19.2

