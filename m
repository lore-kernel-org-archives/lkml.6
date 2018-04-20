Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754519AbeDTJrT convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 05:47:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44573 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754251AbeDTJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 05:47:18 -0400
Date: Fri, 20 Apr 2018 11:47:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tobias Regnery <tobias.regnery@gmail.com>
Cc: joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/amd: fix unused-variable warning
Message-ID: <20180420094714.kjir26edq34i6ktq@linutronix.de>
References: <20180420092836.12219-1-tobias.regnery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180420092836.12219-1-tobias.regnery@gmail.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-20 11:28:36 [+0200], Tobias Regnery wrote:
> The iommu_table_lock is only used by code inside an ifdef CONFIG_IRQ_REMAP
> block. This leads to the following warning with CONFIG_IRQ_REMAP=n:
> 
> amd_iommu.c:86:24: warning: 'iommu_table_lock' defined but not used [-Wunused-variable]
> 
> Guard the spinlock definition with the same ifdef.
> 
> Fixes: ea6166f4b83e9 ("iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>

Thank you for spotting this, I am waiting for Jörg to pick up this
instead:
  http://lkml.kernel.org/r/20180404105713.633983-1-arnd@arndb.de

Sebastian
