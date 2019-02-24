Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF4C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579CA20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X0Xarmu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbfBXUki (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:40:38 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:46811 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfBXUkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:40:37 -0500
Received: by mail-oi1-f193.google.com with SMTP id j135so5667708oib.13;
        Sun, 24 Feb 2019 12:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HtgJpYsEvvaapt90QDnEHKcsANBH69AnGDig38XGIrI=;
        b=X0Xarmu5fdGo+gXRfp3tq/6amLvX1B1ihuL6pCGhzVixYxuwRZzrUAcfhEmBQ8VMO/
         J83I5rZ3q+UHRxw7JyGFDwYBDsaoS//wzPjwvhModR7dP7kSnzymG8Qy9oJH4hYT9cSS
         lp8Orsph/CgfZpkPkFk1cej54OrXLBE72a1M3tLwj8uNnqNfWjAOts3zLl3+6RFqd+gh
         pilUrB/JiNilhQF378vzJm7TjxbeOd7A/PIIWTg7E2e8qfkO5iFUxCXLXoArFDwE/4Ab
         +1neO1c+Gg+MGOw/QMHxQ9KECLEnRF1f4OiuIGrQMrzOO2utpxpoQiXiBFtpdOEM77D7
         +ToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HtgJpYsEvvaapt90QDnEHKcsANBH69AnGDig38XGIrI=;
        b=gVm12/lLjfNKl34LMrzzeIXPjq0fgpOyKC4ZzhUZGSMQMdiSSZKOFafzYwbZAVlBMu
         5PincoM/qzuNcTL4HZnI/EPFhcQVsAkUGLDGV0BbV7Md6Oyscq37FKNDIKCW9AruCyF/
         NjNO7PhomUElqBm7QB2HdY1K+xzaRj3jmD4Z/s0ZQJrokDisYlxsfctC8Dty+I6Tc26S
         Tg8tOSsI9qnK0yHACUfc3IGVjdIsCPU57oilkanHhSRX9T74lwbNgbBvdz+bLOwBiBqy
         v4zjvXeaRSodqoTbSKqQ+h+kWrJSMZHDk0ASd6NVlJ4ZTTslYBY8T+TwpcZBKTZXjMh0
         B5pg==
X-Gm-Message-State: AHQUAuahoC0Af7fbXZTnwLCPwceL+V+wwcxnV9FzPkK96hTWinNetBOg
        WlOpw/VeoqIxPMWeJgSRQHVc8zY+h33r0bHi3IY=
X-Google-Smtp-Source: AHgI3IY8QnriHWSwxy9dogb1PJcfoINsOZI/r7kj8OLQjtY34rzFRVN1Ww/sB+rx1Qdida8qllJxr0ONqpJjJBGkDRU=
X-Received: by 2002:aca:52cd:: with SMTP id g196mr9538568oib.140.1551040836180;
 Sun, 24 Feb 2019 12:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20190212151413.24632-1-narmstrong@baylibre.com> <20190212151413.24632-9-narmstrong@baylibre.com>
In-Reply-To: <20190212151413.24632-9-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 24 Feb 2019 21:40:25 +0100
Message-ID: <CAFBinCBoahGTbnii0Dhfj75YC8u2HjodAqFWwtD=K3xOZ-wGPw@mail.gmail.com>
Subject: Re: [PATCH 8/8] usb: dwc3: Add Amlogic G12A DWC3 glue
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com, linux-amlogic@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

thank you for working on this!
I have few questions and comments below, but overall it looks good :)

On Tue, Feb 12, 2019 at 4:17 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Adds support for Amlogic G12A USB Control Glue HW.
>
> The Amlogic G12A SoC Family embeds 2 USB Controllers :
> - a DWC3 IP configured as Host for USB2 and USB3
> - a DWC2 IP configured as Peripheral USB2 Only
>
> A glue connects these both controllers to 2 USB2 PHYs, and optionnally
> to an USB3+PCIE Combo PHY shared with the PCIE controller.
>
> The Glue configures the UTMI 8bit interfaces for the USB2 PHYs, including
> routing of the OTG PHY between the DWC3 and DWC2 controllers, and
> setups the on-chip OTG mode selection for this PHY.
>
> The PHYs are childen of the Glue node since the Glue controls the interface
> with the PHY, not the DWC3 controller.
my initial impression is: "if we pass the PHYs [via device-tree] to
the dwc2 and dwc3 controllers then we can simplify the suspend
management here in the USBCTRL driver".
I assume there's a catch so it please add an explanation why it's not possible.

