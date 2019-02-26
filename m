Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95877C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4AF2146F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbfBZKhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:37:12 -0500
Received: from 8bytes.org ([81.169.241.247]:41400 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbfBZKhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:37:11 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id AB90741A; Tue, 26 Feb 2019 11:37:09 +0100 (CET)
Date:   Tue, 26 Feb 2019 11:37:08 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, xin.zeng@intel.com,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/9] vfio/mdev: IOMMU aware mediated device
Message-ID: <20190226103707.GG20740@8bytes.org>
References: <20190222021927.13132-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222021927.13132-1-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, Feb 22, 2019 at 10:19:18AM +0800, Lu Baolu wrote:
> Lu Baolu (9):
>   iommu: Add APIs for multiple domains per device
>   iommu/vt-d: Move enable pasid out of CONFIG_INTEL_IOMMU_SVM
>   iommu/vt-d: Add per-device IOMMU feature ops entries
>   iommu/vt-d: Move common code out of iommu_attch_device()
>   iommu/vt-d: Aux-domain specific domain attach/detach
>   iommu/vt-d: Return ID associated with an auxiliary domain
>   vfio/mdev: Add iommu related member in mdev_device
>   vfio/type1: Add domain at(de)taching group helpers
>   vfio/type1: Handle different mdev isolation type

This looks mostly good to me from an IOMMU point of view. I have some
ideas for improving it further, but that can be left for later work. For
example, I wonder if it makes sense to track the enabled/disabled state
for features in core iommu code to safe the call-backs into the
iommu-drivers for the is_enabled checks.

When Alex Acks the vfio changes I am inclined to merge this for v5.1.

Regards,

	Joerg
