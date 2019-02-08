Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3E9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2498220855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:22:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NRfnV9a5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBHRWG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:22:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51802 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbfBHRWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:22:01 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so4287198wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 09:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ELIDzrFuDE4fv0H7ZmmXRZO/WnsGeJX4P6W+1XXVUI=;
        b=NRfnV9a540UmNDKscNJAOYXOcEyFaaX8bPbnN++HLDJnypKbdEz6liciFdRn1wcNfi
         PGUHa4X+nTbJuFKsM6OXlu8ssaLc0mgIh+bdoxtjsAweLEQZmfJ+mkyGlAU38d0brE55
         xjAV8U3Ej3uPiRhFaYsZ6svKUA0jzzdTONgMwWk0Y20lmjmjr75HWi+bt/7bLodDvwBg
         qmNVkPO6qD9OgGDp+OgtiBt5kd7pGcFF53ph03VnYe2baWXVbofhnvYHQjghX387wCxT
         vCzSZXZy9p3kYhvb0Gf03Ev65jet852z+os9RYnpCJnF2JIWCxZqAmLb0Gh4utqi+Vjk
         skxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ELIDzrFuDE4fv0H7ZmmXRZO/WnsGeJX4P6W+1XXVUI=;
        b=MYXosN0OT1VOHTL7uWg9PGhkxOsDqknUfC2E0zrtZqeGbpnldi7rRdAl4wM57pvnag
         8o9AH3xoJYZH46GV//TESgdyjNFjGaYVv8efjPfCLhczNzk4C6xE/AeAa8G05mO2mPH+
         7rKcFjHDvhSXzWRGDbiTf1Wzaq6Y52Z0pT0HDvRYw6zB6+g7J8fWBXU/95zLtH+GnAHi
         7qO5Gh8R47RSqSNIy55B7s7u7sODDijKDAbobEwxE9Cnba+s7x6BShSsFrDTElFLzT44
         wvtbg2DelD1C+95SoNHdkOdWQlI7gf5Ip5wQFmQqIx/Qc2gkNzDDuBMlMXLhjzFLPPm0
         RVdw==
X-Gm-Message-State: AHQUAuaEEwat5v1A7XWTWy5GJCud3F1aqp8+ayuc6c6KdQSImmNIPrvD
        pwx46BR7206X5PL1ij9cTQfN9w==
X-Google-Smtp-Source: AHgI3IaR1xFVAO9b2qxaU0otLVQUTY6EsoNLrmwz4hZ6r6RNdzpR5VBVU2tncDgrUueX3odkeTfxtQ==
X-Received: by 2002:a05:6000:120a:: with SMTP id e10mr17621512wrx.85.1549646518598;
        Fri, 08 Feb 2019 09:21:58 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k23sm4097150wmj.32.2019.02.08.09.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Feb 2019 09:21:57 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     daidavid1@codeaurora.org, vincent.guittot@linaro.org,
        bjorn.andersson@linaro.org, amit.kucheria@linaro.org,
        evgreen@chromium.org, dianders@chromium.org,
        seansw@qti.qualcomm.com, mturquette@baylibre.com,
        abailon@baylibre.com, thierry.reding@gmail.com,
        ksitaraman@nvidia.com, sanjayc@nvidia.com,
        henryc.chen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org
Subject: [PATCH v1 2/2] interconnect: qcom: Add tagging and wake/sleep support for sdm845
Date:   Fri,  8 Feb 2019 19:21:52 +0200
Message-Id: <20190208172152.1807-3-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190208172152.1807-1-georgi.djakov@linaro.org>
References: <20190208172152.1807-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Dai <daidavid1@codeaurora.org>

Add support for wake and sleep commands by using a tag to indicate
whether or not the aggregate and set requests are active only or
dual context for a particular path.

