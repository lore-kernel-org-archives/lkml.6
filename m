Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637FEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3243F2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 01:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550712420;
	bh=m7zDRY6JpUlcjWFdd/aFuCkJzS3maoaqN45Fnny01Qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PI49vhPuTVUiCpXGWhc/wV0f1hLK6IzUlGMIXefgnPh2wQqZ4FL2t8x2K4B7q6LYl
	 nB4neVXh8x49vDP8lmN+5RgbFIKuTw6XjYm5XuSenAZEOu3v3eSAgCZKliXX4Mbhkg
	 Ait7wSRlOTMNkhSxahqykvDFjOiQx6a+3BuQeBuU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfBUB07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 20:26:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:59658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbfBUB05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 20:26:57 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.102.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772E42086D;
        Thu, 21 Feb 2019 01:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550712417;
        bh=m7zDRY6JpUlcjWFdd/aFuCkJzS3maoaqN45Fnny01Qk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XtkD54Z8vEY1ZgHWXZz6qd5S+AJ2IXTRP6xHTUY46O7LG0mg2C2tPvaJ5E2JnyJUl
         QjEDA4CD/alN64c7toEjTWrCMnz1+th6IaYiSefP+bm395G8DEdm0TPQJxXABiUfG2
         OaR8Rxz/7fvI1HLQc8PdSypOZAEq/EXvkHDGLodw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/17] perf bpf-event: Add missing new line into pr_debug call
Date:   Wed, 20 Feb 2019 22:25:47 -0300
Message-Id: <20190221012549.4069-16-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190221012549.4069-1-acme@kernel.org>
References: <20190221012549.4069-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Add a missing new line into pr_debug call in perf_event__synthesize_bpf_events(),
so that the error message does not screw the verbose output.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Link: http://lkml.kernel.org/r/20190220122800.864-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/bpf-event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/bpf-event.c b/tools/perf/util/bpf-event.c
index 62dda96b0096..028c8ec1f62a 100644
--- a/tools/perf/util/bpf-event.c
+++ b/tools/perf/util/bpf-event.c
@@ -233,7 +233,7 @@ int perf_event__synthesize_bpf_events(struct perf_tool *tool,
 				err = 0;
 				break;
 			}
-			pr_debug("%s: can't get next program: %s%s",
+			pr_debug("%s: can't get next program: %s%s\n",
 				 __func__, strerror(errno),
 				 errno == EINVAL ? " -- kernel too old?" : "");
 			/* don't report error on old kernel or EPERM  */
-- 
2.19.1

