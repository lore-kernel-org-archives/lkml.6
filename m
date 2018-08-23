Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD99AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BE72083A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BE72083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732468AbeHWMKN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:10:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729381AbeHWMKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:10:12 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8fGY23188727
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:41:16 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8fGco3188724;
        Thu, 23 Aug 2018 01:41:16 -0700
Date:   Thu, 23 Aug 2018 01:41:16 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-e1e139463db363a253296b431e61519d8809e386@git.kernel.org>
Cc:     dsahern@gmail.com, jolsa@kernel.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, mpetlan@redhat.com, acme@redhat.com,
        mingo@kernel.org, peterz@infradead.org, namhyung@kernel.org,
        alexander.shishkin@linux.intel.com, hpa@zytor.com
Reply-To: dsahern@gmail.com, linux-kernel@vger.kernel.org,
          jolsa@kernel.org, tglx@linutronix.de, acme@redhat.com,
          mpetlan@redhat.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, peterz@infradead.org, mingo@kernel.org,
          hpa@zytor.com
In-Reply-To: <20180817094813.15086-6-jolsa@kernel.org>
References: <20180817094813.15086-6-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Make is_supported_compression()
 static
Git-Commit-ID: e1e139463db363a253296b431e61519d8809e386
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

Commit-ID:  e1e139463db363a253296b431e61519d8809e386
Gitweb:     https://git.kernel.org/tip/e1e139463db363a253296b431e61519d8809e386
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:05 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Make is_supported_compression() static

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-6-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 tools/perf/util/dso.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 9f4b72d8f50f..b8b5fdb1a15b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -202,7 +202,7 @@ static const struct {
 	{ NULL, NULL },
 };
 
-bool is_supported_compression(const char *ext)
+static bool is_supported_compression(const char *ext)
 {
 	unsigned i;
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index e1adadd1fe1e..870346b333ee 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -250,7 +250,6 @@ int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
 char dso__symtab_origin(const struct dso *dso);
 int dso__read_binary_type_filename(const struct dso *dso, enum dso_binary_type type,
 				   char *root_dir, char *filename, size_t size);
-bool is_supported_compression(const char *ext);
 bool is_kernel_module(const char *pathname, int cpumode);
 bool dso__needs_decompress(struct dso *dso);
 int dso__decompress_kmodule_fd(struct dso *dso, const char *name);
