Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B689FECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F5220828
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 13:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F5220828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728699AbeJ0WFX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 18:05:23 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:39531 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728674AbeJ0WFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 18:05:22 -0400
X-IronPort-AV: E=Sophos;i="5.54,432,1534802400"; 
   d="scan'208";a="353089207"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 15:24:20 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Wenyou Yang <wenyou.yang@microchip.com>
Cc:     kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] media: ov7740: constify structures stored in fields of v4l2_subdev_ops structure
Date:   Sat, 27 Oct 2018 14:49:04 +0200
Message-Id: <1540644545-26184-2-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540644545-26184-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540644545-26184-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The fields of a v4l2_subdev_ops structure are all const, so the
structures that are stored there and are not used elsewhere can be
const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/i2c/ov7740.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/ov7740.c b/drivers/media/i2c/ov7740.c
index 6e9c233cfbe3..177688afd9a6 100644
--- a/drivers/media/i2c/ov7740.c
+++ b/drivers/media/i2c/ov7740.c
@@ -322,7 +322,7 @@ static int ov7740_set_power(struct ov7740 *ov7740, int on)
 	return 0;
 }
 
-static struct v4l2_subdev_core_ops ov7740_subdev_core_ops = {
+static const struct v4l2_subdev_core_ops ov7740_subdev_core_ops = {
 	.log_status = v4l2_ctrl_subdev_log_status,
 #ifdef CONFIG_VIDEO_ADV_DEBUG
 	.g_register = ov7740_get_register,
@@ -648,7 +648,7 @@ static int ov7740_s_frame_interval(struct v4l2_subdev *sd,
 	return 0;
 }
 
-static struct v4l2_subdev_video_ops ov7740_subdev_video_ops = {
+static const struct v4l2_subdev_video_ops ov7740_subdev_video_ops = {
 	.s_stream = ov7740_set_stream,
 	.s_frame_interval = ov7740_s_frame_interval,
 	.g_frame_interval = ov7740_g_frame_interval,

