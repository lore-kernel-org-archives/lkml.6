Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0F5C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C05E32075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 01:46:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnB+4mqo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C05E32075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeIDGJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 02:09:02 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:39692 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbeIDGJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 02:09:02 -0400
Received: by mail-qk1-f193.google.com with SMTP id b19-v6so1411874qkc.6;
        Mon, 03 Sep 2018 18:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=13e/6GJsXYJryRF1n5XS6WIDEJ9lQF1dsUN228RV3B8=;
        b=YnB+4mqoBpIy/EW7fw+oCtt/Apjaa6oN8qdoM4kyuWqEl6FInhiXl7+O+uYxZ7r4fB
         4hAPA3Bzp5/40E+XYXfFJsPBuYNVjErsDsSTaoHCxacqXuv3WspZGCXn/lGD68ymJoKa
         FW6ut8mfOuV+1aP7Le7EQ12gT0xasO0Ev1gM9mxS6G51im1CVOWEwpscpPyK7q6to64A
         sPIl0cpui9S5CTuZ1oMsgbZskwltx5p2o3GvLYesTNNZiibBKrD/fL3X9BghZrBxqWpl
         KEGXLJybt1S+SU1C8KFUfr2QfFHAuIfVMqq1La36i5Jk2dcUXYyg/koQbLamAsKOY9YH
         BWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=13e/6GJsXYJryRF1n5XS6WIDEJ9lQF1dsUN228RV3B8=;
        b=NE4oeTs53/7+gADAfHCOoImOOHZryqaO1VOU0a0x8Y2YZy963L8buDihS0KqAhYaNL
         mDk0fU2DFbWIG+7Mi6z5V8O8TO46MlRIQu1GWViw/QteCOBYon5xqhLU+FMPwpX//BC7
         4iw6ye+d3RoWPfGsM8p4pPnk4YkH+Wp3H/yB0jCmoxMfjIsAc7eP/mLZeEqFP6VEK3Vm
         RhiW3+sxpSZuCwhXsecUeBsrjlvtiL6SxyLEUTO3Rpnlz3+2QYjSuk0THgJJTgpHFVSU
         RZ+cQBj3ze+bMgeLMm3BzTd0Fiw+5O9l4ctX7f/lvPwSDZbCzhfK92CXGlxunKy/DEfs
         FYKQ==
X-Gm-Message-State: APzg51DzOgTZAjerq3rmI/IExkJm0PGkZkZR3Ol6tTp40t0Y6hM1V2cw
        WN+f67mUph1BrC2bKs6ELF8=
X-Google-Smtp-Source: ANB0VdYE2fJ95mVyCA6hZwWWFttBKlRWJDmbGeTZHq7PlXlAandInB1Zu8oeBfXSYsa2s3RQF19JkA==
X-Received: by 2002:a37:40d:: with SMTP id 13-v6mr26114823qke.316.1536025575965;
        Mon, 03 Sep 2018 18:46:15 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:b708:4d6d:7be3:c2fe:b5f4:84af])
        by smtp.gmail.com with ESMTPSA id w207-v6sm10271264qka.92.2018.09.03.18.46.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Sep 2018 18:46:15 -0700 (PDT)
From:   Guilherme Gallo <gagallo7@gmail.com>
To:     hverkuil@xs4all.nl, Helen Koike <helen.koike@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
Subject: [PATCH v2] media: vimc: implement basic v4l2-ctrls
Date:   Mon,  3 Sep 2018 22:45:59 -0300
Message-Id: <20180904014559.15765-1-gagallo7@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add brightness, contrast, hue and saturation controls in vimc-sensor

Signed-off-by: Guilherme Alcarde Gallo <gagallo7@gmail.com>
Signed-off-by: Guilherme Gallo <gagallo7@gmail.com>
---
 drivers/media/platform/vimc/vimc-sensor.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
index b2b89315e7ba..edf4c85ae63d 100644
--- a/drivers/media/platform/vimc/vimc-sensor.c
+++ b/drivers/media/platform/vimc/vimc-sensor.c
@@ -317,6 +317,18 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
 	case V4L2_CID_VFLIP:
 		tpg_s_vflip(&vsen->tpg, ctrl->val);
 		break;
+	case V4L2_CID_BRIGHTNESS:
+		tpg_s_brightness(&vsen->tpg, ctrl->val);
+		break;
+	case V4L2_CID_CONTRAST:
+		tpg_s_contrast(&vsen->tpg, ctrl->val);
+		break;
+	case V4L2_CID_HUE:
+		tpg_s_hue(&vsen->tpg, ctrl->val);
+		break;
+	case V4L2_CID_SATURATION:
+		tpg_s_saturation(&vsen->tpg, ctrl->val);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -378,6 +390,14 @@ static int vimc_sen_comp_bind(struct device *comp, struct device *master,
 			  V4L2_CID_VFLIP, 0, 1, 1, 0);
 	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
 			  V4L2_CID_HFLIP, 0, 1, 1, 0);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_CONTRAST, 0, 255, 1, 128);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_HUE, -128, 127, 1, 0);
+	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
+			  V4L2_CID_SATURATION, 0, 255, 1, 128);
 	vsen->sd.ctrl_handler = &vsen->hdl;
 	if (vsen->hdl.error) {
 		ret = vsen->hdl.error;
-- 
2.13.6

Changes in v2:
- Added brightness, hue and saturation controls.
- Fixed the standard values for hue control.
