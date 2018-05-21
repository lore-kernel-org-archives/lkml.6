Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeEUNul (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 09:50:41 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:38219 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752862AbeEUNue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 09:50:34 -0400
X-Google-Smtp-Source: AB8JxZoUlzxKmFr1VSZgb3IhLtC+jtstajPgZkTPDbrMQ3VBiSBQy7wGUwQy5j5VaVdfhuyznmLb4ZvLVuDaeKol7jE=
MIME-Version: 1.0
In-Reply-To: <1526895424-22894-3-git-send-email-hl@rock-chips.com>
References: <1526895424-22894-1-git-send-email-hl@rock-chips.com> <1526895424-22894-3-git-send-email-hl@rock-chips.com>
From: Enric Balletbo Serra <eballetbo@gmail.com>
Date: Mon, 21 May 2018 15:50:32 +0200
Message-ID: <CAFqH_51DrUQh24XWJ2=MAi8EiGCdiK3dKTV_YexRJawJHN7H0A@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] soc: rockchip: split rockchip_typec_phy struct to
 separate header
To: Lin Huang <hl@rock-chips.com>
Cc: Sean Paul <seanpaul@chromium.org>, David Airlie <airlied@linux.ie>,
        Chris Zhong <zyw@rock-chips.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Doug Anderson <dianders@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        daniel.vetter@intel.com, jani.nikula@linux.intel.com,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lin,

2018-05-21 11:37 GMT+02:00 Lin Huang <hl@rock-chips.com>:
> we may use rockchip_phy_typec struct in other driver, so split
> it to separate header.
>

That patch does more than just split some structs to a public header,
it also introduces new structs and new parameters related to the
phy_config feature. IMHO you should first move the current structs and
introduce the new phy_config stuff in the following patch (4/5). I am
not sure about the maintainer preferences, but at least, if the
maintainer is fine like is now, I'd explain that you introduce new
elements in the commit message.

Best regards,
 Enric

> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v2:
> - None
> Changes in v3:
> - None
> Changes in v4:
> - None
> Changes in v5:
> - None
> Changes in v6:
> - new patch here
>
>  drivers/phy/rockchip/phy-rockchip-typec.c | 47 +----------------------
>  include/soc/rockchip/rockchip_phy_typec.h | 63 +++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+), 46 deletions(-)
>  create mode 100644 include/soc/rockchip/rockchip_phy_typec.h
>
> diff --git a/drivers/phy/rockchip/phy-rockchip-typec.c b/drivers/phy/rockchip/phy-rockchip-typec.c
> index 76a4b58..795055f 100644
> --- a/drivers/phy/rockchip/phy-rockchip-typec.c
> +++ b/drivers/phy/rockchip/phy-rockchip-typec.c
> @@ -63,6 +63,7 @@
>
>  #include <linux/mfd/syscon.h>
>  #include <linux/phy/phy.h>
> +#include <soc/rockchip/rockchip_phy_typec.h>
>
>  #define CMN_SSM_BANDGAP                        (0x21 << 2)
>  #define CMN_SSM_BIAS                   (0x22 << 2)
> @@ -349,52 +350,6 @@
>  #define MODE_DFP_USB                   BIT(1)
>  #define MODE_DFP_DP                    BIT(2)
>
> -struct usb3phy_reg {
> -       u32 offset;
> -       u32 enable_bit;
> -       u32 write_enable;
> -};
> -
> -/**
> - * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
> - * @reg: the base address for usb3-phy config.
> - * @typec_conn_dir: the register of type-c connector direction.
> - * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
> - * @external_psm: the register of type-c phy external psm clock.
> - * @pipe_status: the register of type-c phy pipe status.
> - * @usb3_host_disable: the register of type-c usb3 host disable.
> - * @usb3_host_port: the register of type-c usb3 host port.
> - * @uphy_dp_sel: the register of type-c phy DP select control.
> - */
> -struct rockchip_usb3phy_port_cfg {
> -       unsigned int reg;
> -       struct usb3phy_reg typec_conn_dir;
> -       struct usb3phy_reg usb3tousb2_en;
> -       struct usb3phy_reg external_psm;
> -       struct usb3phy_reg pipe_status;
> -       struct usb3phy_reg usb3_host_disable;
> -       struct usb3phy_reg usb3_host_port;
> -       struct usb3phy_reg uphy_dp_sel;
> -};
> -
> -struct rockchip_typec_phy {
> -       struct device *dev;
> -       void __iomem *base;
> -       struct extcon_dev *extcon;
> -       struct regmap *grf_regs;
> -       struct clk *clk_core;
> -       struct clk *clk_ref;
> -       struct reset_control *uphy_rst;
> -       struct reset_control *pipe_rst;
> -       struct reset_control *tcphy_rst;
> -       const struct rockchip_usb3phy_port_cfg *port_cfgs;
> -       /* mutex to protect access to individual PHYs */
> -       struct mutex lock;
> -
> -       bool flip;
> -       u8 mode;
> -};
> -
>  struct phy_reg {
>         u16 value;
>         u32 addr;
> diff --git a/include/soc/rockchip/rockchip_phy_typec.h b/include/soc/rockchip/rockchip_phy_typec.h
> new file mode 100644
> index 0000000..be6af0e
> --- /dev/null
> +++ b/include/soc/rockchip/rockchip_phy_typec.h
> @@ -0,0 +1,63 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#ifndef __SOC_ROCKCHIP_PHY_TYPEC_H
> +#define __SOC_ROCKCHIP_PHY_TYPEC_H
> +
> +struct usb3phy_reg {
> +       u32 offset;
> +       u32 enable_bit;
> +       u32 write_enable;
> +};
> +
> +/**
> + * struct rockchip_usb3phy_port_cfg: usb3-phy port configuration.
> + * @reg: the base address for usb3-phy config.
> + * @typec_conn_dir: the register of type-c connector direction.
> + * @usb3tousb2_en: the register of type-c force usb2 to usb2 enable.
> + * @external_psm: the register of type-c phy external psm clock.
> + * @pipe_status: the register of type-c phy pipe status.
> + * @usb3_host_disable: the register of type-c usb3 host disable.
> + * @usb3_host_port: the register of type-c usb3 host port.
> + * @uphy_dp_sel: the register of type-c phy DP select control.
> + */
> +struct rockchip_usb3phy_port_cfg {
> +       unsigned int reg;
> +       struct usb3phy_reg typec_conn_dir;
> +       struct usb3phy_reg usb3tousb2_en;
> +       struct usb3phy_reg external_psm;
> +       struct usb3phy_reg pipe_status;
> +       struct usb3phy_reg usb3_host_disable;
> +       struct usb3phy_reg usb3_host_port;
> +       struct usb3phy_reg uphy_dp_sel;
> +};
> +
> +struct phy_config {
> +       int swing;
> +       int pe;
> +};
> +
> +struct rockchip_typec_phy {
> +       struct device *dev;
> +       void __iomem *base;
> +       struct extcon_dev *extcon;
> +       struct regmap *grf_regs;
> +       struct clk *clk_core;
> +       struct clk *clk_ref;
> +       struct reset_control *uphy_rst;
> +       struct reset_control *pipe_rst;
> +       struct reset_control *tcphy_rst;
> +       const struct rockchip_usb3phy_port_cfg *port_cfgs;
> +       /* mutex to protect access to individual PHYs */
> +       struct mutex lock;
> +       struct phy_config config[3][4];
> +       bool flip;
> +       u8 mode;
> +       int (*typec_phy_config)(struct phy *phy, int link_rate,
> +                               int lanes, u8 swing, u8 pre_emp);
> +};
> +
> +#endif
> --
> 2.7.4
>
