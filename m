Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C67C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D80F208E1
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 05:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S0eyc+Z8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D80F208E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754409AbeGIF1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 01:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751159AbeGIF06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 01:26:58 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5B7F208DB;
        Mon,  9 Jul 2018 05:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531114017;
        bh=cBwWuoYVDlaPxU09buaBBke7EoBt7O9MuM5YLdq4W9E=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=S0eyc+Z8gXPW17e0jWRdnRvaGlSXHnc9GQ68lwqE6H0eMVsokuEnZkaN7SB2wzx0p
         zsN1wtVMxORPm6976fYxBSXxgY6ok2qJACwbot008tpmXgNjs4HyBR3KGF93hDM8Hw
         vY5UYo1m3VQNqsGEz/T8dL2I8Qo5Owvhe2X6KFAo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jolly Shah <jolly.shah@xilinx.com>, ard.biesheuvel@linaro.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        hkallweit1@gmail.com, keescook@chromium.org,
        linux-clk@vger.kernel.org, mark.rutland@arm.com,
        matt@codeblueprint.co.uk, michal.simek@xilinx.com,
        mingo@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        sboyd@codeaurora.org, sudeep.holla@arm.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529516435-7315-11-git-send-email-jollys@xilinx.com>
Cc:     rajanv@xilinx.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jolly Shah <jolly.shah@xilinx.com>,
        Tejas Patel <tejasp@xilinx.com>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1529516435-7315-1-git-send-email-jollys@xilinx.com>
 <1529516435-7315-11-git-send-email-jollys@xilinx.com>
Message-ID: <153111401693.143105.16925315512459949259@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v9 10/10] drivers: clk: Add ZynqMP clock driver
Date:   Sun, 08 Jul 2018 22:26:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jolly Shah (2018-06-20 10:40:35)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 98ce9fc..a2ebcf7 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -252,6 +252,7 @@ source "drivers/clk/sprd/Kconfig"
>  source "drivers/clk/sunxi-ng/Kconfig"
>  source "drivers/clk/tegra/Kconfig"
>  source "drivers/clk/ti/Kconfig"
> +source "drivers/clk/zynqmp/Kconfig"
>  source "drivers/clk/uniphier/Kconfig"

z comes after u, this is wrong.

>  =

>  endmenu
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 71ec41e..b6ac0d2 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -100,3 +100,4 @@ obj-$(CONFIG_X86)                   +=3D x86/
>  endif
>  obj-$(CONFIG_ARCH_ZX)                  +=3D zte/
>  obj-$(CONFIG_ARCH_ZYNQ)                        +=3D zynq/
> +obj-$(CONFIG_COMMON_CLK_ZYNQMP)         +=3D zynqmp/
> diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
> new file mode 100644
> index 0000000..0f8986c
> --- /dev/null
> +++ b/drivers/clk/zynqmp/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +config COMMON_CLK_ZYNQMP
> +       bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
> +       depends on OF

What relies on OF that isn't stubbed out when OF=3Dn? =


