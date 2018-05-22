Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeEVWvq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 18:51:46 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39650 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753036AbeEVWvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 18:51:43 -0400
X-Google-Smtp-Source: AB8JxZoexllH4yeO7cNUEeR5n/B/2viHV2Cs0Be6mFuZkgtG3mfLZyDvXR103XoS1JJzndVkBbmXMg==
Date: Tue, 22 May 2018 17:51:40 -0500
From: Rob Herring <robh@kernel.org>
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Will Deacon <will.deacon@arm.com>, Heiko Stuebner <heiko@sntech.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Sandy Huang <hjc@rock-chips.com>,
        David Airlie <airlied@linux.ie>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Derek Basehore <dbasehore@chromium.org>,
        linux-clk@vger.kernel.org, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Lin Huang <hl@rock-chips.com>,
        kernel@collabora.com, Sean Paul <seanpaul@chromium.org>,
        linux-arm-kernel@lists.infradead.org,
        Nickey Yang <nickey.yang@rock-chips.com>, devicetree@vger.kernel.org,
        Yakir Yang <kuankuan.y@gmail.com>, Mark Yao <markyao0591@gmail.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Brian Norris <briannorris@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Douglas Anderson <dianders@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Caesar Wang <wxt@rock-chips.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RFC PATCH 09/10] arm64: dts: rk3399: Add dfi and dmc nodes.
Message-ID: <20180522225140.GA30149@rob-hp-laptop>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-10-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514211610.26618-10-enric.balletbo@collabora.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 11:16:09PM +0200, Enric Balletbo i Serra wrote:
> From: Lin Huang <hl@rock-chips.com>
> 
> These are required to support DDR DVFS on rk3399 platform. The patch also
> introduces two new files (rk3399-dram.h and rk3399-dram-default-timing)
> with default DRAM settings.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  .../rockchip/rk3399-dram-default-timing.dtsi  | 38 ++++++++++
>  arch/arm64/boot/dts/rockchip/rk3399-dram.h    | 73 +++++++++++++++++++
>  .../boot/dts/rockchip/rk3399-op1-opp.dtsi     | 29 ++++++++
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      | 20 +++++
>  4 files changed, 160 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-dram.h
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
> new file mode 100644
> index 000000000000..4dfe3e1d8bdf
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-dram-default-timing.dtsi
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR X11)
> +/*
> + * Copyright (c) 2016-2018, Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Author: Lin Huang <hl@rock-chips.com>
> + */
> +
> +#include "rk3399-dram.h"
> +
> +rockchip,ddr3_speed_bin = <21>;
> +rockchip,pd_idle = <0x40>;
> +rockchip,sr_idle = <0x2>;

Don't do includes this way please. These should go under a node.

> +rockchip,sr_mc_gate_idle = <0x3>;
> +rockchip,srpd_lite_idle	= <0x4>;
> +rockchip,standby_idle = <0x2000>;
> +rockchip,dram_dll_dis_freq = <300000000>;
> +rockchip,phy_dll_dis_freq = <125000000>;
> +rockchip,auto_pd_dis_freq = <666000000>;
> +rockchip,ddr3_odt_dis_freq = <333000000>;
> +rockchip,ddr3_drv = <DDR3_DS_40ohm>;
> +rockchip,ddr3_odt = <DDR3_ODT_120ohm>;
> +rockchip,phy_ddr3_ca_drv = <PHY_DRV_ODT_40>;
> +rockchip,phy_ddr3_dq_drv = <PHY_DRV_ODT_40>;
> +rockchip,phy_ddr3_odt = <PHY_DRV_ODT_240>;
> +rockchip,lpddr3_odt_dis_freq = <333000000>;
> +rockchip,lpddr3_drv = <LP3_DS_34ohm>;
> +rockchip,lpddr3_odt = <LP3_ODT_240ohm>;
> +rockchip,phy_lpddr3_ca_drv = <PHY_DRV_ODT_40>;
> +rockchip,phy_lpddr3_dq_drv = <PHY_DRV_ODT_40>;
> +rockchip,phy_lpddr3_odt = <PHY_DRV_ODT_240>;
> +rockchip,lpddr4_odt_dis_freq = <333000000>;
> +rockchip,lpddr4_drv = <LP4_PDDS_60ohm>;
> +rockchip,lpddr4_dq_odt = <LP4_DQ_ODT_40ohm>;
> +rockchip,lpddr4_ca_odt = <LP4_CA_ODT_40ohm>;
> +rockchip,phy_lpddr4_ca_drv = <PHY_DRV_ODT_40>;
> +rockchip,phy_lpddr4_ck_cs_drv = <PHY_DRV_ODT_80>;
> +rockchip,phy_lpddr4_dq_drv = <PHY_DRV_ODT_80>;
> +rockchip,phy_lpddr4_odt = <PHY_DRV_ODT_60>;
