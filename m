Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752926AbeA3PJa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:09:30 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:41101 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751360AbeA3PJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:09:29 -0500
X-Google-Smtp-Source: AH8x227iOK22saqHea76Rj7fmKIzSmClFVT+HDxuVEN0PASu5cXY8bbxWZx3hYmvPM09oCjU7RCsMw==
Date: Tue, 30 Jan 2018 10:09:27 -0500
From: Sean Paul <seanpaul@chromium.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH v2] drm/edid: use true and false for boolean values
Message-ID: <20180130150927.3fm5kotyp6vqugaf@art_vandelay>
References: <20180130100528.GA7154@training>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130100528.GA7154@training>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 04:05:28AM -0600, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.

I suppose you could also fix up the other preferred assignment by adding !!
to the bitwise & operation.

It's also helpful to post the spatch in the commit message so others can
replicate your result (this case is pretty trivial, so less important).

Sean

> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Use true for boolean value in add_detailed_mode as suggested by Daniel
>    Vetter.
>  - Update subject.
> 
>  drivers/gpu/drm/drm_edid.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index ddd5379..b1cb262 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2767,7 +2767,7 @@ do_detailed_mode(struct detailed_timing *timing, void *c)
>  
>  		drm_mode_probed_add(closure->connector, newmode);
>  		closure->modes++;
> -		closure->preferred = 0;
> +		closure->preferred = false;
>  	}
>  }
>  
> @@ -2784,7 +2784,7 @@ add_detailed_modes(struct drm_connector *connector, struct edid *edid,
>  	struct detailed_mode_closure closure = {
>  		.connector = connector,
>  		.edid = edid,
> -		.preferred = 1,
> +		.preferred = true,
>  		.quirks = quirks,
>  	};
>  
> -- 
> 2.7.4
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
