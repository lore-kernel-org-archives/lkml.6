Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8934DC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F32620823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XOPmmUHt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F32620823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbeJ3V54 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:57:56 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40177 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727952AbeJ3V54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:57:56 -0400
Received: by mail-lj1-f194.google.com with SMTP id t22-v6so11256264lji.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 06:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y3BUS53lzVMcPDlczJ3ucNN36+qQq8ngtOaDVAgo27Y=;
        b=XOPmmUHt0rpmcq8gAQRnLIw2sRvaLqpdsnp/w7Qk/DQsaX4OM+jnEWlHy0tqkS26LZ
         GjtcZmJev//CE15OCXGR7cKXeDekk4gkAciQmhWMHjKZsmDB+2iD1XRZHzuCZp5YB8u8
         58Bgx7veNBno0B8UfTzpalxGJodmldIT7Jn6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y3BUS53lzVMcPDlczJ3ucNN36+qQq8ngtOaDVAgo27Y=;
        b=ZxG3XCVt+Mcm0YU9g8UKujqB1KVluuAjjLPfAR4d7wFrmQC+LfPrhAtRZyoepo6zXO
         ay1gUtQWW1BTspHgiLOxBY4Cg+ZLHQWPDSXlbHNOUz6fWJzOZPP9zC72+901Vhpqq/Ym
         etSmCD3FeLtthRf/lIqBEMzRgsTkAUScj6ne+IrnP08Fs3LlpbUISvwxjOpz74ZEZoU/
         prKnvyUvhHRb/N3Ct9z//86zfQqo+zo2NY8gtu53COfK7A9n/ZWXSfCAnBWyFyGrLilu
         4+93OCIPbVX7LVEKNe/fdbSNYylNZLPpLTiikQNrN71eru0i4RYirTKXTIbb4x596S4W
         ZJRQ==
X-Gm-Message-State: AGRZ1gIKHMwXOSH63ADxa4BetIHLe3qZLCo3Z3Rn2ZGBNFvalrBZ/Em1
        iX5cP9w6pRQaA9tPfnhIPe+2mOJCyykaioAaqhUueQ==
X-Google-Smtp-Source: AJdET5e+k6n0rWs1SroiOHQlNm9eLwV9G/nPtMlYQ9jbCK/IPwtVE25VBQzP4sTdoBVFwPBIVc9EO1A/s3c0wvfMkCk=
X-Received: by 2002:a2e:760a:: with SMTP id r10-v6mr12217157ljc.97.1540904671957;
 Tue, 30 Oct 2018 06:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181019095003.26046-1-ckeepax@opensource.cirrus.com> <20181019095003.26046-5-ckeepax@opensource.cirrus.com>
In-Reply-To: <20181019095003.26046-5-ckeepax@opensource.cirrus.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Oct 2018 14:04:20 +0100
Message-ID: <CACRpkdbYtphSk+9E5Wzz4kZvQiT=RANDg_hYqRac7pb0M02oAA@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] pinctrl: lochnagar: Add support for the Cirrus
 Logic Lochnagar
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 11:50 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:

> Lochnagar is an evaluation and development board for Cirrus
> Logic Smart CODEC and Amp devices. It allows the connection of
> most Cirrus Logic devices on mini-cards, as well as allowing
> connection of various application processor systems to provide a
> full evaluation platform. This driver supports the board
> controller chip on the Lochnagar board.
>
> Lochnagar provides many pins which can generally be used for an
> audio function such as an AIF or a PDM interface, but also as
> GPIOs.
>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>
> Changes since v2:
>  - Updated aif-master/aif-slave to use a vendor prefix
>  - Correctly get and put of_node pointer in probe/remove

Looks better and better! Some comments, probably not the last comments:

> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/pinctrl/pinctrl.h>
> +#include <linux/pinctrl/pinmux.h>
> +#include <linux/pinctrl/pinconf.h>
> +#include <linux/pinctrl/pinconf-generic.h>

#include <linux/bits.h>

> +struct lochnagar_aif {
> +       const char name[16];
> +
> +       unsigned int pins[4];
> +
> +       unsigned int src_reg;

u32?

> +       unsigned int src_mask;

u32?

> +
> +       unsigned int ctrl_reg;

u32?

> +       unsigned int ena_mask;

u32?

> +       unsigned int master_mask;

u32?

> +struct lochnagar_func {
> +       const char * const name;
> +
> +       enum lochnagar_func_type type;
> +
> +       int op;

unsigned int? u32?

Looks like u8 actually.

> +struct lochnagar_group {
> +       const char * const name;
> +
> +       enum lochnagar_func_type type;
> +
> +       const unsigned int *pins;
> +       int npins;

unsigned int npins?

> +struct lochnagar_func_groups {
> +       const char **groups;
> +       int ngroups;

unsigned int ngroups?

> +struct lochnagar_pin_priv {
> +       struct lochnagar *lochnagar;
> +       struct device *dev;
> +
> +       const struct lochnagar_func *funcs;
> +       int nfuncs;
> +
> +       const struct pinctrl_pin_desc *pins;
> +       int npins;
> +
> +       const struct lochnagar_group *groups;
> +       int ngroups;
> +
> +       struct lochnagar_func_groups func_groups[LN_FTYPE_COUNT];
> +
> +       struct gpio_chip gpio_chip;
> +};

I bet some of these should be unsigned as well.

> +static const struct pinconf_generic_params lochnagar_dt_params[] = {
> +       {"cirrus,aif-master", PIN_CONFIG_AIFMASTER,  0},
> +       {"cirrus,aif-slave",  PIN_CONFIG_AIFSLAVE,   0},
> +};

I guess these are documented in the device tree bindings.

They look suspciously like muxing but I guess it is explained
there.

> +static void lochnagar_gpio_set(struct gpio_chip *chip,
> +                              unsigned int offset, int value)
> +{
> +       struct lochnagar_pin_priv *priv = gpiochip_get_data(chip);
> +       struct lochnagar *lochnagar = priv->lochnagar;
> +       const struct lochnagar_pin *pin = priv->pins[offset].drv_data;
> +       int ret;
> +
> +       value = !!value;

value = value ? BIT(pin->shift) : 0;

> +       dev_dbg(priv->dev, "Set GPIO %s to %s\n",
> +               pin->name, value ? "high" : "low");
> +
> +       switch (pin->type) {
> +       case LN_PTYPE_MUX:
> +               value |= LN2_OP_GPIO;
> +
> +               ret = lochnagar_pin_set_mux(priv, pin, value);
> +               break;
> +       case LN_PTYPE_GPIO:
> +               if (pin->invert)
> +                       value = !value;
> +
> +               ret = regmap_update_bits(lochnagar->regmap, pin->reg,
> +                                        0x1 << pin->shift,

BIT(pin->shift)

> +                                        value << pin->shift);

Just value provided you used the construction above
to construct it.

Yours,
Linus Walleij
