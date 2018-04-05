Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeDEBwH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 21:52:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60336 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752642AbeDEBwF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 21:52:05 -0400
Date: Thu, 5 Apr 2018 04:52:03 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        dyoung@redhat.com, marcandre.lureau@redhat.com, mst@redhat.com,
        somlo@cmu.edu, sonnyrao@chromium.org
Subject: [PULL] fwcfg, vhost: features and fixes
Message-ID: <20180405045203-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0c8efd610b58cb23cefdfa12015799079aef94ae:

  Linux 4.16-rc5 (2018-03-11 17:25:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to dc32bb678e103afbcfa4d814489af0566307f528:

  vhost: add vsock compat ioctl (2018-03-20 03:17:42 +0200)

----------------------------------------------------------------
fw_cfg, vhost: features fixes

This cleans up the qemu fw cfg device driver.
On top of this, vmcore is dumped there on crash to
help debugging witH kASLR enabled.
Also included are some fixes in vhost.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Marc-André Lureau (10):
      fw_cfg: fix sparse warnings in fw_cfg_sel_endianness()
      fw_cfg: fix sparse warnings with fw_cfg_file
      fw_cfg: fix sparse warning reading FW_CFG_ID
      fw_cfg: fix sparse warnings around FW_CFG_FILE_DIR read
      fw_cfg: remove inline from fw_cfg_read_blob()
      fw_cfg: handle fw_cfg_read_blob() error
      fw_cfg: add a public uapi header
      fw_cfg: add DMA register
      crash: export paddr_vmcoreinfo_note()
      fw_cfg: write vmcoreinfo details

Michael S. Tsirkin (1):
      ptr_ring: fix build

Sonny Rao (2):
      vhost: fix vhost ioctl signature to build with clang
      vhost: add vsock compat ioctl

 MAINTAINERS                      |   1 +
 drivers/firmware/qemu_fw_cfg.c   | 291 +++++++++++++++++++++++++++++++--------
 drivers/vhost/vhost.c            |   2 +-
 drivers/vhost/vhost.h            |   4 +-
 drivers/vhost/vsock.c            |  11 ++
 include/uapi/linux/qemu_fw_cfg.h |  97 +++++++++++++
 kernel/crash_core.c              |   1 +
 tools/virtio/ringtest/ptr_ring.c |   5 +
 8 files changed, 348 insertions(+), 64 deletions(-)
 create mode 100644 include/uapi/linux/qemu_fw_cfg.h
