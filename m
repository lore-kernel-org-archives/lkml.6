Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 51EACC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E4C208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 13:27:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E4C208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936310AbeFON14 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 09:27:56 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33789 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933771AbeFON1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 09:27:54 -0400
Received: by mail-lf0-f66.google.com with SMTP id y20-v6so14675904lfy.0;
        Fri, 15 Jun 2018 06:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=8v3iiBIfazu7RygOJKYjPqvSR3V1dwLZAuD2Tt/2OWU=;
        b=ILbFmX/EU0Rjqa0nBM1TjS/2j/4aGIdH5CVehmlFz0mZDM1kUNbhF6QPOsX3HpNIlT
         +z56JYv5zjUUrQFOdmlgBjCGY3wMTVPaFvXeeIxLGx4RpmvE9umKA/jHg/aRETrL0ciG
         y1yDhEVNWW5i5qq+x++pbXUy57ESW5RFlXLCZ8E+42V41D0LZ8ZuzpxEpK2XCl5qmCt2
         5eRZXQolssqdEVQzHNNfrFLVNB6Vx2q1xAVv9Y41snw+gvtmmOA5cDB5J4hlckqRMfpi
         3lLWMhn2Q44SDfNTpaZupqR16tIP9A4UrVXF2gBjfClEn5E5AlFhzOzTDrHEyUwRIKjP
         kbFQ==
X-Gm-Message-State: APt69E3N4tsn3dGxFEdaZA5dmaoHlf4LQcI6l3puD4/zbWRp604gp33k
        WCMkEEOEs/iBnFrOnyzKkyY=
X-Google-Smtp-Source: ADUXVKKC1JtT7f2oYb3QkuzY6VUO8mQJK2cNahWfX7knm/s+s1cZmcmaamX8elH4ktb6i9ng++A+cQ==
X-Received: by 2002:a2e:6a07:: with SMTP id f7-v6mr1338035ljc.109.1529069272219;
        Fri, 15 Jun 2018 06:27:52 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id q2-v6sm1457935ljg.90.2018.06.15.06.27.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jun 2018 06:27:51 -0700 (PDT)
Date:   Fri, 15 Jun 2018 16:27:43 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v6 0/4] mfd/regulator/clk/input: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <cover.1529067662.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding support for ROHM BD71837 PMIC.

BD71837 is a programmable Power Management IC for powering single-core,
dual-core, and quad-core SoC’s such as NXP-i.MX 8M. It is optimized for
low BOM cost and compact solution footprint. It integrates 8 buck
regulators and 7 LDO’s to provide all the power rails required by the
SoC and the commonly used peripherals.

Rewgulator part is already applied. This is reduced set of patches
containing the MFD part, clock gate for 32.768 KHz clock buffer, input
driver for power button and device-tree bindings for MFD.

Changelog v6
- Added power-key input driver
Based on feedback from Rob Herring and Stephen Boyd
- Added link to datasheet
- Removed interrupt-controller from DT and fixed binding document
- clk styling fixes
- remove clkdev usage
- add clk bindings to MFD documentation
- removed clk binding document

Changelog v5
- dropped regulator patches which are already applied to Mark's tree
Based on feedback from Rob Herring and Stephen Boyd
- mfd bindings: explain why this can be interrupt-controller
- mfd bindings: describe interrupts better
- mfd bindings: require one cell interrupt specifier
- mfd bindings: use generic node names in example
- mfd driver:   ack masked interrupt once at init
- clk bindings: use generic node names in example
- clk driver:   use devm
- clk driver:   use of_clk_add_hw_provider
- clk driver:   change severity of print and how prints are emitted at
                probe error path.
- clk driver:   dropped forward declared functions
- clk configs:  drop unnecessary dependencies
- clk driver:   other styling issues
- mfd/clk DT:   drop clk node.

Changelog v4
- remove mutex from regulator state check as core prevents simultaneous
  accesses
- allow voltage change for bucks 1 to 4 when regulator is enabled
- fix indentiation problems
- properly correct SPDX comments

Changelog v3
- kill unused variable
- kill unused definitions
- use REGMAP_IRQ_REG

Changelog v2
Based on feedback from Mark Brown
- Squashed code and buildfile changes to same patch
- Fixed some styling issues
- Changed SPDX comments to CPP style
- Error out if voltage is changed when regulator is enabled instead of
  Disabling the regulator for duration of change
- Use devm_regulator_register
- Remove compatible usage from regulators - use parent dev for config
- Add a note about using regulator-boot-on for BUCK6 and 7
- fixed warnings from kbuild test robot

patch 1:
        MFD driver and definitions bringing interrupt support and
        enabling clk and regulator subsystems.
patch 2:
        MFD driver DT bindings
patch 3:
        clock driver for BD71837 clock output
patch 4:
        power button driver for power button connected to BD71837

This patch series is based on for-mfd-next

---

Matti Vaittinen (4):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC
  clk: bd71837: Add driver for BD71837 PMIC clock
  input/power: Add driver for BD71837/BD71847 PMIC power button

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  67 ++++
 drivers/clk/Kconfig                                |   6 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/clk-bd71837.c                          | 145 ++++++++
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/bd718xx-pwrkey.c                |  90 +++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bd71837.c                              | 249 ++++++++++++++
 include/linux/mfd/bd71837.h                        | 370 +++++++++++++++++++++
 11 files changed, 953 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 drivers/clk/clk-bd71837.c
 create mode 100644 drivers/input/misc/bd718xx-pwrkey.c
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 include/linux/mfd/bd71837.h

-- 
2.14.3

