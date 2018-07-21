Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F0EECDFB8
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E2D82064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 02:38:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rTppKkpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E2D82064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbeGUD3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 23:29:00 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:35093 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727987AbeGUD3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 23:29:00 -0400
Received: by mail-it0-f67.google.com with SMTP id q20-v6so17008455ith.0;
        Fri, 20 Jul 2018 19:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S0ylOVW/ZlETUFKiI1xGMHquvLjc/Zr8wBTug3qwh0o=;
        b=rTppKkpge/Si/yqKLhPKMbc85s/mDtQLXm2uKze+tbeQnbNYehCSYCjNX3Bnr6+ViX
         uSVH0S4awLYtz+E1vRy3T8lk67bGZGd8BzsqVhr9WRtRADns9ajSqW4znBedjyojYVGa
         QSWshi6n037YQMy0olBiaT8LoIvb7YTyCk+fvq2LPradCka8XLKx/x0UbQC3LPwYGNe7
         d7TGOrTqWqfvfQDwN5OgOsRxvp43phH2g/I5sGuQjLpYVQd2ZkHmAwuqmGI9j1lNChbX
         NhyV32R1I9anI/f68Y0NUkXWHCNVR2PMic2QgTt5gwTtW3DZPjEYJHTpkJkv1SyGbUzI
         FmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S0ylOVW/ZlETUFKiI1xGMHquvLjc/Zr8wBTug3qwh0o=;
        b=A/s8rHkF599TZw52GXJ2XZBUu3Iju1z+ggSGFZJ7x9FUTLgVvdnSPXTqed4iiol4J4
         wMbAGtNS7HI71L6zugP3fH9DR4SWS+qxIaxZUmmw+sXr+YytCuKdZnMAHpFmTf8LEa3R
         4aeftOIH+wL4X9WNv3v79dyp/tvx9P6+cOdVH0okZXIKepfdTlc3nZR08k9GgCWul4mk
         jbA5ZYqsaJrxZ4cA6ipxYbksiRpTJbeDCNdMGRWrp/WSLwzXxP5GP2CORNiXBdao9B4g
         Kmfu/VriTKFTq+kMe29SsI5MxFimzhRjxlPHFFhKD708uOZ766PXj/Y26K0TIxQ9pqZZ
         9Nyw==
X-Gm-Message-State: AOUpUlGTyACLla5hgvX3r9g7frEwPqOO/+H+P7dlIZRIKBByGnw5mQGo
        SpGrHrcVH0FrWanW5KNZgxA4BDZuAdsSdEvvmSg=
X-Google-Smtp-Source: AAOMgpdUOV20cBLhL9/xmrMIfMUtPgnUMyogwR+WpmZB2oGvzSsoeC3+kybNh07y1YwrtbT2rNuAsdAgxgXg2wqgbvY=
X-Received: by 2002:a24:d0cd:: with SMTP id m196-v6mr4122519itg.9.1532140681355;
 Fri, 20 Jul 2018 19:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180719160050.22566-1-krzk@kernel.org>
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
From:   Tomasz Figa <tomasz.figa@gmail.com>
Date:   Sat, 21 Jul 2018 11:37:49 +0900
Message-ID: <CA+Ln22HdeSTqZSfh18rewK_w-q7Xhx6r_5djkuAkbXV=pT8rgw@mail.gmail.com>
Subject: Re: [RFT 00/10] pinctrl: samsung: Remove ugly hack for sharing eint_wakeup_mask
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        PANKAJ KUMAR DUBEY <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:SAMSUNG SOC CLOCK DRIVERS" 
        <linux-samsung-soc@vger.kernel.org>, linux-gpio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

2018=E5=B9=B47=E6=9C=8820=E6=97=A5(=E9=87=91) 1:01 Krzysztof Kozlowski <krz=
k@kernel.org>:
>
> Hi All,
>
> Tests
> =3D=3D=3D=3D=3D
> This is both request for comments and requests for tests. Only basic
> tests were done, including suspend to RAM on Odroid U3 (Exynos4412)
> with max7768 RTC wakeup. Please kindly test it with devices capable of
> suspending and resuming. I am mostly thinking about S5Pv210-based (Aria),
> Trats, Trats2 and TM2 (Exynos5433). Existing platforms should not be
> broken however changing external interrupt wakeup mask was not done
> on Exynos5433.
>
>
> Description
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The Exynos/S5Pv210 machine suspend code needs to write the external
> interrupt mask during suspend.  The mask is controlled by pin controller
> driver: the exynos_wkup_irq_set_wake() in IRQ chip for these wakeup
> interrupts.
>
> Therefore pinctrl driver code exposed an exynos_get_eint_wake_mask()
> function which was later used as an extern in machine code.
>
> This is quite ugly way of combining driver and machine code,
> not portable triggering Sparse and GCC warnings.
>
>
> This might break suspend capability S5Pv210 on with older DTBs (thus
> breaks DTB compatibility), however:
> 1. just "might" because in case of using older DTB, the wakeup mask
>    will not be changed during suspend and default reset value (all
>    interrupts non-masked) should work,
> 2. mainline support for S5Pv210 with DTB is limited and suspend
>    to RAM already might be broken.

We probably should also add that it's highly unlikely that anyone
using S5PV210 actually uses a standalone DTB, since those systems
normally predated DT support in bootloaders and workarounds such as
chainloading or appended DTB are normally used.

>
>
> Dependencies
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. The first seven patches should be taken through one tree,
>    preferably samsung-pinctrl,
> 2. The DTS patch (7/10) for S5Pv210 should go into next cycle,
> 3. The remaining patches (8-10) should go after all previous,
>    so probably another release cycle.
>
>
> Best regards,
> Krzysztof
>
>
> Krzysztof Kozlowski (10):
>   pinctrl: samsung: Define suspend and resume callbacks for all banks
>     and SoCs
>   pinctrl: samsung: Document suspend and resume members
>   pinctrl: samsung: Document hidden requirement about one external
>     wakeup
>   pinctrl: samsung: Add dedicated compatible for S5Pv210 wakeup
>     interrupts
>   ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and
>     Exynos5433
>   pinctrl: samsung: Write external interrupt mask
>   ARM: dts: s5pv210: Switch to S5Pv210 specific pinctrl wakeup
>     compatible
>   ARM: s5pv210: Remove legacy setting of external wakeup interrupts
>   ARM: exynos: Remove legacy setting of external wakeup interrupts
>   pinctrl: samsung: Remove legacy API for handling external wakeup
>     interrupts mask
>
>  .../bindings/pinctrl/samsung-pinctrl.txt           | 11 ++-
>  arch/arm/boot/dts/s5pv210.dtsi                     |  2 +-
>  arch/arm/mach-exynos/common.h                      |  2 -
>  arch/arm/mach-exynos/suspend.c                     | 16 +++--
>  arch/arm/mach-s5pv210/common.h                     |  1 -
>  arch/arm/mach-s5pv210/pm.c                         | 16 +++--
>  drivers/pinctrl/samsung/pinctrl-exynos-arm.c       | 16 +++++
>  drivers/pinctrl/samsung/pinctrl-exynos.c           | 78 ++++++++++++++++=
+++---
>  drivers/pinctrl/samsung/pinctrl-samsung.h          | 11 +++
>  include/linux/soc/samsung/exynos-regs-pmu.h        |  8 ++-
>  10 files changed, 136 insertions(+), 25 deletions(-)

Looking through the series, the idea seems to be very reasonable, so:

Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

Thanks for cleaning this up!

Best regards,
Tomasz
