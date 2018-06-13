Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E0E68C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A138C20693
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:59:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A138C20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934426AbeFMG7K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:59:10 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2767 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933318AbeFMG7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:59:09 -0400
X-UUID: d04e0021f9374b4e8bcf77404540494c-20180613
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1482364207; Wed, 13 Jun 2018 14:59:05 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 14:59:03 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 14:59:03 +0800
Message-ID: <1528873143.30263.1.camel@mtksdaap41>
Subject: Re: [PATCH 15/28] drm/mediatek: add connection from RDMA1 to DSI1
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 13 Jun 2018 14:59:03 +0800
In-Reply-To: <1528872242.27532.0.camel@mtksdaap41>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-16-git-send-email-stu.hsieh@mediatek.com>
         <1528872242.27532.0.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Stu:

On Wed, 2018-06-13 at 14:44 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > This patch add the connection from RDMA1 to DSI1
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index 4abd5dabeccf..7e4ad5580cf6 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -28,6 +28,7 @@
> >  #define DISP_REG_CONFIG_DISP_UFOE_MOUT_EN	0x050
> >  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
> >  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
> > +#define DISP_REG_CONFIG_DSIO_SEL_IN		0x0a8
> >  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> >  #define DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN	0x0c4
> >  #define DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN	0x0c8
> > @@ -84,10 +85,12 @@
> >  #define RDMA0_MOUT_DPI0			0x2
> >  #define RDMA0_MOUT_DSI2			0x4
> >  #define RDMA0_MOUT_DSI3			0x5
> > +#define RDMA1_MOUT_DSI1			0x1
> >  #define RDMA1_MOUT_DPI0			0x2
> >  #define RDMA1_MOUT_DPI1			0x3
> >  #define DPI0_SEL_IN_RDMA1		0x1
> >  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
> > +#define DSI1_SEL_IN_RDMA1		0x1
> >  #define COLOR1_SEL_IN_OVL1		0x1
> >  
> >  #define OVL_MOUT_EN_RDMA		0x1
> > @@ -170,6 +173,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
> >  		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> >  		value = RDMA0_MOUT_DSI3;
> > +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
> > +		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> > +		value = RDMA1_MOUT_DSI1;
> >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> >  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> >  		value = RDMA1_MOUT_DPI0;
> > @@ -198,6 +204,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> >  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> >  		value = DPI1_SEL_IN_RDMA1;
> > +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
> > +		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
> 
> Does data sheet use the naming 'DSI0'? You use this register to select
> DSI1 input.

This is DSIO not DSI0, so it's OK for me.

Reviewed-by: CK Hu <ck.hu at mediatek.com>

> 
> Regards,
> CK
> 
> > +		value = DSI1_SEL_IN_RDMA1;
> >  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
> >  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
> >  		value = COLOR1_SEL_IN_OVL1;
> 


