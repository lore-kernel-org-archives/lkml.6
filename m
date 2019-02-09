Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E17C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B422420855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbfBIMw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:52:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:60859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:52:26 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CqEg22632914
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:52:14 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CqDhD2632911;
        Sat, 9 Feb 2019 04:52:13 -0800
Date:   Sat, 9 Feb 2019 04:52:13 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-06220bf472f2bd8f67bb776df73090945ee786ab@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, suzuki.poulose@arm.com,
        robert.walker@arm.com, linux-kernel@vger.kernel.org,
        mathieu.poirier@linaro.org, tglx@linutronix.de, hpa@zytor.com,
        leo.yan@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, acme@redhat.com, namhyung@kernel.org,
        mingo@kernel.org, jolsa@redhat.com
Reply-To: linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
          robert.walker@arm.com, suzuki.poulose@arm.com,
          alexander.shishkin@linux.intel.com, leo.yan@linaro.org,
          hpa@zytor.com, tglx@linutronix.de, acme@redhat.com,
          namhyung@kernel.org, coresight@lists.linaro.org,
          mike.leach@linaro.org, jolsa@redhat.com, mingo@kernel.org
In-Reply-To: <20190129122842.32041-3-leo.yan@linaro.org>
References: <20190129122842.32041-3-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Set sample flags for instruction range
 packet
Git-Commit-ID: 06220bf472f2bd8f67bb776df73090945ee786ab
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

Commit-ID:  06220bf472f2bd8f67bb776df73090945ee786ab
Gitweb:     https://git.kernel.org/tip/06220bf472f2bd8f67bb776df73090945ee786ab
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 29 Jan 2019 20:28:36 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf cs-etm: Set sample flags for instruction range packet

The perf sample data contains flags to indicate the hardware trace data
is belonging to which type branch instruction, thus this can be used to
print out the human readable string.  Arm CoreSight ETM sample data is
missed to set flags and it is always set to zeros, this results in perf
tool skips to print string for instruction types.

This patch is to set branch instruction flags for instruction range
packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulouse <suzuki.poulose@arm.com>
Cc: coresight ml <coresight@lists.linaro.org>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190129122842.32041-3-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                        | 90 ++++++++++++++++++++++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 8a19310500d9..e98ee49a1527 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -293,6 +293,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_type = 0;
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
+		decoder->packet_buffer[i].flags = 0;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -329,6 +330,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_type = 0;
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
+	decoder->packet_buffer[et].flags = 0;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 7cdd6a9c68a7..23600e57a215 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -45,6 +45,7 @@ struct cs_etm_packet {
 	u32 instr_count;
 	u32 last_instr_type;
 	u32 last_instr_subtype;
+	u32 flags;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 27a374ddf661..d05cac5295f1 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -12,6 +12,7 @@
 #include <linux/log2.h>
 #include <linux/types.h>
 
+#include <opencsd/ocsd_if_types.h>
 #include <stdlib.h>
 
 #include "auxtrace.h"
@@ -719,7 +720,7 @@ static int cs_etm__synth_instruction_sample(struct cs_etm_queue *etmq,
 	sample.stream_id = etmq->etm->instructions_id;
 	sample.period = period;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.insn_len = 1;
 	sample.cpumode = event->sample.header.misc;
 
@@ -778,7 +779,7 @@ static int cs_etm__synth_branch_sample(struct cs_etm_queue *etmq)
 	sample.stream_id = etmq->etm->branches_id;
 	sample.period = 1;
 	sample.cpu = etmq->packet->cpu;
-	sample.flags = 0;
+	sample.flags = etmq->prev_packet->flags;
 	sample.cpumode = event->sample.header.misc;
 
 	/*
@@ -1107,6 +1108,80 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 	return 0;
 }
 
+static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
+{
+	struct cs_etm_packet *packet = etmq->packet;
+
+	switch (packet->sample_type) {
+	case CS_ETM_RANGE:
+		/*
+		 * Immediate branch instruction without neither link nor
+		 * return flag, it's normal branch instruction within
+		 * the function.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_NONE) {
+			packet->flags = PERF_IP_FLAG_BRANCH;
+
+			if (packet->last_instr_cond)
+				packet->flags |= PERF_IP_FLAG_CONDITIONAL;
+		}
+
+		/*
+		 * Immediate branch instruction with link (e.g. BL), this is
+		 * branch instruction for function call.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_BR_LINK)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL;
+
+		/*
+		 * Indirect branch instruction with link (e.g. BLR), this is
+		 * branch instruction for function call.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_BR_LINK)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_CALL;
+
+		/*
+		 * Indirect branch instruction with subtype of
+		 * OCSD_S_INSTR_V7_IMPLIED_RET, this is explicit hint for
+		 * function return for A32/T32.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_V7_IMPLIED_RET)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Indirect branch instruction without link (e.g. BR), usually
+		 * this is used for function return, especially for functions
+		 * within dynamic link lib.
+		 */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_NONE)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+
+		/* Return instruction for function return. */
+		if (packet->last_instr_type == OCSD_INSTR_BR_INDIRECT &&
+		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
+			packet->flags = PERF_IP_FLAG_BRANCH |
+					PERF_IP_FLAG_RETURN;
+		break;
+	case CS_ETM_DISCONTINUITY:
+	case CS_ETM_EXCEPTION:
+	case CS_ETM_EXCEPTION_RET:
+	case CS_ETM_EMPTY:
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_auxtrace *etm = etmq->etm;
@@ -1158,6 +1233,17 @@ static int cs_etm__run_decoder(struct cs_etm_queue *etmq)
 					 */
 					break;
 
+				/*
+				 * Since packet addresses are swapped in packet
+				 * handling within below switch() statements,
+				 * thus setting sample flags must be called
+				 * prior to switch() statement to use address
+				 * information before packets swapping.
+				 */
+				err = cs_etm__set_sample_flags(etmq);
+				if (err < 0)
+					break;
+
 				switch (etmq->packet->sample_type) {
 				case CS_ETM_RANGE:
 					/*
