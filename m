Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933754AbeBMI2U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 03:28:20 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:53461 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933584AbeBMI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 03:28:18 -0500
X-Google-Smtp-Source: AH8x226e+7RXzJKCfMnLiW9BPTnoomeGocMVMHJkX0yzpQEUbTAtcLnx5PRYZ2yGw0XiNsZ9loQJ6LJZ6cy6GdBeoO8=
MIME-Version: 1.0
In-Reply-To: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
References: <e89b91042abbbcf04cb39a3350af000cc411eee1.1518076643.git.baolin.wang@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Feb 2018 09:28:17 +0100
Message-ID: <CACRpkdY1WDOr=BO-h4Us8k9n2d4cXHgBOAHTbUO5ggAoS3-dfA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: Add Spreadtrum EIC controller documentation
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin!

Thank you for your patch.

On Thu, Feb 8, 2018 at 9:01 AM, Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the device tree bindings for the Spreadtrum EIC
> controller. The EIC can be recognized as one special type of GPIO,

s/recognized as one/seen as a/g

> which can only be used as input.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>

> +The EIC is the abbreviation of external interrupt controller, which
> +is only can be used as input mode. The EIC controller includes 4

can be used only in input mode.

> +sub-modules: EIC-Debounce, EIC-Latch, EIC-Async, EIC-Sync.

Are they four sub-modules that are always synthesized into the
silicon at the same time, or do you mean that when producing the
hardware, the designer will choose one of these four types (it looks
like that from the example).

> +
> +The EIC-debounce sub-module provides up to 8 source input signal
> +connection.

connections.

> A debounce machanism is used to

mechanism

> capture input signal's

capture the input signals'

(note plural signals genitive)

> +stable status (ms grade)

is that millisecond resolution you mean?

> and a single-trigger mechanism is introduced
> +into this sub-module to enhance the input event detection reliability.
> +In addition, this sub-module's clock can be shut-off automatically to

no dash in "shut off"

> +reduce power dissipation. The debounce range is from 1ms to 4s with
> +the step of 1ms.

a step size of

> If the input signal is shorter than 1ms, it will be
> +omitted as this sub-module.

I don't understand the last part, do you mean the signal will be ignored
if it is asserted for less than 1 ms?

> +The EIC-latch sub-module is used to latch some special input signal

signals (plural)

What is special about them?

> +and send interrupts to MCU core, and it can provide up to 8 latch
> +source input signal connection.

connections (plural)

> +The EIC-async sub-module uses 32k clock

a 32kHz clock

> to capture short signal

to capture the short signal

> +(us grade)

Do you mean "microsecond granularity"?

> to generate interrupt to MCU by level or edge trigger.

What is MCU? I think you can just omit it, it could be integrated
elsewhere.

> +The EIC-sync is similar with GPIO's input function.

Do you mean that the EIC-sync module is a synchronized signal input
register? Please write that.

> +Required properties:
> +- compatible: Should be one of the following:
> +  "sprd,sc9860-eic-debounce",
> +  "sprd,sc9860-eic-latch",
> +  "sprd,sc9860-eic-async",
> +  "sprd,sc9860-eic-sync",
> +  "sprd,sc27xx-eic-debounce".

So it looks like there is one at the time, so in the SC9860
all four modules exist, but at different addresses?

(...)
> +Example:
> +       eic_debounce: eic@40210000 {
> +               compatible = "sprd,sc9860-eic-debounce";
> +               reg = <0 0x40210000 0 0x80>;

So does this mean that this is a debounced-only EIC?

There are latch, async and sync versions somewhere else in
memory? Or there could be? And they are never say debounce
and latch at the same time? Etc?

Yours,
Linus Walleij
