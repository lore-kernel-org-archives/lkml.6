Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF117ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 715652148D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3l4nl2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715652148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeJQO5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 10:57:41 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42632 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbeJQO5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 10:57:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id y71-v6so23266079lje.9;
        Wed, 17 Oct 2018 00:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KBP1p4NeDrFvGrl5ybCs1RrGYgm6SXucmIRz5ZPKKQQ=;
        b=O3l4nl2xjEHsX+l8mKWXi0hIKxZKvDkJiq3ui8nMveGXl5bMQKssSlMs88VYSdl6Sp
         qyYZVPOjunSMZfjkbTTPRoGKCfry+F1jo2pmb6IV3n/41+Gf4W9G4ta4AQzodsXLLtN8
         MYTWq0hx4ekf0v6Csn1Nxy+qKoThpQvEI06QH+VwIKKhHsbea3Q/SQuLsaxUAsZ39L2B
         8IcpYHC4SN+x6Jy/4kxV0bmxexrXzDYYVH7qBO+irgz1WjNOOhdGVxOjMgudH3Yu/nmV
         eFuovPvpDS8u43a0J83VQqd3i2Gtc6cga+/GDy41jmir8PYTiVgEaGNeVmq/Tvb/UsU7
         JaOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KBP1p4NeDrFvGrl5ybCs1RrGYgm6SXucmIRz5ZPKKQQ=;
        b=mWwagbMIE1tiMO/T5nxVWy1VsxNQJLiZnsKISe2wk52kAraUvmWyRIN5HHDl1BoiJj
         ZKz/Ws25H1rmBiukl/kdthXk7zHwAdHlQ4faO3bAmInV+kUVMr5jrRN4mpxikg1PuAU9
         RcvUpsnUaSN0d5A0YZjqTKR40aPKqr8KkNz6jH3q5QeibUm6OdQZ9wk90taEONRLcQvI
         Y0XxbwTcvbQk6PGpjKpuzeCGA/m79TwMQV6gRcv1sCa3A+p+HeAvm+xOKi8Sq0EeZbUN
         deK1YZrOqunwrxvCPh5/ZVNZmqGH1eew5FJuZpkzyyJ7I/rH7frM+k+Kwh9RPc2QeXKe
         ImnQ==
X-Gm-Message-State: ABuFfoglHuQnIUg7jI+BvfTCtousC+6R1iI9oj/GX3FaUiVN2tcIF+qA
        XhZOFq5FFueY9GnnedjKSDA2HsUa7QYJ/R9hTpk=
X-Google-Smtp-Source: ACcGV61bG8bw3gv32Op2h5MRcTAMBfQGhEqlneXBl/jM27KAieupqmcjpxXXpPRFsC4PbcJe6hmEHcW69kZ/Drp62rA=
X-Received: by 2002:a2e:458b:: with SMTP id s133-v6mr17326068lja.60.1539759803963;
 Wed, 17 Oct 2018 00:03:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
 <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
In-Reply-To: <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
From:   =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k+lkml@gmail.com>
Date:   Wed, 17 Oct 2018 09:03:13 +0200
Message-ID: <CAJKOXPei6b7TnOnG7DUMNm+xEUsMxqcMOfbG10cJbrNROXLN2w@mail.gmail.com>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 16:56, Lukasz Luba <l.luba@partner.samsung.com> wrote:
>
> Hi all,
>
> This patch set adds new flag and mechanism in thermal trip point in DT.
> The current situation with 'passive' (passive cooling - DVFS)
> trip point is that it enables polling mode in thermal framework.

For DT platform, I checked it some months ago... and that time I was
pretty sure - passive mode does not enable polling (unless you tell it
explicitly with "polling-delay-passive"). Maybe something changed...
but quick look at the code tell me that not. Passive does not indicate
polling mode.

Why do you think that passive enables polling?

Best regards


> If the device supports irqs fired when the desired temerature is met,
> thermal framwork should be notifed from driver's irq routine.
> This is sufficent and there is no need of polling.
> As a workaround, people declare trip point as 'active'
> (active cooling, i.e. fan) to bypass polling mode setup in thermal
> framework.
>
> With this patch set trip point 'passive' declared in DT with explicit flag:
> 'irq-mode;' will not register itself as polling mode.
>
> A good example is Exynos4 SoC family, where there is 4 HW supported
> trip points and there is a need of 6. The rest 2 are declared as 'passive'
> without 'irq-mode;' flag, thus polling needed.
>
> It does not break existing design for trip points which do not have 'irq-mode'
> flag - they will use polling.
>
> For consistency this flag should be added to all trip point types('active',
> 'passive', 'hot', 'critical') when need (meaning, when irq will notify thermal
> framework).
>
> Regards,
> Lukasz Luba
>
> Lukasz Luba (11):
>   thermal: remove unused function parameter
>   thermal: add irq-mode configuration for trip point
>   thermal: add new sysfs file for irq-mode
>   Doc: thermal: new irq-mode for trip point
>   Doc: DT: thermal: new irq-mode for trip point
>   DT: arm64: exynos: add support for thermal trip irq-mode
>   DT: arm64: exynos7: add support for thermal trip irq-mode
>   DT: arm: exynos4: add support for thermal trip irq-mode
>   DT: arm: exynos: add support for thermal trip irq-mode
>   DT: arm: exynos: add support for thermal trip irq-mode
>   DT: arm: exynos: add support for thermal trip irq-mode
>
>  .../devicetree/bindings/thermal/thermal.txt        |   7 ++
>  Documentation/thermal/sysfs-api.txt                |   9 ++
>  arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
>  arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
>  arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
>  arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105 ++++++++++++++-------
>  .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
>  drivers/thermal/of-thermal.c                       |  17 ++++
>  drivers/thermal/thermal_core.c                     |  16 ++--
>  drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
>  include/linux/thermal.h                            |   5 +
>  12 files changed, 226 insertions(+), 64 deletions(-)
>
> --
> 2.7.4
>
