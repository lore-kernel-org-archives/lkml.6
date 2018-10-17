Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5FC7ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C11D2152D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXaicV0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C11D2152D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbeJQPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 11:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJQPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 11:46:42 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6626C21523;
        Wed, 17 Oct 2018 07:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539762735;
        bh=3JrxoJ7yJwys+Z0YffuWo6ZIji9az493bEu5KJVuWiM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QXaicV0Y3M6ngqwtc4Dc7C0BlYOMLK6t0FsSMMhPsqubP0HXTOcUDgTiZcrqw/kIM
         LGIGNTB9pQ4pCs/66XT+ynr38IkNvu6+7h/xlSu0KYu7XtLVkleBGOL1Zs8q72cHbY
         5S+tCT/EmdrYkgfmUJn3pG8hJj5iNGDu1efBGcL4=
Received: by mail-lj1-f173.google.com with SMTP id v7-v6so23405750ljg.5;
        Wed, 17 Oct 2018 00:52:15 -0700 (PDT)
X-Gm-Message-State: ABuFfohC3BhZZjzilkstH4ujqdqphLmY37wgzvuHyb3lqWUuVpaGqQBN
        hcZ23PAl2NJzmCc3cCjZqjKEtkL8hIeIm4JFs4E=
X-Google-Smtp-Source: ACcGV62kXhYrM7IK5hHFGM1cMkEZ3w350bpgVPzwdox/s9EXHanomwdPjEh98RNj55CoC2Uwq2oYheERiRJ8+ms17Mw=
X-Received: by 2002:a2e:b017:: with SMTP id y23-v6mr15405941ljk.82.1539762733506;
 Wed, 17 Oct 2018 00:52:13 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
 <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
 <CAJKOXPei6b7TnOnG7DUMNm+xEUsMxqcMOfbG10cJbrNROXLN2w@mail.gmail.com> <20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4~eVYe84jXW0904509045eucas1p2q@eucas1p2.samsung.com>
In-Reply-To: <20181017074244eucas1p2487ff3bccf50d6f4fd7a99cd7d8d2bb4~eVYe84jXW0904509045eucas1p2q@eucas1p2.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 17 Oct 2018 09:52:01 +0200
X-Gmail-Original-Message-ID: <CAJKOXPd4=hvowfkEJbfX_BXf_PEjxuKxn7dxy7cb=G59a8+GOw@mail.gmail.com>
Message-ID: <CAJKOXPd4=hvowfkEJbfX_BXf_PEjxuKxn7dxy7cb=G59a8+GOw@mail.gmail.com>
Subject: Re: [PATCH 00/11] thermal: add new flag irq-mode for trip point
To:     l.luba@partner.samsung.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Oct 2018 at 09:42, Lukasz Luba <l.luba@partner.samsung.com> wrot=
e:
>
> Hi Krzysztof,
>
> On 10/17/2018 09:03 AM, Krzysztof Koz=C5=82owski wrote:
> > On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> =
wrote:
> >>
> >> Hi all,
> >>
> >> This patch set adds new flag and mechanism in thermal trip point in DT=
.
> >> The current situation with 'passive' (passive cooling - DVFS)
> >> trip point is that it enables polling mode in thermal framework.
> >
> > For DT platform, I checked it some months ago... and that time I was
> > pretty sure - passive mode does not enable polling (unless you tell it
> > explicitly with "polling-delay-passive"). Maybe something changed...
> > but quick look at the code tell me that not. Passive does not indicate
> > polling mode.
> >
> > Why do you think that passive enables polling?
> Please check dt file which implements 2 more trip points that HW
> supports:
> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>
> In that file we have this trick with 'active' present.
> Yes, you are right, 'polling-delay-passive' enables it in
> the thermal code (for whole thermal zone).
> Unfortunately, if you change the bellow 'active' to 'passive'
> in that file, they will start polling, which is not what we want.

Yes but this looks different than what you explained at the beginning.
You said that passive enables polling mode... which is not true. You
can have active with or without polling. You can have passive with or
without polling. But the real problem you described now is that given
polling/IRQ mode applies to entire thermal zone, not to a specific
trip point.

I agree with this problem but you need to clearly mark it in cover
letter and description of other commits because really from existing
explanation I understood something completely different. You simply
want to configure IRQ or polling per trip-point, not per thermal zone.

Best regards,
Krzysztof

