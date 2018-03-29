Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751973AbeC2Is2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:48:28 -0400
Received: from 8bytes.org ([81.169.241.247]:44768 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeC2Is0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:48:26 -0400
Date: Thu, 29 Mar 2018 10:48:24 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Gary R Hook <gary.hook@amd.com>, "Raj, Ashok" <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180329084824.fvy7cg2wban4by4n@8bytes.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
 <20180213140303.42mbzfxpypljy37l@8bytes.org>
 <20180213214002.GA27066@otc-nc-03>
 <20180213145332.35c73eda@jacob-builder>
 <20180215095337.fccoozdclfnbepi4@8bytes.org>
 <20180215083811.3ec86e49@jacob-builder>
 <20180315131854.s6xmltsvsysublcw@8bytes.org>
 <20180319093714.3afe698b@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319093714.3afe698b@jacob-builder>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Gary from AMD to Cc ]

On Mon, Mar 19, 2018 at 09:37:14AM -0700, Jacob Pan wrote:
> On Thu, 15 Mar 2018 14:18:54 +0100
> Joerg Roedel <joro@8bytes.org> wrote:
> 
> > On Thu, Feb 15, 2018 at 08:38:11AM -0800, Jacob Pan wrote:
> > > Just wondering if your concern is on the implementation or the
> > > debugfs idea in general. Perhaps have some common IOMMU debugfs?  
> > 
> > My concern mainly is that we add interfaces which reveal
> > potentially security relevant information
> I don;t think security is any worse than existing kernel page table in
> debugfs. i.e. /sys/kernel/debug/page_tables
> This is a debug feature.

Okay, so here is the way to go: Please introduce a basic debugfs
facility to the core iommu code. It should basically only create a
'iommu/' directory in debugfs where drivers can create their own
sub-directories. This must be enabled by a new kconfig option
(CONFIG_IOMMU_DEBUGFS) and the kernel should print a big fat warning at
boot when it is enabled. This hopefully prevents anyone from enabling it
for production kernels.

Then in the next cycle I will review again more closely what information
about VT-d and AMD-Vi is revealed there and will probably apply what I
can live with.

Thanks,

	Joerg
