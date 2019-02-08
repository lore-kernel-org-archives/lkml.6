Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7164C282CC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470B20863
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 18:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OUxTQQP1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfBHSar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 13:30:47 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36286 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbfBHSaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 13:30:46 -0500
Received: by mail-ed1-f67.google.com with SMTP id o59so1791511edb.3;
        Fri, 08 Feb 2019 10:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k1oWIpnOM0qo9S/YLuBjcaa6O13pKH6dQOMzpSgGg9A=;
        b=OUxTQQP12wVEG5ZJoP6nvliVu3GKkOyiOCiPsBLOYO2i75pnhPglx1y9jyH9ZnbL8W
         ss2339T70btkrpmaG5YieIFkNZoeDZRcXg435h4+RxdWDZVcsn1m+py06/B+QzoEc+fY
         NrafIg5iK5PKV8qm1p/m2dd8wAPqUztE+Fb2DxDS3mDvHRnTaLAKuu5iTMGCbwdQmOIP
         CPt5X8K8njCAA+Iwj/88CdPUKTR98gIfsBLYLDZ5UDk05zc0knp0C+i0W5otmlUcaf6h
         yiPGwcyaa1lZm+OjLxr0J9ouvMqfzMs4slGk9+ICnKItd60/K1XENE1i4fruN6LR4wWg
         pocw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=k1oWIpnOM0qo9S/YLuBjcaa6O13pKH6dQOMzpSgGg9A=;
        b=RDvVdDJmUwstisobGShimLNmPWzto07qR8XWwKqbXkv5HE6uAO9IAhwfgl3ZaHjYUt
         DrJTPP59WSvRl9kXJwhMafjztdn2tsmbsnsue0BITcN4bUVRto+BwCvkimKAWmgIT4CU
         j34oQUMVFwqV4UgbW8jOlHElk/ChlC5lPyVxrQJxFjuyicIkZsow3qZVyPeMM31hxpHI
         +OojeaInWI2/XUcGRc6f9FV3VK7wTn5bZXOf9wOlKG/mzx+Af9alU3qQlfXaF05DOgqM
         0sJHfobGjoiIhDXF+KXEYtWOu90CXtq47iLfmaJMAB0lB/jQ0SSQ9jgFNAfIxvTHsct9
         OFVQ==
X-Gm-Message-State: AHQUAuYiffcqG/Z2XyvmJPdiD7NIRxkybS5j+UMiwgaaFV4A8w7Hqn+K
        R3xSEMhJAkq8uJcofhK1RKE=
X-Google-Smtp-Source: AHgI3Ib1rR98hBbp8s28PUK3WOm5hBQ/rJBRrZxWWbybhCPUo9HxPTo7CvHNrvCqBUXhX5Ym5xcRsg==
X-Received: by 2002:a50:a726:: with SMTP id h35mr18052407edc.192.1549650642008;
        Fri, 08 Feb 2019 10:30:42 -0800 (PST)
Received: from ziggy.stardust ([2a00:23c5:318d:1d00:295e:b5f9:da4c:df23])
        by smtp.gmail.com with ESMTPSA id v19sm632676eje.24.2019.02.08.10.30.40
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 10:30:41 -0800 (PST)
Subject: Re: [PATCH v4 04/12] soc: mediatek: add new flow for mtcmos power.
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        srv_heupstream@mediatek.com, stable@vger.kernel.org,
        Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
References: <20190201083016.25856-1-weiyi.lu@mediatek.com>
 <20190201083016.25856-6-weiyi.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <af929b5d-ff93-f7b2-bf32-66539cde2bd5@gmail.com>
