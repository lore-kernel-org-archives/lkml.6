Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id CDB8EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB2A20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB2A20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754579AbeFMIOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:14:43 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:2430 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754500AbeFMIOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:14:41 -0400
X-UUID: 3d3b2693248a4558a8677b6928982d57-20180613
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 942603049; Wed, 13 Jun 2018 16:14:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 16:14:35 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 16:14:35 +0800
Message-ID: <1528877675.30263.27.camel@mtksdaap41>
Subject: Re: [PATCH 19/28] drm/mediatek: add connection from RDMA2 to DPI1
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
Date:   Wed, 13 Jun 2018 16:14:35 +0800
In-Reply-To: <1528876862.11190.35.camel@mtksdccf07>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-20-git-send-email-stu.hsieh@mediatek.com>
         <1528874037.30263.6.camel@mtksdaap41>
         <1528876862.11190.35.camel@mtksdccf07>
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

On Wed, 2018-06-13 at 16:01 +0800, Stu Hsieh wrote:
> Hi, CK:
> 
> 
> On Wed, 2018-06-13 at 15:13 +0800, CK Hu wrote:
> > Hi, Stu:
> > 
> > On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > > This patch add the connection from RDMA2 to DPI1
> > > 
> > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > ---
> > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > index 31a0832ef9ec..2d883815d79c 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > @@ -93,9 +93,11 @@
> > >  #define RDMA1_MOUT_DPI0			0x2
> > >  #define RDMA1_MOUT_DPI1			0x3
> > >  #define RDMA2_MOUT_DPI0			0x2
> > > +#define RDMA2_MOUT_DPI1			0x3
> > 
> > Usually, each bit of a mout register represent a output enable. Is this
> > value 0x3 a correct value?
> > 
> > Regards,
> > CK
> > 
> In HW CONFIG SPEC or MT2712_E2_MMSYS_Change_note show as following:
> 
> Bit(s)	Name			Description
> 2:0	DISP_RDMA2_SOUT_SEL_IN	0: output to dsi0
> 				1: outptu to dsi1
> 				2: output to dpi0
> 				3: output to dpi1
> 				4: output to dsi2
> 				5: output to dsi3
> 
> So, 0x3 is correct value.

The data sheet use the term SOUT match its function, so I think driver
have better change the naming to SOUT.

Regards,
CK

> 
> Regard,
> Stu
> 
> > >  #define DPI0_SEL_IN_RDMA1		0x1
> > >  #define DPI0_SEL_IN_RDMA2		0x3
> > >  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
> > > +#define DPI1_SEL_IN_RDMA2		(0x3 << 8)
> > >  #define DSI1_SEL_IN_RDMA1		0x1
> > >  #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
> > >  #define DSI3_SEL_IN_RDMA1		(0x1 << 16)
> > > @@ -199,6 +201,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> > >  	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> > >  		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> > >  		value = RDMA2_MOUT_DPI0;
> > > +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
> > > +		*addr = DISP_REG_CONFIG_DISP_RDMA2_SOUT;
> > > +		value = RDMA2_MOUT_DPI1;
> > >  	} else {
> > >  		value = 0;
> > >  	}
> > > @@ -233,6 +238,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> > >  	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI0) {
> > >  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> > >  		value = DPI0_SEL_IN_RDMA2;
> > > +	} else if (cur == DDP_COMPONENT_RDMA2 && next == DDP_COMPONENT_DPI1) {
> > > +		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> > > +		value = DPI1_SEL_IN_RDMA2;
> > >  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
> > >  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
> > >  		value = COLOR1_SEL_IN_OVL1;
> > 
> > 
> 
> 


