Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeBSKm5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:42:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:5574 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752307AbeBSKm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:42:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,534,1511856000";
   d="scan'208";a="31892909"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>, airlied@linux.ie
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>, daniel.vetter@intel.com
Subject: Re: [PATCH] drm/edid: Add 6 bpc quirk for CPT panel in Asus UX303LA
In-Reply-To: <20180218085359.7817-1-kai.heng.feng@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180218085359.7817-1-kai.heng.feng@canonical.com>
Date: Mon, 19 Feb 2018 12:42:52 +0200
Message-ID: <87woz99s5v.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Feb 2018, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> Similar to commit e10aec652f31 ("drm/edid: Add 6 bpc quirk for display
> AEO model 0."), the EDID reports "DFP 1.x compliant TMDS" but it support
> 6bpc instead of 8 bpc.
>
> Hence, use 6 bpc quirk for this panel.
>
> Fixes: 196f954e2509 ("drm/i915/dp: Revert "drm/i915/dp: fall back to 18 bpp when sink capability is unknown"")

Implies

Cc: <stable@vger.kernel.org> # v4.8+

> BugLink: https://bugs.launchpad.net/bugs/1749420
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/gpu/drm/drm_edid.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ddd537914575..d9c8d718e261 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -113,6 +113,9 @@ static const struct edid_quirk {
>  	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
>  	{ "AEO", 0, EDID_QUIRK_FORCE_6BPC },
>  
> +	/* CPT panel of Asus UX303LA reports 8 bpc, but is a 6 bpc panel */
> +	{ "CPT", 0x17df, EDID_QUIRK_FORCE_6BPC },
> +
>  	/* Belinea 10 15 55 */
>  	{ "MAX", 1516, EDID_QUIRK_PREFER_LARGE_60 },
>  	{ "MAX", 0x77e, EDID_QUIRK_PREFER_LARGE_60 },

-- 
Jani Nikula, Intel Open Source Technology Center
