Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A44DBC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6367F208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6367F208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935007AbeFMIxj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:53:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9417 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S933732AbeFMIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:53:37 -0400
X-UUID: 871c162f13b74c738a4cb7d54c44bbca-20180613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 765725271; Wed, 13 Jun 2018 16:53:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 16:53:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 16:53:31 +0800
Message-ID: <1528880011.11190.41.camel@mtksdccf07>
Subject: Re: [PATCH 14/28] drm/mediatek: add connection from RDMA1 to DPI1
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
Date:   Wed, 13 Jun 2018 16:53:31 +0800
In-Reply-To: <1528878446.30263.30.camel@mtksdaap41>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-15-git-send-email-stu.hsieh@mediatek.com>
         <1528870410.15127.11.camel@mtksdaap41>
         <1528876574.11190.32.camel@mtksdccf07>
         <1528878446.30263.30.camel@mtksdaap41>
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

On Wed, 2018-06-13 at 16:27 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Wed, 2018-06-13 at 15:56 +0800, Stu Hsieh wrote:
> > Hi, CK:
> > 
> > On Wed, 2018-06-13 at 14:13 +0800, CK Hu wrote:
> > > Hi, Stu:
> > > 
> > > On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > > > This patch add the connection from RDMA1 to DPI1
> > > > 
> > > > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > > > ---
> > > >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 8 ++++++++
> > > >  1 file changed, 8 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > index fed1b5704355..4abd5dabeccf 100644
> > > > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> > > > @@ -85,7 +85,9 @@
> > > >  #define RDMA0_MOUT_DSI2			0x4
> > > >  #define RDMA0_MOUT_DSI3			0x5
> > > >  #define RDMA1_MOUT_DPI0			0x2
> > > > +#define RDMA1_MOUT_DPI1			0x3
> > > 
> > > Usually, each bit of a mout register represent a output enable. Is this
> > > value 0x3 a correct value?
> > > 
> > > Regards,
> > > CK
> > > 
> > In HW CONFIG SPEC show as following
> > 
> > Bit(s)	Name			Description
> > 2:0	DISP_PATH1_SOUT_SEL_IN	0 : Output to DSI0
> > 				1:  Ooutput to DSI1
> > 				2:  Ooutput to DPI
> > 				3:  Ooutput to DPI1
> > 				4:  Ooutput to DSI2
> > 				5:  Ooutput to DSI3
> > 				6 : reserved
> > 				7:  Ooutput to DISP_UFOE
> > 
> > So, 0x3 is correct value
> 
> It looks like that RDMA1 output is also SOUT, use the naming SOUT would
> be better. 
> 
> Regards,
> CK
> 
OK, I would change the definition name from
DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN to DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN

Regard,
STu

> > 
> > Regard,
> > Stu
> > 
> > 
> > > >  #define DPI0_SEL_IN_RDMA1		0x1
> > > > +#define DPI1_SEL_IN_RDMA1		(0x1 << 8)
> > > >  #define COLOR1_SEL_IN_OVL1		0x1
> > > >  
> > > >  #define OVL_MOUT_EN_RDMA		0x1
> > > > @@ -171,6 +173,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
> > > >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> > > >  		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> > > >  		value = RDMA1_MOUT_DPI0;
> > > > +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> > > > +		*addr = DISP_REG_CONFIG_DISP_RDMA1_MOUT_EN;
> > > > +		value = RDMA1_MOUT_DPI1;
> > > >  	} else {
> > > >  		value = 0;
> > > >  	}
> > > > @@ -190,6 +195,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
> > > >  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
> > > >  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> > > >  		value = DPI0_SEL_IN_RDMA1;
> > > > +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
> > > > +		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
> > > > +		value = DPI1_SEL_IN_RDMA1;
> > > >  	} else if (cur == DDP_COMPONENT_OVL1 && next == DDP_COMPONENT_COLOR1) {
> > > >  		*addr = DISP_REG_CONFIG_DISP_COLOR1_SEL_IN;
> > > >  		value = COLOR1_SEL_IN_OVL1;
> > > 
> > > 
> > 
> > 
> 
> 


