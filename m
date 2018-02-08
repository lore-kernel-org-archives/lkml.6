Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeBHQNd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:13:33 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58052 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751079AbeBHQNb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:13:31 -0500
Date: Thu, 8 Feb 2018 18:13:27 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arvind.yadav.cs@gmail.com, cohuck@redhat.com, ebiggers@google.com,
        elfring@users.sourceforge.net, gomonovych@gmail.com,
        jasowang@redhat.com, jinli.zjl@alibaba-inc.com, mst@redhat.com,
        peter.malone@gmail.com, rdunlap@infradead.org, rfreire@redhat.com,
        somlo@cmu.edu, stefanha@redhat.com, tgolembi@redhat.com,
        vincent.legoll@gmail.com, xiangxia.m.yue@gmail.com,
        zhangweiping@didichuxing.com
Subject: [PULL] virtio, vhost: fixes, cleanups, features
Message-ID: <20180208181327-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit d8a5b80568a9cb66810e75b182018e9edb68e8ff:

  Linux 4.15 (2018-01-28 13:20:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d25cc43c6775bff6b8e3dad97c747954b805e421:

  vhost: don't hold onto file pointer for VHOST_SET_LOG_FD (2018-02-01 16:26:47 +0200)

----------------------------------------------------------------
virtio, vhost: fixes, cleanups, features

This includes the disk/cache memory stats for for the virtio balloon,
as well as multiple fixes and cleanups.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Arvind Yadav (1):
      virtio: virtio_mmio: make of_device_ids const.

Eric Biggers (3):
      vhost: don't hold onto file pointer for VHOST_SET_VRING_CALL
      vhost: don't hold onto file pointer for VHOST_SET_VRING_ERR
      vhost: don't hold onto file pointer for VHOST_SET_LOG_FD

Markus Elfring (1):
      vhost/scsi: Improve a size determination in four functions

Michael S. Tsirkin (2):
      virtio/ringtest: fix up need_event math
      virtio/ringtest: virtio_ring: fix up need_event math

Peter Malone (1):
      ringtest: ring.c malloc & memset to calloc

Stefan Hajnoczi (1):
      virtio_blk: print capacity at probe time

Tomáš Golembiovský (1):
      virtio_balloon: include disk/file caches memory statistics

Tonghao Zhang (1):
      vhost: Remove the unused variable.

Vasyl Gomonovych (2):
      virtio-mmio: Use PTR_ERR_OR_ZERO()
      firmware: Use PTR_ERR_OR_ZERO()

Vincent Legoll (1):
      virtio: make VIRTIO a menuconfig to ease disabling it all

weiping zhang (3):
      virtio: split device_register into device_initialize and device_add
      virtio_pci: don't kfree device on register failure
      virtio_vop: don't kfree device on register failure

夷则(Caspar) (1):
      vhost: remove unused lock check flag in vhost_dev_cleanup()

 drivers/block/virtio_blk.c              | 32 ++++++++--------
 drivers/firmware/qemu_fw_cfg.c          |  4 +-
 drivers/misc/mic/vop/vop_main.c         | 20 ++++++----
 drivers/vhost/net.c                     |  2 +-
 drivers/vhost/scsi.c                    | 11 +++---
 drivers/vhost/test.c                    |  2 +-
 drivers/vhost/vhost.c                   | 68 ++++++++-------------------------
 drivers/vhost/vhost.h                   |  9 +----
 drivers/vhost/vsock.c                   |  2 +-
 drivers/virtio/Kconfig                  |  8 +++-
 drivers/virtio/virtio.c                 | 18 +++++++--
 drivers/virtio/virtio_balloon.c         |  4 ++
 drivers/virtio/virtio_mmio.c            |  6 +--
 drivers/virtio/virtio_pci_common.c      |  8 +++-
 include/uapi/linux/virtio_balloon.h     |  3 +-
 tools/virtio/ringtest/ring.c            | 30 ++++++++-------
 tools/virtio/ringtest/virtio_ring_0_9.c | 24 +++++++-----
 17 files changed, 120 insertions(+), 131 deletions(-)
