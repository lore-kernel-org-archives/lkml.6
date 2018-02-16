Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeBPFBV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 00:01:21 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:59840 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeBPFBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 00:01:16 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0A22B60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH v5 03/12] drm/bridge/synopsys: dw-hdmi: Enable workaround
 for v1.32a
To: Jernej Skrabec <jernej.skrabec@siol.net>,
        maxime.ripard@free-electrons.com, wens@csie.org, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, narmstrong@baylibre.com,
        Jose.Abreu@synopsys.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20180214200906.31509-1-jernej.skrabec@siol.net>
 <20180214200906.31509-4-jernej.skrabec@siol.net>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <859c9f7b-8be9-d53b-e8d5-aa04e6b5ca7b@codeaurora.org>
Date: Fri, 16 Feb 2018 10:31:03 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180214200906.31509-4-jernej.skrabec@siol.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday 15 February 2018 01:38 AM, Jernej Skrabec wrote:
> Allwinner SoCs have dw hdmi controller v1.32a which exhibits same
> magenta line issue as i.MX6Q and i.MX6DL. Enable workaround for it.
> 
> Tests show that one iteration is enough.
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Archit Taneja <architt@codeaurora.org>

> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>   drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a38db40ce990..7ca14d7325b5 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1634,9 +1634,10 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>   	 * then write one of the FC registers several times.
>   	 *
>   	 * The number of iterations matters and depends on the HDMI TX revision
> -	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
> -	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
> -	 * 4 and 1 iterations respectively.
> +	 * (and possibly on the platform). So far i.MX6Q (v1.30a), i.MX6DL
> +	 * (v1.31a) and multiple Allwinner SoCs (v1.32a) have been identified
> +	 * as needing the workaround, with 4 iterations for v1.30a and 1
> +	 * iteration for others.
>   	 */
>   
>   	switch (hdmi->version) {
> @@ -1644,6 +1645,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>   		count = 4;
>   		break;
>   	case 0x131a:
> +	case 0x132a:
>   		count = 1;
>   		break;
>   	default:
> 
