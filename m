Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936E8ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09020665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWGcJCGv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A09020665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJZTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:53:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38630 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727666AbeJZTxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:53:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id d10-v6so950644wrs.5;
        Fri, 26 Oct 2018 04:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KZybGOtSAemy1CjzjcNF/ZknXxngxz/81lJVUnTVdE8=;
        b=kWGcJCGv3xOwk11103zPArswoi0cPmdmbZm1ViSXHChh9Qo5T/Z6SeKBDbXrR9d4AP
         nclyKjUSu4gfYYaD1Yj71yT6rjtmmZgdolSPItDRJaE8XUQpb19b9YJe+hQsSDxJXZom
         /D8QC4b9iSyyvX3Zl/3CPRgL6WdMUrXW+FV5ksGyCcs5zItg2KcUgX1F6oyp1lGMhclk
         GucwGwCEsEyem7dAMJ9D+maE/eK5UNEg473PMUswjMqJa/jnOmYcInmkJhJdt5ht81/j
         JJbkmWA2afTe6bX2LP61ita9AicvCNAhJwqClFbi9lVAq9XGMjWEmbDWuqbLeo5qgqXr
         NGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KZybGOtSAemy1CjzjcNF/ZknXxngxz/81lJVUnTVdE8=;
        b=KZVx4SmlS4VR4Ueb47l8rEs8lV+WtiDQi8Tw/k78OqesH2JBZkqG8XCfvZEAGHRHDr
         PYUZxTdZ4poJjIpdoTguv82dkTgQbCbf8QXodfHerJ5YBODbt4vvj5XrC8Dtz2zPE9zD
         O4Xtq77iQRdLOjPezn9c7B5Zrm7dyhWaFKOP6rmXGFYNkcCnsdTN6c5eKcWcnPYVPM4H
         wE367lYJQn71ys4Yb2Sn2W23C7HZVHLQi4fpD99wG7zpQbCnxg5QuvHil5cZNz9LMrnH
         KA0CfmbmxHXXjVYZA/2LB9VusggqQ6IqTPzeclU0EOejwLK/gvV84xN9DBnwZef9ghT6
         maAQ==
X-Gm-Message-State: AGRZ1gJf0IxlkwBtiKPU0LFaljfZsqzFoP+91wigmq0MpGgGo6D4cQtC
        eRc9m7ATYo0h5bxvCNUAajw=
X-Google-Smtp-Source: AJdET5dNejX/Bib3KP2Bb8i07vSUL2/JbOcZt0e9nw+F4rdAmrtfjtA0Z+82T+pKuyNeYEXle+9QMg==
X-Received: by 2002:a5d:488a:: with SMTP id g10-v6mr5428331wrq.0.1540552608459;
        Fri, 26 Oct 2018 04:16:48 -0700 (PDT)
Received: from localhost (pD9E511F8.dip0.t-ipconnect.de. [217.229.17.248])
        by smtp.gmail.com with ESMTPSA id c2-v6sm8553496wrt.77.2018.10.26.04.16.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 04:16:47 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>, Pekka Pessi <ppessi@nvidia.com>,
        Mika Liljeberg <mliljeberg@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/9] mailbox: tegra-hsp: Add support for shared mailboxes
Date:   Fri, 26 Oct 2018 13:16:33 +0200
Message-Id: <20181026111638.10759-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181026111638.10759-1-thierry.reding@gmail.com>
References: <20181026111638.10759-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

The Tegra HSP block supports 'shared mailboxes' that are simple 32-bit
registers consisting of a FULL bit in MSB position and 31 bits of data.
The hardware can be configured to trigger interrupts when a mailbox
is empty or full. Add support for these shared mailboxes to the HSP
driver.

The initial use for the mailboxes is the Tegra Combined UART. For this
purpose, we use interrupts to receive data, and spinning to wait for
the transmit mailbox to be emptied to minimize unnecessary overhead.

Based on work by Mikko Perttunen <mperttunen@nvidia.com>.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mailbox/tegra-hsp.c | 476 +++++++++++++++++++++++++++++++-----
 1 file changed, 415 insertions(+), 61 deletions(-)

