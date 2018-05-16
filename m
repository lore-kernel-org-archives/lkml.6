Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751830AbeEPTu5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 15:50:57 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:46926 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeEPTuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 15:50:54 -0400
X-Google-Smtp-Source: AB8JxZrBz1g7K43ajBF1CdLr/PExSAJ8YD/HcEkE+58bpLV5jtZ36MWzMrnNn+Za92pkbhMZk8CBxl7xwZHUNH5jVBQ=
MIME-Version: 1.0
In-Reply-To: <314df7f911fda8f5584cc4384a26074848a2673b.1526490085.git.hns@goldelico.com>
References: <cover.1526490085.git.hns@goldelico.com> <314df7f911fda8f5584cc4384a26074848a2673b.1526490085.git.hns@goldelico.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 16 May 2018 22:50:53 +0300
Message-ID: <CAHp75VcadghXsqu66NmrfbEPpgqusEUuzSkrE8PSJjAV0avntQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/3] gpio: pca953x: define masks for addressing common
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

On Wed, May 16, 2018 at 8:01 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> These mask bits are to be used to map the extended register
> addreseses (which are defined for an unsupported 8-bit pcal chip)
> to 16 and 24 bit chips (pcal6524).
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/gpio/gpio-pca953x.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpio/gpio-pca953x.c b/drivers/gpio/gpio-pca953x.c
> index 2b667166e855..c0eb679e60d4 100644
> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -56,6 +56,10 @@
>  #define PCAL6524_DEBOUNCE      0x2d
>
>  #define PCA_GPIO_MASK          0x00FF
> +
> +#define PCAL_GPIO_MASK         GENMASK(4, 0)
> +#define PCAL_PINCTRL_MASK      (~PCAL_GPIO_MASK)
> +

I give second thought about it, and think
either plain values, or second converted to its own explicit GENMASK
would be better.

(most confusing part to me is unknowness of the side of PINCTRL part
in the mask)


>  #define PCA_INT                        0x0100
>  #define PCA_PCAL               0x0200
>  #define PCA_LATCH_INT (PCA_PCAL | PCA_INT)
> --
> 2.12.2
>



-- 
With Best Regards,
Andy Shevchenko
