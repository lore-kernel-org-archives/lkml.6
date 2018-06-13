Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90A8CC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507402086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 08:06:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 507402086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeFMIGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 04:06:05 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:27103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754472AbeFMIGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 04:06:01 -0400
X-UUID: d1892caf26694712963d84253744c681-20180613
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1471039441; Wed, 13 Jun 2018 16:05:56 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 16:05:55 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 16:05:55 +0800
Message-ID: <1528877155.11190.36.camel@mtksdccf07>
Subject: Re: [PATCH 26/28] drm/mediatek: add DPI1/DSI1/DSI2/DSI3 in comp_init
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
Date:   Wed, 13 Jun 2018 16:05:55 +0800
In-Reply-To: <1528875305.30263.14.camel@mtksdaap41>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-27-git-send-email-stu.hsieh@mediatek.com>
         <1528875305.30263.14.camel@mtksdaap41>
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

On Wed, 2018-06-13 at 15:35 +0800, CK Hu wrote:
> Hi, Stu:
> 
> On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> > This patch add components DPI1/DSI1/DSI2/DSI3 in comp_init.
> > Because the some parameter for these components initialized
> > in their driver.
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > index 22f4c72fa785..ff974d82a4a6 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> > @@ -278,7 +278,11 @@ int mtk_ddp_comp_init(struct device *dev, struct device_node *node,
> >  
> >  	if (comp_id == DDP_COMPONENT_BLS ||
> >  	    comp_id == DDP_COMPONENT_DPI0 ||
> > +	    comp_id == DDP_COMPONENT_DPI1 ||
> 
> Why not move this modification to the patch 'add component DPI1'?
> 
> >  	    comp_id == DDP_COMPONENT_DSI0 ||
> > +	    comp_id == DDP_COMPONENT_DSI1 ||
> > +	    comp_id == DDP_COMPONENT_DSI2 ||
> 
> Why not move this modification to the patch 'add component DSI2'?
> 
> > +	    comp_id == DDP_COMPONENT_DSI3 ||
> 
> Why not move this modification to the patch 'add component DSI3'?
> 
> Regards,
> CK
> 
ok

Regard,
Stu
> >  	    comp_id == DDP_COMPONENT_PWM0) {
> >  		comp->regs = NULL;
> >  		comp->clk = NULL;
> 
> 


