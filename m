Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426144AbeBOQho (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 11:37:44 -0500
Received: from mga07.intel.com ([134.134.136.100]:53717 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1426072AbeBOQgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 11:36:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="28306003"
Date: Thu, 15 Feb 2018 08:38:11 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180215083811.3ec86e49@jacob-builder>
In-Reply-To: <20180215095337.fccoozdclfnbepi4@8bytes.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
        <20180213140303.42mbzfxpypljy37l@8bytes.org>
        <20180213214002.GA27066@otc-nc-03>
        <20180213145332.35c73eda@jacob-builder>
        <20180215095337.fccoozdclfnbepi4@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2018 10:53:38 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Tue, Feb 13, 2018 at 02:53:32PM -0800, Jacob Pan wrote:
> > We did start out with /dev/mem but run into CONFIG_STRICT_DEVMEM
> > requirement which is turned on by default.
> > libpci is only limited to PCI config space access, right?  
> 
> Even if /dev/mem is not an option, I am still not convinced that this
> is a good idea. How should this be used? Will you just use it to debug
> Intel IOMMUs when you guys work on the driver or should users report
> the data back when they hit problems?
> 
It is for both but mainly the latter. when we have customers/users
reporting Intel IOMMU issues, it would be extremely helpful if we can
ask them to turn debugfs on and report the state. As we move to SVA, we
may also include io page table similar to /sys/kernel/debug/page_table
for PASID etc.

Just wondering if your concern is on the implementation or the debugfs
idea in general. Perhaps have some common IOMMU debugfs?
