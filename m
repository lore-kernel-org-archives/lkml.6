Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3223143-1520426093-2-15516324124220562788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520426092; b=ZIhIse0hMOFqybbCdYsi8XtQrFpTnVDOiRrsx2ZinhlZeQ9
    AVgY82hapqJDDick1W10Iq/8dxtWKd0G9y4GbAsZ06wQsD3LatdOwBFT5tC7A6hR
    J6FhGiP4NY7drzgvWXlT0CYZgEJr7+oimhyzpcw5m+e8/D9+rfkSkPPSi8xc59Im
    mU1UEk34gCjVT6b0Wt7DPffGQRN3n1E3G9uplZXyVelLr9zq9rBto8ZCy9u7VTxN
    vvK7YtRbS0pGmiBjZwlU7ttCjsSaq3RtEJnxNO+va/dayhMKnNTpoQ09knzJkABk
    d+N5ogNIT9rb5KXuAPqYDuU6gPTBg0ip4giU2Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520426092; bh=NDh9qfM2bqe4gSxyH9K4G8xJVG
    alZct1kFpb7YZ6pV0=; b=ihOTn7R/D3tU1tNUhVwELLvYkqNFrDNcj1Y3UPyGib
    gnVpjDqosTFoLwZR6fD49BO/kNiahFaMbqBmWU6HoXCxe4NA7GVluXXQtl1kfzZm
    0RYTIDWRopXKBjow8uitFbvBaw/NsaVKhWkeeqADQwwo1w7010cglpiqyjZ/4QpC
    j0BQa1eC62i6DSvDnOYmsRRftLQZIgWimb7fReExIiUGukNhBFDw0vmff2RaVo54
    vF+x0y1zLh89yRNi5wjCzPn7mxkZUXRE73tLclcD/tEMgu7fkSPDKPhrwtLi+XtM
    eqg/qBoy1hSIhZWFERUty9KUz+r994pAzkXAIuxFP58w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arm.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeCGMeu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 07:34:50 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49822 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751075AbeCGMer (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 07:34:47 -0500
Date: Wed, 7 Mar 2018 12:34:41 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "driverdev-devel@linuxdriverproject.org"
        <driverdev-devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Jack Morgenstein <jackm@mellanox.com>
Subject: Re: [PATCH v3 6/6] PCI: hv: fix 2 hang issues in hv_compose_msi_msg()
Message-ID: <20180307123441.GD15139@e107981-ln.cambridge.arm.com>
References: <20180306182128.23281-1-decui@microsoft.com>
 <20180306182128.23281-7-decui@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306182128.23281-7-decui@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 06, 2018 at 06:21:56PM +0000, Dexuan Cui wrote:
> 1. With the patch "x86/vector/msi: Switch to global reservation mode"
> (4900be8360), the recent v4.15 and newer kernels always hang for 1-vCPU
> Hyper-V VM with SR-IOV. This is because when we reach hv_compose_msi_msg()
> by request_irq()  -> request_threaded_irq() -> __setup_irq()->irq_startup()
>  -> __irq_startup() -> irq_domain_activate_irq() -> ... ->
> msi_domain_activate() -> ... -> hv_compose_msi_msg(), local irq is
> disabled in __setup_irq().
> 
> Fix this by polling the channel.
> 
> 2. If the host is ejecting the VF device before we reach
> hv_compose_msi_msg(), in a UP VM, we can hang in hv_compose_msi_msg()
> forever, because at this time the host doesn't respond to the
> CREATE_INTERRUPT request. This issue also happens to old kernels like
> v4.14, v4.13, etc.

If you are fixing a problem you should report what commit you are fixing
with a Fixes: tag and add a CC: stable@vger.kernel.org to the commit log
to send it to stable kernels to which it should be applied; mentioning
kernel versions in the commit log is useless and should be omitted.

Side note: you should not have stable@vger.kernel.org in the email
addresses CC list you are sending the patches to (you mark patches for
stable by adding an appropriate CC tag in the commit log).

Here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v4.16-rc4

Last but not least, most of the patches in this series do not justify
sending them to stable kernels at all so you should remove the
corresponding tag from the patches.

Thanks,
Lorenzo

> Fix this by polling the channel for the PCI_EJECT message and
> hpdev->state, and by checking the PCI vendor ID.
> 
> Note: actually the above issues also happen to a SMP VM, if
> "hbus->hdev->channel->target_cpu == smp_processor_id()" is true.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> Tested-by: Adrian Suhov <v-adsuho@microsoft.com>
> Tested-by: Chris Valean <v-chvale@microsoft.com>
> Cc: stable@vger.kernel.org
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Jack Morgenstein <jackm@mellanox.com>
> ---
>  drivers/pci/host/pci-hyperv.c | 58 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 265ba11e53e2..50cdefe3f6d3 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -521,6 +521,8 @@ struct hv_pci_compl {
>  	s32 completion_status;
>  };
>  
> +static void hv_pci_onchannelcallback(void *context);
> +
>  /**
>   * hv_pci_generic_compl() - Invoked for a completion packet
>   * @context:		Set up by the sender of the packet.
> @@ -665,6 +667,31 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
>  	}
>  }
>  
> +static u16 hv_pcifront_get_vendor_id(struct hv_pci_dev *hpdev)
> +{
> +	u16 ret;
> +	unsigned long flags;
> +	void __iomem *addr = hpdev->hbus->cfg_addr + CFG_PAGE_OFFSET +
> +			     PCI_VENDOR_ID;
> +
> +	spin_lock_irqsave(&hpdev->hbus->config_lock, flags);
> +
> +	/* Choose the function to be read. (See comment above) */
> +	writel(hpdev->desc.win_slot.slot, hpdev->hbus->cfg_addr);
> +	/* Make sure the function was chosen before we start reading. */
> +	mb();
> +	/* Read from that function's config space. */
> +	ret = readw(addr);
> +	/*
> +	 * mb() is not required here, because the spin_unlock_irqrestore()
> +	 * is a barrier.
> +	 */
> +
> +	spin_unlock_irqrestore(&hpdev->hbus->config_lock, flags);
> +
> +	return ret;
> +}
> +
>  /**
>   * _hv_pcifront_write_config() - Internal PCI config write
>   * @hpdev:	The PCI driver's representation of the device
> @@ -1107,8 +1134,37 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
>  	 * Since this function is called with IRQ locks held, can't
>  	 * do normal wait for completion; instead poll.
>  	 */
> -	while (!try_wait_for_completion(&comp.comp_pkt.host_event))
> +	while (!try_wait_for_completion(&comp.comp_pkt.host_event)) {
> +		/* 0xFFFF means an invalid PCI VENDOR ID. */
> +		if (hv_pcifront_get_vendor_id(hpdev) == 0xFFFF) {
> +			dev_err_once(&hbus->hdev->device,
> +				     "the device has gone\n");
> +			goto free_int_desc;
> +		}
> +
> +		/*
> +		 * When the higher level interrupt code calls us with
> +		 * interrupt disabled, we must poll the channel by calling
> +		 * the channel callback directly when channel->target_cpu is
> +		 * the current CPU. When the higher level interrupt code
> +		 * calls us with interrupt enabled, let's add the
> +		 * local_bh_disable()/enable() to avoid race.
> +		 */
> +		local_bh_disable();
> +
> +		if (hbus->hdev->channel->target_cpu == smp_processor_id())
> +			hv_pci_onchannelcallback(hbus);
> +
> +		local_bh_enable();
> +
> +		if (hpdev->state == hv_pcichild_ejecting) {
> +			dev_err_once(&hbus->hdev->device,
> +				     "the device is being ejected\n");
> +			goto free_int_desc;
> +		}
> +
>  		udelay(100);
> +	}
>  
>  	if (comp.comp_pkt.completion_status < 0) {
>  		dev_err(&hbus->hdev->device,
> -- 
> 2.7.4
