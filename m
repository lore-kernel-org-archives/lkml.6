Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEBAC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36F332089F
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F332089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732756AbeKTM72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 07:59:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:12925 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeKTM72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 07:59:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Nov 2018 18:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,255,1539673200"; 
   d="scan'208";a="90628583"
Received: from yisun1-ubuntu.bj.intel.com (HELO localhost) ([10.238.156.104])
  by orsmga007.jf.intel.com with ESMTP; 19 Nov 2018 18:32:39 -0800
Date:   Tue, 20 Nov 2018 10:29:47 +0800
From:   Yi Sun <yi.y.sun@linux.intel.com>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kirti Wankhede <kwankhede@nvidia.com>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com,
        Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
        yi.l.liu@intel.com, yi.y.sun@intel.com, peterx@redhat.com,
        tiwei.bie@intel.com, Zeng Xin <xin.zeng@intel.com>,
        iommu@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iommu: APIs for paravirtual PASID allocation
Message-ID: <20181120022946.GA27998@yi.y.sun>
References: <20181112064501.2290-1-baolu.lu@linux.intel.com>
 <20181119163648.GD31468@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181119163648.GD31468@char.us.oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-11-19 11:36:48, Konrad Rzeszutek Wilk wrote:
> On Mon, Nov 12, 2018 at 02:44:56PM +0800, Lu Baolu wrote:
> > This adds an uniformed API set for global PASIDs used by IOMMU
> > and device drivers which depend on IOMMU. It works for drivers
> > running on bare metal, full virtualized environments and para-
> > virtualized environment.
> > 
> 
> Are there also some QEMU patches for this in RFC state?

Yes, we already have draft codes and are working on refining
them. Will send patches out for your review. Thanks!
