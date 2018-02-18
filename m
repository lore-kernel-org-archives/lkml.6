Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751355AbeBRMRa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 07:17:30 -0500
Received: from mail-wr0-f193.google.com ([209.85.128.193]:40328 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751292AbeBRMR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 07:17:28 -0500
X-Google-Smtp-Source: AH8x2261pce/wyGYTfFWm/hDTBQUQBEgIiUy1NMZ29HO33hM+PB/vHyg3cIkUx99Ey1/l4YGYoMPuw==
Subject: Re: [PATCH] drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, airlied@linux.ie
Cc: daniel.vetter@intel.com, gustavo@padovan.org, seanpaul@chromium.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20180218085359.7817-1-kai.heng.feng@canonical.com>
From: Mario Kleiner <mario.kleiner.de@gmail.com>
Message-ID: <d6a3afcb-91e5-dc91-7374-50f4864d7f2f@gmail.com>
Date: Sun, 18 Feb 2018 13:17:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180218085359.7817-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/18/2018 09:53 AM, Kai-Heng Feng wrote:
> Similar to commit e10aec652f31 ("drm/edid: Add 6 bpc quirk for display
> AEO model 0."), the EDID reports "DFP 1.x compliant TMDS" but it support
> 6bpc instead of 8 bpc.
> 
> Hence, use 6 bpc quirk for this panel.
> 
> Fixes: 196f954e2509 ("drm/i915/dp: Revert "drm/i915/dp: fall back to 18 bpp when sink capability is unknown"")
> BugLink: https://bugs.launchpad.net/bugs/1749420
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>   drivers/gpu/drm/drm_edid.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ddd537914575..d9c8d718e261 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -113,6 +113,9 @@ static const struct edid_quirk {
>   	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
>   	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
>   
> +	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
> +	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
> +
>   	/* Belinea 10 15 55 */
>   	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
>   	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },
> 

Reviewed-by: Mario Kleiner <mario.kleiner.de@gmail.com>
