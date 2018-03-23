Return-Path: <jonathan.cameron@huawei.com>
X-Google-Smtp-Source: AG47ELvCX+LgsFEvvDhUwGM2lOqSUmkUe+hnj+WUn3VbJGqiQx030ne6w8s2sVCksSICL/Axsw6F
ARC-Seal: i=1; a=rsa-sha256; t=1521810867; cv=none;
        d=google.com; s=arc-20160816;
        b=WvOPnlJxFwsD2Cr1t3/nYgsmLAUZoCDKoV6W1X3kQLk+0cxhKZrQvFOzprlPYs28+J
         MDbHMLlJ+mhmt8Esko4QYB+IlhZVnD1zsxxSTnmowhtpaiTMPsf1/2XBpWcJ5h2zE7mO
         0cDIkYaExQgmraWWU0c69gSEPfH+C+lKQxHtFziEWKcY8GKFCK3bAP33LpSUYn2K7AiM
         O3pR24TY2/G99CZRQ0xhL70Ct7r/TvoXlp/vUSlPaQzIP0h2tfU3XvQU3LX9AgiV3B7t
         FIHHyl24OXg0JYbOIYY5Mvq7I6pzlOG5uPojHI9pcItF/1PszOBDcaK4Y2TGBWtobmXo
         2NSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=JWnYb/IAG1A/Lm89QhcTVFnPTumQmtwZbRmWWEaGN/s=;
        b=msbMhV7FZStZcPrguXJzmOTj1CT3o9jeFBSzNQkZNAsikSqMy/o8E80WP6KyEpZAXT
         a8w89PU8bKy/94InnLPZ8wdvkXKAKWjekY7oiJAml7CYmtF9TFvAGZ1Rvp1C25uF393u
         PCyDSXwjCB6LrvNPKsmVhX1w5Zjq3KP4NSIK7xyqDKq9E668KpkJS0NOoYaEbHOrpMkI
         LaiKWrzxM2z8kVfLrhe98jKwRyjrn83dCARfgqTPu0EHBJZjHh+35qPrW96FCMec30Ju
         6rCeToFv2VgxAm6kO92PN5C/B7Hazc5aUeVjb/H91bxN4a0ynMi5dqu+Zp8cibtAQ00E
         Nurg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jonathan.cameron@huawei.com designates 45.249.212.191 as permitted sender) smtp.mailfrom=jonathan.cameron@huawei.com
Date: Fri, 23 Mar 2018 13:14:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Peter Rosin <peda@axentia.se>
CC: <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij
	<linus.walleij@linaro.org>, "Randy Dunlap" <rdunlap@infradead.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 0/3] iio: add unit converter
Message-ID: <20180323141401.000031cc@huawei.com>
In-Reply-To: <20180319170246.26830-1-peda@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386339632135527?=
X-GMAIL-MSGID: =?utf-8?q?1595734351867173124?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Mar 2018 18:02:43 +0100
Peter Rosin <peda@axentia.se> wrote:

> Hi!
> 
> This moves the iio-mux driver to a new category, since I think
> it will be the single driver in that category forever, and now
> I'm adding a new driver that is somewhat similar in nature...
> 
> But that rename is not very interesting, it's just reshuffling.
> It's the new driver that I need. Specifically, I need to allow
> linear scaling and modification of the type of an io-channel.
> I don't know exactly how that is accomplished in the best way,
> but this is what I came up with.
> 
> The use cases are an ADC hooked up to measure a "big" voltage by
> looking at the midpoint of a voltage divider, and an ADC used
> to measure the current by looking at the voltage over a resistor.
> 
> Comments?
It is pretty much how I would have implemented it as well.

Will probably do a detailed review over the weekend.
Not convinced entirely on the 'wrapper' naming though.
Will think about it...

Jonathan

> 
> Cheers,
> Peter
> 
> Peter Rosin (3):
>   iio: rename the multiplexer category to wrapper
>   dt-bindings: iio: wrapper: add io-channel-unit-converter
>   iio: wrapper: unit-converter: new driver
> 
>  .../{multiplexer => wrapper}/io-channel-mux.txt    |   0
>  .../iio/wrapper/io-channel-unit-converter.txt      |  84 +++++++
>  MAINTAINERS                                        |  11 +-
>  drivers/iio/Kconfig                                |   2 +-
>  drivers/iio/Makefile                               |   2 +-
>  drivers/iio/multiplexer/Makefile                   |   6 -
>  drivers/iio/{multiplexer => wrapper}/Kconfig       |  13 +-
>  drivers/iio/wrapper/Makefile                       |   7 +
>  drivers/iio/{multiplexer => wrapper}/iio-mux.c     |   0
>  drivers/iio/wrapper/iio-unit-converter.c           | 268 +++++++++++++++++++++
>  10 files changed, 381 insertions(+), 12 deletions(-)
>  rename Documentation/devicetree/bindings/iio/{multiplexer => wrapper}/io-channel-mux.txt (100%)
>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>  delete mode 100644 drivers/iio/multiplexer/Makefile
>  rename drivers/iio/{multiplexer => wrapper}/Kconfig (53%)
>  create mode 100644 drivers/iio/wrapper/Makefile
>  rename drivers/iio/{multiplexer => wrapper}/iio-mux.c (100%)
>  create mode 100644 drivers/iio/wrapper/iio-unit-converter.c
> 
