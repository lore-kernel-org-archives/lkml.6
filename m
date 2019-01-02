Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE3C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AED520836
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 20:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZ99amOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbfABUFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 15:05:41 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35053 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbfABUFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 15:05:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id z9so15631279pfi.2;
        Wed, 02 Jan 2019 12:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=FZ1r5uNVGIOtwVfH6hd6Ep+RehsVbsrTkyjvq568N3w=;
        b=gZ99amOnohh+wibaZKqCplHMeODYgQOIVf47Mf8IT3ADvJhzg3z4Ag7dtm4NqstwL2
         4QUCboRelQVKca388g1uoAH68CImktvRFXRS2MuKcqoaddhCLo/bANG2tHVxf9AZwvGj
         Z0Jy+SEqQsc7nY5EHY1hpS7H0RYrbEW0GD+ie29nncN5XG6y3ZFQKxzy0fvfM08rnIoL
         ZlUQhEuYUazYeBS/D6iGjw9taGWL8QKD1E0ApjzsGYIUedqj8W47w/OX0nON4iIafm3N
         z85bm1bhGXPkFWibGhlZIKiOP0bG81zF2N4cOBywqW7RexSgxb42ZD5qfWJXgyBh47AZ
         GBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FZ1r5uNVGIOtwVfH6hd6Ep+RehsVbsrTkyjvq568N3w=;
        b=rdD+hjpwjkr8Ua5UPfoeB4LU3qWyfDhwXgvSHUo2beHpyJy5RSX6kX6csM/Xh482qg
         8DAVq4KlXIWcEKW8RRqxtQldb3/mRD/coe/bFzvMVDk8GdMaP+Jswnud6hXmVo5Vcjrw
         U0wlUzxDeZ50yuqUnus3of9iYDFbUCGzGQbTTE9lasY430gcXQUomhKxWXANsIWnMApi
         YGZq2cgCpsSvqwYZRVDnioNMOgDWoGhiC32N68gkbiz4l7ztcGm1tbDHNWCTWau1pV5e
         Sdo/5LbV7EPyE9Qg0bC1BtzoQIDDWfw/6EJ0MQ+Zz/npidKhOdNjGkLP7/M7lWN/6ni5
         YmJQ==
X-Gm-Message-State: AA+aEWZ2CzrQPIpkaXBguwiaAjFv5n4g1BejterRI/iB8E6JrdQ7obUM
        QEQWB2F+F6MNI8AUh+XYavE=
X-Google-Smtp-Source: AFSGD/WPSTw4hVWZihPJxkKwDxSms+Mj2+JBVF+iTNtIElH5FElVTYBwsgMqyi4ddO0EBxsix/GP+A==
X-Received: by 2002:a62:83ce:: with SMTP id h197mr45452927pfe.187.1546459539047;
        Wed, 02 Jan 2019 12:05:39 -0800 (PST)
Received: from localhost.localdomain ([207.86.76.174])
        by smtp.gmail.com with ESMTPSA id g2sm72404050pfi.95.2019.01.02.12.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 12:05:38 -0800 (PST)
Date:   Wed, 2 Jan 2019 12:05:33 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL v2] Thermal-SoC management updates for v4.21-rc1
Message-ID: <20190102200532.GA2320@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

Please consider pulling from

  git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal linus

to receive Thermal-SoC Management updates for v4.21-rc1 with top-most

9d216211fded20fff301d0317af3238d8383634c:

  thermal: generic-adc: Fix adc to temp interpolation (2019-01-02 04:47:23 -0800)

on top of commit 0072a0c14d5b7cb72c611d396f143f5dcd73ebe2:

  Merge tag 'media/v4.20-4' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-12-03 11:29:20 -0800)

Specifics:
- Tegra DT binding documentation for Tegra194
- Armada now supports ap806 and cp110
- RCAR thermal now supports R8A774C0 and R8A77990
- Fixes on thermal_hwmon, IMX, generic-ADC, ST, RCAR, Broadcom, Uniphier, QCOM, Tegra, 
  PowerClamp, and Armada thermal drivers.

CI:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.20-rc5-43-g9d216211fded/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.20-rc5-43-g9d216211fded/

Also, made sure to not add new warnings on make allmodconfig, allyesconfig, allnoconfig (including x86 as well).

BR,

----------------------------------------------------------------
Anson Huang (2):
      thermal: imx: fix for dependency on cpu-freq
      thermal: imx: save one condition block for normal case of nvmem initialization

Arnd Bergmann (1):
      thermal: st: fix Makefile typo

Bjorn Andersson (1):
      thermal: generic-adc: Fix adc to temp interpolation

Eduardo Valentin (1):
      thermal: hwmon: inline helpers when CONFIG_THERMAL_HWMON is not set

Fabrizio Castro (2):
      dt-bindings: thermal: rcar-thermal: add R8A774C0 support
      thermal: rcar_thermal: add R8A774C0 support

Geert Uytterhoeven (1):
      dt-bindings: thermal: rcar-gen3-thermal: All variants use 3 interrupts

Julia Lawall (1):
      thermal: broadcom: use devm_thermal_zone_of_sensor_register

Kunihiko Hayashi (1):
      thermal: uniphier: Convert to SPDX identifier

Matthias Brugger (1):
      thermal: bcm2835: enable hwmon explicitly

Miquel Raynal (4):
      thermal: armada: add overheat interrupt support
      MAINTAINERS: thermal: add entry for Marvell MVEBU thermal driver
      dt-bindings: ap806: document the thermal interrupt capabilities
      dt-bindings: cp110: document the thermal interrupt capabilities

Srinivas Kandagatla (1):
      thermal: tsens: qcom: do not create duplicate regmap debugfs entries

Thierry Reding (1):
      dt-bindings: thermal: tegra-bpmp: Add Tegra194 support

Yangtao Li (2):
      thermal: tegra: soctherm: Change to use DEFINE_SHOW_ATTRIBUTE macro
      thermal/intel_powerclamp: Change to use DEFINE_SHOW_ATTRIBUTE macro

Yoshihiro Kaneko (2):
      dt-bindings: thermal: rcar-thermal: add R8A77990 support
      thermal: rcar_thermal: add R8A77990 support

YueHaibing (1):
      thermal: armada: Use PTR_ERR_OR_ZERO in armada_thermal_probe_legacy()

 .../arm/marvell/ap806-system-controller.txt        |   7 +
 .../arm/marvell/cp110-system-controller.txt        |   9 +
 .../thermal/nvidia,tegra186-bpmp-thermal.txt       |   3 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |   3 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   6 +-
 MAINTAINERS                                        |   5 +
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/armada_thermal.c                   | 280 ++++++++++++++++++++-
 drivers/thermal/broadcom/bcm2835_thermal.c         |  11 +
 drivers/thermal/broadcom/brcmstb_thermal.c         |  24 +-
 drivers/thermal/imx_thermal.c                      |  52 ++--
 drivers/thermal/intel_powerclamp.c                 |  14 +-
 drivers/thermal/qcom/tsens-common.c                |  12 +-
 drivers/thermal/rcar_thermal.c                     |   8 +
 drivers/thermal/st/Makefile                        |   2 +-
 drivers/thermal/tegra/soctherm.c                   |  12 +-
 drivers/thermal/thermal-generic-adc.c              |  12 +-
 drivers/thermal/thermal_hwmon.h                    |   4 +-
 drivers/thermal/uniphier_thermal.c                 |  13 +-
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h    |  15 ++
 20 files changed, 400 insertions(+), 94 deletions(-)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h