Date:   Fri, 8 Feb 2019 19:30:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20190201083016.25856-6-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2019 09:30, Weiyi Lu wrote:
> From: Owen Chen <owen.chen@mediatek.com>
> 
> Both MT8183 & MT6765 add more bus protect node than previous project,
> therefore we add two more register for setup bus protect, which reside
> at INFRA_CFG & SMI_COMMON.
> 
> With the following change
> 1. bus protect need not only infracfg but smi_common registers involved
>    to setup. Therefore we add a set/clr APIs with more customize arguments.
> 
> The second change is that we also add subsys CG control flow before/after
> the bus protect/sram control, due to bus protect need SMI bus relative CGs
> enable to feed-back its ack, and some master's sram control need CG enable
> to on/off its resource sequentially.
> 
> With the following change
> 1. turn on subsys CG before sram pwron and release bus protect.
> 2. turn off subsys CG after the process of set bus protect/receive
>    ack/disable sram.
> 
> The last change is for some power domains like vpu_core on MT8183 whose
> sram need to do clock and internal isolation while power on/off sram.
> We add a flag "sram_iso_ctrl" in scp_domain_data to judge if we need to
> do the extra sram isolation control or not.
> 

This commit message indicates that you can and should put this changes in
several patches. This will make it easier to understand what you are doing and
and the reason why you are doing it.

> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Makefile           |   2 +-
>  drivers/soc/mediatek/mtk-scpsys-ext.c   |  99 +++++++
>  drivers/soc/mediatek/mtk-scpsys.c       | 376 ++++++++++++++++++------
>  include/linux/soc/mediatek/scpsys-ext.h |  39 +++
>  4 files changed, 428 insertions(+), 88 deletions(-)
>  create mode 100644 drivers/soc/mediatek/mtk-scpsys-ext.c
>  create mode 100644 include/linux/soc/mediatek/scpsys-ext.h
> 
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 64ce5eeaba32..b9dbad6b12f9 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,4 +1,4 @@
>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
> +obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o mtk-scpsys-ext.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
> new file mode 100644
> index 000000000000..f630edb2f65d
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Owen Chen <Owen.Chen@mediatek.com>
> + */
> +#include <linux/ktime.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
> +
> +#define MTK_POLL_DELAY_US   10
> +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
> +
> +static int set_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +		u32 reg_set, u32 reg_sta, u32 reg_en)

why can't we just use this function for all accesses and get rid of the
mtk_infracfg_set_bus_protection?

