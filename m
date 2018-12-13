Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74FEC67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 687AE20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNRnJeSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 687AE20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbeLMCzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 21:55:47 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39931 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMCzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 21:55:46 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so309537pgl.6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 18:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZgeKRuKSyeheXyLcqKqb1eeA05PJDe5Uo6+O1Uyt/WI=;
        b=cNRnJeSDpJfRR+wwXruNpjmyA6IPGXixlu7GyOsw/o/AhnHxxQ+N24ZOKlJBolatOx
         sUlcmxpPAPOzuhmx5xUWp6t4WEkHOhl3DNgOxiL1KomIN6JuAWB55YEljwCdUaseXCAs
         xhsRlB+PjF/vphunUYHXpFKoFVwZghlv3L2+kjrw9T1SusacJ5Vtq0Qer3YDJkBRJTTj
         VOFXjDddPrwoWa0JNzZClOltHRW0y1K7EPxAwq4A/hNK1XlXynG6S+O19cjOd8ikoQyo
         Cqo4yQaaztnzkkZIGwEyrMuYE7rWXZySFtiTwaVLYH6M8hSjIYxZQZUj9jsBGdywEjdr
         o0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZgeKRuKSyeheXyLcqKqb1eeA05PJDe5Uo6+O1Uyt/WI=;
        b=Uv7rmtEjLGDxuURVohM0533/Yji4w5ofWo1T5m97Rmz4vrqRpJp62Mi6PYqWbV0x3J
         iJZ3hUiK1yeiiddGOTHfd8s+hNTfFc6XN5Foctou//N8PEHncydrFVgDZJdOc2S8tG3i
         IhMjRN4iUMWEswGh4fdxh5rJxCkq6eej108b3qCcWnPYMP4fxAb0z5wrB5M1zC5SQfXE
         2+2GtSFIQhJLQCzfWCLnEJzXfR64NfCKotuY6C5hflVLxBfmpfecTg0tn6i17VpuofVC
         fPrppvgV6iA6Swem2x1rbMUMj788H3d41gXbuVHErnUYY/MQyqV88oDagPc0CkwX1JeD
         Lleg==
X-Gm-Message-State: AA+aEWasQm+vW1IXTuDpUIcLqQjyCTygkmPZgIbTiW+Sb5lH0PAFU9o7
        VNR+yMxsZeWi/rS7wiASlUOvGzwyKZjFEeynFvipQ4OZxPc=
X-Google-Smtp-Source: AFSGD/XCaOIcRdevyXNgGKw4xaRk1aLMfJqoWPcBWzAOx/wZMyfgTWKMlUtCto9iyk28Ue+iM635IES4YMiqyIapevM=
X-Received: by 2002:a63:e19:: with SMTP id d25mr20334815pgl.272.1544669745664;
 Wed, 12 Dec 2018 18:55:45 -0800 (PST)
MIME-Version: 1.0
References: <1518717288-123578-1-git-send-email-giulio.benetti@micronovasrl.com>
 <CANwerB3Zr9axz+1rwCnNpLsX-xcOhOKEY4MT53v1+vzd99KRMg@mail.gmail.com>
 <57d929cf-4458-dae4-36d4-4e89170eba4a@micronovasrl.com> <CANwerB1aUP4Rw-B_qmzOu0BWmkpr-LQ5b4FKQbzZeeYHPtGoqA@mail.gmail.com>
 <05786c98-6bc9-44f1-91ea-14452448cced@micronovasrl.com> <e3307630-7ae7-2bd4-4933-a31419a0cc3a@micronovasrl.com>
In-Reply-To: <e3307630-7ae7-2bd4-4933-a31419a0cc3a@micronovasrl.com>
From:   Jonathan Liu <net147@gmail.com>
Date:   Thu, 13 Dec 2018 13:55:14 +1100
Message-ID: <CANwerB2GGLT6fOZk7Q8RXhmiEb7KYnQrx-Rj5AgGn-YPCiMH4g@mail.gmail.com>
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

