Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934813AbeD0OmM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 10:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934579AbeD0OmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 10:42:07 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB00218D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 16:41:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 4.17-rc3
Message-ID: <20180427144157.GA9341@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 6d08b06e67cd117f6992c46611dfb4ce267cd71e:

  Linux 4.17-rc2 (2018-04-22 19:20:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git/ tags/char-misc-4.17-rc3

for you to fetch changes up to 6a7228d90d42bcacfe38786756ba62762b91c20a:

  ARM: amba: Fix race condition with driver_override (2018-04-26 10:35:04 +0200)

----------------------------------------------------------------
Char/Misc driver fixes for 4.17-rc3

Here are some small char and misc driver fixes for 4.17-rc3

A variety of small things that have fallen out after 4.17-rc1 was out.
Some vboxguest fixes for systems with lots of memory, amba bus fixes,
some MAINTAINERS updates, uio_hv_generic driver fixes, and a few other
minor things that resolve problems that people reported.

The amba bus fixes took twice to get right, the first time I messed up
applying the patches in the wrong order, hence the revert and later
addition again with the correct fix, sorry about that.

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Anatolij Gustschin (1):
      fpga-manager: altera-ps-spi: preserve nCONFIG state

Bernat, Yehezkel (1):
      MAINTAINERS: update my email address

Daniel Vetter (1):
      MAINTAINERS: add dri-devel&linaro-mm for Android ION

Geert Uytterhoeven (5):
      slimbus: Fix out-of-bounds access in slim_slicesize()
      ARM: amba: Fix race condition with driver_override
      ARM: amba: Don't read past the end of sysfs "driver_override" buffer
      ARM: amba: Make driver_override output consistent with other buses
      ARM: amba: Fix race condition with driver_override

Greg Kroah-Hartman (1):
      Revert "ARM: amba: Fix race condition with driver_override"

Hans de Goede (4):
      virt: vbox: Move declarations of vboxguest private functions to private header
      virt: vbox: Add vbg_req_free() helper function
      virt: vbox: Use __get_free_pages instead of kmalloc for DMA32 memory
      virt: vbox: Log an error when we fail to get the host version

Martijn Coenen (1):
      ANDROID: binder: prevent transactions into own process.

Stephen Hemminger (4):
      uio_hv_generic: set size of ring buffer attribute
      uio_hv_generic: make ring buffer attribute for primary channel
      uio_hv_generic: use correct channel in isr
      uio_hv_generic: fix subchannel ring mmap

 MAINTAINERS                              |  6 ++-
 drivers/amba/bus.c                       | 17 +++++---
 drivers/android/binder.c                 |  8 ++++
 drivers/fpga/altera-ps-spi.c             |  2 +-
 drivers/slimbus/messaging.c              |  2 +-
 drivers/uio/uio_hv_generic.c             | 72 ++++++++++----------------------
 drivers/virt/vboxguest/vboxguest_core.c  | 70 +++++++++++++++++--------------
 drivers/virt/vboxguest/vboxguest_core.h  |  9 ++++
 drivers/virt/vboxguest/vboxguest_linux.c | 19 +++++++--
 drivers/virt/vboxguest/vboxguest_utils.c | 17 ++++++--
 include/linux/vbox_utils.h               | 23 ----------
 11 files changed, 124 insertions(+), 121 deletions(-)
