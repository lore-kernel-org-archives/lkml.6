Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA78C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBD22186A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549379258;
	bh=r2vyOMhU25btsEod98ogTzny/1a0p5h5UHAcQxcedSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jY23v76q0eR7XOOQ32SbVz5yoUbM6VEHc3oFVd7JQ66HssM1SZ45MpxK2HvZsKCVx
	 QxH/DKfVd6uE1q1JnqI6EP8AwrjMys7q39e4k9jS4uIF57pcCQwZa5oecA1rRUAFSF
	 L79SngARD3H8ihxjteFXd5LcR4L9fdCw8AUwTsnQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbfBEPHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:07:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:42420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729695AbfBEPHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:07:34 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35D8217D6;
        Tue,  5 Feb 2019 15:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549379253;
        bh=r2vyOMhU25btsEod98ogTzny/1a0p5h5UHAcQxcedSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ERu/oRL6qRM1CqnI4OJTFvarPLpC2AlIjXbZ8Ulg1XqW145mwIfHUk8qhZXwyw+0A
         SDQdjLzuNlG1Y8WY7WR0y6V8LvtYuoMvdkPCmKPo9i/xjYluRmyOZnhZozCaiJAr+u
         USbJh3k/kKSJXc6lSKK3anBDofVMTO0jzIVENNoI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Clifton <nickc@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 5/8] perf symbols: Add fallback definitions for GELF_ST_VISIBILITY()
Date:   Tue,  5 Feb 2019 12:07:05 -0300
Message-Id: <20190205150708.9012-6-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205150708.9012-1-acme@kernel.org>
References: <20190205150708.9012-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.20.1

