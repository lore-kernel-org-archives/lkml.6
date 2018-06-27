Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD55C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19D132646A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 11:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19D132646A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964828AbeF0Lct (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 07:32:49 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:59036 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752634AbeF0Lcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 07:32:48 -0400
X-UUID: 24527c5f0347453e93b45357d5e611d5-20180627
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <houlong.wei@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1250757454; Wed, 27 Jun 2018 19:32:44 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs08n1.mediatek.inc
 (172.21.101.55) with Microsoft SMTP Server (TLS) id 15.0.1210.3; Wed, 27 Jun
 2018 19:32:42 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 27 Jun 2018 19:32:40 +0800
Message-ID: <1530099160.31725.1.camel@mhfsdcap03>
Subject: Re: [PATCH v21 4/4] soc: mediatek: Add Mediatek CMDQ helper
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
        Cawa Cheng =?UTF-8?Q?=28=E9=84=AD=E6=9B=84=E7=A6=A7=29?= 
        <cawa.cheng@mediatek.com>,
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>,
        YT Shen =?UTF-8?Q?=28=E6=B2=88=E5=B2=B3=E9=9C=86=29?= 
        <Yt.Shen@mediatek.com>,
        Daoyuan Huang =?UTF-8?Q?=28=E9=BB=83=E9=81=93=E5=8E=9F=29?= 
        <Daoyuan.Huang@mediatek.com>,
        Damon Chu =?UTF-8?Q?=28=E6=9C=B1=E5=B3=BB=E8=B3=A2=29?= 
        <Damon.Chu@mediatek.com>,
        Josh-YC Liu =?UTF-8?Q?=28=E5=8A=89=E8=82=B2=E8=AA=A0=29?= 
        <Josh-YC.Liu@mediatek.com>,
        Glory Hung =?UTF-8?Q?=28=E6=B4=AA=E6=99=BA=E7=91=8B=29?= 
        <glory.hung@mediatek.com>,
        Jiaguang Zhang =?UTF-8?Q?=28=E5=BC=A0=E5=8A=A0=E5=B9=BF=29?= 
        <Jiaguang.Zhang@mediatek.com>,
        Dennis-YC Hsieh =?UTF-8?Q?=28=E8=AC=9D=E5=AE=87=E5=93=B2=29?= 
        <Dennis-YC.Hsieh@mediatek.com>,
        Monica Wang =?UTF-8?Q?=28=E7=8E=8B=E5=AD=9F=E5=A9=B7=29?= 
        <monica.wang@mediatek.com>,
        Hs Liao =?UTF-8?Q?=28=E5=BB=96=E5=AE=8F=E7=A5=A5=29?= 
        <Hs.Liao@mediatek.com>
Date:   Wed, 27 Jun 2018 19:32:40 +0800
In-Reply-To: <1517885553.24456.19.camel@mtksdaap41>
References: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
         <1517383693-25591-5-git-send-email-houlong.wei@mediatek.com>
         <1517885553.24456.19.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-02-06 at 10:52 +0800, CK Hu wrote:
> Hi, Houlong:
> 
> I've some inline comment.
> 
> On Wed, 2018-01-31 at 15:28 +0800, houlong.wei@mediatek.com wrote:
> > From: "hs.liao@mediatek.com" <hs.liao@mediatek.com>
> >
> > Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> >
> > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > ---
> >  drivers/soc/mediatek/Kconfig           |   12 ++
> >  drivers/soc/mediatek/Makefile          |    1 +
> >  drivers/soc/mediatek/mtk-cmdq-helper.c |  322 ++++++++++++++++++++++++++++++++
> >  include/linux/soc/mediatek/mtk-cmdq.h  |  174 +++++++++++++++++
> >  4 files changed, 509 insertions(+)
> >  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> >  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> >
> > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > index a7d0667..e66582e 100644
> > --- a/drivers/soc/mediatek/Kconfig
> > +++ b/drivers/soc/mediatek/Kconfig
> > @@ -4,6 +4,18 @@
> >  menu "MediaTek SoC drivers"
> >  depends on ARCH_MEDIATEK || COMPILE_TEST
> >
> > +config MTK_CMDQ
> > +bool "MediaTek CMDQ Support"
> > +depends on ARM64 && ( ARCH_MEDIATEK || COMPILE_TEST )
> > +select MAILBOX
> > +select MTK_CMDQ_MBOX
> > +select MTK_INFRACFG
> > +help
> > +  Say yes here to add support for the MediaTek Command Queue (CMDQ)
> > +  driver. The CMDQ is used to help read/write registers with critical
> > +  time limitation, such as updating display configuration during the
> > +  vblank.
> > +
> >  config MTK_INFRACFG
> >  bool "MediaTek INFRACFG Support"
> >  select REGMAP
> > diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> > index 12998b0..64ce5ee 100644
> > --- a/drivers/soc/mediatek/Makefile
> > +++ b/drivers/soc/mediatek/Makefile
> > @@ -1,3 +1,4 @@
> > +obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> >  obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> >  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
> >  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> > diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > new file mode 100644
> > index 0000000..80d0558
> > --- /dev/null
> > +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
> > @@ -0,0 +1,322 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#include <linux/completion.h>
> > +#include <linux/errno.h>
> > +#include <linux/of_address.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/mailbox_controller.h>
> > +#include <linux/soc/mediatek/mtk-cmdq.h>
> > +
> > +#define CMDQ_ARG_A_WRITE_MASK0xffff
> > +#define CMDQ_WRITE_ENABLE_MASKBIT(0)
> > +#define CMDQ_EOC_IRQ_ENBIT(0)
> > +#define CMDQ_EOC_CMD((u64)((CMDQ_CODE_EOC << CMDQ_OP_CODE_SHIFT)) \
> > +<< 32 | CMDQ_EOC_IRQ_EN)
> > +
> > +struct cmdq_subsys {
> > +u32base;
> > +intid;
> > +};
> > +
> > +static const struct cmdq_subsys gce_subsys[] = {
> > +{0x1400, 1},
> > +{0x1401, 2},
> > +{0x1402, 3},
> > +};
> 
> I think subsys definition varies by different SoC, so it's better to
> pass these definition from device tree to driver (client driver), and
> client driver pass this subsys in the related interface. For example,
> 
> in include/dt-bindings/gce/mt8173-gce.h, you define
> 
> #define GCE_SUBSYS_1400XXXX1
> #define GCE_SUBSYS_1401XXXX2
> #define GCE_SUBSYS_1402XXXX3
> 
> in device tree, place the subsys definition in client device node,
> 
> #include "dt-bindings/gce/mt8173-gce.h"
> 
> ovl0: ovl@1400c000 {
> compatible = "mediatek,mt8173-disp-ovl";
> gce-subsys = <GCE_SUBSYS_1400XXXX>;
> ...
> };
> 
> And client driver pass subsys in the related interface,
> 
> int cmdq_pkt_write(struct cmdq_pkt *pkt, u8 subsys, u16 offset, u32
> value);
> 
> So, for another SoC, you just need to modify device tree and you do not
> need to modify driver.

