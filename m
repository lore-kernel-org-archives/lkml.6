Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35ECC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4CC20869
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 14:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWe7r6FX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731354AbeL1Ozu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 09:55:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33475 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbeL1Ozt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 09:55:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so10150072plo.0;
        Fri, 28 Dec 2018 06:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=COZL0J0l0RTse5L0uNA+JnTnWbDOnaZNLMnOit8PYcY=;
        b=XWe7r6FXhbDXwiK7P4wKIbC6PfCoxreDy5jHGiW2T8ueS4fLAYDDygxk7dIp7JpAa0
         pWGljDxHc+XhmazgCALi33k9Z80Q5b4sYMHtHkYaLE3uHzCjtBjfZjsnkcJ4E3HrcOZP
         3L2M3ic6htDd1ESHghI+90z72U26iw19oDyDa2TmHGRcA1wJqmtwWR0WyIiCyIIJq5Uj
         FqkMJm72rcgtvoAuoDbHUDyAVSYNFU9efy0e+hGTxscD18AyPOh814f+3Pr0ZVLeQbXA
         /KMIswXXDuLm5710UJf7qzhwoU/8GFjKMRqw1Fog83Ak9XzGtz3bk8OHzEBn3yK/KQsD
         2hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=COZL0J0l0RTse5L0uNA+JnTnWbDOnaZNLMnOit8PYcY=;
        b=pVe+Mc1tR+AS3Kff17f2RinomCZjdsi76fNjI7x1fY6OeiUTiqi9v24TzhMKFKeip+
         Lnjzg7zlqtYjfN3Fg/i35J/zluT0kgKYAAxamA4x3y9uux80W42cazYJm43v5T73VKrt
         Iqq5PjL9wtAPEs1XSH0G9YCuD5tQzxyXgTXmrXqNKWMzyDJL8Nvs+KyItBqlXSsKwVqV
         MHLptKHfzUfCFlPfeXI8FMFJE+Slxpsaj7czhu0C9NgHnJsWG3ZEq18JFszMXpBrsZ0H
         /d1xdTOGAgvH/Ub5HHsSg115gvztHzOEvnbZGu6qPmntoRF4xCfhJWHg7sUt4tg3asak
         Me3A==
X-Gm-Message-State: AJcUukdpt2n1WhMxbXm2++ffVIVmjf0UI1JVUOzauoSpBH8iPrJ5yEQU
        82u6BWrIXjB4Q35bFYdlRjZJTH4g
X-Google-Smtp-Source: ALg8bN4L73dUKjV5tPF+Qjunv9jjYeA+mr5OsMTi4ZRGzw3nspYsAaP0+dVxJ4jtSJosHBfbeEtzpQ==
X-Received: by 2002:a17:902:9047:: with SMTP id w7mr28059660plz.270.1546008948665;
        Fri, 28 Dec 2018 06:55:48 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o84sm68793265pfi.172.2018.12.28.06.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 06:55:47 -0800 (PST)
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL resend] hwmon updates for v4.21
Date:   Fri, 28 Dec 2018 06:55:46 -0800
Message-Id: <1546008946-17600-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ First sent last Sunday. Resending now because I don't know if I will have
  internet access in the next few days. I don't know if it got lost, if it
  was rejected, or what else may have happened. If it is still in the queue,
  my apologies for the noise.  If it was rejected, I would appreciate
  feedback.

  Thanks,
  Guenter
]

Hi Linus,

Please pull hwmon updates for Linux v4.21 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-v4.21

Thanks,
Guenter
------

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-v4.21

for you to fetch changes up to 9aa3aa15f4c2f74f47afd6c5db4b420fadf3f315:

  hwmon: (lm80) fix a missing check of bus read in lm80 probe (2018-12-21 15:37:59 -0800)

----------------------------------------------------------------
hwmon updates for v4.21

The big change in this series is for the most part automatic: Introducing
SENSOR[_DEVICE]_ATTR_{RO,RW,WO} variants and conversion of various drivers
to use it. This is similar to DEVICE_ATTR variants.

Other than that, we have
- Some conversions of S_<PERMS> with octal values, also automated
- Added support for Hygon Dhyana CPUs to k10temp driver
- Added support for STLM75 to lm75 driver
- B57891S0103 to ntc_thermistor
- Added pm-runtime support to ina3221 driver
- Support for PowerPC On-Chip Controller (OCC)
- Various minor bug fices and improvements

----------------------------------------------------------------
Chris Packham (1):
      hwmon: (adt7475) document mapping of sysfs entries to inputs

Colin Ian King (1):
      hwmon: (ltc2978) Fix spelling mistake "comppatible" -> "compatible"

Corentin Labbe (2):
      hwmon: fix typo build -> built
      hwmon: Remove multiple space after dot

