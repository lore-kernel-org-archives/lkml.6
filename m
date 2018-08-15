Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F96C46460
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6295E216F6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:46:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6295E216F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbeHOEgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:36:25 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:42393 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725831AbeHOEgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:36:25 -0400
X-UUID: 533edd484233477e924f866980fe2d9c-20180815
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1683531059; Wed, 15 Aug 2018 09:46:13 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 15 Aug
 2018 09:46:11 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 15 Aug 2018 09:46:10 +0800
Message-ID: <1534297570.21668.3.camel@mhfsdcap03>
Subject: Re: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
From:   houlong wei <houlong.wei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Nicolas Boichat" <drinkcat@chromium.org>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>,
        "Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?=" 
        <Bibby.Hsieh@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AD=9F=E5=A9=B7=29?= 
        <monica.wang@mediatek.com>,
        Hs Liao =?UTF-8?Q?=28=E5=BB=96=E5=AE=8F=E7=A5=A5=29?= 
        <Hs.Liao@mediatek.com>,
        Ginny Chen =?UTF-8?Q?=28=E9=99=B3=E6=B2=BB=E5=82=91=29?= 
        <ginny.chen@mediatek.com>,
        Enzhu Wang =?UTF-8?Q?=28=E7=8E=8B=E6=81=A9=E6=9F=B1=29?= 
        <enzhu.wang@mediatek.com>, <houlong.wei@mediatek.com>
Date:   Wed, 15 Aug 2018 09:46:10 +0800
In-Reply-To: <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
         <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-07-25 at 09:26 +0800, Houlong Wei wrote:
> Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig           |   12 ++
>  drivers/soc/mediatek/Makefile          |    1 +
>  drivers/soc/mediatek/mtk-cmdq-helper.c |  291 ++++++++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  |  135 +++++++++++++++
>  4 files changed, 439 insertions(+)
>  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
>  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index a7d0667..17bd759 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -4,6 +4,18 @@
>  menu "MediaTek SoC drivers"
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
>  
> +config MTK_CMDQ
> +	tristate "MediaTek CMDQ Support"
> +	depends on ARCH_MEDIATEK || COMPILE_TEST
> +	select MAILBOX
> +	select MTK_CMDQ_MBOX
> +	select MTK_INFRACFG
> +	help
> +	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> +	  driver. The CMDQ is used to help read/write registers with critical
> +	  time limitation, such as updating display configuration during the
> +	  vblank.
> +
>  config MTK_INFRACFG
>  	bool "MediaTek INFRACFG Support"
>  	select REGMAP
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 12998b0..64ce5ee 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,3 +1,4 @@
> +obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
>  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> new file mode 100644
> index 0000000..e4dbb7e
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2018 MediaTek Inc.
> +
> +#include <linux/completion.h>
> +#include <linux/errno.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/mailbox_controller.h>
> +#include <linux/soc/mediatek/mtk-cmdq.h>
> +
> +#define CMDQ_ARG_A_WRITE_MASK	0xffff
> +#define CMDQ_WRITE_ENABLE_MASK	BIT(0)
> +#define CMDQ_EOC_IRQ_EN		BIT(0)
> +#define CMDQ_EOC_CMD		((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
> +				<< 32 | CMDQ_EOC_IRQ_EN)
> +
> +static void cmdq_client_timeout(struct timer_list *t)
> +{
> +	struct cmdq_client *client = from_timer(client, t, timer);
> +
> +	dev_err(client->client.dev, "cmdq timeout!\n");
> +}
> +
> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
> +{
> +	struct cmdq_client *client;
> +
> +	client = kzalloc(sizeof(*client), GFP_KERNEL);
> +	if (!client)
> +		return (struct cmdq_client *)-ENOMEM;
> +
> +	client->timeout_ms = timeout;
> +	if (timeout != CMDQ_NO_TIMEOUT) {
> +		spin_lock_init(&client->lock);
> +		timer_setup(&client->timer, cmdq_client_timeout, 0);
> +	}
> +	client->pkt_cnt = 0;
> +	client->client.dev = dev;
> +	client->client.tx_block = false;
> +	client->chan = mbox_request_channel(&client->client, index);
> +
> +	if (IS_ERR(client->chan)) {
> +		long err = 0;
> +
> +		dev_err(dev, "failed to request channel\n");
> +		err = PTR_ERR(client->chan);
> +		kfree(client);
> +
> +		return (struct cmdq_client *)err;
> +	}
> +
> +	return client;
> +}
> +EXPORT_SYMBOL(cmdq_mbox_create);
> +
> +void cmdq_mbox_destroy(struct cmdq_client *client)
> +{
> +	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +		spin_lock(&client->lock);
> +		del_timer_sync(&client->timer);
> +		spin_unlock(&client->lock);
> +	}
> +	mbox_free_channel(client->chan);
> +	kfree(client);
> +}
> +EXPORT_SYMBOL(cmdq_mbox_destroy);
> +
> +int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt **pkt_ptr,
> +		    size_t size)
> +{
> +	struct cmdq_pkt *pkt;
> +	struct device *dev;
> +	dma_addr_t dma_addr;
> +
> +	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> +	if (!pkt)
> +		return -ENOMEM;
> +	pkt->va_base = kzalloc(size, GFP_KERNEL);
> +	if (!pkt->va_base) {
> +		kfree(pkt);
> +		return -ENOMEM;
> +	}
> +	pkt->buf_size = size;
> +	pkt->cl = (void *)client;
> +
> +	dev = client->chan->mbox->dev;
> +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
> +		DMA_TO_DEVICE);
> +	if (dma_mapping_error(dev, dma_addr)) {
> +		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
> +		kfree(pkt->va_base);
> +		kfree(pkt);
> +		return -ENOMEM;
> +	}
> +
> +	pkt->pa_base = dma_addr;
> +	*pkt_ptr = pkt;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_create);
> +
> +void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
> +{
> +	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> +
> +	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
> +			 DMA_TO_DEVICE);
> +	kfree(pkt->va_base);
> +	kfree(pkt);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_destroy);
> +
> +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> +				   u32 arg_a, u32 arg_b)
> +{
> +	u64 *cmd_ptr;
> +
> +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +		return -ENOMEM;
> +	}
> +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> +
> +	return 0;
> +}
> +
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset)
> +{
> +	u32 arg_a = (offset & CMDQ_ARG_A_WRITE_MASK) |
> +		    (subsys << CMDQ_SUBSYS_SHIFT);
> +
> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_write);
> +
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> +			u32 subsys, u32 offset, u32 mask)
> +{
> +	u32 offset_mask = offset;
> +	int err;
> +
> +	if (mask != 0xffffffff) {
> +		err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
> +		WARN_ON(err < 0);
> +		offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> +	}
> +
> +	return cmdq_pkt_write(pkt, value, subsys, offset_mask);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_write_mask);
> +
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> +{
> +	u32 arg_b;
> +
> +	if (event >= CMDQ_MAX_EVENT)
> +		return -EINVAL;
> +
> +	/*
> +	 * WFE arg_b
> +	 * bit 0-11: wait value
> +	 * bit 15: 1 - wait, 0 - no wait
> +	 * bit 16-27: update value
> +	 * bit 31: 1 - update, 0 - no update
> +	 */
> +	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> +
> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_wfe);
> +
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
> +{
> +	if (event >= CMDQ_MAX_EVENT)
> +		return -EINVAL;
> +
> +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
> +				       CMDQ_WFE_UPDATE);
> +}
> +EXPORT_SYMBOL(cmdq_pkt_clear_event);
> +
> +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> +{
> +	int err;
> +
> +	/* insert EOC and generate IRQ for each command iteration */
> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> +	WARN_ON(err < 0);
> +
> +	/* JUMP to end */
> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +	WARN_ON(err < 0);
> +
> +	return err;
> +}
> +
> +static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
> +{
> +	struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
> +	struct cmdq_task_cb *cb = &pkt->cb;
> +	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> +
> +	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +		unsigned long flags = 0;
> +
> +		spin_lock_irqsave(&client->lock, flags);
> +		if (--client->pkt_cnt == 0)
> +			del_timer(&client->timer);
> +		else
> +			mod_timer(&client->timer, jiffies +
> +				  msecs_to_jiffies(client->timeout_ms));
> +		spin_unlock_irqrestore(&client->lock, flags);
> +	}
> +
> +	dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
> +				pkt->cmd_buf_size, DMA_TO_DEVICE);
> +	if (cb->cb) {
> +		data.data = cb->data;
> +		cb->cb(data);
> +	}
> +}
> +
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> +			 void *data)
> +{
> +	int err;
> +	unsigned long flags = 0;
> +	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> +
> +	err = cmdq_pkt_finalize(pkt);
> +	if (err < 0)
> +		return err;
> +
> +	pkt->cb.cb = cb;
> +	pkt->cb.data = data;
> +	pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
> +	pkt->async_cb.data = pkt;
> +
> +	dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
> +				   pkt->cmd_buf_size, DMA_TO_DEVICE);
> +
> +	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> +		spin_lock_irqsave(&client->lock, flags);
> +		if (client->pkt_cnt++ == 0)
> +			mod_timer(&client->timer, jiffies +
> +				  msecs_to_jiffies(client->timeout_ms));
> +		spin_unlock_irqrestore(&client->lock, flags);
> +	}
> +
> +	mbox_send_message(client->chan, pkt);
> +	/* We can send next packet immediately, so just call txdone. */
> +	mbox_client_txdone(client->chan, 0);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_flush_async);
> +
> +struct cmdq_flush_completion {
> +	struct completion cmplt;
> +	bool err;
> +};
> +
> +static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> +{
> +	struct cmdq_flush_completion *cmplt;
> +
> +	cmplt = (struct cmdq_flush_completion *)data.data;
> +	if (data.sta != CMDQ_CB_NORMAL)
> +		cmplt->err = true;
> +	else
> +		cmplt->err = false;
> +	complete(&cmplt->cmplt);
> +}
> +
> +int cmdq_pkt_flush(struct cmdq_pkt *pkt)
> +{
> +	struct cmdq_flush_completion cmplt;
> +	int err;
> +
> +	init_completion(&cmplt.cmplt);
> +	err = cmdq_pkt_flush_async(pkt, cmdq_pkt_flush_cb, &cmplt);
> +	if (err < 0)
> +		return err;
> +	wait_for_completion(&cmplt.cmplt);
> +
> +	return cmplt.err ? -EFAULT : 0;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_flush);
> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> new file mode 100644
> index 0000000..fc84fe4
> --- /dev/null
> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> @@ -0,0 +1,135 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + *
> + */
> +
> +#ifndef __MTK_CMDQ_H__
> +#define __MTK_CMDQ_H__
> +
> +#include <linux/mailbox_client.h>
> +#include <linux/mailbox/mtk-cmdq-mailbox.h>
> +#include <linux/timer.h>
> +
> +#define CMDQ_NO_TIMEOUT		0xffffffffu
> +
> +/** cmdq event maximum */
> +#define CMDQ_MAX_EVENT				0x3ff
> +
> +struct cmdq_pkt;
> +
> +struct cmdq_client {
> +	spinlock_t lock;
> +	u32 pkt_cnt;
> +	struct mbox_client client;
> +	struct mbox_chan *chan;
> +	struct timer_list timer;
> +	u32 timeout_ms; /* in unit of microsecond */
> +};
> +
> +/**
> + * cmdq_mbox_create() - create CMDQ mailbox client and channel
> + * @dev:	device of CMDQ mailbox client
> + * @index:	index of CMDQ mailbox channel
> + * @timeout:	timeout of a pkt execution by GCE, in unit of microsecond, set
> + *		CMDQ_NO_TIMEOUT if a timer is not used.
> + *
> + * Return: CMDQ mailbox client pointer
> + */
> +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index,
> +				     u32 timeout);
> +
> +/**
> + * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
> + * @client:	the CMDQ mailbox client
> + */
> +void cmdq_mbox_destroy(struct cmdq_client *client);
> +
> +/**
> + * cmdq_pkt_create() - create a CMDQ packet
> + * @client:	the CMDQ mailbox client
> + * @pkt_ptr:	CMDQ packet pointer to retrieve cmdq_pkt
> + * @size:	CMDQ buffer size
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt **pkt_ptr,
> +		    size_t size);
> +
> +/**
> + * cmdq_pkt_destroy() - destroy the CMDQ packet
> + * @pkt:	the CMDQ packet
> + */
> +void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
> +
> +/**
> + * cmdq_pkt_write() - append write command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @value:	the specified target register value
> + * @subsys:	the CMDQ sub system code
> + * @offset:	register offset from CMDQ sub system
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, u32 subsys, u32 offset);
> +
> +/**
> + * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @value:	the specified target register value
> + * @subsys:	the CMDQ sub system code
> + * @offset:	register offset from CMDQ sub system
> + * @mask:	the specified target register mask
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> +			u32 subsys, u32 offset, u32 mask);
> +
> +/**
> + * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @event:	the desired event type to "wait and CLEAR"
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event);
> +
> +/**
> + * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> + * @pkt:	the CMDQ packet
> + * @event:	the desired event to be cleared
> + *
> + * Return: 0 for success; else the error code is returned
> + */
> +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event);
> +
> +/**
> + * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
> + * @pkt:	the CMDQ packet
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Trigger CMDQ to execute the CMDQ packet. Note that this is a
> + * synchronous flush function. When the function returned, the recorded
> + * commands have been done.
> + */
> +int cmdq_pkt_flush(struct cmdq_pkt *pkt);
> +
> +/**
> + * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> + *                          packet and call back at the end of done packet
> + * @pkt:	the CMDQ packet
> + * @cb:		called at the end of done packet
> + * @data:	this data will pass back to cb
> + *
> + * Return: 0 for success; else the error code is returned
> + *
> + * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
> + * at the end of done packet. Note that this is an ASYNC function. When the
> + * function returned, it may or may not be finished.
> + */
> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> +			 void *data);
> +
> +#endif	/* __MTK_CMDQ_H__ */

Hello Matthias,
  Could you please review this path when you are available? Thanks a
lot.

