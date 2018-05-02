Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeEBM3c (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:29:32 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39991 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751245AbeEBM3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:29:30 -0400
X-Google-Smtp-Source: AB8JxZqpGogna2yQftIUVPMiVD5n5WFSM95qGfAGvbUiHtAQawOymS+qbjHp0ABqD3NyxmrMT8G0beSN5OhcSfT7rmE=
MIME-Version: 1.0
In-Reply-To: <3df974ea890116d759844e56362dc0786388869a.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <3df974ea890116d759844e56362dc0786388869a.1524933096.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 2 May 2018 15:29:29 +0300
Message-ID: <CAHp75Ve37aARbNZ8qu5W9C-fFG5Kf9GRE_VR4aRLFpX61zviyg@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] gpio: pca953x: define masks for addressing common
 and extended registers
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

On Sat, Apr 28, 2018 at 7:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> These mask bits are to be used to map the extended register
> addreseses (which are defined for an unsupported 8-bit pcal chip)
> to 16 and 24 bit chips (pcal6524).
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 2b667166e855..fc863faa3ce4 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -56,6 +56,9 @@
>  #define PCAL6524_DEBOUNCE      0x2d
>
>  #define PCA_GPIO_MASK          0x00FF

+ empty line (the above is about contents, not addresses)

> +#define PCAL_GPIO_MASK         GENMASK(4, 0)
> +#define PCAL_PINCTRL_MASK      (~PCAL_GPIO_MASK)

I'm not sure which would be better here

1) to follow existing style
0x1F
0xE0

2) to use GENMASK() in both definitions

3) as it in this patch.


Whatever Linus prefers.

> +
>  #define PCA_INT                        0x0100
>  #define PCA_PCAL               0x0200
>  #define PCA_LATCH_INT (PCA_PCAL | PCA_INT)
> --
> 2.12.2
>



-- 
With Best Regards,
Andy Shevchenko