> The drivers collects the mode of each PHY and determine which PHY
> is to be routed between the DWC2 and DWC3 controllers.
>
> This drivers supports the on-probe setup of the OTG mode, and manually
> via a debugfs interface. The IRQ mode change detect is yet to be added
> in a future patchset, mainly due to lack of hardware to validate on.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  drivers/usb/dwc3/Kconfig           |   9 +
>  drivers/usb/dwc3/Makefile          |   1 +
>  drivers/usb/dwc3/dwc3-meson-g12a.c | 650 +++++++++++++++++++++++++++++
>  3 files changed, 660 insertions(+)
>  create mode 100644 drivers/usb/dwc3/dwc3-meson-g12a.c
>
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 1a0404fda596..4335e5e76bbb 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -93,6 +93,15 @@ config USB_DWC3_KEYSTONE
>           Support of USB2/3 functionality in TI Keystone2 platforms.
>           Say 'Y' or 'M' here if you have one such device
>
> +config USB_DWC3_MESON_G12A
> +       tristate "Amlogic Meson G12A Platforms"
> +       depends on OF && COMMON_CLK
> +       depends on ARCH_MESON || COMPILE_TEST
> +       default USB_DWC3
> +       help
> +         Support USB2/3 functionality in Amlogic G12A platforms.
> +        Say 'Y' or 'M' if you have one such device.
> +
>  config USB_DWC3_OF_SIMPLE
>         tristate "Generic OF Simple Glue Layer"
>         depends on OF && COMMON_CLK
> diff --git a/drivers/usb/dwc3/Makefile b/drivers/usb/dwc3/Makefile
> index 6e3ef6144e5d..ae86da0dc5bd 100644
> --- a/drivers/usb/dwc3/Makefile
> +++ b/drivers/usb/dwc3/Makefile
> @@ -47,6 +47,7 @@ obj-$(CONFIG_USB_DWC3_EXYNOS)         += dwc3-exynos.o
>  obj-$(CONFIG_USB_DWC3_PCI)             += dwc3-pci.o
>  obj-$(CONFIG_USB_DWC3_HAPS)            += dwc3-haps.o
>  obj-$(CONFIG_USB_DWC3_KEYSTONE)                += dwc3-keystone.o
> +obj-$(CONFIG_USB_DWC3_MESON_G12A)      += dwc3-meson-g12a.o
>  obj-$(CONFIG_USB_DWC3_OF_SIMPLE)       += dwc3-of-simple.o
>  obj-$(CONFIG_USB_DWC3_ST)              += dwc3-st.o
>  obj-$(CONFIG_USB_DWC3_QCOM)            += dwc3-qcom.o
> diff --git a/drivers/usb/dwc3/dwc3-meson-g12a.c b/drivers/usb/dwc3/dwc3-meson-g12a.c
> new file mode 100644
> index 000000000000..abeff2d56b1d
> --- /dev/null
> +++ b/drivers/usb/dwc3/dwc3-meson-g12a.c
> @@ -0,0 +1,650 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB Glue for Amlogic G12A SoCs
> + *
> + * Copyright (c) 2019 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + */
> +
> +/*
> + * The USB is organized with a glue around the DWC3 Controller IP as :
> + * - Control registers for each USB2 Ports
> + * - Control registers for the USB PHY layer
> + * - SuperSpeed PHY can be enabled only if port is used
> + *
> + * TOFIX:
> + * - Add dynamic OTG switching with ID change interrupt
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/platform_device.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/clk.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/reset.h>
> +#include <linux/of_graph.h>
> +#include <linux/phy/phy.h>
> +#include <linux/usb/otg.h>
> +#include <linux/debugfs.h>
> +
> +/* USB Glue Control Registers */
> +
> +#define USB_R0                                                 0x00
> +       #define USB_R0_P30_LANE0_TX2RX_LOOPBACK                 BIT(17)
> +       #define USB_R0_P30_LANE0_EXT_PCLK_REQ                   BIT(18)
> +       #define USB_R0_P30_PCS_RX_LOS_MASK_VAL_MASK             GENMASK(28, 19)
> +       #define USB_R0_U2D_SS_SCALEDOWN_MODE_MASK               GENMASK(30, 29)
> +       #define USB_R0_U2D_ACT                                  BIT(31)
> +
> +#define USB_R1                                                 0x04
> +       #define USB_R1_U3H_BIGENDIAN_GS                         BIT(0)
> +       #define USB_R1_U3H_PME_ENABLE                           BIT(1)
> +       #define USB_R1_U3H_HUB_PORT_OVERCURRENT_MASK            GENMASK(4, 2)
> +       #define USB_R1_U3H_HUB_PORT_PERM_ATTACH_MASK            GENMASK(9, 7)
> +       #define USB_R1_U3H_HOST_U2_PORT_DISABLE_MASK            GENMASK(13, 12)
> +       #define USB_R1_U3H_HOST_U3_PORT_DISABLE                 BIT(16)
> +       #define USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT      BIT(17)
> +       #define USB_R1_U3H_HOST_MSI_ENABLE                      BIT(18)
> +       #define USB_R1_U3H_FLADJ_30MHZ_REG_MASK                 GENMASK(24, 19)
> +       #define USB_R1_P30_PCS_TX_SWING_FULL_MASK               GENMASK(31, 25)
> +
> +#define USB_R2                                                 0x08
> +       #define USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK             GENMASK(25, 20)
> +       #define USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK               GENMASK(31, 26)
> +
> +#define USB_R3                                                 0x0c
> +       #define USB_R3_P30_SSC_ENABLE                           BIT(0)
> +       #define USB_R3_P30_SSC_RANGE_MASK                       GENMASK(3, 1)
> +       #define USB_R3_P30_SSC_REF_CLK_SEL_MASK                 GENMASK(12, 4)
> +       #define USB_R3_P30_REF_SSP_EN                           BIT(13)
> +
> +#define USB_R4                                                 0x10
> +       #define USB_R4_P21_PORT_RESET_0                         BIT(0)
> +       #define USB_R4_P21_SLEEP_M0                             BIT(1)
> +       #define USB_R4_MEM_PD_MASK                              GENMASK(3, 2)
> +       #define USB_R4_P21_ONLY                                 BIT(4)
> +
> +#define USB_R5                                                 0x14
> +       #define USB_R5_ID_DIG_SYNC                              BIT(0)
> +       #define USB_R5_ID_DIG_REG                               BIT(1)
> +       #define USB_R5_ID_DIG_CFG_MASK                          GENMASK(3, 2)
> +       #define USB_R5_ID_DIG_EN_0                              BIT(4)
> +       #define USB_R5_ID_DIG_EN_1                              BIT(5)
> +       #define USB_R5_ID_DIG_CURR                              BIT(6)
> +       #define USB_R5_ID_DIG_IRQ                               BIT(7)
> +       #define USB_R5_ID_DIG_TH_MASK                           GENMASK(15, 8)
> +       #define USB_R5_ID_DIG_CNT_MASK                          GENMASK(23, 16)
> +
> +/* USB2 Ports Control Registers */
> +
> +#define U2P_R0                                                 0x0
> +       #define U2P_R0_HOST_DEVICE                              BIT(0)
> +       #define U2P_R0_POWER_OK                                 BIT(1)
> +       #define U2P_R0_HAST_MODE                                BIT(2)
> +       #define U2P_R0_POWER_ON_RESET                           BIT(3)
> +       #define U2P_R0_ID_PULLUP                                BIT(4)
> +       #define U2P_R0_DRV_VBUS                                 BIT(5)
> +
> +#define U2P_R1                                                 0x4
> +       #define U2P_R1_PHY_READY                                BIT(0)
> +       #define U2P_R1_ID_DIG                                   BIT(1)
> +       #define U2P_R1_OTG_SESSION_VALID                        BIT(2)
> +       #define U2P_R1_VBUS_VALID                               BIT(3)
> +
> +#define MAX_PHY                                                        5
> +
> +#define USB2_MAX_PHY                                           4
> +#define USB3_PHY                                               4
> +
> +struct dwc3_meson_g12a {
> +       struct device           *dev;
> +       struct regmap           *regmap;
> +       struct clk              *clk;
> +       struct reset_control    *reset;
> +       struct phy              *phys[5];
> +       enum usb_dr_mode        phy_modes[5];
use MAX_PHY instead of hardcoded 5 here

have you also considered moving the per-port values into a separate
struct struct dwc3_meson_g12a_port?
(I'll get back to this below)

> +       enum phy_mode           otg_phy_mode;
> +       unsigned int            usb2_ports;
> +       unsigned int            usb3_ports;
> +       struct dentry           *root;
> +};
> +
> +#define U2P_REG_SIZE                                           0x20
> +#define USB_REG_OFFSET                                         0x80
the USB_Rn registers are always accessed with USB_REG_OFFSET added to
their offset except in dwc3_meson_g12a_usb2_init.
can we add 0x80 to all USB_Rn #defines to avoid this?

> +
> +static void dwc3_meson_g12a_usb2_set_mode(struct dwc3_meson_g12a *priv,
> +                                         int i, enum usb_dr_mode mode)
> +{
> +       switch (mode) {
> +       case USB_DR_MODE_HOST:
> +       case USB_DR_MODE_OTG:
> +       case USB_DR_MODE_UNKNOWN:
> +               regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
> +                               U2P_R0_HOST_DEVICE,
> +                               U2P_R0_HOST_DEVICE);
have you considered creating a separate regmap for each USB2 PHY
configuration register space?
that separate regmap could also be part of the per-port struct
(dwc3_meson_g12a_port)
the result might look like this:
               regmap_update_bits(priv->ports[i].regmap, U2P_R0,
                               U2P_R0_HOST_DEVICE,
                               U2P_R0_HOST_DEVICE);

> +               break;
> +
> +       case USB_DR_MODE_PERIPHERAL:
> +               regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
> +                               U2P_R0_HOST_DEVICE, 0);
> +               break;
> +       }
> +}
> +
> +static int dwc3_meson_g12a_usb2_init(struct dwc3_meson_g12a *priv)
> +{
> +       enum usb_dr_mode id_mode;
> +       u32 val;
> +       int i;
> +
> +       /* Read ID current level */
> +       regmap_read(priv->regmap, USB_R5, &val);
do we need to add USB_REG_OFFSET to USB_R5 here or do we need to read
USB_R5 from the first USB2 PHY register space?
in case we need to express it as "USB_REG_OFFSET + USB_R5" then I have
two suggestions to avoid this kind of issues:
- either add 0x80 to all USB_Rn #defines and to remove USB_REG_OFFSET
- assuming you create a separate regmap for each USB2 PHY
configuration: have a separate regmap for the USB_Rn registers as well

> +       if (val & USB_R5_ID_DIG_CURR)
> +               id_mode = USB_DR_MODE_PERIPHERAL;
> +       else
> +               id_mode = USB_DR_MODE_HOST;
> +
> +       dev_info(priv->dev, "ID mode %s\n",
> +                id_mode ==  USB_DR_MODE_HOST ? "host" : "peripheral");
> +
> +       for (i = 0 ; i < USB2_MAX_PHY ; ++i) {
> +               if (!priv->phys[i])
> +                       continue;
> +
> +               regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
> +                                  U2P_R0_POWER_ON_RESET,
> +                                  U2P_R0_POWER_ON_RESET);
> +
> +               if (priv->phy_modes[i] == USB_DR_MODE_PERIPHERAL ||
> +                   (priv->phy_modes[i] == USB_DR_MODE_OTG &&
> +                    id_mode == USB_DR_MODE_PERIPHERAL)) {
> +                       dwc3_meson_g12a_usb2_set_mode(priv, i,
> +                                                     USB_DR_MODE_PERIPHERAL);
> +
> +                       if (priv->phy_modes[i] == USB_DR_MODE_OTG)
> +                               priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
> +               } else {
> +                       dwc3_meson_g12a_usb2_set_mode(priv, i,
> +                                                     USB_DR_MODE_HOST);
> +
> +                       if (priv->phy_modes[i] == USB_DR_MODE_OTG)
> +                               priv->otg_phy_mode = PHY_MODE_USB_HOST;
> +               }
> +
> +               regmap_update_bits(priv->regmap, U2P_R0 + (U2P_REG_SIZE * i),
> +                                  U2P_R0_POWER_ON_RESET, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +static void dwc3_meson_g12a_usb3_init(struct dwc3_meson_g12a *priv)
> +{
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R3,
> +                       USB_R3_P30_SSC_RANGE_MASK |
> +                       USB_R3_P30_REF_SSP_EN,
> +                       USB_R3_P30_SSC_ENABLE |
> +                       FIELD_PREP(USB_R3_P30_SSC_RANGE_MASK, 2) |
> +                       USB_R3_P30_REF_SSP_EN);
> +       udelay(2);
> +
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R2,
> +                       USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK,
> +                       FIELD_PREP(USB_R2_P30_PCS_TX_DEEMPH_3P5DB_MASK, 0x15));
> +
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R2,
> +                       USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK,
> +                       FIELD_PREP(USB_R2_P30_PCS_TX_DEEMPH_6DB_MASK, 0x20));
> +
> +       udelay(2);
> +
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R1,
> +                       USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT,
> +                       USB_R1_U3H_HOST_PORT_POWER_CONTROL_PRESENT);
> +
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R1,
> +                       USB_R1_P30_PCS_TX_SWING_FULL_MASK,
> +                       FIELD_PREP(USB_R1_P30_PCS_TX_SWING_FULL_MASK, 127));
> +}
> +
> +static void dwc3_meson_g12a_usb_init_mode(struct dwc3_meson_g12a *priv,
> +                                         bool is_peripheral)
can you please make this consistent with dwc3_meson_g12a_usb2_set_mode
which takes enum usb_dr_mode instead of a bool?

