Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D4B1BC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8716A208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="P52I9hmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8716A208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935979AbeFMPJO (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 11:09:14 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54901 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935951AbeFMPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 11:09:10 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so5319440wmf.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 08:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2Rjs/riZGr/2boEAWhRGcdDD/iS7glDtXPe+puCnQcc=;
        b=P52I9hmzV8Gy32BanhgHpkACF9LJcaVpD4PCT/uz0pooSvjrazcfMd/QMZYiTKKX0o
         iVGc4JbO8t9inFar0DA0ZkCTP2yJCiz7ZONgeithmFQySWYdX3SXbi1vwcoCXx4WnVHw
         xdsMLwu7ksz/HwNdDv2Ea9dwyBJTlGHQjTIWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2Rjs/riZGr/2boEAWhRGcdDD/iS7glDtXPe+puCnQcc=;
        b=heRTRDfND1wIepLeckxARQ6wVMz+zS8ST1FiOsQRxDv8gwgiLNMNgHi4P+fJgdDCDl
         MWAubzB4rnLJhJhM3sKAFmnCMSrGodmakHe3d8Zb7JjievIqEk09U17SLWvSyJfBKGz4
         rcYdDLZOjvdIo4gc2gBKz4V2MMVCQPTZc0LWs1HAwIXwAWp+NBNBeyG2NxH6MCmrATrL
         S08jz664tICcRFxyxyV+r67w+sSaDZqmNc62GEwEswV5spMzdMCVp/bnMJ/H5c5l3S+h
         LblBlAw7KQm2yUU4z9OE8CpJzb9AWwaLhP5hVzafZkbXrvjmto8AN3dtXtxyiOkx8LqT
         qi5A==
X-Gm-Message-State: APt69E3qN7NEAhW7SfIckt/nEOWSgG71Ti2p1lHRFuiR7PkIXu8cii5F
        OMA01C6iy9OTpJMA0b5cUY/T0w==
X-Google-Smtp-Source: ADUXVKIHMAKXJSJVogkLVGwmzZxFCeXUf3OVW/M+VrQyexyZ7ZNGLsTXZJaq7119yki/5Y4pqFh10A==
X-Received: by 2002:a1c:e618:: with SMTP id d24-v6mr3589303wmh.154.1528902549312;
        Wed, 13 Jun 2018 08:09:09 -0700 (PDT)
Received: from mms-0440.qualcomm.mm-sol.com ([37.157.136.206])
        by smtp.gmail.com with ESMTPSA id e13-v6sm2886548wrm.45.2018.06.13.08.09.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 08:09:08 -0700 (PDT)
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>
Subject: [PATCH v3 04/27] venus: hfi_cmds: add set_properties for 4xx version
Date:   Wed, 13 Jun 2018 18:07:38 +0300
Message-Id: <20180613150801.11702-5-stanimir.varbanov@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
References: <20180613150801.11702-1-stanimir.varbanov@linaro.org>
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

