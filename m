Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9B0C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC7B02145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7B02145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbeIXSAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:00:51 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46288 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbeIXSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:00:50 -0400
Received: by mail-vs1-f66.google.com with SMTP id t21-v6so782886vso.13;
        Mon, 24 Sep 2018 04:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TTJNBGC+shI+uwZTIXcKp5UcZWAyXhHyjoYR1nsUOo8=;
        b=NJSdBslFpKx++KUTs89U404bRQQBjjJuISky7dpc8XanEeDfByMUunZkZPy0rYHZfx
         s3GBRKJXsf1b8PwYEseEuZEeak9+wZQHyjW/qJkBJn7j0GYkKjMJetWrNZcnOKb7xVba
         yU8pX8+klsBORfdDZ7jw7DdmTgFLdgTl+B/SdUV9d/q4R0TkHRr3uL8OLFyWAD2hJZzk
         fWWvMdEo8w0YbGbcjcksR1Fm5wzvzRiU4CxhEdPHXi10td3H3xBwN0gGEUOlEqyxl4Vq
         OfxuinEl12Rtugj2VSOlhpIPVFA871pB4rTfim+1EwPTeZAqKGwYYLQfkktVFXmY3jq3
         a5pQ==
X-Gm-Message-State: APzg51A1dKu/FRx5MicBXZZ7DCwZO3hcLgqgc6AxTWzEUuqeJbhNiCwy
        C+cY21i/XpoYkKkQm+fIGpze7J75SNXA4NAnAgI=
X-Google-Smtp-Source: ANB0VdasVOzkLQZFUokEuh577Km2Wv1e1MclctIDTixCDSsA5aq1+HAUJkCKruuRUM5OYS3a6K93diHXaCmySVNu4mk=
X-Received: by 2002:a67:f785:: with SMTP id j5-v6mr1892707vso.96.1537790343897;
 Mon, 24 Sep 2018 04:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20180919142346.25468-1-phil.edworthy@renesas.com> <20180919142346.25468-3-phil.edworthy@renesas.com>
In-Reply-To: <20180919142346.25468-3-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 24 Sep 2018 13:58:52 +0200
Message-ID: <CAMuHMdWcHY6LSDK+nrhk8o3uicru1NsXYumAL5KmPc8bVAaoTA@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] pinctrl: renesas: Renesas RZ/N1 pinctrl driver
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Sep 19, 2018 at 4:24 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> This provides a pinctrl driver for the Renesas RZ/N1 device family.
>
> Based on a patch originally written by Michel Pollet at Renesas.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Thanks for your patch!

> --- /dev/null
> +++ b/drivers/pinctrl/pinctrl-rzn1.c

> +/*
> + * Structure detailing the HW registers on the RZ/N1 devices.
> + * Both the Level 1 mux registers and Level 2 mux registers have the same
> + * structure. The only difference is that Level 2 has additional MDIO registers
> + * at the end.
> + */
> +struct rzn1_pinctrl_regs {
> +       union {
> +               u32     conf[170];
> +               u8      pad0[0x400];

This looks a bit confusing, and isn't really padding, as you use a union.
What about getting rid of the union, and making it real padding?

        u32 conf[170];
        u32 pad0[86];

> +       };
> +       u32     status_protect; /* 0x400 */
> +       /* MDIO mux registers, level2 only */
> +       u32     l2_mdio[2];
> +};

BTW, while using a struct instead of register offset definitions has its
merits, it also has its drawbacks, like the need for the "0x400" comment.
You don't have to change it, though.

> +static const struct rzn1_pin_group *rzn1_pinctrl_find_group_by_name(
> +       const struct rzn1_pinctrl *ipctl, const char *name)
> +{
> +       const struct rzn1_pin_group *grp = NULL;
> +       int i;

unsigned int i;
(rzn1_pinctrl.ngroups is unsigned int)

> +
> +       for (i = 0; i < ipctl->ngroups; i++) {
> +               if (!strcmp(ipctl->groups[i].name, name)) {
> +                       grp = &ipctl->groups[i];
> +                       break;
> +               }
> +       }
> +
> +       return grp;
> +}

