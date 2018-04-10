Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeDJSGp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:06:45 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:39636 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbeDJSGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:06:43 -0400
X-Google-Smtp-Source: AIpwx4+h07+e6UTrM+cZ6CgLsWqIxOwcM+yEWmfUZ+q6bLsdCq98ZRtYd6bTged6L+3ntnKNdJek9AU+NjO0EvQxOtQ=
MIME-Version: 1.0
In-Reply-To: <0e9bea79eae7504e61fabdb4a0311f8fdc2f6b25.1523376423.git.hns@goldelico.com>
References: <cover.1523376423.git.hns@goldelico.com> <0e9bea79eae7504e61fabdb4a0311f8fdc2f6b25.1523376423.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Apr 2018 21:06:41 +0300
Message-ID: <CAHp75VfYk1tSJ9PUshDvY2RaYrc+wR+hyrK8Ck1oQSUXPr-0fQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] gpio: pca953x: add register definitions for
 pcal6524 and fix address calculation
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 7:07 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> PCAL chips ("L" seems to stand for "latched") have additional
> registers starting at address 0x40 to control the latches,
> interrupt mask, pull-up and pull down etc.
>
> The constants are so far defined in a way that they fit for
> the pcal9555a when shifted by the number of banks, i.e. multiplied
> by 2.
>
> Now the pcal6524 has 3 banks which means the relative offset
> must be multiplied by 4 which gives a wrong result if not done
> carefully, since the base offset is already included in the offset.
>
> For the basic registers shared with all pca93xx/tca64xx chips
> there is no such offset.
>
> Therefore, we add code to adjust the register number for exended
> registers to the 24 bit accessor functions.
>
> And we add additional register offset constants (not yet used by
> the driver code) which are specific to the pcal6524.
>

First of all, as I said, please split this to two patches. Don't mix the things.


> +       /* adjust register address for pcal6524 */
> +       if (reg >= PCAL953X_OUT_STRENGTH)
> +               reg -= PCAL953X_OUT_STRENGTH >> 1;
> +

Give me some days to think about it.

-- 
With Best Regards,
Andy Shevchenko
