Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E45BDC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B96F820863
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfBIMW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:22:29 -0500
Received: from terminus.zytor.com ([198.137.202.136]:44141 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:22:28 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CMHv32624558
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:22:17 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CMGOq2624555;
        Sat, 9 Feb 2019 04:22:16 -0800
Date:   Sat, 9 Feb 2019 04:22:16 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-03cg3gya2ju4ba2x6ibb9fuz@git.kernel.org>
Cc:     acme@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        mpetlan@redhat.com, peterz@infradead.org, nickc@redhat.com,
        hpa@zytor.com, mhiramat@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, adrian.hunter@intel.com, mingo@kernel.org
Reply-To: namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          acme@redhat.com, jolsa@kernel.org, mingo@kernel.org,
          adrian.hunter@intel.com, mhiramat@kernel.org, tglx@linutronix.de,
          hpa@zytor.com, nickc@redhat.com, mpetlan@redhat.com,
          peterz@infradead.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf symbols: Add fallback definitions for
 GELF_ST_VISIBILITY()
Git-Commit-ID: 843cf70ed29a7fb51f1e796c1d6e1ba3620250ac
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

Commit-ID:  843cf70ed29a7fb51f1e796c1d6e1ba3620250ac
Gitweb:     https://git.kernel.org/tip/843cf70ed29a7fb51f1e796c1d6e1ba3620250ac
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 4 Feb 2019 15:48:03 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 4 Feb 2019 15:50:37 -0300

perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()

Those aren't present in Alpine Linux 3.4 to edge, so provide fallback
defines to get the next patch building there keeping the build
bisectable.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Nick Clifton <nickc@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/n/tip-03cg3gya2ju4ba2x6ibb9fuz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 66a84d5846c8..695a73940329 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -19,6 +19,20 @@
 #define EM_AARCH64	183  /* ARM 64 bit */
 #endif
 
+#ifndef ELF32_ST_VISIBILITY
+#define ELF32_ST_VISIBILITY(o)	((o) & 0x03)
+#endif
+
+/* For ELF64 the definitions are the same.  */
+#ifndef ELF64_ST_VISIBILITY
+#define ELF64_ST_VISIBILITY(o)	ELF32_ST_VISIBILITY (o)
+#endif
+
+/* How to extract information held in the st_other field.  */
+#ifndef GELF_ST_VISIBILITY
+#define GELF_ST_VISIBILITY(val)	ELF64_ST_VISIBILITY (val)
+#endif
+
 typedef Elf64_Nhdr GElf_Nhdr;
 
 #ifdef HAVE_CPLUS_DEMANGLE_SUPPORT