> +static int rzn1_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
> +                           unsigned long *configs, unsigned int num_configs)
> +{
> +       struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       enum pin_config_param param;
> +       int i;

unsigned int i;

> +       u32 arg;
> +       u32 l1, l1_cache;
> +       u32 drv;
> +
> +       if (pin >= ARRAY_SIZE(ipctl->lev1->conf))
> +               return -EINVAL;
> +
> +       l1 = readl(&ipctl->lev1->conf[pin]);
> +       l1_cache = l1;
> +
> +       for (i = 0; i < num_configs; i++) {

> +static int rzn1_pinconf_group_get(struct pinctrl_dev *pctldev,
> +                                 unsigned int selector,
> +                                 unsigned long *config)
> +{
> +       struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct rzn1_pin_group *grp = &ipctl->groups[selector];
> +       unsigned long old = 0;
> +       int i;

unsigned int i;

> +
> +       dev_dbg(ipctl->dev, "group get %s selector:%d\n", grp->name, selector);

%u to format unsigned int.

> +
> +       for (i = 0; i < grp->npins; i++) {

> +static int rzn1_pinconf_group_set(struct pinctrl_dev *pctldev,
> +                                 unsigned int selector,
> +                                 unsigned long *configs,
> +                                 unsigned int num_configs)
> +{
> +       struct rzn1_pinctrl *ipctl = pinctrl_dev_get_drvdata(pctldev);
> +       struct rzn1_pin_group *grp = &ipctl->groups[selector];
> +       int ret, i;

unsigned int i;

> +
> +       dev_dbg(ipctl->dev, "group set %s selector:%d configs:%p/%d\n",

%u

> +               grp->name, selector, configs, num_configs);
> +
> +       for (i = 0; i < grp->npins; i++) {
> +               unsigned int pin = grp->pins[i];
> +
> +               ret = rzn1_pinconf_set(pctldev, pin, configs, num_configs);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}


> +static int rzn1_pinctrl_parse_functions(struct device_node *np,
> +                                       struct rzn1_pinctrl *ipctl, u32 index)

Why u32 instead of plain unsigned int?

> +{
> +       struct device_node *child;
> +       struct rzn1_pmx_func *func;
> +       struct rzn1_pin_group *grp;
> +       u32 i = 0;

Why not plain unsigned int?

> +       int ret;
> +
> +       func = &ipctl->functions[index];
> +
> +       /* Initialise function */
> +       func->name = np->name;
> +       func->num_groups = rzn1_pinctrl_count_function_groups(np);
> +       if (func->num_groups == 0) {
> +               dev_err(ipctl->dev, "no groups defined in %pOF\n", np);
> +               return -EINVAL;
> +       }
> +       dev_dbg(ipctl->dev, "function %s has %d groups\n",
> +               np->name, func->num_groups);
> +
> +       func->groups = devm_kmalloc_array(ipctl->dev,
> +                                         func->num_groups, sizeof(char *),
> +                                         GFP_KERNEL);
> +       if (!func->groups)
> +               return -ENOMEM;
> +
> +       if (of_property_count_u32_elems(np, RZN1_PINS_PROP) > 0) {
> +               func->groups[i] = np->name;
> +               grp = &ipctl->groups[ipctl->ngroups];
> +               grp->func = func->name;
> +               ret = rzn1_pinctrl_parse_groups(np, grp, ipctl);
> +               if (ret < 0)
> +                       return ret;
> +               i++;
> +               ipctl->ngroups++;
> +       }
> +
> +       for_each_child_of_node(np, child) {
> +               func->groups[i] = child->name;
> +               grp = &ipctl->groups[ipctl->ngroups];
> +               grp->func = func->name;
> +               ret = rzn1_pinctrl_parse_groups(child, grp, ipctl);
> +               if (ret < 0)
> +                       return ret;
> +               i++;
> +               ipctl->ngroups++;
> +       }
> +
> +       dev_dbg(ipctl->dev, "function %s parsed %d/%d groups\n",

%u/%u

> +               np->name, i, func->num_groups);
> +
> +       return 0;
> +}
> +
> +static int rzn1_pinctrl_probe_dt(struct platform_device *pdev,
> +                                struct rzn1_pinctrl *ipctl)
> +{
> +       struct device_node *np = pdev->dev.of_node;
> +       struct device_node *child;
> +       unsigned int maxgroups = 0;
> +       u32 nfuncs = 0;
> +       u32 i = 0;

Why not plain unsigned int, for both?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
