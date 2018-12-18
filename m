Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FC1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AEE218A4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545171305;
	bh=adaX1c3PVpeOpSMZkWwBBQ22vMrSw3tTb40bRS1T6eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RoRUrqedFNxyeVUeCQDDXGxK9MSxLITsxltztqDsxxiuJRHXKyJ3NR49pTS8lWOts
	 Av3s4oKOgqQteqSgOtGrjpeAGMmHO2MPs2Hwers+6AUSzUT1uv3/QRA+1h09A5sDAl
	 yg/wCPQXGXSaPbHlqhd7t7nxAjTIPf9MhRQfukO0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeLRWPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:15:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:44644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727549AbeLRWPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:15:03 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF87C217D9;
        Tue, 18 Dec 2018 22:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545171302;
        bh=adaX1c3PVpeOpSMZkWwBBQ22vMrSw3tTb40bRS1T6eU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=voEemIb3s4wIesAD8g0I5Djq6JOh3UDBY5hvuaq9N01O5e6tmwfDyllAsjT6yLD8J
         W4/vS78bp78c8yQrPbFDsiHZv3qb+mN5fN0yja9aoFVFCDGO7d0Tj1fTKasDJlJmYq
         utT9WJLdkC/nyN5qTqT+ijka0hXlFp6ciXjWASTk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 49/63] perf trace: Enclose the errno strings with ()
Date:   Tue, 18 Dec 2018 19:07:19 -0300
Message-Id: <20181218220733.15839-50-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To match strace, now both emit the same line for calls like:

 access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-krxl6klsqc9qyktoaxyih942@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 226e994ac638..35d8fbe47ee4 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2024,10 +2024,10 @@ errno_print: {
 		const char *emsg = str_error_r(-ret, bf, sizeof(bf)),
 			   *e = errno_to_name(evsel, -ret);
 
-		fprintf(trace->output, "-1 %s %s", e, emsg);
+		fprintf(trace->output, "-1 %s (%s)", e, emsg);
 	}
 	} else if (ret == 0 && sc->fmt->timeout)
-		fprintf(trace->output, "0 Timeout");
+		fprintf(trace->output, "0 (Timeout)");
 	else if (ttrace->ret_scnprintf) {
 		char bf[1024];
 		struct syscall_arg arg = {
-- 
2.19.2

