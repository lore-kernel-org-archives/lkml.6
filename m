Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA99FC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A7C25C62
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GkCwuAPE";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GkCwuAPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A7C25C62
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965633AbeGBL0j (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:26:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58960 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965489AbeGBL0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:26:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8A30C607DC; Mon,  2 Jul 2018 11:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530530794;
        bh=P0fr4zYFEgin6y0TpVeJrWqZmmx1EoMIGFbF+yv0lnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GkCwuAPEOnTgIHHMfG3i3l2cqy+gXd9yJQX6NP7eUqqihTp8VpCbr3SADpVNiuj+l
         0p7Jf9PuLTjQ7MCAZShXUwqAPWb8OYPQNWYrcDAT8tO/1THyTYMA3qzoS/OvzJ0gpl
         cnwTZ0J1BvKXL+lF5WCLJtFpNZvQ5NiOiGasjhX0=
Received: from vgarodia-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vgarodia@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26F3D605A4;
        Mon,  2 Jul 2018 11:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530530794;
        bh=P0fr4zYFEgin6y0TpVeJrWqZmmx1EoMIGFbF+yv0lnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=GkCwuAPEOnTgIHHMfG3i3l2cqy+gXd9yJQX6NP7eUqqihTp8VpCbr3SADpVNiuj+l
         0p7Jf9PuLTjQ7MCAZShXUwqAPWb8OYPQNWYrcDAT8tO/1THyTYMA3qzoS/OvzJ0gpl
         cnwTZ0J1BvKXL+lF5WCLJtFpNZvQ5NiOiGasjhX0=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26F3D605A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=vgarodia@codeaurora.org
From:   Vikash Garodia <vgarodia@codeaurora.org>
To:     stanimir.varbanov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, acourbot@chromium.org,
        vgarodia@codeaurora.org
Subject: [PATCH] venus: venc: add support for ext controls
Date:   Mon,  2 Jul 2018 16:56:23 +0530
Message-Id: <1530530783-9480-1-git-send-email-vgarodia@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a requirement to add frame level rate control.

Signed-off-by: Vikash Garodia <vgarodia@codeaurora.org>
---
 drivers/media/platform/qcom/venus/venc.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
index a2c6a4b..eaf2fa8 100644
--- a/drivers/media/platform/qcom/venus/venc.c
+++ b/drivers/media/platform/qcom/venus/venc.c
@@ -546,6 +546,33 @@ static int venc_g_parm(struct file *file, void *fh, struct v4l2_streamparm *a)
 	return 0;
 }
 
+static int venc_s_ext_ctrls(struct file *file, void *fh,
+				struct v4l2_ext_controls *ctrl)
+{
+	struct venus_inst *inst = to_inst(file);
+	struct v4l2_ext_control *control;
+	u32 ptype, i, ret;
+	struct hfi_enable en = { .enable = 1 };
+	void *pdata = NULL;
+
+	control = ctrl->controls;
+	for (i = 0; i < ctrl->count; i++) {
+		switch (control[i].id) {
+		case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
+			ptype = HFI_PROPERTY_PARAM_VENC_DISABLE_RC_TIMESTAMP;
+			en.enable = control[i].value;
+			pdata = &en;
+			break;
+		default:
+			return -EINVAL;
+		}
+	}
+	ret = hfi_session_set_property(inst, ptype, pdata);
+	if (ret)
+		return ret;
+	return 0;
+}
+
 static int venc_enum_framesizes(struct file *file, void *fh,
 				struct v4l2_frmsizeenum *fsize)
 {
@@ -638,6 +665,7 @@ static int venc_enum_frameintervals(struct file *file, void *fh,
 	.vidioc_streamoff = v4l2_m2m_ioctl_streamoff,
 	.vidioc_s_parm = venc_s_parm,
 	.vidioc_g_parm = venc_g_parm,
+	.vidioc_s_ext_ctrl = venc_s_ext_ctrls,
 	.vidioc_enum_framesizes = venc_enum_framesizes,
 	.vidioc_enum_frameintervals = venc_enum_frameintervals,
 	.vidioc_subscribe_event = v4l2_ctrl_subscribe_event,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

