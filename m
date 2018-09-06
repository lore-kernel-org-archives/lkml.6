Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86F9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BB8020659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 03:38:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BB8020659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbeIFILT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 04:11:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:21758 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725804AbeIFILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 04:11:19 -0400
X-UUID: bb9e5cfd72b949e896a549b6a8e8becf-20180906
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <ck.hu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1098826564; Thu, 06 Sep 2018 11:37:54 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Thu, 6 Sep 2018 11:37:42 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Thu, 6 Sep 2018 11:37:43 +0800
Message-ID: <1536205062.4618.23.camel@mtksdaap41>
Subject: Re: [PATCH v2 09/13] drm/mediatek: add support for SPDIF audio in
 HDMI
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
Date:   Thu, 6 Sep 2018 11:37:42 +0800
In-Reply-To: <20180905083146.14727-10-bibby.hsieh@mediatek.com>
References: <20180905083146.14727-1-bibby.hsieh@mediatek.com>
         <20180905083146.14727-10-bibby.hsieh@mediatek.com>
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
> From: chunhui dai <chunhui.dai@mediatek.com>
> 
> add support for SPDIF audio  in HDMI
> 
> Signed-off-by: chunhui dai <chunhui.dai@mediatek.com>

Reviewed-by: CK Hu <ck.hu@mediatek.com>

> ---
>  drivers/gpu/drm/mediatek/mtk_hdmi.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> index 2cb33098ec1a..cd8aaeebb436 100644
> --- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
> @@ -1594,6 +1594,11 @@ static int mtk_hdmi_audio_hw_params(struct device *dev, void *data,
>  		hdmi_params.aud_i2s_fmt = HDMI_I2S_MODE_I2S_24BIT;
>  		hdmi_params.aud_mclk = HDMI_AUD_MCLK_128FS;
>  		break;
> +	case HDMI_SPDIF:
> +		hdmi_params.aud_codec = HDMI_AUDIO_CODING_TYPE_PCM;
> +		hdmi_params.aud_sampe_size = HDMI_AUDIO_SAMPLE_SIZE_16;
> +		hdmi_params.aud_input_type = HDMI_AUD_INPUT_SPDIF;
> +		break;
>  	default:
>  		dev_err(hdmi->dev, "%s: Invalid DAI format %d\n", __func__,
>  			daifmt->fmt);


