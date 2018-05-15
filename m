Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753110AbeEOM7h (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 08:59:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:36482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752320AbeEOM7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 08:59:36 -0400
X-Google-Smtp-Source: AB8JxZrnKVxnkZqqbyGJCbKA2RAmm+SogkjQrqs7hyVCjw40p2yafMmrDUFJalZQXt+/NPG5SXuLZibzwbD+HHPrCuw=
MIME-Version: 1.0
In-Reply-To: <1702366.qL959G52Hi@amdc3058>
References: <CGME20180515123755eucas1p278a9c1e9cb0101e406e3839e27f8b3b1@eucas1p2.samsung.com>
 <1702366.qL959G52Hi@amdc3058>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 15 May 2018 14:59:33 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
Message-ID: <CAJKOXPdW7Ovo9GW=29tqa3rEAkSFgrEzbxm_wdGmRpamgk2-ig@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: exynos: fix type of thermal trip points for Exynos7
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 2:37 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
> Currently Exynos thermal driver treats as "active" all specified
> trip points before reaching maximum number of hardware supported
> trip points.

The trip point type describe the way how system should act - use
active or passive cooling. It is independent of thermal driver. I do
not understand what is exactly wrong... maybe except whether the trip
point is active/passive looks like property of board, not SoC itself,
but your patch does not address it.

> Moreover polling-delay-passive is specified as "0"
> in exynos7.dtsi (IOW passive polling is disabled).

Which is perfectly fine. TMU driver for Exynos7 supports up to eight
trip points in interrupt mode so having polling mode = 0 is good. IOW
passive polling is disabled just like active polling is disabled so
what did you want to say here?

Best regards,
Krzysztof

> Therefore fix
> type of cpu-alert-0 to cpu-alert6 trip points to be "active"
> instead of "passive" (cpu-alert-7 type is "critical" so it
> doesn't need a fixup).
>
> Cc: Alim Akhtar <alim.akhtar@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> Index: b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
> ===================================================================
> --- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi       2018-05-15 13:57:55.822172496 +0200
> +++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi       2018-05-15 14:23:12.594016481 +0200
> @@ -10,37 +10,37 @@ trips {
>         cpu-alert-0 {
>                 temperature = <75000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-alert-1 {
>                 temperature = <80000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-alert-2 {
>                 temperature = <85000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-alert-3 {
>                 temperature = <90000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-alert-4 {
>                 temperature = <95000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-alert-5 {
>                 temperature = <100000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-alert-6 {
>                 temperature = <110000>; /* millicelsius */
>                 hysteresis = <10000>; /* millicelsius */
> -               type = "passive";
> +               type = "active";
>         };
>         cpu-crit-0 {
>                 temperature = <115000>; /* millicelsius */
>
