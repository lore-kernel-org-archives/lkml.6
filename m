Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965897AbeBMVkF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 16:40:05 -0500
Received: from mga06.intel.com ([134.134.136.31]:4361 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965749AbeBMVkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 16:40:03 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="17884192"
Date: Tue, 13 Feb 2018 13:40:02 -0800
From: "Raj, Ashok" <ashok.raj@intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180213214002.GA27066@otc-nc-03>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
 <20180213140303.42mbzfxpypljy37l@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180213140303.42mbzfxpypljy37l@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On Tue, Feb 13, 2018 at 03:03:03PM +0100, Joerg Roedel wrote:
> On Fri, Feb 02, 2018 at 04:49:56PM -0800, Sohil Mehta wrote:
> > This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
> > registers, internal context and dumps individual table entries to help debug
> > Intel IOMMUs.
> > 
> > The first patch does the ground work for the following patches by reorganizing
> > some Intel IOMMU data structures. The following patches create a new Kconfig
> > option - INTEL_IOMMU_DEBUG and add debugfs support for IOMMU context internals,
> > register contents, PASID internals, and Interrupt remapping in that order. The
> > information can be accessed in sysfs at '/sys/kernel/debug/intel_iommu/'.
> 
> This looks like it only presents data from the iommu-hardware (register
> state) or from in-memory data structures used by the hardware. Can't all
> this be read out from user-space with libpci and /dev/mem access?

True, we can do the tools and keep it strictly user space, but find it very
convenient to keep the kernel code and debugfs together. When there are 
bug-reports its rather easy for the user to collect some data and report it, 
and all the data-structures we need are readily available instead of finding
a round-about way to capture the same data from user-space.

This version has only hw dumps for now, but we plan to add some other things
like walking 2nd level page-tables, or get some SVM specific data from the 
driver in the future. 

> 
> Things are different for kernel-defined data structures, as they might
> change between releases and can be presented to user-space via debugfs
> is needed, but the data structures used by the hardware should be pretty
> stable.

Cheers,
Ashok