diff --git a/drivers/mailbox/tegra-hsp.c b/drivers/mailbox/tegra-hsp.c
index 0cde356c11ab..d070c8e38375 100644
--- a/drivers/mailbox/tegra-hsp.c
+++ b/drivers/mailbox/tegra-hsp.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2016, NVIDIA CORPORATION.  All rights reserved.
+ * Copyright (c) 2016-2018, NVIDIA CORPORATION.  All rights reserved.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
@@ -11,6 +11,7 @@
  * more details.
  */
 
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/mailbox_controller.h>
@@ -21,6 +22,17 @@
 
 #include <dt-bindings/mailbox/tegra186-hsp.h>
 
+#include "mailbox.h"
+
+#define HSP_INT_IE(x)		(0x100 + ((x) * 4))
+#define HSP_INT_IV		0x300
+#define HSP_INT_IR		0x304
+
+#define HSP_INT_EMPTY_SHIFT	0
+#define HSP_INT_EMPTY_MASK	0xff
+#define HSP_INT_FULL_SHIFT	8
+#define HSP_INT_FULL_MASK	0xff
+
 #define HSP_INT_DIMENSIONING	0x380
 #define HSP_nSM_SHIFT		0
 #define HSP_nSS_SHIFT		4
@@ -34,6 +46,11 @@
 #define HSP_DB_RAW	0x8
 #define HSP_DB_PENDING	0xc
 
+#define HSP_SM_SHRD_MBOX	0x0
+#define HSP_SM_SHRD_MBOX_FULL	BIT(31)
+#define HSP_SM_SHRD_MBOX_FULL_INT_IE	0x04
+#define HSP_SM_SHRD_MBOX_EMPTY_INT_IE	0x08
+
 #define HSP_DB_CCPLEX		1
 #define HSP_DB_BPMP		3
 #define HSP_DB_MAX		7
@@ -55,6 +72,12 @@ struct tegra_hsp_doorbell {
 	unsigned int index;
 };
 
