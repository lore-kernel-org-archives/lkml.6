Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CFE11C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9062E208AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:46:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9062E208AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754548AbeFMHqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:46:33 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:55098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754452AbeFMHqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:46:30 -0400
X-UUID: 7e12276a99074c9dade534553a7020e6-20180613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 527931738; Wed, 13 Jun 2018 15:46:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 15:46:23 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 15:46:23 +0800
Message-ID: <1528875983.11190.29.camel@mtksdccf07>
Subject: Re: [PATCH 13/28] drm/mediatek: add connection from RDMA0 to DSI3
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 13 Jun 2018 15:46:23 +0800
In-Reply-To: <1528868751.15127.10.camel@mtksdaap41>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-14-git-send-email-stu.hsieh@mediatek.com>
         <1528868751.15127.10.camel@mtksdaap41>
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

On Wed, 2018-06-13 at 13:45 +0800, CK Hu wrote:
> Hi, Stu:
> 
> Two inline comment.
> 
> On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > This patch add the connection from RDMA0 to DSI3
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 4 ++++
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > index c08aed8dae44..fed1b5704355 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > @@ -83,6 +83,7 @@
> >  #define GAMMA_MOUT_EN_RDMA1		0x1
> >  #define RDMA0_MOUT_DPI0			0x2
> >  #define RDMA0_MOUT_DSI2			0x4
> > +#define RDMA0_MOUT_DSI3			0x5
> 
> Usually, each bit of a mout register represent a output enable. Is this
> value 0x5 is a correct value?

In hw CONFIG SPEC show as following:
Bit(s)	Name			Description
2:0	DISP_PATH0_SOUT_SEL_IN	0 : Output to DSI0
				1:  Ooutput to DSI1
				2:  Ooutput to DPI
				3:  Ooutput to DPI1
				4:  Ooutput to DSI2
				5:  Ooutput to DSI3
				6 : reserved
				7:  Ooutput to DISP_UFOE
So, the value 0x5 is correct value.

Regard,
Stu

> 
> >  #define RDMA1_MOUT_DPI0			0x2
> >  #define DPI0_SEL_IN_RDMA1		0x1
> >  #define COLOR1_SEL_IN_OVL1		0x1
> > @@ -164,6 +165,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> >  	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI2) {
> >  		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> >  		value = RDMA0_MOUT_DSI2;
> > +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DSI3) {
> > +		*addr = DISP_REG_CONFIG_DISP_RDMA0_MOUT_EN;
> > +		value = RDMA0_MOUT_DSI3;
> >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> >  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> >  		value = RDMA1_MOUT_DPI0;
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index fe6fdc021fc7..22f4c72fa785 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -228,7 +228,7 @@ static const struct mtk_ddp_comp_match mtk_ddp_matches[DDP_COMPONENT_ID_MAX] = {
> >  	[DDP_COMPONENT_DSI0]	= { MTK_DSI,		0, NULL },
> >  	[DDP_COMPONENT_DSI1]	= { MTK_DSI,		1, NULL },
> >  	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		2, NULL },
> > -	[DDP_COMPONENT_DSI2]	= { MTK_DSI,		3, NULL },
> > +	[DDP_COMPONENT_DSI3]	= { MTK_DSI,		3, NULL },
> 
> I think this is not related to this patch.
OK

> 
> Regards,
> CK
> 
> >  	[DDP_COMPONENT_GAMMA]	= { MTK_DISP_GAMMA,	0, &ddp_gamma },
> >  	[DDP_COMPONENT_OD0]	= { MTK_DISP_OD,	0, &ddp_od },
> >  	[DDP_COMPONENT_OD1]	= { MTK_DISP_OD,	1, &ddp_od },
> 
> 


