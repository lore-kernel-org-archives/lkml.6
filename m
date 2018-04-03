Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeDCSYW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 14:24:22 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:33363 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDCSYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 14:24:20 -0400
X-Google-Smtp-Source: AIpwx4+X95rRABL15/J4GI+cikB/4eIhMx5DSaTb8v6qdOUFRKWDdW6ra8aSVWyyQie3E8frTUyEhg==
Reply-To: minyard@acm.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "openipmi-developer@lists.sourceforge.net"
        <openipmi-developer@lists.sourceforge.net>
From: Corey Minyard <minyard@acm.org>
Subject: [GIT PULL] IPMI updates for 4.17
Message-ID: <8fd953b2-0d71-1edf-645a-b9d432623220@acm.org>
Date: Tue, 3 Apr 2018 13:24:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit e1171aca7da6407c0e65ffb1f38509ee4486a3e7:

   Merge tag 'xtensa-20180225' of git://github.com/jcmvbkbc/linux-xtensa 
(2018-02-25 17:02:24 -0800)

are available in the git repository at:

   https://github.com/cminyard/linux-ipmi.git tags/for-linus-4.17

for you to fetch changes up to c6185e285c5c7cfeab739bae7f206ced695f09c7:

   ipmi/parisc: Add IPMI chassis poweroff for certain HP PA-RISC and 
IA-64 servers (2018-03-27 11:04:17 -0500)

----------------------------------------------------------------
Mostly small changes, as usual.

This does add an IPMI BMC server-side driver, to allow a Linux
system to act as an IPMI controller.  That's the biggest change,
but it is just a new driver that is fairly narrow in use.

The other largish change is removing ACPI SPMI probe support,
which should have never really been there in the beginning.

-corey

----------------------------------------------------------------
Aishwarya Pant (1):
       char/ipmi: add documentation for sysfs interface

Andy Shevchenko (1):
       ipmi: Re-use existing macros for built-in properties

Colin Ian King (1):
       ipmi: use ARRAY_SIZE for poweroff_functions array sizing calculation

Corey Minyard (8):
       ipmi:pci: Make the PCI defines consistent with normal Linux ones
       ipmi: Add or fix SPDX-License-Identifier in all files
       ipmi: Fix some error cleanup issues
       ipmi: Remove some unnecessary initializations
       ipmi: Consolidate cleanup code
       ipmi: Remove ACPI SPMI probing from the SSIF (I2C) driver
       ipmi: Remove ACPI SPMI probing from the system interface driver
       ipmi:pci: Blacklist a Realtek "IPMI" device

Dan Carpenter (1):
       ipmi: missing error code in try_smi_init()

Gustavo A. R. Silva (1):
       ipmi: kcs_bmc: mark expected switch fall-through in 
kcs_bmc_handle_data

Haiyue Wang (3):
       ipmi: add a KCS IPMI BMC driver
       ipmi: add an Aspeed KCS IPMI BMC driver
       ipmi: kcs_bmc: coding-style fixes and use new poll type

Helge Deller (1):
       ipmi/parisc: Add IPMI chassis poweroff for certain HP PA-RISC and 
IA-64 servers

Kamlakant Patel (1):
       ipmi_ssif: Fix kernel panic at msg_done_handler

  .../ABI/testing/sysfs-devices-platform-ipmi        | 238 +++++++++++
  .../devicetree/bindings/ipmi/aspeed-kcs-bmc.txt    |  25 ++
  drivers/char/ipmi/Kconfig                          |  15 +
  drivers/char/ipmi/Makefile                         |   2 +
  drivers/char/ipmi/bt-bmc.c                         |   6 +-
  drivers/char/ipmi/ipmi_bt_sm.c                     |  22 +-
  drivers/char/ipmi/ipmi_devintf.c                   |  22 +-
  drivers/char/ipmi/ipmi_dmi.c                       |  20 +-
  drivers/char/ipmi/ipmi_dmi.h                       |   2 +-
  drivers/char/ipmi/ipmi_kcs_sm.c                    |  22 +-
  drivers/char/ipmi/ipmi_msghandler.c                |  22 +-
  drivers/char/ipmi/ipmi_powernv.c                   |   6 +-
  drivers/char/ipmi/ipmi_poweroff.c                  |  46 +-
  drivers/char/ipmi/ipmi_si.h                        |   1 +
  drivers/char/ipmi/ipmi_si_hardcode.c               |   1 +
  drivers/char/ipmi/ipmi_si_hotmod.c                 |   1 +
  drivers/char/ipmi/ipmi_si_intf.c                   | 192 ++++-----
  drivers/char/ipmi/ipmi_si_mem_io.c                 |   1 +
  drivers/char/ipmi/ipmi_si_parisc.c                 |   1 +
  drivers/char/ipmi/ipmi_si_pci.c                    |  44 +-
  drivers/char/ipmi/ipmi_si_platform.c               | 155 +------
  drivers/char/ipmi/ipmi_si_port_io.c                |   1 +
  drivers/char/ipmi/ipmi_si_sm.h                     |  22 +-
  drivers/char/ipmi/ipmi_smic_sm.c                   |  24 +-
  drivers/char/ipmi/ipmi_ssif.c                      | 115 +----
  drivers/char/ipmi/ipmi_watchdog.c                  |  22 +-
  drivers/char/ipmi/kcs_bmc.c                        | 467 
+++++++++++++++++++++
  drivers/char/ipmi/kcs_bmc.h                        | 108 +++++
  drivers/char/ipmi/kcs_bmc_aspeed.c                 | 320 ++++++++++++++
  include/linux/ipmi-fru.h                           |   3 +-
  include/linux/ipmi.h                               |  21 +-
  include/linux/ipmi_smi.h                           |  21 +-
  include/uapi/linux/ipmi.h                          |  20 -
  include/uapi/linux/ipmi_bmc.h                      |  16 +
  include/uapi/linux/ipmi_msgdefs.h                  |  20 -
  35 files changed, 1349 insertions(+), 675 deletions(-)
  create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-ipmi
  create mode 100644 
Documentation/devicetree/bindings/ipmi/aspeed-kcs-bmc.txt
  create mode 100644 drivers/char/ipmi/kcs_bmc.c
  create mode 100644 drivers/char/ipmi/kcs_bmc.h
  create mode 100644 drivers/char/ipmi/kcs_bmc_aspeed.c
  create mode 100644 include/uapi/linux/ipmi_bmc.h
