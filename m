Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971A9C282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F70B20844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458351;
	bh=LIWhYQfKvUtn/hwKJTdmaKQzWd9pRhRMfNSwKP93gn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=divx2hmspw6xfrXm46AfW+L9Y176xyE+naciyEFLavVcymlP8qpAoFuEeL4R3Sdj6
	 kUsBnrVvhZCrDIAQmiNria/UNntfP7Pt7spYUvQ28HMJDBCBsQndmuaGgeK6m99xOQ
	 VRKxRyu6Z+Mvq7xoxvQxKVhcW6YSB5rFAqXOZ4fw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbfAYXTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729728AbfAYXTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:07 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A6C4D218D0;
        Fri, 25 Jan 2019 23:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458347;
        bh=LIWhYQfKvUtn/hwKJTdmaKQzWd9pRhRMfNSwKP93gn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WFddVwXeaHXuvNVF94YG9gSEQHPCU6DpLjSEGeof4F4sZdqlQQkfEN4Vgt+yEWZOt
         rXkehGLQGDnRCWs2pW9PcrydbPGvHiC+ACr1m24fw/HMspxzJGkomZpZ8ajq0bBqWa
         IAcssjapH4qCZGbQvBH1BELVmoTJIVtPeugXeM1U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 08/29] perf comm: Remove needless headers from comm.h
Date:   Sat, 26 Jan 2019 00:18:22 +0100
Message-Id: <20190125231843.2895-9-acme@kernel.org>
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

There we don't need rbtree, only in comm.c, also ditch perf.h, not
needed at all.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-vr1jnwwujh99skrgldtimpmu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/comm.c | 1 +
 tools/perf/util/comm.h | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 31279a7bd919..1066de92af12 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -6,6 +6,7 @@
 #include <stdio.h>
 #include <string.h>
 #include <linux/refcount.h>
+#include <linux/rbtree.h>
 #include "rwsem.h"
 
 struct comm_str {
diff --git a/tools/perf/util/comm.h b/tools/perf/util/comm.h
index 3e5c438fe85e..f35d8fbfa2dd 100644
--- a/tools/perf/util/comm.h
+++ b/tools/perf/util/comm.h
@@ -2,9 +2,9 @@
 #ifndef __PERF_COMM_H
 #define __PERF_COMM_H
 
-#include "../perf.h"
-#include <linux/rbtree.h>
 #include <linux/list.h>
+#include <linux/types.h>
+#include <stdbool.h>
 
 struct comm_str;
 
-- 
2.20.1

