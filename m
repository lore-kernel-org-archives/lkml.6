Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113A0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801E121528
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 15:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JMJeYUJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801E121528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728353AbeIZWHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 18:07:21 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40714 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727411AbeIZWHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 18:07:21 -0400
Received: by mail-ed1-f67.google.com with SMTP id j62-v6so2334642edd.7;
        Wed, 26 Sep 2018 08:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PRZ5FnT4WQVYAc0du0bk7iidWZyUDzAqISMAoxpjmYc=;
        b=JMJeYUJlJDO/6UE4SPLS2yAzskEGHkdedDrY+FU5ynqs3AFrnpw1b2a5b8RcglipKT
         SBeoUep/XjW1FORF85w60H4Q7xiuLxUSbrpnOTkyfWailzes+n0vP7HBjhVAiDKZYwSQ
         lufK79CvkDRlmdvhuBXbopb2OGRwMXgBD4R1JEuI0YowI2ESQLroQjE6EouFJElVj3ZI
         fyd75siGvpipJDYzgtEfbZY+TolTR6T2E2SuY04z0w3EhTAiF5KLyALXkf8mxEI/BEBj
         9GQdJd+6JYZDDi8wuPYSImQ1PNdNmcfohJVO0wuQ4AEkjb+dEFS71+jSykYBBqRIJsG5
         hFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=PRZ5FnT4WQVYAc0du0bk7iidWZyUDzAqISMAoxpjmYc=;
        b=XG4eNxAPPNjhkl+6N5k3X4Ix6KqO0P1FlqIlrCExHYw+LxyDKc8hjS2JASBoYpvUf5
         enWo58JeEwJQPA+/xVahyKITGRhGYMJ/RN4AjtsnxEtKiCfXVQiRqvjRUjsH+ISAMQa7
         e4ZA/ynzHhB6+FbrSoQk50CLtt5mYaW7wPzFu/0jUCa6zr7j/bqyku314mhG/MQpjWyq
         wvTvsVcMZUYKFndcuJycXgJHuBM6I8ztcAldOQRneAEcmVgr9OZ8WtYwixtwTWe3ZhB5
         UBMl46UWqyZmwlnn/TSlcThtQJoA9gjgaCs4G1lbtbNdVQ7WD5bjNEkqQsqDeU26Komb
         NXVg==
X-Gm-Message-State: ABuFfoitHYIhbXfp+QBRa8UrfaFThcZpsKD3rzvXi9GvnnogEE/BuL/u
        42A/vimRv8zE/EbXTY4mJWs=
X-Google-Smtp-Source: ACcGV62DGz/d/snaOPmrNNuhoZc1+ZfU7RVtP/ntVfMzBS+aWcc77vnr8zJQR+ifXRS8LufuG+Cf7w==
X-Received: by 2002:a50:ed1a:: with SMTP id j26-v6mr10209921eds.29.1537977223713;
        Wed, 26 Sep 2018 08:53:43 -0700 (PDT)
Received: from ziggy.stardust ([37.223.146.97])
        by smtp.gmail.com with ESMTPSA id l4-v6sm10470461edb.41.2018.09.26.08.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 08:53:42 -0700 (PDT)
Subject: Re: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
To:     Houlong Wei <houlong.wei@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        Sascha Hauer <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        CK HU <ck.hu@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        HS Liao <hs.liao@mediatek.com>, ginny.chen@mediatek.com,
        enzhu.wang@mediatek.com
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
 <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 UXI+r2JwH1CJjrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
Date:   Wed, 26 Sep 2018 17:53:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/07/2018 03:26, Houlong Wei wrote:
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

Can't we use
return ERR_PTR(err);
here?

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

I suppose you are not returning the allocated cmdq_pkt to avoid checks for
IS_ERR() logic in the consumer of this API. Am I correct?
Do we really need a pointer to a pointer here? Can't we just use a struct
cmdq_pkt *pkt as argument? That would make things easier.

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

Why do we update the cmd_buf_size here?

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
> +	}> +
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

bikeshadding alarm:
can we order the functions in the include file the same way we do in the c file?

Apart from the few comments, the driver looks fine to me.

Regards,
Matthias
