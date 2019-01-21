Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D08C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFE2217D8
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548115093;
	bh=3ggLA/HUS6V3tfTuK37I7jFy8iEXXMP+ulmG6lEx4Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lIybZoKSSXyilPR81W8nOauyE2Be80d1Nv+2u+EjmgBtSvfJ0bGAF1/e/iLtXh+rh
	 vlplMjc2x76LqZ5hwiDY/8VAfggUo8pVu7ryaDriqgkpTPVJF1bDib1OF8UAIL8Hw2
	 n48kTZrxl2y91Nkiz7Vg9O2Lb/Iyz9Q0eorJZcNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726865AbfAUX6L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:58:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:58536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfAUX6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:58:10 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD2321736;
        Mon, 21 Jan 2019 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548115089;
        bh=3ggLA/HUS6V3tfTuK37I7jFy8iEXXMP+ulmG6lEx4Q0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ycO7IzDgk5ARncWVJ/GjSEThfuHVuY6R1Xu3cA3w3mlxEL/XrItvjVJ5SdIbvt9x0
         4MTpZLy0zZ80G17qNv83+I73mguGn3pNIEnRcXHLK52MpAw3+MFK+66MdVo1tARwjp
         Z0vAuoYPUP0Hbc+02F+pKMe4ONjDhOF/VAUSnJRI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Colin King <colin.king@canonical.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/24] perf tools: Remove duplicate headers
Date:   Mon, 21 Jan 2019 20:56:51 -0300
Message-Id: <20190121235706.20005-10-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121235706.20005-1-acme@kernel.org>
References: <20190121235706.20005-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brajeswar Ghosh <brajeswar.linux@gmail.com>

Remove duplicate headers which are included more than once in the same
file.

Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Colin King <colin.king@canonical.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Link: http://lkml.kernel.org/r/20190115135916.GA3629@hp-pavilion-15-notebook-pc-brajeswar
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c     | 1 -
 tools/perf/tests/bp_account.c | 1 -
 tools/perf/util/dso.h         | 1 -
 tools/perf/util/zlib.c        | 1 -
 4 files changed, 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 63a3afc7f32b..e587808591e8 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -83,7 +83,6 @@
 #include <unistd.h>
 #include <sys/time.h>
 #include <sys/resource.h>
-#include <sys/wait.h>
 
 #include "sane_ctype.h"
 
diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index a20cbc445426..57fc544aedb0 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -15,7 +15,6 @@
 #include <sys/mman.h>
 #include <linux/compiler.h>
 #include <linux/hw_breakpoint.h>
-#include <sys/ioctl.h>
 
 #include "tests.h"
 #include "debug.h"
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 8c8a7abe809d..af2eda29660f 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -8,7 +8,6 @@
 #include <sys/types.h>
 #include <stdbool.h>
 #include "rwsem.h"
-#include <linux/types.h>
 #include <linux/bitops.h>
 #include "map.h"
 #include "namespaces.h"
diff --git a/tools/perf/util/zlib.c b/tools/perf/util/zlib.c
index 902ce6384f57..512ad7c09b13 100644
--- a/tools/perf/util/zlib.c
+++ b/tools/perf/util/zlib.c
@@ -6,7 +6,6 @@
 #include <sys/mman.h>
 #include <zlib.h>
 #include <linux/compiler.h>
-#include <unistd.h>
 
 #include "util/compress.h"
 #include "util/util.h"
-- 
2.20.1

