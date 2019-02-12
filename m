Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4399C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B9F222C1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNW+frnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731874AbfBLRRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:17:14 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34539 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbfBLRQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:16:28 -0500
Received: by mail-pg1-f194.google.com with SMTP id i130so1289820pgd.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qBtfkm7Aoo/feOhhrqKL+o79kVL9oAED5/pempgClW0=;
        b=YNW+frnJ9THIpOHeaU5fgArgePOQEKFlNjaVyZRq0kxYox0+IOtEf1dCefvA8AmCe9
         5dKqrLcEfHG+PRAOLifcCHs3cwveSA61uCPiKajFcdbUVxtU1U5dAwbJv1+qZmPzvIBq
         6yc5gCOluL9Qxj3150ZCPfilXEHNoqEE2opjz/4ziZO1c9Ol6X+oNS34Fu6KguY7ueWh
         6j4ga0u9X6w3sPPPvg6dGIS2+CJu1755RNqQz3tVECFkRT8UwPIPb5WopG1ORVZDiIrt
         mxR74coqJuZcQjGMj3dTLjMfMaMRHc9eDwgaUawrTWU7qfHNBBHL+vUpPQzOOTvHGG1R
         LLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qBtfkm7Aoo/feOhhrqKL+o79kVL9oAED5/pempgClW0=;
        b=XmvXqa/3NQZFgmktv5EJcjZrw2m56IDpngpyYVH5STcjzBmhWN1smV/e6G7krw3kZj
         pBoRfaXd2x6N9HbcqFRipR5KkS/DoI/Cf+FZKgyOeedHBJeGo7+SDCL7ML4gXY6S5axn
         mDte9mNnl8q5SKeCbEq3T7cvESTjOG2FaT2ekTwPoUQ6/w/GCiRzF5k8kEwrf8WkBAl8
         jr8TvI/wg6IMFOOtrk4qROxiW/T9RlqE/HbBA5JJRiSZgwZPlg6+dGXcbF6wdWLLzXMH
         NCc8kxR+JlGQ8LzIFhIBysFfiD7R6XuaWn1ncwVvBvbEy6FC1o2nwUVzg+yN2njbEpJW
         o/7w==
X-Gm-Message-State: AHQUAuYf2J7uSp2YNsTlbIv0E7I+XvB1edaChvqdtXlvYacThGp8yrOc
        VDCRb02C9HKoo8B5hsbaZw9xM+ccaEs=
X-Google-Smtp-Source: AHgI3IZ2iCMUKqBh9euSozlCoP/28cyKZPgHzEI4Bhc+SNQoX3S7iJ7VSzExn2K9y6r58QZ8y3wqXg==
X-Received: by 2002:a62:7086:: with SMTP id l128mr4957980pfc.68.1549991787247;
        Tue, 12 Feb 2019 09:16:27 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id z4sm8659231pgu.10.2019.02.12.09.16.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 09:16:26 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     acme@kernel.org
Cc:     suzuki.poulose@arm.com, mingo@redhat.com, peterz@infradead.org,
        jolsa@redhat.com, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] perf tools: Introducing function cs_etm__init_trace_params()
Date:   Tue, 12 Feb 2019 10:16:11 -0700
Message-Id: <20190212171618.25355-7-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212171618.25355-1-mathieu.poirier@linaro.org>
References: <20190212171618.25355-1-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace parameter initialisation code is repeated in two different
places, something that bloats the file and can lead to errors.  This
is fixed by introducing a helper function and calling the right
protocol initialisation code when required.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 tools/perf/util/cs-etm.c | 112 +++++++++++++++++++--------------------
 tools/perf/util/cs-etm.h |   4 +-
 2 files changed, 58 insertions(+), 58 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index aac07f950074..f3a6dfaf3026 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -136,6 +136,57 @@ static void cs_etm__packet_dump(const char *pkt_string)
 	fflush(stdout);
 }
 
