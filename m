Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3AFC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A02B27A69
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A02B27A69
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936218AbeF1Xcb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:32:31 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:14603 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753166AbeF1Xc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:32:29 -0400
X-UUID: a9e8fbe825e543ad8b2ef7e5f50e9547-20180629
Received: from mtkcas36.mediatek.inc [(172.27.4.250)] by mailgw02.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1601711452; Fri, 29 Jun 2018 07:32:23 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Fri, 29 Jun
 2018 07:32:21 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 29 Jun 2018 07:32:19 +0800
Message-ID: <1530228739.21991.14.camel@mhfsdcap03>
Subject: Re: [PATCH v22 4/4] soc: mediatek: Add Mediatek CMDQ helper
From:   houlong wei <houlong.wei@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
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
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
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
Date:   Fri, 29 Jun 2018 07:32:19 +0800
In-Reply-To: <1530182516.8518.11.camel@mtksdaap41>
References: <1530098172-31385-1-git-send-email-houlong.wei@mediatek.com>
         <1530098172-31385-5-git-send-email-houlong.wei@mediatek.com>
         <1530182516.8518.11.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-06-28 at 18:41 +0800, CK Hu wrote:
> Hi, Houlong:
> 
> Some inline comment.
> 
> On Wed, 2018-06-27 at 19:16 +0800, Houlong Wei wrote:
> > Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> > 
> > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig           |   12 ++
> >  drivers/soc/mediatek/Makefile          |    1 +
> >  drivers/soc/mediatek/mtk-cmdq-helper.c |  258 ++++++++++++++++++++++++++++++++
> >  include/linux/soc/mediatek/mtk-cmdq.h  |  132 ++++++++++++++++
> >  4 files changed, 403 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> >  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> > 
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index a7d0667..17bd759 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -4,6 +4,18 @@
> >  menu "MediaTek SoC drivers"
> >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> >  
> 
> [...]
> 
> > +
> > +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u32 event)
> > +{
> > +	u32 arg_b;
> > +
> > +	if (event >= CMDQ_MAX_EVENT || event < 0)
> 
> The type of event is 'u32', so checking 'event < 0' is redundant.

will fix.

> 
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * WFE arg_b
> > +	 * bit 0-11: wait value
> > +	 * bit 15: 1 - wait, 0 - no wait
> > +	 * bit 16-27: update value
> > +	 * bit 31: 1 - update, 0 - no update
> > +	 */
> > +	arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> > +
> > +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event, arg_b);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_wfe);
> > +
> > +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, u32 event)
> > +{
> > +	if (event >= CMDQ_MAX_EVENT || event < 0)
> 
> The type of event is 'u32', so checking 'event < 0' is redundant.

Will fix.

> 
> > +		return -EINVAL;
> > +
> > +	return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE, event,
> > +				       CMDQ_WFE_UPDATE);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_clear_event);
> > +
> > +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> > +{
> > +	int err;
> > +
> > +	if (cmdq_pkt_is_finalized(pkt))
> > +		return 0;
> > +
> > +	/* insert EOC and generate IRQ for each command iteration */
> > +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	/* JUMP to end */
> > +	err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	return 0;
> > +}
> > +
> > +int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
> > +			 cmdq_async_flush_cb cb, void *data)
> > +{
> > +	int err;
> > +	struct device *dev;
> > +	dma_addr_t dma_addr;
> > +
> > +	err = cmdq_pkt_finalize(pkt);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	dev = client->chan->mbox->dev;
> > +	dma_addr = dma_map_single(dev, pkt->va_base, pkt->cmd_buf_size,
> > +		DMA_TO_DEVICE);
> 
> You map here, but I could not find unmap, so the unmap should be done in
> client driver. I would prefer a symmetric map/unmap which means that
> both map and unmap are done in client driver. I think you put map here
> because you should map after finalize. 

The unmap is done before callback to client, in function
cmdq_task_exec_done, mtk-cmdq-mailbox.c.

> Therefore, export
> cmdq_pkt_finalize() to client driver and let client do finalize, so
> there is no finalize in flush function. This method have a benefit that
> if client reuse command buffer, it need not to map/unmap frequently.

If client reuse command buffer or cmdq_pkt(command queue packet), client
will add new commands to the cmdq_pkt, so map/unmap are necessary for
each cmdq_pkt flush.

> 
> Regards,
> CK
> 
> > +	if (dma_mapping_error(dev, dma_addr)) {
> > +		dev_err(client->chan->mbox->dev, "dma map failed\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	pkt->pa_base = dma_addr;
> > +	pkt->cb.cb = cb;
> > +	pkt->cb.data = data;
> > +
> > +	mbox_send_message(client->chan, pkt);
> > +	/* We can send next packet immediately, so just call txdone. */
> > +	mbox_client_txdone(client->chan, 0);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_flush_async);
> > +
> > +struct cmdq_flush_completion {
> > +	struct completion cmplt;
> > +	bool err;
> > +};
> > +
> > +static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> > +{
> > +	struct cmdq_flush_completion *cmplt = data.data;
> > +
> > +	cmplt->err = data.err;
> > +	complete(&cmplt->cmplt);
> > +}
> > +
> > +int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt)
> > +{
> > +	struct cmdq_flush_completion cmplt;
> > +	int err;
> > +
> > +	init_completion(&cmplt.cmplt);
> > +	err = cmdq_pkt_flush_async(client, pkt, cmdq_pkt_flush_cb, &cmplt);
> > +	if (err < 0)
> > +		return err;
> > +	wait_for_completion(&cmplt.cmplt);
> > +
> > +	return cmplt.err ? -EFAULT : 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_flush);
> 
> [...]
> 
> 


