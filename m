Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753332AbeCFJxe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:53:34 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40589 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeCFJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:53:32 -0500
X-Google-Smtp-Source: AG47ELvrVXPOgQ9LJaXn/lnXuq516VLp69p8pwO/yflXkEwUxkaxxli812Xy37YROo6L1tkNzhENMA==
Subject: Re: [PATCH] drm: bridge: dw-hdmi: Fix overflow workaround for Amlogic
 Meson GX SoCs
To: architt@codeaurora.org
Cc: airlied@linux.ie, a.hajda@samsung.com, Jose.Abreu@synopsys.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <d0ecb49f-f2bd-0a0d-fa18-c7cb178ca17a@baylibre.com>
Date: Tue, 6 Mar 2018 10:53:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519386277-25902-1-git-send-email-narmstrong@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Architt,

On 23/02/2018 12:44, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs, embedded the v2.01a controller, has been also
> identified needing this workaround.
> This patch adds the corresponding version to enable a single iteration for
> this specific version.
> 
> Fixes: be41fc55f1aa ("drm: bridge: dw-hdmi: Handle overflow workaround based on device version")
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> index a38db40..f5018f9 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> @@ -1637,6 +1637,8 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  	 * (and possibly on the platform). So far only i.MX6Q (v1.30a) and
>  	 * i.MX6DL (v1.31a) have been identified as needing the workaround, with
>  	 * 4 and 1 iterations respectively.
> +	 * The Amlogic Meson GX SoCs (v2.01a) have been identifies as needing
> +	 * the workaround with a single iteration.
>  	 */
>  
>  	switch (hdmi->version) {
> @@ -1644,6 +1646,7 @@ static void dw_hdmi_clear_overflow(struct dw_hdmi *hdmi)
>  		count = 4;
>  		break;
>  	case 0x131a:
> +	case 0x201a:
>  		count = 1;
>  		break;
>  	default:
> 

This fixes a long time issue on Amlogic SoCs, is it ok for you ?

Thanks,
Neil
