Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AC59CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51A372087E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 20:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A372087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934500AbeFKUu6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 16:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52284 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934428AbeFKUu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 16:50:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AD389356C9;
        Mon, 11 Jun 2018 20:50:56 +0000 (UTC)
Received: from w520.home (ovpn-116-135.phx2.redhat.com [10.3.116.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A01E83087;
        Mon, 11 Jun 2018 20:50:56 +0000 (UTC)
Date:   Mon, 11 Jun 2018 14:50:56 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: [GIT PULL] VFIO updates for v4.18-rc1
Message-ID: <20180611145056.5575ed34@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 11 Jun 2018 20:50:56 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 29dcea88779c856c7dc92040a0c01233263101d4:

  Linux 4.17 (2018-06-03 14:15:21 -0700)

are available in the Git repository at:

  git://github.com/awilliam/linux-vfio.git tags/vfio-v4.18-rc1

for you to fetch changes up to c1abca96b252a9627f99f39215b84e5de92bf1e3:

  samples: mbochs: add DMA_SHARED_BUFFER dependency (2018-06-09 09:23:52 -0600)

----------------------------------------------------------------
VFIO updates for v4.18

 - Bind type1 task tracking to group_leader to facilitate vCPU hotplug
   in QEMU (Alex Williamson)

 - Sample mdev display drivers, including region-based host and
   guest Linux drivers and bochs compatible dmabuf device
   (Gerd Hoffmann)

 - Fix vfio-platform reset module leak (Geert Uytterhoeven)

 - vfio-platform error message consistency (Geert Uytterhoeven)

 - Global checking for mdev uuid collisions rather than per parent
   device (Alex Williamson)

 - Use match_string() helper (Yisheng Xie)

 - vfio-platform PM domain fixes (Geert Uytterhoeven)

 - Fix sample mbochs driver build dependency (Arnd Bergmann)

----------------------------------------------------------------
Alex Williamson (3):
      vfio/type1: Fix task tracking for QEMU vCPU hotplug
      vfio/mdev: Check globally for duplicate devices
      vfio/mdev: Re-order sysfs attribute creation

Arnd Bergmann (1):
      samples: mbochs: add DMA_SHARED_BUFFER dependency

Geert Uytterhoeven (3):
      vfio: platform: Fix reset module leak in error path
      vfio: platform: Make printed error messages more consistent
      vfio: platform: Fix using devices in PM Domains

Gerd Hoffmann (3):
      sample: vfio mdev display - host device
      sample: vfio mdev display - guest driver
      sample: vfio bochs vbe display (host device for bochs-drm)

Yisheng Xie (1):
      vfio: use match_string() helper

 Documentation/vfio-mediated-device.txt       |    5 +
 drivers/vfio/mdev/mdev_core.c                |  102 +-
 drivers/vfio/mdev/mdev_private.h             |    2 +-
 drivers/vfio/mdev/mdev_sysfs.c               |   14 +-
 drivers/vfio/platform/vfio_platform_common.c |   30 +-
 drivers/vfio/vfio.c                          |   11 +-
 drivers/vfio/vfio_iommu_type1.c              |   73 +-
 samples/Kconfig                              |   31 +
 samples/vfio-mdev/Makefile                   |    3 +
 samples/vfio-mdev/mbochs.c                   | 1406 ++++++++++++++++++++++++++
 samples/vfio-mdev/mdpy-defs.h                |   22 +
 samples/vfio-mdev/mdpy-fb.c                  |  232 +++++
 samples/vfio-mdev/mdpy.c                     |  807 +++++++++++++++
 13 files changed, 2622 insertions(+), 116 deletions(-)
 create mode 100644 samples/vfio-mdev/mbochs.c
 create mode 100644 samples/vfio-mdev/mdpy-defs.h
 create mode 100644 samples/vfio-mdev/mdpy-fb.c
 create mode 100644 samples/vfio-mdev/mdpy.c
