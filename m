Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965065AbeBMODH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 09:03:07 -0500
Received: from 8bytes.org ([81.169.241.247]:38208 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964879AbeBMODF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 09:03:05 -0500
Date: Tue, 13 Feb 2018 15:03:03 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
        Ashok Raj <ashok.raj@intel.com>, David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180213140303.42mbzfxpypljy37l@8bytes.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 04:49:56PM -0800, Sohil Mehta wrote:
> This series aims to add debugfs support for Intel IOMMU. It exposes IOMMU
> registers, internal context and dumps individual table entries to help debug
> Intel IOMMUs.
> 
> The first patch does the ground work for the following patches by reorganizing
> some Intel IOMMU data structures. The following patches create a new Kconfig
> option - INTEL_IOMMU_DEBUG and add debugfs support for IOMMU context internals,
> register contents, PASID internals, and Interrupt remapping in that order. The
> information can be accessed in sysfs at '/sys/kernel/debug/intel_iommu/'.

This looks like it only presents data from the iommu-hardware (register
state) or from in-memory data structures used by the hardware. Can't all
this be read out from user-space with libpci and /dev/mem access?

Things are different for kernel-defined data structures, as they might
change between releases and can be presented to user-space via debugfs
is needed, but the data structures used by the hardware should be pretty
stable.


	Joerg
