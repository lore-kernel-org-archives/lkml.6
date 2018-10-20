Return-Path: <SRS0=g0DB=NA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A286CC67863
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 428BC21523
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Oct 2018 11:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SAr/RuOx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 428BC21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeJTTuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 15:50:54 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40818 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbeJTTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 15:50:54 -0400
Received: by mail-qk1-f195.google.com with SMTP id x11-v6so5357714qkl.7;
        Sat, 20 Oct 2018 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ih1d4IYF2GZcRFILmMBJSedtCis7qNXXFgvJrXNeCDg=;
        b=SAr/RuOxzgRUIhLKiHblvWlI29/EGcGGB4PhG1PLFLecftampbk/C4TlXw4P3g4Pd3
         L47c8F4Rit46JBDEbTO+q6v0UPM7/VTt/fjrSI6AbH+xRS80NGW/BvP5ziN0565WUCqc
         Ucj1XquvSHCzn/LQjqhJ5QEQIhYEIcy+bJeMuEZ8mbRmQOwa93uGu05C+aLnV9C86j9q
         11Wk2XA2xPaSLKOsQqFAvvaAVozC9GT/zC1XdPFgnOrrZUFMF9WaRGVHapqVOyB+XxCk
         9HmYFOzcCMv7mJqgGbJgYu04ZfGGFuC35IRymjbkVSxZcX12mDieVN/vvGQ6g/V2zlWK
         ApmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ih1d4IYF2GZcRFILmMBJSedtCis7qNXXFgvJrXNeCDg=;
        b=YPZX+HpJfIJUBNLkGUAKfYOWAtDg2EF1y45pC+tbPDTBXd+QXEC5gvAbnCguddU9kX
         EvdTnPxDvl03XKrK90vw0KnKwCY5AoHin1TVHfSbdVulHTi4LEqy693fdWPn+fUkGbBE
         OtOumHlwzKn1DAip9nnDPyT8SNSMJ8Aj4cTigZWNSN7INmj/YvxjnEwGHr6WdiOEQkFs
         eagls73GS7SsI5WjrCPDJ829YYpuljj35Koc5S+hrwODd7iO2TT4HiMerXD4qHnHXHOF
         YSTIMWkyGMMPUqln1ffWPvSZEMM2wg2xpuGu8u1UYUZ9eY69cDnFijn36zx2Y0UY4hPf
         EdIA==
X-Gm-Message-State: AGRZ1gKlhYoG/8uSLlSb6rZMSOwykpf7cfL8K7bzIINVfKDelwOMvcxf
        cmnh08zVrijuSHeDbqFLCeY03dcw7omAhmAAFxI=
X-Google-Smtp-Source: AJdET5cmk8nzwIJrSa2TcK9F2mK3+tWF9AmiMqd6wUWj17gc4A7YUYLsqL/MRkvmxzHelJzko+1GTfd24GeGW7zpZoM=
X-Received: by 2002:a37:f70d:: with SMTP id q13-v6mr462280qkj.33.1540035643259;
 Sat, 20 Oct 2018 04:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20180421085009.28773-1-javier@emutex.com> <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1539969334-24577-4-git-send-email-dan@emutex.com>
In-Reply-To: <1539969334-24577-4-git-send-email-dan@emutex.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 20 Oct 2018 14:40:31 +0300
Message-ID: <CAHp75Vc8jxK6mcjOxmuOD0CTqYvfSSL=HMPpRVtOyCb6LxVB2w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] pinctrl: upboard: Add UP2 pinctrl and gpio driver
To:     "Dan O'Donovan" <dan@emutex.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        carlos.iglesias@emutex.com, Javier Arteaga <javier@emutex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 8:24 PM Dan O'Donovan <dan@emutex.com> wrote:
>
> From: Javier Arteaga <javier@emutex.com>
>
> The UP2 board features a Raspberry Pi compatible pin header (HAT) and a
> board-specific expansion connector (EXHAT). Both expose assorted
> functions from either the SoC (such as GPIO, I2C, SPI, UART...) or other
> on-board devices (ADC, FPGA IP blocks...).
>
> These lines are routed through an on-board FPGA. The platform controller
> in its stock firmware provides register fields to change:
>
> - Line enable (FPGA pins enabled / high impedance)
> - Line direction (SoC driven / FPGA driven)
>
> To enable using SoC GPIOs on the pin header, this arrangement requires
> both configuring the platform controller, and updating the SoC pad
> registers in sync.
>
> Add a frontend pinctrl/GPIO driver that registers a new set of GPIO
> lines for the header pins. When these are requested, the driver
> propagates this request to the backend SoC pinctrl/GPIO driver by
> grabbing a GPIO descriptor for the matching SoC GPIO line. The needed
> mapping for this is retrieved via ACPI properties.

To Linus: please, don't consider this as anyhow part of Intel pin
control infrastructure. Thus, if you are okay with the driver
(personally I don't see any major issues with the code, though it
might be required some clarification on design level, e.g. ACPI
relationship) I have no objection.

