Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752445AbeCOMzC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:55:02 -0400
Received: from 8bytes.org ([81.169.241.247]:42106 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751833AbeCOMzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:55:00 -0400
Date: Thu, 15 Mar 2018 13:54:58 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 04/10] iommu/amd: split irq_lookup_table out of the
 amd_iommu_devtable_lock
Message-ID: <20180315125458.7omh75bzkfyjwjla@8bytes.org>
References: <20180223222736.18542-1-bigeasy@linutronix.de>
 <20180223222736.18542-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223222736.18542-5-bigeasy@linutronix.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 11:27:30PM +0100, Sebastian Andrzej Siewior wrote:
> The function get_irq_table() reads/writes irq_lookup_table while holding
> the amd_iommu_devtable_lock. It also modifies
> amd_iommu_dev_table[].data[2].
> set_dte_entry() is using amd_iommu_dev_table[].data[0|1] (under the
> domain->lock) so it should be okay. The access to the iommu is
> serialized with its own (iommu's) lock.
> 
> So split out get_irq_table() out of amd_iommu_devtable_lock's lock. The
> new lock is a raw_spin_lock because modify_irte_ga() is called while
> desc->lock is held (which is raw).
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

This patch likely conflicts with changes already in the iommu-tree, as
it contains a patch splitting the get_irq_table() function. Can
you rebase your series against the x86/amd branch?


Thanks,

	Joerg