Eddie James (10):
      dt-bindings: fsi: Add P9 OCC device documentation
      fsi: Add On-Chip Controller (OCC) driver
      Documentation: hwmon: Add OCC documentation
      dt-bindings: i2c: Add P8 OCC hwmon device documentation
      hwmon: Add On-Chip Controller (OCC) hwmon driver
      hwmon (occ): Add command transport method for P8 and P9
      hwmon (occ): Parse OCC poll response
      hwmon (occ): Add sensor types and versions
      hwmon (occ): Add sensor attributes and register hwmon device
      hwmon (occ): Add sysfs attributes for additional OCC data

Guenter Roeck (43):
      hwmon: Introduce SENSOR_DEVICE_ATTR_{RO, RW, WO} and variants
      hwmon: (ltc2945): Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (k10temp) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (lm95234) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (nct7802) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (ltc4260) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (max6650) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (ntc_thermistor) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (pwm-fan) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (max6697) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (tmp401) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (ina2xx) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (ltc4215) Auto-convert to use SENSOR_DEVICE_ATTR_{RO, RW, WO}
      hwmon: (abx500) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (acpi_power_meter) Replace S_<PERMS> with octal values
      hwmon: (ad7314) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ad7414) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ad7418) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adc128d818) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adcxx) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adm1021) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ads1015) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ads7828) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ads7871) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adt7462) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adt7470) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adt7475) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (adt7x10) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (amc6821) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (applesmc) Replace S_<PERMS> with octal values
      hwmon: (aspeed-pwm-tacho) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (asus_atk0110) Replace S_<PERMS> with octal values
      hwmon: (coretemp) Replace S_<PERMS> with octal values
      hwmon: (da9052-hwmon) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (da9055-hwmon) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (dell-smm-hwmon) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ds1621) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ds620) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (emc1403) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (emc2103) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (emc6w201) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (fschmd) Use permission specific SENSOR[_DEVICE]_ATTR variants
      hwmon: (ftsteutates) Use permission specific SENSOR[_DEVICE]_ATTR variants

Heiko Stuebner (1):
      dt-bindings: hwmon: tmp108: add optional interrupts and #thermal-sensor-cells

Jagan Teki (1):
      hwmon: (lm75) Add STLM75 support

Kangjie Lu (2):
      hwmon: (lm80) fix a missing check of the status of SMBus read
      hwmon: (lm80) fix a missing check of bus read in lm80 probe

Kun Yi (2):
      dt-bindings: hwmon: Add adm127x documentation
      hwmon: (adm1275) Allow setting shunt reg value

Michele Sorcinelli (1):
      dell-smm-hwmon.c: Add XPS 9570 to supported devices list

Nicolin Chen (6):
      hwmon: (ina3221) Check channel status for alarms attribute read
      hwmon: (ina3221) Serialize sysfs ABI accesses
      hwmon: (ina3221) Make sure data is ready before reading
      hwmon: (ina3221) Add PM runtime support
      hwmon (lm63) Do not overwrite data->kind
      Documentation: hwmon: Add descriptions for ina2xx sysfs entries

Peter Rosin (4):
      dt-bindings: hwmon: (ntc_thermistor) add B57891S0103 thermistor from Epcos
      hwmon: (ntc_thermistor): add support for B57891S0103 from Epcos
      hwmon: (ntc_thermistor) sort thermistor id lists alphabetically
      hwmon: (ntc_thermistor) use a table to lookup the thermistor type

Pu Wen (1):
      hwmon: (k10temp) Add Hygon Dhyana support

Rasmus Villemoes (1):
      hwmon: (core) remove redundant cast

Rob Herring (1):
      hwmon: (ina3221) Convert to using %pOFn instead of device_node.name

Thierry Reding (1):
      dt-bindings: hwmon: (lm90) Document ti,tmp451 compatible string

Vadim Pasternak (1):
      hwmon: (mlxreg-fan) Modify macros for tachometer fault status reading

