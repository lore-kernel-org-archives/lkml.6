Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28219C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D07CF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:06:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D07CF20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJaBAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:00:49 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42227 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726532AbeJaBAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:00:49 -0400
X-IronPort-AV: E=Sophos;i="5.54,445,1534802400"; 
   d="scan'208";a="353497819"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/AES128-SHA256; 30 Oct 2018 17:06:42 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     kernel-janitors@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] usb: gadget: uvc: constify vb2_ops structure
Date:   Tue, 30 Oct 2018 16:31:21 +0100
Message-Id: <1540913482-22130-2-git-send-email-Julia.Lawall@lip6.fr>
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
 drivers/usb/gadget/function/uvc_queue.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_queue.c b/drivers/usb/gadget/function/uvc_queue.c
index 9e33d5206d54..526a10a33094 100644
--- a/drivers/usb/gadget/function/uvc_queue.c
+++ b/drivers/usb/gadget/function/uvc_queue.c
@@ -102,7 +102,7 @@ static void uvc_buffer_queue(struct vb2_buffer *vb)
 	spin_unlock_irqrestore(&queue->irqlock, flags);
 }
 
-static struct vb2_ops uvc_queue_qops = {
+static const struct vb2_ops uvc_queue_qops = {
 	.queue_setup = uvc_queue_setup,
 	.buf_prepare = uvc_buffer_prepare,
 	.buf_queue = uvc_buffer_queue,

