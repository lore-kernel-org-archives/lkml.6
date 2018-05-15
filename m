Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeEOCyO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:54:14 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46481 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752295AbeEOCyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:54:09 -0400
X-Google-Smtp-Source: AB8JxZq4v/0B9thu3Gt/GYximp1JljIi/XnmnCZPl/s3x1DGHQ2uFqOgLk+kKOx1H95WuJGntpel7Q==
From: Leo Yan <leo.yan@linaro.org>
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 0/5] Hi3660: enable power management features
Date: Tue, 15 May 2018 10:53:10 +0800
Message-Id: <1526352795-6991-1-git-send-email-leo.yan@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since hi3660 drivers have been merged into Linux kernel (mailbox driver is in
Linux-next branch and other drivers are existed in Linux mainline kernel), so
this patch series is to enable power management features on hi3660.

This patch series includes device tree binding for mailbox, stub clock and CPU
OPPs, and has one patch to consolidate the Kconfigs for driver modules.

This patch set have been tested on Hikey960 and also verified the patch 'hisi:
Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX' for Hikey620.

Changes from v1:
* Changed patch subject from "dts: arm64: hi3660" to "arm64: dts: hi3660".


Daniel Lezcano (1):
  hisi: Consolidate the Kconfigs for the CLOCK_STUB and the MAILBOX

Kaihua Zhong (2):
  arm64: dts: hi3660: Add mailbox node
  arm64: dts: hi3660: Add stub clock node

Leo Yan (1):
  arm64: dts: hi3660: Add CPU frequency scaling support

Tao Wang (1):
  arm64: dts: hi3660: Add thermal cooling management

 arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 145 ++++++++++++++++++++++++++++++
 arch/arm64/configs/defconfig              |   1 -
 drivers/clk/hisilicon/Kconfig             |  13 +--
 drivers/mailbox/Kconfig                   |  12 ++-
 4 files changed, 161 insertions(+), 10 deletions(-)

-- 
1.9.1
