Return-Path: <Radu.Pirea@microchip.com>
X-Google-Smtp-Source: AB8JxZqmiBldWb8KAM00REUsMDngK1g6SdlFjheDgYCl7jz8AS4xUN4aQd8i98E6uUnYpOUPunDu
ARC-Seal: i=1; a=rsa-sha256; t=1525448769; cv=none;
        d=google.com; s=arc-20160816;
        b=q+QjZdS9OwYOH77z0liktI1p0p7omlY8nL6jcMiL++XpWRQkEKTm0bjyfSUrSa1Kia
         igVqnSaP0ge3wuKiipIvFhCYaP6D9XdwurMLx0ZHMsDROgckCx1e7ld8yMCZZHpKumuS
         zDpNtfJWtire9/DpqrwU23tSo7n8kzH0f7NO2PDb+ST5ztR7xzKZUFwVNSQw1PnjpWPa
         IzUau1ULi7i2uk8HqByHtalcUOueXtRqVT79a8u8hgRjXinVGFTKYr3Yp3vWSHROrR7A
         2UEovFpPTTgNb5TLWiD0YH0anrtk5TM5dwSXkT+YCEp8EUHQfWwRbagP816Gfo1pCmAC
         SOtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6Ykgo8Qyw1xuSktPfjKqdbRDQUEc9NjYenyi0iPFxWo=;
        b=jXdi5bR6D/dVoaQPCvvorz66mLuACA8JT9d60+sr3zhbdJEX+6bQEZT9YqW6rPUDg4
         hlryVDBvwXNh+fd+H9fbjq0cnPI/GckCXFr8Sk6JqycNBnvVQy4RANMD1O8NQOVRgV0o
         cKXY28YO8Lg4A08zBHtRdVDqeLr8qcD6zcnAMzkC72poE7MilHEFRzoFEnhyZsxlVFHF
         UiJWOfgRpL9B1eEJbGstOI8lm0fZDepJ7GV3DgpxIA0dHr3nzrBmI1DtHIGdNT0LmtPI
         da9Ciaft0V14ktx4Z/tU6atnDZsMAjxKxlx3UTy/jYu9XcyJZrTdNJyekJ7coWlb4AYP
         xDcA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of radu.pirea@microchip.com designates 68.232.149.84 as permitted sender) smtp.mailfrom=Radu.Pirea@microchip.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of radu.pirea@microchip.com designates 68.232.149.84 as permitted sender) smtp.mailfrom=Radu.Pirea@microchip.com
X-IronPort-AV: E=Sophos;i="5.49,363,1520924400";
   d="scan'208";a="13798986"
From: Radu Pirea <radu.pirea@microchip.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-serial@vger.kernel.org>
CC: <lee.jones@linaro.org>, <broonie@kernel.org>,
	<alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
	<jslaby@suse.com>, <gregkh@linuxfoundation.org>, <richard.genoud@gmail.com>,
	Radu Pirea <radu.pirea@microchip.com>
Subject: [PATCH v2 0/6] Driver for at91 usart in spi mode
Date: Fri, 4 May 2018 18:47:08 +0300
Message-ID: <20180504154714.5109-1-radu.pirea@microchip.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599548969412215444?=
X-GMAIL-MSGID: =?utf-8?q?1599548969412215444?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

This is the second version of driver. I added a mfd driver which by
default probes atmel_serial driver and if in dt is specified to probe
the spi driver, then the spi-at91-usart driver will be probed. The
compatible for atmel_serial is now the compatible for at91-usart mfd
driver and compatilbe for atmel_serial driver was changed in order to
keep the bindings for serial as they are.

Changes in v1:
- added spi-at91-usart driver

Changes in v2:
- added at91-usart mfd driver
- modified spi-at91-usart driver to work as mfd driver child
- modified atmel_serial driver to work as mfd driver child

Radu Pirea (6):
  MAINTAINERS: add at91 usart mfd driver
  mfd: at91-usart: added mfd driver for usart
  MAINTAINERS: add at91 usart spi driver
  dt-bindings: add binding for at91-usart in spi mode
  spi: at91-usart: add driver for at91-usart as spi
  tty/serial: atmel: changed the driver to work under at91-usart mfd

 .../bindings/spi/microchip,at91-usart-spi.txt |  28 +
 MAINTAINERS                                   |  14 +
 drivers/mfd/Kconfig                           |  10 +
 drivers/mfd/Makefile                          |   1 +
 drivers/mfd/at91-usart.c                      |  81 +++
 drivers/spi/Kconfig                           |   9 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-at91-usart.c                  | 545 ++++++++++++++++++
 drivers/tty/serial/Kconfig                    |   1 +
 drivers/tty/serial/atmel_serial.c             |  29 +-
 include/dt-bindings/mfd/at91-usart.h          |  17 +
 11 files changed, 722 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/microchip,at91-usart-spi.txt
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h

-- 
2.17.0
