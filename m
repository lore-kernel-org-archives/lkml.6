Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965368AbeBMRA2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 12:00:28 -0500
Received: from mga05.intel.com ([192.55.52.43]:19193 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964837AbeBMRAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 12:00:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,508,1511856000";
   d="scan'208";a="34378287"
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, Mario.Limonciello@dell.com,
        Radion Mirchevsky <radion.mirchevsky@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 00/18] thunderbolt: Add support for Intel Titan Ridge
Date: Tue, 13 Feb 2018 20:00:00 +0300
Message-Id: <20180213170018.9780-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Intel Titan Ridge Thunderbolt controller.
Titan Ridge is the next generation Thunderbolt 3 controller and successor
of Alpine Ridge.

In addition to fixes and Titan Ridge support this series adds following:

  - USB only security level (SL4).

  - A new attribute for devices telling whether they were connected
    automatically during boot.

  - Preboot ACL allows userspace to specify a list of devices (based on
    device unique_id) that the firmware automatically connects during boot.

Bjorn, I've Cc'd you the series as well because I would like to get your
blessing for patch [2/18] as it uses functions from PCI subsystem.

Thanks!

Mika Westerberg (13):
  thunderbolt: Resume control channel after hibernation image is created
  thunderbolt: Serialize PCIe tunnel creation with PCI rescan
  thunderbolt: Handle connecting device in place of host properly
  thunderbolt: Do not overwrite error code when domain adding fails
  thunderbolt: Wait a bit longer for root switch config space
  thunderbolt: Wait a bit longer for ICM to authenticate the active NVM
  thunderbolt: Handle rejected Thunderbolt devices
  thunderbolt: Factor common ICM add and update operations out
  thunderbolt: Add tb_switch_get()
  thunderbolt: Add constant for approval timeout
  thunderbolt: Move driver ready handling to struct icm
  thunderbolt: Add support for preboot ACL
  thunderbolt: Introduce USB only (SL4) security level

Radion Mirchevsky (4):
  thunderbolt: Correct function name in kernel-doc comment
  thunderbolt: Add tb_switch_find_by_route()
  thunderbolt: Add tb_xdomain_find_by_route()
  thunderbolt: Add support for Intel Titan Ridge

Yehezkel Bernat (1):
  thunderbolt: Add 'boot' attribute for devices

 Documentation/ABI/testing/sysfs-bus-thunderbolt |  33 ++
 drivers/thunderbolt/dma_port.c                  |  28 +-
 drivers/thunderbolt/domain.c                    | 129 +++-
 drivers/thunderbolt/icm.c                       | 757 +++++++++++++++++++++---
 drivers/thunderbolt/nhi.c                       |   5 +-
 drivers/thunderbolt/nhi.h                       |   5 +
 drivers/thunderbolt/switch.c                    |  61 +-
 drivers/thunderbolt/tb.h                        |  14 +
 drivers/thunderbolt/tb_msgs.h                   | 180 +++++-
 drivers/thunderbolt/xdomain.c                   |  40 +-
 include/linux/thunderbolt.h                     |  19 +
 11 files changed, 1172 insertions(+), 99 deletions(-)

-- 
2.15.1