> +{
> +	u32 val;
> +
> +	if (reg_set)

just use one variable reg and add a boolean stating if you need write or update.
Might make sense to pass a struct here to not bloat the function parameters.


> +		regmap_write(map, reg_set, mask);
> +	else
> +		regmap_update_bits(map, reg_en, mask, mask);
> +
> +	return regmap_read_poll_timeout(map, reg_sta,
> +			val, (val & ack_mask) == ack_mask,
> +			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int clear_bus_protection(struct regmap *map, u32 mask, u32 ack_mask,
> +		u32 reg_clr, u32 reg_sta, u32 reg_en)
> +{
> +	u32 val;
> +
> +	if (reg_clr)
> +		regmap_write(map, reg_clr, mask);
> +	else
> +		regmap_update_bits(map, reg_en, mask, 0);
> +
> +	return regmap_read_poll_timeout(map, reg_sta,
> +			val, !(val & ack_mask),
> +			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +	struct regmap *infracfg, struct regmap *smi_common)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_STEPS && bp_table[i].mask; i++) {

I'd prefer to pass the number of entries in bp_table here. In any case check for
the mask is somehow confusing.
The use of bp_table[i] many times allows to create a local pointer to point to
the entry.

> +		struct regmap *map;
> +		int ret;
> +
> +		if (bp_table[i].type == IFR_TYPE)
> +			map = infracfg;
> +		else if (bp_table[i].type == SMI_TYPE)
> +			map = smi_common;
> +		else
> +			return -EINVAL;
> +
> +		ret = set_bus_protection(map,
> +				bp_table[i].mask, bp_table[i].mask,
> +				bp_table[i].set_ofs, bp_table[i].sta_ofs,
> +				bp_table[i].en_ofs);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +	struct regmap *infracfg, struct regmap *smi_common)
> +{
> +	int i;
> +
> +	for (i = MAX_STEPS - 1; i >= 0; i--) {
> +		struct regmap *map;
> +		int ret;
> +
> +		if (bp_table[i].type == IFR_TYPE)
> +			map = infracfg;
> +		else if (bp_table[i].type == SMI_TYPE)
> +			map = smi_common;
> +		else
> +			return -EINVAL;
> +
> +		ret = clear_bus_protection(map,
> +				bp_table[i].mask, bp_table[i].clr_ack_mask,
> +				bp_table[i].clr_ofs, bp_table[i].sta_ofs,
> +				bp_table[i].en_ofs);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 5b24bb4bfbf6..53a16fa327cf 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -1,15 +1,7 @@
> -/*
> - * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> +

extra patch please.

>  #include <linux/clk.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
> @@ -20,6 +12,7 @@
>  #include <linux/pm_domain.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/soc/mediatek/infracfg.h>
> +#include <linux/soc/mediatek/scpsys-ext.h>
>  
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> @@ -29,7 +22,7 @@
>  #include <dt-bindings/power/mt8173-power.h>
>  
>  #define MTK_POLL_DELAY_US   10
> -#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> +#define MTK_POLL_TIMEOUT    USEC_PER_SEC
>  
>  #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
>  #define MTK_SCPD_FWAIT_SRAM		BIT(1)
> @@ -64,6 +57,8 @@
>  #define PWR_ON_BIT			BIT(2)
>  #define PWR_ON_2ND_BIT			BIT(3)
>  #define PWR_CLK_DIS_BIT			BIT(4)
> +#define PWR_SRAM_CLKISO_BIT		BIT(5)
> +#define PWR_SRAM_ISOINT_B_BIT		BIT(6)
>  
>  #define PWR_STATUS_CONN			BIT(1)
>  #define PWR_STATUS_DISP			BIT(3)
> @@ -115,16 +110,40 @@ static const char * const clk_names[] = {
>  };
>  
>  #define MAX_CLKS	3
> -
> +#define MAX_SUBSYS_CLKS 10
> +
> +/**
> + * struct scp_domain_data - scp domain data for power on/off flow
> + * @name: The domain name.
> + * @sta_mask: The mask for power on/off status bit.
> + * @ctl_offs: The offset for main power control register.
> + * @sram_iso_ctrl: The flag to judge if the power domain need to do
> + *                 the extra sram isolation control.
> + * @sram_pdn_bits: The mask for sram power control bits.
> + * @sram_pdn_ack_bits: The mask for sram power control acked bits.
> + * @bus_prot_mask: The mask for single step bus protection.
> + * @clk_id: The basic clock needs to be enabled before enabling certain
> + *          power domains.
> + * @basic_clk_name: provide the same purpose with field "clk_id"
> + *                  by declaring basic clock prefix name rather than clk_id.
> + * @subsys_clk_prefix: The prefix name of the clocks need to be enabled
> + *                     before releasing bus protection.
> + * @caps: The flag for active wake-up action.
> + * @bp_table: The mask table for multiple step bus protection.
> + */
>  struct scp_domain_data {
>  	const char *name;
>  	u32 sta_mask;
>  	int ctl_offs;
> +	bool sram_iso_ctrl;
>  	u32 sram_pdn_bits;
>  	u32 sram_pdn_ack_bits;
>  	u32 bus_prot_mask;
>  	enum clk_id clk_id[MAX_CLKS];
> +	const char *basic_clk_name[MAX_CLKS];

it is not explained in the commit message why we would need the name here.

> +	const char *subsys_clk_prefix;
>  	u8 caps;
> +	struct bus_prot bp_table[MAX_STEPS];
>  };
>  
>  struct scp;
> @@ -133,6 +152,7 @@ struct scp_domain {
>  	struct generic_pm_domain genpd;
>  	struct scp *scp;
>  	struct clk *clk[MAX_CLKS];
> +	struct clk *subsys_clk[MAX_SUBSYS_CLKS];
>  	const struct scp_domain_data *data;
>  	struct regulator *supply;
>  };
> @@ -148,6 +168,7 @@ struct scp {
>  	struct device *dev;
>  	void __iomem *base;
>  	struct regmap *infracfg;
> +	struct regmap *smi_common;
>  	struct scp_ctrl_reg ctrl_reg;
>  	bool bus_prot_reg_update;
>  };
> @@ -188,32 +209,166 @@ static int scpsys_domain_is_on(struct scp_domain *scpd)
>  	return -EINVAL;
>  }
>  
> +static int scpsys_regulator_enable(struct scp_domain *scpd)
> +{
> +	if (!scpd->supply)
> +		return 0;
> +
> +	return regulator_enable(scpd->supply);
> +}
> +
> +static int scpsys_regulator_disable(struct scp_domain *scpd)
> +{
> +	if (!scpd->supply)
> +		return 0;
> +
> +	return regulator_disable(scpd->supply);
> +}
> +
> +static int scpsys_clk_enable(struct clk *clk[], int max_num)

introducing the clock refactoring should be a seperate patch.

> +{
> +	int i, ret = 0;
> +
> +	for (i = 0; i < max_num && clk[i]; i++) {
> +		ret = clk_prepare_enable(clk[i]);
> +		if (ret) {
> +			for (--i; i >= 0; i--)
> +				clk_disable_unprepare(clk[i]);
> +
> +			break;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static int scpsys_clk_disable(struct clk *clk[], int max_num)
> +{
> +	int i;
> +
> +	for (i = max_num - 1; i >= 0; i--) {
> +		if (clk[i])
> +			clk_disable_unprepare(clk[i]);
> +	}
> +
> +	return 0;
> +}
> +
> +static int scpsys_sram_enable(struct scp_domain *scpd, void __iomem *ctl_addr)

make all the refactoring an extra patch where you just do that without any
logical change.

> +{
> +	u32 val;
> +	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> +	int tmp;
> +
> +	val = readl(ctl_addr) & ~scpd->data->sram_pdn_bits;
> +	writel(val, ctl_addr);
> +
> +	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> +	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> +		/*
> +		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> +		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup
> +		 * is applied here.
> +		 */
> +		usleep_range(12000, 12100);
> +	} else {
> +		/* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +		int ret = readl_poll_timeout(ctl_addr, tmp,
> +				(tmp & pdn_ack) == 0,
> +				MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	if (scpd->data->sram_iso_ctrl)	{
> +		val = readl(ctl_addr) | PWR_SRAM_ISOINT_B_BIT;
> +		writel(val, ctl_addr);
> +		udelay(1);
> +		val &= ~PWR_SRAM_CLKISO_BIT;
> +		writel(val, ctl_addr);
> +	}
> +
> +	return 0;
> +}
> +
> +static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
> +{
> +	u32 val;
> +	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
> +	int tmp;
> +
> +	if (scpd->data->sram_iso_ctrl)	{
> +		val = readl(ctl_addr);
> +		val |= PWR_SRAM_CLKISO_BIT;
> +		writel(val, ctl_addr);
> +		val &= ~PWR_SRAM_ISOINT_B_BIT;
> +		writel(val, ctl_addr);
> +		udelay(1);
> +	}
> +
> +	val = readl(ctl_addr) | scpd->data->sram_pdn_bits;
> +	writel(val, ctl_addr);
> +
> +	/* Either wait until SRAM_PDN_ACK all 1 or 0 */
> +	return readl_poll_timeout(ctl_addr, tmp,
> +			(tmp & pdn_ack) == pdn_ack,
> +			MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +}
> +
> +static int scpsys_bus_protect_enable(struct scp_domain *scpd)
> +{
> +	struct scp *scp = scpd->scp;
> +	int ret = 0;
> +
> +	if (scpd->data->bus_prot_mask) {
> +		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> +				scpd->data->bus_prot_mask,
> +				scp->bus_prot_reg_update);
> +	} else if (scpd->data->bp_table[0].mask) {
> +		ret = mtk_scpsys_ext_set_bus_protection(scpd->data->bp_table,
> +				scp->infracfg,
> +				scp->smi_common);

Please change all existing domains with a bus_prot_mask to use a bp_table with
one entry. I suppose one patch would be adding the bp_table infrastructure and
following one will change all domains. Just have a look what is more elegant.

> +	}
> +
> +	return ret;
> +}
> +
> +static int scpsys_bus_protect_disable(struct scp_domain *scpd)
> +{
> +	struct scp *scp = scpd->scp;
> +	int ret = 0;
> +
> +	if (scpd->data->bus_prot_mask) {
> +		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> +				scpd->data->bus_prot_mask,
> +				scp->bus_prot_reg_update);
> +	} else if (scpd->data->bp_table[0].mask) {
> +		ret = mtk_scpsys_ext_clear_bus_protection(
> +				scpd->data->bp_table,
> +				scp->infracfg,
> +				scp->smi_common);
> +	}
> +
> +	return ret;
> +}
> +
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
>  {
>  	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>  	struct scp *scp = scpd->scp;
>  	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>  	u32 val;
>  	int ret, tmp;
> -	int i;
>  
> -	if (scpd->supply) {
> -		ret = regulator_enable(scpd->supply);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++) {
> -		ret = clk_prepare_enable(scpd->clk[i]);
> -		if (ret) {
> -			for (--i; i >= 0; i--)
> -				clk_disable_unprepare(scpd->clk[i]);
> +	ret = scpsys_regulator_enable(scpd);
> +	if (ret < 0)
> +		return ret;
>  
> -			goto err_clk;
> -		}
> -	}
> +	ret = scpsys_clk_enable(scpd->clk, MAX_CLKS);
> +	if (ret)
> +		goto err_clk;
>  
> +	/* subsys power on */
>  	val = readl(ctl_addr);
>  	val |= PWR_ON_BIT;
>  	writel(val, ctl_addr);
> @@ -235,43 +390,26 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	val |= PWR_RST_B_BIT;
>  	writel(val, ctl_addr);
>  
> -	val &= ~scpd->data->sram_pdn_bits;
> -	writel(val, ctl_addr);
> -
> -	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> -	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> -		/*
> -		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> -		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
> -		 * applied here.
> -		 */
> -		usleep_range(12000, 12100);
> +	ret = scpsys_clk_enable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> +	if (ret < 0)
> +		goto err_pwr_ack;

in between all this refactoring it is difficult to find the relevant change, so
please try to think about the maintainer when doing changes to the code base, as
he has to understand and accept (hopefully in this order ;) your code.

>  
> -	} else {
> -		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> -					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -		if (ret < 0)
> -			goto err_pwr_ack;
> -	}
> +	ret = scpsys_sram_enable(scpd, ctl_addr);
> +	if (ret < 0)
> +		goto err_sram;
>  
> -	if (scpd->data->bus_prot_mask) {
> -		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> -				scpd->data->bus_prot_mask,
> -				scp->bus_prot_reg_update);
> -		if (ret)
> -			goto err_pwr_ack;
> -	}
> +	ret = scpsys_bus_protect_disable(scpd);
> +	if (ret < 0)
> +		goto err_sram;
>  
>  	return 0;
>  
> +err_sram:
> +	scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
>  err_pwr_ack:
> -	for (i = MAX_CLKS - 1; i >= 0; i--) {
> -		if (scpd->clk[i])
> -			clk_disable_unprepare(scpd->clk[i]);
> -	}
> +	scpsys_clk_disable(scpd->clk, MAX_CLKS);
>  err_clk:
> -	if (scpd->supply)
> -		regulator_disable(scpd->supply);
> +	scpsys_regulator_disable(scpd);
>  
>  	dev_err(scp->dev, "Failed to power on domain %s\n", genpd->name);
>  
> @@ -283,29 +421,21 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	struct scp_domain *scpd = container_of(genpd, struct scp_domain, genpd);
>  	struct scp *scp = scpd->scp;
>  	void __iomem *ctl_addr = scp->base + scpd->data->ctl_offs;
> -	u32 pdn_ack = scpd->data->sram_pdn_ack_bits;
>  	u32 val;
>  	int ret, tmp;
> -	int i;
> -
> -	if (scpd->data->bus_prot_mask) {
> -		ret = mtk_infracfg_set_bus_protection(scp->infracfg,
> -				scpd->data->bus_prot_mask,
> -				scp->bus_prot_reg_update);
> -		if (ret)
> -			goto out;
> -	}
>  
> -	val = readl(ctl_addr);
> -	val |= scpd->data->sram_pdn_bits;
> -	writel(val, ctl_addr);
> +	ret = scpsys_bus_protect_enable(scpd);
> +	if (ret < 0)
> +		goto out;
>  
> -	/* wait until SRAM_PDN_ACK all 1 */
> -	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == pdn_ack,
> -				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +	ret = scpsys_sram_disable(scpd, ctl_addr);
>  	if (ret < 0)
>  		goto out;
>  
> +	ret = scpsys_clk_disable(scpd->subsys_clk, MAX_SUBSYS_CLKS);
> +
> +	/* subsys power off */
> +	val = readl(ctl_addr);
>  	val |= PWR_ISO_BIT;
>  	writel(val, ctl_addr);
>  
> @@ -327,11 +457,9 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	if (ret < 0)
>  		goto out;
>  
> -	for (i = 0; i < MAX_CLKS && scpd->clk[i]; i++)
> -		clk_disable_unprepare(scpd->clk[i]);
> +	scpsys_clk_disable(scpd->clk, MAX_CLKS);
>  
> -	if (scpd->supply)
> -		regulator_disable(scpd->supply);
> +	scpsys_regulator_disable(scpd);
>  
>  	return 0;
>  
> @@ -341,6 +469,48 @@ static int scpsys_power_off(struct generic_pm_domain *genpd)
>  	return ret;
>  }
>  
> +static int init_subsys_clks(struct platform_device *pdev,
> +		const char *prefix, struct clk **clk)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	u32 prefix_len, sub_clk_cnt = 0;
> +	struct property *prop;
> +	const char *clk_name;
> +
> +	if (!node) {
> +		dev_err(&pdev->dev, "Cannot find scpsys node: %ld\n",
> +			PTR_ERR(node));
> +		return PTR_ERR(node);
> +	}

You are changing the way the devicetree node looks like, please add a patch
adding the information to the binding.

> +
> +	prefix_len = strlen(prefix);
> +
> +	of_property_for_each_string(node, "clock-names", prop, clk_name) {
> +		if (!strncmp(clk_name, prefix, prefix_len) &&
> +				(clk_name[prefix_len] == '-')) {
> +			if (sub_clk_cnt >= MAX_SUBSYS_CLKS) {
> +				dev_err(&pdev->dev,
> +					"subsys clk out of range %d\n",
> +					sub_clk_cnt);
> +				return -ENOMEM;

ENOMEM?

> +			}
> +
> +			clk[sub_clk_cnt] = devm_clk_get(&pdev->dev,
> +						clk_name);
> +

to be honest I'm not sure what you are doing here. You are creating the clock
names to get them from the CCF, but why can't you use some of_clk_get* accessors?

> +			if (IS_ERR(clk)) {
> +				dev_err(&pdev->dev,
> +					"Subsys clk read fail %ld\n",
> +					PTR_ERR(clk));
> +				return PTR_ERR(clk);
> +			}
> +			sub_clk_cnt++;
> +		}
> +	}
> +
> +	return sub_clk_cnt;
> +}
> +
>  static void init_clks(struct platform_device *pdev, struct clk **clk)
>  {
>  	int i;
> @@ -396,6 +566,17 @@ static struct scp *init_scp(struct platform_device *pdev,
>  		return ERR_CAST(scp->infracfg);
>  	}
>  
> +	scp->smi_common = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
> +			"smi_comm");
> +
> +	if (scp->smi_common == ERR_PTR(-ENODEV)) {
> +		scp->smi_common = NULL;
> +	} else if (IS_ERR(scp->smi_common)) {

if error:
  if it's ENODEV:
    set smi_common to NULL
  else: error out.

> +		dev_err(&pdev->dev, "Cannot find smi_common controller: %ld\n",
> +				PTR_ERR(scp->smi_common));
> +		return ERR_CAST(scp->smi_common);
> +	}
> +
>  	for (i = 0; i < num; i++) {
>  		struct scp_domain *scpd = &scp->domains[i];
>  		const struct scp_domain_data *data = &scp_domain_data[i];
> @@ -417,22 +598,43 @@ static struct scp *init_scp(struct platform_device *pdev,
>  		struct scp_domain *scpd = &scp->domains[i];
>  		struct generic_pm_domain *genpd = &scpd->genpd;
>  		const struct scp_domain_data *data = &scp_domain_data[i];
> +		int clk_cnt;
>  
>  		pd_data->domains[i] = genpd;
>  		scpd->scp = scp;
>  
>  		scpd->data = data;
>  
> -		for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> -			struct clk *c = clk[data->clk_id[j]];
> +		if (data->clk_id[0]) {
> +			for (j = 0; j < MAX_CLKS && data->clk_id[j]; j++) {
> +				struct clk *c = clk[data->clk_id[j]];
>  
> -			if (IS_ERR(c)) {
> -				dev_err(&pdev->dev, "%s: clk unavailable\n",
> -					data->name);
> -				return ERR_CAST(c);
> +				if (IS_ERR(c)) {
> +					dev_err(&pdev->dev,
> +						"%s: clk unavailable\n",
> +						data->name);
> +					return ERR_CAST(c);
> +				}
> +
> +				scpd->clk[j] = c;
>  			}
> +		} else if (data->basic_clk_name[0]) {
> +			for (j = 0; j < MAX_CLKS &&
> +					data->basic_clk_name[j]; j++)
> +				scpd->clk[j] = devm_clk_get(&pdev->dev,
> +						data->basic_clk_name[j]);
> +		}

You have to explain why we need this basic clocks and why we can't get them in
init_clk

Regards,
Matthias


>  
> -			scpd->clk[j] = c;
> +		if (data->subsys_clk_prefix) {
> +			clk_cnt = init_subsys_clks(pdev,
> +					data->subsys_clk_prefix,
> +					scpd->subsys_clk);
> +			if (clk_cnt < 0) {
> +				dev_err(&pdev->dev,
> +					"%s: subsys clk unavailable\n",
> +					data->name);
> +				return ERR_PTR(clk_cnt);
> +			}
>  		}
>  
>  		genpd->name = data->name;
> diff --git a/include/linux/soc/mediatek/scpsys-ext.h b/include/linux/soc/mediatek/scpsys-ext.h
> new file mode 100644
> index 000000000000..d0ed295c88a7
> --- /dev/null
> +++ b/include/linux/soc/mediatek/scpsys-ext.h
> @@ -0,0 +1,39 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_MEDIATEK_SCPSYS_EXT_H
> +#define __SOC_MEDIATEK_SCPSYS_EXT_H
> +
> +#define MAX_STEPS	4
> +
> +#define BUS_PROT(_type, _set_ofs, _clr_ofs,			\
> +		_en_ofs, _sta_ofs, _mask, _clr_ack_mask) {	\
> +		.type = _type,					\
> +		.set_ofs = _set_ofs,				\
> +		.clr_ofs = _clr_ofs,				\
> +		.en_ofs = _en_ofs,				\
> +		.sta_ofs = _sta_ofs,				\
> +		.mask = _mask,					\
> +		.clr_ack_mask = _clr_ack_mask,			\
> +	}
> +
> +enum regmap_type {
> +	IFR_TYPE,
> +	SMI_TYPE,
> +	MAX_REGMAP_TYPE,
> +};
> +
> +struct bus_prot {
> +	enum regmap_type type;
> +	u32 set_ofs;
> +	u32 clr_ofs;
> +	u32 en_ofs;
> +	u32 sta_ofs;
> +	u32 mask;
> +	u32 clr_ack_mask;
> +};
> +
> +int mtk_scpsys_ext_set_bus_protection(const struct bus_prot *bp_table,
> +	struct regmap *infracfg, struct regmap *smi_common);
> +int mtk_scpsys_ext_clear_bus_protection(const struct bus_prot *bp_table,
> +	struct regmap *infracfg, struct regmap *smi_common);
> +
> +#endif /* __SOC_MEDIATEK_SCPSYS_EXT_H */
> 
