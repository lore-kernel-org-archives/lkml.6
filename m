Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E105C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:53:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8A9F20855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbfBIMxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:53:44 -0500
Received: from terminus.zytor.com ([198.137.202.136]:47819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:53:44 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CrWCM2633011
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:53:32 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CrVMd2633008;
        Sat, 9 Feb 2019 04:53:31 -0800
Date:   Sat, 9 Feb 2019 04:53:31 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-47106e7413f9fc10780d1ec7df3eaa725df6ebe8@git.kernel.org>
Cc:     mathieu.poirier@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        robert.walker@arm.com, suzuki.poulose@arm.com,
        mike.leach@linaro.org, jolsa@redhat.com, acme@redhat.com,
        namhyung@kernel.org, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, hpa@zytor.com, coresight@lists.linaro.org
Reply-To: jolsa@redhat.com, mike.leach@linaro.org, suzuki.poulose@arm.com,
          coresight@lists.linaro.org, leo.yan@linaro.org, hpa@zytor.com,
          acme@redhat.com, namhyung@kernel.org,
          alexander.shishkin@linux.intel.com, linux-kernel@vger.kernel.org,
          mingo@kernel.org, mathieu.poirier@linaro.org,
          robert.walker@arm.com, tglx@linutronix.de
In-Reply-To: <20190129122842.32041-5-leo.yan@linaro.org>
References: <20190129122842.32041-5-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add exception number in exception
 packet
Git-Commit-ID: 47106e7413f9fc10780d1ec7df3eaa725df6ebe8
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

Commit-ID:  47106e7413f9fc10780d1ec7df3eaa725df6ebe8
Gitweb:     https://git.kernel.org/tip/47106e7413f9fc10780d1ec7df3eaa725df6ebe8
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 29 Jan 2019 20:28:38 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf cs-etm: Add exception number in exception packet

When an exception packet comes, it contains the information for
exception number; the exception number indicates the exception types, so
from it we can know if the exception is taken for interrupt, system call
or other traps, etc.

This patch simply adds a field in cs_etm_packet struct, it records
exception number for exception packet that will then be used to properly
identify exception types to the perf synthesize mechanic.

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
Link: http://lkml.kernel.org/r/20190129122842.32041-5-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 20 ++++++++++++++++----
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h |  1 +
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index e98ee49a1527..294efa76c9e3 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -294,6 +294,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_subtype = 0;
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
+		decoder->packet_buffer[i].exception_number = UINT32_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_subtype = 0;
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
+	decoder->packet_buffer[et].exception_number = UINT32_MAX;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
@@ -406,10 +408,20 @@ cs_etm_decoder__buffer_discontinuity(struct cs_etm_decoder *decoder,
 
 static ocsd_datapath_resp_t
 cs_etm_decoder__buffer_exception(struct cs_etm_decoder *decoder,
+				 const ocsd_generic_trace_elem *elem,
 				 const uint8_t trace_chan_id)
-{
-	return cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
-					     CS_ETM_EXCEPTION);
+{	int ret = 0;
+	struct cs_etm_packet *packet;
+
+	ret = cs_etm_decoder__buffer_packet(decoder, trace_chan_id,
+					    CS_ETM_EXCEPTION);
+	if (ret != OCSD_RESP_CONT && ret != OCSD_RESP_WAIT)
+		return ret;
+
+	packet = &decoder->packet_buffer[decoder->tail];
+	packet->exception_number = elem->exception_number;
+
+	return ret;
 }
 
 static ocsd_datapath_resp_t
@@ -443,7 +455,7 @@ static ocsd_datapath_resp_t cs_etm_decoder__gen_trace_elem_printer(
 						    trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION:
-		resp = cs_etm_decoder__buffer_exception(decoder,
+		resp = cs_etm_decoder__buffer_exception(decoder, elem,
 							trace_chan_id);
 		break;
 	case OCSD_GEN_TRC_ELEM_EXCEPTION_RET:
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 23600e57a215..012b4728a46f 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -46,6 +46,7 @@ struct cs_etm_packet {
 	u32 last_instr_type;
 	u32 last_instr_subtype;
 	u32 flags;
+	u32 exception_number;
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
