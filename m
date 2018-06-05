Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbeFES6l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbeFES6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:58:40 -0400
Date: Tue, 5 Jun 2018 20:58:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Driver core patches for 4.18-rc1
Message-ID: <20180605185816.GC24892@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6da6c0db5316275015e8cc2959f12a17584aeb64:

  Linux v4.17-rc3 (2018-04-29 14:17:42 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git/ tags/driver-core-4.18-rc1

for you to fetch changes up to 8c97a46af04b4f7c0a0dded031fef1806872e648:

  driver core: hold dev's parent lock when needed (2018-05-31 10:12:07 +0200)

----------------------------------------------------------------
Driver core changes for 4.18-rc1

Here is the driver core patchset for 4.18-rc1.

The large chunk of these are firmware core documentation and api
updates.  Nothing major there, just better descriptions for others to be
able to understand the firmware code better.  There's also a user for a
new firmware api call.

Other than that, there are some minor updates for debugfs, kernfs, and
the driver core itself.

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andres Rodriguez (6):
      firmware: wrap FW_OPT_* into an enum
      firmware: use () to terminate kernel-doc function names
      firmware: rename fw_sysfs_fallback to firmware_fallback_sysfs()
      firmware: add firmware_request_nowarn() - load firmware without warnings
      ath10k: use firmware_request_nowarn() to load firmware
      ath10k: re-enable the firmware fallback mechanism for testmode

Andy Shevchenko (1):
      debugfs: Re-use kstrtobool_from_user()

Arvind Yadav (1):
      mm: memory_hotplug: use put_device() if device_register fail

Florian Schmaus (1):
      driver-core: return EINVAL error instead of BUG_ON()

Greg Kroah-Hartman (1):
      Merge 4.17-rc3 into driver-core-next

Luis R. Rodriguez (8):
      firmware_loader: document firmware_sysfs_fallback()
      firmware_loader: enhance Kconfig documentation over FW_LOADER
      firmware_loader: replace ---help--- with help
      firmware_loader: move kconfig FW_LOADER entries to its own file
      firmware_loader: make firmware_fallback_sysfs() print more useful
      Documentation: fix few typos and clarifications for the firmware loader
      Documentation: remove stale firmware API reference
      Documentation: clarify firmware_class provenance and why we can't rename the module

Martin Liu (1):
      driver core: hold dev's parent lock when needed

Mathieu Malaterre (1):
      driver core: add __printf verification to device_create_groups_vargs

Souptick Joarder (1):
      fs: kernfs: Adding new return type vm_fault_t

Tetsuo Handa (1):
      driver core: Don't ignore class_dir_create_and_add() failure.

Thomas Richter (1):
      debugfs: inode: debugfs_create_dir uses mode permission from parent

Wolfram Sang (1):
      base: core: fix typo 'can by' to 'can be'

 Documentation/dell_rbu.txt                         |   5 +-
 .../driver-api/firmware/fallback-mechanisms.rst    |  14 +-
 .../driver-api/firmware/firmware_cache.rst         |   4 +-
 .../driver-api/firmware/request_firmware.rst       |   5 +
 drivers/base/Kconfig                               |  90 +++---------
 drivers/base/bus.c                                 |  16 +--
 drivers/base/core.c                                |  18 ++-
 drivers/base/dd.c                                  |   8 +-
 drivers/base/driver.c                              |   6 +-
 drivers/base/firmware_loader/Kconfig               | 154 +++++++++++++++++++++
 drivers/base/firmware_loader/fallback.c            |  53 +++++--
 drivers/base/firmware_loader/fallback.h            |  18 +--
 drivers/base/firmware_loader/firmware.h            |  37 +++--
 drivers/base/firmware_loader/main.c                |  57 ++++++--
 drivers/base/memory.c                              |   8 +-
 drivers/net/wireless/ath/ath10k/core.c             |   2 +-
 drivers/net/wireless/ath/ath10k/testmode.c         |   2 +-
 drivers/usb/core/driver.c                          |   1 +
 fs/debugfs/file.c                                  |  10 +-
 fs/debugfs/inode.c                                 |   4 +-
 fs/kernfs/file.c                                   |   8 +-
 include/linux/device.h                             |   3 +
 include/linux/firmware.h                           |  10 ++
 23 files changed, 371 insertions(+), 162 deletions(-)
 create mode 100644 drivers/base/firmware_loader/Kconfig
