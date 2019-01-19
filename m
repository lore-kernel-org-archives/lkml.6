Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B223AC61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6B820850
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 01:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PiMbxk9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730312AbfASBoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 20:44:20 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33840 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbfASBoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 20:44:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so7105132plz.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 17:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apzqr2DPBRKwMWYdw7mN2gcZix8iFxXQD+UIs2uAD/8=;
        b=PiMbxk9o8YY2tVjT3ff/E+/k0qmzfKhgGNsgDhImweyyi3d6rdLRJL2sTjMAjzFyx3
         kNoFWUkUmRpDfUJGqWEtwRE5WiItb8AOQRRnrGKmMgSG9N5WulWUt4ln5TA6zoeBlKxm
         2k3tLnjb+Cc5RyA8fu959FOaaWTwFmPK+7zWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apzqr2DPBRKwMWYdw7mN2gcZix8iFxXQD+UIs2uAD/8=;
        b=se8Wj2gdADGecgj9XDTaQPBNNPUmt6bPAh49z3pjiFMUn89J2OoDWq8v0e9vI/0ps8
         tQ/wlak7tyNc7krGu6pFLCLZcqWetGsE0k1HIJ7sBksN2Ox/Ik2fMaVmefUWIUREqplm
         BAFMgiYS7h/L20kPxPkURnv/JNvmJd35bV5I212R/oc1a1AKYeMQTdc9GlJIb6zDRBck
         7JcZn/QV9ofiEacLxAyK2TSRT6Xk1BJOOdVZfbqp/PjpcepL0NW15Qcx5YGtL556Q3Cx
         QHYzVccq5SHzeT5P5T0/wv0+2H3rO7Pb++evKsUoKNE49s6VqVy4LeujiRJdFfDoFBl6
         8ovg==
X-Gm-Message-State: AJcUukcjgEZpgZ5JdHmblKjZS/Sx1UNlx5p2rOP5NCBXQ9bjoRDlTcFs
        UePxUhuCHrMdnHC7Vre5FwUeSA==
X-Google-Smtp-Source: ALg8bN7L0udZa+Jgulh1FhMV7DgtEu9RnqPT47+s4IM+f4moeb7hKUvS8qH7Oq64zzeIW9ntvKZfnA==
X-Received: by 2002:a17:902:2969:: with SMTP id g96mr21194637plb.295.1547862256537;
        Fri, 18 Jan 2019 17:44:16 -0800 (PST)
Received: from localhost.localdomain (li421-24.members.linode.com. [50.116.3.24])
        by smtp.gmail.com with ESMTPSA id d21sm8648436pfo.162.2019.01.18.17.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 17:44:15 -0800 (PST)
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
Subject: [PATCH v6 3/8] perf cs-etm: Set sample flags for trace discontinuity
Date:   Sat, 19 Jan 2019 09:43:42 +0800
Message-Id: <20190119014347.27441-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190119014347.27441-1-leo.yan@linaro.org>
References: <20190119014347.27441-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the middle of trace stream, it might be interrupted thus the trace
data is not continuous, the trace stream firstly is ended for previous
trace block and restarted for next block.

To display related information for showing trace is restarted, this
patch set sample flags for trace discontinuity:

- If one discontinuity packet is coming, append flag
  PERF_IP_FLAG_TRACE_END to the previous packet to indicate the trace
  has been ended;
- If one instruction packet is following discontinuity packet, this
  instruction packet is the first one packet to restarting trace.  So
  set flag PERF_IP_FLAG_TRACE_START to discontinuity packet, this flag
  will be used to generate sample when connect with the sequential
  instruction packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/cs-etm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index d05cac5295f1..1aa29633ce77 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1111,6 +1111,7 @@ static int cs_etm__end_block(struct cs_etm_queue *etmq)
 static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 {
 	struct cs_etm_packet *packet = etmq->packet;
+	struct cs_etm_packet *prev_packet = etmq->prev_packet;
 
 	switch (packet->sample_type) {
 	case CS_ETM_RANGE:
@@ -1170,8 +1171,26 @@ static int cs_etm__set_sample_flags(struct cs_etm_queue *etmq)
 		    packet->last_instr_subtype == OCSD_S_INSTR_V8_RET)
 			packet->flags = PERF_IP_FLAG_BRANCH |
 					PERF_IP_FLAG_RETURN;
+
+		/*
+		 * Decoder might insert a discontinuity in the middle of
+		 * instruction packets, fixup prev_packet with flag
+		 * PERF_IP_FLAG_TRACE_BEGIN to indicate restarting trace.
+		 */
+		if (prev_packet->sample_type == CS_ETM_DISCONTINUITY)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_BEGIN;
 		break;
 	case CS_ETM_DISCONTINUITY:
+		/*
+		 * The trace is discontinuous, if the previous packet is
+		 * instruction packet, set flag PERF_IP_FLAG_TRACE_END
+		 * for previous packet.
+		 */
+		if (prev_packet->sample_type == CS_ETM_RANGE)
+			prev_packet->flags |= PERF_IP_FLAG_BRANCH |
+					      PERF_IP_FLAG_TRACE_END;
+		break;
 	case CS_ETM_EXCEPTION:
 	case CS_ETM_EXCEPTION_RET:
 	case CS_ETM_EMPTY:
-- 
2.17.1

