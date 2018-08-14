Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0AFC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EBE21721
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 10:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45EBE21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbeHNNOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 09:14:06 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42822 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731360AbeHNNOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 09:14:05 -0400
Received: by mail-oi0-f68.google.com with SMTP id b16-v6so32572974oic.9;
        Tue, 14 Aug 2018 03:27:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=uFDgQQy5X0o3IeSCJTk9hsa2bBp6PMo1qhxz+aUzqHA=;
        b=H9yhlt4G2LbmuIrCkPlUcD9yLM7Uv1Nwkercj8+20p51g7CE7Jo1wIOOIcAnksalwL
         alvlL43WQMbkVQPedmhs91PjW7pA9MsBkdLLN2RO5nw2l6q4W8TuHeIm/F4Uxjc51lUu
         PG1m8GzGNiV7JHvxLsGTN88fB44zNZr6UtsEyMbX78bMTUy97FnAMZV6pwNNMOFd/eNN
         pDkmT8vcJdT5HYCNWB1Az+XZ8BSUX8QV2Wk6bfJrgNDiB6aPHxIEm7+ZJxF0LPbD780c
         0gFnoiJyERCTB+WOtwK81C2vh+psUnTruQ62jlI3K7Q0FVTM2TNZriXEKAvGEnUOjNNi
         DtoQ==
X-Gm-Message-State: AOUpUlESAw5Bw6CAqeVqRMVJQOLl7NPuEbivtAiGoHZxQecqDcRWs4EU
        8dk9enfNjzZBA35a0skdqGdmZt8YSq1JuksXMWJ+TayC
X-Google-Smtp-Source: AA+uWPz4FkpNVz/H0RmIyDQ1k7tkf/2CAhreivnvd6qJApDPflQF3sr3AWgmqwm5DRT176uwtsMnSMNk9/jBKGiJy74=
X-Received: by 2002:aca:6285:: with SMTP id w127-v6mr20768405oib.120.1534242452486;
 Tue, 14 Aug 2018 03:27:32 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Aug 2018 12:27:21 +0200
Message-ID: <CAJZ5v0iet7uBBQgygjm=m0DtosdCCOtELCJdWcC3hZw4UUQ40w@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v4.19-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.19-rc1

with top-most commit 76f7d6c07acd7a694ccc97355d37637f6677de51

 Merge branches 'acpi-button', 'acpi-battery' and 'acpi-osi'

on top of commit 1ffaddd029c867d134a1dde39f540dcc8c52e274

 Linux 4.18-rc8

to receive the first batch of ACPI updates for 4.19-rc1.

These revert two ACPICA commits that are not needed any more, rework
the property graphs support in ACPI to be more aligned with the
analogous DT code, add some new quirks and remove one that isn't
needed any more, add a special platform driver to enumerate multiple
I2C devices hooked up to the same device object in the ACPI tables
and update the battery and button drivers.

Specifics:

 - Revert two ACPICA commits that are not needed any more (Erik
   Schmauss).

 - Rework property graph support in the ACPI device properties
   framework to make it behave more like the analogous DT code
   and update the documentation of it (Sakari Ailus).

 - Change the default ACPI device status after initialization
   to ACPI_STA_DEFAULT instead of 0 (Hans de Goede).

 - Add a special platform driver for enumerating multiple I2C devices
   hooked up to the same object in the ACPI tables (Hans de Goede).

 - Fix the ACPI battery driver to avoid reporting full capacity on
   systems without support for that and clean it up (Hans de Goede,
   Dmitry Rozhkov, Lucas Rangit Magasweran).

 - Add two system wakeup quirks to the ACPI EC driver (Aaron Ma,
   Mika Westerberg).

 - Add the touchscreen on Dell Venue Pro 7139 to the list of "always
   present" devices to make it work (Tristian Celestin).

 - Revert a special tables handling quirk for Dell XPS 9570 and
   Precision M5530 which is not needed any more (Kai Heng Feng).

 - Add support for a new OEM _OSI string to allow system vendors to
   work around issues with NVidia HDMI audio (Alex Hung).

 - Prevent the ACPI button driver from reporting excessive system
   wakeup events and clean it up (Ravi Chandra Sadineni, Randy Dunlap).

 - Clean up two minor code style issues in the ACPI core and GHES
   handling on ARM64 (Dongjiu Geng, John Garry, Tom Todd).

Thanks!


---------------

Aaron Ma (1):
      ACPI / EC: Use ec_no_wakeup on ThinkPad X1 Yoga 3rd

