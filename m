Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757859AbeD0Lg0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:36:26 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:50318 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757817AbeD0LgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:36:23 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Simon Horman <horms+renesas@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] fbdev/drm: sh_mobile: remove unused MERAM support
Date: Fri, 27 Apr 2018 14:36:35 +0300
Message-ID: <2561366.LzYTbHeMbO@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180427112213epcas2p3ed6890af75e679b537121f2655aa91d8@epcas2p3.samsung.com> <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

On Friday, 27 April 2018 14:21:42 EEST Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patchset removes unused MERAM support (last user was removed
> 3 years ago) from shmobile fbdev & drm drivers and then removes
> MERAM driver itself.
> 
> If it is okay to merge this patches I would like patch #1 to go
> through fbdev tree and patch #2 to go through drm tree. Once they
> are both upstream (v4.18) I will apply patch #3 to fbdev tree.

Or you could merge everything through the fbdev tree in one go, the shmobile 
driver hardly sees any activity these days.

For the whole series,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Bartlomiej Zolnierkiewicz (3):
>   video: fbdev: sh_mobile_lcdcfb: remove unused MERAM support
>   drm: shmobile: remove unused MERAM support
>   video: fbdev: remove unused sh_mobile_meram driver
> 
>  drivers/gpu/drm/shmobile/Kconfig           |   1 -
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.c  |  42 --
>  drivers/gpu/drm/shmobile/shmob_drm_crtc.h  |   1 -
>  drivers/gpu/drm/shmobile/shmob_drm_drv.h   |   2 -
>  drivers/gpu/drm/shmobile/shmob_drm_kms.c   |  11 -
>  drivers/gpu/drm/shmobile/shmob_drm_kms.h   |   1 -
>  drivers/gpu/drm/shmobile/shmob_drm_plane.c |   2 -
>  drivers/video/fbdev/Kconfig                |  13 -
>  drivers/video/fbdev/Makefile               |   1 -
>  drivers/video/fbdev/sh_mobile_lcdcfb.c     |  63 +--
>  drivers/video/fbdev/sh_mobile_lcdcfb.h     |   1 -
>  drivers/video/fbdev/sh_mobile_meram.c      | 754 --------------------------
>  include/linux/platform_data/shmob_drm.h    |   4 -
>  include/video/sh_mobile_lcdc.h             |   3 -
>  include/video/sh_mobile_meram.h            |  95 ----
>  15 files changed, 1 insertion(+), 993 deletions(-)
>  delete mode 100644 drivers/video/fbdev/sh_mobile_meram.c
>  delete mode 100644 include/video/sh_mobile_meram.h

-- 
Regards,

Laurent Pinchart
