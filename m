Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D77A4C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9A672081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 15:47:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9A672081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeKCAyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 20:54:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:50867
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726098AbeKCAyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 20:54:51 -0400
X-IronPort-AV: E=Sophos;i="5.54,456,1534802400"; 
   d="scan'208";a="284189318"
Received: from palace.lip6.fr ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 02 Nov 2018 16:47:18 +0100
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: hi3660: constify mbox_chan_ops structure
Date:   Fri,  2 Nov 2018 16:11:55 +0100
Message-Id: <1541171515-24331-1-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mbox_chan_ops structure can be const as it is only stored in the
ops field of an mbox_controller structure and this field is const.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mailbox/hi3660-mailbox.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
index 3eea6b642484..c3fd1f2b797f 100644
--- a/drivers/mailbox/hi3660-mailbox.c
+++ b/drivers/mailbox/hi3660-mailbox.c
@@ -206,7 +206,7 @@ static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
 	return 0;
 }
 
-static struct mbox_chan_ops hi3660_mbox_ops = {
+static const struct mbox_chan_ops hi3660_mbox_ops = {
 	.startup	= hi3660_mbox_startup,
 	.send_data	= hi3660_mbox_send_data,
 };

