Return-Path: <anholt@anholt.net>
X-Google-Smtp-Source: AG47ELvwgl4fn0AU0KaVi/jnbZq2SIG1Gv+0HqGEZr7svi4WXyETemrPIZMxkv6ldcN9D0ZOIbuu
ARC-Seal: i=1; a=rsa-sha256; t=1520281690; cv=none;
        d=google.com; s=arc-20160816;
        b=yezZ4fb6TX3rWJPnVB5cqXKWXKdxQP4CIydChKih3YW3j70QYyv201ocrh9P4+5KjN
         PrRUGZgsUhRBkGJupikHCFeWE/dzBAUfV4Rg3cEX4X1YQljpfswhY/62r01wvQ0IUghe
         Ybclb1Aq3fHu1HBhKWf6vgYK7DM2I3gzX+xYD6je0q43mpWJh7D/dIofe99HV37tvP0r
         uvZ+wGHmVo6EMN9HywyQ4Q1PW4iZLs+mb4o4ewuGcACSSD51Hpas7Y3YocXCFD76umNi
         IsD32hVDwe5a4P9CXaFQlc2phV/9jRV+ncx+xy1+ncLgJ2eqlpbT8klkgT7WieXqzCjC
         YD8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=0Ecuv5oTlWgBKwPU1gC5kyAkra5gnL2JQVDOfjiQpk8=;
        b=o8Mes8rkrBr4tJEXSPKOgCn58iMy+A7UALDT1xZcN3ZXJ8NkEpqYyD3Gmw3cDr7Tow
         /zPNvo65W96W8nNqzZQiiPlTOMOs6f4Ea7PaCl4IJ/+46BwXRGI4NaGzGzW5Om/giKMi
         gcRxRCI+APtMZFXn8fElw/BAODTlDoTO/5/dkqlnlHL6k3jscn/lC+YSCiezHsqcN5Ox
         fwXF04fK2IVPPf/sAFPaP6cenflO/H9tiJq7Gg4eoZSp00BZVr2tfbtaDKKM7SxdoAzV
         NeFyS9fdL1CftK/ZIcNXnHcEgySC6kVOAS0+5Ccd84UX0QfGjM9aFDnoBxbOBpNk0V5C
         Uzqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of anholt@anholt.net designates 50.246.234.109 as permitted sender) smtp.mailfrom=anholt@anholt.net
From: Eric Anholt <eric@anholt.net>
To: Florian Fainelli <f.fainelli@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Phil Elwell <phil@raspberrypi.org>
Cc: linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <stefan.wahren@i2se.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Eric Anholt <eric@anholt.net>
Subject: [PATCH 0/5] VCHI DT bindings
Date: Mon,  5 Mar 2018 12:28:01 -0800
Message-Id: <20180305202806.21219-1-eric@anholt.net>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594130893702898887?=
X-GMAIL-MSGID: =?utf-8?q?1594130893702898887?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series removes a gross DT property and adds a DT binding for the
VCHI driver so that we can start probing it automatically on RPi.

This is useful immediately as it lets you use vcgencmd for measuring
clocks (we have code for this in Linux but no userland interface).
It'll also be useful as a base for getting the consumer drivers to
probe automatically, which I'm expecting we'll do using a bus provided
by VCHI, since we'll be able to do some service discovery on VCHI.

VCHI itself can't just use a bus from the firmware driver, because of
the regs and interrupts -- the firmware link it has is just to allow a
request to the VPU to bring up VCHI on this hardware doorbell.

Greg: I'm good with merging patch 1 whenever, but I'd like to make
sure Stefan has a chance to take a look at the cache-line-size
property change, at least.

Eric Anholt (5):
  staging: vc04_services: Remove dead FRAGMENTS_T
  staging: vc04_services: Remove cache-line-size property.
  dt-bindings: soc: Add a binding for the Broadcom VCHI services.
  ARM: dts: bcm2835: Add VCHI node to the Raspberry Pi boards.
  staging: vc04_services: Mark the "DT bindings" job done.

 .../bindings/soc/bcm/brcm,bcm2835-vchiq.txt        | 18 ++++++++++++++++
 arch/arm/boot/dts/bcm2835-rpi.dtsi                 |  7 ++++++
 drivers/staging/vc04_services/interface/vchi/TODO  |  9 ++------
 .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---------------
 .../interface/vchiq_arm/vchiq_pagelist.h           |  6 ------
 5 files changed, 35 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/soc/bcm/brcm,bcm2835-vchiq.txt

-- 
2.16.2
