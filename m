Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbeECMsj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 08:48:39 -0400
Received: from 8bytes.org ([81.169.241.247]:54214 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeECMsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 08:48:35 -0400
Date: Thu, 3 May 2018 14:48:33 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Baoquan He <bhe@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gary R Hook <gary.hook@amd.com>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: amd: hide unused iommu_table_lock
Message-ID: <20180503124832.f4klueztrtc664st@8bytes.org>
References: <20180404105713.633983-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180404105713.633983-1-arnd@arndb.de>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2018 at 12:56:59PM +0200, Arnd Bergmann wrote:
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
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
