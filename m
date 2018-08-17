Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF99C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A619218AA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 09:48:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A619218AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeHQMvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 08:51:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42248 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725845AbeHQMvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 08:51:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5F14406222D;
        Fri, 17 Aug 2018 09:48:22 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 68DC31746E;
        Fri, 17 Aug 2018 09:48:21 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH 04/13] perf tools: Make decompress_to_file function static
Date:   Fri, 17 Aug 2018 11:48:04 +0200
Message-Id: <20180817094813.15086-5-jolsa@kernel.org>
In-Reply-To: <20180817094813.15086-1-jolsa@kernel.org>
References: <20180817094813.15086-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 09:48:22 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.7]); Fri, 17 Aug 2018 09:48:22 +0000 (UTC) for IP:'10.11.54.5' DOMAIN:'int-mx05.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@kernel.org' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no outside user of it.

Link: http://lkml.kernel.org/n/tip-w7pmh9n76tz9xt5r4xnsnck4@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c | 3 ++-
 tools/perf/util/dso.h | 1 -
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8ee1faa5726f..3f38b6a08a9a 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -239,7 +239,8 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-bool decompress_to_file(const char *ext, const char *filename, int output_fd)
+static bool
+decompress_to_file(const char *ext, const char *filename, int output_fd)
 {
 	unsigned i;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index ef69de2e69ea..e1adadd1fe1e 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -252,7 +252,6 @@ int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type t
 				   char *root_dir, char *filename, size_t size);
 bool is_supported_compression(const char *ext);
 bool is_kernel_module(const char *pathname, int cpumode);
-bool decompress_to_file(const char *ext, const char *filename, int output_fd);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
 int dso__decompress_kmodule_path(struct dso *dso, const char *name,
-- 
2.17.1

