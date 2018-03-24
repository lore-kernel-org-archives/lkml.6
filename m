Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeCXXUR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 19:20:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:7131 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752827AbeCXXUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 19:20:16 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,356,1517904000";
   d="scan'208";a="30979916"
Date: Sun, 25 Mar 2018 07:19:37 +0800
From: kbuild test robot <lkp@intel.com>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: kbuild-all@01.org, iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>, Lan Tianyu <tianyu.lan@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jean Delvare <khali@linux-fr.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [RFC PATCH] iommu/vt-d: intel_iommu_page_response() can be static
Message-ID: <20180324231937.GA9962@xian.lkp.intel.com>
References: <1521774734-48433-21-git-send-email-jacob.jun.pan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521774734-48433-21-git-send-email-jacob.jun.pan@linux.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 49c5977b4ee7 ("iommu/vt-d: add intel iommu page response function")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 intel-iommu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 8d73ff0..06be796 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5195,7 +5195,7 @@ static int intel_iommu_sva_invalidate(struct iommu_domain *domain,
 	return ret;
 }
 
-int intel_iommu_page_response(struct device *dev, struct page_response_msg *msg)
+static int intel_iommu_page_response(struct device *dev, struct page_response_msg *msg)
 {
 	struct qi_desc resp;
 	struct intel_iommu *iommu;