also while reading the code the naming of
dwc3_meson_g12a_usb2_set_mode and dwc3_meson_g12a_usb_init_mode
confused me.
in retrospect dwc3_meson_g12a_usb2_set_mode seems good enough because
it indicates that it sets the mode for one one the USB2 ports (or
PHYs).
dwc3_meson_g12a_usb_init_mode however is not only used for
initialization but also for forcing the mode at runtime. I don't have
any suggestion for a better name yet

> +{
> +       if (is_peripheral) {
> +               regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R0,
> +                               USB_R0_U2D_ACT, USB_R0_U2D_ACT);
> +               regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R0,
> +                               USB_R0_U2D_SS_SCALEDOWN_MODE_MASK, 0);
> +               regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R4,
> +                               USB_R4_P21_SLEEP_M0, USB_R4_P21_SLEEP_M0);
> +       } else {
> +               regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R0,
> +                               USB_R0_U2D_ACT, 0);
> +               regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R4,
> +                               USB_R4_P21_SLEEP_M0, 0);
> +       }
> +}
> +
> +static int dwc3_meson_g12a_usb_init(struct dwc3_meson_g12a *priv)
> +{
> +       int ret;
> +
> +       ret = dwc3_meson_g12a_usb2_init(priv);
> +       if (ret)
> +               return ret;
> +
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R1,
> +                       USB_R1_U3H_FLADJ_30MHZ_REG_MASK,
> +                       FIELD_PREP(USB_R1_U3H_FLADJ_30MHZ_REG_MASK, 0x20));
> +
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R5,
> +                       USB_R5_ID_DIG_EN_0,
> +                       USB_R5_ID_DIG_EN_0);
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R5,
> +                       USB_R5_ID_DIG_EN_1,
> +                       USB_R5_ID_DIG_EN_1);
> +       regmap_update_bits(priv->regmap, USB_REG_OFFSET + USB_R5,
> +                       USB_R5_ID_DIG_TH_MASK,
> +                       FIELD_PREP(USB_R5_ID_DIG_TH_MASK, 0xff));
> +
> +       /* If we have an actual SuperSpeed port, initialize it */
> +       if (priv->usb3_ports)
> +               dwc3_meson_g12a_usb3_init(priv);
> +
> +       dwc3_meson_g12a_usb_init_mode(priv,
> +                               (priv->otg_phy_mode == PHY_MODE_USB_DEVICE));
> +
> +       return 0;
> +}
> +
> +static const struct regmap_config phy_meson_g12a_usb3_regmap_conf = {
> +       .reg_bits = 8,
> +       .val_bits = 32,
> +       .reg_stride = 4,
> +       .max_register = USB_REG_OFFSET + USB_R5,
> +};
> +
> +static int dwc3_meson_g12a_get_phys(struct dwc3_meson_g12a *priv)
> +{
> +       struct device_node *port, *phy_node;
> +       struct of_phandle_args args;
> +       enum usb_dr_mode mode;
> +       const char *dr_mode;
> +       struct phy *phy;
> +       int ret, i;
> +
> +       for (i = 0 ; i < MAX_PHY ; ++i) {
> +               port = of_graph_get_port_by_id(priv->dev->of_node, i);
> +
> +               /* Ignore port if not defined or disabled */
> +               if (!of_device_is_available(port)) {
> +                       of_node_put(port);
> +                       continue;
> +               }
> +
> +               /* Get associated PHY */
> +               phy = of_phy_get(port, NULL);
> +               if (IS_ERR(phy)) {
> +                       of_node_put(port);
> +                       ret = PTR_ERR(phy);
> +                       goto err_phy_get;
> +               }
> +
> +               of_node_put(port);
> +
> +               /* Get phy dr_mode */
> +               ret = of_parse_phandle_with_args(port, "phys", "#phy-cells",
> +                                                0, &args);
> +               if (ret) {
> +                       of_node_put(port);
> +                       goto err_phy_get;
> +               }
> +
> +               phy_node = args.np;
> +
> +               ret = of_property_read_string(phy_node, "dr_mode", &dr_mode);
> +               if (ret) {
> +                       dr_mode = "unknown";
> +                       mode = USB_DR_MODE_UNKNOWN;
> +               } else {
> +                       if (!strcmp(dr_mode, "host"))
> +                               mode = USB_DR_MODE_HOST;
> +                       else if (!strcmp(dr_mode, "otg"))
> +                               mode = USB_DR_MODE_OTG;
> +                       else if (!strcmp(dr_mode, "peripheral"))
> +                               mode = USB_DR_MODE_PERIPHERAL;
> +                       else {
> +                               mode = USB_DR_MODE_UNKNOWN;
> +                               dr_mode = "unknown";
> +                       }
> +               }
> +
> +               dev_info(priv->dev, "port%d: %s mode %s\n",
> +                        i, of_node_full_name(phy_node), dr_mode);
> +
> +               of_node_put(phy_node);
> +
> +               priv->phy_modes[i] = mode;
> +               priv->phys[i] = phy;
> +
> +               if (i == USB3_PHY)
> +                       priv->usb3_ports++;
> +               else
> +                       priv->usb2_ports++;
> +       }
> +
> +       dev_info(priv->dev, "usb2 ports: %d\n", priv->usb2_ports);
> +       dev_info(priv->dev, "usb3 ports: %d\n", priv->usb3_ports);
nit-pick: USB2 and USB3 (instead of the lower-case variants)?

> +
> +       return 0;
> +
> +err_phy_get:
> +       for (i = 0 ; i < MAX_PHY ; ++i)
> +               if (priv->phys[i])
phy_put is NULL-safe, so you can drop this check

> +                       phy_put(priv->phys[i]);
> +
> +       return ret;
> +}
> +
> +static int dwc3_meson_g12a_mode_force_get(void *data, u64 *val)
> +{
> +       struct dwc3_meson_g12a *priv = data;
> +
> +       if (priv->otg_phy_mode == PHY_MODE_USB_HOST)
> +               *val = 1;
> +       else if (priv->otg_phy_mode == PHY_MODE_USB_DEVICE)
> +               *val = 0;
> +       else
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static int dwc3_meson_g12a_mode_force_set(void *data, u64 val)
> +{
> +       struct dwc3_meson_g12a *priv = data;
> +       int i;
> +
> +       if ((val && priv->otg_phy_mode == PHY_MODE_USB_HOST) ||
> +           (!val && priv->otg_phy_mode == PHY_MODE_USB_DEVICE))
> +               return 0;
> +
> +       for (i = 0 ; i < USB2_MAX_PHY ; ++i) {
> +               if (!priv->phys[i])
> +                       continue;
> +
> +               if (priv->phy_modes[i] != USB_DR_MODE_OTG)
> +                       continue;
> +
> +               if (val) {
> +                       dev_info(priv->dev, "switching to Host Mode\n");
> +
> +                       dwc3_meson_g12a_usb2_set_mode(priv, i,
> +                                                     USB_DR_MODE_HOST);
> +
> +                       dwc3_meson_g12a_usb_init_mode(priv, false);
> +
> +                       priv->otg_phy_mode = PHY_MODE_USB_HOST;
> +               } else {
> +                       dev_info(priv->dev, "switching to Device Mode\n");
> +
> +                       dwc3_meson_g12a_usb2_set_mode(priv, i,
> +                                                     USB_DR_MODE_PERIPHERAL);
> +
> +                       dwc3_meson_g12a_usb_init_mode(priv, true);
> +
> +                       priv->otg_phy_mode = PHY_MODE_USB_DEVICE;
> +               }
> +
> +               return phy_set_mode(priv->phys[i], priv->otg_phy_mode);
none of the G12A USB PHY drivers implements phy_ops.set_mode. do you
plan to change that? if not: what's the purpose of calling
phy_set_mode?

> +       }
> +
> +       return -EINVAL;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(dwc3_meson_g12a_mode_force_fops,
> +                        dwc3_meson_g12a_mode_force_get,
> +                        dwc3_meson_g12a_mode_force_set, "%llu\n");
> +
> +static int dwc3_meson_g12a_otg_id_get(void *data, u64 *val)
> +{
> +       struct dwc3_meson_g12a *priv = data;
> +       u32 reg;
> +
> +       regmap_read(priv->regmap, USB_R5, &reg);
> +
> +       *val = (reg & USB_R5_ID_DIG_CURR);
"mode_force" returns 0 or 1 while this returns either 0 or 0x40 (bit 6).
can you please express it as "!!(reg & USB_R5_ID_DIG_CURR)" to make
"otg_id" also return 0 or 1?

> +
> +       return 0;
> +}
> +
> +DEFINE_DEBUGFS_ATTRIBUTE(dwc3_meson_g12a_otg_id_fops,
> +                        dwc3_meson_g12a_otg_id_get, NULL, "%llu\n");
> +
> +/* We provide a DebugFS interface to get the ID value and force OTG switch */
at first I was curious if having one debugfs attribute for the whole
USBCTL registers is enough.
my thought was that we may have to expose one attribute per port for
example if G12A uses port 1 for OTG, but G12B uses port 2 (this is a
theoretical case, I have no documentation that this will happen).
only later I noticed that the code already supports this by looking up
the PHY with USB_DR_MODE_OTG set.
so a single attribute (together with the dr_mode configuration in the
.dts) covers our requirements.

> +static int dwc3_meson_g12a_debugfs_init(struct dwc3_meson_g12a *priv)
> +{
> +       priv->root = debugfs_create_dir("dwc3-meson-g12a", NULL);
> +       if (IS_ERR(priv->root))
> +               return PTR_ERR(priv->root);
> +
> +       debugfs_create_file("mode_force", 0600, priv->root, priv,
> +                           &dwc3_meson_g12a_mode_force_fops);
> +
> +       debugfs_create_file("otg_id", 0400, priv->root, priv,
> +                           &dwc3_meson_g12a_otg_id_fops);
> +
> +       return 0;
> +}
> +
> +static int dwc3_meson_g12a_probe(struct platform_device *pdev)
> +{
> +       struct dwc3_meson_g12a  *priv;
> +       struct device           *dev = &pdev->dev;
> +       struct device_node      *np = dev->of_node;
> +       void __iomem *base;
> +       struct resource *res;
> +       int ret, i;
> +
> +       priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> +       if (!priv)
> +               return -ENOMEM;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       base = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(base))
> +               return PTR_ERR(base);
> +
> +       priv->regmap = devm_regmap_init_mmio(dev, base,
> +                                            &phy_meson_g12a_usb3_regmap_conf);
> +       if (IS_ERR(priv->regmap))
> +               return PTR_ERR(priv->regmap);
> +
> +       priv->clk = devm_clk_get(dev, "usb");
> +       if (IS_ERR(priv->clk))
> +               return PTR_ERR(priv->clk);
> +
> +       ret = clk_prepare_enable(priv->clk);
> +       if (ret)
> +               return ret;
> +
> +       platform_set_drvdata(pdev, priv);
> +       priv->dev = dev;
> +
> +       priv->reset = devm_reset_control_get(dev, "usb");
> +       if (IS_ERR(priv->reset)) {
> +               ret = PTR_ERR(priv->reset);
> +               dev_err(dev, "failed to get device reset, err=%d\n", ret);
> +               return ret;
> +       }
> +
> +       ret = reset_control_reset(priv->reset);
> +       if (ret)
> +               return ret;
> +
> +       ret = dwc3_meson_g12a_get_phys(priv);
> +       if (ret)
> +               return ret;
> +
> +       dwc3_meson_g12a_usb_init(priv);
> +
> +       /* Init PHYs */
> +       for (i = 0 ; i < MAX_PHY ; ++i) {
> +               if (priv->phys[i]) {
> +                       ret = phy_init(priv->phys[i]);
> +                       if (ret)
> +                               goto err_phys_put;
> +               }
> +       }
> +
> +       /* Set OTG PHY mode */
none of this PHY drivers implements phy_ops.set_mode.
dwc3_meson_g12a_usb_init() above should have taken care of
initializing the mode already if I understand the code correctly
can you please check if the following block is needed:
> +       for (i = 0 ; i < MAX_PHY ; ++i) {
> +               if (priv->phys[i] && priv->phy_modes[i] == USB_DR_MODE_OTG) {
> +                       ret = phy_set_mode(priv->phys[i], priv->otg_phy_mode);
> +                       if (ret)
> +                               goto err_phys_put;
> +               }
> +       }
> +
> +       ret = of_platform_populate(np, NULL, NULL, dev);
> +       if (ret) {
> +               clk_disable_unprepare(priv->clk);
> +               clk_put(priv->clk);
> +
> +               goto err_phys_exit;
> +       }
> +
> +       pm_runtime_set_active(dev);
> +       pm_runtime_enable(dev);
> +       pm_runtime_get_sync(dev);
> +
> +       if (dwc3_meson_g12a_debugfs_init(priv))
> +               dev_dbg(dev, "Failed to add DebugFS interface\n");
> +
> +       return 0;
> +
> +err_phys_exit:
> +       for (i = 0 ; i < MAX_PHY ; ++i)
> +               if (priv->phys[i])
phy_exit is NULL-safe, so you can drop this check

> +                       phy_exit(priv->phys[i]);
> +
> +err_phys_put:
> +       for (i = 0 ; i < MAX_PHY ; ++i)
> +               if (priv->phys[i])
phy_put is NULL-safe so you can drop this check

> +                       phy_put(priv->phys[i]);
> +
> +       return ret;
> +}
> +
> +static int dwc3_meson_g12a_remove(struct platform_device *pdev)
> +{
> +       struct dwc3_meson_g12a *priv = platform_get_drvdata(pdev);
> +       struct device *dev = &pdev->dev;
> +       int i;
> +
> +       debugfs_remove_recursive(priv->root);
> +
> +       of_platform_depopulate(dev);
> +
> +       for (i = 0 ; i < MAX_PHY ; ++i)
> +               if (priv->phys[i])
phy_exit is NULL-safe, so you can drop this check

> +                       phy_exit(priv->phys[i]);
> +
> +       for (i = 0 ; i < MAX_PHY ; ++i)
> +               if (priv->phys[i])
phy_put is NULL-safe, so you can drop this check

> +                       phy_put(priv->phys[i]);
> +
> +       clk_disable_unprepare(priv->clk);
> +       clk_put(priv->clk);
the clock is obtained with devm_clk_get - doesn't that automatically
call clk_put upon removal?

> +
> +       pm_runtime_disable(dev);
> +       pm_runtime_put_noidle(dev);
> +       pm_runtime_set_suspended(dev);
(I'm new to the runtime PM logic, so the following questions might not
make sense)
will this also call dwc3_meson_g12a_runtime_suspend (defined below)?
if so: how do we ensure that we don't call clk_disable if we already
called clk_disable_unprepare?

> +       return 0;
> +}
> +
> +static int __maybe_unused dwc3_meson_g12a_runtime_suspend(struct device *dev)
> +{
> +       struct dwc3_meson_g12a  *priv = dev_get_drvdata(dev);
> +
> +       clk_disable(priv->clk);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused dwc3_meson_g12a_runtime_resume(struct device *dev)
> +{
> +       struct dwc3_meson_g12a  *priv = dev_get_drvdata(dev);
> +
> +       return clk_enable(priv->clk);
> +}
> +
> +static int __maybe_unused dwc3_meson_g12a_suspend(struct device *dev)
> +{
> +       struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> +       int i;
> +
> +       for (i = 0 ; i < MAX_PHY ; ++i)
> +               if (priv->phys[i])
phy_exit is NULL-safe, so you can drop this check

> +                       phy_exit(priv->phys[i]);
> +
> +       reset_control_assert(priv->reset);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused dwc3_meson_g12a_resume(struct device *dev)
> +{
> +       struct dwc3_meson_g12a *priv = dev_get_drvdata(dev);
> +       int i, ret;
> +
> +       reset_control_deassert(priv->reset);
> +
> +       dwc3_meson_g12a_usb_init(priv);
> +
> +       /* Init PHYs */
> +       for (i = 0 ; i < MAX_PHY ; ++i) {
> +               if (priv->phys[i]) {
phy_init is NULL-safe, so you can drop this check
> +                       ret = phy_init(priv->phys[i]);
> +                       if (ret)
> +                               return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops dwc3_meson_g12a_dev_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(dwc3_meson_g12a_suspend, dwc3_meson_g12a_resume)
> +       SET_RUNTIME_PM_OPS(dwc3_meson_g12a_runtime_suspend,
> +                       dwc3_meson_g12a_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id dwc3_meson_g12a_match[] = {
> +       { .compatible = "amlogic,meson-g12a-usb-ctrl" },
> +       { /* Sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, dwc3_meson_g12a_match);
> +
> +static struct platform_driver dwc3_meson_g12a_driver = {
> +       .probe          = dwc3_meson_g12a_probe,
> +       .remove         = dwc3_meson_g12a_remove,
> +       .driver         = {
> +               .name   = "dwc3-meson-g12a",
> +               .of_match_table = dwc3_meson_g12a_match,
> +               .pm     = &dwc3_meson_g12a_dev_pm_ops,
> +       },
> +};
> +
> +module_platform_driver(dwc3_meson_g12a_driver);
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("Amlogic Meson G12A USB Glue Layer");
> +MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
> --
> 2.20.1
>
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic


Regards

Martin
