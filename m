Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F832C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:09:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E05522154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 21:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E05522154C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391498AbeIVC7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:59:43 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39074 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391321AbeIVC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:59:43 -0400
Received: by mail-ed1-f67.google.com with SMTP id h4-v6so11779189edi.6;
        Fri, 21 Sep 2018 14:09:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bjn4kQ22oX3C/93NG2671u4NbgsTtw8ox4CSxLsZeJs=;
        b=Wmbq0zxRFxj+nVhqVHFvG+jIR8wtSJPPOlWul4xUHTqJ6btgTL4yPqo5H5BLnXu4gr
         mkvYVIU5uyQTQ4EQoux3jCSlYb9DDxN20snxHcNaK3i+oB5/dOH98pGXzJ+iDVqGC95D
         uoES9JXUmf2IAJawFYWCOKM1MxAA45N4SxrOZziUEyg9wIg4XiZU7U4bJ+oorB83JOyU
         rS23FvxEjFx4tnOfm9EE6CsUM/I3rYOIBJF+2EVsGo96S8fIqJRRL+j5sbO96OueWfS1
         OD/2OEVNgQL/6j+81lSGModRnQ+IQkWFTkFuOscMxKyy7/1kfgXe1fcmqHk6EfpaTeK6
         dE1g==
X-Gm-Message-State: APzg51DbEI3C10zRdFuvdKKQIXZ9DkhURaC6zOs2NRs1n/jJe+cX102E
        2NjJ/+9LgysliFLTNUbzMJs=
X-Google-Smtp-Source: ANB0VdYN/41cl7SKcdcfptyT0hG7OhgyQHiEAg6Mbd1frUtNAeqQr01QSdQZSAYm5MHMRZ01lPludQ==
X-Received: by 2002:a50:b410:: with SMTP id b16-v6mr14830077edh.190.1537564142987;
        Fri, 21 Sep 2018 14:09:02 -0700 (PDT)
Received: from kozik-lap ([178.38.103.27])
        by smtp.googlemail.com with ESMTPSA id l4-v6sm2227407edb.41.2018.09.21.14.09.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Sep 2018 14:09:01 -0700 (PDT)
Date:   Fri, 21 Sep 2018 23:09:00 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Anand Moon <linux.amoon@gmail.com>
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
Subject: Re: [PATCHv3 5/7] ARM: dts: exynos5422: use wp-gpio method to detect
 sd-card
Message-ID: <20180921210900.GA12384@kozik-lap>
References: <20180920175826.1284-1-linux.amoon@gmail.com>
 <20180920175826.1284-6-linux.amoon@gmail.com>
 <CAJKOXPdUVjG1xR-q-K98RQpqsWzw-emEv2_3x3CoS+XK8cye2Q@mail.gmail.com>
 <CANAwSgQQgObh-N0CbBM9iNxOGUd2uwoKNFVDBymEALzMtHxOhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANAwSgQQgObh-N0CbBM9iNxOGUd2uwoKNFVDBymEALzMtHxOhA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 06:01:07PM +0530, Anand Moon wrote:
> Hi Krzysztof,
> 
> On Fri, 21 Sep 2018 at 16:42, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >
> > On Thu, 20 Sep 2018 at 19:59, Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > add the Write Protect GPIO property for sdcard, to fix
> > > the warning message during boot time.
> > > of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/soc/mmc@12220000[0]'
> > >
> > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > ---
> > > New patch to this series.
> > > If we keep the wp-gpio GPIO_ACTIVE_LOW sdcard boot into RO mode.
> > > ---
> > >  arch/arm/boot/dts/exynos5422-odroid-core.dtsi | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > index 03fe02ceae66..475c38bbc99e 100644
> > > --- a/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > +++ b/arch/arm/boot/dts/exynos5422-odroid-core.dtsi
> > > @@ -370,6 +370,7 @@
> > >         cap-sd-highspeed;
> > >         max-frequency = <200000000>;
> > >         cd-gpios = <&gpc2 2 GPIO_ACTIVE_LOW>;
> > > +       wp-gpios = <&gpc4 0 GPIO_ACTIVE_HIGH>;
> >
> > Two issues here:
> > 1. You need also proper pinctrl setting.
> 
> Thanks for pointing out. Yes proper pinctrl is needed to support this setting.
> probably pinctrl sd2_wp is needed to support this feature.
> 
> > 2. On schematics the WP is not connected... so how do you know that it
> From XU4_MAIN_REV0.1 schematics page 7 "Micro Socket" their is no
> connection to WP pin.
> but below schematics page "EXYNOS 5422 MMC UFS" it's shows
> XMMC2WP/GPC4_0/EXT_INT13_0.
> 
> > is active high? How did you test it? How do you want to test it on
> > microSD?
> 
> I just tested this with the DTS change to GPIO_ACTIVE_LOW which
> resulted the microSD card booted into RO mode.
> So I set this to GPIO_ACTIVE_HIGH just to avoid warning.
> 
> I will study the changes requires and then post proper separate patch
> to support this feature.

Please squash it with cd-gpios change and send it only for the purpose
of describing the hardware. They do not have any meaningful change from
functional point of view (maybe except slower code as now it goes
through gpio subsystem instead of just reading dw-mmc registers).

Please use full sentences in commit msg (so start with capital letter)
and remove reference for warning because there is no warning.
You can follow up on my change for XU:
https://patchwork.kernel.org/patch/10610985/

Best regards,
Krzysztof
