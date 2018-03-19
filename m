Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935514AbeCSQfU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 12:35:20 -0400
Received: from mga18.intel.com ([134.134.136.126]:8500 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933823AbeCSQfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 12:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,331,1517904000";
   d="scan'208";a="40281020"
Date: Mon, 19 Mar 2018 09:37:14 -0700
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
Message-ID: <20180319093714.3afe698b@jacob-builder>
In-Reply-To: <20180315131854.s6xmltsvsysublcw@8bytes.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
        <20180213140303.42mbzfxpypljy37l@8bytes.org>
        <20180213214002.GA27066@otc-nc-03>
        <20180213145332.35c73eda@jacob-builder>
        <20180215095337.fccoozdclfnbepi4@8bytes.org>
        <20180215083811.3ec86e49@jacob-builder>
        <20180315131854.s6xmltsvsysublcw@8bytes.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2018 14:18:54 +0100
Joerg Roedel <joro@8bytes.org> wrote:

> On Thu, Feb 15, 2018 at 08:38:11AM -0800, Jacob Pan wrote:
> > Just wondering if your concern is on the implementation or the
> > debugfs idea in general. Perhaps have some common IOMMU debugfs?  
> 
> My concern mainly is that we add interfaces which reveal
> potentially security relevant information
I don;t think security is any worse than existing kernel page table in
debugfs. i.e. /sys/kernel/debug/page_tables
This is a debug feature.
> to user-space and that tools
> come up using it so that this also becomes kABI and we can't easily
> change it anymore and this whole stuff turns into a maintence
> nightmare.
> 
Agreed, perhaps we can address that by only dumping user readable data
which avoid having a parser tool that relies on stable kABI?

> So that is definitly not something I'd like to see enabled in the
> distros, and its better to avoid it at all and search for better ways
> to debug upcoming issues.
> 
We can make it "def_bool n" so only used by advanced customers who can
recompile kernel.
> BPF tracers and tracing in general comes to mind here...
> 
my concern is that tracing is suitable for dynamic debugging, but these
context info are mostly static. Perhaps I am missing some tracing
features.

Thanks,

Jacob
> 
> 	Joerg
> 

[Jacob Pan]
