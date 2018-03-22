Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeCVO00 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:26:26 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:37994 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752219AbeCVO0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:26:23 -0400
X-Google-Smtp-Source: AG47ELtnL84yXHHV0JeJJ3MfOmx+i1Q4qAa5HzdXJgYAz+QVVuKYJSqI+eQrr9tyFykTpfsyNCSnI5dIZ7naE4q+cQw=
MIME-Version: 1.0
In-Reply-To: <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
References: <20180315153730.3798004-1-arnd@arndb.de> <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 22 Mar 2018 15:26:22 +0100
X-Google-Sender-Auth: OkarZJ8-KFhI5DQ3VWQvFWn_lEg
Message-ID: <CAMuHMdULWVXXSXrEBoomONQhF-Af3FGMijMnL6WL6P1XE-e7zA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around
 during build
To: Frank.Rowand@sony.com
Cc: Arnd Bergmann <arnd@arndb.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?=
        <niklas.soderlund+renesas@ragnatech.se>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

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

Shouldn't that just be moved to scripts/Makefile.lib, just above the rule
to make dtb.S, like is done for other precious objects?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
