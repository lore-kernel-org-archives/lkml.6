Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B859C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1061624FCD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 01:39:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1061624FCD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932838AbeGBBjW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 21:39:22 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31835 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752843AbeGBBjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 21:39:20 -0400
X-UUID: e14748dceaec43bc83aa98db0f0c58b8-20180702
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 701489952; Mon, 02 Jul 2018 09:39:13 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Mon, 2 Jul 2018 09:39:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Mon, 2 Jul 2018 09:39:10 +0800
Message-ID: <1530495550.4568.2.camel@mtksdaap41>
Subject: Re: [PATCH v7 00/29] Add support for mediatek SOC MT2712
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
Date:   Mon, 2 Jul 2018 09:39:10 +0800
In-Reply-To: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
References: <1529482771-2153-1-git-send-email-stu.hsieh@mediatek.com>
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

On Wed, 2018-06-20 at 16:19 +0800, Stu Hsieh wrote:
> This patch add support for the Mediatek MT2712 DISP subsystem.
> MT2712 is base on MT8173, there are some difference as following:
> MT2712 support three disp output(two ovl and one rdma)
> 

For the series, applied to mediatek-drm-next-4.19 [1], the patch
'drm/mediatek: Add support for mediatek SOC MT2712' has line over 80
character, so I've modified it.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-next-4.19

Regards,
CK

> Change in v6:
> - Update commit message for the patch
>   "drm/mediatek: Update the definition of connection from RDMA1 to DPI0"
> 
> Stu Hsieh (29):
>   drm/mediatek: update dt-bindings for mt2712
>   drm/mediatek: support maximum 64 mutex mod
>   drm/mediatek: add ddp component AAL1
>   drm/mediatek: add ddp component OD1
>   drm/mediatek: add ddp component PWM1
>   drm/mediatek: add ddp component PWM2
>   drm/mediatek: add component DPI1
>   drm/mediatek: add component DSI2
>   drm/mediatek: add component DSI3
>   drm/mediatek: add the DSI1 for component init condition
>   drm/mediatek: add connection from OD1 to RDMA1
>   drm/mediatek: Update the definition of connection from RDMA1 to DPI0
>   drm/mediatek: add connection from RDMA0 to DPI0
>   drm/mediatek: add connection from RDMA0 to DSI2
>   drm/mediatek: add connection from RDMA0 to DSI3
>   drm/mediatek: add connection from RDMA1 to DPI1
>   drm/mediatek: add connection from RDMA1 to DSI1
>   drm/mediatek: add connection from RDMA1 to DSI2
>   drm/mediatek: add connection from RDMA1 to DSI3
>   drm/mediatek: add connection from RDMA2 to DPI0
>   drm/mediatek: add connection from RDMA2 to DPI1
>   drm/mediatek: add connection from RDMA2 to DSI1
>   drm/mediatek: add connection from RDMA2 to DSI2
>   drm/mediatek: add connection from RDMA2 to DSI3
>   drm/mediatek: add DPI1 support for mutex
>   drm/mediatek: add DSI2 support for mutex
>   drm/mediatek: add DSI3 support for mutex
>   drm/mediatek: add third ddp path
>   drm/mediatek: Add support for mediatek SOC MT2712
> 
>  .../bindings/display/mediatek/mediatek,disp.txt    |   2 +-
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c            |   3 +
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c             | 235 ++++++++++++++++++---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c        |  15 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h        |  10 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c             |  47 ++++-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h             |   5 +-
>  7 files changed, 274 insertions(+), 43 deletions(-)
> 