> +       depends on ARCH_ZYNQMP || COMPILE_TEST
> +       depends on ZYNQMP_FIRMWARE
> +       help
> +         Support for the Zynqmp Ultrascale clock controller.
> +         It has a dependency on the PMU firmware.
> +         Say Y if you want to include clock support.
> diff --git a/drivers/clk/zynqmp/clk-gate-zynqmp.c b/drivers/clk/zynqmp/cl=
k-gate-zynqmp.c
> new file mode 100644
> index 0000000..b927eb1
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clk-gate-zynqmp.c
> @@ -0,0 +1,146 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq UltraScale+ MPSoC clock controller
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + *
> + * Gated clock implementation
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include "clk-zynqmp.h"
> +
> +/**
> + * struct clk_gate - gating clock
> + * @hw:                handle between common and hardware-specific inter=
faces
> + * @flags:     hardware-specific flags
> + * @clk_id:    Id of clock
> + */
> +struct zynqmp_clk_gate {
> +       struct clk_hw hw;
> +       u8 flags;
> +       u32 clk_id;
> +};
> +
> +#define to_zynqmp_clk_gate(_hw) container_of(_hw, struct zynqmp_clk_gate=
, hw)
> +
> +/**
> + * zynqmp_clk_gate_enable() - Enable clock
> + * @hw:                handle between common and hardware-specific inter=
faces
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_clk_gate_enable(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_gate *gate =3D to_zynqmp_clk_gate(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D gate->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_enable(clk_id);
> +
> +       if (ret)
> +               pr_warn_once("%s() clock enabled failed for %s, ret =3D %=
d\n",
> +                            __func__, clk_name, ret);
> +
> +       return ret;
> +}
> +
> +/*
> + * zynqmp_clk_gate_disable() - Disable clock
> + * @hw:                handle between common and hardware-specific inter=
faces
> + */
> +static void zynqmp_clk_gate_disable(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_gate *gate =3D to_zynqmp_clk_gate(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D gate->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_disable(clk_id);
> +
> +       if (ret)
> +               pr_warn_once("%s() clock disable failed for %s, ret =3D %=
d\n",
> +                            __func__, clk_name, ret);
> +}
> +
> +/**
> + * zynqmp_clk_gate_is_enable() - Check clock state
> + * @hw:                handle between common and hardware-specific inter=
faces
> + *
> + * Return: 1 if enabled, 0 if disabled else error code
> + */
> +static int zynqmp_clk_gate_is_enabled(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_gate *gate =3D to_zynqmp_clk_gate(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D gate->clk_id;
> +       int state, ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_getstate(clk_id, &state);
> +       if (ret) {
> +               pr_warn_once("%s() clock get state failed for %s, ret =3D=
 %d\n",
> +                            __func__, clk_name, ret);
> +               return -EIO;
> +       }
> +
> +       return state ? 1 : 0;
> +}
> +
> +const struct clk_ops zynqmp_clk_gate_ops =3D {

static?

> +       .enable =3D zynqmp_clk_gate_enable,
> +       .disable =3D zynqmp_clk_gate_disable,
> +       .is_enabled =3D zynqmp_clk_gate_is_enabled,
> +};
> +EXPORT_SYMBOL_GPL(zynqmp_clk_gate_ops);
> +

Or why is it exported?

> +/**
> + * zynqmp_clk_register_gate() - register a gate clock with the clock fra=
mework
> + * @dev:               device that is registering this clock
> + * @name:              name of this clock
> + * @clk_id:            Id of this clock
> + * @parent:            name of this clock's parent
> + * @flags:             framework-specific flags for this clock
> + * @clk_gate_flags:    gate-specific flags for this clock
> + *
> + * Return: clock hardware of the registered clock gate
> + */
> +struct clk_hw *zynqmp_clk_register_gate(struct device *dev, const char *=
name,
> +                                       u32 clk_id, const char *parent,
> +                                       unsigned long flags,
> +                                       u8 clk_gate_flags)
> +{
> +       struct zynqmp_clk_gate *gate;
> +       struct clk_hw *hw;
> +       int ret;
> +       struct clk_init_data init;
> +
> +       /* allocate the gate */
> +       gate =3D kzalloc(sizeof(*gate), GFP_KERNEL);
> +       if (!gate)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       init.ops =3D &zynqmp_clk_gate_ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D &parent;
> +       init.num_parents =3D 1;
> +
> +       /* struct clk_gate assignments */
> +       gate->flags =3D clk_gate_flags;
> +       gate->hw.init =3D &init;
> +       gate->clk_id =3D clk_id;
> +
> +       hw =3D &gate->hw;
> +       ret =3D clk_hw_register(dev, hw);

But dev is always NULL? Seems to be a lot of copy/paste going on.

> +       if (ret) {
> +               kfree(gate);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> diff --git a/drivers/clk/zynqmp/clk-mux-zynqmp.c b/drivers/clk/zynqmp/clk=
-mux-zynqmp.c
> new file mode 100644
> index 0000000..a0b452d
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clk-mux-zynqmp.c
> @@ -0,0 +1,150 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq UltraScale+ MPSoC mux
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include "clk-zynqmp.h"
> +
> +/*
> + * DOC: basic adjustable multiplexer clock that cannot gate
> + *
> + * Traits of this clock:
> + * prepare - clk_prepare only ensures that parents are prepared
> + * enable - clk_enable only ensures that parents are enabled
> + * rate - rate is only affected by parent switching.  No clk_set_rate su=
pport
> + * parent - parent is adjustable through clk_set_parent
> + */
> +
> +/**
> + * struct zynqmp_clk_mux - multiplexer clock
> + *
> + * @hw:                handle between common and hardware-specific inter=
faces
> + * @flags:     hardware-specific flags
> + * @clk_id:    Id of clock
> + */
> +struct zynqmp_clk_mux {
> +       struct clk_hw hw;
> +       u8 flags;
> +       u32 clk_id;
> +};
> +
> +#define to_zynqmp_clk_mux(_hw) container_of(_hw, struct zynqmp_clk_mux, =
hw)
> +
> +/**
> + * zynqmp_clk_mux_get_parent() - Get parent of clock
> + * @hw:                handle between common and hardware-specific inter=
faces
> + *
> + * Return: Parent index
> + */
> +static u8 zynqmp_clk_mux_get_parent(struct clk_hw *hw)
> +{
> +       struct zynqmp_clk_mux *mux =3D to_zynqmp_clk_mux(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D mux->clk_id;
> +       u32 val;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_getparent(clk_id, &val);
> +
> +       if (ret)
> +               pr_warn_once("%s() getparent failed for clock: %s, ret =
=3D %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return val;
> +}
> +
> +/**
> + * zynqmp_clk_mux_set_parent() - Set parent of clock
> + * @hw:                handle between common and hardware-specific inter=
faces
> + * @index:     Parent index
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_clk_mux_set_parent(struct clk_hw *hw, u8 index)
> +{
> +       struct zynqmp_clk_mux *mux =3D to_zynqmp_clk_mux(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D mux->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_setparent(clk_id, index);
> +
> +       if (ret)
> +               pr_warn_once("%s() set parent failed for clock: %s, ret =
=3D %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return ret;
> +}
> +
> +const struct clk_ops zynqmp_clk_mux_ops =3D {

static?

> +       .get_parent =3D zynqmp_clk_mux_get_parent,
> +       .set_parent =3D zynqmp_clk_mux_set_parent,
> +       .determine_rate =3D __clk_mux_determine_rate,
> +};
> +EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ops);

Or why is it exported?

> +
> +const struct clk_ops zynqmp_clk_mux_ro_ops =3D {
> +       .get_parent =3D zynqmp_clk_mux_get_parent,
> +};
> +EXPORT_SYMBOL_GPL(zynqmp_clk_mux_ro_ops);

Same.

> +
> +/**
> + * zynqmp_clk_register_mux() - register a mux table with the clock
> + *                            framework
> + * @dev:               device that is registering this clock
> + * @name:              name of this clock
> + * @clk_id:            Id of this clock
> + * @parents:           name of this clock's parents
> + * @num_parents:       number of parents
> + * @flags:             framework-specific flags for this clock
> + * @clk_mux_flags:     mux-specific flags for this clock
> + *
> + * Return: clock hardware of the registered clock mux
> + */
> +struct clk_hw *zynqmp_clk_register_mux(struct device *dev, const char *n=
ame,
> +                                      u32 clk_id,
> +                                      const char * const *parents,
> +                                      u8 num_parents,
> +                                      unsigned long flags,
> +                                      u8 clk_mux_flags)
> +{
> +       struct zynqmp_clk_mux *mux;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       /* allocate the mux */

Obvious comment, remove.

> +       mux =3D kzalloc(sizeof(*mux), GFP_KERNEL);
> +       if (!mux)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name =3D name;
> +       if (clk_mux_flags & CLK_MUX_READ_ONLY)
> +               init.ops =3D &zynqmp_clk_mux_ro_ops;
> +       else
> +               init.ops =3D &zynqmp_clk_mux_ops;
> +       init.flags =3D flags;
> +       init.parent_names =3D parents;
> +       init.num_parents =3D num_parents;
> +
> +       /* struct clk_mux assignments */

Obvious comment, remove.

> +       mux->flags =3D clk_mux_flags;
> +       mux->hw.init =3D &init;
> +       mux->clk_id =3D clk_id;
> +
> +       hw =3D &mux->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(hw);
> +               hw =3D ERR_PTR(ret);
> +       }
> +
> +       return hw;
> +}
> +EXPORT_SYMBOL_GPL(zynqmp_clk_register_mux);
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> new file mode 100644
> index 0000000..a315fc2
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -0,0 +1,737 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq UltraScale+ MPSoC clock controller
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + *
> + * Based on drivers/clk/zynq/clkc.c
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +
> +#include "clk-zynqmp.h"
> +
> +#define MAX_PARENT                     100
> +#define MAX_NODES                      6
> +#define MAX_NAME_LEN                   50
> +#define MAX_CLOCK                      300
> +
> +#define CLK_INIT_ENABLE_SHIFT          1
> +#define CLK_TYPE_SHIFT                 2
> +
> +#define PM_API_PAYLOAD_LEN             3
> +
> +#define NA_PARENT                      0xFFFFFFFF
> +#define DUMMY_PARENT                   0xFFFFFFFE
> +
> +#define CLK_TYPE_FIELD_LEN             4
> +#define CLK_TOPOLOGY_NODE_OFFSET       16
> +#define NODES_PER_RESP                 3
> +
> +#define CLK_TYPE_FIELD_MASK            0xF
> +#define CLK_FLAG_FIELD_MASK            GENMASK(21, 8)
> +#define CLK_TYPE_FLAG_FIELD_MASK       GENMASK(31, 24)
> +
> +#define CLK_PARENTS_ID_LEN             16
> +#define CLK_PARENTS_ID_MASK            0xFFFF
> +
> +/* Flags for parents */
> +#define PARENT_CLK_SELF                        0
> +#define PARENT_CLK_NODE1               1
> +#define PARENT_CLK_NODE2               2
> +#define PARENT_CLK_NODE3               3
> +#define PARENT_CLK_NODE4               4
> +#define PARENT_CLK_EXTERNAL            5
> +
> +#define END_OF_CLK_NAME                        "END_OF_CLK"
> +#define RESERVED_CLK_NAME              ""
> +
> +#define CLK_VALID_MASK                 0x1
> +#define CLK_INIT_ENABLE_MASK           (0x1 << CLK_INIT_ENABLE_SHIFT)
> +
> +enum clk_type {
> +       CLK_TYPE_OUTPUT,
> +       CLK_TYPE_EXTERNAL,
> +};
> +
> +/**
> + * struct clock_parent - Structure for parent of clock

Please remove 'structure' from all these kernel docs on structures. It's
redundant.

> + * @name:      Parent name
> + * @id:                Parent clock ID
> + * @flag:      Parent flags
> + */
> +struct clock_parent {
> +       char name[MAX_NAME_LEN];
> +       int id;
> +       u32 flag;
> +};
> +
> +/**
> + * struct clock_topology - Structure for topology of clock
> + * @type:      Type of topology
> + * @flag:      Topology flags
> + * @type_flag: Topology type specific flag
> + */
> +struct clock_topology {
> +       u32 type;
> +       u32 flag;
> +       u32 type_flag;
> +};
> +
> +/**
> + * struct zynqmp_clock - Structure for clock
> + * @clk_name:          Clock name
> + * @valid:             Validity flag of clock
> + * @init_enable:       init_enable flag of clock

This doesn't describe what it means though.

> + * @type:              Clock type (Output/External)
> + * @node:              Clock tolology nodes

topology?

> + * @num_nodes:         Number of nodes present in topology
> + * @parent:            structure of parent of clock

Why isn't structure capitalized?

> + * @num_parents:       Number of parents of clock
> + */
> +struct zynqmp_clock {
> +       char clk_name[MAX_NAME_LEN];
> +       u32 valid;
> +       u32 init_enable;
> +       enum clk_type type;
> +       struct clock_topology node[MAX_NODES];
> +       u32 num_nodes;
> +       struct clock_parent parent[MAX_PARENT];
> +       u32 num_parents;
> +};
> +
> +static const char clk_type_postfix[][10] =3D {
> +       [TYPE_INVALID] =3D "",
> +       [TYPE_MUX] =3D "_mux",
> +       [TYPE_GATE] =3D "",
> +       [TYPE_DIV1] =3D "_div1",
> +       [TYPE_DIV2] =3D "_div2",
> +       [TYPE_FIXEDFACTOR] =3D "_ff",
> +       [TYPE_PLL] =3D ""
> +};
> +
> +static struct zynqmp_clock clock[MAX_CLOCK];

Can this be allocated at runtime instead of wasting a bunch of space in
the Image?

> +static struct clk_hw_onecell_data *zynqmp_data;
> +static unsigned int clock_max_idx;
> +static const struct zynqmp_eemi_ops *eemi_ops;
> +
> +/**
> + * zynqmp_is_valid_clock() - Check whether clock is valid or not
> + * @clk_id:    Clock index
> + * @valid:     1: if clock is valid
> + *             0: invalid clock
> + *
> + * Return: 0 on success else error code

Why not return < 0 on error, 0 if invalid, and 1 if valid? Then we can
get rid of the u32 pointer that just leads to more confusion.

> + */
> +static int zynqmp_is_valid_clock(u32 clk_id, u32 *valid)
> +{
> +       if (clk_id > clock_max_idx)
> +               return -ENODEV;
> +
> +       *valid =3D clock[clk_id].valid;
> +
> +       return *valid ? 0 : -EINVAL;
> +}
> +
> +/**
> + * zynqmp_get_clock_name() - Get name of clock from Clock index
> + * @clk_id:    Clock index
> + * @clk_name:  Name of clock
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_get_clock_name(u32 clk_id, char *clk_name)
> +{
> +       int ret;
> +       u32 valid;
> +
> +       ret =3D zynqmp_is_valid_clock(clk_id, &valid);
> +       if (!ret && valid) {
> +               strncpy(clk_name, clock[clk_id].clk_name, MAX_NAME_LEN);
> +               return ret;
> +       } else {
> +               return ret;
> +       }

Just return ret for else statements with return ret inside them.

> +}
> +
> +/**
> + * zynqmp_get_clock_type() - Get type of clock
> + * @clk_id:    Clock index
> + * @type:      Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_get_clock_type(u32 clk_id, u32 *type)
> +{
> +       int ret;
> +       u32 valid;
> +
> +       ret =3D zynqmp_is_valid_clock(clk_id, &valid);
> +       if (!ret && valid) {
> +               *type =3D clock[clk_id].type;
> +               return ret;
> +       } else {
> +               return ret;
> +       }

Again.

> +}
> +
> +/**
> + * zynqmp_pm_clock_get_name() - Get the name of clock for given id
> + * @clock_id:  ID of the clock to be queried
> + * @name:      Name of given clock
> + *
> + * This function is used to get name of clock specified by given
> + * clock ID.
> + *
> + * Return: Returns 0, in case of error name would be 0

say '@name' to indicate name means an argument.

> + */
> +static int zynqmp_pm_clock_get_name(u32 clock_id, char *name)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +       qdata.qid =3D PM_QID_CLOCK_GET_NAME;
> +       qdata.arg1 =3D clock_id;
> +
> +       eemi_ops->query_data(qdata, ret_payload);
> +       memcpy(name, ret_payload, CLK_GET_NAME_RESP_LEN);
> +
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_topology() - Get the topology of clock for given =
id
> + * @clock_id:  ID of the clock to be queried
> + * @index:     Node index of clock topology
> + * @topology:  Buffer to store nodes in topology and flags
> + *
> + * This function is used to get topology information for the clock
> + * specified by given clock ID.
> + *
> + * This API will return 3 node of topology with a single response. To get
> + * other nodes, master should call same API in loop with new
> + * index till error is returned. E.g First call should have
> + * index 0 which will return nodes 0,1 and 2. Next call, index
> + * should be 3 which will return nodes 3,4 and 5 and so on.
> + *
> + * Return: Returns status, either success or error+reason

What is 'status'? 0 for everything's OK?

> + */
> +static int zynqmp_pm_clock_get_topology(u32 clock_id, u32 index, u32 *to=
pology)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +
> +       qdata.qid =3D PM_QID_CLOCK_GET_TOPOLOGY;
> +       qdata.arg1 =3D clock_id;
> +       qdata.arg2 =3D index;
> +
> +       ret =3D eemi_ops->query_data(qdata, ret_payload);
> +       memcpy(topology, &ret_payload[1], CLK_GET_TOPOLOGY_RESP_WORDS * 4=
);
> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_fixedfactor_params() - Get clock's fixed factor p=
arams
> + * @clock_id:  Clock ID
> + * @mul:       Multiplication value
> + * @div:       Divisor value
> + *
> + * This function is used to get fixed factor parameters for the fixed
> + * clock. This API is applicable only for the fixed clock.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_clock_get_fixedfactor_params(u32 clock_id,
> +                                                 u32 *mul,
> +                                                 u32 *div)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +
> +       qdata.qid =3D PM_QID_CLOCK_GET_FIXEDFACTOR_PARAMS;
> +       qdata.arg1 =3D clock_id;
> +
> +       ret =3D eemi_ops->query_data(qdata, ret_payload);
> +       *mul =3D ret_payload[1];
> +       *div =3D ret_payload[2];
> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_parents() - Get the first 3 parents of clock for =
given id
> + * @clock_id:  Clock ID
> + * @index:     Parent index
> + * @parents:   3 parents of the given clock
> + *
> + * This function is used to get 3 parents for the clock specified by
> + * given clock ID.
> + *
> + * This API will return 3 parents with a single response. To get
> + * other parents, master should call same API in loop with new
> + * parent index till error is returned. E.g First call should have
> + * index 0 which will return parents 0,1 and 2. Next call, index
> + * should be 3 which will return parent 3,4 and 5 and so on.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_clock_get_parents(u32 clock_id, u32 index, u32 *par=
ents)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];

What's the endianness of this payload? Is it little endian? Or do the
eemi_ops convert to CPU native endianness?

> +       int ret;
> +
> +       qdata.qid =3D PM_QID_CLOCK_GET_PARENTS;
> +       qdata.arg1 =3D clock_id;
> +       qdata.arg2 =3D index;
> +
> +       ret =3D eemi_ops->query_data(qdata, ret_payload);
> +       memcpy(parents, &ret_payload[1], CLK_GET_PARENTS_RESP_WORDS * 4);
> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_attributes() - Get the attributes of clock for gi=
ven id
> + * @clock_id:  Clock ID
> + * @attr:      Clock attributes
> + *
> + * This function is used to get clock's attributes(e.g. valid, clock typ=
e, etc).
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_clock_get_attributes(u32 clock_id, u32 *attr)
> +{
> +       struct zynqmp_pm_query_data qdata =3D {0};
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +
> +       qdata.qid =3D PM_QID_CLOCK_GET_ATTRIBUTES;
> +       qdata.arg1 =3D clock_id;
> +
> +       ret =3D eemi_ops->query_data(qdata, ret_payload);
> +       memcpy(attr, &ret_payload[1], CLK_GET_ATTR_RESP_WORDS * 4);
> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_clock_get_topology() - Get topology of clock from firmware usi=
ng
> + *                              PM_API
> + * @clk_id:            Clock index
> + * @clk_topology:      Structure of clock topology
> + * @num_nodes:         number of nodes
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_clock_get_topology(u32 clk_id,
> +                                    struct clock_topology *clk_topology,
> +                                    u32 *num_nodes)
> +{
> +       int j, k =3D 0, ret;
> +       u32 pm_resp[PM_API_PAYLOAD_LEN] =3D {0};
> +
> +       *num_nodes =3D 0;
> +       for (j =3D 0; j <=3D MAX_NODES; j +=3D 3) {
> +               ret =3D zynqmp_pm_clock_get_topology(clk_id, j, pm_resp);
> +               if (ret)
> +                       return ret;
> +               for (k =3D 0; k < PM_API_PAYLOAD_LEN; k++) {
> +                       if (!(pm_resp[k] & CLK_TYPE_FIELD_MASK))
> +                               return 0;
> +                       clk_topology[*num_nodes].type =3D pm_resp[k] &
> +                                                       CLK_TYPE_FIELD_MA=
SK;

When this line splitting happens it's a sign to make another subroutine.

> +                       clk_topology[*num_nodes].flag =3D
> +                                       FIELD_GET(CLK_FLAG_FIELD_MASK,
> +                                                 pm_resp[k]);
> +                       clk_topology[*num_nodes].type_flag =3D
> +                               FIELD_GET(CLK_TYPE_FLAG_FIELD_MASK,
> +                                         pm_resp[k]);
> +                       (*num_nodes)++;
> +               }
> +       }
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_clock_get_parents() - Get parents info from firmware using PM_=
API
> + * @clk_id:            Clock index
> + * @parents:           Structure of parent information
> + * @num_parents:       Total number of parents
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_clock_get_parents(u32 clk_id, struct clock_parent *par=
ents,
> +                                   u32 *num_parents)
> +{
> +       int j =3D 0, k, ret, total_parents =3D 0;
> +       u32 pm_resp[PM_API_PAYLOAD_LEN] =3D {0};
> +       struct clock_parent *parent;
> +
> +       do {
> +               /* Get parents from firmware */
> +               ret =3D zynqmp_pm_clock_get_parents(clk_id, j, pm_resp);
> +               if (ret)
> +                       return ret;
> +
> +               for (k =3D 0; k < PM_API_PAYLOAD_LEN; k++) {
> +                       if (pm_resp[k] =3D=3D NA_PARENT) {
> +                               *num_parents =3D total_parents;
> +                               return 0;
> +                       }
> +
> +                       parent =3D &parents[k + j];
> +                       parent->id =3D pm_resp[k] & CLK_PARENTS_ID_MASK;
> +                       if (pm_resp[k] =3D=3D DUMMY_PARENT) {
> +                               strcpy(parent->name, "dummy_name");
> +                               parent->flag =3D 0;
> +                       } else {
> +                               parent->flag =3D pm_resp[k] >>
> +                                                       CLK_PARENTS_ID_LE=
N;

Same comment. Function is too indented and long.

> +                               if (zynqmp_get_clock_name(parent->id,
> +                                                         parent->name))
> +                                       continue;
> +                       }
> +                       total_parents++;
> +               }
> +               j +=3D PM_API_PAYLOAD_LEN;
> +       } while (total_parents <=3D MAX_PARENT);
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_get_parent_list() - Create list of parents name
> + * @np:                        Device node
> + * @clk_id:            Clock index
> + * @parent_list:       List of parent's name
> + * @num_parents:       Total number of parents
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_get_parent_list(struct device_node *np, u32 clk_id,
> +                                 const char **parent_list, u32 *num_pare=
nts)
> +{
> +       int i =3D 0, ret;
> +       u32 total_parents =3D clock[clk_id].num_parents;
> +       struct clock_topology *clk_nodes;
> +       struct clock_parent *parents;
> +
> +       clk_nodes =3D clock[clk_id].node;
> +       parents =3D clock[clk_id].parent;
> +
> +       for (i =3D 0; i < total_parents; i++) {
> +               if (!parents[i].flag) {
> +                       parent_list[i] =3D parents[i].name;
> +               } else if (parents[i].flag =3D=3D PARENT_CLK_EXTERNAL) {
> +                       ret =3D of_property_match_string(np, "clock-names=
",
> +                                                      parents[i].name);
> +                       if (ret < 0)
> +                               strcpy(parents[i].name, "dummy_name");
> +                       parent_list[i] =3D parents[i].name;
> +               } else {
> +                       strcat(parents[i].name,
> +                              clk_type_postfix[clk_nodes[parents[i].flag=
 - 1].
> +                              type]);
> +                       parent_list[i] =3D parents[i].name;
> +               }
> +       }
> +
> +       *num_parents =3D total_parents;
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_register_clk_topology() - Register clock topology
> + * @clk_id:            Clock index
> + * @clk_name:          Clock Name
> + * @num_parents:       Total number of parents
> + * @parent_names:      List of parents name
> + *
> + * Return: Returns either clock hardware or error+reason
> + */
> +static struct clk_hw *zynqmp_register_clk_topology(int clk_id, char *clk=
_name,
> +                                                  int num_parents,
> +                                                  const char **parent_na=
mes)
> +{
> +       int j, ret;
> +       u32 num_nodes, mult, div;
> +       char *clk_out =3D NULL;
> +       struct clock_topology *nodes;
> +       struct clk_hw *hw =3D NULL;
> +
> +       nodes =3D clock[clk_id].node;
> +       num_nodes =3D clock[clk_id].num_nodes;
> +
> +       for (j =3D 0; j < num_nodes; j++) {
> +               /*
> +                * Clock name received from firmware is output clock name.
> +                * Intermediate clock names are postfixed with type of cl=
ock.
> +                */
> +               if (j !=3D (num_nodes - 1)) {
> +                       clk_out =3D kasprintf(GFP_KERNEL, "%s%s", clk_nam=
e,
> +                                           clk_type_postfix[nodes[j].typ=
e]);
> +               } else {
> +                       clk_out =3D kasprintf(GFP_KERNEL, "%s", clk_name);
> +               }
> +
> +               switch (nodes[j].type) {

Make this switchcase a function of its own.

> +               case TYPE_MUX:
> +                       hw =3D zynqmp_clk_register_mux(NULL, clk_out,
> +                                                    clk_id, parent_names,
> +                                                    num_parents,
> +                                                    nodes[j].flag,
> +                                                    nodes[j].type_flag);

Why not pass &nodes to all these registration functions? And then also
pass dev, clk_out, and clk_id each time? Then the switch statement could
practically become an array of function pointers that you call with the
same arguments based on the type.

> +                       break;
> +               case TYPE_PLL:
> +                       hw =3D zynqmp_clk_register_pll(NULL, clk_out, clk=
_id,
> +                                                    parent_names[0],
> +                                                    nodes[j].flag);
> +                       break;
> +               case TYPE_FIXEDFACTOR:
> +                       ret =3D zynqmp_pm_clock_get_fixedfactor_params(cl=
k_id,
> +                                                                    &mul=
t,
> +                                                                    &div=
);

And this could be folded into that function for the fixedfactor clks.

> +                       hw =3D clk_hw_register_fixed_factor(NULL, clk_out,
> +                                                         parent_names[0],
> +                                                         nodes[j].flag, =
mult,
> +                                                         div);
> +                       break;
> +               case TYPE_DIV1:
> +               case TYPE_DIV2:
> +                       hw =3D zynqmp_clk_register_divider(NULL, clk_out,=
 clk_id,
> +                                                        nodes[j].type,
> +                                                        parent_names[0],
> +                                                        nodes[j].flag,
> +                                                        nodes[j].type_fl=
ag);
> +                       break;
> +               case TYPE_GATE:
> +
> +                       hw =3D zynqmp_clk_register_gate(NULL, clk_out, cl=
k_id,
> +                                                     parent_names[0],
> +                                                     nodes[j].flag,
> +                                                     nodes[j].type_flag);
> +                       break;
> +               default:
> +                       pr_err("%s() Unknown topology for %s\n",
> +                              __func__, clk_out);
> +                       break;
> +               }
> +               if (IS_ERR(hw))
> +                       pr_warn_once("%s() %s register fail with %ld\n",
> +                                    __func__, clk_name, PTR_ERR(hw));
> +
> +               parent_names[0] =3D clk_out;
> +       }
> +       kfree(clk_out);
> +       return hw;
> +}
> +
> +/**
> + * zynqmp_register_clocks() - Register clocks
> + * @np:                Device node
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_register_clocks(struct device_node *np)
> +{
> +       int ret;
> +       u32 i, total_parents =3D 0, type =3D 0;
> +       const char *parent_names[MAX_PARENT];
> +
> +       for (i =3D 0; i < clock_max_idx; i++) {
> +               char clk_name[MAX_NAME_LEN];
> +
> +               /* get clock name, continue to next clock if name not fou=
nd */
> +               if (zynqmp_get_clock_name(i, clk_name))
> +                       continue;
> +
> +               /* Check if clock is valid and output clock.
> +                * Do not regiter invalid or external clock.

s/regiter/register/

> +                */
> +               ret =3D zynqmp_get_clock_type(i, &type);
> +               if (ret || type !=3D CLK_TYPE_OUTPUT)
> +                       continue;
> +
> +               /* Get parents of clock*/
> +               if (zynqmp_get_parent_list(np, i, parent_names,
> +                                          &total_parents)) {
> +                       WARN_ONCE(1, "No parents found for %s\n",
> +                                 clock[i].clk_name);
> +                       continue;
> +               }
> +
> +               zynqmp_data->hws[i] =3D
> +                       zynqmp_register_clk_topology(i, clk_name,
> +                                                    total_parents,
> +                                                    parent_names);
> +       }
> +
> +       for (i =3D 0; i < clock_max_idx; i++) {
> +               if (IS_ERR(zynqmp_data->hws[i])) {
> +                       pr_err("Zynq Ultrascale+ MPSoC clk %s: register f=
ailed with %ld\n",
> +                              clock[i].clk_name, PTR_ERR(zynqmp_data->hw=
s[i]));
> +                       WARN_ON(1);
> +               }
> +       }
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_get_clock_info() - Get clock information from firmware using P=
M_API
> + */
> +static void zynqmp_get_clock_info(void)
> +{
> +       int i, ret;
> +       u32 attr, type =3D 0;
> +
> +       memset(clock, 0, sizeof(clock));
> +       for (i =3D 0; i < MAX_CLOCK; i++) {
> +               zynqmp_pm_clock_get_name(i, clock[i].clk_name);
> +               if (!strcmp(clock[i].clk_name, END_OF_CLK_NAME)) {
> +                       clock_max_idx =3D i;
> +                       break;
> +               } else if (!strcmp(clock[i].clk_name, RESERVED_CLK_NAME))=
 {
> +                       continue;
> +               }
> +
> +               ret =3D zynqmp_pm_clock_get_attributes(i, &attr);
> +               if (ret)
> +                       continue;
> +
> +               clock[i].valid =3D attr & CLK_VALID_MASK;
> +               clock[i].init_enable =3D !!(attr & CLK_INIT_ENABLE_MASK);
> +               clock[i].type =3D attr >> CLK_TYPE_SHIFT ? CLK_TYPE_EXTER=
NAL :
> +                                                       CLK_TYPE_OUTPUT;
> +       }
> +
> +       /* Get topology of all clock */
> +       for (i =3D 0; i < clock_max_idx; i++) {
> +               ret =3D zynqmp_get_clock_type(i, &type);
> +               if (ret || type !=3D CLK_TYPE_OUTPUT)
> +                       continue;
> +
> +               ret =3D zynqmp_clock_get_topology(i, clock[i].node,
> +                                               &clock[i].num_nodes);
> +               if (ret)
> +                       continue;
> +
> +               ret =3D zynqmp_clock_get_parents(i, clock[i].parent,
> +                                              &clock[i].num_parents);
> +               if (ret)
> +                       continue;
> +       }
> +}
> +
> +/**
> + * zynqmp_validate_eemi_ops() - Validate eemi ops
> + *
> + * Return: 0 on success else error code
> + */
> +static inline int zynqmp_validate_eemi_ops(void)
> +{
> +       eemi_ops =3D zynqmp_pm_get_eemi_ops();
> +       if (!eemi_ops || !eemi_ops->query_data ||
> +           !eemi_ops->clock_setdivider ||
> +           !eemi_ops->clock_getdivider ||
> +           !eemi_ops->clock_setparent ||
> +           !eemi_ops->clock_getparent ||
> +           !eemi_ops->clock_getstate ||
> +           !eemi_ops->clock_disable ||
> +           !eemi_ops->clock_enable ||
> +           !eemi_ops->ioctl)
> +               return -ENXIO;
> +
> +       return 0;

Is this function really necessary? Firmware sometimes won't implement
the ops or something? Why is the driver probing in DT then?

> +}
> +
> +/**
> + * zynqmp_clk_setup() - Setup the clock framework and register clocks
> + * @np:                Device node
> + *
> + * Return: 0 on success else error code
> + */
> +static int __init zynqmp_clk_setup(struct device_node *np)
> +{
> +       int idx;
> +
> +       idx =3D of_property_match_string(np, "clock-names", "pss_ref_clk"=
);
> +       if (idx < 0) {
> +               pr_err("pss_ref_clk not provided\n");
> +               return -ENOENT;
> +       }
> +       idx =3D of_property_match_string(np, "clock-names", "video_clk");
> +       if (idx < 0) {
> +               pr_err("video_clk not provided\n");
> +               return -ENOENT;
> +       }
> +       idx =3D of_property_match_string(np, "clock-names", "pss_alt_ref_=
clk");
> +       if (idx < 0) {
> +               pr_err("pss_alt_ref_clk not provided\n");
> +               return -ENOENT;
> +       }
> +       idx =3D of_property_match_string(np, "clock-names", "aux_ref_clk"=
);
> +       if (idx < 0) {
> +               pr_err("aux_ref_clk not provided\n");
> +               return -ENOENT;
> +       }
> +       idx =3D of_property_match_string(np, "clock-names", "gt_crx_ref_c=
lk");
> +       if (idx < 0) {
> +               pr_err("aux_ref_clk not provided\n");
> +               return -ENOENT;
> +       }

Seems like a lot of checking for things that could be checked statically
by some DT checker? Remove this unless it's doing something useful.

> +
> +       zynqmp_data =3D kzalloc(sizeof(*zynqmp_data) + sizeof(*zynqmp_dat=
a) *
> +                                               MAX_CLOCK, GFP_KERNEL);
> +       if (!zynqmp_data)
> +               return -ENOMEM;
> +
> +       zynqmp_get_clock_info();
> +       zynqmp_register_clocks(np);
> +
> +       zynqmp_data->num =3D clock_max_idx;
> +       of_clk_add_hw_provider(np, of_clk_hw_onecell_get, zynqmp_data);
> +
> +       return 0;
> +}
> +
> +/**
> + * zynqmp_clock_init() - Initialize zynqmp clocks
> + *
> + * Return: 0 on success else error code
> + */
> +static int __init zynqmp_clock_init(void)
> +{
> +       int ret;
> +       struct device_node *np;
> +
> +       np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp");
> +       if (!np)
> +               return -ENOENT;
> +       of_node_put(np);
> +
> +       np =3D of_find_compatible_node(NULL, NULL, "xlnx,zynqmp-clk");

Why can't this be a platform device driver?

> +       if (!np) {
> +               pr_err("%s: clk node not found\n", __func__);
> +               return -ENOENT;
> +       }
> +
> +       ret =3D zynqmp_validate_eemi_ops();
> +       if (ret) {
> +               pr_err("%s: eemi ops validation fail\n", __func__);
> +               of_node_put(np);
> +               return ret;
> +       }
> +
> +       ret =3D zynqmp_clk_setup(np);
> +       of_node_put(np);
> +
> +       return ret;
> +}
> +arch_initcall(zynqmp_clock_init);
> diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
> new file mode 100644
> index 0000000..ef3e2e9
> --- /dev/null
> +++ b/drivers/clk/zynqmp/divider.c
> @@ -0,0 +1,219 @@
[...]
> +
> +/**
> + * struct zynqmp_clk_divider - adjustable divider clock
> + * @hw:                handle between common and hardware-specific inter=
faces
> + * @flags:     Hardware specific flags
> + * @clk_id:    Id of clock
> + * @div_type:  divisor type (TYPE_DIV1 or TYPE_DIV2)
> + */
> +struct zynqmp_clk_divider {
> +       struct clk_hw hw;
> +       u8 flags;
> +       u32 clk_id;
> +       u32 div_type;
> +};
> +
> +static int zynqmp_divider_get_val(unsigned long parent_rate, unsigned lo=
ng rate)
> +{
> +       return DIV_ROUND_CLOSEST(parent_rate, rate);

This is used once, why not just put it inline at the call site instead?

> +}
> +
> +/**
> + * zynqmp_clk_divider_recalc_rate() - Recalc rate of divider clock
> + * @hw:                        handle between common and hardware-specif=
ic interfaces
> + * @parent_rate:       rate of parent clock
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
> +                                                   unsigned long parent_=
rate)
> +{
> +       struct zynqmp_clk_divider *divider =3D to_zynqmp_clk_divider(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D divider->clk_id;
> +       u32 div_type =3D divider->div_type;
> +       u32 div, value;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_getdivider(clk_id, &div);
> +
> +       if (ret)
> +               pr_warn_once("%s() get divider failed for %s, ret =3D %d\=
n",
> +                            __func__, clk_name, ret);
> +
> +       if (div_type =3D=3D TYPE_DIV1)
> +               value =3D div & 0xFFFF;
> +       else
> +               value =3D (div >> 16) & 0xFFFF;

div is u32, so masking with 16 bits after shifting it right by 16 does
nothing.

> +
> +       return DIV_ROUND_UP_ULL(parent_rate, value);
> +}
> +
> +/**
> + * zynqmp_clk_divider_round_rate() - Round rate of divider clock
> + * @hw:                        handle between common and hardware-specif=
ic interfaces
> + * @rate:              rate of clock to be set
> + * @prate:             rate of parent clock
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
> +                                         unsigned long rate,
> +                                         unsigned long *prate)
> +{
> +       struct zynqmp_clk_divider *divider =3D to_zynqmp_clk_divider(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D divider->clk_id;
> +       u32 div_type =3D divider->div_type;
> +       u32 bestdiv;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       /* if read only, just return current value */
> +       if (divider->flags & CLK_DIVIDER_READ_ONLY) {
> +               ret =3D eemi_ops->clock_getdivider(clk_id, &bestdiv);
> +
> +               if (ret)
> +                       pr_warn_once("%s() get divider failed for %s, ret=
 =3D %d\n",
> +                                    __func__, clk_name, ret);
> +               if (div_type =3D=3D TYPE_DIV1)
> +                       bestdiv =3D bestdiv & 0xFFFF;
> +               else
> +                       bestdiv  =3D (bestdiv >> 16) & 0xFFFF;
> +
> +               return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
> +       }
> +
> +       bestdiv =3D zynqmp_divider_get_val(*prate, rate);
> +
> +       if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) &&
> +           (clk_hw_get_flags(hw) & CLK_FRAC))

We don't stuff implementation specific clk flags into the
clk_core::flags variable, so don't expect CLK_FRAC to come out of there
and be testable here.

> +               bestdiv =3D rate % *prate ? 1 : bestdiv;
> +       *prate =3D rate * bestdiv;
> +
> +       return rate;
> +}
> +
[...]
> diff --git a/drivers/clk/zynqmp/pll.c b/drivers/clk/zynqmp/pll.c
> new file mode 100644
> index 0000000..1782829
> --- /dev/null
> +++ b/drivers/clk/zynqmp/pll.c
> @@ -0,0 +1,345 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Zynq UltraScale+ MPSoC PLL driver
> + *
> + *  Copyright (C) 2016-2018 Xilinx
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> +#include <linux/slab.h>
> +#include "clk-zynqmp.h"
> +
> +/**
> + * struct zynqmp_pll - Structure for PLL clock
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + * @clk_id:    PLL clock ID
> + */
> +struct zynqmp_pll {
> +       struct clk_hw hw;
> +       u32 clk_id;
> +};
> +
> +#define to_zynqmp_pll(_hw)     container_of(_hw, struct zynqmp_pll, hw)
> +
> +#define PLL_FBDIV_MIN  25
> +#define PLL_FBDIV_MAX  125
> +
> +#define PS_PLL_VCO_MIN 1500000000
> +#define PS_PLL_VCO_MAX 3000000000UL
> +
> +enum pll_mode {
> +       PLL_MODE_INT,
> +       PLL_MODE_FRAC,
> +};
> +
> +#define FRAC_OFFSET 0x8
> +#define PLLFCFG_FRAC_EN        BIT(31)
> +#define FRAC_DIV  BIT(16)  /* 2^16 */
> +
> +/**
> + * zynqmp_pll_get_mode() - Get mode of PLL
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + *
> + * Return: Mode of PLL
> + */
> +static inline enum pll_mode zynqmp_pll_get_mode(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_MODE, clk_id, 0,
> +                             ret_payload);
> +       if (ret)
> +               pr_warn_once("%s() PLL get frac mode failed for %s, ret =
=3D %d\n",
> +                            __func__, clk_name, ret);
> +
> +       return ret_payload[1];
> +}
> +
> +/**
> + * zynqmp_pll_set_mode() - Set the PLL mode
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + * @on:                Flag to determine the mode
> + */
> +static inline void zynqmp_pll_set_mode(struct clk_hw *hw, bool on)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       int ret;
> +       u32 mode;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       if (on)
> +               mode =3D PLL_MODE_FRAC;
> +       else
> +               mode =3D PLL_MODE_INT;
> +
> +       ret =3D eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_MODE, clk_id, mode,=
 NULL);
> +       if (ret)
> +               pr_warn_once("%s() PLL set frac mode failed for %s, ret =
=3D %d\n",
> +                            __func__, clk_name, ret);
> +}
> +
> +/**
> + * zynqmp_pll_round_rate() - Round a clock frequency
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + * @rate:      Desired clock frequency
> + * @prate:     Clock frequency of parent clock
> + *
> + * Return: Frequency closest to @rate the hardware can generate
> + */
> +static long zynqmp_pll_round_rate(struct clk_hw *hw, unsigned long rate,
> +                                 unsigned long *prate)
> +{
> +       u32 fbdiv;
> +       long rate_div, f;
> +
> +       /* Enable the fractional mode if needed */
> +       rate_div =3D (rate * FRAC_DIV) / *prate;
> +       f =3D rate_div % FRAC_DIV;
> +       zynqmp_pll_set_mode(hw, !!f);
> +
> +       if (zynqmp_pll_get_mode(hw) =3D=3D PLL_MODE_FRAC) {
> +               if (rate > PS_PLL_VCO_MAX) {
> +                       fbdiv =3D rate / PS_PLL_VCO_MAX;
> +                       rate =3D rate / (fbdiv + 1);
> +               }
> +               if (rate < PS_PLL_VCO_MIN) {
> +                       fbdiv =3D DIV_ROUND_UP(PS_PLL_VCO_MIN, rate);
> +                       rate =3D rate * fbdiv;
> +               }
> +               return rate;
> +       }
> +
> +       fbdiv =3D DIV_ROUND_CLOSEST(rate, *prate);
> +       fbdiv =3D clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
> +       return *prate * fbdiv;
> +}
> +
> +/**
> + * zynqmp_pll_recalc_rate() - Recalculate clock frequency
> + * @hw:                        Handle between common and hardware-specif=
ic interfaces
> + * @parent_rate:       Clock frequency of parent clock
> + *
> + * Return: Current clock frequency
> + */
> +static unsigned long zynqmp_pll_recalc_rate(struct clk_hw *hw,
> +                                           unsigned long parent_rate)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 fbdiv, data;
> +       unsigned long rate, frac;
> +       u32 ret_payload[PAYLOAD_ARG_CNT];
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       /*
> +        * makes probably sense to redundantly save fbdiv in the struct
> +        * zynqmp_pll to save the IO access.

Is this a TODO? Doesn't make sense to me because caching things for
recalc rate is painful to get right. Please remove this comment.

> +        */
> +       ret =3D eemi_ops->clock_getdivider(clk_id, &fbdiv);
> +       if (ret)
> +               pr_warn_once("%s() get divider failed for %s, ret =3D %d\=
n",
> +                            __func__, clk_name, ret);
> +
> +       rate =3D  parent_rate * fbdiv;
> +       if (zynqmp_pll_get_mode(hw) =3D=3D PLL_MODE_FRAC) {
> +               eemi_ops->ioctl(0, IOCTL_GET_PLL_FRAC_DATA, clk_id, 0,
> +                               ret_payload);
> +               data =3D ret_payload[1];
> +               frac =3D (parent_rate * data) / FRAC_DIV;
> +               rate =3D rate + frac;
> +       }
> +
> +       return rate;
> +}
> +
> +/**
> + * zynqmp_pll_set_rate() - Set rate of PLL
> + * @hw:                        Handle between common and hardware-specif=
ic interfaces
> + * @rate:              Frequency of clock to be set
> + * @parent_rate:       Clock frequency of parent clock
> + *
> + * Set PLL divider to set desired rate.
> + *
> + * Returns:            rate which is set on success else error code
> + */
> +static int zynqmp_pll_set_rate(struct clk_hw *hw, unsigned long rate,
> +                              unsigned long parent_rate)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 fbdiv, data;
> +       long rate_div, frac, m, f;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       if (zynqmp_pll_get_mode(hw) =3D=3D PLL_MODE_FRAC) {
> +               rate_div =3D ((rate * FRAC_DIV) / parent_rate);

Too many parenthesis.

> +               m =3D rate_div / FRAC_DIV;
> +               f =3D rate_div % FRAC_DIV;
> +               m =3D clamp_t(u32, m, (PLL_FBDIV_MIN), (PLL_FBDIV_MAX));
> +               rate =3D parent_rate * m;
> +               frac =3D (parent_rate * f) / FRAC_DIV;
> +
> +               ret =3D eemi_ops->clock_setdivider(clk_id, m);
> +               if (ret)
> +                       pr_warn_once("%s() set divider failed for %s, ret=
 =3D %d\n",
> +                                    __func__, clk_name, ret);
> +
> +               data =3D (FRAC_DIV * f) / FRAC_DIV;

Feels like there must be some macro for this idiom but I failed to find
it. round_something()?

> +               eemi_ops->ioctl(0, IOCTL_SET_PLL_FRAC_DATA, clk_id, data,=
 NULL);
> +
> +               return rate + frac;
> +       }
> +
> +       fbdiv =3D DIV_ROUND_CLOSEST(rate, parent_rate);
> +       fbdiv =3D clamp_t(u32, fbdiv, PLL_FBDIV_MIN, PLL_FBDIV_MAX);
> +       ret =3D eemi_ops->clock_setdivider(clk_id, fbdiv);
> +       if (ret)
> +               pr_warn_once("%s() set divider failed for %s, ret =3D %d\=
n",
> +                            __func__, clk_name, ret);
> +
> +       return parent_rate * fbdiv;
> +}
> +
> +/**
> + * zynqmp_pll_is_enabled() - Check if a clock is enabled
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + *
> + * Return: 1 if the clock is enabled, 0 otherwise
> + */
> +static int zynqmp_pll_is_enabled(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       unsigned int state;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       ret =3D eemi_ops->clock_getstate(clk_id, &state);
> +       if (ret) {
> +               pr_warn_once("%s() clock get state failed for %s, ret =3D=
 %d\n",
> +                            __func__, clk_name, ret);
> +               return -EIO;
> +       }
> +
> +       return state ? 1 : 0;
> +}
> +
> +/**
> + * zynqmp_pll_enable() - Enable clock
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_pll_enable(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       if (zynqmp_pll_is_enabled(hw))
> +               return 0;
> +
> +       pr_info("PLL: enable\n");

No.

> +
> +       ret =3D eemi_ops->clock_enable(clk_id);
> +       if (ret)
> +               pr_warn_once("%s() clock enable failed for %s, ret =3D %d=
\n",
> +                            __func__, clk_name, ret);
> +
> +       return ret;
> +}
> +
> +/**
> + * zynqmp_pll_disable() - Disable clock
> + * @hw:                Handle between common and hardware-specific inter=
faces
> + */
> +static void zynqmp_pll_disable(struct clk_hw *hw)
> +{
> +       struct zynqmp_pll *clk =3D to_zynqmp_pll(hw);
> +       const char *clk_name =3D clk_hw_get_name(hw);
> +       u32 clk_id =3D clk->clk_id;
> +       int ret;
> +       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops=
();
> +
> +       if (!zynqmp_pll_is_enabled(hw))
> +               return;
> +
> +       pr_info("PLL: shutdown\n");

No.

> +
> +       ret =3D eemi_ops->clock_disable(clk_id);
> +       if (ret)
> +               pr_warn_once("%s() clock disable failed for %s, ret =3D %=
d\n",
> +                            __func__, clk_name, ret);
> +}
> +
> +static const struct clk_ops zynqmp_pll_ops =3D {
> +       .enable =3D zynqmp_pll_enable,
> +       .disable =3D zynqmp_pll_disable,
> +       .is_enabled =3D zynqmp_pll_is_enabled,
> +       .round_rate =3D zynqmp_pll_round_rate,
> +       .recalc_rate =3D zynqmp_pll_recalc_rate,
> +       .set_rate =3D zynqmp_pll_set_rate,
> +};
> +
> +/**
> + * zynqmp_clk_register_pll() - Register PLL with the clock framework
> + * @dev:       Device pointer
> + * @name:      PLL name
> + * @clk_id:    Clock ID
> + * @parent:    Parent clock name
> + * @flag:      PLL flgas
> + *
> + * Return: clock hardware to the registered clock
> + */
> +struct clk_hw *zynqmp_clk_register_pll(struct device *dev, const char *n=
ame,
> +                                      u32 clk_id,
> +                                      const char *parent,
> +                                      unsigned long flag)
> +{
> +       struct zynqmp_pll *pll;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       init.name =3D name;
> +       init.ops =3D &zynqmp_pll_ops;
> +       init.flags =3D flag;
> +       init.parent_names =3D &parent;
> +       init.num_parents =3D 1;
> +
> +       pll =3D kmalloc(sizeof(*pll), GFP_KERNEL);

Why kmalloc instead of kzalloc?

> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       /* Populate the struct */

Yes. That's a useless comment.

> +       pll->hw.init =3D &init;
> +       pll->clk_id =3D clk_id;
> +
> +       hw =3D &pll->hw;
> +       ret =3D clk_hw_register(dev, hw);
> +       if (ret) {
> +               kfree(pll);
> +               return ERR_PTR(ret);
> +       }
> +
> +       clk_hw_set_rate_range(hw, PS_PLL_VCO_MIN, PS_PLL_VCO_MAX);

Why is this necessary?

> +       if (ret < 0)
> +               pr_err("%s:ERROR clk_set_rate_range failed %d\n", name, r=
et);
> +
> +       return hw;
> +}
