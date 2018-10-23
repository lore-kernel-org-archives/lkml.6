Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7568C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D3020671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lj7KwYYJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77D3020671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbeJWTJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:09:14 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53132 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeJWTJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:09:14 -0400
Received: by mail-wm1-f68.google.com with SMTP id 189-v6so1259332wmw.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 03:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=wiZEY391vn1lvOosCd/vk7TYWhaJ3jt9kxjf8txIWuI=;
        b=Lj7KwYYJVrNLUxjGBdGaZ0jdMXd+ExoBF4Mql1zXMFdlpifxVwBPNv1tftOcQvLDR1
         tOpueGv4r7MbrBjmaUUedjI0CggGmIyrphIVucxEXMFrjljpNv39VzDb931bHkQrihsC
         hlEFotfE4jjGTtGO5/Qf3e58XuhuP2YRVfqTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=wiZEY391vn1lvOosCd/vk7TYWhaJ3jt9kxjf8txIWuI=;
        b=Gty59d8XtqXSwmagd+sBjeANs7tX4Cs4wDjcBFM3HDVSsQPDJ6Olm1GUdDhE4iGkVJ
         dyGP71s9uNjfOY9SzuzLylPa2MiVulr4RUXqsNinLlPpbCx2Z2PrPBsP/BE1y4KMHuRE
         RqjCzhYB+5/HiqmXXloBYyikflBIy9q4YpPYsxl27TSJ/+tWXDOgjRqpYti+Si4PNdU7
         Rsxs55MYVe6o6jaoiVLHyL0kGTv6oDnnDG87H4dav97FM+tY7U0/Ipp0p/Nhv8nyrmlz
         chPJ4NcPO/TBpwYoi652FtN5FtLBfhF8MyBiKB8uTTi9Ro2MZdIMXUXAVoxi0WahROMG
         90dA==
X-Gm-Message-State: ABuFfoia8cyWpZVwLBzvlcmHqhx1N9GWZ8oltbw7usNxd2brbK36M/6J
        ig9jSWMgl8j2LPoTuoc3rKdi++s1u7Q=
X-Google-Smtp-Source: ACcGV60zVZbkn/+xxdPPMLf9ytXD0qkUuKPZeTOwfZUmn2hA266KmcokPlTVcg1dQbFyRLTsN4jpvA==
X-Received: by 2002:a1c:c90f:: with SMTP id f15-v6mr19673042wmb.48.1540291578782;
        Tue, 23 Oct 2018 03:46:18 -0700 (PDT)
Received: from dell ([2.27.167.33])
        by smtp.gmail.com with ESMTPSA id u13-v6sm657383wrn.11.2018.10.23.03.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 03:46:17 -0700 (PDT)
Date:   Tue, 23 Oct 2018 11:46:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] MFD for v4.20
Message-ID: <20181023104616.GX4939@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Welcome back.

Enjoy!

The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-4.20

