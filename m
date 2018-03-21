Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751604AbeCUHik (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 03:38:40 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45175 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751040AbeCUHig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 03:38:36 -0400
X-Google-Smtp-Source: AG47ELux1702kszPA5lI/+deD2wB3Fb7kkVsQ8fqMNyReB93c2aIZikP5yBP9bnZRYxxW1ocC9eLVPvMOh/OkZw79iQ=
MIME-Version: 1.0
In-Reply-To: <8748007.hiNNEuVPPY@avalon>
References: <20180315153730.3798004-1-arnd@arndb.de> <ED290C750E1B324E972B0017C9D4BAB06479C421@USCULXMSG01.am.sony.com>
 <CAK8P3a0kEqZ265bG+S7JWgR47A_H2QjAT_+v+AKrFab+wN6AQg@mail.gmail.com> <8748007.hiNNEuVPPY@avalon>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 21 Mar 2018 15:38:35 +0800
X-Google-Sender-Auth: IqpAAh7O1TfFaYO6Vf2D15CSYoU
Message-ID: <CAK8P3a2zoGCi2k8gy5QZ0Ddn1pZGMmMAWusdq7c=x_SJ9Lq3LA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] drm: rcar-du: keep temporary dtb files around
 during build
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Frank.Rowand@sony.com, David Airlie <airlied@linux.ie>,
        niklas.soderlund+renesas@ragnatech.se,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 9:15 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Arnd,
>
> On Friday, 16 March 2018 10:25:25 EET Arnd Bergmann wrote:
>> On Fri, Mar 16, 2018 at 2:39 AM,  <Frank.Rowand@sony.com> wrote:
>> > On Thursday, March 15, 2018 8:37 AM, Arnd Bergmann wrote:
>> >> The *.dtb and *.dtb.S files get removed by 'make' during the build
>> >> process,
>> >> and later seem to be missed during the 'modpost' stage:
>> >>
>> >> rm drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7791.dtb.S
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7795.dtb.S
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7796.dtb.S
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7793.dtb.S
>> >> WARNING: could not open
>> >> drivers/gpu/drm/rcar-du/rcar_du_of_lvds_r8a7790.dtb.S: No such file or
>> >> directory
>> >>
>> >> As a workaround, this adds all those files to the 'extra-y' target list,
>> >> but that's really ugly. Any ideas for a better fix?
>> >
>> > Does this work for you (untested, but the way it is done in
>> > drivers/of/unittest-data/Makefile):
>> >
>> > .PRECIOUS: \
>> >
>> >         $(obj)/%.dtb.S \
>> >         $(obj)/%.dtb
>>
>> Yes, that works and looks much better than my version.
>
> Thank you for your patch, and sorry for breaking the build. Do you plan to
> submit a new version based on Frank's approach ?

I'm currently at Linaro Connect and won't be able to send a tested patch
before mid next week. If you want it earlier, feel free to apply that patch
with my original description and 'Reported-by: Arnd Bergmann <arnd@arndb.de>'.

        Arnd
