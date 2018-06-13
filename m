Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DA4C5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A63D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:23:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A63D2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934634AbeFMHXF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:23:05 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41327 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S934150AbeFMHXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:23:02 -0400
X-UUID: 7bccdec80642476299011d2418d55b33-20180613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1725022314; Wed, 13 Jun 2018 15:23:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 15:22:58 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 15:22:58 +0800
Message-ID: <1528874578.30263.12.camel@mtksdaap41>
Subject: Re: [PATCH 25/28] drm/mediatek: add DSI3 support for mutex
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
Date:   Wed, 13 Jun 2018 15:22:58 +0800
In-Reply-To: <1528687580-549-26-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-26-git-send-email-stu.hsieh@mediatek.com>
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

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch add the DSI3 support for mutex
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu at mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 1e7e3872eccc..28dd8531a7de 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -78,6 +78,7 @@
>  #define MUTEX_SOF_DPI0			3
>  #define MUTEX_SOF_DPI1			4
>  #define MUTEX_SOF_DSI2			5
> +#define MUTEX_SOF_DSI3			6
>  
>  #define OVL0_MOUT_EN_COLOR0		0x1
>  #define OD_MOUT_EN_RDMA0		0x1
> @@ -387,6 +388,9 @@ void mtk_disp_mutex_add_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DSI2:
>  		reg = MUTEX_SOF_DSI2;
>  		break;
> +	case DDP_COMPONENT_DSI3:
> +		reg = MUTEX_SOF_DSI3;
> +		break;
>  	case DDP_COMPONENT_DPI0:
>  		reg = MUTEX_SOF_DPI0;
>  		break;
> @@ -425,6 +429,7 @@ void mtk_disp_mutex_remove_comp(struct mtk_disp_mutex *mutex,
>  	case DDP_COMPONENT_DSI0:
>  	case DDP_COMPONENT_DSI1:
>  	case DDP_COMPONENT_DSI2:
> +	case DDP_COMPONENT_DSI3:
>  	case DDP_COMPONENT_DPI0:
>  	case DDP_COMPONENT_DPI1:
>  		writel_relaxed(MUTEX_SOF_SINGLE_MODE,


