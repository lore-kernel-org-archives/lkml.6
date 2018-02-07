Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932274AbeBGBl2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 20:41:28 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38463 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932200AbeBGBlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 20:41:25 -0500
X-Google-Smtp-Source: AH8x225BhqgDAdEZAiYumeagfk2Ij4tjCIzMDloMru4zUfcIYpWdvdTVSeFXIcGAUH95/zq23+BWGA==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v5 0/5] GICv3 Save and Restore
Date: Tue,  6 Feb 2018 17:41:13 -0800
Message-Id: <20180207014117.62611-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A lot of changes in v2. The distributor and redistributor saving and
restoring is left to the PSCI/firmware implementation after
discussions with ARM. This reduces the line changes by a lot and
removes now unneeded patches.

Patches are verified on an RK3399 platform with pending patches in the
ARM-Trusted-Firmware project.

Just a couple minor changes in v3 to formatting.

Fixed a false ITS wedged detection due to the cmd_write and creadr
offsets not matching up on reset in v4. Also minor formatting changes.

Got rid of additional device tree property with detecting if there are
collections stored in the ITS in v5. Made other minor changes.

Derek Basehore (4):
  cpu_pm: add syscore_suspend error handling
  irqchip/gic-v3-its: add ability to save/restore ITS state
  DT/arm,gic-v3-its: add reset-on-suspend property
  irqchip/gic-v3-its: add ability to resend MAPC on resume

 .../bindings/interrupt-controller/arm,gic-v3.txt   |   3 +
 drivers/irqchip/irq-gic-v3-its.c                   | 179 ++++++++++++++++-----
 include/linux/irqchip/arm-gic-v3.h                 |   1 +
 kernel/cpu_pm.c                                    |   3 +
 4 files changed, 148 insertions(+), 38 deletions(-)

-- 
2.16.0.rc1.238.g530d649a79-goog