for you to fetch changes up to 6eb357844373f833f085e63e6c8c026a61568c57:

  mfd: cros_ec: Avoid unneeded internal declaration warning (2018-10-23 08:58:34 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for USART SPI to AT91*

 - New Functionality
   - Add support for Audio CODECs to motorola-cpcap

 - Fix-ups
   - DT documentation fix-ups; atmel-usart
   - Staticise functions/structs; spi-at91-usart, arizona-core
   - Constify; ti-lmu
   - Fix memory leaks; menelaus
   - Change device 'wake-up' status; ti_am335x_tscadc, max8997
   - Power Management (suspend/resume) semantic changes; ti_am335x_adc, cros_ec, max8997
   - SPDX churn; sec-core (+ headers), max* (+ headers), intel* (+ headers),
   - Trivial (whitespace, email addresses, alphabetisise); Kconfig, adp5520, intel_soc_pmic_*
   - Build as module; sec-irq
   - Use new %pOFn printk format for device_node.name; max77620
   - Remove unused code; madera
   - Use generic MACROs; intel_msic, intel_soc_pmic_crc
   - Move to GPIOD; ti-lmu
   - Use managed resources; ti-lmu

 - Bug Fixes
   - Add missing headers; at91-usart
   - Prevent device from entering low-power mode; arizona-core
   - Poll for BOOT_DONE to avoid still-booting NACK; madera-core
   - Prevent ADC read from shutting down device; mc13xxx-core

----------------------------------------------------------------
Alexandre Belloni (1):
      mfd: menelaus: Fix possible race condition and leak

Andy Shevchenko (7):
      mfd: intel_msic: Use DEFINE_RES_IRQ() macro
      mfd: intel_soc_pmic_crc: Use DEFINE_RES_IRQ_NAMED() macro
      mfd: intel_soc_pmic_crc: Use REGMAP_IRQ_REG() macro
      mfd: intel_soc_pmic_bxtwc: Chain power button IRQs as well
      mfd: Sort headers alphabetically for Intel PMIC drivers
      mfd: Convert Intel PMIC drivers to use SPDX identifier 1;5201;0c Reduce size of duplicated comments by switching to use SPDX identifier.
      MAINTAINERS: Add myself as designated reviewer of Intel MFD PMIC

Colin Ian King (1):
      mfd: arizona: Make array mclk_name static, shrinks object size

Fabio Estevam (1):
      mfd: mc13xxx-core: Fix PMIC shutdown when reading ADC values

Krzysztof Kozlowski (4):
      mfd: sec-core: Add SPDX license identifiers
      mfd: maxim: Add SPDX license identifiers
      mfd: sec-core: Fix indentation of Kconfig description
      mfd: sec-core: Allow building as module

Lee Jones (5):
      dt-bindings: mfd: atmel-usart: Correct interrupts property to include IRQ number
      MAINTAINERS: Change Radu's email address
      spi: at91-usart: Make local functions static
      mfd: at91-usart: Include Device Tree header
      Merge branches 'ib-mfd-iio-input-4.20', 'ib-mfd-irqchip-4.20', 'ib-mfd-rtc-4.20' and 'ib-mfd-spi-tty-4.20-1' into ibs-for-mfd-merged

Marek Szyprowski (2):
      mfd: max8997: Enale irq-wakeup unconditionally
      mfd: max8997: Disable interrupt handling for suspend/resume cycle

Michael Hennerich (1):
      mfd: adp5520: Update MODULE AUTHOR email address

Nathan Chancellor (1):
      mfd: cros_ec: Avoid unneeded internal declaration warning

Paul Cercueil (1):
      mfd: Add ingenic-tcu.h header

Pavel Machek (3):
      mfd: ti-lmu: Switch to GPIOD
      mfd: ti-lmu: Use managed resource for everything
      mfd: ti-lmu: Use of_device_get_match_data() helper

Radu Pirea (6):
      MAINTAINERS: Add AT91 USART MFD entry
      dt-bindings: Add binding for atmel-usart in SPI mode
      mfd: at91-usart: Add MFD driver for USART
      MAINTAINERS: Add AT91 USART SPI entry
      spi: at91-usart: Add driver for at91-usart as SPI
      tty/serial: atmel: Change the driver to work under at91-usart MFD

RaviChandra Sadineni (1):
      mfd: cros_ec: Check for mkbp events on resume only if supported.

Richard Fitzgerald (3):
      mfd: madera: Add irqchip data pointer into struct madera
      mfd: madera: Don't use regmap_read_poll_timeout to poll for BOOT_DONE
      mfd: madera: Remove unused forward reference

Rob Herring (1):
      mfd: max77620: Convert to using %pOFn instead of device_node.name

Sapthagiri Baratam (1):
      mfd: arizona: Correct calling of runtime_put_sync

Sebastian Reichel (2):
      mfd: motorola-cpcap: Add audio-codec support
      mfd: ti-lmu: constify mfd_cell tables

Vignesh R (5):
      mfd: ti_am335x_tscadc: Don't mark TSCADC MFD as wakeup capable
      Input: ti_am335x_tsc: Mark TSC device as wakeup source
      mfd: ti_am335x_tscadc: Keep ADC interface on if child is wakeup capable
      iio: adc: ti_am335x_adc: Disable ADC during suspend unconditionally
      Input: ti_am335x_tsc: Mark IRQ as wakeup capable

 Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt |  25 +-
 MAINTAINERS                                                       |  24 ++
 drivers/iio/adc/ti_am335x_adc.c                                   |  12 +-
 drivers/input/touchscreen/ti_am335x_tsc.c                         |  22 +-
 drivers/mfd/Kconfig                                               |  26 +-
 drivers/mfd/Makefile                                              |   1 +
 drivers/mfd/adp5520.c                                             |   2 +-
 drivers/mfd/arizona-core.c                                        |  10 +-
 drivers/mfd/at91-usart.c                                          |  72 +++++
 drivers/mfd/cros_ec.c                                             |   3 +-
 drivers/mfd/cros_ec_dev.c                                         |   1 +
 drivers/mfd/intel_msic.c                                          |  49 +---
 drivers/mfd/intel_soc_pmic_bxtwc.c                                |  56 ++--
 drivers/mfd/intel_soc_pmic_chtdc_ti.c                             |   5 +-
 drivers/mfd/intel_soc_pmic_chtwc.c                                |   5 +-
 drivers/mfd/intel_soc_pmic_core.c                                 |  25 +-
 drivers/mfd/intel_soc_pmic_core.h                                 |  12 +-
 drivers/mfd/intel_soc_pmic_crc.c                                  |  78 ++----
 drivers/mfd/madera-core.c                                         |  33 ++-
 drivers/mfd/max14577.c                                            |  28 +-
 drivers/mfd/max77620.c                                            |   2 +-
 drivers/mfd/max77686.c                                            |  32 +--
 drivers/mfd/max77693.c                                            |  34 +--
 drivers/mfd/max77843.c                                            |  19 +-
 drivers/mfd/max8997-irq.c                                         |  30 +--
 drivers/mfd/max8997.c                                             |  40 +--
 drivers/mfd/max8998-irq.c                                         |  18 +-
 drivers/mfd/max8998.c                                             |  28 +-
 drivers/mfd/mc13xxx-core.c                                        |   3 +-
 drivers/mfd/menelaus.c                                            |  13 +-
 drivers/mfd/motorola-cpcap.c                                      |  51 +++-
 drivers/mfd/sec-core.c                                            |  16 +-
 drivers/mfd/sec-irq.c                                             |  24 +-
 drivers/mfd/ti-lmu.c                                              |  91 +++----
 drivers/mfd/ti_am335x_tscadc.c                                    |  14 +-
 drivers/spi/Kconfig                                               |   8 +
 drivers/spi/Makefile                                              |   1 +
 drivers/spi/spi-at91-usart.c                                      | 432 ++++++++++++++++++++++++++++++
 drivers/tty/serial/Kconfig                                        |   1 +
 drivers/tty/serial/atmel_serial.c                                 |  42 +--
 include/dt-bindings/mfd/at91-usart.h                              |  17 ++
 include/linux/mfd/ingenic-tcu.h                                   |  56 ++++
 include/linux/mfd/intel_msic.h                                    |   7 +-
 include/linux/mfd/intel_soc_pmic.h                                |  13 +-
 include/linux/mfd/intel_soc_pmic_bxtwc.h                          |  10 +-
 include/linux/mfd/madera/core.h                                   |   2 +
 include/linux/mfd/madera/pdata.h                                  |   1 -
 include/linux/mfd/max14577-private.h                              |  11 +-
 include/linux/mfd/max14577.h                                      |  11 +-
 include/linux/mfd/max77686-private.h                              |  15 +-
 include/linux/mfd/max77686.h                                      |  15 +-
 include/linux/mfd/max77693-common.h                               |   6 +-
 include/linux/mfd/max77693-private.h                              |  15 +-
 include/linux/mfd/max77693.h                                      |  15 +-
 include/linux/mfd/max77843-private.h                              |   6 +-
 include/linux/mfd/max8997-private.h                               |  15 +-
 include/linux/mfd/max8997.h                                       |  16 +-
 include/linux/mfd/max8998-private.h                               |  15 +-
 include/linux/mfd/max8998.h                                       |  15 +-
 include/linux/mfd/mc13xxx.h                                       |   1 +
 include/linux/mfd/samsung/core.h                                  |  11 +-
 include/linux/mfd/samsung/irq.h                                   |  10 +-
 include/linux/mfd/samsung/rtc.h                                   |  15 +-
 include/linux/mfd/samsung/s2mpa01.h                               |   7 +-
 include/linux/mfd/samsung/s2mps11.h                               |   9 +-
 include/linux/mfd/samsung/s2mps13.h                               |  14 +-
 include/linux/mfd/samsung/s2mps14.h                               |  14 +-
 include/linux/mfd/samsung/s2mps15.h                               |  11 +-
 include/linux/mfd/samsung/s2mpu02.h                               |  14 +-
 include/linux/mfd/samsung/s5m8763.h                               |  10 +-
 include/linux/mfd/samsung/s5m8767.h                               |  10 +-
 include/linux/mfd/ti-lmu.h                                        |   3 +-
 72 files changed, 1045 insertions(+), 733 deletions(-)
 rename Documentation/devicetree/bindings/{serial => mfd}/atmel-usart.txt (76%)
 create mode 100644 drivers/mfd/at91-usart.c
 create mode 100644 drivers/spi/spi-at91-usart.c
 create mode 100644 include/dt-bindings/mfd/at91-usart.h
 create mode 100644 include/linux/mfd/ingenic-tcu.h

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
