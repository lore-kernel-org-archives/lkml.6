Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400FAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB56C2075E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 06:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB56C2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIDLEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:04:07 -0400
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:41175 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727321AbeIDLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:04:06 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud9.xs4all.net with ESMTPA
        id x50efMVMCnJnWx50hf0WwM; Tue, 04 Sep 2018 08:40:24 +0200
Subject: Re: [PATCH v2] media: vimc: implement basic v4l2-ctrls
To:     Guilherme Gallo <gagallo7@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     lkcamp@lists.libreplanetbr.org
References: <20180904014559.15765-1-gagallo7@gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <529ce419-bba7-7e90-cb7d-e9a94fe64ac2@xs4all.nl>
Date:   Tue, 4 Sep 2018 08:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180904014559.15765-1-gagallo7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKdcstj5XslJjgtPgHw5mIW1PVBwG9/Ml7sj2C11L8I3jrrh8AobqDigwKW1I5OHT8/V1ogp4VoPk7vss5LeWTNxic4Yg0OFXx8ZWI8xi+549Lcfe197
 j0mysxSMJ1T8YuDmxHRxm+QggtEvtMtuV65+SAEK+wl60rlsoxgURTV1UVfOnHg2Vpxmp4ahps1nQWMswsSRaPvslYDeDBjdqvYtnJCEJ5ic79DX55Gk2P9d
 d/FF/kNJOEIFbj3farqXfbNjdhkqkuHOJb1pYMjdaYgFIpMXjffCYFuJVujmT3+d3oZfrK0rbb/MUAqXBjEhMzgB3PEY7y6uWJf95bhXdth1VxeavqFxfBya
 boY0t1tU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

On 09/04/2018 03:45 AM, Guilherme Gallo wrote:
> Add brightness, contrast, hue and saturation controls in vimc-sensor
> 
> Signed-off-by: Guilherme Alcarde Gallo <gagallo7@gmail.com>
> Signed-off-by: Guilherme Gallo <gagallo7@gmail.com>

Looks good, but you have (probably unintended) two Signed-off-by lines.
Just let me know which one I should use and I'll drop the other one.

Regards,

	Hans

> ---
>  drivers/media/platform/vimc/vimc-sensor.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/media/platform/vimc/vimc-sensor.c b/drivers/media/platform/vimc/vimc-sensor.c
> index b2b89315e7ba..edf4c85ae63d 100644
> --- a/drivers/media/platform/vimc/vimc-sensor.c
> +++ b/drivers/media/platform/vimc/vimc-sensor.c
> @@ -317,6 +317,18 @@ static int vimc_sen_s_ctrl(struct v4l2_ctrl *ctrl)
>  	case V4L2_CID_VFLIP:
>  		tpg_s_vflip(&vsen->tpg, ctrl->val);
>  		break;
> +	case V4L2_CID_BRIGHTNESS:
> +		tpg_s_brightness(&vsen->tpg, ctrl->val);
> +		break;
> +	case V4L2_CID_CONTRAST:
> +		tpg_s_contrast(&vsen->tpg, ctrl->val);
> +		break;
> +	case V4L2_CID_HUE:
> +		tpg_s_hue(&vsen->tpg, ctrl->val);
> +		break;
> +	case V4L2_CID_SATURATION:
> +		tpg_s_saturation(&vsen->tpg, ctrl->val);
> +		break;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -378,6 +390,14 @@ static int vimc_sen_comp_bind(struct device *comp, struct device *master,
>  			  V4L2_CID_VFLIP, 0, 1, 1, 0);
>  	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
>  			  V4L2_CID_HFLIP, 0, 1, 1, 0);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_BRIGHTNESS, 0, 255, 1, 128);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_CONTRAST, 0, 255, 1, 128);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_HUE, -128, 127, 1, 0);
> +	v4l2_ctrl_new_std(&vsen->hdl, &vimc_sen_ctrl_ops,
> +			  V4L2_CID_SATURATION, 0, 255, 1, 128);
>  	vsen->sd.ctrl_handler = &vsen->hdl;
>  	if (vsen->hdl.error) {
>  		ret = vsen->hdl.error;
> 

