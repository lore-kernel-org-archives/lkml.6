Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753703AbeDRIOc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:14:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35118 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeDRINR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:13:17 -0400
X-Google-Smtp-Source: AIpwx48nHtT+J9LFbTMByKk2heLeiHLO4UrxAEhTzyA0CbTkPuhiLnebJWqk997HTiaYy71yIj8r2g==
Date: Wed, 18 Apr 2018 09:13:13 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] gpio: dwapb: Add support for 1 interrupt per port A
 GPIO
Message-ID: <20180418081313.dqxdtjqmw4z27uny@dell>
References: <1523968977-4241-1-git-send-email-phil.edworthy@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1523968977-4241-1-git-send-email-phil.edworthy@renesas.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018, Phil Edworthy wrote:

> The DesignWare GPIO IP can be configured for either 1 interrupt or 1
> per GPIO in port A, but the driver currently only supports 1 interrupt.
> See the DesignWare DW_apb_gpio Databook description of the
> 'GPIO_INTR_IO' parameter.
> 
> This change allows the driver to work with up to 32 interrupts, it will
> get as many interrupts as specified in the DT 'interrupts' property.
> It doesn't do anything clever with the different interrupts, it just calls
> the same handler used for single interrupt hardware.
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
> One point to mention is that I have made it possible for users to have
> unconncted interrupts by specifying holes in the list of interrupts. This is
> done by supporting the interrupts-extended DT prop.
> However, I have no use for this and had to hack some test case for this.
> Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
> 
> v4:
>  - Use of_irq_get() instead of of_irq_parse_one()+irq_create_of_mapping()
> v3:
>  - Rolled mfd: intel_quark_i2c_gpio fix into this patch to avoid bisect problems
> v2:
>  - Replaced interrupt-mask DT prop with support for the interrupts-extended
>    prop. This means replacing the call to irq_of_parse_and_map() with calls
>    to of_irq_parse_one() and irq_create_of_mapping().
> 
> Note: There are a few *code* lines over 80 chars, but this is just guidance,
>    right? Especially as there are already some lines over 80 chars.
> 
> snps:gpio fix
> 
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> ---
>  .../devicetree/bindings/gpio/snps-dwapb-gpio.txt   |  9 +++--
>  drivers/gpio/gpio-dwapb.c                          | 42 +++++++++++++++++-----
>  drivers/mfd/intel_quark_i2c_gpio.c                 |  3 +-

If Linus, is happy with the GPIO implementation, then the changes in
MFD look fine:

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
