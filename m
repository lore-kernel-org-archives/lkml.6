Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755340AbeBOJrN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 04:47:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5240 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755165AbeBOJrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 04:47:11 -0500
From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
To: <alex.williamson@redhat.com>, <eric.auger@redhat.com>,
        <pmorel@linux.vnet.ibm.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <john.garry@huawei.com>, <xuwei5@hisilicon.com>,
        Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 0/6] vfio/type1: Add support for valid iova list management
Date: Thu, 15 Feb 2018 09:44:58 +0000
Message-ID: <20180215094504.4972-1-shameerali.kolothum.thodi@huawei.com>
X-Mailer: git-send-email 2.12.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.202.227.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces an iova list associated with a vfio 
iommu. The list is kept updated taking care of iommu apertures,
and reserved regions. Also this series adds checks for any conflict
with existing dma mappings whenever a new device group is attached to
the domain.

User-space can retrieve valid iova ranges using VFIO_IOMMU_GET_INFO
ioctl capability chains. Any dma map request outside the valid iova
range will be rejected.

RFCv2 --> v3
 Removed RFC tag.
 Addressed comments from Alex and Eric:
 - Added comments to make iova list management logic more clear.
 - Use of iova list copy so that original is not altered in
   case of failure.

RFCv1 --> RFCv2
 Addressed comments from Alex:
-Introduced IOVA list management and added checks for conflicts with 
 existing dma map entries during attach/detach.

Shameer Kolothum (6):
  vfio/type1: Introduce iova list and add iommu aperture validity check
  vfio/type1: Check reserve region conflict and update iova list
  vfio/type1: Update iova list on detach
  vfio/type1: check dma map request is within a valid iova range
  vfio/type1: Add IOVA range capability support
  vfio/type1: remove duplicate retrieval of reserved regions.

 drivers/vfio/vfio_iommu_type1.c | 499 +++++++++++++++++++++++++++++++++++++++-
 include/uapi/linux/vfio.h       |  23 ++
 2 files changed, 511 insertions(+), 11 deletions(-)

-- 
2.7.4
