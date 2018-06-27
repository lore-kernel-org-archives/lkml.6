Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769BEC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3063026035
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hCuv2CtK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3063026035
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeF0Pf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:35:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54762 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934816AbeF0P2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:28:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id i139-v6so6278019wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Rjs/riZGr/2boEAWhRGcdDD/iS7glDtXPe+puCnQcc=;
        b=hCuv2CtK71qx8GGpe4YRlSobtrXClSJc4/fLMU7sVHLikFcXbDQpBf0su5Bl7Q662h
         vNv7fOt5ecYFpYfPWyS2KVIBwtpALoALFltCkZqGzkBAV4GF8cOD+p5yIBcpi0djjR1G
         1YC6BRPPHD7KOBP/tTauo3h+GNbka1S6/AiZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Rjs/riZGr/2boEAWhRGcdDD/iS7glDtXPe+puCnQcc=;
        b=jkFSVJ9LoDdxCFXnVAO1wCv+H99CD5pXz+4nsVFjLK1P2kKOqxRZe1TjRWOIwHqkqf
         URQ1ryt3fVUvSHQzjBD+BL8VE24HJYQaqcwp3K0FY2ke0lEEkHTRgDjZK9ZqPPtNSfqa
         nCCqOKC+qN2G6uek4XLrecpYFxre6bVeDJ/QogcEHgHVfOyI2Q2f1dxzeneIc8JkOu+4
         O0CK+fsL85Iab2wm6ZuNHABZcoo44yIqtAm8MwpctFyLv5GVTEbJwSl3ghK5zyIEfISh
         0TU0sGouOcpuNKXXO4Z6BD9ruVij+CGVh4EEvVGHvGJ8SOLRBH6ArVoCjbU5vKRuzT2l
         /c7Q==
X-Gm-Message-State: APt69E2+H3qdL9E86fNaOPEzOgA8S+SHKX9bSkRegX6sbSZ6q3AdhGkK
        TDrTUb1j7TstJ177DCWvL8JfqQ==
X-Google-Smtp-Source: AAOMgpdpkwEuwa1VUyS3mOLFt2VdOVqR0t6vZV15XB8b9PdVWiQcaKAGeR7yJ6r/06BoyENWL6J2aA==
X-Received: by 2002:a1c:b1d7:: with SMTP id a206-v6mr5512528wmf.61.1530113282349;
        Wed, 27 Jun 2018 08:28:02 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id o203-v6sm2916075wmd.30.2018.06.27.08.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 08:28:01 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v4 04/27] venus: hfi_cmds: add set_properties for 4xx version
Date:   Wed, 27 Jun 2018 18:27:02 +0300
Message-Id: <20180627152725.9783-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
References: <20180627152725.9783-1-stanimir.varbanov@linaro.org>
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

