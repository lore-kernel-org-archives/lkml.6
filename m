Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754654AbeEWI3c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:29:32 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54791 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754614AbeEWI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:29:22 -0400
X-Google-Smtp-Source: AB8JxZozQcsQTRVJ6oiylFBSrYfa8eF2gWJTODfj4q1RYZSs//w8DVFpgElF52/mbR36FIJsT5+8xuuJtg5qaBJoiuM=
MIME-Version: 1.0
In-Reply-To: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
References: <1526027497-32556-1-git-send-email-phil.edworthy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 10:29:20 +0200
Message-ID: <CACRpkdZAdhAn97iWPsym_K+A8iVwa3tRacpeEu=J6C=b+xAO6g@mail.gmail.com>
Subject: Re: [PATCH v6] gpio: dwapb: Add support for 1 interrupt per port A GPIO
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hoan Tran <hotran@apm.com>, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 10:31 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:

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
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>
> ---
> One point to mention is that I have made it possible for users to have
> unconnected interrupts by specifying holes in the list of interrupts. This is
> done by supporting the interrupts-extended DT prop.
> However, I have no use for this and had to hack some test case for this.
> Perhaps the driver should support 1 interrupt or all GPIOa as interrupts?
>
> v6:
>  - Treat DT and ACPI the same as much as possible. Note that we can't use
>    platform_get_irq() to get the DT interrupts as they are in the port
>    sub-node and hence do not have an associated platform device.

I already applied this patch in some version, can you check what is
in my devel branch and send incremental patches on top if
something needs changing?
https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git/commit/?h=devel&id=e6ca26abd37606ba4864f20c85d3fe4a2173b93f

Sorry for not knowing by heart what was applied or when, it's
just too much for me sometimes.

Yours,
Linus Walleij
