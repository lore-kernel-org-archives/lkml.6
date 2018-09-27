Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD170C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A136C21571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A136C21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeI0Vew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 17:34:52 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:42164 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbeI0Vew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 17:34:52 -0400
Received: by mail-vs1-f66.google.com with SMTP id w16-v6so1707752vso.9;
        Thu, 27 Sep 2018 08:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvIm1UyrIJkQt7vWM+wkyVG5hv9Y0kBl6OEFUHju/eg=;
        b=TotubeZMcpZa3+Ea1yMEQCBzrXT/SBFwNrM0YTjREokApx6FGy2UICpZQCCuwk6bbC
         SIxRX2W3OE0G5PfZJj6UK/45qrZW6+4arxIRnWQ+Do8b111ox0kEUjR/MqypFve3UdUw
         JrIxjSw2fN+/l3fjh2O4v9YGsIpJs/ugIKvZtcXZHVf/XsPOxij+qgRloHrBkNwJBQFF
         bRqNm/uQEWWxh2mGOI68bOSI7mLMFnFpHA7ssNK443uwKDmfyI7RvKoyzcXjuKTkCE1y
         qG2rCG+yWceTSR5Ud8oA1PhSPKu/Cb9jkai/K0isJlgs7pjyc7r/F/U9JL9GVJgfifvl
         SWkA==
X-Gm-Message-State: ABuFfojqpEZBEGka7nOxrekyRaRpDsJ+vT99uy7XcXEXJ8KqxNkfAe7S
        jsdgR7fAtFOs/RIS4vS7ghQifctjilTbhtJZPJM=
X-Google-Smtp-Source: ACcGV62mqbJa9j5LtwlOjA/9iFnP6XEKrTS7X3YGGrU62+rkwA7NgVtpB/K0X+HrArtMajyppJ/0NSVBeBNGYdFkYoU=
X-Received: by 2002:a67:68ce:: with SMTP id d197-v6mr2550752vsc.152.1538061367250;
 Thu, 27 Sep 2018 08:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20180927135922.12015-1-phil.edworthy@renesas.com> <20180927135922.12015-2-phil.edworthy@renesas.com>
In-Reply-To: <20180927135922.12015-2-phil.edworthy@renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Sep 2018 17:15:54 +0200
Message-ID: <CAMuHMdV1n9KgU+6LxY3_jHTqgL1gKs+54yY0qjnwBeQX7UdOSg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: pinctrl: renesas,rzn1-pinctrl: documentation
To:     Phil Edworthy <phil.edworthy@renesas.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 3:59 PM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> The Renesas RZ/N1 device family PINCTRL node description.
>
> Based on a patch originally written by Michel Pollet at Renesas.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
> v6:
>  - Instead of combining the pin nr and func into a single element, use
>    a pair of 8-bit elements.

> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzn1-pinctrl.txt

> +- Pin multiplexing sub-nodes:
> +  A pin multiplexing sub-node describes how to configure a set of
> +  (or a single) pin in some desired alternate function mode.
> +  A single sub-node may define several pin configurations.
> +  Please refer to pinctrl-bindings.txt to get to know more on generic
> +  pin properties usage.
> +
> +  The allowed generic formats for a pin multiplexing sub-node are the
> +  following ones:
> +
> +  node-1 {
> +      pinmux = /bits/ 8 <PIN_NR MUX_FUNC>, <PIN_NR MUX_FUNC>, ... ;
> +      GENERIC_PINCONFIG;
> +  };

and

> +  Example:
> +  A serial communication interface with a TX output pin and an RX input pin.
> +
> +  &pinctrl {
> +       pins_uart0: pins_uart0 {
> +               pinmux = /bits/ 8 <
> +                       103 RZN1_FUNC_UART0_I   /* UART0_TXD */
> +                       104 RZN1_FUNC_UART0_I   /* UART0_RXD */
> +               >;
> +       };
> +  };

So the above is in response to Rob's comment on v4:

| > +#define RZN1_MUX(_gpio, _func) \
| > +       (((RZN1_FUNC_##_func) << 8) | (_gpio))
|
| I'm not a fan of token pasting and it also goes against kernel style.
| If every other Renesas platform is doing this, then fine. Otherwise,
| you can express it in pretty much the same (source) space:
|
| pinmux = <RZN1_MUX_UART0_I 104>;
|
| Yes, this is 2 cells instead of 1, but if you care about space, you
| can use 8 or 16 bit size.

I'm not so much impressed by the "/bits/ 8" part.
No other pinctrl bindings uses this.
We do have RZA1_PINMUX() and STM32_PINMUX() macros.

Rob: Is this really what you intended?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
