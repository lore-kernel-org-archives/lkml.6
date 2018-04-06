Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752070AbeDFVdY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 17:33:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41090 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751442AbeDFVdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 17:33:22 -0400
Date: Fri, 6 Apr 2018 15:33:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v4.17
Message-ID: <20180406153322.28e85a8e@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit c698ca5278934c0ae32297a8725ced2e27585d7f:

  Linux 4.16-rc6 (2018-03-18 17:48:42 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.17-rc1

for you to fetch changes up to da9147140fe3de5a3a3fe5fe7f69739d4f39bea1:

  MAINTAINERS: vfio/platform: Update sub-maintainer (2018-04-02 09:04:08 -0600)

----------------------------------------------------------------
VFIO updates for v4.17-rc1

 - Adopt iommu_unmap_fast() interface to type1 backend
   (Suravee Suthikulpanit)

 - mdev sample driver fixup (Shunyong Yang)

 - More efficient PFN mapping handling in type1 backend
   (Jason Cai)

 - VFIO device ioeventfd interface (Alex Williamson)

 - Tag new vfio-platform sub-maintainer (Alex Williamson)

----------------------------------------------------------------
Alex Williamson (4):
      vfio/pci: Pull BAR mapping setup from read-write path
      vfio/pci: Use endian neutral helpers
      vfio/pci: Add ioeventfd support
      MAINTAINERS: vfio/platform: Update sub-maintainer

Jason Cai (Xiang Feng) (1):
      vfio/type1: Improve memory pinning process for raw PFN mapping

Shunyong Yang (1):
      vfio-mdev/samples: change RDI interrupt condition

Suravee Suthikulpanit (1):
      vfio/type1: Adopt fast IOTLB flush interface when unmap IOVAs

 MAINTAINERS                         |   2 +-
 drivers/vfio/pci/vfio_pci.c         |  35 +++++++
 drivers/vfio/pci/vfio_pci_private.h |  19 ++++
 drivers/vfio/pci/vfio_pci_rdwr.c    | 184 ++++++++++++++++++++++++++++++++----
 drivers/vfio/vfio_iommu_type1.c     | 151 +++++++++++++++++++++++++----
 include/uapi/linux/vfio.h           |  27 ++++++
 samples/vfio-mdev/mtty.c            |   2 +-
 7 files changed, 377 insertions(+), 43 deletions(-)
