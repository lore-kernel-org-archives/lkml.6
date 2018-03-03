Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeCCLR4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 06:17:56 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:39200 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751775AbeCCLRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 06:17:54 -0500
X-Google-Smtp-Source: AG47ELv93Mj3LWO3B2HZXHg8xtQ0zc8TLvgi2ovIth01glNcvzdXpD6EixRy5mBvmUPqm4QzOI3+xRT9twnU5ZpFHWg=
MIME-Version: 1.0
In-Reply-To: <20180301152515.20940-4-enric.balletbo@collabora.com>
References: <20180301152515.20940-1-enric.balletbo@collabora.com> <20180301152515.20940-4-enric.balletbo@collabora.com>
From: Vicente Bergas <vicencb@gmail.com>
Date: Sat, 3 Mar 2018 12:17:53 +0100
Message-ID: <CAAMcf8CZ4JnytkdDoUmxxvjBR4T1QNNHDSzFsj_z8-Nm_ky=tA@mail.gmail.com>
Subject: Re: [PATCH v2 3/6] arm64: dts: rockchip: enable typec-phy for rk3399-sapphire.
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: kishon@ti.com, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        groeck@chromium.org, gwendal@chromium.org, kernel@collabora.com,
        devicetree@vger.kernel.org, Jianqun Xu <jay.xu@rock-chips.com>,
        Jacob Chen <jacob-chen@iotwrt.com>, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 4:25 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> Commit c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port
> support for rk3399") caused a regression regarding the USB3 type-A port.
> During boot, the following message appears a few times:
>
>   dwc3: failed to initialize core
>
> The driver is deferred waiting for the typec-phy, but this never happens
> bceause is disabled. So, enable it.
>
> Fixes: c301b327aea898af ("arm64: dts: rockchip: add usb3-phy otg-port support for rk3399")
> Reported-by: Vicente Bergas <vicencb@gmail.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
>
> Changes in v2: None
>
>  arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> index ce592a4c0c4c..9c685eab4748 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-sapphire.dtsi
> @@ -557,6 +557,14 @@
>         status = "okay";
>  };
>
> +&tcphy0 {
> +       status = "okay";
> +};
> +
> +&tcphy1 {
> +       status = "okay";
> +};
> +
>  &u2phy0 {
>         status = "okay";
>
> --
> 2.16.1

Tested-by: Vicente Bergas <vicencb@gmail.com>

Thank you,
  Vicente.
