Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244CAC61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C3D20850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jxwOsEBj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfASBoO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:44:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33686 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727713AbfASBoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:44:13 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so7114324plo.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XJIZCAPULyAuE6ru9p7H4wc2p68zHe0RBmLv7q7ns4s=;
        b=jxwOsEBjpjW0GJM/td1qH6zm7wudD+4sCp+8LXIz47JqSIhwAYsVSdJMNFpmXa/Gla
         gXQ8sbU+tXqH2huWye7ZW+i+yzoLz/8MHpjFQXGqqXrsWCjt/7/K9XlkWQuPD4IwL78R
         9GKQY/WlRP/b+G0i5FVvT3xxK9hJP5yXG0u/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XJIZCAPULyAuE6ru9p7H4wc2p68zHe0RBmLv7q7ns4s=;
        b=N20tDkKTGjDtx6GosHhxQvCpQMFV4RIN/Sy5O0UDy+cMYHcUMbbY4YHFdylWJ9zW4c
         ZWgYxbqH+wrkLrgKbJycxiJlwZwi7udKkJVo5LmBompRrrzvSgC80fTuUe69KHS3KpL/
         r31nWyjdQJ9FDTKvBnxc095qnjn1NQil7ZRyDNJ8RQTHuZHo1JFBQa7MGRwRdNxUCgbH
         +ziSO7WFcUKMhlxIDwKAZl+UwsEIHrZ58byY1U3wrdAOyl0y+5aeShOCwd4uAYOIog7Q
         Bk5pYLbnE4MYsaNIXjSevPmlv5352UKssZUpr7Muf2H25iuZXoP4z1DyUTcpAdP6gt7Z
         qnKA==
X-Gm-Message-State: AJcUukfy47ljqZEH83oRB7+x1pbUzEd7VL0qH3ODyiL5L3CGJ361HRnp
        zn6e6kkYkaoGRnT/WDThzH9QZQ==
X-Google-Smtp-Source: ALg8bN7ukwSnwooLMcnROslY/XDuGYQ3Z/QZowUUmmmEf7VONnwckZrXcMcFeww2WvgLmq3sz55lvw==
X-Received: by 2002:a17:902:b48b:: with SMTP id y11mr20633017plr.200.1547862252857;
        Fri, 18 Jan 2019 17:44:12 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:44:12 -0800 (PST)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 2/8] perf cs-etm: Set sample flags for instruction range packet
Date:   Sat, 19 Jan 2019 09:43:41 +0800
Message-Id: <20190119014347.27441-3-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf sample data contains flags to indicate the hardware trace data
is belonging to which type branch instruction, thus this can be used to
print out the human readable string.  Arm CoreSight ETM sample data is
missed to set flags and it is always set to zeros, this results in perf
tool skips to print string for instruction types.

This patch is to set branch instruction flags for instruction range
packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../perf/util/cs-etm-decoder/cs-etm-decoder.c |  2 +
 .../perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 tools/perf/util/cs-etm.c                      | 90 ++++++++++++++++++-
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
-- 
2.17.1

