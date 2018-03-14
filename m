Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751571AbeCNTpZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 15:45:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46296 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750779AbeCNTpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 15:45:24 -0400
Date: Wed, 14 Mar 2018 12:45:21 -0700
From: Darren Hart <dvhart@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>, Mario.Limonciello@dell.com,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [GIT PULL] platform-drivers-x86 for 4.16-7
Message-ID: <20180314194521.GA7096@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This addresses the Dell boot failure reported by Dominik as well as the
missing ACPI_WMI related Kconfig dependency.

As discussed, if any issues are reported against related dell drivers,
I will immediately prepare the revert back to:

94f77cb platform/x86: dell-smbios: Rename dell-smbios source to dell-smbios-base

Thanks,

Darren Hart
VMware Open Source Technology Center

The following changes since commit 32d7b19bad9695c4c9026b0ceb3a384561ddee70:

  platform/x86: dell-smbios: Resolve dependency error on DCDBAS (2018-03-09 09:35:46 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-platform-drivers-x86.git tags/platform-drivers-x86-v4.16-7

for you to fetch changes up to 49368c13217f3b4d2e2d168e88b16c74910ad0ae:

  platform/x86: Fix dell driver init order (2018-03-14 11:05:53 -0700)

----------------------------------------------------------------
platform-drivers-x86 for v4.16-7

DELL_SMBIOS conditionally depends on ACPI_WMI in the same way it depends
on DCDBAS, update the Kconfig accordingly. Correct the driver init order
to ensure that the driver dependencies are met, avoiding race conditions
resulting in boot failure on certain systems when the drivers are
built-in.

The following is an automated git shortlog grouped by driver:

dell-smbios and related drivers:
 - Fix dell driver init order
 - Resolve dependency error on ACPI_WMI

----------------------------------------------------------------
Darren Hart (1):
      platform/x86: dell-smbios: Resolve dependency error on ACPI_WMI

Darren Hart (VMware) (1):
      platform/x86: Fix dell driver init order

 drivers/firmware/dcdbas.c               | 2 +-
 drivers/platform/x86/Kconfig            | 7 ++++---
 drivers/platform/x86/dell-smbios-base.c | 2 +-
 drivers/platform/x86/dell-wmi.c         | 2 +-
 4 files changed, 7 insertions(+), 6 deletions(-)

-- 
Darren Hart
VMware Open Source Technology Center
