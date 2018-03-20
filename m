Return-Path: <sebastian.reichel@collabora.co.uk>
X-Google-Smtp-Source: AG47ELs2rKTeNS4V1W8nAlNhkG32eeHIVUJqsDu+8xsrPGXidB3orxhqmsK6ua89efP5xgqlGRNb
ARC-Seal: i=1; a=rsa-sha256; t=1521566525; cv=none;
        d=google.com; s=arc-20160816;
        b=JMdJKeIdebhqsL4eozfyqzWD2V3NM3OjUX1QcmhBtjYSkBIHeBzbpnICZGIMsTiK6g
         7k9SQp9S5odzBYJrfni857tQVm/gPKK2bwnqzjWaxlxPdaPRKc3GyNep7snJ5Whvp0Cx
         i3t6iN7fH3dg5PavhgWeEHGluDpSSFpLt/ZuOeIFZFTQhsPfo/kxdGgWg+yX9W70LoqY
         gd55IOZTHbTgll7YmpMxCLiByHWsQ1IeF3ju2j+ljPm6ciGyXrROob4rOAWGq57nPJie
         JvJp4mrDZyxGNlN3WOJ1x3pSDgTaKeAUELyZ8VBxwxQDKYfPa91CuX6EbipbtR5U0mI6
         VP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=WH5hoRnyRaMDqpF0QWpjonrhSSjZegyzIikdxX7Yy78=;
        b=vNJGTHgrPGH8/RDV3pUw9ufM1LKlJXIPTTHIpJLZ/bGWjfAqwbVS7Rya4dUH1EDyLj
         BX1OfEMhHoMWVamwlU9OgHGaedjftW2yzlm344Y8f18wRGZolPW1uF58U++SOFdFOIgc
         ojcUH7oSLUt6fdimLMjlcHqG81jM/dgGqdNIx/BAlNSlZBMCd/Kzjl6ULzEb5/KTbQlO
         yuTP7dmwytItm7LMU0hRHdsPwjlThZ2Q8WBvk2z+V7WQAsrc+DjuVCmVUtuasCFR3qPA
         hc/VBHR6H0Q16tm5RWPOxtwEFH9NY+MBkJXRU9yOQWqJM88bLDNPXvjkHuiJHAa6k2hT
         PQsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sebastian.reichel@collabora.co.uk designates 2a00:1098:0:82:1000:25:2eeb:e3e3 as permitted sender) smtp.mailfrom=sebastian.reichel@collabora.co.uk;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=collabora.co.uk
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: Sascha Hauer <kernel@pengutronix.de>,
	Fabio Estevam <fabio.estevam@nxp.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Nandor Han <nandor.han@ge.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH 0/2] GE Healthcare PPD firmware upgrade driver for ACHC
Date: Tue, 20 Mar 2018 18:21:59 +0100
Message-Id: <20180320172201.2065-1-sebastian.reichel@collabora.co.uk>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595478140843121750?=
X-GMAIL-MSGID: =?utf-8?q?1595478140843121750?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

The PPD has a secondary processor from NXP, which can be programmed
from the main system. It is connected to the main processor by having
it's EzPort interface connected to the SPI bus.

This adds a generic driver to handle firmware flashing via NXP EzPort
and adds a custom compatible for the instance found in GE's device.
The reset gpio is only requested during flashing, since it is also
used for resetting other devices. A better solution for the shared
reset gpio is required at some point, but this does neither affect
the userspace interface, nor the DT interface and should not block
upstreaming this driver.

-- Sebastian

Sebastian Reichel (2):
  misc: ezport-firmware: new driver
  ARM: dts: imx53: PPD: Update ACHC programming interface

 Documentation/devicetree/bindings/misc/ge-achc.txt |  19 +-
 arch/arm/boot/dts/imx53-ppd.dts                    |   5 +-
 drivers/misc/Kconfig                               |   9 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/ezport-firmware.c                     | 487 +++++++++++++++++++++
 5 files changed, 516 insertions(+), 5 deletions(-)
 create mode 100644 drivers/misc/ezport-firmware.c

-- 
2.16.2
