Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F7BC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F3E218FD
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 16:05:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVXdC+YM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfAAQFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 11:05:09 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44070 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbfAAQFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 11:05:08 -0500
Received: by mail-pl1-f195.google.com with SMTP id e11so13570736plt.11;
        Tue, 01 Jan 2019 08:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Q23qRJES+GDJpVx4jwjvtwLc/flGhzf6Q5cxd0yN1TU=;
        b=DVXdC+YMdf4UeXqoFPOEztG5yS8hUb4NNRIgcFz4uES3mBIYzttSp441+U3Jv3PiPT
         oGHdVJOJnz/6WxVTsh7rWWvcqY79hzrVdU47IQJxhDwwtDAKz8q3FsTOVuxudbyWoG9p
         OXkJOEEgab4nLZX2HZ2BbjM4wTDyA1HJP/MagjV//hi/e8neLQHvSr6fDg2zqeqqyyR6
         4nNr5utLJfSiIdZCh1oiH6TzCkL4qChC47J21Poa9ufIR+cSCh55gwoCzC04VhjrqtJQ
         ch3LU49fvm4pDoMbEj0TdUPp73Sv24ppsty4CHA7c6rjQ8uSHQnXNAq6WszeURBgvZb5
         LEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Q23qRJES+GDJpVx4jwjvtwLc/flGhzf6Q5cxd0yN1TU=;
        b=SI+L8Fp8LKidRm+nX/be2kcGDINvyA4Pi4efCjBA12QPvBUHSKw+zAFpGs1L03Wd38
         xjBvjHLaqGhER3ykX2dyC+N1zjItNzMUTE0PDoJzsi87ffFV7Pbi0YPyPKcvPxQmVjiJ
         INKdJ3l6gll7fJNcchsNDiECeZ0V9aRM6kTtzWrElTipgi2EfW2SuwTJlIZPOzK7L1sG
         FztKWiuxx+JXf/l/MEG/GJFCFVRmklncECHVp33SloAM0kotGL+RAplmFX3AwD2HbV3v
         HBrh3C1d1RF+tT8HkI3wG6ylA56dp2byIcOa90860TRqTFcprtFk1V8uw7xSQY368PGZ
         76TQ==
X-Gm-Message-State: AJcUukfvOBm4hsdgvad0Y+ysPqQ9LjHnhpMRHikkn0KlU33PxF+V3K+1
        RBW0qnVSBHvDtB/A/jowE7ALOcd+
X-Google-Smtp-Source: ALg8bN4GTQNSr0H1CYcPPN6COq/Tw3hzzXp54rMm5PiObpjtkv4bcRuE4U9sJM1haeKOTxuUjEHw1g==
X-Received: by 2002:a17:902:830a:: with SMTP id bd10mr40938361plb.321.1546358707512;
        Tue, 01 Jan 2019 08:05:07 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id r8sm118907800pgu.38.2019.01.01.08.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 08:05:06 -0800 (PST)
Date:   Tue, 1 Jan 2019 08:05:04 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Message-ID: <20190101160503.GA3306@localhost.localdomain>
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

055ddb633a35845f106fb732a07c90862e0a43e5:

  thermal: generic-adc: Fix adc to temp interpolation (2018-12-25 14:44:45 -0800)

on top of commit 0072a0c14d5b7cb72c611d396f143f5dcd73ebe2:

  Merge tag 'media/v4.20-4' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media (2018-12-03 11:29:20 -0800)

Specifics:
- Tegra DT binding documentation for Tegra194
- Armada now supports ap806 and cp110
- RCAR thermal now supports R8A774C0 and R8A77990
- Fixes on IMX, generic-ADC, ST, RCAR, Broadcom, Uniphier, QCOM, Tegra, 
  PowerClamp, and Armada

CI:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.20-rc5-42-g055ddb633a35/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.20-rc5-42-g055ddb633a35/

BR,
Eduardo

----------------------------------------------------------------
Anson Huang (2):
      thermal: imx: fix for dependency on cpu-freq
      thermal: imx: save one condition block for normal case of nvmem initialization

Arnd Bergmann (1):
      thermal: st: fix Makefile typo

Bjorn Andersson (1):
      thermal: generic-adc: Fix adc to temp interpolation

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
 drivers/thermal/uniphier_thermal.c                 |  13 +-
 .../dt-bindings/thermal/tegra194-bpmp-thermal.h    |  15 ++
 19 files changed, 398 insertions(+), 92 deletions(-)
 create mode 100644 include/dt-bindings/thermal/tegra194-bpmp-thermal.h
