Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754774AbeDYOrc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 10:47:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754203AbeDYOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 10:47:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46314217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AB8JxZpZof4hY8WpFccYDrFKD/pBz537bub1hmRpXEhWh5r/m77O0L3ZzE3ZWa0xfbaHTu3rZnSb5u31sZjx27b/uCY=
MIME-Version: 1.0
In-Reply-To: <20180425125449.19755-12-kishon@ti.com>
References: <20180425125449.19755-1-kishon@ti.com> <20180425125449.19755-12-kishon@ti.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 25 Apr 2018 09:47:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKBXbcQxbN7z9j_DKgiaQg4buUa+08fg9zPELv-ucpRZA@mail.gmail.com>
Message-ID: <CAL_JsqKBXbcQxbN7z9j_DKgiaQg4buUa+08fg9zPELv-ucpRZA@mail.gmail.com>
Subject: Re: [PATCH v3 11/15] ARM: dts: dra7-evm: Add wilink8 wlan support
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-doc@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Hari Nagalla <hnagalla@ti.com>, Ido Yariv <ido@wizery.com>,
        Eyal Reizer <eyalr@ti.com>, Sekhar Nori <nsekhar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 25, 2018 at 7:54 AM, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> From: Hari Nagalla <hnagalla@ti.com>
>
> The wilink module is a combo wireless connectivity sdio
> card based on Texas Instrument's wl18xx solution. It is a
> 4-wire, 1.8V, embedded sdio wlan device with an external
> irq line and is power-controlled by a gpio-based fixed
> regulator.
>
> Add pinmux configuration and IODelay values for MMC4.
> On dra7-evm, MMC4 is used for connecting to wilink module.
>
> IODelay data credits to :  Vishal Mahaveer <vishalm@ti.com>
> and Sekhar Nori <nsekhar@ti.com>
>
> Signed-off-by: Ido Yariv <ido@wizery.com>
> Signed-off-by: Eyal Reizer <eyalr@ti.com>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  arch/arm/boot/dts/dra7-evm-common.dtsi | 15 +++++++++++++++
>  arch/arm/boot/dts/dra7-evm.dts         | 25 +++++++++++++++++++++++++
>  2 files changed, 40 insertions(+)
>
> diff --git a/arch/arm/boot/dts/dra7-evm-common.dtsi b/arch/arm/boot/dts/dra7-evm-common.dtsi
> index 05a7b1a01bc3..3590c40fc112 100644
> --- a/arch/arm/boot/dts/dra7-evm-common.dtsi
> +++ b/arch/arm/boot/dts/dra7-evm-common.dtsi
> @@ -260,3 +260,18 @@
>  &pcie1_rc {
>         status = "okay";
>  };
> +
> +&mmc4 {
> +       bus-width = <4>;
> +       cap-power-off-card;
> +       keep-power-in-suspend;
> +       non-removable;
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +       wlcore: wlcore@2 {

wifi@2
