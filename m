Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751566AbeEVSrf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:47:35 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:45733 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751343AbeEVSrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:47:31 -0400
X-Google-Smtp-Source: AB8JxZrckyaNa4JfcLYEiO06EZw3AXLPCRni7+jUdrqnkpsqICopQBAXDjTTOm6S487XPDPR4b6Jxw==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH 0/5] Enhance support for the SP805 WDT
Date: Tue, 22 May 2018 11:47:15 -0700
Message-Id: <1527014840-21236-1-git-send-email-ray.jui@broadcom.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series enhances the support for the SP805 watchdog timer.
First of all, 'timeout-sec' devicetree property is added. In addition,
support is also added to allow the driver to reset the watchdog if it
has been detected that watchdot has been started in the bootloader. In
this case, the driver will initiate the ping service from the kernel
watchdog subsystem, before a user mode daemon takes over. This series
also enables SP805 in the default ARM64 defconfig

This patch series is based off v4.17-rc5 and is available on GIHUB:
repo: https://github.com/Broadcom/arm64-linux.git
branch: sp805-wdt-v1

Ray Jui (5):
  Documentation: DT: Add optional 'timeout-sec' property for sp805
  watchdog: sp805: add 'timeout-sec' DT property support
  watchdog: sp805: set WDOG_HW_RUNNING when appropriate
  arm64: dt: set initial SR watchdog timeout to 60 seconds
  arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

 .../devicetree/bindings/watchdog/sp805-wdt.txt     |  2 ++
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/watchdog/sp805_wdt.c                       | 31 +++++++++++++++++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.1.4
