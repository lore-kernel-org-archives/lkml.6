Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeCZAi1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 20:38:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:6982 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCZAi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 20:38:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,362,1517904000";
   d="scan'208";a="40544373"
Subject: Re: [PATCH 0/3] iommu/vt-d: Global PASID name space
To: David Woodhouse <dwmw2@infradead.org>, Joerg Roedel <joro@8bytes.org>
References: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
Cc: ashok.raj@intel.com, sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
From: Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <5AB840FD.8020600@linux.intel.com>
Date: Mon, 26 Mar 2018 08:38:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.1
MIME-Version: 1.0
In-Reply-To: <1521081501-30119-1-git-send-email-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

A gentle ping. :-)

Any comments on this patch set?

Best regards,
Lu Baolu

On 03/15/2018 10:38 AM, Lu Baolu wrote:
> Hi,
>
> This patch series is trying to change the scope of PASID management
> used in Intel IOMMU driver from per IOMMU to driver global. This is
> required for some cases where current per-IOMMU PASID name space
> doesn't work. For an example, one application (associated with one
> PASID) might talk to two physical devices simultaneously where two
> devices could reside behind two different IOMMU units.
>
> Best regards,
> Lu Baolu
>
> Lu Baolu (3):
>   iommu/vt-d: Global PASID name space
>   iommu/vt-d: Decouple idr bond pointer from svm
>   iommu/vt-d: Use global PASID for SVM usage
>
>  drivers/iommu/intel-iommu.c | 64 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-svm.c   | 34 +++++++++++++-----------
>  include/linux/intel-iommu.h |  7 ++++-
>  3 files changed, 89 insertions(+), 16 deletions(-)
>
