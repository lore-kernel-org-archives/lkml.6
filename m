Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4+bLvIh8p7EuPLm5YpX2Rw+/68GSwaYH7DRa2K8RvhfawuvCuIhar29g7Exxk6bnfVD7Ce7
ARC-Seal: i=1; a=rsa-sha256; t=1524505098; cv=none;
        d=google.com; s=arc-20160816;
        b=xbVZQaB5HaNjB5+hhdG95SozkeSuGqK6VzevIDTEctDzcCsgV/mmOLNXOUMf3o7s10
         gQUSTwzHxPRzeZ3xUEIo5+71mrd/q0PIW0p/N5LMnNII8l5msKvqjJ61wJGuLh4tbmca
         I7gs9nXqC5mYjeznii16E2Z1NjzmhkDZAhScbIC7hq5oHCHl58btwY22jeZmCNbG50CW
         tuhZAW1OsjNMSNn7dWQiFFrX9ZvPEB/6LU8MvEr2ptXINjwudR9EWhHg5ejo2RU/8d5B
         dXF7UoTcHHXPu4jQ9wflJFoWEY+o8padZO5+bzLXwIiQoW8E8A01L5u9j8HA98jJf6+e
         udXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=26Vj5Wpm8clemgAq/4jmeAaxdP8eG8aZQebhFLaykzU=;
        b=K0ASoChWLt7X+paV3JjZSDYVBhzr8nEEWFAkEmhChTGPklOWvVDFVQbNHRccxAo9SO
         Kt3FauFoCkOSOayawvA+/EoKz6S1OQg3sFtuODGJ9U6u0jKyporuC+e0H8CoFPJIrSdB
         ekSwL0UIyhGYbz5xB7V8PiJ7QmRF1U+PFCNd/vt1QZ+5JqvXJC3NftOGevcG0lfuYfYb
         peilOIwCBTAMRNU/IxRS6LhRc9mEf+1iRe3Q86IZpDD3SarAzF5nmebopkeVVABPtP4A
         sRChPkHPwhsGtdQUjq5Y/7xzZ1b8tenpDf5qiy5SEqKZaXNrAolX9NAQ2M3N0OD16yUz
         2Oxg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Date: Mon, 23 Apr 2018 19:38:14 +0200
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Jonathan
 Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>, Arkadiusz Golec
 <agolec@cadence.com>, Alan Douglas <adouglas@cadence.com>, Bartosz Folta
 <bfolta@cadence.com>, Damian Kos <dkos@cadence.com>, Alicja
 Jurasik-Urbaniak <alicja@cadence.com>, Cyprian Wronka
 <cwronka@cadence.com>, Suresh Punnoose <sureshp@cadence.com>, Rafal
 Ciepiela <rafalc@cadence.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Nishanth Menon <nm@ti.com>, Rob Herring
 <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar
 Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vitor Soares <Vitor.Soares@synopsys.com>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Linus Walleij
 <linus.walleij@linaro.org>, Xiang Lin <Xiang.Lin@synaptics.com>,
 linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 00/10] Add the I3C subsystem
Message-ID: <20180423193814.5c8ca75a@bbrezillon>
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347987778039674?=
X-GMAIL-MSGID: =?utf-8?q?1598559457734210576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Fri, 30 Mar 2018 09:47:41 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> This patch series is a proposal for a new I3C subsystem.

This v4 has been sent almost a month ago and I didn't get any feedback
so far apart from Rob's R-b. Greg, is there any chance we can get these
patches merged in 4.18? If not, could you tell me what should be
addressed/improved/reworked?

Thanks,

Boris

