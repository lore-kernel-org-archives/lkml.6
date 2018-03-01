Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161943AbeCAVT6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 16:19:58 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42053 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161475AbeCAVT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 16:19:56 -0500
X-Google-Smtp-Source: AG47ELv+bzGql4T5InDHamVzaVMDvgLAa5AH8m6oehvlEVITu2O+StHAZKUXT24CwTJqUagBmtmsiA==
Date: Thu, 1 Mar 2018 15:19:50 -0600
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v3 3/7] pinctrl: sunxi: add support for the Allwinner H6
 main pin controller
Message-ID: <20180301211950.ust7g4jnlncrvwxp@rob-hp-laptop>
References: <20180223122552.58049-1-icenowy@aosc.io>
 <20180223122552.58049-4-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223122552.58049-4-icenowy@aosc.io>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 08:25:48PM +0800, Icenowy Zheng wrote:
> The Allwinner H6 SoC has two pin controllers, one main controller
> (called CPUX-PORT in user manual) and one controller in CPUs power
> domain (called CPUS-PORT in user manual).
> 
> This commit introduces support for the main pin controller on H6.
> 
> The pin bank A and B are not wired out and hidden from the SoC's
> documents, however it's shown that the "ATE" (an AC200 chip
> co-packaged with the H6 die) is connected to the main SoC die via these
> pin banks. The information about these banks is just copied from the BSP
> pinctrl driver, but re-formatted to fit the mainline pinctrl driver
> format. The GPIO functions are dropped, as they're impossible to use --
> except a GPIO&IRQ only pin (PB20) which might be the IRQ of ATE.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v3:
> - SPDX license identifier fix.
> - Dropped most GPIO functionality at PA/PB.
> 
> Changes in v2:
> - Dropped without_bus_gate description.
> - Switched to SPDX license identifier.
> 
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Please add acks when posting new versions.

>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          | 614 +++++++++++++++++++++
>  4 files changed, 620 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
