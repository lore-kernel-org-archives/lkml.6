Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeBWLTi (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:19:38 -0500
Received: from mga04.intel.com ([192.55.52.120]:53962 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeBWLTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:19:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="19758518"
From: Tiwei Bie <tiwei.bie@intel.com>
To: mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, wexu@redhat.com, jfreimann@redhat.com,
        tiwei.bie@intel.com
Subject: [PATCH RFC 0/2] Packed ring for virtio
Date: Fri, 23 Feb 2018 19:17:59 +0800
Message-Id: <20180223111801.15240-1-tiwei.bie@intel.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This RFC implements a subset of packed ring which is described at
https://github.com/oasis-tcs/virtio-docs/blob/master/virtio-v1.1-packed-wd08.pdf

The code was tested with DPDK vhost (testpmd/vhost-PMD) implemented
by Jens at http://dpdk.org/ml/archives/dev/2018-January/089417.html
Minor changes are needed for the vhost code, e.g. to kick the guest.

It's not a complete implementation, here is what's missing:

- Device area and driver area
- VIRTIO_RING_F_INDIRECT_DESC
- VIRTIO_F_NOTIFICATION_DATA
- Virtio devices except net are not tested
- See FIXME in the code for more details

Thanks!

Best regards,
Tiwei Bie

Tiwei Bie (2):
  virtio: introduce packed ring defines
  virtio_ring: support packed ring

 drivers/virtio/virtio_ring.c       | 699 ++++++++++++++++++++++++++++++++-----
 include/linux/virtio_ring.h        |   8 +-
 include/uapi/linux/virtio_config.h |  18 +-
 include/uapi/linux/virtio_ring.h   |  68 ++++
 4 files changed, 703 insertions(+), 90 deletions(-)

-- 
2.14.1
