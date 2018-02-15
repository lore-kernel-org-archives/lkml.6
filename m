Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164280AbeBOWSP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 17:18:15 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:41716 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163612AbeBOWSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 17:18:13 -0500
X-Google-Smtp-Source: AH8x225MxUkhOKq1tiXyEUCvHDkWjkcdi95otaJkGU1XhVaL8edv6vh3weg6PZMDmybpwCiBGFcDZWTNrKxyzwEXzT4=
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 15 Feb 2018 23:18:12 +0100
X-Google-Sender-Auth: QoIy35cKdIb1l-EtMeSSW9HzG4g
Message-ID: <CAJZ5v0gvN5hGZMt4kceyAJhbpJdyJdbCArWgWO2F07d02zN0Ug@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v4.16-rc2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-4.16-rc2

with top-most commit 31a3be353fc21f13e2ccdc661cda253f78b16661

 Merge branches 'acpi-ec', 'acpi-tables' and 'acpi-doc'

on top of commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2

 Linux 4.16-rc1

to receive ACPI updates for 4.16-rc2.

These fix a system resume regression from the 4.13 cycle, clean up
device table handling in the ACPI core, update sysfs ABI documentation
of a couple of drivers and add an expected switch fall-through marker
to the SPCR table parsing code.

Specifics:

 - Revert a problematic EC driver change from the 4.13 cycle that
   introduced a system resume regression on Thinkpad X240 (Rafael
   Wysocki).

 - Clean up device tables handling in the ACPI core and the related
   part of the device properties framework (Andy Shevchenko).

 - Update the sysfs ABI documentatio of the dock and the INT3407
   special device drivers (Aishwarya Pant).

 - Add an expected switch fall-through marker to the SPCR table
   parsing code (Gustavo Silva).

Thanks!


---------------

Aishwarya Pant (2):
      ACPI / DPTF: Document dptf_power sysfs atttributes
      ACPI: dock: document sysfs interface

Andy Shevchenko (4):
      ACPI / bus: Do not traverse through non-existed device table
      ACPI / bus: Remove checks in acpi_get_match_data()
      ACPI / bus: Rename acpi_get_match_data() to acpi_device_get_match_data()
      device property: Constify device_get_match_data()

Gustavo A. R. Silva (1):
      ACPI: SPCR: Mark expected switch fall-through in acpi_parse_spcr

Rafael J. Wysocki (1):
      ACPI / EC: Restore polling during noirq suspend/resume phases

---------------

 .../ABI/testing/sysfs-devices-platform-dock        | 39 +++++++++++
 Documentation/ABI/testing/sysfs-platform-dptf      | 40 ++++++++++++
 drivers/acpi/bus.c                                 | 75 ++++++++++++----------
 drivers/acpi/ec.c                                  |  6 ++
 drivers/acpi/property.c                            |  4 +-
 drivers/acpi/spcr.c                                |  1 +
 drivers/base/property.c                            |  5 +-
 drivers/of/property.c                              |  4 +-
 include/linux/acpi.h                               |  4 +-
 include/linux/fwnode.h                             |  4 +-
 include/linux/property.h                           |  2 +-
 11 files changed, 138 insertions(+), 46 deletions(-)
