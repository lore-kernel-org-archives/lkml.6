Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14057C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9471E20834
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 03:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9471E20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbeHGF7j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 01:59:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:40975 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726958AbeHGF7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 01:59:39 -0400
X-UUID: 69a03cb5ffd24764a8c94767f05f2f2c-20180807
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 858295423; Tue, 07 Aug 2018 11:47:12 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 7 Aug 2018 11:47:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 7 Aug 2018 11:47:10 +0800
Message-ID: <1533613630.22668.10.camel@mtksdaap41>
Subject: Re: [PATCH v3 09/13] drm/mediatek: add callback function to return
 OVL layer number
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Tue, 7 Aug 2018 11:47:10 +0800
In-Reply-To: <1533556700-26525-10-git-send-email-stu.hsieh@mediatek.com>
References: <1533556700-26525-1-git-send-email-stu.hsieh@mediatek.com>
         <1533556700-26525-10-git-send-email-stu.hsieh@mediatek.com>
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

On Mon, 2018-08-06 at 19:58 +0800, Stu Hsieh wrote:
> This patch add callback function to return OVL layer number
> 
> For now, MT8173, MT2712, MT2701 OVL all has 4 layer.
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

I would like to remove the term 'callback' because this is just function
pointer rather than callback function. OVL does not register callback
function to crtc and crtc call OVL function directly. The modification
is good to me, so

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> index 978782a77629..66060e79afbc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
> @@ -132,6 +132,11 @@ static void mtk_ovl_config(struct mtk_ddp_comp *comp, unsigned int w,
>  	writel(0x0, comp->regs + DISP_REG_OVL_RST);
>  }
>  
> +static unsigned int mtk_ovl_layer_nr(struct mtk_ddp_comp *comp)
> +{
> +	return 4;
> +}
> +
>  static void mtk_ovl_layer_on(struct mtk_ddp_comp *comp, unsigned int idx)
>  {
>  	unsigned int reg;
> @@ -221,6 +226,7 @@ static const struct mtk_ddp_comp_funcs mtk_disp_ovl_funcs = {
>  	.stop = mtk_ovl_stop,
>  	.enable_vblank = mtk_ovl_enable_vblank,
>  	.disable_vblank = mtk_ovl_disable_vblank,
> +	.layer_nr = mtk_ovl_layer_nr,
>  	.layer_on = mtk_ovl_layer_on,
>  	.layer_off = mtk_ovl_layer_off,
>  	.layer_config = mtk_ovl_layer_config,


