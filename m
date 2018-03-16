Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753159AbeCPIZ2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 04:25:28 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37500 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752585AbeCPIZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 04:25:26 -0400
X-Google-Smtp-Source: AG47ELuamwyOHUTGbW0e3aPwXNRypI2z1UkY+wcj393yfissp2Eth3cVx2r+rNGJzj8U7GYlOtnUSyhb6Do+uAUnLsg=
MIME-Version: 1.0
In-Reply-To: <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
References: <20180315153730.3798004-1-arnd@arndb.de> <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 16 Mar 2018 09:25:25 +0100
X-Google-Sender-Auth: D0gphjRntRw8cwGM1dxlC_AiLqY
Message-ID: <CAK8P3a0kEqZ265bG+S7JWgR47A_H2QjAT_+v+AKrFab+wN6AQg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around
 during build
To: Frank.Rowand@sony.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, niklas.soderlund+renesas@ragnatech.se,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 2:39 AM,  <Frank.Rowand@sony.com> wrote:
> On Thursday, March 15, 2018 8:37 AM, Arnd Bergmann [mailto:arnd@arndb.de]  wrote:
>>
>> The *.dtb and *.dtb.S files get removed by 'make' during the build
>> process,
>> and later seem to be missed during the 'modpost' stage:
>>
>> rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
>> WARNING: could not open
>> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or
>> directory
>>
>> As a workaround, this adds all those files to the 'extra-y' target list,
>> but that's really ugly. Any ideas for a better fix?
>
> Does this work for you (untested, but the way it is done in
> drivers/of/unittest-data/Makefile):
>
> .PRECIOUS: \
>         $(obj)/%.dtb.S \
>         $(obj)/%.dtb

Yes, that works and looks much better than my version.

      Arnd
