Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAB2C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D08020878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D08020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbeJBPOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:14:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31517 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727315AbeJBPOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:14:32 -0400
X-UUID: c5e1198c2df74638b35760773867ff55-20181002
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1661430672; Tue, 02 Oct 2018 16:32:20 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 2 Oct 2018 16:32:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 2 Oct 2018 16:32:16 +0800
Message-ID: <1538469136.24335.1.camel@mtksdaap41>
Subject: Re: [PATCH v4 05/11] drm/mediatek: convert dpi driver to use
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
Date:   Tue, 2 Oct 2018 16:32:16 +0800
In-Reply-To: <20181002081041.32629-6-bibby.hsieh@mediatek.com>
References: <20181002081041.32629-1-bibby.hsieh@mediatek.com>
         <20181002081041.32629-6-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-SNTS-SMTP: 9181BCB286DB77A89D435CB9D03039355CC15C814588684C2957CB36B34D3C642000:8
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Tue, 2018-10-02 at 16:10 +0800, Bibby Hsieh wrote:
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

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dpi.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
> index 0dbe9345fa2e..08915e1765f8 100644
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
> @@ -668,7 +669,6 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct mtk_dpi *dpi;
>  	struct resource *mem;
> -	struct device_node *bridge_node;
>  	int comp_id;
>  	int ret;
>  
> @@ -714,16 +714,12 @@ static int mtk_dpi_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> -	bridge_node = of_graph_get_remote_node(dev->of_node, 0, 0);
> -	if (!bridge_node)
> -		return -ENODEV;
> -
> -	dev_info(dev, "Found bridge node: %pOF\n", bridge_node);
> +	ret = drm_of_find_panel_or_bridge(dev->of_node, 0, 0,
> +					  NULL, &dpi->bridge);
> +	if (ret)
> +		return ret;
>  
> -	dpi->bridge = of_drm_find_bridge(bridge_node);
> -	of_node_put(bridge_node);
> -	if (!dpi->bridge)
> -		return -EPROBE_DEFER;
> +	dev_info(dev, "Found bridge node: %pOF\n", dpi->bridge->of_node);
>  
>  	comp_id = mtk_ddp_comp_get_id(dev->of_node, MTK_DPI);
>  	if (comp_id < 0) {


