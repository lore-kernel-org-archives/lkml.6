Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A8EC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8093F214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 11:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8093F214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732251AbeHBNUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 09:20:15 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:29427 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731083AbeHBNUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 09:20:14 -0400
X-UUID: 17c4ff6aa2d84c0580c6e3d8ae3c330f-20180802
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <stu.hsieh@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1234062202; Thu, 02 Aug 2018 19:29:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 2 Aug 2018 19:29:22 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 2 Aug 2018 19:29:22 +0800
Message-ID: <1533209362.11190.54.camel@mtksdccf07>
Subject: Re: [PATCH v1 00/15] Add RDMA memory mode support for mediatek SOC
 MT2712
From:   Stu Hsieh <stu.hsieh@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Thu, 2 Aug 2018 19:29:22 +0800
In-Reply-To: <1532482768.9280.4.camel@mtksdaap41>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
         <1532482768.9280.4.camel@mtksdaap41>
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

On Wed, 2018-07-25 at 09:39 +0800, CK Hu wrote:
> Hi, Stu:
> 
> It looks like the series is a bug fix of [1]. In [1], you create third
> crtc but it does not work unless apply this series. So for all the
> patches in this series, you should refer to [2] to add 'Fixes:' and
> 'Cc:' in commit message.
> 
> 
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e6ab087a224fd7bcf712db698fbade673cc9addd
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=83ba62bc700bab710b22be3a1bf6cf973f754273
> 
> Regards,
> CK
> 

OK

Regards,
Stu

> On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> > This patch series add RDMA memory mode support for mediatek SOC MT2712.
> > MT2712 has three display data path, including three HW engine,
> > two OVL and one RDMA.
> > 
> > The RDMA used in third ddp and it need to be set memory mode,
> > then RDMA could read data from memory and output to panel.
> > 
> > Stu Hsieh (15):
> >   drm/mediatek: add connection from RDMA0 to DPI1
> >   drm/mediatek: add connection from RDMA0 to DSI1
> >   drm/mediatek: add connection from RDMA1 to DSI0
> >   drm/mediatek: add connection from RDMA2 to DSI0
> >   drm/mediatek: add RDMA memory mode for crtc created
> >   drm/mediatek: add memory mode for RDMA
> >   drm/mediatek: add layer config to set RDMA for plane setting
> >   drm/mediatek: add RGB color format support for RDMA
> >   drm/mediatek: add YUYV/UYVY color format support for RDMA
> >   drm/mediatek: add drm_device in RDMA for mamory mode to reaquest
> >     buffer
> >   drm/mediatek: add dummy buffer for RDMA memory mode
> >   drm/mediatek: add layer number condition for RDMA to control plane
> >   drm/mediatek: Update some variable name from ovl to comp
> >   drm/mediatek: fixed the error value for add DSI1 in mutex
> >   drm/mediatek: fixed connection from RDMA2 to DSI1
> > 
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 122 +++++++++++++++++++++++++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     |  59 +++++++++-----
> >  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |   4 +-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      |  20 ++++-
> >  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |   2 +
> >  5 files changed, 181 insertions(+), 26 deletions(-)
> > 
> 
> 


