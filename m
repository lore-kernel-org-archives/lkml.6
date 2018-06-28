Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2ABC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA2D327232
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 10:42:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA2D327232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933028AbeF1KmD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 06:42:03 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:21379 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753203AbeF1KmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 06:42:02 -0400
X-UUID: 5272c7431cfb4b70ae8141c96e776c4f-20180628
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 444405737; Thu, 28 Jun 2018 18:41:57 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 18:41:56 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 18:41:56 +0800
Message-ID: <1530182516.8518.11.camel@mtksdaap41>
Subject: Re: [PATCH v22 4/4] soc: mediatek: Add Mediatek CMDQ helper
From:   CK Hu <ck.hu@mediatek.com>
To:     Houlong Wei <houlong.wei@mediatek.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <srv_heupstream@mediatek.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Daoyuan Huang <daoyuan.huang@mediatek.com>,
        Jiaguang Zhang <jiaguang.zhang@mediatek.com>,
        Dennis-YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        Monica Wang <monica.wang@mediatek.com>,
        "HS Liao" <hs.liao@mediatek.com>, <ginny.chen@mediatek.com>,
        <enzhu.wang@mediatek.com>
Date:   Thu, 28 Jun 2018 18:41:56 +0800
In-Reply-To: <1530098172-31385-5-git-send-email-houlong.wei@mediatek.com>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
         <1530098172-31385-5-git-send-email-houlong.wei@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Houlong:

Some inline comment.

On Wed, 2018-06-27 at 19:16 +0800, Houlong Wei wrote:
> Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> 
> Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> Signed-off-by: HS Liao <hs.liao@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig           |   12 ++
>  drivers/soc/mediatek/Makefile          |    1 +
>  drivers/soc/mediatek/mtk-cmdq-helper.c |  258 ++++++++++++++++++++++++++++++++
>  include/linux/soc/mediatek/mtk-cmdq.h  |  132 ++++++++++++++++
>  4 files changed, 403 insertions(+)
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

[...]

> +
> +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> +{
> +	u32 arg_b;
> +
> +	if (event >= CMDQ_MAX_EVENT || event < 0)

The type of event is 'u32', so checking 'event < 0' is redundant.

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
> +	if (event >= CMDQ_MAX_EVENT || event < 0)

The type of event is 'u32', so checking 'event < 0' is redundant.

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
> +	if (cmdq_pkt_is_finalized(pkt))
> +		return 0;
> +
> +	/* insert EOC and generate IRQ for each command iteration */
> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> +	if (err < 0)
> +		return err;
> +
> +	/* JUMP to end */
> +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> +	if (err < 0)
> +		return err;
> +
> +	return 0;
> +}
> +
> +int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
> +			 cmdq_async_flush_cb cb, void *data)
> +{
> +	int err;
> +	struct device *dev;
> +	dma_addr_t dma_addr;
> +
> +	err = cmdq_pkt_finalize(pkt);
> +	if (err < 0)
> +		return err;
> +
> +	dev = client->chan->mbox->dev;
> +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->cmd_buf_size,
> +		DMA_TO_DEVICE);

You map here, but I could not find unmap, so the unmap should be done in
client driver. I would prefer a symmetric map/unmap which means that
both map and unmap are done in client driver. I think you put map here
because you should map after finalize. Therefore, export
cmdq_pkt_finalize() to client driver and let client do finalize, so
there is no finalize in flush function. This method have a benefit that
if client reuse command buffer, it need not to map/unmap frequently.

Regards,
CK

> +	if (dma_mapping_error(dev, dma_addr)) {
> +		dev_err(client->chan->mbox->dev, "dma map failed\n");
> +		return -ENOMEM;
> +	}
> +
> +	pkt->pa_base = dma_addr;
> +	pkt->cb.cb = cb;
> +	pkt->cb.data = data;
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
> +	struct cmdq_flush_completion *cmplt = data.data;
> +
> +	cmplt->err = data.err;
> +	complete(&cmplt->cmplt);
> +}
> +
> +int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt)
> +{
> +	struct cmdq_flush_completion cmplt;
> +	int err;
> +
> +	init_completion(&cmplt.cmplt);
> +	err = cmdq_pkt_flush_async(client, pkt, cmdq_pkt_flush_cb, &cmplt);
> +	if (err < 0)
> +		return err;
> +	wait_for_completion(&cmplt.cmplt);
> +
> +	return cmplt.err ? -EFAULT : 0;
> +}
> +EXPORT_SYMBOL(cmdq_pkt_flush);

[...]


