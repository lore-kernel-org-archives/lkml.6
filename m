Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966149AbeCAFs3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 00:48:29 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33434 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966102AbeCAFs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 00:48:26 -0500
X-Google-Smtp-Source: AG47ELu3ftvRKHRU4dNUDb3u6qbNo1vWFHRyy6fGMoWgrvlKu8Tejhp3x2PvngbSTZrtoYLfU9d+tg==
From: Derek Basehore <dbasehore@chromium.org>
To: linux-kernel@vger.kernel.org
Cc: Soby.Mathew@arm.com, sudeep.holla@arm.com, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, tglx@linutronix.de,
        briannorris@chromium.org, marc.zyngier@arm.com,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v7 0/3] GICv3 Save and Restore
Date: Wed, 28 Feb 2018 21:48:17 -0800
Message-Id: <20180301054820.42847-1-dbasehore@chromium.org>
X-Mailer: git-send-email 2.16.2.395.g2e18187dfd-goog
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

v6: Fixed reinitialized collections to only happen when the collection
is stored in the ITS. Changed error handling to avoid undefined
behavior of the ITS.

v7: Fixed pr_errs to print out the physical rather than virtual base
address of the ITS and the error code. Updated the documentation.

Derek Basehore (3):
  irqchip/gic-v3-its: add ability to save/restore ITS state
  DT/arm,gic-v3-its: add reset-on-suspend property
  irqchip/gic-v3-its: add ability to resend MAPC on resume

 .../interrupt-controller/arm,gic-v3.txt       |   5 +
 drivers/irqchip/irq-gic-v3-its.c              | 193 ++++++++++++++----
 include/linux/irqchip/arm-gic-v3.h            |   1 +
 3 files changed, 161 insertions(+), 38 deletions(-)

-- 
2.16.2.395.g2e18187dfd-goog
