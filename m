Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A6DC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909AB2082B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMrPucCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909AB2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeJ0AQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:16:42 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40659 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0AQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:16:42 -0400
Received: by mail-pg1-f193.google.com with SMTP id o14-v6so712709pgv.7;
        Fri, 26 Oct 2018 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fNmfnDKPs4Mi/sBSfBzi5P6a0Wv3ilDVBeLB9S3kU0k=;
        b=rMrPucCqA/RbQR+gNjqx2lUf4a2jZ9SyIrkwIImjrt3vsYW6kyVdWfozPEv/LsSl4I
         j8LloOs6q3d69yb0jlN1uRjrm2Yh34/61GbPeUx0CZeeo3+t0toNQqUHJTWnTGKWR8ge
         d1LK5h6mlvPPGC/nipHQIL6El3acIrYI3DuOmIRoaJ35fHTufad5AQelQvZJqnDVh9Qr
         9+1oPYdaPUYylbPovs7WnECI1+eqij6U6Vdc188wNC3BUgPW2ivqQ4vFrZpl4pkU4Ly4
         DOIC/Wy7pgI21NDxBh3Jslu9nhK/vDB4p0F+2Z8R+I/3LbWYwLPfA4q1aNDENbqm3Znq
         2UhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fNmfnDKPs4Mi/sBSfBzi5P6a0Wv3ilDVBeLB9S3kU0k=;
        b=ZUg1soiO2nG3tdx2xXloQwESwNSDh60c96IH6F1tcpivjNQ2oh7VAill4Z90Zyl2C4
         Ry1TNbxNh9CkJZlJJFKixYipwU/SfiLP4CqPQJfZuZaCxVx8Nn7B1aCcYH40BHaohko3
         ExqlY/r6LhqKGY3s4EnziZcSPjMn2nka5OPSRWpvL1GneTDg7zJy+l2pmpNXkScGr6zE
         3CN2yuqOJe1pX2Frqtd7nb1CIxhMjoGsUhcgtH+8ZEj2uX9VXcDfCj08DG4IyFz9jRbe
         GnhRkoR2AWbMWwdMjX9wcS/4x5AquQnr9oVKnKrGIkhLvjl7qvMbPGYzdCy/AX1WSC1k
         XDZg==
X-Gm-Message-State: AGRZ1gIy+Q7yr/B1dm/dQ5IQHl2C+4ow/Mt9fuFnfWpc3E7jH5h3wmBr
        ht+1K6ELQLgLQEaiqfal2l0=
X-Google-Smtp-Source: AJdET5dHbllMkCenEjljLCL2E4I4MD5tX1SoHa15HjZrieH6VWUYmhrdJ2EZWxepdumhYH+houooUg==
X-Received: by 2002:a63:9b09:: with SMTP id r9-v6mr3923360pgd.307.1540568350782;
        Fri, 26 Oct 2018 08:39:10 -0700 (PDT)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id l1-v6sm12982766pgm.8.2018.10.26.08.39.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 08:39:09 -0700 (PDT)
Date:   Fri, 26 Oct 2018 08:39:05 -0700
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rui Zhang <rui.zhang@intel.com>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Thermal-SoC management updates for v4.20-rc1
Message-ID: <20181026153901.GA3744@localhost.localdomain>
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

to receive Thermal-SoC Management updates for v4.20-rc1 with top-most

760eea43f8c6d48684f1f34b8a02fddc1456e849:

  thermal: da9062/61: Prevent hardware access during system suspend (2018-10-25 10:44:55 -0700)

on top of commit 2ad0d52699700a91660a406a4046017a2d7f246a:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net (2018-08-19 11:51:45 -0700)

Several new stuff coming up. Specifics:
- Rework of tsens thermal driver
- Rework of hisi thermal driver
- OF-thermal now allows sharing multiple cooling devices on maps
- Added support for r8a7744 and R8A77970  on rcar thermal driver
- Added support for r8a774a1 on rcar_gen3 thermal driver
- New thermal driver  stm32
- Fixes on multiple thermal drivers: of-thermal, imx, qoriq, armada, qcom-spmi, rcar, da9062/61

Bot results:
Full Boot Summary: https://kernelci.org/boot/all/job/evalenti/branch/for-kernelci/kernel/v4.18-10762-g760eea43f8c6/
Full Build Summary: https://kernelci.org/build/evalenti/branch/for-kernelci/kernel/v4.18-10762-g760eea43f8c6/


BR,

Eduardo Valentin

----------------------------------------------------------------
Amit Kucheria (8):
      thermal: tsens: Prepare 8916 and 8974 tsens to use SROT and TM address space
      thermal: tsens: Add SPDX license identifiers
      thermal: tsens: Get rid of dead code
      thermal: tsens: Rename map field in order to add a second address map
      thermal: tsens: Add the SROT address map
      thermal: tsens: Pass register offsets as private data
      thermal: tsens: Check if the IP is correctly enabled by firmware
      dt-bindings: thermal: Fix a typo in documentation

