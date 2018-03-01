Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162962AbeCAXYX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:24:23 -0500
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45814 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162870AbeCAXYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:24:21 -0500
X-Google-Smtp-Source: AG47ELuMuGoxu63UXaGq4ObhdfaY+iusLUXbvJ2ernlIQDs+C5WZA8YOVyMD3WmwJApPQHNKr4IOsg==
Date: Thu, 1 Mar 2018 17:24:19 -0600
From: Rob Herring <robh@kernel.org>
To: Marcel Ziswiler <marcel@ziswiler.com>
Cc: linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM: tegra: fix ulpi regression on tegra20
Message-ID: <20180301232419.ypehol54rhqrqjds@rob-hp-laptop>
References: <20180222143825.1517-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222143825.1517-1-marcel@ziswiler.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:38:25PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Since commit f8f8f1d04494 ("clk: Don't touch hardware when reparenting
> during registration") ULPI has been broken on Tegra20 leading to the
> following error message during boot:
> 
> [    1.974698] ulpi_phy_power_on: ulpi write failed
> [    1.979384] tegra-ehci c5004000.usb: Failed to power on the phy
> [    1.985434] tegra-ehci: probe of c5004000.usb failed with error -110
> 
> Debugging through the changes and finally also consulting the TRM
> revealed that rather than the CDEV2 clock off OSC requiring such pin
> muxing actually the PLL_P_OUT4 clock is in use. It looks like so far it
> just worked by chance of that one having been enabled which Stephen's
> commit now changed when reparenting sclk away from pll_p_out4 leaving
> that one disabled. Fix this by properly assigning the PLL_P_OUT4 clock
> as the ULPI PHY clock.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> ---
> 
> Changes in v2:
> - Updated device tree binding documentation as well.
> - CCing Dmitry as well.
> 
>  Documentation/devicetree/bindings/phy/nvidia,tegra20-usb-phy.txt | 4 +++-
>  arch/arm/boot/dts/tegra20.dtsi                                   | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
