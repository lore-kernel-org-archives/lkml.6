Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7/J0NcQ+GltvQgAAmS7hNA
	; Fri, 08 Jun 2018 08:31:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66106607E4; Fri,  8 Jun 2018 08:31:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D1D1B601C3;
	Fri,  8 Jun 2018 08:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D1D1B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752820AbeFHIbf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:31:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58133 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751224AbeFHIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:31:30 -0400
X-UUID: 3b62db36091e49c2a09661c66d6c5643-20180608
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 466482789; Fri, 08 Jun 2018 16:31:27 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 8 Jun 2018 16:31:25 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 8 Jun 2018 16:31:24 +0800
Message-ID: <1528446684.11190.22.camel@mtksdccf07>
Subject: Re: [PATCH v4 8/9] drm/mediatek: add third ddp path
From: Stu Hsieh <stu.hsieh@mediatek.com>
To: CK Hu <ck.hu@mediatek.com>
CC: Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <srv_heupstream@mediatek.com>
Date: Fri, 8 Jun 2018 16:31:24 +0800
In-Reply-To: <1527493677.24367.10.camel@mtksdaap41>
References: <1527489507-24453-1-git-send-email-stu.hsieh@mediatek.com>
         <1527489507-24453-9-git-send-email-stu.hsieh@mediatek.com>
         <1527493677.24367.10.camel@mtksdaap41>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-05-28 at 15:47 +0800, CK Hu wrote:
> Hi, Stu:
> 
> One inline comment.
> 
> On Mon, 2018-05-28 at 14:38 +0800, Stu Hsieh wrote:
> > This patch create third crtc by third ddp path
> > 
> > Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 5 +++++
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h  | 7 +++++--
> >  3 files changed, 13 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > index 658b8dd45b83..2d6aa150a9ff 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> > @@ -539,6 +539,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
> >  	int ret;
> >  	int i;
> >  
> > +	if (!path)
> > +		return 0;
> > +
> >  	for (i = 0; i < path_len; i++) {
> >  		enum mtk_ddp_comp_id comp_id = path[i];
> >  		struct device_node *node;
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > index 08d5d0b47bfe..3d279a299383 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> > @@ -232,6 +232,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
> >  	if (ret < 0)
> >  		goto err_component_unbind;
> >  
> > +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> > +				  private->data->third_len);
> > +	if (ret < 0)
> > +		goto err_component_unbind;
> > +
> >  	/* Use OVL device for all DMA memory allocations */
> >  	np = private->comp_node[private->data->main_path[0]] ?:
> >  	     private->comp_node[private->data->ext_path[0]];
> > diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > index c3378c452c0a..d867e2683923 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> > @@ -17,8 +17,8 @@
> >  #include <linux/io.h>
> >  #include "mtk_drm_ddp_comp.h"
> >  
> > -#define MAX_CRTC	2
> > -#define MAX_CONNECTOR	2
> > +#define MAX_CRTC	3
> > +#define MAX_CONNECTOR	3
> 
> MAX_CONNECTOR is useless, maybe we just need to remove it in a clean up
> patch. Or you could keep its value.
ok
For this patch, I would keep its value.

Regards,
Stu

> 
> Regards,
> CK
> 
> >  
> >  struct device;
> >  struct device_node;
> > @@ -33,6 +33,9 @@ struct mtk_mmsys_driver_data {
> >  	unsigned int main_len;
> >  	const enum mtk_ddp_comp_id *ext_path;
> >  	unsigned int ext_len;
> > +	const enum mtk_ddp_comp_id *third_path;
> > +	unsigned int third_len;
> > +
> >  	bool shadow_register;
> >  };
> >  
> 
> 
