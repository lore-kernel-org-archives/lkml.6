Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4810AC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:55:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C86320855
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 12:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBIMzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 07:55:05 -0500
Received: from terminus.zytor.com ([198.137.202.136]:55815 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbfBIMzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 07:55:05 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x19CsqE22633323
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Feb 2019 04:54:52 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x19CsprB2633320;
        Sat, 9 Feb 2019 04:54:51 -0800
Date:   Sat, 9 Feb 2019 04:54:51 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-03919e526b29be8d0c77142e008b397a2c089398@git.kernel.org>
Cc:     coresight@lists.linaro.org, jolsa@redhat.com, leo.yan@linaro.org,
        robert.walker@arm.com, mathieu.poirier@linaro.org, acme@redhat.com,
        mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, tglx@linutronix.de, suzuki.poulose@arm.com,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
          suzuki.poulose@arm.com, tglx@linutronix.de, namhyung@kernel.org,
          mathieu.poirier@linaro.org, acme@redhat.com,
          mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
          robert.walker@arm.com, coresight@lists.linaro.org,
          jolsa@redhat.com, leo.yan@linaro.org
In-Reply-To: <20190129122842.32041-7-leo.yan@linaro.org>
References: <20190129122842.32041-7-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Add traceID in packet
Git-Commit-ID: 03919e526b29be8d0c77142e008b397a2c089398
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

Commit-ID:  03919e526b29be8d0c77142e008b397a2c089398
Gitweb:     https://git.kernel.org/tip/03919e526b29be8d0c77142e008b397a2c089398
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 29 Jan 2019 20:28:40 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 6 Feb 2019 10:00:40 -0300

perf cs-etm: Add traceID in packet

Add traceID in packet, thus we can use traceID to retrieve metadata
pointer from traceID-metadata tuple.

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
Link: http://lkml.kernel.org/r/20190129122842.32041-7-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 2 ++
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index cdd38ffd10d2..ba4c623cd8de 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -295,6 +295,7 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 		decoder->packet_buffer[i].last_instr_cond = 0;
 		decoder->packet_buffer[i].flags = 0;
 		decoder->packet_buffer[i].exception_number = UINT32_MAX;
+		decoder->packet_buffer[i].trace_chan_id = UINT8_MAX;
 		decoder->packet_buffer[i].cpu = INT_MIN;
 	}
 }
@@ -331,6 +332,7 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].last_instr_cond = 0;
 	decoder->packet_buffer[et].flags = 0;
 	decoder->packet_buffer[et].exception_number = UINT32_MAX;
+	decoder->packet_buffer[et].trace_chan_id = trace_chan_id;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
index 012b4728a46f..7e6a8850be4a 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
@@ -50,6 +50,7 @@ struct cs_etm_packet {
 	u8 last_instr_cond;
 	u8 last_instr_taken_branch;
 	u8 last_instr_size;
+	u8 trace_chan_id;
 	int cpu;
 };
 
