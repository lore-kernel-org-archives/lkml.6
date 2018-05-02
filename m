Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbeEBKMz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 06:12:55 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36312 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbeEBKMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 06:12:49 -0400
X-Google-Smtp-Source: AB8JxZq2mvtEiCkC8sojvEehG9Onj9Hmim8SAKLJ+xAY+qHl/jBKVphO6lItLGpyyXWc5iw430xprXjzNz8Z2ARdfr8=
MIME-Version: 1.0
In-Reply-To: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
References: <1524759587-7007-1-git-send-email-phil.edworthy@renesas.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 12:12:48 +0200
Message-ID: <CACRpkdYP=jxDVV9Z9HdCWQisgYHmm8WN0RZR6b_yOwytWY9Lgw@mail.gmail.com>
Subject: Re: [PATCH v5] gpio: dwapb: Add support for 1 interrupt per port A GPIO
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Hoan Tran <hotran@apm.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
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

On Thu, Apr 26, 2018 at 6:19 PM, Phil Edworthy
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
> ACPI companion code provided by Hoan Tran <hotran@apm.com>. This was tested
> on X-Gene by Hoan.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Acked-by: Lee Jones <lee.jones@linaro.org>

Patch applied for v4.18 with Hoan's ACK.

Yours,
Linus Walleij
