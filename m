Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeDYHHo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:07:44 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51252 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751320AbeDYHHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:07:36 -0400
X-Google-Smtp-Source: AIpwx482YDT7+2sWi3rov1cUcRVTch1BPr8faLJL8hx/Mda9gQEVCGVfunxeosfFqs53zBuhQoU+Xg==
Date: Wed, 25 Apr 2018 09:07:32 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Cihangir Akturk <cakturk@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Egbert Eich <eich@suse.de>, Peter Rosin <peda@axentia.se>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/ast: fix mode_valid's return type
Message-ID: <20180425070732.GJ25142@phenom.ffwll.local>
Mail-Followup-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Airlie <airlied@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Cihangir Akturk <cakturk@gmail.com>, Takashi Iwai <tiwai@suse.de>,
        Egbert Eich <eich@suse.de>, Peter Rosin <peda@axentia.se>,
        dri-devel@lists.freedesktop.org
References: <20180424131443.1810-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131443.1810-1-luc.vanoostenryck@gmail.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 03:14:40PM +0200, Luc Van Oostenryck wrote:
> The method struct drm_connector_helper_funcs::mode_valid is defined
> as returning an 'enum drm_mode_status' but the driver implementation
> for this method uses an 'int' for it.
> 
> Fix this by using 'enum drm_mode_status' in the driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Applied to drm-misc-next, thanks.
-Daniel
> ---
>  drivers/gpu/drm/ast/ast_mode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ast/ast_mode.c b/drivers/gpu/drm/ast/ast_mode.c
> index 831b73392..036dff8a1 100644
> --- a/drivers/gpu/drm/ast/ast_mode.c
> +++ b/drivers/gpu/drm/ast/ast_mode.c
> @@ -799,7 +799,7 @@ static int ast_get_modes(struct drm_connector *connector)
>  	return 0;
>  }
>  
> -static int ast_mode_valid(struct drm_connector *connector,
> +static enum drm_mode_status ast_mode_valid(struct drm_connector *connector,
>  			  struct drm_display_mode *mode)
>  {
>  	struct ast_private *ast = connector->dev->dev_private;
> -- 
> 2.17.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
