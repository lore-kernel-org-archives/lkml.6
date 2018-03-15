Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeCONBs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 09:01:48 -0400
Received: from 8bytes.org ([81.169.241.247]:42188 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751481AbeCONBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 09:01:47 -0400
Date: Thu, 15 Mar 2018 14:01:45 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: iommu/amd: lock splitting & GFP_KERNEL allocation
Message-ID: <20180315130144.v25fugc2kfglptby@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-1-bigeasy@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Fri, Feb 23, 2018 at 11:27:26PM +0100, Sebastian Andrzej Siewior wrote:
> I have no idea why but suddenly my A10 box complained loudly about
> locking and memory allocations within the iommu code under RT. Looking
> at the code it has been like this for a longer time so the iommu must
> have appeared recently (well there was a bios upgrade due to other
> issues so it might have enabled it).
> 
> The goal here is to make the memory allocation in get_irq_table() not
> with disabled interrupts and having as little raw_spin_lock as possible
> while having them if the caller is also holding one (like desc->lock
> during IRQ-affinity changes).
> 
> The patches were boot tested on an AMD EPYC 7601.

Thanks for these patches, I really like the cleanups and the improved
locking. Please rebase against x86/amd in the iommu branch and address
the other comment I have, then I put them into my tree.


Thanks,

	Joerg
