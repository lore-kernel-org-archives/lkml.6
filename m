Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BC2C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1566B21707
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 05:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1566B21707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeHCGzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 02:55:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:36653 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726627AbeHCGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 02:55:14 -0400
X-UUID: 50001a32507f4c979c5a5507cc6f5d09-20180803
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 725614619; Fri, 03 Aug 2018 13:00:40 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Fri, 3 Aug 2018 13:00:38 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Fri, 3 Aug 2018 13:00:38 +0800
Message-ID: <1533272438.31144.2.camel@mtksdaap41>
Subject: Re: [PATCH v2 03/15] drm/mediatek: add connection from RDMA1 to DSI0
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Fri, 3 Aug 2018 13:00:38 +0800
In-Reply-To: <1533265868-28110-4-git-send-email-stu.hsieh@mediatek.com>
References: <1533265868-28110-1-git-send-email-stu.hsieh@mediatek.com>
         <1533265868-28110-4-git-send-email-stu.hsieh@mediatek.com>
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

On Fri, 2018-08-03 at 11:10 +0800, Stu Hsieh wrote:
> This patch add connection from RDMA1 to DSI0
> 
> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 310d8482d5a0..31189fad8d4e 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -124,6 +124,7 @@
>  #define DPI0_SEL_IN_RDMA2		0x3
>  #define DPI1_SEL_IN_RDMA1		(0x1 << 8)
>  #define DPI1_SEL_IN_RDMA2		(0x3 << 8)
> +#define DSI0_SEL_IN_RDMA1		0x1
>  #define DSI1_SEL_IN_RDMA1		0x1
>  #define DSI1_SEL_IN_RDMA2		0x4
>  #define DSI2_SEL_IN_RDMA1		(0x1 << 16)
> @@ -290,6 +291,9 @@ static unsigned int mtk_ddp_sel_in(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI1) {
>  		*addr = DISP_REG_CONFIG_DPI_SEL_IN;
>  		value = DPI1_SEL_IN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI0) {
> +		*addr = DISP_REG_CONFIG_DSIE_SEL_IN;
> +		value = DSI0_SEL_IN_RDMA1;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DSI1) {
>  		*addr = DISP_REG_CONFIG_DSIO_SEL_IN;
>  		value = DSI1_SEL_IN_RDMA1;


