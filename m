Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbeCJWHA (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 17:07:00 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51558 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeCJWG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 17:06:58 -0500
X-Google-Smtp-Source: AG47ELs+hvpYJYWgLlsPNbxHbjmfeSiDivcS1AsOD/g4LTmdO2UBF46t1Guw7Fl1UzwLZzfAKonevw==
Message-ID: <cb0f18f82afd7df898e58dda7ddd3e973941fcfe.camel@elementarea.net>
Subject: [PATCH v2 0/2] iio: chemical: sgp30: Support SGP30 / SGPC3 Gas
 Sensors
From: Andreas Brauchli <a.brauchli@elementarea.net>
To: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date: Sat, 10 Mar 2018 23:06:55 +0100
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.27.90-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Sensirion SGP30 and SGPC3 I2C gas
sensors.

Further product specs available from:
https://www.sensirion.com/en/environmental-sensors/gas-sensors/multi-pixel-gas-sensors/
https://www.sensirion.com/en/about-us/links/#c15360

Patch 1/2 add new IIO modifiers used by the driver
Patch 2/2 add sgp30/sgpc3 driver and documentation

Major changes to v1:
* Driver renamed to sgp30
* No or minimal sensor knowledge required to use the device:
  automatic fixed interval polling (see next point) and initialization.
* Background thread for IAQ polling
* Remove triggered-buffers support
* Add new IIO modifiers for ethanol and H2
* Support for SGPC3 product increment ("feature set 0.6") including 
  humidity compensation and an ultra-low power mode. Unfortunately, the
  datasheet for this new SGPC3 has not been released yet.
* ABI/DT Documentation

Many thanks to Peter Meerwald-Standler and Jonathan Cameron for their most valuable feedback on v1.

Andreas Brauchli (2):
  iio: Add modifiers for ethanol and H2 gases
  iio: chemical: sgp30: Support Sensirion SGPxx sensors

 Documentation/ABI/testing/sysfs-bus-iio            |    4 +
 .../ABI/testing/sysfs-bus-iio-chemical-sgp30       |   62 ++
 .../bindings/iio/chemical/sensirion,sgp30.txt      |   15 +
 Documentation/iio/chemical/sgp30.txt               |   97 ++
 drivers/iio/chemical/Kconfig                       |   13 +
 drivers/iio/chemical/Makefile                      |    1 +
 drivers/iio/chemical/sgp30.c                       | 1120 ++++++++++++++++++++
 include/uapi/linux/iio/types.h                     |    2 +
 tools/iio/iio_event_monitor.c                      |    4 +
 9 files changed, 1318 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp30
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp30.txt
 create mode 100644 Documentation/iio/chemical/sgp30.txt
 create mode 100644 drivers/iio/chemical/sgp30.c

-- 
2.15.1
