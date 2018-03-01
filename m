Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033110AbeCAQja (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:39:30 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35226 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032988AbeCAQj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:39:28 -0500
X-Google-Smtp-Source: AG47ELv5SuHdhZoeMBF4tM4a1yHv132290FTzJeb3rj7CG9WtkYxp4RNcFQV+OmzeTigAvdiwAUxZQ==
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        jassisinghbrar@gmail.com, andy.shevchenko@gmail.com,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 0/2] add support for Socionext SynQuacer I2C controller
Date: Thu,  1 Mar 2018 16:38:13 +0000
Message-Id: <20180301163815.30595-1-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding and a driver for the I2C IP found in the Socionext SynQuacer
SoC, which is essentially a rebranded version of the Fujitsu F_I2C controller.

v4:
- clarify binding that only a single interrupt specifier is expected (#1)
- check return value of clk_prepare_enable() on probe path (#2)
- add Andy's R-b to patch #2

v3:
- incorporate more of Andy's review comments (#2), especially regarding the
  bus speed and clock source handling for ACPI
- patch #1 unchanged.

v2:
- incorporate Andy's review comments (#2)
- patch #1 unchanged.

Ard Biesheuvel (2):
  dt-bindings: i2c: add binding for Socionext SynQuacer I2C
  i2c: add support for Socionext SynQuacer I2C controller

 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt |  29 +
 drivers/i2c/busses/Kconfig                              |  10 +
 drivers/i2c/busses/Makefile                             |   1 +
 drivers/i2c/busses/i2c-synquacer.c                      | 792 ++++++++++++++++++++
 4 files changed, 832 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 create mode 100644 drivers/i2c/busses/i2c-synquacer.c

-- 
2.11.0
