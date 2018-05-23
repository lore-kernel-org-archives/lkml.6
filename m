Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932813AbeEWLsr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 07:48:47 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:51995 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932796AbeEWLsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 07:48:40 -0400
X-Google-Smtp-Source: AB8JxZrSkch9OXQNX9NfDoXaWm7L4Gc7N1rLmoH6Wjplse0/U6N78pcQtfG+mNVUThYkwuGWUx8vttU9v9R/+2HA/EM=
MIME-Version: 1.0
In-Reply-To: <e70e83f07aebaf702fef90a9fac61e41d8b558b0.1526533188.git.hns@goldelico.com>
References: <cover.1526533188.git.hns@goldelico.com> <e70e83f07aebaf702fef90a9fac61e41d8b558b0.1526533188.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 13:48:38 +0200
Message-ID: <CACRpkdYfjqRaUnYXhksXANbgyn++nUAda4D1prawGU1vZ06wQg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] gpio: pca953x: fix address calculation for pcal6524
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Alexandre Courbot <gnurou@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 6:59 AM, H. Nikolaus Schaller <hns@goldelico.com> wrote:

> The register constants are so far defined in a way that they fit
> for the pcal9555a when shifted by the number of banks, i.e. are
> multiplied by 2 in the accessor function.
>
> Now, the pcal6524 has 3 banks which means the relative offset
> is multiplied by 4 for the standard registers.
>
> Simply applying the bit shift to the extended registers gives
> a wrong result, since the base offset is already included in
> the offset.
>
> Therefore, we have to add code to the 24 bit accessor functions
> that adjusts the register number for these exended registers.
>
> The formula finally used was developed and proposed by
> Andy Shevchenko <andy.shevchenko@gmail.com>.
>
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied.

Yours,
Linus Walleij
