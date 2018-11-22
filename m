Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0F6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D9D2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:36:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zpWmQTDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D9D2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404311AbeKVOOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:14:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:55776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404284AbeKVOOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:14:16 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84C642080F;
        Thu, 22 Nov 2018 03:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857810;
        bh=m+OJqk9Egcp9+o4ivQ9rZxZXX8DXDUDA3wnjAIfx8U4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zpWmQTDa2vQZbn8DcvCGwLx6Fw6eHNiyLPm+h+NrQ9/5m7bz8ohBUKJ8j3gLGtqCB
         1+ne7Flbo4+t6WoQU3tJCzxlgxPysRAeDZu+2Z3u0ujeX59ffaPKvIgrvLWvmV0M15
         vVq6RMXKNNwkD1tdahkzTnqYDjU9X+YTgZ7IXcAY=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/28] perf trace: Add "_from_option" suffix to trace__set_filter()
Date:   Thu, 22 Nov 2018 00:35:52 -0300
Message-Id: <20181122033611.15890-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

As we'll need that name for a new function to set filters for both
tracepoints and BPF maps for filtering pids.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-mdkck6hf3fnd21rz2766280q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d86ba17fcf44..8f966c7a7d0d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3104,8 +3104,8 @@ static int trace__set_duration(const struct option *opt, const char *str,
 	return 0;
 }
 
-static int trace__set_filter_pids(const struct option *opt, const char *str,
-				  int unset __maybe_unused)
+static int trace__set_filter_pids_from_option(const struct option *opt, const char *str,
+					      int unset __maybe_unused)
 {
 	int ret = -1;
 	size_t i;
@@ -3363,7 +3363,7 @@ int cmd_trace(int argc, const char **argv)
 	OPT_STRING('t', "tid", &trace.opts.target.tid, "tid",
 		    "trace events on existing thread id"),
 	OPT_CALLBACK(0, "filter-pids", &trace, "CSV list of pids",
-		     "pids to filter (by the kernel)", trace__set_filter_pids),
+		     "pids to filter (by the kernel)", trace__set_filter_pids_from_option),
 	OPT_BOOLEAN('a', "all-cpus", &trace.opts.target.system_wide,
 		    "system-wide collection from all CPUs"),
 	OPT_STRING('C', "cpu", &trace.opts.target.cpu_list, "cpu",
-- 
2.14.5

