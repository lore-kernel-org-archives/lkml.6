Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93556C46464
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C62820C03
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 01:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C62820C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbeHOEpg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 00:45:36 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:2594 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725843AbeHOEpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 00:45:36 -0400
X-UUID: f943f4bb7cdf415cad5be5f64e6d4d60-20180815
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1603568645; Wed, 15 Aug 2018 09:55:31 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Wed, 15 Aug 2018 09:55:29 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Wed, 15 Aug 2018 09:55:29 +0800
Message-ID: <1534298129.29201.3.camel@mtksdaap41>
Subject: Re: [PATCH v4 00/14] Add RDMA memory mode support for mediatek SOC
 MT2712
From:   CK Hu <ck.hu@mediatek.com>
To:     Stu Hsieh <stu.hsieh@mediatek.com>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>
Date:   Wed, 15 Aug 2018 09:55:29 +0800
In-Reply-To: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
References: <1533780949-30141-1-git-send-email-stu.hsieh@mediatek.com>
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

For the series, applied to mediatek-drm-next-4.19 [1], but I modified
'drm/mediatek: add RGB color format support for RDMA' and 'drm/mediatek:
add YUYV/UYVY color format support for RDMA' because I would like to
place related register definition together.

[1]
https://github.com/ckhu-mediatek/linux.git-tags/commits/mediatek-drm-fixes-4.19

Regards,
CK

On Thu, 2018-08-09 at 10:15 +0800, Stu Hsieh wrote:
> This patch series add RDMA memory mode support for mediatek SOC MT2712.
> MT2712 has three display data path, including three HW engine,
> two OVL and one RDMA.
> 
> The RDMA used in third ddp and it need to be set memory mode,
> then RDMA could read data from memory and output to panel.
> 
> Change in v4:
> - Add the comment about naming color format definition for RDMA in patch
>   "drm/mediatek: add memory mode and layer_config for RDMA"
> - Add the comment about naming color format definition for OVL in patch
>   "drm/mediatek: add the comment about color format setting for OVL"
> - Update the naming about matrix definition and Symbolize the mask in patch
>   "drm/mediatek: add YUYV/UYVY color format support for RDMA"
> - remove the word "callback" for title in patch
>   "drm/mediatek: add function to return OVL layer number" and
>   "drm/mediatek: add function to return RDMA layer number"
> - Use single pointer to declare the planes array in patch
>   "drm/mediatek: use layer_nr function to get layer number to init plane"
> 
> Stu Hsieh (14):
>   drm/mediatek: add connection from RDMA0 to DPI1
>   drm/mediatek: add connection from RDMA0 to DSI1
>   drm/mediatek: add connection from RDMA1 to DSI0
>   drm/mediatek: add connection from RDMA2 to DSI0
>   drm/mediatek: add memory mode and layer_config for RDMA
>   drm/mediatek: add RGB color format support for RDMA
>   drm/mediatek: add the comment about color format setting for OVL
>   drm/mediatek: add YUYV/UYVY color format support for RDMA
>   drm/mediatek: add function to get layer number for component
>   drm/mediatek: add function to return OVL layer number
>   drm/mediatek: add function to return RDMA layer number
>   drm/mediatek: use layer_nr function to get layer number to init plane
>   drm/mediatek: update some variable name from ovl to comp
>   drm/mediatek: fix connection from RDMA2 to DSI1
> 
>  drivers/gpu/drm/mediatek/mtk_disp_ovl.c     | 11 ++++
>  drivers/gpu/drm/mediatek/mtk_disp_rdma.c    | 93 +++++++++++++++++++++++++++++
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c     | 47 ++++++++-------
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.h     |  3 +-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp.c      | 18 +++++-
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.h |  9 +++
>  6 files changed, 158 insertions(+), 23 deletions(-)
> 


