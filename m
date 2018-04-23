Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932608AbeDWWIh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 18:08:37 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43810 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932367AbeDWWIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 18:08:32 -0400
X-Google-Smtp-Source: AIpwx49i733W6VmS0ycmy/8SiHDYJFUVY7wZkpM39M89t1o6O6MzFkV2D2LtpBf6ZqFeAlke65p45nBx41rkcwgsM7c=
MIME-Version: 1.0
In-Reply-To: <20180423213805.12591-3-javier@emutex.com>
References: <20180423213805.12591-1-javier@emutex.com> <20180423213805.12591-3-javier@emutex.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 24 Apr 2018 01:08:31 +0300
Message-ID: <CAHp75VfONiaWmuadb2ijFcqrdr0QLexmxyd6kHUTxxH-itYtUQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] iio: adc128s052: add ACPI _HID AANT1280
To: Javier Arteaga <javier@emutex.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 24, 2018 at 12:38 AM, Javier Arteaga <javier@emutex.com> wrote:
> From: Nicola Lunghi <nicola.lunghi@emutex.com>
>
> ACPI _HID AANT1280 matches an ADC124S101 present on E3940 SKUs of the UP
> Squared board.
>
> Add it to the driver.

> +       if (ACPI_COMPANION(&spi->dev)) {

> +               const struct acpi_device_id *ad_id;
> +
> +               ad_id = acpi_match_device(spi->dev.driver->acpi_match_table,
> +                                         &spi->dev);
> +               if (!ad_id)
> +                       return -ENODEV;
> +
> +               config = ad_id->driver_data;

There is a new API to get it by one call.
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=b283f157611f129f5bbbf7d06f5af860d76797fd

> +       } else {
> +               config = spi_get_device_id(spi)->driver_data;
> +       }

-- 
With Best Regards,
Andy Shevchenko
