Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751609AbeCPJ0Y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 05:26:24 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35710 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeCPJ0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 05:26:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 41CC160390
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=architt@codeaurora.org
Subject: Re: [PATCH 1/2] dt-bindings: analogix-dp: Add backlight-pwm-passthru
To: Alexandru M Stan <amstan@chromium.org>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>
Cc: devicetree@vger.kernel.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        dianders@chromium.org, linux-rockchip@lists.infradead.org,
        marcheu@chromium.org, hoegsberg@chromium.org,
        Thierry Escande <thierry.escande@collabora.com>,
        Jeffy Chen <jeffy.chen@rock-chips.com>
References: <20180316025659.217423-1-amstan@chromium.org>
 <20180316025659.217423-2-amstan@chromium.org>
From: Archit Taneja <architt@codeaurora.org>
Message-ID: <124034c6-a0af-0142-0d04-7d8bbc19bb82@codeaurora.org>
Date: Fri, 16 Mar 2018 14:56:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316025659.217423-2-amstan@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 16 March 2018 08:26 AM, Alexandru M Stan wrote:
> Documentation for the optional backlight-pwm-passthru property.
> Tells the EDP panel to folow the input pwm frequency instead

s/folow/follow

It would be nice if we could add the details you mentioned in
patch #0 in either this or the next patch.

> of generating its own.

This is one of those bindings which is more a knob than a HW property,
but I can't think of any easy way to figure this out in SW. So, I guess
it's okay to have.

One thing I was wondering about was whether this prop should belong to
the eDP controller or the eDP panel. I don't have any strong opinion
about it, though.

Reviewed-by: Archit Taneja <architt@codeaurora.org>

Thanks,
Archit


> 
> Signed-off-by: Alexandru M Stan <amstan@chromium.org>
> ---
> 
>   Documentation/devicetree/bindings/display/bridge/analogix_dp.txt | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> index 0c7473dd0e51..3c15242f6ce3 100644
> --- a/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> +++ b/Documentation/devicetree/bindings/display/bridge/analogix_dp.txt
> @@ -23,6 +23,10 @@ Required properties for dp-controller:
>   		from general PHY binding: Should be "dp".
>   
>   Optional properties for dp-controller:
> +	-backlight-pwm-passthru:
> +		Directly pass the PWM frequency applied to the BL_PWM_DIM
> +		pin to the backlight current source. Done via
> +		EDP_BACKLIGHT_MODE_SET_REGISTER on DPCD.
>   	-force-hpd:
>   		Indicate driver need force hpd when hpd detect failed, this
>   		is used for some eDP screen which don't have hpd signal.
> 
