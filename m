Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0566C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3CC222C0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IakIojWr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfBLRQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:16:25 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42943 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729211AbfBLRQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:23 -0500
Received: by mail-pf1-f194.google.com with SMTP id n74so1586772pfi.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VCeE+fVe6sOPfIScwVf+tBPxTH5OVWtBxrO1s0RcHJI=;
        b=IakIojWrVhLLuunKXwwN4iY4XDiT0UcS3/3wk8jIMBLxEkKEYFPIytjPBl0G/M45oy
         eAkA1XwPou7P12w14qY2H2PWiXTxCEJALNrYPPwQfbxobxcLs5Jnzcm87oyN0A4u4v7A
         pX1gg3cbtN6KNoA+2Mw5Vl1BYGpEX8vnqUpJV210HchPYaPVmu9/q/2ld8MuGtyCrBJv
         uDLQpBy386ikkiecyTPEkggRObY58Y2aX+2rMKEuOg8a2WO1EtUSzZKVmfoVvXpLy1zt
         oyR/VaKnp9BlTMDaFcKTA8FgbrGEErj/v/rpVce3Q8YThiGHpj2Gk0nbfxshcVp+imC3
         jWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VCeE+fVe6sOPfIScwVf+tBPxTH5OVWtBxrO1s0RcHJI=;
        b=fkCpQ0V0gtj9fmAxCfTjGupy3rW1gjt8/nngAcHp6IO4gqlBHJaiXlfocxY9sl2z2v
         uG3kvu9Js1cletf0UifokkLkwV/gFMAUy3fMesn1qPplwvWZWSWWDfx7gYTnPo0f4ujD
         Thm5z49onasvh9hGbDvc1ZWvp1VAaWMF/jZJIGfNlo/dmLDUVlKqMbVVdf6wf9HzeToW
         sRl5KJEM9CNJ1oB3vTSPexHRKz94VY45PtP7OfepBJqK7i5A9Ri0l0xLUJyLTrh53CUo
         U+wWp70ZkbekTrDnZ+QylXiWx6pTgmkeIWiNuFprSFYTS4edecY2tzscNO6qzhS1PFD+
         JmdA==
X-Gm-Message-State: AHQUAub/xWe5xQYkCwPsjxsbtc9GESUHON8W+L3egWdPpNoXQTMRnVJm
        sHvaJ4dDICDmzJPDe6AWUTlHdw==
X-Google-Smtp-Source: AHgI3IYDQJ50KAjYQ3/cuGL5b4e47X/ziZL9vx4vc2EdDCeAGWMRdssrnfB4hNNwuLy8liTp1BSTAQ==
X-Received: by 2002:a65:6491:: with SMTP id e17mr4540223pgv.418.1549991782641;
        Tue, 12 Feb 2019 09:16:22 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:22 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/13] perf tools: Remove unused structure field "time" and "timestamp"
Date:   Tue, 12 Feb 2019 10:16:07 -0700
Message-Id: <20190212171618.25355-3-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Field "time" and "timestamp" in structure cs_etm_queue are no longer used
and need to be removed.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
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
2.17.1