> +#define UPBOARD_BIT_TO_PIN(r, bit) \
> +       ((r) * UPBOARD_REGISTER_SIZE + (bit))

One line?

> +static int upboard_get_functions_count(struct pinctrl_dev *pctldev)
> +{
> +       return 0;
> +}
> +
> +static int upboard_get_function_groups(struct pinctrl_dev *pctldev,
> +                                      unsigned int selector,
> +                                      const char * const **groups,
> +                                      unsigned int *num_groups)
> +{
> +       *groups = NULL;
> +       *num_groups = 0;
> +       return 0;
> +}
> +
> +static const char *upboard_get_function_name(struct pinctrl_dev *pctldev,
> +                                            unsigned int selector)
> +{
> +       return NULL;
> +}
> +
> +static int upboard_set_mux(struct pinctrl_dev *pctldev, unsigned int function,
> +                          unsigned int group)
> +{
> +       return 0;
> +}

Hmm... Do you need those stubs? Same Q for other stubs in the file.

> +static int upboard_gpio_request_enable(struct pinctrl_dev *pctldev,
> +                                      struct pinctrl_gpio_range *range,
> +                                      unsigned int pin)
> +{
> +       const struct pin_desc * const pd = pin_desc_get(pctldev, pin);
> +       const struct upboard_pin *p;
> +       int ret;
> +

> +       if (!pd)
> +               return -EINVAL;

When it possible to happen?
Same Q for the rest same excerpts.

> +       p = pd->drv_data;
> +
> +       /* if this pin has an associated function bit, disable it first */
> +       if (p->func_en) {
> +               ret = regmap_field_write(p->func_en, 0);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (p->gpio_en) {
> +               ret = regmap_field_write(p->gpio_en, 1);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       return 0;
> +}

> +static struct gpio_desc *upboard_offset_to_soc_gpio(struct gpio_chip *gc,
> +                                                   unsigned int offset)
> +{

> +       struct upboard_pinctrl *pctrl =
> +               container_of(gc, struct upboard_pinctrl, chip);

One line?

> +
> +       if (offset + 1 > pctrl->nsoc_gpios || !pctrl->soc_gpios[offset])
> +               return ERR_PTR(-ENODEV);

offset >= ?
Is it even possible?

> +
> +       return pctrl->soc_gpios[offset];
> +}
> +
> +static int upboard_gpio_request(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct upboard_pinctrl *pctrl =
> +               container_of(gc, struct upboard_pinctrl, chip);

One line?

> +}
> +
> +static void upboard_gpio_free(struct gpio_chip *gc, unsigned int offset)
> +{
> +       struct upboard_pinctrl *pctrl =
> +               container_of(gc, struct upboard_pinctrl, chip);

Ditto.

> +       if (offset + 1 > pctrl->nsoc_gpios || !pctrl->soc_gpios[offset])
> +               return;

offset >= ?
Is it even possible?

> +}

> +static int upboard_pinctrl_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct pinctrl_desc *pctldesc;
> +       struct upboard_pinctrl *pctrl;
> +       struct upboard_pin *pins;
> +       struct acpi_device *adev;
> +       struct regmap *regmap;
> +       unsigned int i;
> +       int ret;

> +       adev = ACPI_COMPANION(dev);
> +       if (!adev || strcmp(acpi_device_hid(adev), "AANT0F01"))
> +               return -ENODEV;

Same Q as per LED driver.

> +       for (i = 0; i < pctldesc->npins; i++) {
> +               struct upboard_pin *pin = &pins[i];
> +               const struct pinctrl_pin_desc *pd = &pctldesc->pins[i];

> +               pin->func_en = NULL;

Useless.

> +               if (pd->drv_data) {
> +                       struct reg_field *field = pd->drv_data;
> +
> +                       pin->func_en = devm_regmap_field_alloc(dev, regmap,
> +                                                              *field);
> +                       if (IS_ERR(pin->func_en))
> +                               return PTR_ERR(pin->func_en);
> +               }
> +
> +               pin->gpio_en = upboard_field_alloc(dev, regmap,
> +                                                  UPBOARD_REG_GPIO_EN0, i);
> +               if (IS_ERR(pin->gpio_en))
> +                       return PTR_ERR(pin->gpio_en);
> +
> +               pin->gpio_dir = upboard_field_alloc(dev, regmap,
> +                                                   UPBOARD_REG_GPIO_DIR0, i);
> +               if (IS_ERR(pin->gpio_dir))
> +                       return PTR_ERR(pin->gpio_dir);
> +

> +               ((struct pinctrl_pin_desc *)pd)->drv_data = pin;

I'm not sure I understand the purpose of this casting.

> +       }

> +       pctrl->soc_gpios = devm_kzalloc(dev,
> +                                       pctrl->nsoc_gpios * sizeof(*pctrl->soc_gpios),
> +                                       GFP_KERNEL);
> +       if (!pctrl->soc_gpios)
> +               return -ENOMEM;

kzalloc -> kcalloc

> +}

-- 
With Best Regards,
Andy Shevchenko
