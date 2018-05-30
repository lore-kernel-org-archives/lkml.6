Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754987AbeE3Eb3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 00:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750770AbeE3Eb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 00:31:27 -0400
Date: Wed, 30 May 2018 06:31:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Christoffer Dall <cdall@linaro.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Gabriele Paoloni <gabriele.paoloni@huawei.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Add pci=safemode option
Message-ID: <20180530043103.GA19734@kroah.com>
References: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527650389-31575-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 11:19:41PM -0400, Sinan Kaya wrote:
> Adding pci=safemode kernel command line parameter to turn off all PCI
> Express service driver as well as all optional PCIe features such as LTR,
> Extended tags, Relaxed Ordering etc.
> 
> Also setting MPS configuration to PCIE_BUS_SAFE so that MPS and MRRS can be
> reconfigured with by the kernel in case BIOS hands off a broken
> configuration.

Why not fix the BIOS?  That's what sane platforms do :)

> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  drivers/pci/pci.c                               | 7 +++++++
>  drivers/pci/pci.h                               | 2 ++
>  drivers/pci/pcie/portdrv_core.c                 | 2 +-
>  drivers/pci/probe.c                             | 6 ++++++
>  5 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 641ec9c..247adbb 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3153,6 +3153,8 @@
>  		noari		do not use PCIe ARI.
>  		noats		[PCIE, Intel-IOMMU, AMD-IOMMU]
>  				do not use PCIe ATS (and IOMMU device IOTLB).
> +		safemode	turns of all optinal PCI features. Useful
> +				for bringup/troubleshooting.

s/optinal/optional/ ?

And you should explain what exactly in PCI is "optional".  Who defines
this and where is that list and what can go wrong if those options are
not enabled?

In looking at your patch, I can't determine that at all, so there's no
way that someone just looking at this sentence will be able to
understand.

thanks,

greg k-h
