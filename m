Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751071AbeDMPDU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 11:03:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:38771 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750761AbeDMPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 11:03:19 -0400
Date: Fri, 13 Apr 2018 17:03:10 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>, Joerg Roedel <joro@8bytes.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Baoquan He <bhe@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: amd: hide unused iommu_table_lock
Message-ID: <20180413150310.4gbpuavvimnfj57a@linutronix.de>
References: <20180404105713.633983-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180404105713.633983-1-arnd@arndb.de>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-04 12:56:59 [+0200], Arnd Bergmann wrote:
> The newly introduced lock is only used when CONFIG_IRQ_REMAP is enabled:
> 
> drivers/iommu/amd_iommu.c:86:24: error: 'iommu_table_lock' defined but not used [-Werror=unused-variable]
>  static DEFINE_SPINLOCK(iommu_table_lock);
> 
> This moves the definition next to the user, within the #ifdef protected
> section of the file.
> 
> Fixes: ea6166f4b83e ("iommu/amd: Split irq_lookup_table out of the amd_iommu_devtable_lock")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thank you Arnd.

Sebastian