Hi CK, thanks for your suggestion. I do it in v22.

> > +
> > +static int cmdq_subsys_base_to_id(u32 base)
> > +{
> > +int i;
> > +
> > +for (i = 0; i < ARRAY_SIZE(gce_subsys); i++)
> > +if (gce_subsys[i].base == base)
> > +return gce_subsys[i].id;
> > +return -EFAULT;
> > +}
> > +
> > +static int cmdq_pkt_realloc_cmd_buffer(struct cmdq_pkt *pkt, size_t size)
> > +{
> > +void *new_buf;
> > +
> > +new_buf = krealloc(pkt->va_base, size, GFP_KERNEL | __GFP_ZERO);
> > +if (!new_buf)
> > +return -ENOMEM;
> > +pkt->va_base = new_buf;
> > +pkt->buf_size = size;
> > +return 0;
> > +}
> > +
> > +struct cmdq_base *cmdq_register_device(struct device *dev)
> > +{
> > +struct cmdq_base *cmdq_base;
> > +struct resource res;
> > +int subsys;
> > +u32 base;
> > +
> > +if (of_address_to_resource(dev->of_node, 0, &res))
> > +return NULL;
> > +base = (u32)res.start;
> > +
> > +subsys = cmdq_subsys_base_to_id(base >> 16);
> > +if (subsys < 0)
> > +return NULL;
> > +
> > +cmdq_base = devm_kmalloc(dev, sizeof(*cmdq_base), GFP_KERNEL);
> > +if (!cmdq_base)
> > +return NULL;
> > +cmdq_base->subsys = subsys;
> > +cmdq_base->base = base;
> > +
> > +return cmdq_base;
> > +}
> > +EXPORT_SYMBOL(cmdq_register_device);
> > +
> > +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index)
> > +{
> > +struct cmdq_client *client;
> > +
> > +client = kzalloc(sizeof(*client), GFP_KERNEL);
> > +client->client.dev = dev;
> > +client->client.tx_block = false;
> > +client->chan = mbox_request_channel(&client->client, index);
> > +return client;
> > +}
> > +EXPORT_SYMBOL(cmdq_mbox_create);
> > +
> > +void cmdq_mbox_destroy(struct cmdq_client *client)
> > +{
> > +mbox_free_channel(client->chan);
> > +kfree(client);
> > +}
> > +EXPORT_SYMBOL(cmdq_mbox_destroy);
> > +
> > +int cmdq_pkt_create(struct cmdq_pkt **pkt_ptr)
> > +{
> > +struct cmdq_pkt *pkt;
> > +int err;
> > +
> > +pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
> > +if (!pkt)
> > +return -ENOMEM;
> > +err = cmdq_pkt_realloc_cmd_buffer(pkt, PAGE_SIZE);
> > +if (err < 0) {
> > +kfree(pkt);
> > +return err;
> > +}
> > +*pkt_ptr = pkt;
> > +return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_create);
> > +
> > +void cmdq_pkt_destroy(struct cmdq_pkt *pkt)
> > +{
> > +kfree(pkt->va_base);
> > +kfree(pkt);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_destroy);
> > +
> > +static bool cmdq_pkt_is_finalized(struct cmdq_pkt *pkt)
> > +{
> > +u64 *expect_eoc;
> > +
> > +if (pkt->cmd_buf_size < CMDQ_INST_SIZE << 1)
> > +return false;
> > +
> > +expect_eoc = pkt->va_base + pkt->cmd_buf_size - (CMDQ_INST_SIZE << 1);
> > +if (*expect_eoc == CMDQ_EOC_CMD)
> > +return true;
> > +
> > +return false;
> > +}
> > +
> > +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> > +   u32 arg_a, u32 arg_b)
> > +{
> > +u64 *cmd_ptr;
> > +int err;
> > +
> > +if (WARN_ON(cmdq_pkt_is_finalized(pkt)))
> > +return -EBUSY;
> > +if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> > +err = cmdq_pkt_realloc_cmd_buffer(pkt, pkt->buf_size << 1);
> > +if (err < 0)
> > +return err;
> > +}
> > +cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> > +(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > +pkt->cmd_buf_size += CMDQ_INST_SIZE;
> > +return 0;
> > +}
> > +
> > +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value, struct cmdq_base *base,
> > +   u32 offset)
> > +{
> > +u32 arg_a = ((base->base + offset) & CMDQ_ARG_A_WRITE_MASK) |
> > +    (base->subsys << CMDQ_SUBSYS_SHIFT);
> > +return cmdq_pkt_append_command(pkt, CMDQ_CODE_WRITE, arg_a, value);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_write);
> > +
> > +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> > +struct cmdq_base *base, u32 offset, u32 mask)
> > +{
> > +u32 offset_mask = offset;
> > +int err;
> > +
> > +if (mask != 0xffffffff) {
> > +err = cmdq_pkt_append_command(pkt, CMDQ_CODE_MASK, 0, ~mask);
> > +if (err < 0)
> > +return err;
> > +offset_mask |= CMDQ_WRITE_ENABLE_MASK;
> > +}
> > +return cmdq_pkt_write(pkt, value, base, offset_mask);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_write_mask);
> > +
> > +static const u32 cmdq_event_value[CMDQ_MAX_EVENT] = {
> > +/* Display start of frame(SOF) events */
> > +[CMDQ_EVENT_DISP_OVL0_SOF] = 11,
> > +[CMDQ_EVENT_DISP_OVL1_SOF] = 12,
> > +[CMDQ_EVENT_DISP_RDMA0_SOF] = 13,
> > +[CMDQ_EVENT_DISP_RDMA1_SOF] = 14,
> > +[CMDQ_EVENT_DISP_RDMA2_SOF] = 15,
> > +[CMDQ_EVENT_DISP_WDMA0_SOF] = 16,
> > +[CMDQ_EVENT_DISP_WDMA1_SOF] = 17,
> > +/* Display end of frame(EOF) events */
> > +[CMDQ_EVENT_DISP_OVL0_EOF] = 39,
> > +[CMDQ_EVENT_DISP_OVL1_EOF] = 40,
> > +[CMDQ_EVENT_DISP_RDMA0_EOF] = 41,
> > +[CMDQ_EVENT_DISP_RDMA1_EOF] = 42,
> > +[CMDQ_EVENT_DISP_RDMA2_EOF] = 43,
> > +[CMDQ_EVENT_DISP_WDMA0_EOF] = 44,
> > +[CMDQ_EVENT_DISP_WDMA1_EOF] = 45,
> > +/* Mutex end of frame(EOF) events */
> > +[CMDQ_EVENT_MUTEX0_STREAM_EOF] = 53,
> > +[CMDQ_EVENT_MUTEX1_STREAM_EOF] = 54,
> > +[CMDQ_EVENT_MUTEX2_STREAM_EOF] = 55,
> > +[CMDQ_EVENT_MUTEX3_STREAM_EOF] = 56,
> > +[CMDQ_EVENT_MUTEX4_STREAM_EOF] = 57,
> > +/* Display underrun events */
> > +[CMDQ_EVENT_DISP_RDMA0_UNDERRUN] = 63,
> > +[CMDQ_EVENT_DISP_RDMA1_UNDERRUN] = 64,
> > +[CMDQ_EVENT_DISP_RDMA2_UNDERRUN] = 65,
> > +};
> 
> The event is like subsys that it varies by different SoC, so it's better
> to pass this information from device tree to client driver. And the wait
> for event interface would become
> 
> int cmdq_pkt_wfe(struct cmdq_pkt *pkt, u16 event)
> 
> And cmdq driver need not to translate the event value.
> 
> Regards,
> CK

