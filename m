Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425300AbeE1QYn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 12:24:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932473AbeE1QYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 12:24:38 -0400
X-Google-Smtp-Source: ADUXVKJ/CnodSWI+CsvASqknqprDiQb4CgUgxrt3Q272lqO5CU0LuDHbAFdOXntGpr2FkeDPohTXgi4iluV4y7nfTM4=
MIME-Version: 1.0
In-Reply-To: <1527500833-16005-10-git-send-email-m.purski@samsung.com>
References: <CGME20180528094729eucas1p1cc26ea191a4ee1ba9daa06fae93037bf@eucas1p1.samsung.com>
 <1527500833-16005-1-git-send-email-m.purski@samsung.com> <1527500833-16005-10-git-send-email-m.purski@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 28 May 2018 18:24:35 +0200
X-Gmail-Original-Message-ID: <CAJKOXPe0gq8U+7xSaxaZFjsGxx7iRGKMEtYn==fAZajJkfasxw@mail.gmail.com>
Message-ID: <CAJKOXPe0gq8U+7xSaxaZFjsGxx7iRGKMEtYn==fAZajJkfasxw@mail.gmail.com>
Subject: Re: [PATCH 09/12] ARM: dts: exynos5250: add mipi-phy node
To: Maciej Purski <m.purski@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Kukjin Kim <kgene@kernel.org>, Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:47 AM, Maciej Purski <m.purski@samsung.com> wrote:
> The patch adds phy node, required by MIPI devices.
>
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

This have pretty small changes since original Andrzej's patch so
probably Andrzej's authorship should be preserved.

> ---
>  arch/arm/boot/dts/exynos5250.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 2daf505..a63b655 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -733,6 +733,12 @@
>                         #phy-cells = <0>;
>                 };
>
> +               mipi_phy: video-phy@10040710 {
> +                       compatible = "samsung,s5pv210-mipi-video-phy";

No DTC warnings (make dtbs W=1)? reg is missing so DTC should complain.

Best regards,
Krzysztof

> +                       #phy-cells = <1>;
> +                       syscon = <&pmu_system_controller>;
> +               };
> +
>                 adc: adc@12d10000 {
>                         compatible = "samsung,exynos-adc-v1";
>                         reg = <0x12D10000 0x100>;
> --
> 2.7.4
>
