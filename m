Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933399AbeBVRHd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:07:33 -0500
Received: from mga14.intel.com ([192.55.52.115]:22972 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933139AbeBVRHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:07:32 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="33360573"
Date: Thu, 22 Feb 2018 09:09:29 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Yves-Alexis Perez <corsac@debian.org>
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Joerg Roedel <joro@8bytes.org>,
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
Message-ID: <20180222090929.12cc8344@jacob-builder>
In-Reply-To: <1519285717.2388.11.camel@debian.org>
References: <1517619001-148586-1-git-send-email-sohil.mehta@intel.com>
        <20180213140303.42mbzfxpypljy37l@8bytes.org>
        <20180213214002.GA27066@otc-nc-03>
        <1518992132.2542.5.camel@debian.org>
        <20180220142512.039309aa@jacob-builder>
        <1519285717.2388.11.camel@debian.org>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Feb 2018 08:48:37 +0100
Yves-Alexis Perez <corsac@debian.org> wrote:

> On Tue, 2018-02-20 at 14:25 -0800, Jacob Pan wrote:
> > I didn't know about chipsec but reading the code seems to rely on an
> > out-of-tree kernel module. I don't think it matches what we need
> > here.  
> 
> Yes good indeed, I had forgot about that. Maybe the userland part is
> still useful, but there's definitely a need for (protected) access to
> privileged memory (and access to /dev/mem is less practical than
> debugfs, I guess).
> 
Another reason we can't use /dev/mem is that the context entries are
not static, they are created for each device when the first map()
comes. So we need to rely on the list in the intel iommu driver to dump
the context.
> Regards,

[Jacob Pan]
