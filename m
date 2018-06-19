Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038C4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81192075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81192075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756409AbeFSIY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:24:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32630 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755674AbeFSIYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:24:20 -0400
X-UUID: 013f70cd72c54f2fbde7d61b7a9c876d-20180619
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 260783135; Tue, 19 Jun 2018 16:24:17 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Tue, 19 Jun 2018 16:24:16 +0800
Received: from [172.21.77.4] (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Tue, 19 Jun 2018 16:24:16 +0800
Message-ID: <1529396655.26480.9.camel@mtksdaap41>
Subject: Re: [PATCH v6 13/29] drm/mediatek: add connection from RDMA0 to DPI0
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
Date:   Tue, 19 Jun 2018 16:24:15 +0800
In-Reply-To: <1529393670-26862-14-git-send-email-stu.hsieh@mediatek.com>
References: <1529393670-26862-1-git-send-email-stu.hsieh@mediatek.com>
         <1529393670-26862-14-git-send-email-stu.hsieh@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-06-19 at 15:34 +0800, Stu Hsieh wrote:
> This patch add the connection from RDMA0 to DPI0
> 

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> Signed-off-by: Stu Hsieh <stu.hsieh@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> index 977df8facb79..3a3f37f523f2 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.c
> @@ -29,6 +29,7 @@
>  #define DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x084
>  #define DISP_REG_CONFIG_DISP_COLOR1_SEL_IN	0x088
>  #define DISP_REG_CONFIG_DPI_SEL_IN		0x0ac
> +#define DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN	0x0c4
>  #define DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN	0x0c8
>  #define DISP_REG_CONFIG_MMSYS_CG_CON0		0x100
>  
> @@ -80,6 +81,7 @@
>  #define COLOR0_SEL_IN_OVL0		0x1
>  #define OVL1_MOUT_EN_COLOR1		0x1
>  #define GAMMA_MOUT_EN_RDMA1		0x1
> +#define RDMA0_SOUT_DPI0			0x2
>  #define RDMA1_SOUT_DPI0			0x2
>  #define DPI0_SEL_IN_RDMA1		0x1
>  #define COLOR1_SEL_IN_OVL1		0x1
> @@ -155,6 +157,9 @@ static unsigned int mtk_ddp_mout_en(enum mtk_ddp_comp_id cur,
>  	} else if (cur == DDP_COMPONENT_OD1 && next == DDP_COMPONENT_RDMA1) {
>  		*addr = DISP_REG_CONFIG_DISP_OD_MOUT_EN;
>  		value = OD1_MOUT_EN_RDMA1;
> +	} else if (cur == DDP_COMPONENT_RDMA0 && next == DDP_COMPONENT_DPI0) {
> +		*addr = DISP_REG_CONFIG_DISP_RDMA0_SOUT_EN;
> +		value = RDMA0_SOUT_DPI0;
>  	} else if (cur == DDP_COMPONENT_RDMA1 && next == DDP_COMPONENT_DPI0) {
>  		*addr = DISP_REG_CONFIG_DISP_RDMA1_SOUT_EN;
>  		value = RDMA1_SOUT_DPI0;


