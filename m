Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756233AbeDXKvR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 06:51:17 -0400
Received: from bert.emutex.com ([91.103.1.109]:54379 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755273AbeDXKvN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 06:51:13 -0400
Date: Tue, 24 Apr 2018 11:51:06 +0100
From: Javier Arteaga <javier@emutex.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Dan O'Donovan" <dan@emutex.com>, linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicola Lunghi <nicola.lunghi@emutex.com>
Subject: Re: [PATCH v2 2/3] iio: adc128s052: add ACPI _HID AANT1280
Message-ID: <20180424105106.33efoxuhizcxcz5e@localhost>
References: <20180423213805.12591-1-javier@emutex.com>
 <20180423213805.12591-3-javier@emutex.com>
 <CAHp75VfONiaWmuadb2ijFcqrdr0QLexmxyd6kHUTxxH-itYtUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHp75VfONiaWmuadb2ijFcqrdr0QLexmxyd6kHUTxxH-itYtUQ@mail.gmail.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Hi Andy, On Tue, Apr 24, 2018 at 01:08:31AM +0300, Andy Shevchenko
    wrote: > > + if (ACPI_COMPANION(&spi->dev)) { > > > + const struct acpi_device_id
    *ad_id; > > + > > + ad_id = acpi_match_device(spi->dev.driver->acpi_match_table,
    > > + &spi->dev); > > + if (!ad_id) > > + return -ENODEV; > > + > > + config
    = ad_id->driver_data; > > There is a new API to get it by one call. > https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=b283f157611f129f5bbbf7d06f5af860d76797fd
    [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Apr 24, 2018 at 01:08:31AM +0300, Andy Shevchenko wrote:
> > +       if (ACPI_COMPANION(&spi->dev)) {
> 
> > +               const struct acpi_device_id *ad_id;
> > +
> > +               ad_id = acpi_match_device(spi->dev.driver->acpi_match_table,
> > +                                         &spi->dev);
> > +               if (!ad_id)
> > +                       return -ENODEV;
> > +
> > +               config = ad_id->driver_data;
> 
> There is a new API to get it by one call.
> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git/commit/?id=b283f157611f129f5bbbf7d06f5af860d76797fd

That looks much cleaner. Will do for a v3.

Thank you!
