Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB4DC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9087220657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:06:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9087220657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeJaBAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:00:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25427 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbeJaBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:00:51 -0400
X-IronPort-AV: E=Sophos;i="5.54,445,1534802400"; 
   d="scan'208";a="353497821"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Oct 2018 17:06:42 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     kernel-janitors@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] media: video-i2c: hwmon: constify vb2_ops structure
Date:   Tue, 30 Oct 2018 16:31:22 +0100
Message-Id: <1540913482-22130-3-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540913482-22130-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540913482-22130-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The vb2_ops structure can be const as it is only stored in the ops
field of a vb2_queue structure and this field is const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/media/i2c/video-i2c.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/video-i2c.c b/drivers/media/i2c/video-i2c.c
index 4d49af86c15e..cb89cda6553d 100644
--- a/drivers/media/i2c/video-i2c.c
+++ b/drivers/media/i2c/video-i2c.c
@@ -336,7 +336,7 @@ static void stop_streaming(struct vb2_queue *vq)
 	video_i2c_del_list(vq, VB2_BUF_STATE_ERROR);
 }
 
-static struct vb2_ops video_i2c_video_qops = {
+static const struct vb2_ops video_i2c_video_qops = {
 	.queue_setup		= queue_setup,
 	.buf_prepare		= buffer_prepare,
 	.buf_queue		= buffer_queue,

