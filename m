Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751958AbeBDONe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 09:13:34 -0500
Received: from mga14.intel.com ([192.55.52.115]:52063 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeBDON1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 09:13:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,458,1511856000";
   d="scan'208";a="201238860"
Message-ID: <1517753602.7000.1508.camel@linux.intel.com>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sohil Mehta <sohil.mehta@intel.com>, Joerg Roedel <joro@8bytes.org>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Date: Sun, 04 Feb 2018 16:13:22 +0200
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-02 at 16:49 -0800, Sohil Mehta wrote:
> Hi All,
> 
> This series aims to add debugfs support for Intel IOMMU. It exposes
> IOMMU
> registers, internal context and dumps individual table entries to help
> debug
> Intel IOMMUs.
> 
> The first patch does the ground work for the following patches by
> reorganizing
> some Intel IOMMU data structures. The following patches create a new
> Kconfig
> option - INTEL_IOMMU_DEBUG and add debugfs support for IOMMU context
> internals,
> register contents, PASID internals, and Interrupt remapping in that
> order. The
> information can be accessed in sysfs at
> '/sys/kernel/debug/intel_iommu/'.
> 
> 

Nice and clean in comparison to v1.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Joerg, note, that macro, which patch 2 defines privately, likely will
make v4.16-rc1, thus patch 2 might need to be rebased. So, please, wait
till v4.16-rc1 before applying this.

> Regards,
> Sohil
>  
> Changes since v6:
>  - Split patch 1/5 and 2/5 differently
>  - Simplify and improve code formatting
>  - Use macro for register set definitions
>  - Fix compiler warning for readq
>  - Add Co-Developed-by tag to commit messages
> 
> Changes since v5:
>  - Change the order of includes to an alphabetical order
>  - Change seq_printf and seq_puts formatting
> 
> Changes since v4:
>  - Change to a SPDX license tag
>  - Fix seq_printf formatting and remove leading '\n's
> 
> Changes since v3:
>  - Remove an unused function parameter from some of the functions
>  - Fix checkpatch.pl warnings
>  - Remove error reporting for debugfs_create_file functions
>  - Fix unnecessary reprogramming of the context entries
>  - Simplify and merge the show context and extended context patch into
> one
>  - Remove redundant IOMMU null check under for_each_active_iommu
>  - Update the commit title to be consistent
> 
> Changes since v2:
>  - Added a macro for seq file operations based on recommendation by
> Andy 
>    Shevchenko. The marco can be moved to seq_file.h at a future point
>  - Changed the debugfs file names to more relevant ones
>  - Added information for MTRR registers in the regset file
> 
> Changes since v1:
>  - Fixed seq_printf formatting
>  - Handled the case when Interrupt remapping is not enabled
> 
> Gayatri Kammela (4):
>   iommu/vt-d: Relocate struct/function declarations to its header
> files
>   iommu/vt-d: Enable debugfs support to show context internals
>   iommu/vt-d: Add debugfs support to show register contents
>   iommu/vt-d: Add debugfs support to show Pasid table contents
> 
> Sohil Mehta (1):
>   iommu/vt-d: Add debugfs support for Interrupt remapping
> 
>  drivers/iommu/Kconfig             |   8 +
>  drivers/iommu/Makefile            |   1 +
>  drivers/iommu/intel-iommu-debug.c | 338
> ++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-iommu.c       |  34 +---
>  drivers/iommu/intel-svm.c         |   8 -
>  include/linux/intel-iommu.h       |  39 +++++
>  include/linux/intel-svm.h         |  10 +-
>  7 files changed, 400 insertions(+), 38 deletions(-)
>  create mode 100644 drivers/iommu/intel-iommu-debug.c
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
