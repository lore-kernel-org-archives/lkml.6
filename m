Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0EBCC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DD52563C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 01:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65DD52563C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752905AbeF1BHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 21:07:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:40814 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751177AbeF1BHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 21:07:15 -0400
X-UUID: 8bf21b70bb4843d4b8dcc843633bdfd5-20180628
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1778603653; Thu, 28 Jun 2018 09:07:11 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 09:07:08 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 09:07:09 +0800
Message-ID: <1530148028.6193.9.camel@mtksdaap41>
Subject: Re: [PATCH v21 4/4] soc: mediatek: Add Mediatek CMDQ helper
From:   CK Hu <ck.hu@mediatek.com>
To:     houlong wei <houlong.wei@mediatek.com>
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
Date:   Thu, 28 Jun 2018 09:07:08 +0800
In-Reply-To: <1530099833.31725.7.camel@mhfsdcap03>
References: <1517383693-25591-1-git-send-email-houlong.wei@mediatek.com>
         <1517383693-25591-5-git-send-email-houlong.wei@mediatek.com>
         <1519200345.8716.68.camel@mtksdaap41> <1530099833.31725.7.camel@mhfsdcap03>
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

On Wed, 2018-06-27 at 19:43 +0800, houlong wei wrote:
> On Wed, 2018-02-21 at 16:05 +0800, CK Hu wrote:
> > Hi, Houlong:
> > 
> > I've one more inline comment.
> > 
> > On Wed, 2018-01-31 at 15:28 +0800, houlong.wei@mediatek.com wrote:
> > > From: "hs.liao@mediatek.com" <hs.liao@mediatek.com>
> > > 
> > > Add Mediatek CMDQ helper to create CMDQ packet and assemble GCE op code.
> > > 
> > > Signed-off-by: Houlong Wei <houlong.wei@mediatek.com>
> > > Signed-off-by: HS Liao <hs.liao@mediatek.com>
> > > ---
> > >  drivers/soc/mediatek/Kconfig           |   12 ++
> > >  drivers/soc/mediatek/Makefile          |    1 +
> > >  drivers/soc/mediatek/mtk-cmdq-helper.c |  322 ++++++++++++++++++++++++++++++++
> > >  include/linux/soc/mediatek/mtk-cmdq.h  |  174 +++++++++++++++++
> > >  4 files changed, 509 insertions(+)
> > >  create mode 100644 drivers/soc/mediatek/mtk-cmdq-helper.c
> > >  create mode 100644 include/linux/soc/mediatek/mtk-cmdq.h
> > > 
> > > diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> > > index a7d0667..e66582e 100644
> > > --- a/drivers/soc/mediatek/Kconfig
> > > +++ b/drivers/soc/mediatek/Kconfig
> > > @@ -4,6 +4,18 @@
> > >  menu "MediaTek SoC drivers"
> > >  	depends on ARCH_MEDIATEK || COMPILE_TEST
> > >  

[...]

> > > +
> > > +static int cmdq_pkt_append_command(struct cmdq_pkt *pkt, enum cmdq_code code,
> > > +				   u32 arg_a, u32 arg_b)
> > > +{
> > > +	u64 *cmd_ptr;
> > > +	int err;
> > > +
> > > +	if (WARN_ON(cmdq_pkt_is_finalized(pkt)))
> > > +		return -EBUSY;
> > > +	if (unlikely(pkt->cmd_buf_size + CMDQ_INST_SIZE > pkt->buf_size)) {
> > > +		err = cmdq_pkt_realloc_cmd_buffer(pkt, pkt->buf_size << 1);
> > 
> > In your design, the command buffer is frequently allocated and freed.
> > But client may not want this mechanism because it have penalty on CPU
> > loading and may have risk of allocation failure. The client may
> > pre-allocate the command buffer and reuse it. So it's better to let
> > client decide which buffer management it want. That means cmdq helper do
> > not allocate command buffer and do not reallocate it. The working flow
> > would be:
> > 
> > For client that want to pre-allocate buffer:
> > (1) Client pre-allocate a command buffer with a pre-calculated size.
> > (Programmer should make sure that all command would not exceed this
> > size)
> > (2) Client use cmdq helper function to generate command in command
> > buffer. If command buffer is full, helper still increase
> > pkt->cmd_buf_size but do not write command into command buffer.
> > (3) When client flush packet, cmdq helper could check whether
> > pkt->cmd_buf_size is greater than pkt->buf_size, if so, return error and
> > programmer should modify the pre-calculated size in step (1).
> > (4) Wait for command done.
> > (5) Set pkt->cmd_buf_size to zero and directly goto step (2) to reuse
> > this command buffer.
> > 
> > For client that want to dynamically allocate buffer:
> > (1) Client dynamically allocate a command buffer with a initial size,
> > for example, 1024 bytes.
> > (2) Client use cmdq helper function to generate command in command
> > buffer. If command buffer is full, helper still increase
> > pkt->cmd_buf_size but do not write command into command buffer.
> > (3) When client flush packet, cmdq helper could check whether
> > pkt->cmd_buf_size is greater than pkt->buf_size, if so, return error and
> > client goto step (1) and reallocate a command buffer with pkt->buf_size.
> > (4) Wait for command done.
> > (5) Free the command buffer.
> > 
> > Because the reallocation is so complicated, for client that want to
> > dynamically allocate buffer, the initial buffer size could also be
> > pre-calculated that you need not to reallocate it. Once the buffer is
> > full, programmer should also fix the accurate buffer size.
> > 
> > Regards,
> > CK
> > 
> 
> Hi CK, thanks for your explanation and suggestion. Currently, the cmdq
> buffer is allocated in cmdq_pkt_create and its initial size is
> PAGE_SIZE. In most case of display scenario, PAGE_SIZE(4096) bytes are
> enough.
> 

You use the tern 'most' means you still need to consider the size over
PAGE_SIZE. If in current application, PAGE_SIZE is enough for display, I
think you still should remove this reallocation in the first patch
because you need not to reallocation. Once the display need more than
PAGE_SIZE, you send the another patch that support client to set the
initial size. I think we should make the first patch as simple as
possible, and you could add another patch to improve it.

Regards,
CK

> > > +		if (err < 0)
> > > +			return err;
> > > +	}
> > > +	cmd_ptr = pkt->va_base + pkt->cmd_buf_size;
> > > +	(*cmd_ptr) = (u64)((code << CMDQ_OP_CODE_SHIFT) | arg_a) << 32 | arg_b;
> > > +	pkt->cmd_buf_size += CMDQ_INST_SIZE;
> > > +	return 0;
> > > +}
> > > +

[...]
> 
> 


