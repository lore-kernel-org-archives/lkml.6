Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033995AbeCAScZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:32:25 -0500
Received: from mail-qt0-f173.google.com ([209.85.216.173]:44012 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033904AbeCAScX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:32:23 -0500
X-Google-Smtp-Source: AG47ELuCFX8Vp/opXj9RVN6gvXjKSGGzEly5cDT3X3UFwv502LoxNsS9hE3XbFUPrg9JP2Pe8rT4QNOY4Un+QpCrPNk=
MIME-Version: 1.0
In-Reply-To: <20180301163815.30595-3-ard.biesheuvel@linaro.org>
References: <20180301163815.30595-1-ard.biesheuvel@linaro.org> <20180301163815.30595-3-ard.biesheuvel@linaro.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 20:32:21 +0200
Message-ID: <CAHp75VcJ4+4-yCm6sKf+Q80FwRMjkjSGMZd5X3hecHQZ9nV7Rw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] i2c: add support for Socionext SynQuacer I2C controller
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Wolfram Sang <wsa@the-dreams.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Jassi Brar <jassisinghbrar@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 6:38 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> This is a cleaned up version of the I2C controller driver for
> the Fujitsu F_I2C IP, which was never supported upstream, and
> has now been incorporated into the Socionext SynQuacer SoC.

> +static int synquacer_i2c_remove(struct platform_device *pdev)
> +{
> +       struct synquacer_i2c *i2c = platform_get_drvdata(pdev);
> +

> +       platform_set_drvdata(pdev, NULL);

Just noticed, this is redundant for many years since driver core does
it for every device on removal.

It can be fixed by followup though.

> +       i2c_del_adapter(&i2c->adapter);
> +       if (!IS_ERR(i2c->pclk))
> +               clk_disable_unprepare(i2c->pclk);
> +
> +       return 0;
> +};

-- 
With Best Regards,
Andy Shevchenko
