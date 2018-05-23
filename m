Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-771538-1527111180-2-14461717610832170320
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527111179; b=Z83oWWr6vRNUPwyXtize38KPn4DEwcvRYrqWkYTAX+0MZFHfru
    u4vr5mBuiwg4mmiklP/2/zwRPFSnZaa0TCL0gqQEDYHYvP2lj11XRpkCB/Woofp/
    hIUxc2kISav0q4forIei26k6EyYZlSaEM+J8suota4zumcOUad8p3q+AdMin7Ot8
    haoHX/6SI5yevVR43+tLAfWc9TaToOwG7TOvtAaJumLfOic1KcPqmT6FLvAPMvec
    5c1fcWJJ0dWcKJlXqIooGVt3rtN58o645qF4UX86kcEkI0aeq3BJ8sh2KOVrOsem
    FggTkt1AbgpZbd8rSHSDVNbZWLdfnVNXAsUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527111179; bh=M1L1JPWprrkOpP80I5asYOwECtwqfK
    d01z2D/vPID7E=; b=UIDn+ZX8RGW3bsLSWOHo+DsHUShsJapKZ8jT/XJzymmYbM
    PAQE4qE8SDaIMsqFRZiVFMaXYCt5JWCtcUZolMw+sk8Xf76zCDYGiKVMD1sBcX8O
    tgc3dZhZarWJX0tcARGxMn7ZdpUwubrBZ+BrCRhM6zkmIzUamFTkvhQV1VmZMcmA
    ZVn9awzCOUciZMaf5FfbGBoZo1PSVw/as2qjZZ2Rsc2hyQEx6W7VpEE+bD78ISUU
    TmR5D0kVTkTH4ULD8mOn2MTvKjimQegcVU9tdgMCsYO8mKyZvt1Du6WC+6fBsGw9
    b1hAiaVKBC0vL2keUSINPjM3GVyyS0uNGlj+XrpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=OhDOFxob x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=OhDOFxob x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLDZvGckewIHfnlgezavSBUg2aCla23hgRgzbd0uuO9LWU1lVuhOCiX9UxmUXz1cvR8h7HM8C+5eV8FwDoHB2uEsXmsa6/KLFPsDzIDClFk4av8Z6uLS
    Ehif+MRcsbMLzXRG3SoGTXyfaZ+G3FUkd3CzSbMCMx5zcfdXs2YYMhAXUh0agT2vVTRU5BCNuneIQXz22V+Uhj5Fwmw1sgZxeeNhvzDQ8q/4Op2ZPYjwmgS6
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LpQP-O61AAAA:8 a=zVRjdazwAAAA:8 a=rc-dnq2cj9-4qg9tUOgA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=pioyyrs4ZptJ924tMmac:22
    a=000VuuKJPBW3DWPeRJJA:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933969AbeEWVc4 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 17:32:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:54838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933791AbeEWVcv (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 23 May 2018 17:32:51 -0400
Date: Wed, 23 May 2018 16:32:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-pci@vger.kernel.org, timur@codeaurora.org, ryan@finnie.org,
        linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        Don Brace <don.brace@microsemi.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
Message-ID: <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[-cc Gabriele (invalid email address)]
[+cc Don, esc.storagedev, linux-scsi since hpsa is involved]

Background for newcomers:

  Ryan reported a panic on shutdown/reboot [1] on DL360 Gen9.  I think
  the problem is that the shutdown path clears PCI_COMMAND_MASTER on
  the Root Port leading to an hpsa device, the hpsa device attempts a
  DMA, the Root Port treats the DMA as an Unsupported Request (a fatal
  error), and that leads to a panic.

  This patch avoids the problem by changing the Root Port shutdown
  path so it doesn't clear PCI_COMMAND_MASTER.

  [1] https://bugzilla.kernel.org/show_bug.cgi?id=199779

On Tue, May 22, 2018 at 10:44:46PM -0400, Sinan Kaya wrote:
> 'Commit cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during
> shutdown")' has been added to kernel to shutdown pending PCIe port
> service interrupts during reboot so that a newly started kexec kernel
> wouldn't observe pending interrupts.
> 
> pcie_port_device_remove() is disabling the root port and switches by
> calling pci_disable_device() after all PCIe service drivers are shutdown.

It's interesting and annoying that pci_enable_device() and
pci_disable_device() sound like they should be inverses, or at least
related, but they really aren't.

pci_enable_device() basically turns on PCI_COMMAND_MEMORY and/or
PCI_COMMAND_IO so the device will respond to programmed I/O.  But
pci_disable_device() leaves programmed I/O enabled and turns off
PCI_COMMAND_MASTER, which keeps the device from performing DMA or
forwarding transactions upstream (in the case of bridges).

Not an issue for this patch, just an observation :)

> pci_disable_device() has a much wider impact then port service itself and
> it prevents all inbound transactions to reach to the system and impacts
> the entire PCI traffic behind the bridge.
> 
> Issue is that pcie_port_device_remove() doesn't maintain any coordination
> with the rest of the PCI device drivers in the system before clearing the
> bus master bit.

I am interested in this part because if there really isn't any
coordination, that's a good argument for getting rid of portdrv, which
I want to do anyway.  But I haven't dug into this enough to verify it.

The portdrv does register as a regular PCI driver (pcie_portdriver),
and I'm pretty sure the driver core is smart enough to call the driver
entry points in a postorder traversal (children before parents), which
means the hpsa .shutdown() should be called before the portdrv
.shutdown().

The crash seems to indicate that the hpsa device attempted a DMA after
we cleared the Root Port's PCI_COMMAND_MASTER, which means
hpsa_shutdown() didn't stop DMA from the device (it looks like *most*
shutdown methods don't disable device DMA, so it's in good company).

