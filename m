Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8245C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8198F2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbfBVWZs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:25:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36848 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbfBVWZr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:25:47 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 538683092757;
        Fri, 22 Feb 2019 22:25:47 +0000 (UTC)
Received: from x1.home (ovpn-116-24.phx2.redhat.com [10.3.116.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 15A6D5D70D;
        Fri, 22 Feb 2019 22:25:47 +0000 (UTC)
Date:   Fri, 22 Feb 2019 15:25:46 -0700
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v5.1-rc1
Message-ID: <20190222152546.5b95bb65@x1.home>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 22 Feb 2019 22:25:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Sorry for the duplicate, botched the [GIT PULL] first time around.
This is for the next merge window.  Thanks!

The following changes since commit 8834f5600cf3c8db365e18a3d5cac2c2780c81e5:

  Linux 5.0-rc5 (2019-02-03 13:48:04 -0800)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v5.1-rc1

for you to fetch changes up to 0cfd027be1d6def4a462cdc180c055143af24069:

  vfio_pci: Enable memory accesses before calling pci_map_rom (2019-02-18 14:57:50 -0700)

----------------------------------------------------------------
VFIO updates for v5.1-rc1

 - Switch mdev to generic UUID API (Andy Shevchenko)

 - Fixup platform reset include paths (Masahiro Yamada)

 - Fix usage of MINORMASK (Chengguang Xu)

 - Remove noise from duplicate spapr table unsets (Alexey Kardashevskiy)

 - Restore device state after PM reset (Alex Williamson)

 - Ensure memory translation enabled for PCI ROM access (Eric Auger)

----------------------------------------------------------------
Alex Williamson (1):
      vfio/pci: Restore device state on PM transition

Alexey Kardashevskiy (1):
      vfio/spapr_tce: Skip unsetting already unset table

Andy Shevchenko (1):
      vfio-mdev: Switch to use new generic UUID API

Chengguang Xu (4):
      vfio: expand minor range when registering chrdev region
      samples/vfio-mdev/mbochs: expand minor range when registering chrdev region
      samples/vfio-mdev/mdpy: expand minor range when registering chrdev region
      samples/vfio-mdev/mtty: expand minor range when registering chrdev region

Eric Auger (1):
      vfio_pci: Enable memory accesses before calling pci_map_rom

Masahiro Yamada (1):
      vfio: platform: reset: fix up include directives to remove ccflags-y

 drivers/vfio/mdev/mdev_core.c                      | 16 ++--
 drivers/vfio/mdev/mdev_private.h                   |  5 +-
 drivers/vfio/mdev/mdev_sysfs.c                     |  6 +-
 drivers/vfio/pci/vfio_pci.c                        | 90 ++++++++++++++++++----
 drivers/vfio/pci/vfio_pci_config.c                 |  2 +-
 drivers/vfio/pci/vfio_pci_private.h                |  6 ++
 drivers/vfio/platform/reset/Makefile               |  2 -
 .../vfio/platform/reset/vfio_platform_amdxgbe.c    |  2 +-
 .../vfio/platform/reset/vfio_platform_bcmflexrm.c  |  2 +-
 .../platform/reset/vfio_platform_calxedaxgmac.c    |  2 +-
 drivers/vfio/vfio.c                                |  8 +-
 drivers/vfio/vfio_iommu_spapr_tce.c                |  3 +-
 include/linux/mdev.h                               |  2 +-
 samples/vfio-mdev/mbochs.c                         |  8 +-
 samples/vfio-mdev/mdpy.c                           |  8 +-
 samples/vfio-mdev/mtty.c                           | 17 ++--
 16 files changed, 125 insertions(+), 54 deletions(-)
