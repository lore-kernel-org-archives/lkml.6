Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09977C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB29C21B68
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191739;
	bh=hBbmYi1eufJ3+PYw5OIT7VFBXZCV407JHG0U5Sa4ioE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GFkO3D6/EGJrX9IST7/QuNLaBAgtOOnj8gRhnwZrx75sWkLdLnSBmw39k5G36BQyu
	 AQwbcMdDJZU7F009g/rHtLb+/hIVGh9ahGh1+R6SQMMv4GIC1l6YCxtBVRchJATbX/
	 KDSry6DjmxPNzld54sL0B//GIvtFvo79150RzftU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbfBOAs6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:48:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387628AbfBOAs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:48:56 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D27FE222D4;
        Fri, 15 Feb 2019 00:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191735;
        bh=hBbmYi1eufJ3+PYw5OIT7VFBXZCV407JHG0U5Sa4ioE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xH1QSx9ELJjH8Hw9YC1lyMstqjB07j7L22f397ZmVYP2q9yM/oDG89/KAtemQ7m+m
         OR7yxAd5ZBRi+P1nn8XInggnTNvd6CSIqjNUfcL05Iw5LQ0aTvWPkywgdDRbt23yzg
         LhrbdktyfqkyUdyXI1bNpPh2YKnTnGYsOxQYiGPk=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 42/43] perf header: Remove unused 'cpu_nr' field  from 'struct cpu_topo'
Date:   Thu, 14 Feb 2019 21:45:38 -0300
Message-Id: <20190215004539.23571-43-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Not used at all.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190213123246.4015-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f1508adefc16..61ce197c5362 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -563,7 +563,6 @@ static int write_cmdline(struct feat_fd *ff,
 	"/sys/devices/system/cpu/cpu%d/topology/thread_siblings_list"
 
 struct cpu_topo {
-	u32 cpu_nr;
 	u32 core_sib;
 	u32 thread_sib;
 	char **core_siblings;
@@ -679,7 +678,6 @@ static struct cpu_topo *build_cpu_topology(void)
 		goto out_free;
 
 	tp = addr;
-	tp->cpu_nr = nr;
 	addr += sizeof(*tp);
 	tp->core_siblings = addr;
 	addr += sz;
-- 
2.19.1

