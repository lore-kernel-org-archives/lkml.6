Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F8EC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:32:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8B6923F4B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8B6923F4B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753813AbeGEOcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:32:02 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41385 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeGEOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:32:00 -0400
Received: by mail-lf0-f68.google.com with SMTP id y127-v6so7136677lfc.8;
        Thu, 05 Jul 2018 07:31:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OQHlDav0v7DsoScgU9MQLrLO0YSWKKzrESk1g3nf+nU=;
        b=aCgMeZqiERiv6S0j36yw+KRKpkvAgwB+LnhuJSstjTWhoGhOgr9WLnpum+1LlIpmir
         c3KfHFLyKMxhn9+K2PWygBEYQVnjTodQ6LR88c/pdmSXNRtW/c5FVVF8D8x+jGTUlpTE
         sCJa9P6DzhSW4dhBIYLKBlF88Xe2zOoZVbKCcdcnvSfVn4wZfe6O1DTznwgTO6SlQysl
         edc/KDvPCMFS/wFnrq0QkausXwYmkkA7l/XxdPz+OiE0FcON9AylK/lUPWKLGFdyGicv
         DAdbcEstU2b3lQuW+lIUUfTIcBgqyNCdO261o1A2xR61+KWFYc1429WSZwbCWHisp+Y+
         jEdg==
X-Gm-Message-State: APt69E2mR1ceeBh6Ly0IINifSKDkboXg1OptM9HpXDpp6vgE70Kvh1kv
        +Ma/vm2uZ6B+sc042AjcV4WoVOxh
X-Google-Smtp-Source: AAOMgpdwXgZHXO56BySgCyjiPDLOSSd/A/p80ZiYPPXzml62L45SbT0o7MfOGrme4t+jqCx4w2M+vQ==
X-Received: by 2002:a19:c742:: with SMTP id x63-v6mr4533774lff.9.1530801118103;
        Thu, 05 Jul 2018 07:31:58 -0700 (PDT)
Received: from localhost.localdomain (82-203-172-137.bb.dnainternet.fi. [82.203.172.137])
        by smtp.gmail.com with ESMTPSA id l82-v6sm1482457lfb.8.2018.07.05.07.31.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Jul 2018 07:31:57 -0700 (PDT)
Date:   Thu, 5 Jul 2018 17:31:49 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org,
        mark.rutland@arm.com, lee.jones@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, mazziesaccount@gmail.com, arnd@arndb.de,
        dmitry.torokhov@gmail.com, sre@kernel.org, chenjh@rock-chips.com,
        andrew.smirnov@gmail.com, linus.walleij@linaro.org,
        kstewart@linuxfoundation.org, heiko@sntech.de,
        gregkh@linuxfoundation.org, eballetbo@gmail.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v10 0/2] mfd/regulator/clk/input: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <cover.1530800707.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adding support for ROHM BD71837 PMIC.

BD71837 is a programmable Power Management IC for powering single-core,
dual-core, and quad-core SoCs such as NXP-i.MX 8M. It is optimized for
low BOM cost and compact solution footprint. It integrates 8 buck
regulators and 7 LDOs to provide all the power rails required by the
SoC and the commonly used peripherals.

This is reduced set of patches containing only the MFD and devicetree
bindings. This enables alrady applied regulator part and power button
support using gpio-keys. Clock and reset support will be sent as separate
set of patches - possibly only after my vacations. Sorry for longish delay
which will follow.

Changelog v10
Fixes based on comments from Lee Jones
- Drop the platform data.
- Drop the regmap wrapper functions and use regmap directly.
- Rename files with rohm-prefix.
- Replace goto from probe by in-place returns.
- Drop unnecessary i2c_id table.
- Change gpio_keys_button array to simple struct.
- Fix return value checks for regmap functions.
- Various styling/spelling fixes.
- Replace foo-bar with something more meaningfull in DT example

Changelog v9
Fixes initiated by feedback from Enric Balletbo Serra, Lee and Dmitry.
- Simplified control flow for probe
- Removed accidentally left squash commit message
- Some comma presence toggling after last member in an array =)
- Styling of multi line comments.

Changelog v8
- Dropped clk-bd71837 from series (will send later)
- Dropped bd718xx-pwrkey driver and used gpio_keys instead.
- Added power-button short/long press duration configuratio to MFD
- Cleaned MFD driver according to comments from Enric Balletbo Serra.
  (used devm, removed unnecessary header inclusions, removed redundant
  assignment, styling issues, allow building MFD part as module, fixed
  license mismatch).

Changelog v7
- patch 1: Cleaned MFD probe since MFD no longer directly reads DT
  properties.
- patch 1/4: Moved power-key related definitions from powerkey patch (4)
  to MFD patch (1) so that powerkey can be applied independently
- Patch 2 is unchanged.
- patch 3: Added missing allocation check back to clk probe

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
        enabling clk, regulator and input subsystems.
patch 2:
        MFD driver DT bindings

This patch series is based on for-mfd-next

---

Matti Vaittinen (2):
  mfd: bd71837: mfd driver for ROHM BD71837 PMIC
  mfd: bd71837: Devicetree bindings for ROHM BD71837 PMIC

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  62 ++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/rohm-bd718x7.c                         | 198 ++++++++++++
 include/linux/mfd/rohm-bd718x7.h                   | 333 +++++++++++++++++++++
 5 files changed, 607 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 drivers/mfd/rohm-bd718x7.c
 create mode 100644 include/linux/mfd/rohm-bd718x7.h

-- 
2.14.3