Signed-off-by: David Dai <daidavid1@codeaurora.org>
Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 101 +++++++++++++++++++++--------
 1 file changed, 75 insertions(+), 26 deletions(-)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index fb526004c82e..13499f681160 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -65,6 +65,12 @@ struct bcm_db {
 #define SDM845_MAX_BCMS		30
 #define SDM845_MAX_BCM_PER_NODE	2
 #define SDM845_MAX_VCD		10
+#define SDM845_MAX_CTX		2
+#define SDM845_EE_STATE		2
+#define EE_STATE_WAKE		0
+#define EE_STATE_SLEEP		1
+#define AO_CTX			0
+#define DUAL_CTX		1
 
 /**
  * struct qcom_icc_node - Qualcomm specific interconnect nodes
@@ -86,8 +92,8 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
-	u64 sum_avg;
-	u64 max_peak;
+	u64 sum_avg[SDM845_MAX_CTX];
+	u64 max_peak[SDM845_MAX_CTX];
 	struct qcom_icc_bcm *bcms[SDM845_MAX_BCM_PER_NODE];
 	size_t num_bcms;
 };
@@ -112,8 +118,8 @@ struct qcom_icc_bcm {
 	const char *name;
 	u32 type;
 	u32 addr;
-	u64 vote_x;
-	u64 vote_y;
+	u64 vote_x[SDM845_EE_STATE];
+	u64 vote_y[SDM845_EE_STATE];
 	bool dirty;
 	bool keepalive;
 	struct bcm_db aux_data;
@@ -555,7 +561,7 @@ inline void tcs_cmd_gen(struct tcs_cmd *cmd, u64 vote_x, u64 vote_y,
 		cmd->wait = true;
 }
 
-static void tcs_list_gen(struct list_head *bcm_list,
+static void tcs_list_gen(struct list_head *bcm_list, int ee_state,
 			 struct tcs_cmd tcs_list[SDM845_MAX_VCD],
 			 int n[SDM845_MAX_VCD])
 {
@@ -573,8 +579,8 @@ static void tcs_list_gen(struct list_head *bcm_list,
 			commit = true;
 			cur_vcd_size = 0;
 		}
-		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x, bcm->vote_y,
-			    bcm->addr, commit);
+		tcs_cmd_gen(&tcs_list[idx], bcm->vote_x[ee_state],
+			    bcm->vote_y[ee_state], bcm->addr, commit);
 		idx++;
 		n[batch]++;
 		/*
@@ -595,32 +601,42 @@ static void tcs_list_gen(struct list_head *bcm_list,
 
 static void bcm_aggregate(struct qcom_icc_bcm *bcm)
 {
-	size_t i;
-	u64 agg_avg = 0;
-	u64 agg_peak = 0;
+	size_t i, ctx;
+	u64 agg_avg[SDM845_MAX_CTX] = {0};
+	u64 agg_peak[SDM845_MAX_CTX] = {0};
 	u64 temp;
 
-	for (i = 0; i < bcm->num_nodes; i++) {
-		temp = bcm->nodes[i]->sum_avg * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
-		agg_avg = max(agg_avg, temp);
+	for (ctx = 0; ctx < SDM845_MAX_CTX; ctx++) {
+		for (i = 0; i < bcm->num_nodes; i++) {
+			temp = bcm->nodes[i]->sum_avg[ctx] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth * bcm->nodes[i]->channels);
+			agg_avg[ctx] = max(agg_avg[ctx], temp);
 
-		temp = bcm->nodes[i]->max_peak * bcm->aux_data.width;
-		do_div(temp, bcm->nodes[i]->buswidth);
-		agg_peak = max(agg_peak, temp);
+			temp = bcm->nodes[i]->max_peak[ctx] * bcm->aux_data.width;
+			do_div(temp, bcm->nodes[i]->buswidth);
+			agg_peak[ctx] = max(agg_peak[ctx], temp);
+		}
 	}
 
-	temp = agg_avg * 1000ULL;
+	temp = agg_avg[AO_CTX] + agg_avg[DUAL_CTX] * 1000ULL;
+	do_div(temp, bcm->aux_data.unit);
+	bcm->vote_x[EE_STATE_WAKE] = temp;
+
+	temp = max(agg_peak[AO_CTX], agg_peak[DUAL_CTX]) * 1000ULL;
+	do_div(temp, bcm->aux_data.unit);
+	bcm->vote_y[EE_STATE_WAKE] = temp;
+
+	temp = agg_avg[DUAL_CTX] * 1000ULL;
 	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_x = temp;
+	bcm->vote_x[EE_STATE_SLEEP] = temp;
 
-	temp = agg_peak * 1000ULL;
+	temp = agg_peak[DUAL_CTX] * 1000ULL;
 	do_div(temp, bcm->aux_data.unit);
-	bcm->vote_y = temp;
+	bcm->vote_y[EE_STATE_SLEEP] = temp;
 
 	if (bcm->keepalive && bcm->vote_x == 0 && bcm->vote_y == 0) {
-		bcm->vote_x = 1;
-		bcm->vote_y = 1;
+		bcm->vote_x[EE_STATE_WAKE] = 1;
+		bcm->vote_y[EE_STATE_WAKE] = 1;
 	}
 
 	bcm->dirty = false;
@@ -631,14 +647,16 @@ static int qcom_icc_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
 {
 	size_t i;
 	struct qcom_icc_node *qn;
+	u32 ctx = 0;
 
 	qn = node->data;
+	ctx = (!!tag) ? AO_CTX : DUAL_CTX;
 
 	*agg_avg += avg_bw;
 	*agg_peak = max_t(u32, *agg_peak, peak_bw);
 
-	qn->sum_avg = *agg_avg;
-	qn->max_peak = *agg_peak;
+	qn->sum_avg[ctx] = *agg_avg;
+	qn->max_peak[ctx] = *agg_peak;
 
 	for (i = 0; i < qn->num_bcms; i++)
 		qn->bcms[i]->dirty = true;
@@ -675,7 +693,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 	 * Construct the command list based on a pre ordered list of BCMs
 	 * based on VCD.
 	 */
-	tcs_list_gen(&commit_list, cmds, commit_idx);
+	tcs_list_gen(&commit_list, EE_STATE_WAKE, cmds, commit_idx);
 
 	if (!commit_idx[0])
 		return ret;
@@ -693,6 +711,37 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		return ret;
 	}
 
