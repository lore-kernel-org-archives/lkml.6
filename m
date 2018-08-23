Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3ED7C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13FB20851
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:41:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B13FB20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732362AbeHWMJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:09:40 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38077 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728224AbeHWMJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:09:39 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7N8egP23188633
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 23 Aug 2018 01:40:42 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7N8egSr3188630;
        Thu, 23 Aug 2018 01:40:42 -0700
Date:   Thu, 23 Aug 2018 01:40:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-85e1d419e71eaa39248a9fa6572502a3c802f9ca@git.kernel.org>
Cc:     dsahern@gmail.com, namhyung@kernel.org, peterz@infradead.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        acme@redhat.com, mpetlan@redhat.com, tglx@linutronix.de,
        jolsa@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          hpa@zytor.com, namhyung@kernel.org, peterz@infradead.org,
          dsahern@gmail.com, tglx@linutronix.de, jolsa@kernel.org,
          mpetlan@redhat.com, acme@redhat.com, mingo@kernel.org
In-Reply-To: <20180817094813.15086-5-jolsa@kernel.org>
References: <20180817094813.15086-5-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tools: Make decompress_to_file() function
 static
Git-Commit-ID: 85e1d419e71eaa39248a9fa6572502a3c802f9ca
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

Commit-ID:  85e1d419e71eaa39248a9fa6572502a3c802f9ca
Gitweb:     https://git.kernel.org/tip/85e1d419e71eaa39248a9fa6572502a3c802f9ca
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 17 Aug 2018 11:48:04 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 20 Aug 2018 08:54:59 -0300

perf tools: Make decompress_to_file() function static

There's no outside user of it.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180817094813.15086-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 2 +-
 tools/perf/util/dso.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8ee1faa5726f..9f4b72d8f50f 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -239,7 +239,7 @@ bool is_kernel_module(const char *pathname, int cpumode)
 	return m.kmod;
 }
 
-bool decompress_to_file(const char *ext, const char *filename, int output_fd)
+static bool decompress_to_file(const char *ext, const char *filename, int output_fd)
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