+static void cs_etm__set_trace_param_etmv3(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx,
+					  u32 etmidr)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = cs_etm__get_v7_protocol_version(etmidr);
+	t_params[idx].etmv3.reg_ctrl = metadata[idx][CS_ETM_ETMCR];
+	t_params[idx].etmv3.reg_trc_id = metadata[idx][CS_ETM_ETMTRACEIDR];
+}
+
+static void cs_etm__set_trace_param_etmv4(struct cs_etm_trace_params *t_params,
+					  struct cs_etm_auxtrace *etm, int idx)
+{
+	u64 **metadata = etm->metadata;
+
+	t_params[idx].protocol = CS_ETM_PROTO_ETMV4i;
+	t_params[idx].etmv4.reg_idr0 = metadata[idx][CS_ETMV4_TRCIDR0];
+	t_params[idx].etmv4.reg_idr1 = metadata[idx][CS_ETMV4_TRCIDR1];
+	t_params[idx].etmv4.reg_idr2 = metadata[idx][CS_ETMV4_TRCIDR2];
+	t_params[idx].etmv4.reg_idr8 = metadata[idx][CS_ETMV4_TRCIDR8];
+	t_params[idx].etmv4.reg_configr = metadata[idx][CS_ETMV4_TRCCONFIGR];
+	t_params[idx].etmv4.reg_traceidr = metadata[idx][CS_ETMV4_TRCTRACEIDR];
+}
+
+static int cs_etm__init_trace_params(struct cs_etm_trace_params *t_params,
+				     struct cs_etm_auxtrace *etm)
+{
+	int i;
+	u32 etmidr;
+	u64 architecture;
+
+	for (i = 0; i < etm->num_cpu; i++) {
+		architecture = etm->metadata[i][CS_ETM_MAGIC];
+
+		switch (architecture) {
+		case __perf_cs_etmv3_magic:
+			etmidr = etm->metadata[i][CS_ETM_ETMIDR];
+			cs_etm__set_trace_param_etmv3(t_params, etm, i, etmidr);
+			break;
+		case __perf_cs_etmv4_magic:
+			cs_etm__set_trace_param_etmv4(t_params, etm, i);
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
 static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 				       struct cs_etm_queue *etmq,
 				       enum cs_etm_decoder_operation mode)
@@ -161,7 +212,7 @@ static int cs_etm__init_decoder_params(struct cs_etm_decoder_params *d_params,
 static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 			       struct auxtrace_buffer *buffer)
 {
-	int i, ret;
+	int ret;
 	const char *color = PERF_COLOR_BLUE;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params *t_params;
@@ -179,33 +230,8 @@ static void cs_etm__dump_event(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		return;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-						      __perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, NULL,
@@ -382,7 +408,6 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u64 address,
 static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 						unsigned int queue_nr)
 {
-	int i;
 	struct cs_etm_decoder_params d_params;
 	struct cs_etm_trace_params  *t_params = NULL;
 	struct cs_etm_queue *etmq;
@@ -431,33 +456,8 @@ static struct cs_etm_queue *cs_etm__alloc_queue(struct cs_etm_auxtrace *etm,
 	if (!t_params)
 		goto out_free;
 
-	for (i = 0; i < etm->num_cpu; i++) {
-		if (etm->metadata[i][CS_ETM_MAGIC] == __perf_cs_etmv3_magic) {
-			u32 etmidr = etm->metadata[i][CS_ETM_ETMIDR];
-
-			t_params[i].protocol =
-					cs_etm__get_v7_protocol_version(etmidr);
-			t_params[i].etmv3.reg_ctrl =
-					etm->metadata[i][CS_ETM_ETMCR];
-			t_params[i].etmv3.reg_trc_id =
-					etm->metadata[i][CS_ETM_ETMTRACEIDR];
-		} else if (etm->metadata[i][CS_ETM_MAGIC] ==
-							__perf_cs_etmv4_magic) {
-			t_params[i].protocol = CS_ETM_PROTO_ETMV4i;
-			t_params[i].etmv4.reg_idr0 =
-					etm->metadata[i][CS_ETMV4_TRCIDR0];
-			t_params[i].etmv4.reg_idr1 =
-					etm->metadata[i][CS_ETMV4_TRCIDR1];
-			t_params[i].etmv4.reg_idr2 =
-					etm->metadata[i][CS_ETMV4_TRCIDR2];
-			t_params[i].etmv4.reg_idr8 =
-					etm->metadata[i][CS_ETMV4_TRCIDR8];
-			t_params[i].etmv4.reg_configr =
-					etm->metadata[i][CS_ETMV4_TRCCONFIGR];
-			t_params[i].etmv4.reg_traceidr =
-					etm->metadata[i][CS_ETMV4_TRCTRACEIDR];
-		}
-	}
+	if (cs_etm__init_trace_params(t_params, etm))
+		goto out_free;
 
 	/* Set decoder parameters to simply print the trace packets */
 	if (cs_etm__init_decoder_params(&d_params, etmq,
diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
index d76126e0e3d0..0e97c196147a 100644
--- a/tools/perf/util/cs-etm.h
+++ b/tools/perf/util/cs-etm.h
@@ -105,8 +105,8 @@ struct intlist *traceid_list;
 
 #define CS_ETM_HEADER_SIZE (CS_HEADER_VERSION_0_MAX * sizeof(u64))
 
-static const u64 __perf_cs_etmv3_magic   = 0x3030303030303030ULL;
-static const u64 __perf_cs_etmv4_magic   = 0x4040404040404040ULL;
+#define __perf_cs_etmv3_magic 0x3030303030303030ULL
+#define __perf_cs_etmv4_magic 0x4040404040404040ULL
 #define CS_ETMV3_PRIV_SIZE (CS_ETM_PRIV_MAX * sizeof(u64))
 #define CS_ETMV4_PRIV_SIZE (CS_ETMV4_PRIV_MAX * sizeof(u64))
 
-- 
2.17.1

