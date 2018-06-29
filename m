Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512D0C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16B2F27BD0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16B2F27BD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934999AbeF2IUy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:20:54 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33544 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934450AbeF2IUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:20:49 -0400
Received: by mail-lf0-f66.google.com with SMTP id u14-v6so1145808lfu.0;
        Fri, 29 Jun 2018 01:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=lfOE7nKjFoDuaGaSHoX+TjljcxfVyleqy9YTPZjg37k=;
        b=fxI//O6Vd+ltuPyyb0nDMPScqPfOHTtzs04+us7lEI9+099n6ygZjrsGq7ABo73Nmq
         UDgi7Vv9Bwqt0sce7XteX+eMcBLiGHeixCPaCb0wYgpugbaE1rph+jVwrt+r9tvQUS+4
         3OFUs6xAlvY4SGiVYM/FrVbeCmj9qM3ni519i578QU1bZBlXJfH+HyMcaoxHuCLWqxBw
         ymE9bxpHe/KLU9i/ZDNd6DRhmkbeKaY0WtEYjzHN5XgRsFYvj8jEt1CfGYOuJ7jR6t/x
         hosMbKxZuoclKOS5fPMliRyb9asPoUEUnVMH5LzBSybmrBDyleM9f49nvn3HlPI8Qeas
         ZP5w==
X-Gm-Message-State: APt69E0V6k35wCmn0GEeNoA2Eky/pV02fVgiJ+9tjrXaOVRj3jP7okS8
        LUsFDERiu09e/fvqL/YSe34Hl3iM
X-Google-Smtp-Source: AAOMgpeRsY9KyaiR1tabkKSZwXYYiL6GpKO0nv6J/zaReCb5i/RHOS51UVfeC9IGO/LJKUqF/b1UCw==
X-Received: by 2002:a19:5d54:: with SMTP id p20-v6mr8815514lfj.143.1530260447125;
        Fri, 29 Jun 2018 01:20:47 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id n9-v6sm1647965lfb.7.2018.06.29.01.20.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 01:20:46 -0700 (PDT)
Date:   Fri, 29 Jun 2018 11:20:33 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lee.jones@linaro.org, lgirdwood@gmail.com, broonie@kernel.org,
        mazziesaccount@gmail.com, arnd@arndb.de, dmitry.torokhov@gmail.com,
        sre@kernel.org, chenjh@rock-chips.com, andrew.smirnov@gmail.com,
        linus.walleij@linaro.org, kstewart@linuxfoundation.org,
        heiko@sntech.de, gregkh@linuxfoundation.org
Cc:     sboyd@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: [PATCH v8 0/2] mfd/regulator/clk/input: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <cover.1530259815.git.matti.vaittinen@fi.rohmeurope.com>
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

This is reduced set of patches containing only the MFD and devicetree
bindings. Devicetree bindings patch (2) is not changed. The MFD patch
enables alrady applied regulator part and power button support using
gpio-keys. Clock and reset support will be sent as separate set of
patches - possibly only after my vacations. Sorry for longish delay
which will follow.

Changelog v8
- Dropped clk-bd71837 from series (will send later)
- Patch 2 is unchanged.
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

 .../devicetree/bindings/mfd/rohm,bd71837-pmic.txt  |  67 ++++
 drivers/mfd/Kconfig                                |  13 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/bd71837.c                              | 220 ++++++++++++
 include/linux/mfd/bd71837.h                        | 391 +++++++++++++++++++++
 5 files changed, 692 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/rohm,bd71837-pmic.txt
 create mode 100644 drivers/mfd/bd71837.c
 create mode 100644 include/linux/mfd/bd71837.h

-- 
2.14.3

