Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751473AbeDYHJE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:09:04 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39089 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeDYHJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:09:02 -0400
X-Google-Smtp-Source: AIpwx480yzxmNxtsN7ujNkTh9fpKvew7V2uu6jSQy/XXEJKC8e9DtiLTeYOxbUvyo7PzGUwlbwsL2A==
Date: Wed, 25 Apr 2018 09:08:58 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Robert Tarasov <tutankhamen@chromium.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/udl: fix mode_valid's return type
Message-ID: <20180425070858.GL25142@phenom.ffwll.local>
Mail-Followup-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>,
        Robert Tarasov <tutankhamen@chromium.org>,
        Keith Packard <keithp@keithp.com>, dri-devel@lists.freedesktop.org
References: <20180424131520.2409-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131520.2409-1-luc.vanoostenryck@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:15:17PM +0200, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

hisilicon, mgag200 and udl patches also merged to drm-misc-next.
-Daniel

> ---
>  drivers/gpu/drm/udl/udl_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/udl/udl_connector.c b/drivers/gpu/drm/udl/udl_connector.c
> index c3dc1fd20..09dc585aa 100644
> --- a/drivers/gpu/drm/udl/udl_connector.c
> +++ b/drivers/gpu/drm/udl/udl_connector.c
> @@ -105,7 +105,7 @@ static int udl_get_modes(struct drm_connector *connector)
>  	return 0;
>  }
>  
> -static int udl_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status udl_mode_valid(struct drm_connector *connector,
>  			  struct drm_display_mode *mode)
>  {
>  	struct udl_device *udl = connector->dev->dev_private;
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
