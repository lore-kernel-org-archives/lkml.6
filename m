Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73FEC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:47:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5B4222F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405056AbfBOJjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:39:40 -0500
Received: from terminus.zytor.com ([198.137.202.136]:54191 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390412AbfBOJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:39:40 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x1F9dQkJ1118222
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 15 Feb 2019 01:39:26 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x1F9dPtH1118219;
        Fri, 15 Feb 2019 01:39:25 -0800
Date:   Fri, 15 Feb 2019 01:39:25 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Mathieu Poirier <tipbot@zytor.com>
Message-ID: <tip-b611f63bb1b7ba20e87d9d0d7af88d247bcf98eb@git.kernel.org>
Cc:     leo.yan@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org,
        mingo@kernel.org, acme@redhat.com, tglx@linutronix.de,
        jolsa@redhat.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: mathieu.poirier@linaro.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
          leo.yan@linaro.org, suzuki.poulose@arm.com, peterz@infradead.org
In-Reply-To: <20190212171618.25355-2-mathieu.poirier@linaro.org>
References: <20190212171618.25355-2-mathieu.poirier@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Remove unused structure field "state"
Git-Commit-ID: b611f63bb1b7ba20e87d9d0d7af88d247bcf98eb
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

Commit-ID:  b611f63bb1b7ba20e87d9d0d7af88d247bcf98eb
Gitweb:     https://git.kernel.org/tip/b611f63bb1b7ba20e87d9d0d7af88d247bcf98eb
Author:     Mathieu Poirier <mathieu.poirier@linaro.org>
AuthorDate: Tue, 12 Feb 2019 10:16:06 -0700
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 14 Feb 2019 15:18:06 -0300

perf cs-etm: Remove unused structure field "state"

Field "state" in structure cs_etm_queue is no longer used and needs
to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-2-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 0b11d653cfbe..ebd68eb43da9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -65,7 +65,6 @@ struct cs_etm_queue {
 	struct thread *thread;
 	struct cs_etm_decoder *decoder;
 	struct auxtrace_buffer *buffer;
-	const struct cs_etm_state *state;
 	union perf_event *event_buf;
 	unsigned int queue_nr;
 	pid_t pid, tid;
