Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752087AbeCOCqU (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 22:46:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:43990 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751488AbeCOCqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 22:46:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,308,1517904000";
   d="scan'208";a="24171116"
From: Lu Baolu <baolu.lu@linux.intel.com>
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 0/3] iommu/vt-d: Global PASID name space
Date: Thu, 15 Mar 2018 10:38:18 +0800
Message-Id: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series is trying to change the scope of PASID management
used in Intel IOMMU driver from per IOMMU to driver global. This is
required for some cases where current per-IOMMU PASID name space
doesn't work. For an example, one application (associated with one
PASID) might talk to two physical devices simultaneously where two
devices could reside behind two different IOMMU units.

Best regards,
Lu Baolu

Lu Baolu (3):
  iommu/vt-d: Global PASID name space
  iommu/vt-d: Decouple idr bond pointer from svm
  iommu/vt-d: Use global PASID for SVM usage

 drivers/iommu/intel-iommu.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-svm.c   | 34 +++++++++++++-----------
 include/linux/intel-iommu.h |  7 ++++-
 3 files changed, 89 insertions(+), 16 deletions(-)

-- 
2.7.4
