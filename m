Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FC8C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0758F2152C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0758F2152C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727232AbeI0INP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:13:15 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:7951 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726651AbeI0INO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:13:14 -0400
X-UUID: eccf48051f864d48a3171e57402b577c-20180927
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1170972801; Thu, 27 Sep 2018 09:57:15 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 27 Sep
 2018 09:57:13 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 27 Sep 2018 09:57:11 +0800
Message-ID: <1538013431.17514.31.camel@mhfsdcap03>
Subject: Re: [PATCH v23 4/4] soc: mediatek: Add Mediatek CMDQ helper
From:   houlong wei <houlong.wei@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
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
Date:   Thu, 27 Sep 2018 09:57:11 +0800
In-Reply-To: <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
References: <1532482002-11164-1-git-send-email-houlong.wei@mediatek.com>
         <1532482002-11164-5-git-send-email-houlong.wei@mediatek.com>
         <ca12e8ab-e3d1-1cf0-8fe9-756d57bd5a3a@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-09-26 at 23:53 +0800, Matthias Brugger wrote:
> 
> On 25/07/2018 03:26, Houlong Wei wrote:
> > Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> > 
> > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig           |   12 ++
> >  drivers/soc/mediatek/Makefile          |    1 +
> >  drivers/soc/mediatek/mtk-cmdq-helper.c |  291 ++++++++++++++++++++++++++++++++
> >  include/linux/soc/mediatek/mtk-cmdq.h  |  135 +++++++++++++++
> >  4 files changed, 439 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> >  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h

[...]

> > +
> > +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index, u32 timeout)
> > +{
> > +	struct cmdq_client *client;
> > +
> > +	client = kzalloc(sizeof(*client), GFP_KERNEL);
> > +	if (!client)
> > +		return (struct cmdq_client *)-ENOMEM;
> > +
> > +	client->timeout_ms = timeout;
> > +	if (timeout != CMDQ_NO_TIMEOUT) {
> > +		spin_lock_init(&client->lock);
> > +		timer_setup(&client->timer, cmdq_client_timeout, 0);
> > +	}
> > +	client->pkt_cnt = 0;
> > +	client->client.dev = dev;
> > +	client->client.tx_block = false;
> > +	client->chan = mbox_request_channel(&client->client, index);
> > +
> > +	if (IS_ERR(client->chan)) {
> > +		long err = 0;
> > +
> > +		dev_err(dev, "failed to request channel\n");
> > +		err = PTR_ERR(client->chan);
> > +		kfree(client);
> > +
> > +		return (struct cmdq_client *)err;
> 
> Can't we use
> return ERR_PTR(err);
> here?

Sure, will fix it.

> 
> > +	}
> > +
> > +	return client;
> > +}
> > +EXPORT_SYMBOL(cmdq_mbox_create);
> > +
> > +void cmdq_mbox_destroy(struct cmdq_client *client)
> > +{
> > +	if (client->timeout_ms != CMDQ_NO_TIMEOUT) {
> > +		spin_lock(&client->lock);
> > +		del_timer_sync(&client->timer);
> > +		spin_unlock(&client->lock);
> > +	}
> > +	mbox_free_channel(client->chan);
> > +	kfree(client);
> > +}
> > +EXPORT_SYMBOL(cmdq_mbox_destroy);
> > +
> > +int cmdq_pkt_create(struct cmdq_client *client, struct cmdq_pkt **pkt_ptr,
> > +		    size_t size)
> 
> I suppose you are not returning the allocated cmdq_pkt to avoid checks for
> IS_ERR() logic in the consumer of this API. Am I correct?
> Do we really need a pointer to a pointer here? Can't we just use a struct
> cmdq_pkt *pkt as argument? That would make things easier.

Do you mean we change the argument 'struct cmdq_pkt **pkt_ptr' to
'struct cmdq_pkt *pkt', and the consumer allocate a struct cmdq_pkt
*pkt, then pass pkt as argument of this API?
If yes, the consumer still need to check the return value of this API.
For the current implementation, the consumer doesn't need check
IS_ERR(*pkt_ptr) if the return value equals to 0.

Since the consumer has to check the return value of this API once, to
make it simpler, I shall change the prototype to 
'struct cmdq_pkt *cmdq_pkt_create(struct cmdq_client *client, size_t
size)' and change its implementation.

> 
> > +{
> > +	struct cmdq_pkt *pkt;
> > +	struct device *dev;
> > +	dma_addr_t dma_addr;
> > +
> > +	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> > +	if (!pkt)
> > +		return -ENOMEM;
> > +	pkt->va_base = kzalloc(size, GFP_KERNEL);
> > +	if (!pkt->va_base) {
> > +		kfree(pkt);
> > +		return -ENOMEM;
> > +	}
> > +	pkt->buf_size = size;
> > +	pkt->cl = (void *)client;
> > +
> > +	dev = client->chan->mbox->dev;
> > +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->buf_size,
> > +		DMA_TO_DEVICE);
> > +	if (dma_mapping_error(dev, dma_addr)) {
> > +		dev_err(dev, "dma map failed, size=%u\n", (u32)(u64)size);
> > +		kfree(pkt->va_base);
> > +		kfree(pkt);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pkt->pa_base = dma_addr;
> > +	*pkt_ptr = pkt;
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_create);
> > +
> > +void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
> > +{
> > +	struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
> > +
> > +	dma_unmap_single(client->chan->mbox->dev, pkt->pa_base, pkt->buf_size,
> > +			 DMA_TO_DEVICE);
> > +	kfree(pkt->va_base);
> > +	kfree(pkt);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_destroy);
> > +
> > +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> > +				   u32 arg_a, u32 arg_b)
> > +{
> > +	u64 *cmd_ptr;
> > +
> > +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> > +		pkt->cmd_buf_size += CMDQ_INST_SIZE;
> 
> Why do we update the cmd_buf_size here?

Because in developing phase of consumer driver, the consumer has to know
the real command buffer size after adding command failure. Then the
consumer will increase the size and run the cmdq flow (cmdq_pkt_create,
cmdq_pkt_write/wfe...) again. Finally, the consumer get the real size
and fix it.

> 
> > +		return -ENOMEM;
> > +	}
> > +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> > +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> > +
> > +	return 0;
> > +}

[...]

> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> > new file mode 100644
> > index 0000000..fc84fe4

[...]

> > +/**
> > + * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
> > + * @pkt:	the CMDQ packet
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + *
> > + * Trigger CMDQ to execute the CMDQ packet. Note that this is a
> > + * synchronous flush function. When the function returned, the recorded
> > + * commands have been done.
> > + */
> > +int cmdq_pkt_flush(struct cmdq_pkt *pkt);
> > +
> > +/**
> > + * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> > + *                          packet and call back at the end of done packet
> > + * @pkt:	the CMDQ packet
> > + * @cb:		called at the end of done packet
> > + * @data:	this data will pass back to cb
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + *
> > + * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
> > + * at the end of done packet. Note that this is an ASYNC function. When the
> > + * function returned, it may or may not be finished.
> > + */
> > +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
> > +			 void *data);
> > +
> 
> bikeshadding alarm:
> can we order the functions in the include file the same way we do in the c file?

Will adjust the functions order in mtk_cmdq.h, thanks.

> Apart from the few comments, the driver looks fine to me.
> 
> Regards,
> Matthias