> 
> This infrastructure is not complete yet and will be extended over
> time.
> 
> There are a few design choices that are worth mentioning because they
> impact the way I3C device drivers can interact with their devices:
> 
> - all functions used to send I3C/I2C frames must be called in
>   non-atomic context. Mainly done this way to ease implementation, but
>   this is still open to discussion. Please let me know if you think it's
>   worth considering an asynchronous model here
> - the bus element is a separate object and is not implicitly described
>   by the master (as done in I2C). The reason is that I want to be able
>   to handle multiple master connected to the same bus and visible to
>   Linux.
>   In this situation, we should only have one instance of the device and
>   not one per master, and sharing the bus object would be part of the
>   solution to gracefully handle this case.
>   I'm not sure if we will ever need to deal with multiple masters
>   controlling the same bus and exposed under Linux, but separating the
>   bus and master concept is pretty easy, hence the decision to do it
>   now, just in case we need it some day.
>   The other benefit of separating the bus and master concepts is that
>   master devices appear under the bus directory in sysfs.
> - I2C backward compatibility has been designed to be transparent to I2C
>   drivers and the I2C subsystem. The I3C master just registers an I2C
>   adapter which creates a new I2C bus. I'd say that, from a
>   representation PoV it's not ideal because what should appear as a
>   single I3C bus exposing I3C and I2C devices here appears as 2
>   different busses connected to each other through the parenting (the
>   I3C master is the parent of the I2C and I3C busses).
>   On the other hand, I don't see a better solution if we want something
>   that is not invasive.
> 
> Missing features in this preliminary version:
> - support for HDR modes (has been removed because of lack of real users)
> - no support for multi-master and the associated concepts (mastership
>   handover, support for secondary masters, ...)
> - I2C devices can only be described using DT because this is the only
>   use case I have. However, the framework can easily be extended with
>   ACPI and board info support
> - I3C slave framework. This has been completely omitted, but shouldn't
>   have a huge impact on the I3C framework because I3C slaves don't see
>   the whole bus, it's only about handling master requests and generating
>   IBIs. Some of the struct, constant and enum definitions could be
>   shared, but most of the I3C slave framework logic will be different
> 
> Main changes between v2 and v3 are:
> - Reworked the DT bindings as suggested by Rob
> - Reworked the bus initialization step as suggested by Vitor
> - Added a driver for an I3C GPIO expander
> 
> Main changes between the initial RFC and this v2 are:
> - Add a generic infrastructure to support IBIs. It's worth mentioning
>   that I tried exposing IBIs as a regular IRQs, but after several
>   attempts and a discussion with Mark Zyngier, it appeared that it was
>   not really fitting in the Linux IRQ model (the fact that you have
>   payload attached to IBIs, the fact that most of the time an IBI will
>   generate a transfer on the bus which has to be done in an atomic
>   context, ...)
>   The counterpart of this decision is the latency induced by the
>   workqueue approach, but since I don't have real use cases, I don't
>   know if this can be a problem or not. 
> - Add helpers to support Hot Join
> - Add support for IBIs and Hot Join in Cadence I3C master driver
> - Address several issues in how I was using the device model
> 
> Note that I2C changes have been sent separately [1] this time. Other
> than that, no big changes in this version, I just addressed the
> comments I received from Thomas, Peter, Geert and Rob.
> 
> Thanks,
> 
> Boris
> 
> [1]https://patchwork.ozlabs.org/project/linux-i2c/list/?series=35687
> 
> Boris Brezillon (10):
>   i3c: Add core I3C infrastructure
>   docs: driver-api: Add I3C documentation
>   i3c: Add sysfs ABI spec
>   dt-bindings: i3c: Document core bindings
>   dt-bindings: i3c: Add macros to help fill I3C/I2C device's reg
>     property
>   MAINTAINERS: Add myself as the I3C subsystem maintainer
>   i3c: master: Add driver for Cadence IP
>   dt-bindings: i3c: Document Cadence I3C master bindings
>   gpio: Add a driver for Cadence I3C GPIO expander
>   dt-bindings: gpio: Add bindings for Cadence I3C gpio expander
> 
>  Documentation/ABI/testing/sysfs-bus-i3c            |   95 ++
>  .../devicetree/bindings/gpio/gpio-cdns-i3c.txt     |   39 +
>  .../devicetree/bindings/i3c/cdns,i3c-master.txt    |   44 +
>  Documentation/devicetree/bindings/i3c/i3c.txt      |  140 ++
>  Documentation/driver-api/i3c/conf.py               |   10 +
>  Documentation/driver-api/i3c/device-driver-api.rst |    7 +
>  Documentation/driver-api/i3c/index.rst             |    9 +
>  Documentation/driver-api/i3c/master-driver-api.rst |    8 +
>  Documentation/driver-api/i3c/protocol.rst          |  201 +++
>  Documentation/driver-api/index.rst                 |    1 +
>  MAINTAINERS                                        |    9 +
>  drivers/Kconfig                                    |    2 +
>  drivers/Makefile                                   |    2 +-
>  drivers/gpio/Kconfig                               |   11 +
>  drivers/gpio/Makefile                              |    1 +
>  drivers/gpio/gpio-cdns-i3c.c                       |  380 +++++
>  drivers/i3c/Kconfig                                |   24 +
>  drivers/i3c/Makefile                               |    4 +
>  drivers/i3c/core.c                                 |  620 +++++++
>  drivers/i3c/device.c                               |  294 ++++
>  drivers/i3c/internals.h                            |   28 +
>  drivers/i3c/master.c                               | 1723 ++++++++++++++++++++
>  drivers/i3c/master/Kconfig                         |    5 +
>  drivers/i3c/master/Makefile                        |    1 +
>  drivers/i3c/master/i3c-master-cdns.c               | 1650 +++++++++++++++++++
>  include/dt-bindings/i3c/i3c.h                      |   28 +
>  include/linux/i3c/ccc.h                            |  382 +++++
>  include/linux/i3c/device.h                         |  305 ++++
>  include/linux/i3c/master.h                         |  587 +++++++
>  include/linux/mod_devicetable.h                    |   17 +
>  30 files changed, 6626 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-i3c
>  create mode 100644 Documentation/devicetree/bindings/gpio/gpio-cdns-i3c.txt
>  create mode 100644 Documentation/devicetree/bindings/i3c/cdns,i3c-master.txt
>  create mode 100644 Documentation/devicetree/bindings/i3c/i3c.txt
>  create mode 100644 Documentation/driver-api/i3c/conf.py
>  create mode 100644 Documentation/driver-api/i3c/device-driver-api.rst
>  create mode 100644 Documentation/driver-api/i3c/index.rst
>  create mode 100644 Documentation/driver-api/i3c/master-driver-api.rst
>  create mode 100644 Documentation/driver-api/i3c/protocol.rst
>  create mode 100644 drivers/gpio/gpio-cdns-i3c.c
>  create mode 100644 drivers/i3c/Kconfig
>  create mode 100644 drivers/i3c/Makefile
>  create mode 100644 drivers/i3c/core.c
>  create mode 100644 drivers/i3c/device.c
>  create mode 100644 drivers/i3c/internals.h
>  create mode 100644 drivers/i3c/master.c
>  create mode 100644 drivers/i3c/master/Kconfig
>  create mode 100644 drivers/i3c/master/Makefile
>  create mode 100644 drivers/i3c/master/i3c-master-cdns.c
>  create mode 100644 include/dt-bindings/i3c/i3c.h
>  create mode 100644 include/linux/i3c/ccc.h
>  create mode 100644 include/linux/i3c/device.h
>  create mode 100644 include/linux/i3c/master.h
> 