+	INIT_LIST_HEAD(&commit_list);
+
+	for (i = 0; i < qp->num_bcms; i++) {
+		/* Only generate WAKE and SLEEP commands if a resource's
+		 * requirements change as the execution environment transitions
+		 * between different power states.
+		 */
+		if (qp->bcms[i]->vote_x[EE_STATE_WAKE] !=
+		    qp->bcms[i]->vote_x[EE_STATE_SLEEP] ||
+		    qp->bcms[i]->vote_y[EE_STATE_WAKE] !=
+		    qp->bcms[i]->vote_y[EE_STATE_SLEEP]) {
+			list_add_tail(&qp->bcms[i]->list, &commit_list);
+		}
+	}
+
+	tcs_list_gen(&commit_list, EE_STATE_WAKE, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_WAKE_ONLY_STATE, cmds, commit_idx);
+	if (ret) {
+		dev_err(qp->dev, "Error sending WAKE RPMH requests: %d\n", ret);
+		return ret;
+	}
+
+	tcs_list_gen(&commit_list, EE_STATE_SLEEP, cmds, commit_idx);
+
+	ret = rpmh_write_batch(qp->dev, RPMH_SLEEP_STATE, cmds, commit_idx);
+	if (ret) {
+		dev_err(qp->dev, "Error sending SLEEP RPMH requests: %d\n", ret);
+		return ret;
+	}
+
 	return ret;
 }
 