Anson Huang (3):
      thermal: qoriq: add i.mx8mq support
      thermal: imx: improve error message
      thermal: imx: handle error path in one place to save duplicated code

Biju Das (1):
      dt-bindings: thermal: rcar: Add device tree support for r8a7744

Dan Carpenter (1):
      thermal: armada: fix a test in probe()

Daniel Lezcano (11):
      thermal/drivers/hisi: Change the platform data pointer to sensor ops
      thermal/drivers/hisi: Change the driver to be sensor oriented
      thermal/drivers/hisi: Set the thermal zone private data to the sensor pointer
      thermal/drivers/hisi: Factor out the probe functions
      thermal/drivers/hisi: Prepare to support multiple sensors
      thermal/drivers/hisi: Add multiple sensors support
      thermal/drivers/hisi: Replace macro name with relevant sensor location
      thermal/drivers/hisi: Use platform_get_irq_byname
      thermal/drivers/hisi: Remove pointless irq field
      thermal/drivers/hisi: Add more sensors channel
      thermal/drivers/hisi: Add the dual clusters sensors for hi3660

David HERNANDEZ SANCHEZ (2):
      dt-bindings: stm32-thermal: add binding documentation
      thermal: add stm32 thermal driver

Fabrizio Castro (2):
      thermal: rcar_gen3_thermal: Add r8a774a1 support
      dt-bindings: thermal: rcar-gen3-thermal: Add r8a774a1 support

Geert Uytterhoeven (3):
      thermal: rcar_thermal: Prevent hardware access during system suspend
      thermal: rcar_thermal: Prevent doing work after unbind
      thermal: da9062/61: Prevent hardware access during system suspend

Matthias Kaehlcke (3):
      dt-bindings: thermal: qcom-spmi-temp-alarm: Fix documentation of 'reg'
      dt-bindings: thermal: qcom-spmi-temp-alarm: Improve thermal zone in example
      thermal: qcom-spmi: Use PMIC thermal stage 2 for critical trip points

Rob Herring (1):
      thermal: Convert to using %pOFn instead of device_node.name

Sergei Shtylyov (5):
      thermal: rcar_thermal: fix duplicate IRQ request
      dt-bindings: thermal: rcar-thermal: document R8A77970 bindings
      thermal: rcar_thermal: add R8A77970 support
      dt-bindings: thermal: rcar-gen3-thermal: document R8A77980 bindings
      thermal: rcar_gen3_thermal: add R8A77980 support

Viresh Kumar (1):
      of: thermal: Allow multiple devices to share cooling map

 .../bindings/thermal/qcom-spmi-temp-alarm.txt      |  16 +-
 .../devicetree/bindings/thermal/qoriq-thermal.txt  |   6 +-
 .../bindings/thermal/rcar-gen3-thermal.txt         |   5 +-
 .../devicetree/bindings/thermal/rcar-thermal.txt   |   6 +-
 .../devicetree/bindings/thermal/stm32-thermal.txt  |  61 ++
 .../devicetree/bindings/thermal/thermal.txt        |   2 +-
 drivers/thermal/Kconfig                            |   2 +-
 drivers/thermal/Makefile                           |   2 +-
 drivers/thermal/armada_thermal.c                   |   4 +-
 drivers/thermal/da9062-thermal.c                   |   4 +-
 drivers/thermal/hisi_thermal.c                     | 249 ++++---
 drivers/thermal/imx_thermal.c                      |  31 +-
 drivers/thermal/of-thermal.c                       | 152 +++--
 drivers/thermal/qcom-spmi-temp-alarm.c             | 158 ++++-
 drivers/thermal/qcom/tsens-8916.c                  |  12 +-
 drivers/thermal/qcom/tsens-8960.c                  |  41 +-
 drivers/thermal/qcom/tsens-8974.c                  |  12 +-
 drivers/thermal/qcom/tsens-common.c                |  62 +-
 drivers/thermal/qcom/tsens-v2.c                    |   8 +-
 drivers/thermal/qcom/tsens.c                       |  19 +-
 drivers/thermal/qcom/tsens.h                       |  23 +-
 drivers/thermal/qoriq_thermal.c                    |   5 +-
 drivers/thermal/rcar_gen3_thermal.c                |   2 +
 drivers/thermal/rcar_thermal.c                     |  11 +-
 drivers/thermal/st/Kconfig                         |  14 +
 drivers/thermal/st/Makefile                        |   1 +
 drivers/thermal/st/stm_thermal.c                   | 760 +++++++++++++++++++++
 27 files changed, 1365 insertions(+), 303 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/thermal/stm32-thermal.txt
 create mode 100644 drivers/thermal/st/stm_thermal.c
