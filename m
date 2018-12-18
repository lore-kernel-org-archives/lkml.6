Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041E4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE256218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 22:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545170976;
	bh=sQzOP+9OhakI0znnJjphATJcCEEyXRw+mo4NRzn4HtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F7GgeKZ2asITvF8eX474Hq720Ck4X7F5H+fUQtzYiz8CqoQVS7XZfBxiTlewySMje
	 mJ1NzkB6zdAfdwv+3Tr07dvB+xjGbk/0VzHty+zgX5+nlsMAArqF4CRdKSF8qSbm3x
	 om4hd4LR+YU74soxt0WHRqyioV0uYCrxZEjxTYY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeLRWJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 17:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbeLRWJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 17:09:33 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.101.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B9B3218A4;
        Tue, 18 Dec 2018 22:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545170973;
        bh=sQzOP+9OhakI0znnJjphATJcCEEyXRw+mo4NRzn4HtU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SlPlODkfjE0bkU9ttjg1anbUs4M6k6bCv3Td9HGCyRnSS33Rf4pvvZBSFCOgBqM8Q
         80HI+dbvZSf8dHIMBVq85N3VyCe77cENnCkvXvmJu5u604qmyS5XOF8yDAxB9/OqQZ
         HfsMcjk6UzviW83R7a/jNz9Fc6RbZ6At3OvYc4Bo=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 19/63] perf tools: Link libperf-jvmti.so with LDFLAGS variable
Date:   Tue, 18 Dec 2018 19:06:49 -0300
Message-Id: <20181218220733.15839-20-acme@kernel.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181218220733.15839-1-acme@kernel.org>
References: <20181218220733.15839-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

So we could propagate distro flags into libperf-jvmti.so library.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181212132940.840-1-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 22956a85e4c6..8c1350c591f2 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -654,7 +654,7 @@ $(LIBJVMTI_IN): FORCE
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=jvmti obj=jvmti
 
 $(OUTPUT)$(LIBJVMTI): $(LIBJVMTI_IN)
-	$(QUIET_LINK)$(CC) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
+	$(QUIET_LINK)$(CC) $(LDFLAGS) -shared -Wl,-soname -Wl,$(LIBJVMTI) -o $@ $<
 endif
 
 $(patsubst perf-%,%.o,$(PROGRAMS)): $(wildcard */*.h)
-- 
2.19.2

