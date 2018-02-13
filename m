Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933532AbeBMHNb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:13:31 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:50922 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933502AbeBMHN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:13:26 -0500
X-Google-Smtp-Source: AH8x227MNpNvqXCIFbowUJIidjjIX0frMp2ANe+MFynJ7XjTYmHAh9T0rHXKbaMlAjVi7zZ77wcEwA==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: slongerbeam@gmail.com, mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: todor.tomov@linaro.org, nicolas.dechesne@linaro.org,
        dragonboard@lists.96boards.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH] media: i2c: ov5640: Add pixel clock support
Date: Tue, 13 Feb 2018 12:43:08 +0530
Message-Id: <1518505988-8389-2-git-send-email-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518505988-8389-1-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1518505988-8389-1-git-send-email-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the camera subsystems like camss in Qualcommm MSM chipsets
require pixel clock support in camera sensor drivers. So, this commit
adds a default pixel clock rate of 96MHz to OV5640 camera sensor driver.

According to the datasheet, 96MHz can be used as a pixel clock rate for
most of the modes.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/media/i2c/ov5640.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
index 39a2269..7152c84 100644
--- a/drivers/media/i2c/ov5640.c
+++ b/drivers/media/i2c/ov5640.c
@@ -162,6 +162,7 @@ struct ov5640_ctrls {
 		struct v4l2_ctrl *auto_gain;
 		struct v4l2_ctrl *gain;
 	};
+	struct v4l2_ctrl *pixel_clock;
 	struct v4l2_ctrl *brightness;
 	struct v4l2_ctrl *saturation;
 	struct v4l2_ctrl *contrast;
@@ -2009,6 +2010,9 @@ static int ov5640_init_controls(struct ov5640_dev *sensor)
 	ctrls->gain = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_GAIN,
 					0, 1023, 1, 0);
 
+	/* Pixel clock (default of 96MHz) */
+	ctrls->pixel_clock = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
+					1, INT_MAX, 1, 96000000);
 	ctrls->saturation = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_SATURATION,
 					      0, 255, 1, 64);
 	ctrls->hue = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_HUE,
-- 
2.7.4
