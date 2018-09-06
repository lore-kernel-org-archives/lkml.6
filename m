Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046EC433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 104BA20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 05:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104BA20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbeIFKQs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 06:16:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10075 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725850AbeIFKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 06:16:48 -0400
X-UUID: c1f8d17001f74248bca06340fcb2de40-20180906
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 989774673; Thu, 06 Sep 2018 13:42:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 13:42:55 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 13:42:55 +0800
Message-ID: <1536212574.4618.37.camel@mtksdaap41>
Subject: Re: [PATCH v2 11/13] drm/mediatek: implement connection from BLS to
 DPI0
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
        "Sascha Hauer" <kernel@pengutronix.de>
Date:   Thu, 6 Sep 2018 13:42:54 +0800
In-Reply-To: <20180905083146.14727-12-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-12-bibby.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bibby:

On Wed, 2018-09-05 at 16:31 +0800, Bibby Hsieh wrote:
> Modify display driver to support connection from BLS to DPI.
> 
> Signed-off-by: Bibby Hsieh <bibby.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 87e4191c250e..cc8d49e60c7e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -39,6 +39,7 @@
>  #define DISP_REG_CONFIG_DISP_OVL_MOUT_EN	0x030
>  #define DISP_REG_CONFIG_OUT_SEL			0x04c
>  #define DISP_REG_CONFIG_DSI_SEL			0x050
> +#define DISP_REG_CONFIG_DPI_SEL			0x064
>  
>  #define DISP_REG_MUTEX_EN(n)	(0x20 + 0x20 * (n))
>  #define DISP_REG_MUTEX(n)	(0x24 + 0x20 * (n))
> @@ -132,7 +133,11 @@
>  
>  #define OVL_MOUT_EN_RDMA		0x1
>  #define BLS_TO_DSI_RDMA1_TO_DPI1	0x8
> +#define BLS_TO_DPI_RDMA1_TO_DSI		0x2
>  #define DSI_SEL_IN_BLS			0x0
> +#define DPI_SEL_IN_BLS			0x0
> +#define DSI_SEL_IN_RDMA			0x1
> +#define DPI_SEL_IN_RDMA			0x1
>  
>  struct mtk_disp_mutex {
>  	int id;
> @@ -323,9 +328,21 @@ static void mtk_ddp_sout_sel(void __iomem *config_regs,
>  			     enum mtk_ddp_comp_id cur,
>  			     enum mtk_ddp_comp_id next)
>  {
> -	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0)
> +	if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DSI0) {
>  		writel_relaxed(BLS_TO_DSI_RDMA1_TO_DPI1,
>  			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> +		writel_relaxed(DSI_SEL_IN_BLS,
> +			       config_regs + DISP_REG_CONFIG_DSI_SEL);
> +		writel_relaxed(DPI_SEL_IN_RDMA,
> +			       config_regs + DISP_REG_CONFIG_DPI_SEL);
> +	} else if (cur == DDP_COMPONENT_BLS && next == DDP_COMPONENT_DPI0) {
> +		writel_relaxed(BLS_TO_DPI_RDMA1_TO_DSI,
> +			       config_regs + DISP_REG_CONFIG_OUT_SEL);
> +		writel_relaxed(DSI_SEL_IN_RDMA,
> +			       config_regs + DISP_REG_CONFIG_DSI_SEL);
> +		writel_relaxed(DPI_SEL_IN_BLS,
> +			       config_regs + DISP_REG_CONFIG_DPI_SEL);
> +	}
>  }
>  
>  void mtk_ddp_add_comp_to_path(void __iomem *config_regs,


