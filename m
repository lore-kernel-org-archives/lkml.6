Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932892AbeB1SXp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 13:23:45 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:47071 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932381AbeB1SXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 13:23:42 -0500
X-Google-Smtp-Source: AG47ELtpv6VodHkRdfcVsqRrNQn92tcLaAfzcFDbnwPPS7ButDAx4tYTEUs9Yl4Jftj7Fo9DrL1dIg==
Date: Wed, 28 Feb 2018 23:53:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: linus.walleij@linaro.org, robh+dt@kernel.org, afaerber@suse.de
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hzhang@ucrobotics.com,
        bdong@ucrobotics.com, manivannanece23@gmail.com
Subject: Re: [PATCH 00/10] Add Actions Semi S900 pinctrl and gpio support
Message-ID: <20180228182331.65bnk2cp2fpgry5p@linaro.org>
References: <20180228174906.22721-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228174906.22721-1-manivannan.sadhasivam@linaro.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 11:18:56PM +0530, Manivannan Sadhasivam wrote:
> This patchset adds pinctrl and gpio support for Actions Semi S900 SoC.
> Pinctrl and gpio subsystems share the common set of register range but
> implemented as individual drivers for making it less complex.
> 
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.
> 
> gpio-line-names has been added for the Bubblegum-96 board matching the
> 96Boards CE specification v1.0.
> 
> Both pinctrl and gpio drivers are verified using the Bubblegum-96 board.
> 
> This patchset depends on the clock driver which is still under review:
> https://lkml.org/lkml/2018/2/9/831
> 
> There is also S500 pinctrl and gpio driver developed by Andreas Farber
> independently to this patchset.
> https://github.com/afaerber/linux/commits/bg96-next
> 
> If this patchseries seems to be good enough to add base OWL pinctrl and
> gpio support. Then, we may decide on adding S500 support on top of this later
> by reusing the pinctrl definitions from Andreas.
> 
> Thanks,
> Mani
>

Please ignore this patchset. This one came out without version tag. Sent a new
patch series with correct version.

Sorry for the inconvenience!

Regards,
Mani 
> Changes in v3:
> 
> * Simplified owl_gpio_set_reg() with _relaxed functions
> * Added interrupt controller properties to gpio node bindings as suggested
>   by Rob
> * Minor code cleanups
> 
> Changes in v2:
> 
> * Implemented each GPIO bank as its own gpio-controller
> * Added gpio-ranges property
> * Modified pin group to follow pad names instead of register names
> * Incorporated review comments from Andy
> * Incorporated review comments from Andreas
> * Fixed the MODULE_LICENSE with respect to SPDX tag
> * Added Reviewed by tag from Rob for pinctrl binding
> 
> Manivannan Sadhasivam (10):
>   dt-bindings: pinctrl: Add bindings for Actions S900 SoC
>   arm64: dts: actions: Add pinctrl node for S900
>   arm64: actions: Enable PINCTRL in platforms Kconfig
>   pinctrl: actions: Add Actions S900 pinctrl driver
>   dt-bindings: gpio: Add gpio nodes for Actions S900 SoC
>   arm64: dts: actions: Add S900 gpio nodes
>   arm64: dts: actions: Add gpio line names to Bubblegum-96 board
>   gpio: Add gpio driver for Actions OWL S900 SoC
>   MAINTAINERS: Add reviewer for ACTIONS platforms
>   MAINTAINERS: Add Actions Semi S900 pinctrl and gpio entries
> 
>  .../devicetree/bindings/gpio/actions,owl-gpio.txt  |   95 +
>  .../bindings/pinctrl/actions,s900-pinctrl.txt      |  178 ++
>  MAINTAINERS                                        |    5 +
>  arch/arm64/Kconfig.platforms                       |    1 +
>  arch/arm64/boot/dts/actions/s900-bubblegum-96.dts  |  201 ++
>  arch/arm64/boot/dts/actions/s900.dtsi              |   54 +
>  drivers/gpio/Kconfig                               |    8 +
>  drivers/gpio/Makefile                              |    1 +
>  drivers/gpio/gpio-owl.c                            |  218 ++
>  drivers/pinctrl/Kconfig                            |    1 +
>  drivers/pinctrl/Makefile                           |    1 +
>  drivers/pinctrl/actions/Kconfig                    |   12 +
>  drivers/pinctrl/actions/Makefile                   |    2 +
>  drivers/pinctrl/actions/pinctrl-owl.c              |  571 +++++
>  drivers/pinctrl/actions/pinctrl-owl.h              |  142 ++
>  drivers/pinctrl/actions/pinctrl-s900.c             | 2505 ++++++++++++++++++++
>  16 files changed, 3995 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/actions,owl-gpio.txt
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/actions,s900-pinctrl.txt
>  create mode 100644 drivers/gpio/gpio-owl.c
>  create mode 100644 drivers/pinctrl/actions/Kconfig
>  create mode 100644 drivers/pinctrl/actions/Makefile
>  create mode 100644 drivers/pinctrl/actions/pinctrl-owl.c
>  create mode 100644 drivers/pinctrl/actions/pinctrl-owl.h
>  create mode 100644 drivers/pinctrl/actions/pinctrl-s900.c
> 
> -- 
> 2.14.1
> 
