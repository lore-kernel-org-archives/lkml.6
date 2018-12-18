Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE06C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D659D21852
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 15:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dv63YM0n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbeLRPCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 10:02:53 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42417 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbeLRPCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 10:02:53 -0500
Received: by mail-pf1-f196.google.com with SMTP id 64so8252179pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EoR9tXvS5iiZMeyLbkU3WrDtPTssA7xoNREpHrQD36c=;
        b=dv63YM0n1ELXbUR9u9DkFQXPUh4O3k9+zR/4cv0NkjBuYhfDPrYXW4s93i93i8IAAP
         4ZEJoBb/LUPzY4qrOLNV2PQ+1mxOrX1BXoLtt+WHThoy7JsqmHDemdizun7Gbb4U/vvo
         mNXnC6CDLbk3sIK9D2miSw/4XXLWJN2r6fxNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EoR9tXvS5iiZMeyLbkU3WrDtPTssA7xoNREpHrQD36c=;
        b=lLoycB4njN7UwmNAGki5pul2W4gRF3Jd2tMYIpyNlpqWwoNG6Yk0xvizlWzyJlD3+K
         Arf49k8DFd9ApGIJHyYTxPzixkL215eVbvFsZ5VW8W2o2PG5695+LJTSYAUj362zN2Ae
         EFV5qwkrpzL0Rhdl1Qq9/OhyWE8HUT0kKL7ti4xWcFrt5K78IhHAqqLsnOYGyOe2FzPu
         EBWDsE7BmHaGbTUtFXz2laKwuDpTqp2DjO4Zu2PcZTATsXT6pyytfqqJgcGAqONCaggI
         uw22UMsEc5qt1dvX7PeOQFcXyuQ5MMb7UwrbV5lq7YcYEB3NCIIjokGmVkK4Q3IWTWL/
         Cj6A==
X-Gm-Message-State: AA+aEWbKXUgvnMtNhJC9hasYF93dKfDsnlDpu1/ct+gswlJtrH+m8xsR
        ej0vvlMDnBPdlkplz2D239EH
X-Google-Smtp-Source: AFSGD/V/9h9QNNKDX1eC1wnyt7Zw/bawJozYpB39qdXqj/4gZN2qZKnr4hL+QTlNXBR+FPne5ElFww==
X-Received: by 2002:a62:7086:: with SMTP id l128mr16872918pfc.68.1545145371950;
        Tue, 18 Dec 2018 07:02:51 -0800 (PST)
Received: from localhost.localdomain ([2409:4072:702:382e:8c68:d268:ed20:5f25])
        by smtp.gmail.com with ESMTPSA id m198sm28798688pga.10.2018.12.18.07.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 07:02:51 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     olof@lixom.net, arnd@arndb.de, arm@kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-unisoc@lists.infradead.org, afaerber@suse.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, amit.kucheria@linaro.org,
        linus.walleij@linaro.org, zhao_steven@263.net,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v7 00/11] Add initial RDA8810PL SoC and Orange Pi boards support
Date:   Tue, 18 Dec 2018 20:32:27 +0530
Message-Id: <20181218150238.23010-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maintainers,

This patch series adds initial RDA8810PL SoC and Orange Pi boards (2G IoT and
i96) support. RDA8810PL is an ARM Cortex A5 based SoC with Vivante's GC860
GPU. The SoC has been added as a new ARM sub architecture with myself as the
maintainer.

More information about the boards can be found in below links:

1. Orange Pi 2G-IoT - http://www.orangepi.org/OrangePi2GIOT/
2. Orange Pi i96 - https://www.96boards.org/product/orangepi-i96/

All patches are reviewed by the corresponding subsystem maintainers. The
clocksource and irqchip patches are reviewed and merged while the serial
driver got review from Greg but I'm not sure who will apply it.

So as per my discussion with Arnd, sending the individual patches instead
of a Pull request so that the rest of the patches can go through the
ARM SoC tree.

Please consider applying it.

Thanks,
Mani

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
 arch/arm/mach-rda/Kconfig                     |   7 +
 arch/arm/mach-rda/Makefile                    |   1 +
 drivers/tty/serial/Kconfig                    |  19 +
 drivers/tty/serial/Makefile                   |   1 +
 drivers/tty/serial/rda-uart.c                 | 831 ++++++++++++++++++
 include/uapi/linux/serial_core.h              |   3 +
 17 files changed, 1122 insertions(+)
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

