Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBHUQr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:16:47 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45519 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbeBHUQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:16:45 -0500
X-Google-Smtp-Source: AH8x225Jz4a9U8fpTN/+OXJzFh+MfXneWoRmPfmSteklNM7uvkUyHMls1kRKdNoGjWc151dY/YADJA==
Date: Thu, 8 Feb 2018 14:16:43 -0600
From: Rob Herring <robh@kernel.org>
To: Icenowy Zheng <icenowy@aosc.io>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Linus Walleij <linus.walleij@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/6] pinctrl: sunxi: add support for the Allwinner H6
 main pin controller
Message-ID: <20180208201643.vqj7o5v5rzlwsoch@rob-hp-laptop>
References: <20180203154942.63566-1-icenowy@aosc.io>
 <20180203154942.63566-3-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180203154942.63566-3-icenowy@aosc.io>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 03, 2018 at 11:49:38PM +0800, Icenowy Zheng wrote:
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
> format.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v2:
> - Dropped without_bus_gate description.
> - Switched to SPDX license identifier.
> 
>  .../bindings/pinctrl/allwinner,sunxi-pinctrl.txt   |   1 +

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/pinctrl/sunxi/Kconfig                      |   4 +
>  drivers/pinctrl/sunxi/Makefile                     |   1 +
>  drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c          | 676 +++++++++++++++++++++
>  4 files changed, 682 insertions(+)
>  create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun50i-h6.c
