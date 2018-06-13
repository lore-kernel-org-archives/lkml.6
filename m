Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id EBFA5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F4D20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F4D20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeFMHim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:38:42 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22051 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754452AbeFMHil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:38:41 -0400
X-UUID: 005560cd68c9436db934827c8db4b1a4-20180613
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1126950773; Wed, 13 Jun 2018 15:38:39 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 13 Jun 2018 15:38:37 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 13 Jun 2018 15:38:37 +0800
Message-ID: <1528875517.30263.15.camel@mtksdaap41>
Subject: Re: [PATCH 27/28] drm/mediatek: add third ddp path
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
Date:   Wed, 13 Jun 2018 15:38:37 +0800
In-Reply-To: <1528687580-549-28-git-send-email-stu.hsieh@mediatek.com>
References: <1528687580-549-1-git-send-email-stu.hsieh@mediatek.com>
         <1528687580-549-28-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-11 at 11:26 +0800, Stu Hsieh wrote:
> This patch create third crtc by third ddp path
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu at mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 3 +++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c  | 5 +++++
>  drivers/gpu/drm/mediatek/mtk_drm_drv.h  | 5 ++++-
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index 658b8dd45b83..2d6aa150a9ff 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -539,6 +539,9 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
>  	int ret;
>  	int i;
>  
> +	if (!path)
> +		return 0;
> +
>  	for (i = 0; i < path_len; i++) {
>  		enum mtk_ddp_comp_id comp_id = path[i];
>  		struct device_node *node;
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 08d5d0b47bfe..3d279a299383 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -232,6 +232,11 @@ static int mtk_drm_kms_init(struct drm_device *drm)
>  	if (ret < 0)
>  		goto err_component_unbind;
>  
> +	ret = mtk_drm_crtc_create(drm, private->data->third_path,
> +				  private->data->third_len);
> +	if (ret < 0)
> +		goto err_component_unbind;
> +
>  	/* Use OVL device for all DMA memory allocations */
>  	np = private->comp_node[private->data->main_path[0]] ?:
>  	     private->comp_node[private->data->ext_path[0]];
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.h b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> index c3378c452c0a..ecc00ca3221d 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.h
> @@ -17,7 +17,7 @@
>  #include <linux/io.h>
>  #include "mtk_drm_ddp_comp.h"
>  
> -#define MAX_CRTC	2
> +#define MAX_CRTC	3
>  #define MAX_CONNECTOR	2
>  
>  struct device;
> @@ -33,6 +33,9 @@ struct mtk_mmsys_driver_data {
>  	unsigned int main_len;
>  	const enum mtk_ddp_comp_id *ext_path;
>  	unsigned int ext_len;
> +	const enum mtk_ddp_comp_id *third_path;
> +	unsigned int third_len;
> +
>  	bool shadow_register;
>  };
>  


