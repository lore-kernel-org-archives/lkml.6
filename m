Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F9EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3180620856
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 03:03:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3180620856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeGYEMa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 00:12:30 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:61574 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725820AbeGYEMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 00:12:30 -0400
X-UUID: 4f2780469e6745d7b3bd158688623b66-20180725
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1791738641; Wed, 25 Jul 2018 11:02:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 25 Jul 2018 11:02:51 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 25 Jul 2018 11:02:51 +0800
Message-ID: <1532487770.9280.17.camel@mtksdaap41>
Subject: Re: [PATCH v1 12/15] drm/mediatek: add layer number condition for
 RDMA to control plane
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 25 Jul 2018 11:02:50 +0800
In-Reply-To: <1532420235-22268-13-git-send-email-stu.hsieh@mediatek.com>
References: <1532420235-22268-1-git-send-email-stu.hsieh@mediatek.com>
         <1532420235-22268-13-git-send-email-stu.hsieh@mediatek.com>
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

On Tue, 2018-07-24 at 16:17 +0800, Stu Hsieh wrote:
> This patch add layer number condition for RDMA to control plane
> 
> When plane init in crtc create,
> it use the number of OVL layer to init plane.
> That's OVL can read 4 memory address.
> 
> For mt2712 third ddp, it use RDMA to read memory.
> RDMA can read 1 memory address, so it just init one plane.
> 
> For compatibility, this patch use two define OVL_LAYER_NR and
> RDMA_LAYER_NR to distingush two difference HW engine.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 25 +++++++++++++++++--------
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h |  2 ++
>  2 files changed, 19 insertions(+), 8 deletions(-)
> 

[...]

> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> index 9d9410c67ae9..b44fefadf14a 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.h
> @@ -18,7 +18,9 @@
>  #include "mtk_drm_ddp_comp.h"
>  #include "mtk_drm_plane.h"
>  
> +#define MAX_LAYER_NR	4
>  #define OVL_LAYER_NR	4
> +#define RDMA_LAYER_NR	1
>  #define MTK_LUT_SIZE	512
>  #define MTK_MAX_BPC	10
>  #define MTK_MIN_BPC	3

If the layer number is not fixed in '4', I would like to get this value
from component because in some SoC, OVL may have 6 layer. So add an
interface to get the max layer number and OVL, RDMA driver would return
the number for this SoC.

Regards,
CK


