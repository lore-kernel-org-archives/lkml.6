Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E024ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77F3208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 18:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NuZVVagC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C77F3208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731094AbeGPSfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 14:35:01 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39492 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbeGPSe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 14:34:59 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w6GI69NQ017781;
        Mon, 16 Jul 2018 13:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1531764369;
        bh=5wWrK6VF2ukYyYB9XrW7r/aWvvVmEhmt8uCoRSgLppM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=NuZVVagCF61zMPnxmSaGBAZV/hSMTdQLUbce9W6SgNlZkIkuHOAcsbRPeW2iW5jfv
         z6o3/DFaMsb1096ODhzmj9q4R/VqWQR1d5008OOxtCqy4xYDIS8/nz78NCBWWnmjMt
         eVi70xPKAjLhY7IKtSbamaPUe8hdYdxeA3n1rHOk=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI69mp024992;
        Mon, 16 Jul 2018 13:06:09 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 16
 Jul 2018 13:06:08 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 16 Jul 2018 13:06:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w6GI68am001270;
        Mon, 16 Jul 2018 13:06:08 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>,
        Tero Kristo <t-kristo@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH V2 3/6] mailbox: ti-msgmgr: Change message count mask to be descriptor based
Date:   Mon, 16 Jul 2018 13:06:04 -0500
Message-ID: <20180716180607.16526-4-nm@ti.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180716180607.16526-1-nm@ti.com>
References: <20180716180607.16526-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mask used to extract the message count to be descriptor based.

This is to support changes for count location for various SoC
solutions.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes since V1: None
V1: https://patchwork.kernel.org/patch/10475341/
RFC:  https://patchwork.kernel.org/patch/10447671/

 drivers/mailbox/ti-msgmgr.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index 91c955979008..7d2eb4b359ba 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -44,6 +44,7 @@ struct ti_msgmgr_valid_queue_desc {
  * @max_messages:	Number of messages
  * @data_first_reg:	First data register for proxy data region
  * @data_last_reg:	Last data register for proxy data region
+ * @status_cnt_mask:	Mask for getting the status value
  * @tx_polled:		Do I need to use polled mechanism for tx
  * @tx_poll_timeout_ms: Timeout in ms if polled
  * @valid_queues:	List of Valid queues that the processor can access
@@ -58,6 +59,7 @@ struct ti_msgmgr_desc {
 	u8 max_messages;
 	u8 data_first_reg;
 	u8 data_last_reg;
+	u32 status_cnt_mask;
 	bool tx_polled;
 	int tx_poll_timeout_ms;
 	const struct ti_msgmgr_valid_queue_desc *valid_queues;
@@ -116,20 +118,24 @@ struct ti_msgmgr_inst {
 
 /**
  * ti_msgmgr_queue_get_num_messages() - Get the number of pending messages
+ * @d:		Description of message manager
  * @qinst:	Queue instance for which we check the number of pending messages
  *
  * Return: number of messages pending in the queue (0 == no pending messages)
  */
-static inline int ti_msgmgr_queue_get_num_messages(struct ti_queue_inst *qinst)
+static inline int
+ti_msgmgr_queue_get_num_messages(const struct ti_msgmgr_desc *d,
+				 struct ti_queue_inst *qinst)
 {
 	u32 val;
+	u32 status_cnt_mask = d->status_cnt_mask;
 
 	/*
 	 * We cannot use relaxed operation here - update may happen
 	 * real-time.
 	 */
-	val = readl(qinst->queue_state) & Q_STATE_ENTRY_COUNT_MASK;
-	val >>= __ffs(Q_STATE_ENTRY_COUNT_MASK);
+	val = readl(qinst->queue_state) & status_cnt_mask;
+	val >>= __ffs(status_cnt_mask);
 
 	return val;
 }
@@ -167,8 +173,9 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 		return IRQ_NONE;
 	}
 
+	desc = inst->desc;
 	/* Do I actually have messages to read? */
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
 	if (!msg_count) {
 		/* Shared IRQ? */
 		dev_dbg(dev, "Spurious event - 0 pending data!\n");
@@ -181,7 +188,6 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 	 * of how many bytes I should be reading. Let the client figure this
 	 * out.. I just read the full message and pass it on..
 	 */
-	desc = inst->desc;
 	message.len = desc->max_message_size;
 	message.buf = (u8 *)qinst->rx_buff;
 
@@ -224,12 +230,14 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
 	int msg_count;
 
 	if (qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
 
 	return msg_count ? true : false;
 }
@@ -243,12 +251,14 @@ static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
 static bool ti_msgmgr_last_tx_done(struct mbox_chan *chan)
 {
 	struct ti_queue_inst *qinst = chan->con_priv;
+	struct device *dev = chan->mbox->dev;
+	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
 	int msg_count;
 
 	if (!qinst->is_tx)
 		return false;
 
-	msg_count = ti_msgmgr_queue_get_num_messages(qinst);
+	msg_count = ti_msgmgr_queue_get_num_messages(inst->desc, qinst);
 
 	/* if we have any messages pending.. */
 	return msg_count ? false : true;
@@ -523,6 +533,7 @@ static const struct ti_msgmgr_desc k2g_desc = {
 	.max_messages = 128,
 	.data_first_reg = 16,
 	.data_last_reg = 31,
+	.status_cnt_mask = Q_STATE_ENTRY_COUNT_MASK,
 	.tx_polled = false,
 	.valid_queues = k2g_valid_queues,
 	.num_valid_queues = ARRAY_SIZE(k2g_valid_queues),
-- 
2.15.1

