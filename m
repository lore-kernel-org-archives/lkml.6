Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B36C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E0152154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 07:55:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/sCp0uR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0152154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeIVNsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 09:48:07 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:40063 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIVNsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 09:48:07 -0400
Received: by mail-oi0-f65.google.com with SMTP id l202-v6so13295650oig.7;
        Sat, 22 Sep 2018 00:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MTpOHYq+526RY7xbnMoPi6PYKDuuT+o7YY/0rY78ndY=;
        b=Z/sCp0uRd4Bpinak8Ei/5c28cwCesneBQM7LTDjpybuzFiHQduN6tmdn/AD+XF9F7M
         iVWwQgoXcmlFbcLxy7nnFtNqXvYsti3+sLUeoaYFNnqZiFFgQ9ICic7rMPYTtoLwyuqM
         gpM5xj0Rzwsqs9iCdENf1FyAd4PDdC/Wd2gPAb51Py4Mo5ya8YA8Nd/CtJxF9CK2BTQ1
         0cTQ9IAUFEXmSUWTd2di3tLIWK/Rp3xSfnCONTvzi6FoABMzlJa168/AjY5/Bb94DPUQ
         OsdgadtH19GeRC7eO/NW0/+hu+9y8pjeuYvr16pHCU7MHNFTowObFfkBk57YNTyuSDgr
         BfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MTpOHYq+526RY7xbnMoPi6PYKDuuT+o7YY/0rY78ndY=;
        b=RB0vyPlOcXPPFIOy1+Wa3CV/DvDLz5J85KjUvh0da8imQxmXMfwAhQ7b7Tq5nbVWYC
         HBnxpBFWijhNh+PI1TlNZ/mHNZHbWPzkDQJ/MyWNijTBZaXc3wXP+j+RC6r72y14tdGk
         U5KrlkDMyoT9q9KP8PcxnVIjn79kG8NF2C8nuKrR7AfmKgGaU7ByL/k7VUAVf2aA+aPD
         xN6LRKYoYNxfJIGEFX584MdakBIAyUIlvivcYz3Of6y1Zmjvo9us4D2fh+WubgeNXYdR
         WIUn/AqueYEpNcQVHTuaCoxpLURj+d5J2j4YzDdOicrTFSjpcQ8Sd+CE5TtgPdzOiPK2
         eA6w==
X-Gm-Message-State: APzg51BW4lO4LqVi/DEXXUFK9t9yGf9te7MT+yUn76GT5k6RV6aJN7WH
        r4sVqdHsyVei7OKjV8VyuHdC6tYNxO0RCE16MpI=
X-Google-Smtp-Source: ANB0VdY7HWWh5YlzvEzQtphP0m5lZb6OGNocstbMwCE+gMz/i2C9zjps7bxY93JorZU7NtVCqF8abxXNtVKhYFcVgdA=
X-Received: by 2002:aca:60c1:: with SMTP id u184-v6mr551228oib.99.1537602929046;
 Sat, 22 Sep 2018 00:55:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180920175826.1284-1-linux.amoon@gmail.com> <20180920175826.1284-6-linux.amoon@gmail.com>
 <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
 <CANAwSgQQgObh-N0CbBM9iNxOGUd2uwoKNFVDBymEALzMtHxOhA@mail.gmail.com> <20180921210900.GA12384@kozik-lap>
In-Reply-To: <20180921210900.GA12384@kozik-lap>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sat, 22 Sep 2018 13:25:15 +0530
Message-ID: <CANAwSgQmu6kA9CZUP_Xy5M461f+p1N+hgi4yCu_f-9AOVv+-Kw@mail.gmail.com>
Subject: Re: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect sd-card
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,
On Sat, 22 Sep 2018 at 02:39, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Sep 21, 2018 at 06:01:07PM +0530, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Fri, 21 Sep 2018 at 16:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Thu, 20 Sep 2018 at 19:59, Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > add the Write Protect GPIO property for sdcard, to fix
> > > > the warning message during boot time.
> > > > of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'
> > > >
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > New patch to this series.
> > > > If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
> > > > ---
> > > >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > > index 03fe02ceae66..475c38bbc99e 100644
> > > > --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > > +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > > @@ -370,6 +370,7 @@
> > > >         cap-sd-highspeed;
> > > >         max-frequency = <200000000>;
> > > >         cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> > > > +       wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;
> > >
> > > Two issues here:
> > > 1. You need also proper pinctrl setting.
> >
> > Thanks for pointing out. Yes proper pinctrl is needed to support this setting.
> > probably pinctrl sd2_wp is needed to support this feature.
> >
> > > 2. On schematics the WP is not connected... so how do you know that it
> > From XU4_MAIN_REV0.1 schematics page 7 "Micro Socket" their is no
> > connection to WP pin.
> > but below schematics page "EXYNOS 5422 MMC UFS" it's shows
> > XMMC2WP/GPC4_0/EXT_INT13_0.
> >
> > > is active high? How did you test it? How do you want to test it on
> > > microSD?
> >
> > I just tested this with the DTS change to GPIO_ACTIVE_LOW which
> > resulted the microSD card booted into RO mode.
> > So I set this to GPIO_ACTIVE_HIGH just to avoid warning.
> >
> > I will study the changes requires and then post proper separate patch
> > to support this feature.
>
> Please squash it with cd-gpios change and send it only for the purpose
> of describing the hardware. They do not have any meaningful change from
> functional point of view (maybe except slower code as now it goes
> through gpio subsystem instead of just reading dw-mmc registers).
>
> Please use full sentences in commit msg (so start with capital letter)
> and remove reference for warning because there is no warning.
> You can follow up on my change for XU:
> https://patchwork.kernel.org/patch/10610985/
>
Ok I have tried to squash the changes into single patch.

> Best regards,
> Krzysztof

Best Regards
-Anand
