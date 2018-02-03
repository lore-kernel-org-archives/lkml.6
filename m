Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753162AbeBCAtb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 19:49:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:17233 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752146AbeBCAtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 19:49:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,452,1511856000";
   d="scan'208";a="15086243"
From: Sohil Mehta <sohil.mehta@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Date: Fri,  2 Feb 2018 16:49:56 -0800
Message-Id: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
registers, internal context and dumps individual table entries to help debug
Intel IOMMUs.

The first patch does the ground work for the following patches by reorganizing
some Intel IOMMU data structures. The following patches create a new Kconfig
option - INTEL_IOMMU_DEBUG and add debugfs support for IOMMU context internals,
register contents, PASID internals, and Interrupt remapping in that order. The
information can be accessed in sysfs at '/sys/kernel/debug/intel_iommu/'.


Regards,
Sohil
 
Changes since v6:
 - Split patch 1/5 and 2/5 differently
 - Simplify and improve code formatting
 - Use macro for register set definitions
 - Fix compiler warning for readq
 - Add Co-Developed-by tag to commit messages

Changes since v5:
 - Change the order of includes to an alphabetical order
 - Change seq_printf and seq_puts formatting

Changes since v4:
 - Change to a SPDX license tag
 - Fix seq_printf formatting and remove leading '\n's

Changes since v3:
 - Remove an unused function parameter from some of the functions
 - Fix checkpatch.pl warnings
 - Remove error reporting for debugfs_create_file functions
 - Fix unnecessary reprogramming of the context entries
 - Simplify and merge the show context and extended context patch into one
 - Remove redundant IOMMU null check under for_each_active_iommu
 - Update the commit title to be consistent

Changes since v2:
 - Added a macro for seq file operations based on recommendation by Andy 
   Shevchenko. The marco can be moved to seq_file.h at a future point
 - Changed the debugfs file names to more relevant ones
 - Added information for MTRR registers in the regset file

Changes since v1:
 - Fixed seq_printf formatting
 - Handled the case when Interrupt remapping is not enabled

Gayatri Kammela (4):
  iommu/vt-d: Relocate struct/function declarations to its header files
  iommu/vt-d: Enable debugfs support to show context internals
  iommu/vt-d: Add debugfs support to show register contents
  iommu/vt-d: Add debugfs support to show Pasid table contents

Sohil Mehta (1):
  iommu/vt-d: Add debugfs support for Interrupt remapping

 drivers/iommu/Kconfig             |   8 +
 drivers/iommu/Makefile            |   1 +
 drivers/iommu/intel-iommu-debug.c | 338 ++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-iommu.c       |  34 +---
 drivers/iommu/intel-svm.c         |   8 -
 include/linux/intel-iommu.h       |  39 +++++
 include/linux/intel-svm.h         |  10 +-
 7 files changed, 400 insertions(+), 38 deletions(-)
 create mode 100644 drivers/iommu/intel-iommu-debug.c

-- 
2.7.4