YueHaibing (1):
      hwmon: (asus_atk0110) Fix debugfs_simple_attr.cocci warnings

 .../devicetree/bindings/fsi/ibm,p9-occ.txt         |   16 +
 .../devicetree/bindings/hwmon/adm1275.txt          |   25 +
 Documentation/devicetree/bindings/hwmon/lm90.txt   |    1 +
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |    1 +
 Documentation/devicetree/bindings/hwmon/tmp108.txt |    4 +
 .../devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt   |   25 +
 Documentation/hwmon/adm1275                        |    3 +
 Documentation/hwmon/adt7475                        |   12 +
 Documentation/hwmon/hwmon-kernel-api.txt           |   24 +-
 Documentation/hwmon/ina2xx                         |   15 +
 Documentation/hwmon/lm75                           |    5 +
 Documentation/hwmon/occ                            |  112 ++
 drivers/fsi/Kconfig                                |   10 +
 drivers/fsi/Makefile                               |    1 +
 drivers/fsi/fsi-occ.c                              |  599 +++++++++++
 drivers/hwmon/Kconfig                              |  246 ++---
 drivers/hwmon/Makefile                             |    1 +
 drivers/hwmon/abx500.c                             |   96 +-
 drivers/hwmon/acpi_power_meter.c                   |    4 +-
 drivers/hwmon/ad7314.c                             |    9 +-
 drivers/hwmon/ad7414.c                             |   26 +-
 drivers/hwmon/ad7418.c                             |   27 +-
 drivers/hwmon/adc128d818.c                         |  135 +--
 drivers/hwmon/adcxx.c                              |   44 +-
 drivers/hwmon/adm1021.c                            |   48 +-
 drivers/hwmon/ads1015.c                            |   20 +-
 drivers/hwmon/ads7828.c                            |   20 +-
 drivers/hwmon/ads7871.c                            |   20 +-
 drivers/hwmon/adt7462.c                            |  646 +++++-------
 drivers/hwmon/adt7470.c                            |  403 +++----
 drivers/hwmon/adt7475.c                            |  308 +++---
 drivers/hwmon/adt7x10.c                            |   59 +-
 drivers/hwmon/amc6821.c                            |  229 ++--
 drivers/hwmon/applesmc.c                           |    2 +-
 drivers/hwmon/aspeed-pwm-tacho.c                   |   80 +-
 drivers/hwmon/asus_atk0110.c                       |   16 +-
 drivers/hwmon/coretemp.c                           |    2 +-
 drivers/hwmon/da9052-hwmon.c                       |  105 +-
 drivers/hwmon/da9055-hwmon.c                       |   41 +-
 drivers/hwmon/dell-smm-hwmon.c                     |   75 +-
 drivers/hwmon/ds1621.c                             |   20 +-
 drivers/hwmon/ds620.c                              |   20 +-
 drivers/hwmon/emc1403.c                            |  164 ++-
 drivers/hwmon/emc2103.c                            |   92 +-
 drivers/hwmon/emc6w201.c                           |  150 ++-
 drivers/hwmon/fschmd.c                             |  235 +++--
 drivers/hwmon/ftsteutates.c                        |  202 ++--
 drivers/hwmon/hwmon.c                              |    4 +-
 drivers/hwmon/ina2xx.c                             |   36 +-
 drivers/hwmon/ina3221.c                            |  198 +++-
 drivers/hwmon/k10temp.c                            |   13 +-
 drivers/hwmon/lm63.c                               |    1 -
 drivers/hwmon/lm75.c                               |   10 +
 drivers/hwmon/lm80.c                               |   26 +-
 drivers/hwmon/lm95234.c                            |  161 ++-
 drivers/hwmon/ltc2945.c                            |  121 +--
 drivers/hwmon/ltc4215.c                            |   42 +-
 drivers/hwmon/ltc4260.c                            |   26 +-
 drivers/hwmon/max6650.c                            |   31 +-
 drivers/hwmon/max6697.c                            |  144 ++-
 drivers/hwmon/mlxreg-fan.c                         |    2 +-
 drivers/hwmon/nct7802.c                            |  408 +++-----
 drivers/hwmon/ntc_thermistor.c                     |  184 ++--
 drivers/hwmon/occ/Kconfig                          |   31 +
 drivers/hwmon/occ/Makefile                         |    5 +
 drivers/hwmon/occ/common.c                         | 1098 ++++++++++++++++++++
 drivers/hwmon/occ/common.h                         |  128 +++
 drivers/hwmon/occ/p8_i2c.c                         |  255 +++++
 drivers/hwmon/occ/p9_sbe.c                         |  106 ++
 drivers/hwmon/occ/sysfs.c                          |  188 ++++
 drivers/hwmon/pmbus/adm1275.c                      |   15 +-
 drivers/hwmon/pmbus/ltc2978.c                      |    2 +-
 drivers/hwmon/pwm-fan.c                            |   10 +-
 drivers/hwmon/tmp401.c                             |  126 +--
 include/linux/fsi-occ.h                            |   25 +
 include/linux/hwmon-sysfs.h                        |   39 +
 include/linux/platform_data/ntc_thermistor.h       |    5 +-
 77 files changed, 5040 insertions(+), 2798 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/fsi/ibm,p9-occ.txt
 create mode 100644 Documentation/devicetree/bindings/hwmon/adm1275.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/ibm,p8-occ-hwmon.txt
 create mode 100644 Documentation/hwmon/occ
 create mode 100644 drivers/fsi/fsi-occ.c
 create mode 100644 drivers/hwmon/occ/Kconfig
 create mode 100644 drivers/hwmon/occ/Makefile
 create mode 100644 drivers/hwmon/occ/common.c
 create mode 100644 drivers/hwmon/occ/common.h
 create mode 100644 drivers/hwmon/occ/p8_i2c.c
 create mode 100644 drivers/hwmon/occ/p9_sbe.c
 create mode 100644 drivers/hwmon/occ/sysfs.c
 create mode 100644 include/linux/fsi-occ.h
