Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B037CC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 675822082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 10:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vMksWFBA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675822082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbeLKKt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 05:49:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44050 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbeLKKt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 05:49:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so6932493pfh.11
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 02:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y71fcmnIB/o2dLTOTXKfTEal8/+afznMcpckDqtgyns=;
        b=vMksWFBAHwBc0pXp1sFSLtI+ME+0QKpVbwr9Z/EOXgrSnccl4JSc9cxtq6A/srw8/5
         Ps3HYz0J/nNJhZQq7Dnr26SxHveovarI9Mi2RzuPt5f3AZ8pQdvryWvHqYb8LgLDcRoh
         9odh+q3wsBwH93Gq+hyD246dO0soOtcssK4hhziRGGxVjL3PFcGQj+qIdJFKrqLqRI5W
         NBAM3ltY1wf7Q4nYdH6QzebQ0AyEq0ie10Dy+6I3pQMRFrNlm6AgC4uMI8vBzZOn+4T0
         /FNJfDhUPj7SEOzz4GbFcVP+fWS+S+JOXwK+6XcnowLsVuC4ipaB7lmQ8o3tJU5fkl41
         x+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y71fcmnIB/o2dLTOTXKfTEal8/+afznMcpckDqtgyns=;
        b=T0Ri08VfOpBhBI9O0Ck9g89LrKphgIVB4OOLz4nW8/LIWyZkhjt0qSmwqmYWSLzfOr
         qrPDCUZao6p6vFVrh7Fg8o5uwCoiIxkodBXH1L/sAFhkjD0f67E2l4pCBxeXMaYvYVXs
         R+bIQ6XIaPW1Uc6XeqP+w45KS/h7YCVBQqqZ9fv/jKvNTjfxKblaPb9+w/U3MhMth3/F
         BI6z8U+6OPv/fvj44cUznEXC+/imGtNF0fAJRCOfZ+VGPJCDIQWgNUHPeFalwbqOQ1ZT
         pGxnehbSYblUgouypuc8tiUfwNK7r4f6chRLs7HOCCwGXJGWBb3IfrGUrmR9HWO9lTSR
         J/Bw==
X-Gm-Message-State: AA+aEWZeRsLWYrVlZJpTtswaAfih0IXf+9IruRCMkGDUB1tzUlOrG97A
        BaiPWT9DVO+ih2EKhJMDtzBxnyMIVRE9xuxO0FM=
X-Google-Smtp-Source: AFSGD/WBu92paH2SZyoTzt3yo/RqRBi7d/uR08RbDZSIoHJI0pTa68usFSltcewwV3KJZwKYehhpMWkP42mT8CX5s9U=
X-Received: by 2002:a63:4611:: with SMTP id t17mr14042870pga.119.1544525366276;
 Tue, 11 Dec 2018 02:49:26 -0800 (PST)
MIME-Version: 1.0
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com> <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
In-Reply-To: <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Tue, 11 Dec 2018 21:49:13 +1100
Message-ID: <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
Subject: Re: [PATCH] drm/sun4i: fix HSYNC and VSYNC polarity
To:     Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc:     Maxime Ripard <maxime.ripard@free-electrons.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giulio,

On Thu, 6 Dec 2018 at 22:00, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> Hi Jonathan,
>
> Il 06/12/2018 08:29, Jonathan Liu ha scritto:
> > Hi Giulio,
> >
> > On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
> > <giulio.benetti@micronovasrl.com> wrote:
> >>
> >> Differently from other Lcd signals, HSYNC and VSYNC signals
> >> result inverted if their bits are cleared to 0.
> >>
> >> Invert their settings of IO_POL register.
> >>
> >> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >> ---
> >>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
> >>   1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> index 3c15cf2..aaf911a 100644
> >> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct sun4i_tcon *tcon,
> >>                       SUN4I_TCON0_BASIC3_H_SYNC(hsync));
> >>
> >>          /* Setup the polarity of the various signals */
> >> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> >> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> >>                  val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> >>
> >> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> >> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >>                  val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> >>
> >>          regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
> >
> > I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
> > LCD touchscreen (Innolux AT070TN92) connected to Olimex
> > A20-OLinuXino-MICRO that the image does not display correctly after
> > this change.
> > The image is shifted to the right.
> >
> > Reverting the change results in the image being displayed correctly on
> > the screen.
> >
> > I have in the device tree a "panel" node with compatible =
> > "innolux,at070tn92" which uses the timings in
> > drivers/gpu/drm/panel/panel-simple.c.
> >
> > Any ideas?

>
> Checking Display Datasheet:
> https://www.olimex.com/Products/Retired/A13-LCD7-TS/resources/S700-AT070TN92.pdf
>
> Page 13 section 3.3.2 you can see it needs active low VS and HS.
>
> You can refer to this Thread and check scope captures about VS and HS
> versus TCON0_IOPOL register:
> https://lists.freedesktop.org/archives/dri-devel/2018-January/163874.html
>
> There should be something that wrongly sets one of these or both:
> mode->flags |= DRM_MODE_FLAG_PHSYNC;
> and/or
> mode->flags |= DRM_MODE_FLAG_PVSYNC;
>
> Checked in panel-simple.c but it's not there.

flags is 0 because it is not assigned in the struct definition for the panel.
Before this change, TCON0_IO_POL_REG would be 0x03000000 (both bits
set to 1) and image displays correctly.
After this change, TCON0_IO_POL_REG is 0x00000000 (both bits set to 0)
and image doesn't display correctly.

Checked using "devmem2 0x01c0c088" on A20-OLinuXino-MICRO Rev J.

>
> At the moment I don't have a board to check it with me, I'll try to do
> it soon, but I'm full with other work at the moment.
>
> If you have the chance to debug you could try to find in which point
> mode->flags gets changed with those 2 flags.
>
> When the problem came out I've noticed the same thing for u-boot too but
> it's been decided to not patch it because in that case every single
> sunxi defconfig had to be changed from:
> CONFIG_VIDEO_LCD_MODE="...,sync:3,..."
> to:
> CONFIG_VIDEO_LCD_MODE="...,sync:0,..."
> and it would have been a great mess, probably not worth it:
> https://lists.denx.de/pipermail/u-boot/2018-February/321405.html
>
> So keep in mind that TCON driver works differently for HS and
> VS(inverted) polarity in u-boot and linux.
>
> Hope to work this out soon.

Regards,
Jonathan
