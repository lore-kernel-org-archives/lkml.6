Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753874AbeEOOLE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 10:11:04 -0400
Received: from 8bytes.org ([81.169.241.247]:48652 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753850AbeEOOLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 10:11:03 -0400
Date: Tue, 15 May 2018 16:11:01 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>, ashok.raj@intel.com,
        sanjay.k.kumar@intel.com, jacob.jun.pan@intel.com,
        kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] iommu/vt-d: Improve PASID id and table management
Message-ID: <20180515141101.GF18595@8bytes.org>
References: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525398084-28815-1-git-send-email-baolu.lu@linux.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 04, 2018 at 09:41:15AM +0800, Lu Baolu wrote:
> PATCH 4~9 implement per domain PASID table. Current per IOMMU
> PASID table implementation is insecure in the cases where
> multiple devices under one single IOMMU unit support PASID
> feature. With per domain PASID table, we can achieve finer
> protection and isolation granularity.


Hold on, we hat discussions in the past about doing a system-wide pasid
space, so that every mm_struct with devices attached gets the same pasid
across all devices it is talking to. Reason was that some devices (will)
require this to work correctly. This goes into the opposite direction,
so I am a bit confused here. Please explain, is this not longer
necessary?


Regards,

	Joerg