> This has been found to cause crashes on HP DL360 Gen9 machines during
> reboot. Besides, kexec is already clearing the bus master bit in
> pci_device_shutdown() after all PCI drivers are removed.

The original path was:

  pci_device_shutdown(hpsa)
    drv->shutdown
      hpsa_shutdown                     # hpsa_pci_driver.shutdown
  ...
  pci_device_shutdown(RP)               # root port
    drv->shutdown
      pcie_portdrv_remove               # pcie_portdriver.shutdown
        pcie_port_device_remove
          pci_disable_device
            do_pci_disable_device
              # clear RP PCI_COMMAND_MASTER
    if (kexec)
      pci_clear_master(RP)
        # clear RP PCI_COMMAND_MASTER

If I understand correctly, the new path after this patch is:

  pci_device_shutdown(hpsa)
    drv->shutdown
      hpsa_shutdown                     # hpsa_pci_driver.shutdown
  ...
  pci_device_shutdown(RP)               # root port
    drv->shutdown
      pcie_portdrv_shutdown             # pcie_portdriver.shutdown
        __pcie_portdrv_remove(RP, false)
          pcie_port_device_remove(RP, false)
            # do NOT clear RP PCI_COMMAND_MASTER
    if (kexec)
      pci_clear_master(RP)
        # clear RP PCI_COMMAND_MASTER

I guess this patch avoids the panic during reboot because we're not in
the kexec path, so we never clear PCI_COMMAND_MASTER for the Root
Port, so the hpsa device can DMA happily until the lights go out.

But DMA continuing for some random amount of time before the reboot or
shutdown happens makes me a little queasy.  That doesn't sound safe.
The more I think about this, the more confused I get.  What am I
missing?  

> Just remove the extra clear in shutdown path by seperating the remove and
> shutdown APIs in the PORTDRV.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199779
> Fixes: cc27b735ad3a ("PCI/portdrv: Turn off PCIe services during shutdown")
> Cc: stable@vger.kernel.org
> Reported-by: Ryan Finnie <ryan@finnie.org>
> ---
>  drivers/pci/pcie/portdrv.h      |  2 +-
>  drivers/pci/pcie/portdrv_core.c |  5 +++--
>  drivers/pci/pcie/portdrv_pci.c  | 16 +++++++++++++---
>  3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
> index d0c6783..f6e88fe 100644
> --- a/drivers/pci/pcie/portdrv.h
> +++ b/drivers/pci/pcie/portdrv.h
> @@ -86,7 +86,7 @@ int pcie_port_device_register(struct pci_dev *dev);
>  int pcie_port_device_suspend(struct device *dev);
>  int pcie_port_device_resume(struct device *dev);
>  #endif
> -void pcie_port_device_remove(struct pci_dev *dev);
> +void pcie_port_device_remove(struct pci_dev *dev, bool disable);
>  int __must_check pcie_port_bus_register(void);
>  void pcie_port_bus_unregister(void);
>  
> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> index c9c0663..f35341e 100644
> --- a/drivers/pci/pcie/portdrv_core.c
> +++ b/drivers/pci/pcie/portdrv_core.c
> @@ -405,11 +405,12 @@ static int remove_iter(struct device *dev, void *data)
>   * Remove PCI Express port service devices associated with given port and
>   * disable MSI-X or MSI for the port.
>   */
> -void pcie_port_device_remove(struct pci_dev *dev)
> +void pcie_port_device_remove(struct pci_dev *dev, bool disable)
>  {
>  	device_for_each_child(&dev->dev, NULL, remove_iter);
>  	pci_free_irq_vectors(dev);
> -	pci_disable_device(dev);
> +	if (disable)
> +		pci_disable_device(dev);
>  }
>  
>  /**
> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portdrv_pci.c
> index 973f1b8..29afaf3 100644
> --- a/drivers/pci/pcie/portdrv_pci.c
> +++ b/drivers/pci/pcie/portdrv_pci.c
> @@ -137,7 +137,7 @@ static int pcie_portdrv_probe(struct pci_dev *dev,
>  	return 0;
>  }
>  
> -static void pcie_portdrv_remove(struct pci_dev *dev)
> +static void __pcie_portdrv_remove(struct pci_dev *dev, bool disable)
>  {
>  	if (pci_bridge_d3_possible(dev)) {
>  		pm_runtime_forbid(&dev->dev);
> @@ -145,7 +145,17 @@ static void pcie_portdrv_remove(struct pci_dev *dev)
>  		pm_runtime_dont_use_autosuspend(&dev->dev);
>  	}
>  
> -	pcie_port_device_remove(dev);
> +	pcie_port_device_remove(dev, disable);
> +}
> +
> +static void pcie_portdrv_remove(struct pci_dev *dev)
> +{
> +	return __pcie_portdrv_remove(dev, true);
> +}
> +
> +static void pcie_portdrv_shutdown(struct pci_dev *dev)
> +{
> +	return __pcie_portdrv_remove(dev, false);
>  }
>  
>  static pci_ers_result_t pcie_portdrv_error_detected(struct pci_dev *dev,
> @@ -218,7 +228,7 @@ static struct pci_driver pcie_portdriver = {
>  
>  	.probe		= pcie_portdrv_probe,
>  	.remove		= pcie_portdrv_remove,
> -	.shutdown	= pcie_portdrv_remove,
> +	.shutdown	= pcie_portdrv_shutdown,

What are the circumstances when we call .remove() vs .shutdown()?

I guess the main (maybe only) way to call .remove() is to hot-remove
the port?  And .shutdown() is basically used in the reboot and kexec
paths?

>  	.err_handler	= &pcie_portdrv_err_handler,
>  
> -- 
> 2.7.4
> 
