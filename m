Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C932EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983FA222D9
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 00:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550191657;
	bh=QIatHaw3Pd5ihg58PDRuNTKAZDK95EbTjHOpkdkaj0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CzuhP6fYvaUcS+kCefGhySTbwpOgk7icgrAtLrichOz6qM/JRld4rLXP2MqZQYred
	 nz3glizHduaOKur1tACGd0pRJgCBYlulH4xgSw49SggXKrrbb5QgoEyEy8AgIJjMi2
	 JqLrGQhRTmwIkdCFytRj/1KZB31+PUFyhZJA7ExQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389278AbfBOArg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 19:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389224AbfBOAre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 19:47:34 -0500
Received: from quaco.ghostprotocols.net (unknown [189.40.103.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1EC82229F;
        Fri, 15 Feb 2019 00:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550191652;
        bh=QIatHaw3Pd5ihg58PDRuNTKAZDK95EbTjHOpkdkaj0c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HuGtlp3Ob8IeHmdrInDSqwbqnbmKQj/a+Ozr7S3TYLPKshbt/ejIT23YvK0meAVnd
         8EcpsglRAqdRDOlCl4D8vrlKy++0eoBNK6XR9NGV7Xp8Gg/pnF+hk3a6TKu1FuPjZd
         5gpO/G6apyG1HWqnt6ZFFlsmI3L+z4ohDwibTGjE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suzuki K Poulouse <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/43] perf cs-etm: Remove unused structure field "time" and "timestamp"
Date:   Thu, 14 Feb 2019 21:45:20 -0300
Message-Id: <20190215004539.23571-25-acme@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215004539.23571-1-acme@kernel.org>
References: <20190215004539.23571-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Field "time" and "timestamp" in structure cs_etm_queue are no longer
used and need to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190212171618.25355-3-mathieu.poirier@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index ebd68eb43da9..1d9419a0cf0c 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -69,8 +69,6 @@ struct cs_etm_queue {
 	unsigned int queue_nr;
 	pid_t pid, tid;
 	int cpu;
-	u64 time;
-	u64 timestamp;
 	u64 offset;
 	u64 period_instructions;
 	struct branch_stack *last_branch;
@@ -82,7 +80,7 @@ struct cs_etm_queue {
 
 static int cs_etm__update_queues(struct cs_etm_auxtrace *etm);
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid, u64 time_);
+					   pid_t tid);
 
 /* PTMs ETMIDR [11:8] set to b0011 */
 #define ETMIDR_PTM_VERSION 0x00000300
@@ -234,7 +232,7 @@ static int cs_etm__flush_events(struct perf_session *session,
 	if (ret < 0)
 		return ret;
 
-	return cs_etm__process_timeless_queues(etm, -1, MAX_TIMESTAMP - 1);
+	return cs_etm__process_timeless_queues(etm, -1);
 }
 
 static void cs_etm__free_queue(void *priv)
@@ -1583,7 +1581,7 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 }
 
 static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
-					   pid_t tid, u64 time_)
+					   pid_t tid)
 {
 	unsigned int i;
 	struct auxtrace_queues *queues = &etm->queues;
@@ -1593,7 +1591,6 @@ static int cs_etm__process_timeless_queues(struct cs_etm_auxtrace *etm,
 		struct cs_etm_queue *etmq = queue->priv;
 
 		if (etmq && ((tid == -1) || (etmq->tid == tid))) {
-			etmq->time = time_;
 			cs_etm__set_pid_tid_cpu(etm, queue);
 			cs_etm__run_decoder(etmq);
 		}
@@ -1637,8 +1634,7 @@ static int cs_etm__process_event(struct perf_session *session,
 
 	if (event->header.type == PERF_RECORD_EXIT)
 		return cs_etm__process_timeless_queues(etm,
-						       event->fork.tid,
-						       sample->time);
+						       event->fork.tid);
 
 	return 0;
 }
-- 
2.19.1