+struct tegra_hsp_mailbox {
+	struct tegra_hsp_channel channel;
+	unsigned int index;
+	bool sending;
+};
+
 struct tegra_hsp_db_map {
 	const char *name;
 	unsigned int master;
@@ -66,10 +89,13 @@ struct tegra_hsp_soc {
 };
 
 struct tegra_hsp {
+	struct device *dev;
 	const struct tegra_hsp_soc *soc;
-	struct mbox_controller mbox;
+	struct mbox_controller mbox_db;
+	struct mbox_controller mbox_sm;
 	void __iomem *regs;
-	unsigned int irq;
+	unsigned int doorbell_irq;
+	unsigned int *shared_irqs;
 	unsigned int num_sm;
 	unsigned int num_as;
 	unsigned int num_ss;
@@ -78,14 +104,9 @@ struct tegra_hsp {
 	spinlock_t lock;
 
 	struct list_head doorbells;
+	struct tegra_hsp_mailbox *mailboxes;
 };
 
-static inline struct tegra_hsp *
-to_tegra_hsp(struct mbox_controller *mbox)
-{
-	return container_of(mbox, struct tegra_hsp, mbox);
-}
-
 static inline u32 tegra_hsp_readl(struct tegra_hsp *hsp, unsigned int offset)
 {
 	return readl(hsp->regs + offset);
@@ -158,7 +179,7 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, void *data)
 
 	spin_lock(&hsp->lock);
 
-	for_each_set_bit(master, &value, hsp->mbox.num_chans) {
+	for_each_set_bit(master, &value, hsp->mbox_db.num_chans) {
 		struct tegra_hsp_doorbell *db;
 
 		db = __tegra_hsp_doorbell_get(hsp, master);
@@ -182,6 +203,84 @@ static irqreturn_t tegra_hsp_doorbell_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t tegra_hsp_shared_full_irq(int irq, void *data)
+{
+	struct tegra_hsp *hsp = data;
+	unsigned long bit, mask;
+	u32 status, value;
+	void *msg;
+
+	status = tegra_hsp_readl(hsp, HSP_INT_IR);
+
+	/* only interested in FULL interrupts */
+	mask = (status >> HSP_INT_FULL_SHIFT) & HSP_INT_FULL_MASK;
+
+	if (!mask)
+		return IRQ_NONE;
+
+	for_each_set_bit(bit, &mask, hsp->num_sm) {
+		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[bit];
+
+		if (!mb->sending) {
+			value = tegra_hsp_channel_readl(&mb->channel,
+							HSP_SM_SHRD_MBOX);
+			value &= ~HSP_SM_SHRD_MBOX_FULL;
+			msg = (void *)(unsigned long)value;
+			mbox_chan_received_data(mb->channel.chan, msg);
+
+			/*
+			 * Need to clear all bits here since some producers,
+			 * such as TCU, depend on fields in the register
+			 * getting cleared by the consumer.
+			 *
+			 * The mailbox API doesn't give the consumers a way
+			 * of doing that explicitly, so we have to make sure
+			 * we cover all possible cases.
+			 */
+			tegra_hsp_channel_writel(&mb->channel, 0x0,
+						 HSP_SM_SHRD_MBOX);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t tegra_hsp_shared_empty_irq(int irq, void *data)
+{
+	struct tegra_hsp *hsp = data;
+	unsigned long bit, mask;
+	u32 status, value;
+
+	status = tegra_hsp_readl(hsp, HSP_INT_IR);
+
+	/* only interested in EMPTY interrupts */
+	mask = (status >> HSP_INT_EMPTY_SHIFT) & HSP_INT_EMPTY_MASK;
+
+	if (!mask)
+		return IRQ_NONE;
+
+	for_each_set_bit(bit, &mask, hsp->num_sm) {
+		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[bit];
+
+		if (mb->sending) {
+			/*
+			 * Disable EMPTY interrupts until data is sent
+			 * with the next message. These interrupts are
+			 * level-triggered, so if we kept them enabled
+			 * they would constantly trigger until we next
+			 * write data into the message.
+			 */
+			value = tegra_hsp_readl(hsp, HSP_INT_IE(1));
+			value &= ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
+			tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
+
+			mbox_chan_txdone(mb->channel.chan, 0);
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 static struct tegra_hsp_channel *
 tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 			  unsigned int master, unsigned int index)
@@ -194,7 +293,7 @@ tegra_hsp_doorbell_create(struct tegra_hsp *hsp, const char *name,
 	if (!db)
 		return ERR_PTR(-ENOMEM);
 
-	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) << 16;
+	offset = (1 + (hsp->num_sm / 2) + hsp->num_ss + hsp->num_as) * SZ_64K;
 	offset += index * 0x100;
 
 	db->channel.regs = hsp->regs + offset;
@@ -235,8 +334,8 @@ static int tegra_hsp_doorbell_startup(struct mbox_chan *chan)
 	unsigned long flags;
 	u32 value;
 
-	if (db->master >= hsp->mbox.num_chans) {
-		dev_err(hsp->mbox.dev,
+	if (db->master >= chan->mbox->num_chans) {
+		dev_err(chan->mbox->dev,
 			"invalid master ID %u for HSP channel\n",
 			db->master);
 		return -EINVAL;
@@ -281,46 +380,147 @@ static void tegra_hsp_doorbell_shutdown(struct mbox_chan *chan)
 	spin_unlock_irqrestore(&hsp->lock, flags);
 }
 
-static const struct mbox_chan_ops tegra_hsp_doorbell_ops = {
+static const struct mbox_chan_ops tegra_hsp_db_ops = {
 	.send_data = tegra_hsp_doorbell_send_data,
 	.startup = tegra_hsp_doorbell_startup,
 	.shutdown = tegra_hsp_doorbell_shutdown,
 };
 
-static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
+static int tegra_hsp_mailbox_send_data(struct mbox_chan *chan, void *data)
+{
+	struct tegra_hsp_mailbox *mb = chan->con_priv;
+	struct tegra_hsp *hsp = mb->channel.hsp;
+	u32 value;
+
+	mb->sending = true;
+
+	/* copy data and mark mailbox full */
+	value = (u32)(unsigned long)data;
+	value |= HSP_SM_SHRD_MBOX_FULL;
+
+	tegra_hsp_channel_writel(&mb->channel, value, HSP_SM_SHRD_MBOX);
+
+	if (!irqs_disabled()) {
+		/* enable EMPTY interrupt for the shared mailbox */
+		value = tegra_hsp_readl(hsp, HSP_INT_IE(1));
+		value |= BIT(HSP_INT_EMPTY_SHIFT + mb->index);
+		tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
+	}
+
+	return 0;
+}
+
+static int tegra_hsp_mailbox_flush(struct mbox_chan *chan,
+				   unsigned long timeout)
+{
+	struct tegra_hsp_mailbox *mb = chan->con_priv;
+	struct tegra_hsp_channel *ch = &mb->channel;
+	u32 value;
+
+	timeout = jiffies + msecs_to_jiffies(timeout);
+
+	while (time_before(jiffies, timeout)) {
+		value = tegra_hsp_channel_readl(ch, HSP_SM_SHRD_MBOX);
+		if ((value & HSP_SM_SHRD_MBOX_FULL) == 0) {
+			mbox_chan_txdone(chan, 0);
+			return 0;
+		}
+
+		udelay(1);
+	}
+
+	return -ETIME;
+}
+
+static int tegra_hsp_mailbox_startup(struct mbox_chan *chan)
+{
+	struct tegra_hsp_mailbox *mb = chan->con_priv;
+	struct tegra_hsp_channel *ch = &mb->channel;
+	struct tegra_hsp *hsp = mb->channel.hsp;
+	u32 value;
+
+	chan->txdone_method = TXDONE_BY_IRQ;
+
+	/*
+	 * Shared mailboxes start out as consumers by default. FULL interrupts
+	 * are coalesced at shared interrupt 0, while EMPTY interrupts will be
+	 * coalesced at shared interrupt 1.
+	 *
+	 * Keep EMPTY interrupts disabled at startup and only enable them when
+	 * the mailbox is actually full. This is required because the FULL and
+	 * EMPTY interrupts are level-triggered, so keeping EMPTY interrupts
+	 * enabled all the time would cause an interrupt storm while mailboxes
+	 * are idle.
+	 */
+
+	value = tegra_hsp_readl(hsp, HSP_INT_IE(0));
+	value |= BIT(HSP_INT_FULL_SHIFT + mb->index);
+	tegra_hsp_writel(hsp, value, HSP_INT_IE(0));
+
+	value = tegra_hsp_readl(hsp, HSP_INT_IE(1));
+	value &= ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
+	tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
+
+	tegra_hsp_channel_writel(ch, 0x1, HSP_SM_SHRD_MBOX_FULL_INT_IE);
+	tegra_hsp_channel_writel(ch, 0x1, HSP_SM_SHRD_MBOX_EMPTY_INT_IE);
+
+	return 0;
+}
+
+static void tegra_hsp_mailbox_shutdown(struct mbox_chan *chan)
+{
+	struct tegra_hsp_mailbox *mb = chan->con_priv;
+	struct tegra_hsp_channel *ch = &mb->channel;
+	struct tegra_hsp *hsp = mb->channel.hsp;
+	u32 value;
+
+	tegra_hsp_channel_writel(ch, 0x0, HSP_SM_SHRD_MBOX_EMPTY_INT_IE);
+	tegra_hsp_channel_writel(ch, 0x0, HSP_SM_SHRD_MBOX_FULL_INT_IE);
+
+	value = tegra_hsp_readl(hsp, HSP_INT_IE(1));
+	value &= ~BIT(HSP_INT_EMPTY_SHIFT + mb->index);
+	tegra_hsp_writel(hsp, value, HSP_INT_IE(1));
+
+	value = tegra_hsp_readl(hsp, HSP_INT_IE(0));
+	value &= ~BIT(HSP_INT_FULL_SHIFT + mb->index);
+	tegra_hsp_writel(hsp, value, HSP_INT_IE(0));
+}
+
+static const struct mbox_chan_ops tegra_hsp_sm_ops = {
+	.send_data = tegra_hsp_mailbox_send_data,
+	.flush = tegra_hsp_mailbox_flush,
+	.startup = tegra_hsp_mailbox_startup,
+	.shutdown = tegra_hsp_mailbox_shutdown,
+};
+
+static struct mbox_chan *tegra_hsp_db_xlate(struct mbox_controller *mbox,
 					    const struct of_phandle_args *args)
 {
+	struct tegra_hsp *hsp = container_of(mbox, struct tegra_hsp, mbox_db);
+	unsigned int type = args->args[0], master = args->args[1];
 	struct tegra_hsp_channel *channel = ERR_PTR(-ENODEV);
-	struct tegra_hsp *hsp = to_tegra_hsp(mbox);
-	unsigned int type = args->args[0];
-	unsigned int master = args->args[1];
 	struct tegra_hsp_doorbell *db;
 	struct mbox_chan *chan;
 	unsigned long flags;
 	unsigned int i;
 
-	switch (type) {
-	case TEGRA_HSP_MBOX_TYPE_DB:
-		db = tegra_hsp_doorbell_get(hsp, master);
-		if (db)
-			channel = &db->channel;
+	if (type != TEGRA_HSP_MBOX_TYPE_DB || !hsp->doorbell_irq)
+		return ERR_PTR(-ENODEV);
 
-		break;
-
-	default:
-		break;
-	}
+	db = tegra_hsp_doorbell_get(hsp, master);
+	if (db)
+		channel = &db->channel;
 
 	if (IS_ERR(channel))
 		return ERR_CAST(channel);
 
 	spin_lock_irqsave(&hsp->lock, flags);
 
-	for (i = 0; i < hsp->mbox.num_chans; i++) {
-		chan = &hsp->mbox.chans[i];
+	for (i = 0; i < mbox->num_chans; i++) {
+		chan = &mbox->chans[i];
 		if (!chan->con_priv) {
-			chan->con_priv = channel;
 			channel->chan = chan;
+			chan->con_priv = db;
 			break;
 		}
 
@@ -332,6 +532,19 @@ static struct mbox_chan *of_tegra_hsp_xlate(struct mbox_controller *mbox,
 	return chan ?: ERR_PTR(-EBUSY);
 }
 
+static struct mbox_chan *tegra_hsp_sm_xlate(struct mbox_controller *mbox,
+					    const struct of_phandle_args *args)
+{
+	struct tegra_hsp *hsp = container_of(mbox, struct tegra_hsp, mbox_sm);
+	unsigned int type = args->args[0], index = args->args[1];
+
+	if (type != TEGRA_HSP_MBOX_TYPE_SM || !hsp->shared_irqs ||
+	    index >= hsp->num_sm)
+		return ERR_PTR(-ENODEV);
+
+	return hsp->mailboxes[index].channel.chan;
+}
+
 static void tegra_hsp_remove_doorbells(struct tegra_hsp *hsp)
 {
 	struct tegra_hsp_doorbell *db, *tmp;
@@ -364,10 +577,72 @@ static int tegra_hsp_add_doorbells(struct tegra_hsp *hsp)
 	return 0;
 }
 
+static int tegra_hsp_add_mailboxes(struct tegra_hsp *hsp, struct device *dev)
+{
+	int i;
+
+	hsp->mailboxes = devm_kcalloc(dev, hsp->num_sm, sizeof(*hsp->mailboxes),
+				      GFP_KERNEL);
+	if (!hsp->mailboxes)
+		return -ENOMEM;
+
+	for (i = 0; i < hsp->num_sm; i++) {
+		struct tegra_hsp_mailbox *mb = &hsp->mailboxes[i];
+
+		mb->index = i;
+		mb->sending = false;
+
+		mb->channel.hsp = hsp;
+		mb->channel.regs = hsp->regs + SZ_64K + i * SZ_32K;
+		mb->channel.chan = &hsp->mbox_sm.chans[i];
+		mb->channel.chan->con_priv = mb;
+	}
+
+	return 0;
+}
+
+static int tegra_hsp_request_shared_irqs(struct tegra_hsp *hsp)
+{
+	int err;
+
+	if (hsp->shared_irqs[0] > 0) {
+		err = devm_request_irq(hsp->dev, hsp->shared_irqs[0],
+				       tegra_hsp_shared_full_irq, 0,
+				       dev_name(hsp->dev), hsp);
+		if (err < 0) {
+			dev_err(hsp->dev,
+				"failed to request full interrupt: %d\n",
+				err);
+			return err;
+		}
+
+		dev_dbg(hsp->dev, "full interrupt requested: %u\n",
+			hsp->shared_irqs[0]);
+	}
+
+	if (hsp->shared_irqs[1] > 0) {
+		err = devm_request_irq(hsp->dev, hsp->shared_irqs[1],
+				       tegra_hsp_shared_empty_irq, 0,
+				       dev_name(hsp->dev), hsp);
+		if (err < 0) {
+			dev_err(hsp->dev,
+				"failed to request empty interrupt: %d\n",
+				err);
+			return err;
+		}
+
+		dev_dbg(hsp->dev, "empty interrupt requested: %u\n",
+			hsp->shared_irqs[1]);
+	}
+
+	return 0;
+}
+
 static int tegra_hsp_probe(struct platform_device *pdev)
 {
 	struct tegra_hsp *hsp;
 	struct resource *res;
+	unsigned int i;
 	u32 value;
 	int err;
 
@@ -375,6 +650,7 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	if (!hsp)
 		return -ENOMEM;
 
+	hsp->dev = &pdev->dev;
 	hsp->soc = of_device_get_match_data(&pdev->dev);
 	INIT_LIST_HEAD(&hsp->doorbells);
 	spin_lock_init(&hsp->lock);
@@ -392,58 +668,136 @@ static int tegra_hsp_probe(struct platform_device *pdev)
 	hsp->num_si = (value >> HSP_nSI_SHIFT) & HSP_nINT_MASK;
 
 	err = platform_get_irq_byname(pdev, "doorbell");
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to get doorbell IRQ: %d\n", err);
-		return err;
+	if (err >= 0)
+		hsp->doorbell_irq = err;
+
+	if (hsp->num_si > 0) {
+		unsigned int count = 0;
+
+		hsp->shared_irqs = devm_kcalloc(&pdev->dev, hsp->num_si,
+						sizeof(*hsp->shared_irqs),
+						GFP_KERNEL);
+		if (!hsp->shared_irqs)
+			return -ENOMEM;
+
+		for (i = 0; i < hsp->num_si; i++) {
+			char *name;
+
+			name = kasprintf(GFP_KERNEL, "shared%u", i);
+			if (!name)
+				return -ENOMEM;
+
+			err = platform_get_irq_byname(pdev, name);
+			if (err >= 0) {
+				hsp->shared_irqs[i] = err;
+				count++;
+			}
+
+			kfree(name);
+		}
+
+		if (count == 0) {
+			devm_kfree(&pdev->dev, hsp->shared_irqs);
+			hsp->shared_irqs = NULL;
+		}
 	}
 
-	hsp->irq = err;
+	/* setup the doorbell controller */
+	hsp->mbox_db.of_xlate = tegra_hsp_db_xlate;
+	hsp->mbox_db.num_chans = 32;
+	hsp->mbox_db.dev = &pdev->dev;
+	hsp->mbox_db.ops = &tegra_hsp_db_ops;
 
-	hsp->mbox.of_xlate = of_tegra_hsp_xlate;
-	hsp->mbox.num_chans = 32;
-	hsp->mbox.dev = &pdev->dev;
-	hsp->mbox.txdone_irq = false;
-	hsp->mbox.txdone_poll = false;
-	hsp->mbox.ops = &tegra_hsp_doorbell_ops;
+	hsp->mbox_db.chans = devm_kcalloc(&pdev->dev, hsp->mbox_db.num_chans,
+					  sizeof(*hsp->mbox_db.chans),
+					  GFP_KERNEL);
+	if (!hsp->mbox_db.chans)
+		return -ENOMEM;
 
-	hsp->mbox.chans = devm_kcalloc(&pdev->dev, hsp->mbox.num_chans,
-					sizeof(*hsp->mbox.chans),
-					GFP_KERNEL);
-	if (!hsp->mbox.chans)
+	if (hsp->doorbell_irq) {
+		err = tegra_hsp_add_doorbells(hsp);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to add doorbells: %d\n",
+			        err);
+			return err;
+		}
+	}
+
+	err = mbox_controller_register(&hsp->mbox_db);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to register doorbell mailbox: %d\n", err);
+		goto remove_doorbells;
+	}
+
+	/* setup the shared mailbox controller */
+	hsp->mbox_sm.of_xlate = tegra_hsp_sm_xlate;
+	hsp->mbox_sm.num_chans = hsp->num_sm;
+	hsp->mbox_sm.dev = &pdev->dev;
+	hsp->mbox_sm.ops = &tegra_hsp_sm_ops;
+
+	hsp->mbox_sm.chans = devm_kcalloc(&pdev->dev, hsp->mbox_sm.num_chans,
+					  sizeof(*hsp->mbox_sm.chans),
+					  GFP_KERNEL);
+	if (!hsp->mbox_sm.chans)
 		return -ENOMEM;
 
-	err = tegra_hsp_add_doorbells(hsp);
+	if (hsp->shared_irqs) {
+		err = tegra_hsp_add_mailboxes(hsp, &pdev->dev);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to add mailboxes: %d\n",
+			        err);
+			goto unregister_mbox_db;
+		}
+	}
+
+	err = mbox_controller_register(&hsp->mbox_sm);
 	if (err < 0) {
-		dev_err(&pdev->dev, "failed to add doorbells: %d\n", err);
-		return err;
+		dev_err(&pdev->dev, "failed to register shared mailbox: %d\n", err);
+		goto unregister_mbox_db;
 	}
 
 	platform_set_drvdata(pdev, hsp);
 
-	err = mbox_controller_register(&hsp->mbox);
-	if (err) {
-		dev_err(&pdev->dev, "failed to register mailbox: %d\n", err);
-		tegra_hsp_remove_doorbells(hsp);
-		return err;
+	if (hsp->doorbell_irq) {
+		err = devm_request_irq(&pdev->dev, hsp->doorbell_irq,
+				       tegra_hsp_doorbell_irq, IRQF_NO_SUSPEND,
+				       dev_name(&pdev->dev), hsp);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+			        "failed to request doorbell IRQ#%u: %d\n",
+				hsp->doorbell_irq, err);
+			goto unregister_mbox_sm;
+		}
 	}
 
-	err = devm_request_irq(&pdev->dev, hsp->irq, tegra_hsp_doorbell_irq,
-			       IRQF_NO_SUSPEND, dev_name(&pdev->dev), hsp);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n",
-			hsp->irq, err);
-		return err;
+	if (hsp->shared_irqs) {
+		err = tegra_hsp_request_shared_irqs(hsp);
+		if (err < 0)
+			goto unregister_mbox_sm;
 	}
 
 	return 0;
+
+unregister_mbox_sm:
+	mbox_controller_unregister(&hsp->mbox_sm);
+unregister_mbox_db:
+	mbox_controller_unregister(&hsp->mbox_db);
+remove_doorbells:
+	if (hsp->doorbell_irq)
+		tegra_hsp_remove_doorbells(hsp);
+
+	return err;
 }
 
 static int tegra_hsp_remove(struct platform_device *pdev)
 {
 	struct tegra_hsp *hsp = platform_get_drvdata(pdev);
 
-	mbox_controller_unregister(&hsp->mbox);
-	tegra_hsp_remove_doorbells(hsp);
+	mbox_controller_unregister(&hsp->mbox_sm);
+	mbox_controller_unregister(&hsp->mbox_db);
+
+	if (hsp->doorbell_irq)
+		tegra_hsp_remove_doorbells(hsp);
 
 	return 0;
 }
-- 
2.19.1

