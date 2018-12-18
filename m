Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327A3217D7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 03:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="f3Ytmy/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbeLRDmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 22:42:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42721 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbeLRDmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 22:42:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so7420013pfr.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 19:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs4OFtBvTEICsxyk99pvT2Zl5zpLIGiZC2HOUjEKzsA=;
        b=f3Ytmy/LDGeCLbrL9sdHmR5darDWzsw8l4fZqkocXJ4Pxmpr267zHcK6w/taFkCvQj
         PVolR1lvpHQU8pJswlx6b0e7q1/FKul6SDXRNSaDkj37GfWCfiitiCR4pkjYrIBSS/Hu
         RSgqZYNSfendmgFKrktZ8QekMVBokp5mJ549o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hs4OFtBvTEICsxyk99pvT2Zl5zpLIGiZC2HOUjEKzsA=;
        b=g1/2j67/Rl+0BF0LDRgUEi7vxGw5USAwEoBIbikqU9/peK04+VK/LHJ2wdKmiiCbyI
         ev77vZcv3t0JL4oAvGgHsWCNouvVUV11s5Hit3p/lwbHGNjeKAVNuTxZGpgsFK/u1i91
         Mj42sPfA+zHXUz7ZKiAuL0u7+nT8grBNkjZjYMGchv4nUiVysigxgqSBGevx3fxbGhIW
         bdyux9TOZO7XCBnZeIpJyIqPuNqdpN/yYZDHFNqBNB3lMIaXk4UXQNhaDYK6EyAMmRYM
         N0KuCYlnV5BsiswlMRLJEPI0h1VPSYN/aIcIppDyeR40egH5N/jolF2MtlT1rIvoNNuf
         3PEQ==
X-Gm-Message-State: AA+aEWbwPQ/AO1xdrykU5gKLGf8X/Bfj+fbPcQD9MznHns03TJD02H1z
        q5/1Y7bQ5qdtHUxqrlZBvqVD
X-Google-Smtp-Source: AFSGD/VOwnxWXLoTmh722zFsIUvGzjAyDv3btMDEuGDp0Ed03798aQ+q+1Gi08Xi/fKPHgo5qXNNbQ==
X-Received: by 2002:a63:4b60:: with SMTP id k32mr14259363pgl.186.1545104519695;
        Mon, 17 Dec 2018 19:41:59 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id b202sm25255422pfb.88.2018.12.17.19.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 19:41:58 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v5 00/11] Add initial RDA8810PL SoC and Orange Pi boards support
Date:   Tue, 18 Dec 2018 09:11:21 +0530
Message-Id: <20181218034132.5070-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
GPU. The SoC has been added as a new ARM sub architecture with myself
and Andreas as the maintainers.

More information about the boards can be found in below links:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

This patchset is based on the initial revision sent out by Andreas long
back (http://lists.infradead.org/pipermail/linux-arm-kernel/2017-June/515951.html).

I have extended his patchset with proper irqchip and UART drivers. Now,
boards can boot into initramfs with console at UART2.

Thanks,
Mani

Changes in v5:

* Dropped timer and irqchip patches since they got applied
* Dropped Andreas from MAINTAINERS as per his request

Changes in v4:

* Added Rob's Reviewed-by tags for vendor and SoC patches.
* Moved platform Kconfig changes from timer and irqchip drivers to
  SoC support patch.
* Added Marc's Reviewed-by tag for irqchip driver.
* Addressed Rob's review comments for bindings patches.
* Added the newly created linux-unisoc mailing list to MAINTAINERS
  entry.
* Dropped overseas.sales@unisoc.com mail address as it is bouncing back.
* Modified the DTS subject prefix to ARM: from arm:

Changes in v3:

As per Marc's review:

* Removed unused header and defines from irqchip driver.
* Removed setting flow handlers from set_type callback.
* Minor code cleanups.

As per Arnd's review:

* Modified the UART indexes to start from 1 to match the SoC numbering
* Enabled exposed UARTs (all 3 on both boards)
* Modified the serial aliases as per board numbering

* Added Greg's Reviewed-by tag for serial driver.

Changes in v2:

* Used readl/writel_relaxed calls for both irqchip and timer drivers as
  per Marc's review.
* Implemented the logic to prevent counter wrapping during read as
  suggested by Marc.
* Used the timer-of API as per Daniel's suggestion.
* Added description about the timer in both commit log and driver.
* Changed the Vendor name for RDA to Unisoc Communications Inc.
* Removed the soc node level and cleaned up devicetrees as per Rob's
  review.
* Merged interrupt controller DT patch to SoC.
* Moved aliases to board dts as per Arnd's suggestion.
* Removed RDA Micro support mail address and used Unisoc one and added
  my missing signed off by tag as per Andreas's comments.

Andreas Färber (4):
  dt-bindings: Add RDA Micro vendor prefix
  dt-bindings: arm: Document RDA8810PL and reference boards
  ARM: Prepare RDA8810PL SoC
  dt-bindings: serial: Document RDA Micro UART

Manivannan Sadhasivam (7):
  ARM: dts: Add devicetree for RDA8810PL SoC
  ARM: dts: Add devicetree for OrangePi 2G IoT board
  ARM: dts: Add devicetree for OrangePi i96 board
  ARM: dts: rda8810pl: Add timer support
  ARM: dts: rda8810pl: Add interrupt support for UART
  tty: serial: Add RDA8810PL UART driver
  MAINTAINERS: Add entry for RDA Micro SoC architecture

 .../admin-guide/kernel-parameters.txt         |   6 +
 Documentation/devicetree/bindings/arm/rda.txt |  17 +
 .../bindings/serial/rda,8810pl-uart.txt       |  17 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 MAINTAINERS                                   |  14 +
 arch/arm/Kconfig                              |   2 +
 arch/arm/Makefile                             |   1 +
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/rda8810pl-orangepi-2g-iot.dts    |  50 ++
 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts  |  50 ++
 arch/arm/boot/dts/rda8810pl.dtsi              |  99 +++
 arch/arm/mach-rda/Kconfig                     |   9 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 17 files changed, 1124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rda.txt
 create mode 100644 Documentation/devicetree/bindings/serial/rda,8810pl-uart.txt
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-2g-iot.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl-orangepi-i96.dts
 create mode 100644 arch/arm/boot/dts/rda8810pl.dtsi
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile
 create mode 100644 drivers/tty/serial/rda-uart.c

-- 
2.17.1

