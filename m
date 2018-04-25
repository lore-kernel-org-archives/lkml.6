Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbeDYNoj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 09:44:39 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:39714 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754291AbeDYNoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 09:44:38 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm: rcar-du: Use drm_dev_put
Date: Wed, 25 Apr 2018 16:44:53 +0300
Message-ID: <16063366.hqKB8js4d5@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAK-LDbKJ5CF7x-Ott68c7uf-sWW9v8+C9C-F6df7Zu9ZVXBU0w@mail.gmail.com>
References: <20180425121036.28965-1-vthakkar1994@gmail.com> <5811471.PjpYk9OX8O@avalon> <CAK-LDbKJ5CF7x-Ott68c7uf-sWW9v8+C9C-F6df7Zu9ZVXBU0w@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vaishali,

On Wednesday, 25 April 2018 16:42:59 EEST Vaishali Thakkar wrote:
> On Wed, Apr 25, 2018 at 7:02 PM, Laurent Pinchart wrote:
> > On Wednesday, 25 April 2018 15:10:36 EEST Vaishali Thakkar wrote:
> >> As specified in drm_drv.c, drm_dev_unref is a compatibility alias
> >> for drm_dev_put and shouldn't be used in new code. So, use
> >> drm_dev_put instead.
> > 
> > This looks good to me. However, how about taking it one step further and
> > mass- patching all drivers to use drm_dev_put() ? We could then remove
> > drm_dev_unref() completely.
> 
> Sure thing! Do you want me to fold this patch in that patchset or will you
> be fine with applying this separately?

I don't think we should split the change in one patch per driver, so if you 
send a single patch (to be applied through drm-misc) I think it would make 
sense to fold this change in.

> >> Signed-off-by: Vaishali Thakkar <vthakkar1994@gmail.com>
> >> ---
> >> 
> >>  drivers/gpu/drm/rcar-du/rcar_du_drv.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> b/drivers/gpu/drm/rcar-du/rcar_du_drv.c index 05745e86d73e..418a80e6b2f4
> >> 100644
> >> --- a/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> +++ b/drivers/gpu/drm/rcar-du/rcar_du_drv.c
> >> @@ -378,7 +378,7 @@ static int rcar_du_remove(struct platform_device
> >> *pdev)
> >>       drm_kms_helper_poll_fini(ddev);
> >>       drm_mode_config_cleanup(ddev);
> >> 
> >> -     drm_dev_unref(ddev);
> >> +     drm_dev_put(ddev);
> >>       return 0;
> >>  }

-- 
Regards,

Laurent Pinchart
