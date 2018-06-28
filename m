Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926E4C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C56E25410
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C56E25410
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeF1Dpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:45:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:24662 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750942AbeF1Dpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:45:49 -0400
X-UUID: 0174346147e54195adde20ddeff9981e-20180628
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 734708562; Thu, 28 Jun 2018 11:45:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 28 Jun 2018 11:45:38 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 28 Jun 2018 11:45:37 +0800
Message-ID: <1530157537.11190.53.camel@mtksdccf07>
Subject: Re: [PATCH v7 00/29] Add support for mediatek SOC MT2712
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     Daniel Vetter <daniel@ffwll.ch>
CC:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 28 Jun 2018 11:45:37 +0800
In-Reply-To: <20180625084740.GN2958@phenom.ffwll.local>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
         <20180625084740.GN2958@phenom.ffwll.local>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Daniel Vetter:

On Mon, 2018-06-25 at 10:47 +0200, Daniel Vetter wrote:
> On Wed, Jun 20, 2018 at 04:19:02PM +0800, Stu Hsieh wrote:
> > This patch add support for the Mediatek MT2712 DISP subsystem.
> > MT2712 is base on MT8173, there are some difference as following:
> > MT2712 support three disp output(two ovl and one rdma)
> > 
> > Change in v6:
> > - Update commit message for the patch
> >   "drm/mediatek: Update the definition of connection from RDMA1 to DPI0"
> 
> Just a drive-by comment on the mediatek driver:
> 
> As far as I can see mtk_drm_gem.c reimplements the cma helpers as a
> copypaste job. Any reasons why you're not using the normal cma helpers?
> 
> Thanks, Daniel
> > 

In the beginning, we develop mtk_drm_gem.c by referring other platform.
We will try to use the normal cma helpers according to your idea.

Thanks,
Stu

> > Stu Hsieh (29):
> >   drm/mediatek: update dt-bindings for mt2712
> >   drm/mediatek: support maximum 64 mutex mod
> >   drm/mediatek: add ddp component AAL1
> >   drm/mediatek: add ddp component OD1
> >   drm/mediatek: add ddp component PWM1
> >   drm/mediatek: add ddp component PWM2
> >   drm/mediatek: add component DPI1
> >   drm/mediatek: add component DSI2
> >   drm/mediatek: add component DSI3
> >   drm/mediatek: add the DSI1 for component init condition
> >   drm/mediatek: add connection from OD1 to RDMA1
> >   drm/mediatek: Update the definition of connection from RDMA1 to DPI0
> >   drm/mediatek: add connection from RDMA0 to DPI0
> >   drm/mediatek: add connection from RDMA0 to DSI2
> >   drm/mediatek: add connection from RDMA0 to DSI3
> >   drm/mediatek: add connection from RDMA1 to DPI1
> >   drm/mediatek: add connection from RDMA1 to DSI1
> >   drm/mediatek: add connection from RDMA1 to DSI2
> >   drm/mediatek: add connection from RDMA1 to DSI3
> >   drm/mediatek: add connection from RDMA2 to DPI0
> >   drm/mediatek: add connection from RDMA2 to DPI1
> >   drm/mediatek: add connection from RDMA2 to DSI1
> >   drm/mediatek: add connection from RDMA2 to DSI2
> >   drm/mediatek: add connection from RDMA2 to DSI3
> >   drm/mediatek: add DPI1 support for mutex
> >   drm/mediatek: add DSI2 support for mutex
> >   drm/mediatek: add DSI3 support for mutex
> >   drm/mediatek: add third ddp path
> >   drm/mediatek: Add support for mediatek SOC MT2712
> > 
> >  .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 235 ++++++++++++++++++---
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
> >  7 files changed, 274 insertions(+), 43 deletions(-)
> > 
> > -- 
> > 2.12.5
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 


