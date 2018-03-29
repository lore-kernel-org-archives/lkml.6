Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751209AbeC2IuV (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 04:50:21 -0400
Received: from 8bytes.org ([81.169.241.247]:44798 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeC2IuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 04:50:20 -0400
Date: Thu, 29 Mar 2018 10:50:18 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Dmitry Safonov <dima@arista.com>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
Message-ID: <20180329085017.tkdtx77u4khiuqhw@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
 <20180315134649.skh2aukcmg5ud74y@8bytes.org>
 <1521123183.2686.7.camel@arista.com>
 <20180315142253.GC5259@8bytes.org>
 <1521124490.2686.16.camel@arista.com>
 <1521124920.2686.20.camel@arista.com>
 <20180315152828.GA11365@8bytes.org>
 <1521579013.2686.83.camel@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521579013.2686.83.camel@arista.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 08:50:13PM +0000, Dmitry Safonov wrote:
> Hmm, but this fixes my softlockup issue, because it's about time spent
> in printk() inside irq-disabled section, rather about exiting the dmar-
> clearing loop.
> And on my hw doesn't make any difference to limit loop or not because
> clearing a fault is much faster than hw could generate a new fault.
> ITOW, it fixes the softlockup for me and the loop-related lockup can't
> happen on hw I have (so it's the other issue, [possible?] on other hw).

It might solve your issue, but someone else might still run into it with
a different setup. An upstream fix needs to solve it for everyone.

Thanks,

	Joerg
