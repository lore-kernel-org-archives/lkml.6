Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx4+8hSsLU7xsgb6Iw9KN80aHdlQS9ZqBeOw2Vs06RBD0X3Xd2a4hzHek+Itl/TPeo5hhxDLW
ARC-Seal: i=1; a=rsa-sha256; t=1522777349; cv=none;
        d=google.com; s=arc-20160816;
        b=jqdmOVqZtOKFg3v8vWGPh7Xv20z3t33e+19lgBxr+FZYJ9qvG1T7iSxlLCG9pWEAJf
         9/2YXamfNBWo5+z2kPHlucsJw0kt+TaVXuSCaTaTsKwzG8Jv7lZ5hqAwMY9AAm+m7Vn4
         KOCcvSfZ+l0MaJBq5Ig1L6NqHATHq8Ui1k/kJpmfK2BOf3iiEtU9fUTjwjdcmz1wdL4V
         cI9AkcvGl/wBFJq9vwAMkWXtY+3tGzFlZu0t2aYJPJ2OZBwep9TMpoGwP5AI9T3a5+OL
         Eu2VPVQHHPrr73UTcSqV9+DTc6Gx9a5ISqF1AL/oHwnu63fbKAexosXfh2h6lJQ8B0tA
         d1AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=eHbYoGM+UR6UBGEtg58AVLNU8PiomFw7u/ADOV0hdpQ=;
        b=TFY79Ism/q2575jNMt3a4U3+ButsOXJkfYNuuW06WgpGlVQvQIWgA8Uj9GF9W271J6
         4kNCBsWj6TQyUIC/rGfAbR+5Dpmx83jWMPboymRtFmQhbx9SjcVEIEH5nbR45fBtiDqd
         L3s5pNI6XHjsqFYzCUkTBShWavmlWK3k95LlPz1PLs+INt66eRo2n9gkMQ5uq7VCdu5P
         wIOmRpWjMAK+EUh/teq1gHvBxQle9yPEFoeJYs5uSqh2DgIQLmW5JLOkWuyPNjfEEcka
         RwSrBlzPCiPThVimhAFiKRVbhN6UsvRSBw5su5m7E8ioXwxmLYXAZAHq98YDxKzqDz2I
         /bbg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=ZZxyh/dO;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=ZZxyh/dO;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v2 0/2] iio: add unit converter
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20180403153635.8228-1-peda@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
Date: Tue, 3 Apr 2018 12:41:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180403153635.8228-1-peda@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739875121160497?=
X-GMAIL-MSGID: =?utf-8?q?1596747781768257846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/03/2018 10:36 AM, Peter Rosin wrote:
> Hi!
> 
> This driver implements support for voltage dividers and current
> sense circuits. It's pretty generic and should be easily adaptable
> to other linear scaling purposes...
> 

I really like this idea, defining channel scaling / channel type
conversion in DT will be very useful. So much so that I would recommend
this not be a use specific driver but instead moved into the IIO core.

This would allow defining these channel conversions in the device node
itself, so as to not need a separate node just for the converter (the
conversion is not a device and probably should not have it's own node
anyway). It would also help with enabling this support for buffered
readers/writers and not just devices only supporting _raw reads/writes.

Andrew

> The driver is still named "unit converter", because it was not
> clear to me that there was a real problem with the driver being
> named that. I got the impression that the naming discussion in
> v1 was mainly about the category, and that it kind of looked odd
> and non-specific with unit-converter in the DT bindings, but
> what do I know?
> 
> Cheers,
> Peter
> 
> Changes since v1:    https://lkml.org/lkml/2018/3/19/801
> - Put the driver in the new afe category (Analog Front Ends) and do not
>   move the iio-mux driver.
> - Do not refer to the source channel as "parent", use "source" instead.
> - Have the DT compatible drive the target unit, instead of relying on a
>   "type" DT-property for that.
> - In the DT bindings, use an unnamed source channel.
> - Do not set up writes to _RAW (sorry Phil) as I don't need it and have
>   not tested it. It's easy to add back if needed.
> - Fail if the source channel does not support _RAW or _SCALE.
> - Fix various spelling issues.
> - Fix various code style issues.
> 
> Peter Rosin (2):
>   dt-bindings: iio: afe: add current-sense-cuicuit and voltage-divider
>   iio: afe: unit-converter: new driver
> 
>  .../bindings/iio/afe/current-sense-circuit.txt     |  45 ++++
>  .../bindings/iio/afe/voltage-divider.txt           |  45 ++++
>  MAINTAINERS                                        |   8 +
>  drivers/iio/Kconfig                                |   1 +
>  drivers/iio/Makefile                               |   1 +
>  drivers/iio/afe/Kconfig                            |  18 ++
>  drivers/iio/afe/Makefile                           |   6 +
>  drivers/iio/afe/iio-unit-converter.c               | 257 +++++++++++++++++++++
>  8 files changed, 381 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/afe/voltage-divider.txt
>  create mode 100644 drivers/iio/afe/Kconfig
>  create mode 100644 drivers/iio/afe/Makefile
>  create mode 100644 drivers/iio/afe/iio-unit-converter.c
> 
