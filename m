Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752994AbeD3M1R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 08:27:17 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:51038 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752255AbeD3M1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 08:27:16 -0400
X-Google-Smtp-Source: AB8JxZqlgKpzadGBGDZs/5qtd26IR288QdlE/YuaamEEXzf0Hn+51ZDntG9B5YIszpVK7IINWcM10Q==
Date: Mon, 30 Apr 2018 13:27:12 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Meghana Madhyastha <meghana.madhyastha@gmail.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 1/6] backlight: Nuke unused backlight.props.state states
Message-ID: <20180430122712.GG5147@dell>
References: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180425174253.4616-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Daniel Vetter wrote:

> The backlight power state handling is supremely confusing. We have:
> - props.power, using FB_BLANK_* defines
> - props.fb_blank, using the same, but deprecated int favour of
>   props.state
> - props.state, using the BL_CORE_* defines
> - and finally a bunch of backlight drivers treat brightness == 0 as
>   off. But of course not all of them.
> 
> This is way too much confusion to fix in a simple patch, but at least
> prevent more hilarity from spreading by removing the unused BL_CORE_*
> defines. I have no idea why exactly anyone would need that.
> 
> Wrt the ideal state, we really just want a boolean state. The 4 power
> saving states that the fbdev subsystem uses are overkill in todays hw
> (this was only relevant for VGA and similar analog circuits like
> TV-out), the new drm atomic modeset api simplified even the uapi to a
> simple bool. And there was never a valid technical reason to have the
> intermediate fbdev power states for backlights (those really only can
> be either off or on).
> 
> Cleanup motivated by Meghana's questions about all this.

All applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
