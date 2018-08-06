Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD3FC4646D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BF6B21A0B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 11:54:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BF6B21A0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbeHFOCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 10:02:50 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:62605 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730245AbeHFOCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 10:02:50 -0400
X-UUID: edcc95acbf4648a5b74672c4fb050e32-20180806
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 719257665; Mon, 06 Aug 2018 19:53:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 6 Aug 2018 19:53:55 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 6 Aug 2018 19:53:55 +0800
Message-ID: <1533556434.11190.70.camel@mtksdccf07>
Subject: Re: [PATCH v2 12/15] drm/mediatek: add callback function to return
 RDMA layer number
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Mon, 6 Aug 2018 19:53:54 +0800
In-Reply-To: <1533273202.31144.8.camel@mtksdaap41>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
         <1533265868-28110-13-git-send-email-stu.hsieh@mediatek.com>
         <1533273202.31144.8.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, CK:

On Fri, 2018-08-03 at 13:13 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Fri, 2018-08-03 at 11:11 +0800, Stu Hsieh wrote:
> > This patch add callback function to return RDMA layer number
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index b728f0f42611..8c145a87c9e5 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -60,6 +60,7 @@
> >  
> >  struct mtk_disp_rdma_data {
> >  	unsigned int fifo_size;
> > +	unsigned int layer_nr;
> >  };
> >  
> >  /**
> > @@ -194,6 +195,13 @@ static unsigned int rdma_fmt_convert(struct mtk_disp_rdma *rdma,
> >  	}
> >  }
> >  
> > +static unsigned int mtk_rdma_layer_nr(struct mtk_ddp_comp *comp)
> > +{
> > +	struct mtk_disp_rdma *rdma = comp_to_rdma(comp);
> > +
> > +	return rdma->data->layer_nr;
> 
> Maybe RDMA always has one layer, so you could just return 1 here.
> 
> Regards,
> CK
> 
OK

Regards,
Stu

> > +}
> > +
> >  static void mtk_rdma_layer_config(struct mtk_ddp_comp *comp, unsigned int idx,
> >  				  struct mtk_plane_state *state)
> >  {
> > @@ -227,6 +235,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_rdma_funcs = {
> >  	.stop = mtk_rdma_stop,
> >  	.enable_vblank = mtk_rdma_enable_vblank,
> >  	.disable_vblank = mtk_rdma_disable_vblank,
> > +	.layer_nr = mtk_rdma_layer_nr,
> >  	.layer_config = mtk_rdma_layer_config,
> >  };
> >  
> > @@ -329,6 +338,7 @@ static const struct mtk_disp_rdma_data mt2701_rdma_driver_data = {
> >  
> >  static const struct mtk_disp_rdma_data mt8173_rdma_driver_data = {
> >  	.fifo_size = SZ_8K,
> > +	.layer_nr = 1,
> >  };
> >  
> >  static const struct of_device_id mtk_disp_rdma_driver_dt_match[] = {
> 
> 


