Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935249AbeEXAPk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 20:15:40 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:43701 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935173AbeEXAPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 20:15:35 -0400
X-Google-Smtp-Source: ADUXVKIZjr05DqnxpdEalp/Br0SX2wBfpb2nEkt/B+HQ2YzeiBK78fk8tjf0kr/wyXXr0rWXRjfmng==
From: Ray Jui <ray.jui@broadcom.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <ray.jui@broadcom.com>
Subject: [PATCH v3 0/6] Enhance support for the SP805 WDT
Date: Wed, 23 May 2018 17:15:18 -0700
Message-Id: <1527120924-12131-1-git-send-email-ray.jui@broadcom.com>
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
branch: sp805-wdt-v3

Changes since v2:
 - Fix indent and format to make them consistent within arm,sp805.txt

Changes since v1:
 - Consolidate two duplicated SP805 binding documents into one
 - Slight change of the wdt_is_running implementation per discussion

Ray Jui (6):
  Documentation: DT: Consolidate SP805 binding docs
  Documentation: DT: Add optional 'timeout-sec' property for sp805
  watchdog: sp805: add 'timeout-sec' DT property support
  watchdog: sp805: set WDOG_HW_RUNNING when appropriate
  arm64: dt: set initial SR watchdog timeout to 60 seconds
  arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

 .../devicetree/bindings/watchdog/arm,sp805.txt     | 29 +++++++++++++++-----
 .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
 .../arm64/boot/dts/broadcom/stingray/stingray.dtsi |  1 +
 arch/arm64/configs/defconfig                       |  1 +
 drivers/watchdog/sp805_wdt.c                       | 28 ++++++++++++++++++-
 5 files changed, 51 insertions(+), 39 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt

-- 
2.1.4
