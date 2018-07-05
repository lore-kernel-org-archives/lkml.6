Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC141C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A729520847
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fI6QMaSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A729520847
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754616AbeGENOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:14:41 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36617 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754195AbeGENFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:05:12 -0400
Received: by mail-wm0-f68.google.com with SMTP id s14-v6so10732505wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 06:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Rjs/riZGr/2boEAWhRGcdDD/iS7glDtXPe+puCnQcc=;
        b=fI6QMaSXVEUj4pi6HST0HtUEy1jU0Txb1l5V5fwAz8pLb+woTfyCHWnmENfX1NYNvS
         lRFY4DiR0CEB7uGtkBCpErNYQT04hL02RausIn8D4eBw2M2z+d0hzvChjLjILl9XcRx+
         z0rjn2B1OQ5XP5vXgyQR1qVR3ryXZJthAwB38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Rjs/riZGr/2boEAWhRGcdDD/iS7glDtXPe+puCnQcc=;
        b=fwqbRDphDwn1UXBjY8m7uoQ+Qlk/mZQBq40KRUOTR1pJH0K4k3ZCccxzW2Vi9U5s6l
         W40XTw/oG+OercOYbg03PYSWwzHVeVzyL/IVgFRetZFogH8Tr0DCHote7RrgjuyUsC6N
         h1jsAUBz0tcjfLn19RsVAfD5hEVrxYWyRQwVN9vsqUka//6XEFVZAJuJNwIlO1KzrHyi
         ohXs8GOezEsvCExgj45HwfCZ3l/Oc/R5bvfonBo0cuS+eFZSWdIKl6mqFFq897dG02Wt
         TIVWCJQ4oxpqfgvDz62OkBwtaAJ8R1QRUJQ/CjK6rYDaBpoOQsprctfzqNK9kSLp6A+Y
         qfGA==
X-Gm-Message-State: APt69E3qNoqw8MZg9a5Ow867byve9zU1kAFfUJ+M2YSZ+H4g7zQ8qJfW
        7+6cFwrXxaoqoH1KpCae666+TA==
X-Google-Smtp-Source: AAOMgpdDG1JbkCIuwDI8BK2YRDQ3vpVrl9ZIMp0+I2IUQeasJxrss8RXL2qp0qt0dpxuClfPuUj5GA==
X-Received: by 2002:a1c:aacf:: with SMTP id t198-v6mr3838721wme.109.1530795910894;
        Thu, 05 Jul 2018 06:05:10 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id 11-v6sm2109102wrw.67.2018.07.05.06.05.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 06:05:10 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v5 04/27] venus: hfi_cmds: add set_properties for 4xx version
Date:   Thu,  5 Jul 2018 16:03:38 +0300
Message-Id: <20180705130401.24315-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
References: <20180705130401.24315-1-stanimir.varbanov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds set_properties method to handle newer 4xx properties and
fall-back to 3xx for the rest.

Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
---
 drivers/media/platform/qcom/venus/hfi_cmds.c | 62 +++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
index 1cfeb7743041..e8389d8d8c48 100644
--- a/drivers/media/platform/qcom/venus/hfi_cmds.c
+++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
@@ -1166,6 +1166,63 @@ pkt_session_set_property_3xx(struct hfi_session_set_property_pkt *pkt,
 	return ret;
 }
 
+static int
+pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
+			     void *cookie, u32 ptype, void *pdata)
+{
+	void *prop_data;
+
+	if (!pkt || !cookie || !pdata)
+		return -EINVAL;
+
+	prop_data = &pkt->data[1];
+
+	pkt->shdr.hdr.size = sizeof(*pkt);
+	pkt->shdr.hdr.pkt_type = HFI_CMD_SESSION_SET_PROPERTY;
+	pkt->shdr.session_id = hash32_ptr(cookie);
+	pkt->num_properties = 1;
+	pkt->data[0] = ptype;
+
+	/*
+	 * Any session set property which is different in 3XX packetization
+	 * should be added as a new case below. All unchanged session set
+	 * properties will be handled in the default case.
+	 */
+	switch (ptype) {
+	case HFI_PROPERTY_PARAM_BUFFER_COUNT_ACTUAL: {
+		struct hfi_buffer_count_actual *in = pdata;
+		struct hfi_buffer_count_actual_4xx *count = prop_data;
+
+		count->count_actual = in->count_actual;
+		count->type = in->type;
+		count->count_min_host = in->count_actual;
+		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*count);
+		break;
+	}
+	case HFI_PROPERTY_PARAM_WORK_MODE: {
+		struct hfi_video_work_mode *in = pdata, *wm = prop_data;
+
+		wm->video_work_mode = in->video_work_mode;
+		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*wm);
+		break;
+	}
+	case HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE: {
+		struct hfi_videocores_usage_type *in = pdata, *cu = prop_data;
+
+		cu->video_core_enable_mask = in->video_core_enable_mask;
+		pkt->shdr.hdr.size += sizeof(u32) + sizeof(*cu);
+		break;
+	}
+	case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
+		/* not implemented on Venus 4xx */
+		break;
+	default:
+		return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
+	}
+
+	return 0;
+}
+
 int pkt_session_get_property(struct hfi_session_get_property_pkt *pkt,
 			     void *cookie, u32 ptype)
 {
@@ -1181,7 +1238,10 @@ int pkt_session_set_property(struct hfi_session_set_property_pkt *pkt,
 	if (hfi_ver == HFI_VERSION_1XX)
 		return pkt_session_set_property_1x(pkt, cookie, ptype, pdata);
 
-	return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
+	if (hfi_ver == HFI_VERSION_3XX)
+		return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
+
+	return pkt_session_set_property_4xx(pkt, cookie, ptype, pdata);
 }
 
 void pkt_set_version(enum hfi_version version)
-- 
2.14.1

