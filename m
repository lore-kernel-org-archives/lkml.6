Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755135AbeBAUYq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 15:24:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46112 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754983AbeBAUYh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 15:24:37 -0500
Date: Thu, 1 Feb 2018 13:24:36 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v4.16
Message-ID: <20180201132436.0b3b4efa@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 1291a0d5049dbc06baaaf66a9ff3f53db493b19b:

  Linux 4.15-rc4 (2017-12-17 18:59:59 -0800)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.16-rc1

for you to fetch changes up to 46ed90f157f42d956ffed17c003f089a59b76e3e:

  vfio: mdev: make a couple of functions and structure vfio_mdev_driver static (2018-01-09 12:13:08 -0700)

----------------------------------------------------------------
VFIO updates for v4.16-rc1

 - Mask INTx from user if pdev->irq is zero (Alexey Kardashevskiy)

 - Capability helper cleanup (Alex Williamson)

 - Allow mmaps overlapping MSI-X vector table with region capability
   exposing this feature (Alexey Kardashevskiy)

 - mdev static cleanups (Xiongwei Song)

----------------------------------------------------------------
Alex Williamson (1):
      vfio: Simplify capability helper

Alexey Kardashevskiy (2):
      vfio-pci: Mask INTx if a device is not capabable of enabling it
      vfio-pci: Allow mapping MSIX BAR

Xiongwei Song (1):
      vfio: mdev: make a couple of functions and structure vfio_mdev_driver static

 drivers/gpu/drm/i915/gvt/kvmgt.c | 15 +++++---
 drivers/vfio/mdev/vfio_mdev.c    |  6 ++--
 drivers/vfio/pci/vfio_pci.c      | 75 +++++++++-------------------------------
 drivers/vfio/vfio.c              | 52 +++-------------------------
 include/linux/vfio.h             |  3 +-
 include/uapi/linux/vfio.h        | 10 ++++++
 6 files changed, 45 insertions(+), 116 deletions(-)
