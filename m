Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751915AbeCONTA (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:19:00 -0400
Received: from 8bytes.org ([81.169.241.247]:42338 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbeCONS5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:18:57 -0400
Date: Thu, 15 Mar 2018 14:18:54 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>, Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v7 0/5] Add Intel IOMMU debugfs support
Message-ID: <20180315131854.s6xmltsvsysublcw@8bytes.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
 <20180213140303.42mbzfxpypljy37l@8bytes.org>
 <20180213214002.GA27066@otc-nc-03>
 <20180213145332.35c73eda@jacob-builder>
 <20180215095337.fccoozdclfnbepi4@8bytes.org>
 <20180215083811.3ec86e49@jacob-builder>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215083811.3ec86e49@jacob-builder>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 08:38:11AM -0800, Jacob Pan wrote:
> Just wondering if your concern is on the implementation or the debugfs
> idea in general. Perhaps have some common IOMMU debugfs?

My concern mainly is that we add interfaces which reveal
potentially security relevant information to user-space and that tools
come up using it so that this also becomes kABI and we can't easily
change it anymore and this whole stuff turns into a maintence nightmare.

So that is definitly not something I'd like to see enabled in the
distros, and its better to avoid it at all and search for better ways to
debug upcoming issues.

BPF tracers and tracing in general comes to mind here...


	Joerg
