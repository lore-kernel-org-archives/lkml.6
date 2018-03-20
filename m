Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751673AbeCTSn5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:43:57 -0400
Received: from 8bytes.org ([81.169.241.247]:34216 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751269AbeCTSnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:43:55 -0400
Date: Tue, 20 Mar 2018 13:43:48 -0500
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Sankaran Rajesh <rajesh.sankaran@intel.com>,
        Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Use real PASID for flush in caching mode
Message-ID: <20180320184347.h46j2wuwlj73ciag@8bytes.org>
References: <1521174696-22495-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521174696-22495-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 12:31:36PM +0800, Lu Baolu wrote:
> If caching mode is supported, the hardware will cache
> none-present or erroneous translation entries. Hence,
> software should explicitly invalidate the PASID cache
> after a PASID table entry becomes present. We should
> issue such invalidation with the PASID value that we
> have changed. PASID 0 is not reserved for this case.
> 
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Sankaran Rajesh <rajesh.sankaran@intel.com>
> Suggested-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Applied, thanks.