> --------8<-------------------------
>          thermal-zones {
>                  cpu0_thermal: cpu0-thermal {
>                          thermal-sensors =3D <&tmu_cpu0 0>;
>                          polling-delay-passive =3D <250>;
>                          polling-delay =3D <0>;
>                          trips {
>                                  cpu0_alert0: cpu-alert-0 {
>                                          temperature =3D <50000>; /*
> millicelsius */
>                                          hysteresis =3D <5000>; /*
> millicelsius */
>                                          type =3D "active";
>                                  };
>                                  cpu0_alert1: cpu-alert-1 {
>                                          temperature =3D <60000>; /*
> millicelsius */
>                                          hysteresis =3D <5000>; /*
> millicelsius */
>                                          type =3D "active";
>                                  };
>                                  cpu0_alert2: cpu-alert-2 {
>                                          temperature =3D <70000>; /*
> millicelsius */
>                                          hysteresis =3D <5000>; /*
> millicelsius */
>                                          type =3D "active";
>                                  };
>                                  cpu0_crit0: cpu-crit-0 {
>                                          temperature =3D <120000>; /*
> millicelsius */
>                                          hysteresis =3D <0>; /*
> millicelsius */
>                                          type =3D "critical";
>                                  };
>                                  /*
>                                   * Exynos542x supports only 4 trip-point=
s
>                                   * so for these polling mode is required=
.
>                                   * Start polling at temperature level
> of last
>                                   * interrupt-driven trip: cpu0_alert2
>                                   */
>                                  cpu0_alert3: cpu-alert-3 {
>                                          temperature =3D <70000>; /*
> millicelsius */
>                                          hysteresis =3D <10000>; /*
> millicelsius */
>                                          type =3D "passive";
>                                  };
>                                  cpu0_alert4: cpu-alert-4 {
>                                          temperature =3D <85000>; /*
> millicelsius */
>                                          hysteresis =3D <10000>; /*
> millicelsius */
>                                          type =3D "passive";
>                                  };
>                          };
> ---------------->8-----------------------------
>
> If you have some other ideas how to handle this case,
> I am happy to discuss.
>
> Regards,
> Lukasz
> >
> > Best regards
> >
> >
> >> If the device supports irqs fired when the desired temerature is met,
> >> thermal framwork should be notifed from driver's irq routine.
> >> This is sufficent and there is no need of polling.
> >> As a workaround, people declare trip point as 'active'
> >> (active cooling, i.e. fan) to bypass polling mode setup in thermal
> >> framework.
> >>
> >> With this patch set trip point 'passive' declared in DT with explicit =
flag:
> >> 'irq-mode;' will not register itself as polling mode.
> >>
> >> A good example is Exynos4 SoC family, where there is 4 HW supported
> >> trip points and there is a need of 6. The rest 2 are declared as 'pass=
ive'
> >> without 'irq-mode;' flag, thus polling needed.
> >>
> >> It does not break existing design for trip points which do not have 'i=
rq-mode'
> >> flag - they will use polling.
> >>
> >> For consistency this flag should be added to all trip point types('act=
ive',
> >> 'passive', 'hot', 'critical') when need (meaning, when irq will notify=
 thermal
> >> framework).
> >>
> >> Regards,
> >> Lukasz Luba
> >>
> >> Lukasz Luba (11):
> >>    thermal: remove unused function parameter
> >>    thermal: add irq-mode configuration for trip point
> >>    thermal: add new sysfs file for irq-mode
> >>    Doc: thermal: new irq-mode for trip point
> >>    Doc: DT: thermal: new irq-mode for trip point
> >>    DT: arm64: exynos: add support for thermal trip irq-mode
> >>    DT: arm64: exynos7: add support for thermal trip irq-mode
> >>    DT: arm: exynos4: add support for thermal trip irq-mode
> >>    DT: arm: exynos: add support for thermal trip irq-mode
> >>    DT: arm: exynos: add support for thermal trip irq-mode
> >>    DT: arm: exynos: add support for thermal trip irq-mode
> >>
> >>   .../devicetree/bindings/thermal/thermal.txt        |   7 ++
> >>   Documentation/thermal/sysfs-api.txt                |   9 ++
> >>   arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
> >>   arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
> >>   arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
> >>   arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
> >>   arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105 +++++++++++=
+++-------
> >>   .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
> >>   drivers/thermal/of-thermal.c                       |  17 ++++
> >>   drivers/thermal/thermal_core.c                     |  16 ++--
> >>   drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
> >>   include/linux/thermal.h                            |   5 +
> >>   12 files changed, 226 insertions(+), 64 deletions(-)
> >>
> >> --
> >> 2.7.4
> >>
> >
> >
