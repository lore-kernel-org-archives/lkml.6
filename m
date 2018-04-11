Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3269524-1523477804-2-5779245192552099078
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523477803; b=mkDxPz0rpaHDEBYUH4Y8WQMj2RREj8+OvUPEnCDAVzC+zRx3Jj
    4Qt+rfQ8ww0Lgih4BXptL1wwvG98jJO8f2d6LRzQ1l2wrY2KvP8FmBIvT5mWHjkz
    Ty2L3zFtjx91VUi7GwFuLrl+mTpkYi2lQZIZK/+qCaFDRUW4X+uCKw5hcOjF/kx5
    VT5KUHuoALp83/8e0IKhBsfq8bHzp5aP4qXw+gzYVEdzHAfptdz5bnV24W/S0239
    JXtK9sZlCEBp3JNOG2/PMeOtopRrC6KGacHgCrLw5uYeKldUwMtRxWlxGStAGNqM
    9Rg7U7L/8O/Uzakw+tZRxXAgIu+PK/+IgaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523477803; bh=T4OTD
    flgRddmYyTl0kE4tBrMvBovTv05d24z7VV9+Dk=; b=Ard28De/ngpUhbGN4IJdD
    K09F99sUNK8tGFCOQLATt/4kXnyI34iXSafTnjw2WCKDKwxFdFVLW89E7mZWAeoM
    1rleUigRT74OfVWWxdtw/wSeYYJahJRTX+ye986pRFkyoaRsWAVMEoVsJQV/jfS/
    LTM8NDxZhz/in/91alLEzfNswqS6voUweTapeCpccywsRiG/9wQyyAtcxSaujDrB
    TXGvZiptMgZfb16u0S4jqlcMHyaUzwVBAwiZ/bjjF9h64S2xAPqFiVm02kjVG3gd
    ckqI29EJD9I6O5wTOo7OZWUjFqpowBm8kf4xFzsmHDB+VqN212Gl/Dfdlq5UPJbx
    Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPixdpUa2L1R3kMX4Ji+UCiKaNjOf4RagXNJaJXXg2tKlwZvGQmKdcyJlN+mTA4aVJ0WIfIrA5txVgyifvzyJk/9ys63b6W77vdmXnB3VOzfPE0A13z+
    9xznZDjgawQ4n8efJe0nJrODqM+YoXjIstpKx1+2DSmr6aoxkLDHj1/IY0VG6+2tRExaayMEFcbKtHHEOc4wKv5BSUpH1pb5h9Pc27XWcWfUc5VWENkJzFgh
    GfHvrZng9zLQizJOMLOLJQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8 a=_gdl5x-7BR-a16W4YwwA:9
    a=Hr5Rb--sCSGyMW6n:21 a=h2rZLxrJRm4-qWAz:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1A72178E
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=helgaas@kernel.org
Date: Wed, 11 Apr 2018 15:16:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v6] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180411201634.GB105104@bhelgaas-glaptop.roam.corp.google.com>
References: <9496B0D1-CC19-42F4-BE50-DEA4EFC8D615@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <9496B0D1-CC19-42F4-BE50-DEA4EFC8D615@microsoft.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I would make the subject:

  Revert "PCI: hv: Use device serial number as PCI domain"

so it matches the original commit.  Otherwise you really need quite a
lot of driver internal knowledge to connect them.

On Wed, Apr 11, 2018 at 12:36:25AM +0000, Sridhar Pitchai wrote:
> When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
> PCI bus to the guest, Hyper-V always provides unique PCI domain.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> overrode unique domain with the serial number of the first device added
> to the virtual PCI bus. The reason for that patch is to have a consistent
> and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
> device serial number as PCI domain") will not guarantee unique domain id.

Possible alternate text:

  The reason for that patch was to have a consistent and short name
  for the device, but Hyper-V doesn't provide unique serial numbers
  (in spite of the code comment claiming that it does).  Using
  non-unique serial numbers as domain IDs leads to duplicate device
  addresses, which causes PCI bus registration to fail.
  
> For example, if the serial number of the device is 0 and there exists a
> PCI bus with domain 0 already, this will cause the PCI bus registration
> with kernel fails.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") need to be reverted.

I think the above sentence is redundant and could be removed.

> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org

Regardless of what you do with the feedback above,

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks a lot for persisting with this!

> ---
> Changes in v6:
> * fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38eab785..ac67e56e451a 100644
> --- a/drivers/pci/host/pci-hyperv.c
> +++ b/drivers/pci/host/pci-hyperv.c
> @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>  	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>  	spin_lock_irqsave(&hbus->device_list_lock, flags);
>  
> -	/*
> -	 * When a device is being added to the bus, we set the PCI domain
> -	 * number to be the device serial number, which is non-zero and
> -	 * unique on the same VM.  The serial numbers start with 1, and
> -	 * increase by 1 for each device.  So device names including this
> -	 * can have shorter names than based on the bus instance UUID.
> -	 * Only the first device serial number is used for domain, so the
> -	 * domain number will not change after the first device is added.
> -	 */
> -	if (list_empty(&hbus->children))
> -		hbus->sysdata.domain = desc->ser;
>  	list_add_tail(&hpdev->list_entry, &hbus->children);
>  	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>  	return hpdev;
> -- 
> 2.14.1
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
