Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeCXLhw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 07:37:52 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:42200 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751858AbeCXLhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 07:37:51 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BDE47603AF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH] drm/msm/dsi: use correct enum in dsi_get_cmd_fmt
To: Stefan Agner <stefan@agner.ch>, robdclark@gmail.com, airlied@linux.ie
Cc: seanpaul@chromium.org, ssusheel@codeaurora.org, robh@kernel.org,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180319212632.11260-1-stefan@agner.ch>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <46b36451-8b2c-fdb4-16b3-64a52cb80954@codeaurora.org>
Date: Sat, 24 Mar 2018 17:07:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319212632.11260-1-stefan@agner.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday 20 March 2018 02:56 AM, Stefan Agner wrote:
> The function dsi_get_cmd_fmt returns enum dsi_cmd_dst_format,
> use the correct enum value also for MIPI_DSI_FMT_RGB666/_PACKED.
> 
> This has been discovered using clang:
>    drivers/gpu/drm/msm/dsi/dsi_host.c:743:35: warning: implicit conversion
>          from enumeration type 'enum dsi_vid_dst_format' to different
>          enumeration type 'enum dsi_cmd_dst_format' [-Wenum-conversion]
>            case MIPI_DSI_FMT_RGB666:       return VID_DST_FORMAT_RGB666;
>                                            ~~~~~~ ^~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Archit

> ---
>   drivers/gpu/drm/msm/dsi/dsi_host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
> index 0f7324a686ca..d729b2b4b66d 100644
> --- a/drivers/gpu/drm/msm/dsi/dsi_host.c
> +++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
> @@ -740,7 +740,7 @@ static inline enum dsi_cmd_dst_format dsi_get_cmd_fmt(
>   	switch (mipi_fmt) {
>   	case MIPI_DSI_FMT_RGB888:	return CMD_DST_FORMAT_RGB888;
>   	case MIPI_DSI_FMT_RGB666_PACKED:
> -	case MIPI_DSI_FMT_RGB666:	return VID_DST_FORMAT_RGB666;
> +	case MIPI_DSI_FMT_RGB666:	return CMD_DST_FORMAT_RGB666;
>   	case MIPI_DSI_FMT_RGB565:	return CMD_DST_FORMAT_RGB565;
>   	default:			return CMD_DST_FORMAT_RGB888;
>   	}
> 
