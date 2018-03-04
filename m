Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeCDIsi (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 03:48:38 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40995 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751793AbeCDIsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 03:48:36 -0500
X-Google-Smtp-Source: AG47ELvLOuW1ENAARBgceBVMT2o/GeV7ngNErcSR20ehWrTbZ9vJS18iJIJGFOIyZTpJX+P5UaXX0A==
To: Rob Herring <robh+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ivan Gorinov <ivan.gorinov@intel.com>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Subject: [GIT PULL] of_overlay_fdt_apply() v7 for 4.17
Message-ID: <617f14dc-63f7-e59c-4fa8-813b4ebd3c34@gmail.com>
Date: Sun, 4 Mar 2018 00:48:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please pull the changes to create the overlay FDT apply API.

This is the v7 changes.

-Frank

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/frowand/linux.git tags/overlay_apply_fdt_v7-for-4.17

for you to fetch changes up to e547c0031697a0cb5ff7f4a66754fb3e082754ff:

  of: improve reporting invalid overlay target path (2018-03-04 00:29:40 -0800)

----------------------------------------------------------------
Move duplicating and unflattening of an overlay flattened devicetree
(FDT) into the overlay application code.  To accomplish this,
of_overlay_apply() is replaced by of_overlay_fdt_apply().

----------------------------------------------------------------
Frank Rowand (5):
      x86: devicetree: fix config option around x86_flattree_get_config()
      of: change overlay apply input data from unflattened to FDT
      of: Documentation: of_overlay_apply() replaced by of_overlay_fdt_apply()
      of: convert unittest overlay devicetree source to sugar syntax
      of: improve reporting invalid overlay target path

 Documentation/devicetree/overlay-notes.txt       |   4 +-
 arch/x86/kernel/devicetree.c                     |   2 +-
 drivers/of/Kconfig                               |   1 +
 drivers/of/overlay.c                             | 134 ++++++++--
 drivers/of/resolver.c                            |   6 -
 drivers/of/unittest-data/Makefile                |  28 ++-
 drivers/of/unittest-data/overlay.dts             | 101 ++++----
 drivers/of/unittest-data/overlay_0.dts           |  14 ++
 drivers/of/unittest-data/overlay_1.dts           |  14 ++
 drivers/of/unittest-data/overlay_10.dts          |  27 ++
 drivers/of/unittest-data/overlay_11.dts          |  28 +++
 drivers/of/unittest-data/overlay_12.dts          |  14 ++
 drivers/of/unittest-data/overlay_13.dts          |  14 ++
 drivers/of/unittest-data/overlay_15.dts          |  30 +++
 drivers/of/unittest-data/overlay_2.dts           |   9 +
 drivers/of/unittest-data/overlay_3.dts           |   9 +
 drivers/of/unittest-data/overlay_4.dts           |  18 ++
 drivers/of/unittest-data/overlay_5.dts           |   9 +
 drivers/of/unittest-data/overlay_6.dts           |  10 +
 drivers/of/unittest-data/overlay_7.dts           |  10 +
 drivers/of/unittest-data/overlay_8.dts           |  10 +
 drivers/of/unittest-data/overlay_9.dts           |  10 +
 drivers/of/unittest-data/overlay_bad_phandle.dts |  23 +-
 drivers/of/unittest-data/overlay_bad_symbol.dts  |  25 +-
 drivers/of/unittest-data/tests-overlay.dtsi      | 217 +---------------
 drivers/of/unittest.c                            | 300 +++++++++++------------
 include/linux/of.h                               |   6 +-
 27 files changed, 586 insertions(+), 487 deletions(-)
 create mode 100644 drivers/of/unittest-data/overlay_0.dts
 create mode 100644 drivers/of/unittest-data/overlay_1.dts
 create mode 100644 drivers/of/unittest-data/overlay_10.dts
 create mode 100644 drivers/of/unittest-data/overlay_11.dts
 create mode 100644 drivers/of/unittest-data/overlay_12.dts
 create mode 100644 drivers/of/unittest-data/overlay_13.dts
 create mode 100644 drivers/of/unittest-data/overlay_15.dts
 create mode 100644 drivers/of/unittest-data/overlay_2.dts
 create mode 100644 drivers/of/unittest-data/overlay_3.dts
 create mode 100644 drivers/of/unittest-data/overlay_4.dts
 create mode 100644 drivers/of/unittest-data/overlay_5.dts
 create mode 100644 drivers/of/unittest-data/overlay_6.dts
 create mode 100644 drivers/of/unittest-data/overlay_7.dts
 create mode 100644 drivers/of/unittest-data/overlay_8.dts
 create mode 100644 drivers/of/unittest-data/overlay_9.dts