Hi CK, thanks for your suggestion. I do it in v22.

> > +
> > +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, enum cmdq_event event)
> > +{
> > +u32 arg_b;
> > +
> > +if (event >= CMDQ_MAX_EVENT || event < 0)
> > +return -EINVAL;
> > +
> > +/*
> > + * WFE arg_b
> > + * bit 0-11: wait value
> > + * bit 15: 1 - wait, 0 - no wait
> > + * bit 16-27: update value
> > + * bit 31: 1 - update, 0 - no update
> > + */
> > +arg_b = CMDQ_WFE_UPDATE | CMDQ_WFE_WAIT | CMDQ_WFE_WAIT_VALUE;
> > +return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE,
> > +cmdq_event_value[event], arg_b);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_wfe);
> > +
> > +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, enum cmdq_event event)
> > +{
> > +if (event >= CMDQ_MAX_EVENT || event < 0)
> > +return -EINVAL;
> > +
> > +return cmdq_pkt_append_command(pkt, CMDQ_CODE_WFE,
> > +cmdq_event_value[event], CMDQ_WFE_UPDATE);
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_clear_event);
> > +
> > +static int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
> > +{
> > +int err;
> > +
> > +if (cmdq_pkt_is_finalized(pkt))
> > +return 0;
> > +
> > +/* insert EOC and generate IRQ for each command iteration */
> > +err = cmdq_pkt_append_command(pkt, CMDQ_CODE_EOC, 0, CMDQ_EOC_IRQ_EN);
> > +if (err < 0)
> > +return err;
> > +
> > +/* JUMP to end */
> > +err = cmdq_pkt_append_command(pkt, CMDQ_CODE_JUMP, 0, CMDQ_JUMP_PASS);
> > +if (err < 0)
> > +return err;
> > +
> > +return 0;
> > +}
> > +
> > +int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
> > + cmdq_async_flush_cb cb, void *data)
> > +{
> > +int err;
> > +struct device *dev;
> > +dma_addr_t dma_addr;
> > +
> > +err = cmdq_pkt_finalize(pkt);
> > +if (err < 0)
> > +return err;
> > +
> > +dev = client->chan->mbox->dev;
> > +dma_addr = dma_map_single(dev, pkt->va_base, pkt->cmd_buf_size,
> > +DMA_TO_DEVICE);
> > +if (dma_mapping_error(dev, dma_addr)) {
> > +dev_err(client->chan->mbox->dev, "dma map failed\n");
> > +return -ENOMEM;
> > +}
> > +
> > +pkt->pa_base = dma_addr;
> > +pkt->cb.cb = cb;
> > +pkt->cb.data = data;
> > +
> > +mbox_send_message(client->chan, pkt);
> > +/* We can send next packet immediately, so just call txdone. */
> > +mbox_client_txdone(client->chan, 0);
> > +
> > +return 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_flush_async);
> > +
> > +struct cmdq_flush_completion {
> > +struct completion cmplt;
> > +bool err;
> > +};
> > +
> > +static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
> > +{
> > +struct cmdq_flush_completion *cmplt = data.data;
> > +
> > +cmplt->err = data.err;
> > +complete(&cmplt->cmplt);
> > +}
> > +
> > +int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt)
> > +{
> > +struct cmdq_flush_completion cmplt;
> > +int err;
> > +
> > +init_completion(&cmplt.cmplt);
> > +err = cmdq_pkt_flush_async(client, pkt, cmdq_pkt_flush_cb, &cmplt);
> > +if (err < 0)
> > +return err;
> > +wait_for_completion(&cmplt.cmplt);
> > +return cmplt.err ? -EFAULT : 0;
> > +}
> > +EXPORT_SYMBOL(cmdq_pkt_flush);
> > diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
> > new file mode 100644
> > index 0000000..5b35d73
> > --- /dev/null
> > +++ b/include/linux/soc/mediatek/mtk-cmdq.h
> > @@ -0,0 +1,174 @@
> > +/*
> > + * Copyright (c) 2015 MediaTek Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License version 2 as
> > + * published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> > +
> > +#ifndef __MTK_CMDQ_H__
> > +#define __MTK_CMDQ_H__
> > +
> > +#include <linux/mailbox_client.h>
> > +#include <linux/mailbox/mtk-cmdq-mailbox.h>
> > +
> > +/* display events in command queue(CMDQ) */
> > +enum cmdq_event {
> > +/* Display start of frame(SOF) events */
> > +CMDQ_EVENT_DISP_OVL0_SOF,
> > +CMDQ_EVENT_DISP_OVL1_SOF,
> > +CMDQ_EVENT_DISP_RDMA0_SOF,
> > +CMDQ_EVENT_DISP_RDMA1_SOF,
> > +CMDQ_EVENT_DISP_RDMA2_SOF,
> > +CMDQ_EVENT_DISP_WDMA0_SOF,
> > +CMDQ_EVENT_DISP_WDMA1_SOF,
> > +/* Display end of frame(EOF) events */
> > +CMDQ_EVENT_DISP_OVL0_EOF,
> > +CMDQ_EVENT_DISP_OVL1_EOF,
> > +CMDQ_EVENT_DISP_RDMA0_EOF,
> > +CMDQ_EVENT_DISP_RDMA1_EOF,
> > +CMDQ_EVENT_DISP_RDMA2_EOF,
> > +CMDQ_EVENT_DISP_WDMA0_EOF,
> > +CMDQ_EVENT_DISP_WDMA1_EOF,
> > +/* Mutex end of frame(EOF) events */
> > +CMDQ_EVENT_MUTEX0_STREAM_EOF,
> > +CMDQ_EVENT_MUTEX1_STREAM_EOF,
> > +CMDQ_EVENT_MUTEX2_STREAM_EOF,
> > +CMDQ_EVENT_MUTEX3_STREAM_EOF,
> > +CMDQ_EVENT_MUTEX4_STREAM_EOF,
> > +/* Display underrun events */
> > +CMDQ_EVENT_DISP_RDMA0_UNDERRUN,
> > +CMDQ_EVENT_DISP_RDMA1_UNDERRUN,
> > +CMDQ_EVENT_DISP_RDMA2_UNDERRUN,
> > +/* Keep this at the end */
> > +CMDQ_MAX_EVENT,
> > +};
> > +
> > +struct cmdq_pkt;
> > +
> > +struct cmdq_base {
> > +intsubsys;
> > +u32base;
> > +};
> > +
> > +struct cmdq_client {
> > +struct mbox_client client;
> > +struct mbox_chan *chan;
> > +};
> > +
> > +/**
> > + * cmdq_register_device() - register device which needs CMDQ
> > + * @dev:device for CMDQ to access its registers
> > + *
> > + * Return: cmdq_base pointer or NULL for failed
> > + */
> > +struct cmdq_base *cmdq_register_device(struct device *dev);
> > +
> > +/**
> > + * cmdq_mbox_create() - create CMDQ mailbox client and channel
> > + * @dev:device of CMDQ mailbox client
> > + * @index:index of CMDQ mailbox channel
> > + *
> > + * Return: CMDQ mailbox client pointer
> > + */
> > +struct cmdq_client *cmdq_mbox_create(struct device *dev, int index);
> > +
> > +/**
> > + * cmdq_mbox_destroy() - destroy CMDQ mailbox client and channel
> > + * @client:the CMDQ mailbox client
> > + */
> > +void cmdq_mbox_destroy(struct cmdq_client *client);
> > +
> > +/**
> > + * cmdq_pkt_create() - create a CMDQ packet
> > + * @pkt_ptr:CMDQ packet pointer to retrieve cmdq_pkt
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_create(struct cmdq_pkt **pkt_ptr);
> > +
> > +/**
> > + * cmdq_pkt_destroy() - destroy the CMDQ packet
> > + * @pkt:the CMDQ packet
> > + */
> > +void cmdq_pkt_destroy(struct cmdq_pkt *pkt);
> > +
> > +/**
> > + * cmdq_pkt_write() - append write command to the CMDQ packet
> > + * @pkt:the CMDQ packet
> > + * @value:the specified target register value
> > + * @base:the CMDQ base
> > + * @offset:register offset from module base
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_write(struct cmdq_pkt *pkt, u32 value,
> > +   struct cmdq_base *base, u32 offset);
> > +
> > +/**
> > + * cmdq_pkt_write_mask() - append write command with mask to the CMDQ packet
> > + * @pkt:the CMDQ packet
> > + * @value:the specified target register value
> > + * @base:the CMDQ base
> > + * @offset:register offset from module base
> > + * @mask:the specified target register mask
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_write_mask(struct cmdq_pkt *pkt, u32 value,
> > +struct cmdq_base *base, u32 offset, u32 mask);
> > +
> > +/**
> > + * cmdq_pkt_wfe() - append wait for event command to the CMDQ packet
> > + * @pkt:the CMDQ packet
> > + * @event:the desired event type to "wait and CLEAR"
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_wfe(struct cmdq_pkt *pkt, enum cmdq_event event);
> > +
> > +/**
> > + * cmdq_pkt_clear_event() - append clear event command to the CMDQ packet
> > + * @pkt:the CMDQ packet
> > + * @event:the desired event to be cleared
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + */
> > +int cmdq_pkt_clear_event(struct cmdq_pkt *pkt, enum cmdq_event event);
> > +
> > +/**
> > + * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
> > + * @client:the CMDQ mailbox client
> > + * @pkt:the CMDQ packet
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + *
> > + * Trigger CMDQ to execute the CMDQ packet. Note that this is a
> > + * synchronous flush function. When the function returned, the recorded
> > + * commands have been done.
> > + */
> > +int cmdq_pkt_flush(struct cmdq_client *client, struct cmdq_pkt *pkt);
> > +
> > +/**
> > + * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
> > + *                          packet and call back at the end of done packet
> > + * @client:the CMDQ mailbox client
> > + * @pkt:the CMDQ packet
> > + * @cb:called at the end of done packet
> > + * @data:this data will pass back to cb
> > + *
> > + * Return: 0 for success; else the error code is returned
> > + *
> > + * Trigger CMDQ to asynchronously execute the CMDQ packet and call back
> > + * at the end of done packet. Note that this is an ASYNC function. When the
> > + * function returned, it may or may not be finished.
> > + */
> > +int cmdq_pkt_flush_async(struct cmdq_client *client, struct cmdq_pkt *pkt,
> > + cmdq_async_flush_cb cb, void *data);
> > +
> > +#endif/* __MTK_CMDQ_H__ */
> 
> 


