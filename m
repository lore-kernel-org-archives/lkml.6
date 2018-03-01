Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967845AbeCALub (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 06:50:31 -0500
Received: from smtprelay0049.hostedemail.com ([216.40.44.49]:47049 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967723AbeCALua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 06:50:30 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:69:355:379:541:800:960:973:988:989:1260:1345:1437:1534:1543:1711:1730:1747:1777:1792:2393:2559:2562:2895:3138:3139:3140:3141:3142:3354:3867:4321:4605:5007:6119:6261:6642:7875:8603:10004:10848:11026:11658:11914:12043:12438:12555:12895:14096:14181:14394:14721:21060:21080:21451:21627:30012:30054:30070,0,RBL:46.188.150.148:@perches.com:.lbl8.mailshell.net-62.8.110.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:19,LUA_SUMMARY:none
X-HE-Tag: rake27_3f7f5536bb50
X-Filterd-Recvd-Size: 3636
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: tw9910: Whitespace alignment
Date: Thu,  1 Mar 2018 03:50:22 -0800
Message-Id: <2601b3771b35242dba70e1a9e50b2f2bc3dd41d8.1519904988.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update multiline statements to open parenthesis.
Update a ?: to a single line.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/media/i2c/tw9910.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/tw9910.c b/drivers/media/i2c/tw9910.c
index cc5d383fc6b8..ab32cd81ebd0 100644
--- a/drivers/media/i2c/tw9910.c
+++ b/drivers/media/i2c/tw9910.c
@@ -445,7 +445,7 @@ static const struct tw9910_scale_ctrl *tw9910_select_norm(v4l2_std_id norm,
 
 	for (i = 0; i < size; i++) {
 		tmp = abs(width - scale[i].width) +
-			abs(height - scale[i].height);
+		      abs(height - scale[i].height);
 		if (tmp < diff) {
 			diff = tmp;
 			ret = scale + i;
@@ -534,9 +534,9 @@ static int tw9910_s_std(struct v4l2_subdev *sd, v4l2_std_id norm)
 	if (!ret)
 		ret = i2c_smbus_write_byte_data(client, CROP_HI,
 						((vdelay >> 2) & 0xc0) |
-			((vact >> 4) & 0x30) |
-			((hdelay >> 6) & 0x0c) |
-			((hact >> 8) & 0x03));
+						((vact >> 4) & 0x30) |
+						((hdelay >> 6) & 0x0c) |
+						((hact >> 8) & 0x03));
 	if (!ret)
 		ret = i2c_smbus_write_byte_data(client, VDELAY_LO,
 						vdelay & 0xff);
@@ -642,8 +642,7 @@ static int tw9910_s_power(struct v4l2_subdev *sd, int on)
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	struct tw9910_priv *priv = to_tw9910(client);
 
-	return on ? tw9910_power_on(priv) :
-		    tw9910_power_off(priv);
+	return on ? tw9910_power_on(priv) : tw9910_power_off(priv);
 }
 
 static int tw9910_set_frame(struct v4l2_subdev *sd, u32 *width, u32 *height)
@@ -733,7 +732,7 @@ static int tw9910_set_frame(struct v4l2_subdev *sd, u32 *width, u32 *height)
 
 static int tw9910_get_selection(struct v4l2_subdev *sd,
 				struct v4l2_subdev_pad_config *cfg,
-		struct v4l2_subdev_selection *sel)
+				struct v4l2_subdev_selection *sel)
 {
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
 	struct tw9910_priv *priv = to_tw9910(client);
@@ -758,7 +757,7 @@ static int tw9910_get_selection(struct v4l2_subdev *sd,
 
 static int tw9910_get_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_pad_config *cfg,
-		struct v4l2_subdev_format *format)
+			  struct v4l2_subdev_format *format)
 {
 	struct v4l2_mbus_framefmt *mf = &format->format;
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
@@ -809,7 +808,7 @@ static int tw9910_s_fmt(struct v4l2_subdev *sd,
 
 static int tw9910_set_fmt(struct v4l2_subdev *sd,
 			  struct v4l2_subdev_pad_config *cfg,
-		struct v4l2_subdev_format *format)
+			  struct v4l2_subdev_format *format)
 {
 	struct v4l2_mbus_framefmt *mf = &format->format;
 	struct i2c_client *client = v4l2_get_subdevdata(sd);
@@ -900,7 +899,7 @@ static const struct v4l2_subdev_core_ops tw9910_subdev_core_ops = {
 
 static int tw9910_enum_mbus_code(struct v4l2_subdev *sd,
 				 struct v4l2_subdev_pad_config *cfg,
-		struct v4l2_subdev_mbus_code_enum *code)
+				 struct v4l2_subdev_mbus_code_enum *code)
 {
 	if (code->pad || code->index)
 		return -EINVAL;
-- 
2.15.0