Alex Hung (1):
      ACPI / OSI: Add OEM _OSI string to enable NVidia HDMI audio

Bob Moore (1):
      ACPICA: Update version to 20180629

Dmitry Rozhkov (4):
      ACPI / battery: drop inclusion of init.h
      ACPI / battery: reorder headers alphabetically
      ACPI / battery: use specialized print macros
      ACPI / battery: get rid of negations in conditions

Dongjiu Geng (1):
      arm64 / ACPI: clean the additional checks before calling ghes_notify_sea()

Erik Schmauss (2):
      ACPICA: Revert "iASL: change processing of external op namespace
nodes for correctness"
      ACPICA: Revert "iASL compiler: allow compilation of externals
with paths that refer to existing names"

Hans de Goede (5):
      ACPI / battery: Do not export energy_full[_design] on devices
without full_charge_capacity
      ACPI / scan: Initialize status to ACPI_STA_DEFAULT
      ACPI / scan: Create platform device for fwnodes with multiple i2c devices
      ACPI / x86: utils: Remove status workaround from
acpi_device_always_present()
      platform/x86: Add ACPI i2c-multi-instantiate pseudo driver

John Garry (1):
      ACPI / scan: Add static attribute to indirect_io_hosts[]

Kai Heng Feng (1):
      Revert "ACPI / bus: Parse tables as term_list for Dell XPS 9570
and Precision M5530"

Lucas Rangit Magasweran (1):
      ACPI: battery: remove redundant old_present check on insertion

Mika Westerberg (1):
      ACPI / EC: Add another entry for Thinkpad X1 Carbon 6th

Randy Dunlap (1):
      ACPI / button: fix defined but not used warning

Ravi Chandra Sadineni (1):
      ACPI / button: increment wakeup count only when notified

Sakari Ailus (11):
      ACPI: Convert ACPI reference args to generic fwnode reference args
      ACPI: property: Allow making references to non-device nodes
      ACPI: property: Document hierarchical data extension references
      ACPI: property: Make the ACPI graph API private
      ACPI: property: Allow direct graph endpoint references
      ACPI: property: Use data node name and reg property for graphs
      ACPI: property: Document key numbering for hierarchical data
extension refs
      ACPI: property: Update documentation for hierarchical data extension 1.1
      ACPI: property: graph: Fix graph documentation
      ACPI: property: graph: Improve graph documentation for port/ep numbering
      ACPI: property: graph: Update graph documentation to use generic
references

Tom Todd (1):
      ACPI: bus: Fix a pointer coding style issue

Tristian Celestin (1):
      ACPI / x86: enable touchscreen on Dell Venue Pro 7139

---------------

 Documentation/acpi/dsd/data-node-references.txt   |  89 +++++++++
 Documentation/acpi/dsd/graph.txt                  |  72 ++++----
 MAINTAINERS                                       |   6 +
 arch/arm64/mm/fault.c                             |   7 +-
 drivers/acpi/acpica/aclocal.h                     |   1 -
 drivers/acpi/acpica/nsaccess.c                    |   7 -
 drivers/acpi/acpica/nssearch.c                    |   1 -
 drivers/acpi/battery.c                            |  69 ++++---
 drivers/acpi/bus.c                                |  40 +----
 drivers/acpi/button.c                             |  17 +-
 drivers/acpi/ec.c                                 |  14 ++
 drivers/acpi/osi.c                                |   8 +
 drivers/acpi/property.c                           | 209 ++++++++++------------
 drivers/acpi/scan.c                               |  23 ++-
 drivers/acpi/x86/utils.c                          |  22 +--
 drivers/gpio/gpiolib-acpi.c                       |  11 +-
 drivers/infiniband/hw/hns/hns_roce_hw_v1.c        |  10 +-
 drivers/media/v4l2-core/v4l2-fwnode.c             |   2 +-
 drivers/net/ethernet/apm/xgene/xgene_enet_hw.c    |   6 +-
 drivers/net/ethernet/hisilicon/hns/hns_dsaf_mac.c |   6 +-
 drivers/net/ethernet/hisilicon/hns/hns_enet.c     |   8 +-
 drivers/platform/x86/Kconfig                      |  11 ++
 drivers/platform/x86/Makefile                     |   1 +
 drivers/platform/x86/i2c-multi-instantiate.c      | 132 ++++++++++++++
 include/acpi/acpixf.h                             |   2 +-
 include/acpi/ghes.h                               |   4 +
 include/linux/acpi.h                              |  25 +--
 include/linux/fwnode.h                            |   2 +-
 28 files changed, 528 insertions(+), 277 deletions(-)
