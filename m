Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 765B9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44336218FC
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458347;
	bh=llgp6iB9umQMtijPU5ndOBm56cNGSCkZgnCSDL4fGkk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YCf219TOwzBo4xhZWsC5DlkhjZc5JbRhl6lo4+wAF38ppfFZUaNCIfC09tNpqsKp8
	 oz5zl7cNuJFkLC3N6sS8VM5Y/BjcOUJ6VfWdJTexBEwOVJKEzmyNJtpEb+GcGGV/JZ
	 jjluw2H6zDUQ+k6u69lXz10TuZVf4ByTnRjM3Cb4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729724AbfAYXTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:47578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729685AbfAYXTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:04 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C075C20844;
        Fri, 25 Jan 2019 23:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458343;
        bh=llgp6iB9umQMtijPU5ndOBm56cNGSCkZgnCSDL4fGkk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rUSsUJI94MwIX3vGdHxIBDrD+QbA3PODJXxlydYYVY5Li28EGY4+6mPFvOQmIdiCF
         6oz+zxhimokQHNrpQRbl4BAld1zXmWfljGca/SGz34ofsxO1Eb0uC/5SGvjo6jvJ7p
         s8BIsJtCe6NuTwoII58t+3v1tDosOHsojX3IKIGw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 06/29] perf symbols: Remove some unnecessary includes from symbol.h
Date:   Sat, 26 Jan 2019 00:18:20 +0100
Message-Id: <20190125231843.2895-7-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And fixup the fallout in places like annotation and jitdump that were
using things like dirname() but weren't including libgen.h, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7ji9igrauh6ylt3p6i03bjlf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c |  1 +
 tools/perf/util/jitdump.c  |  1 +
 tools/perf/util/symbol.h   | 10 ++++------
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 70de8f6b3aee..3d79add5f7ae 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -9,6 +9,7 @@
 
 #include <errno.h>
 #include <inttypes.h>
+#include <libgen.h>
 #include "util.h"
 #include "ui/ui.h"
 #include "sort.h"
diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index bf249552a9b0..eda28d3570bc 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -2,6 +2,7 @@
 #include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index 956d9916e364..2162a5d9b3ac 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -5,16 +5,10 @@
 #include <linux/types.h>
 #include <stdbool.h>
 #include <stdint.h>
-#include "map.h"
-#include "../perf.h"
 #include <linux/list.h>
 #include <linux/rbtree.h>
 #include <stdio.h>
-#include <byteswap.h>
-#include <libgen.h>
 #include "branch.h"
-#include "build-id.h"
-#include "event.h"
 #include "path.h"
 #include "symbol_conf.h"
 
@@ -26,6 +20,10 @@
 
 #include "dso.h"
 
+struct map;
+struct map_groups;
+struct option;
+
 /*
  * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
  * for newer versions we can use mmap to reduce memory usage:
-- 
2.20.1