On Wed, 12 Dec 2018 at 04:39, Giulio Benetti
<giulio.benetti@micronovasrl.com> wrote:
>
> Forgot to ask you,
>
> Il 11/12/2018 18:20, Giulio Benetti ha scritto:
> > Hi Jonathan,
> >
> > Il 11/12/2018 11:49, Jonathan Liu ha scritto:
> >> Hi Giulio,
> >>
> >> On Thu, 6 Dec 2018 at 22:00, Giulio Benetti
> >> <giulio.benetti@micronovasrl.com> wrote:
> >>>
> >>> Hi Jonathan,
> >>>
> >>> Il 06/12/2018 08:29, Jonathan Liu ha scritto:
> >>>> Hi Giulio,
> >>>>
> >>>> On Thu, 15 Feb 2018 at 17:54, Giulio Benetti
> >>>> <giulio.benetti@micronovasrl.com> wrote:
> >>>>>
> >>>>> Differently from other Lcd signals, HSYNC and VSYNC signals
> >>>>> result inverted if their bits are cleared to 0.
> >>>>>
> >>>>> Invert their settings of IO_POL register.
> >>>>>
> >>>>> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> >>>>> ---
> >>>>>    drivers/gpu/drm/sun4i/sun4i_tcon.c | 4 ++--
> >>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>>> b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>>> index 3c15cf2..aaf911a 100644
> >>>>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> >>>>> @@ -389,10 +389,10 @@ static void sun4i_tcon0_mode_set_rgb(struct
> >>>>> sun4i_tcon *tcon,
> >>>>>                        SUN4I_TCON0_BASIC3_H_SYNC(hsync));
> >>>>>
> >>>>>           /* Setup the polarity of the various signals */
> >>>>> -       if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
> >>>>> +       if (mode->flags & DRM_MODE_FLAG_PHSYNC)
> >>>>>                   val |= SUN4I_TCON0_IO_POL_HSYNC_POSITIVE;
> >>>>>
> >>>>> -       if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
> >>>>> +       if (mode->flags & DRM_MODE_FLAG_PVSYNC)
> >>>>>                   val |= SUN4I_TCON0_IO_POL_VSYNC_POSITIVE;
> >>>>>
> >>>>>           regmap_update_bits(tcon->regs, SUN4I_TCON0_IO_POL_REG,
> >>>>
> >>>> I am running Linux 4.19.6 and noticed with Olimex LCD-OLinuXino-7TS 7"
> >>>> LCD touchscreen (Innolux AT070TN92) connected to Olimex
> >>>> A20-OLinuXino-MICRO that the image does not display correctly after
> >>>> this change.
> >>>> The image is shifted to the right.
> >>>>
> >>>> Reverting the change results in the image being displayed correctly on
> >>>> the screen.
> >>>>
> >>>> I have in the device tree a "panel" node with compatible =
> >>>> "innolux,at070tn92" which uses the timings in
> >>>> drivers/gpu/drm/panel/panel-simple.c.
> >>>>
> >>>> Any ideas?
> >>
> >>>
> >>> Checking Display Datasheet:
> >>> https://www.olimex.com/Products/Retired/A13-LCD7-TS/resources/S700-AT070TN92.pdf
> >>>
> >>>
> >>> Page 13 section 3.3.2 you can see it needs active low VS and HS.
> >>>
> >>> You can refer to this Thread and check scope captures about VS and HS
> >>> versus TCON0_IOPOL register:
> >>> https://lists.freedesktop.org/archives/dri-devel/2018-January/163874.html
> >>>
> >>>
> >>> There should be something that wrongly sets one of these or both:
> >>> mode->flags |= DRM_MODE_FLAG_PHSYNC;
> >>> and/or
> >>> mode->flags |= DRM_MODE_FLAG_PVSYNC;
> >>>
> >>> Checked in panel-simple.c but it's not there.
> >>
> >> flags is 0 because it is not assigned in the struct definition for the
> >> panel.
> >
> > I don't think it is 0, because otherwise IO_POL_REG wouldn't be set to
> > 0x03000000 but to 0.
> > What is checked is exactly mode->flags, so the problem seems to be
> > upstream.
> >
> > This is my doubt, it seems mode->flags is not initialized or overriden
> > at a certain point, this is why I want to debug it with Jtag tomorrow.
> >
> >> Before this change, TCON0_IO_POL_REG would be 0x03000000 (both bits
> >> set to 1) and image displays correctly > After this change,
> >> TCON0_IO_POL_REG is 0x00000000 (both bits set to 0)
> >> and image doesn't display correctly.
> >>
> >> Checked using "devmem2 0x01c0c088" on A20-OLinuXino-MICRO Rev J.
> >
> > 0x03000000 as I've triple checked with scope means Positive H/Vsync,
> > and 0x00000000 Negative H/VSync.
> >
> > Please check on the Thread I've pointed you above where there are all
> > the links to the scope captures.
> >
> > Are you completely sure you're using the correct panel?
> > This is because if with 0x03000000 it works correctly, it means that
> > you're using Positive VS and HS but on datasheet on Figure 3.2 it shows
> > that they must be negative.
> >
> > Do you have any chance to measure those signals with a scope?
> >
> > Tomorrow, while debugging, I'll re-check H/Vsync signals again.
> >
> > Kind regards

>
> Can you precisely point me the sources of:
> - u-boot
> - kernel
> - dts
>
> you're using?
>
> Thanks

U-Boot - git tag v2017.03
Linux - git tag v4.19.6
DTS - see device tree changes in
https://github.com/net147/linux/tree/sun7i-drm-wip but change the
compatible to "innolux,at070tn92"

Thanks.

Regards,
Jonathan
