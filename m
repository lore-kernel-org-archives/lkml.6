Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F56C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5B20831
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 03:01:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F5B20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbeJaL5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:57:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34872 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbeJaL5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:57:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id d6-v6so4260134edi.2;
        Tue, 30 Oct 2018 20:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xP8pxYWP6iRFybnCXDTz5/BYiWNIe9KaxPtSx1Ncz8=;
        b=XLs6HEXV85Kd6xGquivdBQc6RntoLkAZuGLKQJbduFVzwLR9ynPfegieyI2IU6VwKl
         dGhTHoEhbBwMgQa++Zflre1ozXO3kGAXvksHhAd6cw492WTwLVif8WyY0UGnqiNvUTmm
         crG2dXs6K/aqMmRjw+7S+rKa2tBPgc5b+5d/3DxW6gdZ+Xkr7H5iUO2I9yrbb15/AiS0
         O4InKUwIBqGjUQ71f205X+NIKHY5tEikzTTqJ9TajFOrTbUMG6gHHTFof34jFQ1fEGG8
         6mPOZW8zr79103rj/ABu7Kg/DJN2CgW+kDt/xDDGuEYHbcPZfzbPfrWM14zacwstxlvw
         RmRw==
X-Gm-Message-State: AGRZ1gJYcGQpIOsW3LgxP7j4i5Rhq6fYITeNzkevWuCLRyqGOSX8UjXf
        qmR0UR3u9bgTAwjn5wKb3axVRqmKGY8=
X-Google-Smtp-Source: AJdET5ejc3KX6x8Ucb5y4f6x7rRxGTMui64LvND5KBcE0F6iRLJWJAkpHHMHKs4yAGfB1gi2ZKMp0w==
X-Received: by 2002:a17:906:a35a:: with SMTP id bz26-v6mr454120ejb.98.1540954866238;
        Tue, 30 Oct 2018 20:01:06 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id x21-v6sm7589806eds.30.2018.10.30.20.01.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 20:01:05 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id l2-v6so7647923wmh.3;
        Tue, 30 Oct 2018 20:01:04 -0700 (PDT)
X-Received: by 2002:a1c:1752:: with SMTP id 79-v6mr831954wmx.145.1540954864372;
 Tue, 30 Oct 2018 20:01:04 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-4-oskari@lemmela.net>
In-Reply-To: <20181023185330.10472-4-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 11:00:51 +0800
X-Gmail-Original-Message-ID: <CAGb2v666Vn_GdFwT4MXfbD7Gb1UC+gwGdVhquKH09Ld_Q3QmtA@mail.gmail.com>
Message-ID: <CAGb2v666Vn_GdFwT4MXfbD7Gb1UC+gwGdVhquKH09Ld_Q3QmtA@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO bindings
To:     oskari@lemmela.net
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:54 AM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> The AXP803 GPIO is compatible with AXP813 GPIO, but add
> specific compatible for it.
>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> index fc42b2caa06d..5337a21d7bcf 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
> @@ -11,6 +11,7 @@ This driver employs the per-pin muxing pattern.
>  Required properties:
>  - compatible: Should be one of:
>         - "x-powers,axp209-gpio"
> +       - "x-powers,axp803-gpio"
>         - "x-powers,axp813-gpio"
>  - #gpio-cells: Should be two. The first cell is the pin number and the
>    second is the GPIO flags.
> @@ -67,6 +68,7 @@ GPIO0 |       gpio_in, gpio_out, ldo, adc
>  GPIO1  |       gpio_in, gpio_out, ldo, adc
>  GPIO2  |       gpio_in, gpio_out
>
> +axp803
>  axp813
>  ------
>  GPIO   |       Functions
> --

As mentioned in my reply to the cover letter, this patch isn't needed.

We ask people to add model-specific compatibles in the device tree
in case the hardware turns out not to be so compatible with the old
hardware we thought it was compatible with. With the model-specific
compatible in place, we have a way out. Without it, we'd have to ask
everyone to update their device trees, which annoys some people who'd
like to have some sort of backward compatibility.

If the model-specific + fallback compatibles combination was to be
listed, the line would include both compatibles. But we're not doing
that for Allwinner stuff. As mentioned it is there just in case. The
best outcome is we don't care and don't need to use them.

ChenYu
