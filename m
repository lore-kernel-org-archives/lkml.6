Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85566C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4092921531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 09:47:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4092921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389901AbeIUPfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 11:35:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:56625 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389561AbeIUPfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 11:35:50 -0400
X-UUID: 1dd9c9f1bd47468bad98d77e75e3c936-20180921
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 960274248; Fri, 21 Sep 2018 17:47:37 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 21 Sep 2018 17:47:34 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 21 Sep 2018 17:47:34 +0800
Message-ID: <1537523254.20660.9.camel@mtksdaap41>
Subject: Re: [PATCH v3 05/12] drm/mediatek: convert dpi driver to use
 drm_of_find_panel_or_bridge
From:   CK Hu <ck.hu@mediatek.com>
To:     Bibby Hsieh <bibby.hsieh@mediatek.com>
CC:     David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        Cawa Cheng <cawa.cheng@mediatek.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        YT Shen <yt.shen@mediatek.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Mao Huang <littlecvr@chromium.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Sascha Hauer" <kernel@pengutronix.de>,
        chunhui dai <chunhui.dai@mediatek.com>
Date:   Fri, 21 Sep 2018 17:47:34 +0800
In-Reply-To: <20180921032822.30771-6-bibby.hsieh@mediatek.com>
References: <20180921032822.30771-1-bibby.hsieh@mediatek.com>
         <20180921032822.30771-6-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 967759F6189D651CC4D543760CDD515C112CB9E2E49E741EEB3A2A02F60CD2672000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Fri, 2018-09-21 at 11:28 +0800, Bibby Hsieh wrote:
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> Convert dpi driver to use drm_of_find_panel_or_bridge.
> This changes some error messages to debug messages (in the graph core).
> Graph connections are often "no connects" depending on the particular
> board, so we want to avoid spurious messages. Plus the kernel is not a
> DT validator.
> related links:
> [1] https://lkml.org/lkml/2017/2/3/716
> [2] https://lkml.org/lkml/2017/2/3/719
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 022ccec49cea..7a4868a0afec 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dpi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
> @@ -14,6 +14,7 @@
>  #include <drm/drmP.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_of.h>
>  #include <linux/kernel.h>
>  #include <linux/component.h>
>  #include <linux/platform_device.h>
> @@ -697,7 +698,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_dpi *dpi;
>  	struct resource *mem;
> -	struct device_node *bridge_node;
>  	int comp_id;
>  	int ret;
>  
> @@ -743,16 +743,14 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> -	if (!bridge_node)
> -		return -ENODEV;
> -
> -	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
> -
> -	dpi->bridge = of_drm_find_bridge(bridge_node);
> -	of_node_put(bridge_node);
> -	if (!dpi->bridge)
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> +					  NULL, &dpi->bridge);
> +	if (ret) {
> +		dev_err(dev, "Failed to find panel or bridge: %d\n", ret);
>  		return -EPROBE_DEFER;

I've traced into drm_of_find_panel_or_bridge(), it may return -ENODEV
when device tree has error, why do you treat this error to
-EPROBE_DEFER? I think you may modify this as

if (ret)
	return ret;

Regards,
CK

> +	}
> +
> +	dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge->of_node);
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
>  	if (comp_id < 0) {


