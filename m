Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71C6C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981F721849
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 08:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGhyNpLB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeLRIFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 03:05:43 -0500
Received: from mail-pg1-f176.google.com ([209.85.215.176]:38705 "EHLO
        mail-pg1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbeLRIFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 03:05:43 -0500
Received: by mail-pg1-f176.google.com with SMTP id g189so7445458pgc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 00:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNnQ01QtOuLnNql7u2t1TXH3JBjCSJxCTLjx8RnrsZs=;
        b=AGhyNpLBYn3t5YLs9m7KwDZnzvwgL5He9FWKcKJPDsP/H2qb6QPvkoP3MBvfWKtnAc
         lEHGqdSiWXEmm1lXtxfMX5oNi77av22ErUHkDpi0YrrbDnb5AJDPw21fYcwBc+AyjCnp
         EeRsxH1INShwnYEpTvW7Qzv+gmBxsWA4Cw+iA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fNnQ01QtOuLnNql7u2t1TXH3JBjCSJxCTLjx8RnrsZs=;
        b=WvzgSbdaBWkY3X+fLP/mySKB5ltOZvzJdfiwxyzqhYgQKBmmnzyNCj8Tn4a74jS2Jz
         xbV52LVNPmRiJLFFp1RyrOvecCKquEPcc5opwQxq3tzre3STu1IAkjVvNjJhhMNYOtUi
         SmDl9DyU2Bar41OH+ZHJEVJtUyXiM/vuBwTDILc3SSM3alpchMpTlbeJWClq3krW2onu
         nTeoEGyWaI0gcr9x0aF6RkSr9/QfI0qbWzUX4DS22WFjQQuck4soCM8DcugGqxkFUnJ3
         DJxGrQmlW9u8OQiv/fUKirF4WDAXvABDLh6YHjnYSLvVmtr3QqY7YJ2QHs+xxKn5fsKW
         76GA==
X-Gm-Message-State: AA+aEWaKgbTt0EsVs/DBDIYz9llinX/ymFi5lIWRjaIL4N4a5Hrtevh1
        hLi0htC9Kxf2K+/C6wjL8T/2
X-Google-Smtp-Source: AFSGD/VDJXLTW+B475kSPScvDNwv5U4Utxec7tilT4zJphA1Eg6dC8SA3AX+LCqblMvn35vxYA36aA==
X-Received: by 2002:a63:4926:: with SMTP id w38mr14291485pga.353.1545120342280;
        Tue, 18 Dec 2018 00:05:42 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id 7sm45596888pfm.8.2018.12.18.00.05.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 00:05:41 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, robh+dt@kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com
Cc:     linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 00/11] Add initial RDA8810PL SoC and Orange Pi boards support
Date:   Tue, 18 Dec 2018 13:35:16 +0530
Message-Id: <20181218080527.10801-1-manivannan.sadhasivam@linaro.org>
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

Changes in v6:

* Fixed the MAINTAINERS patch commit message

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

