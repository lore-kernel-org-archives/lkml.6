Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753488AbeCTNOh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 09:14:37 -0400
Received: from galahad.ideasonboard.com ([185.26.127.97]:33938 "EHLO
        galahad.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753019AbeCTNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 09:14:32 -0400
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Frank.Rowand@sony.com, David Airlie <airlied@linux.ie>,
        niklas.soderlund+renesas@ragnatech.se,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around during build
Date: Tue, 20 Mar 2018 15:15:37 +0200
Message-ID: <8748007.hiNNEuVPPY@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <CAK8P3a0kEqZ265bG+S7JWgR47A_H2QjAT_+v+AKrFab+wN6AQg@mail.gmail.com>
References: <20180315153730.3798004-1-arnd@arndb.de> <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com> <CAK8P3a0kEqZ265bG+S7JWgR47A_H2QjAT_+v+AKrFab+wN6AQg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Friday, 16 March 2018 10:25:25 EET Arnd Bergmann wrote:
> On Fri, Mar 16, 2018 at 2:39 AM,  <Frank.Rowand@sony.com> wrote:
> > On Thursday, March 15, 2018 8:37 AM, Arnd Bergmann wrote:
> >> The *.dtb and *.dtb.S files get removed by 'make' during the build
> >> process,
> >> and later seem to be missed during the 'modpost' stage:
> >> 
> >> rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
> >> WARNING: could not open
> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or
> >> directory
> >> 
> >> As a workaround, this adds all those files to the 'extra-y' target list,
> >> but that's really ugly. Any ideas for a better fix?
> > 
> > Does this work for you (untested, but the way it is done in
> > drivers/of/unittest-data/Makefile):
> > 
> > .PRECIOUS: \
> > 
> >         $(obj)/%.dtb.S \
> >         $(obj)/%.dtb
> 
> Yes, that works and looks much better than my version.

Thank you for your patch, and sorry for breaking the build. Do you plan to 
submit a new version based on Frank's approach ?

-- 
Regards,

Laurent Pinchart
