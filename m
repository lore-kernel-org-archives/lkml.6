Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E4DC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FCF20671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04FCF20671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731363AbeGYVyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:54:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730337AbeGYVyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:54:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6PKewOU498516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 25 Jul 2018 13:40:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6PKev3R498513;
        Wed, 25 Jul 2018 13:40:57 -0700
Date:   Wed, 25 Jul 2018 13:40:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-6abf0f451087176caf0f9ad0cc2a79bcc5ebb443@git.kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org,
        robert.walker@arm.com, namhyung@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, acme@redhat.com, kim.phillips@arm.com,
        mingo@kernel.org, leo.yan@linaro.org,
        alexander.shishkin@linux.intel.com
Reply-To: namhyung@kernel.org, peterz@infradead.org, tglx@linutronix.de,
          hpa@zytor.com, jolsa@redhat.com, linux-kernel@vger.kernel.org,
          robert.walker@arm.com, mike.leach@linaro.org, acme@redhat.com,
          mingo@kernel.org, kim.phillips@arm.com, leo.yan@linaro.org,
          alexander.shishkin@linux.intel.com, mathieu.poirier@linaro.org
In-Reply-To: <1529298599-3876-2-git-send-email-leo.yan@linaro.org>
References: <1529298599-3876-2-git-send-email-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf cs-etm: Introduce invalid address macro
Git-Commit-ID: 6abf0f451087176caf0f9ad0cc2a79bcc5ebb443
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

Commit-ID:  6abf0f451087176caf0f9ad0cc2a79bcc5ebb443
Gitweb:     https://git.kernel.org/tip/6abf0f451087176caf0f9ad0cc2a79bcc5ebb443
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Mon, 18 Jun 2018 13:09:54 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 24 Jul 2018 14:48:22 -0300

perf cs-etm: Introduce invalid address macro

This patch introduces invalid address macro and uses it to replace dummy
value '0xdeadbeefdeadbeefUL'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kim Phillips <kim.phillips@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Robert Walker <robert.walker@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/1529298599-3876-2-git-send-email-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
index 4d5fc374e730..938def6d0bb9 100644
--- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
+++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
@@ -31,6 +31,8 @@
 #endif
 #endif
 
+#define CS_ETM_INVAL_ADDR	0xdeadbeefdeadbeefUL
+
 struct cs_etm_decoder {
 	void *data;
 	void (*packet_printer)(const char *msg);
@@ -261,8 +263,8 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
 	decoder->tail = 0;
 	decoder->packet_count = 0;
 	for (i = 0; i < MAX_BUFFER; i++) {
-		decoder->packet_buffer[i].start_addr = 0xdeadbeefdeadbeefUL;
-		decoder->packet_buffer[i].end_addr = 0xdeadbeefdeadbeefUL;
+		decoder->packet_buffer[i].start_addr = CS_ETM_INVAL_ADDR;
+		decoder->packet_buffer[i].end_addr = CS_ETM_INVAL_ADDR;
 		decoder->packet_buffer[i].last_instr_taken_branch = false;
 		decoder->packet_buffer[i].exc = false;
 		decoder->packet_buffer[i].exc_ret = false;
@@ -295,8 +297,8 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
 	decoder->packet_buffer[et].exc = false;
 	decoder->packet_buffer[et].exc_ret = false;
 	decoder->packet_buffer[et].cpu = *((int *)inode->priv);
-	decoder->packet_buffer[et].start_addr = 0xdeadbeefdeadbeefUL;
-	decoder->packet_buffer[et].end_addr = 0xdeadbeefdeadbeefUL;
+	decoder->packet_buffer[et].start_addr = CS_ETM_INVAL_ADDR;
+	decoder->packet_buffer[et].end_addr = CS_ETM_INVAL_ADDR;
 
 	if (decoder->packet_count == MAX_BUFFER - 1)
 		return OCSD_RESP_WAIT;
