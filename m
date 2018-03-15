Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-168041-1521115536-2-17308676150387648254
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521115535; b=QvN9qFrv+AjrJKSlujFLSEIbhqTalzsVsg6Xc5a4UKjUBwI
    mmR5ACABwaMZbrphyS51xKgoApzAjK/Ajv6oKdqI8UGB96pNlvaMNQPyF2Pym5pE
    7cLrhizyww0FyUdWd6epztrNZ35LE38FaCVFXFOa7UGKdBcy+l1m6U+/lpKaFs94
    Gnp+XcULdGNGRCes8SjkG4nV83FYgzYPLV/acwITIIBtAaLH+LsHtDKBSz7wcFYQ
    YJLvUJ6hhaytBJDMg4DMEQnLC80o1aleLUMheKw7XrFmq3h2g5+Jdfxoq4SH/5FT
    ABeOfF1DpVThky95Gcx0TYdfbWpdhKRpvun5t9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521115535; bh=C
    MyGnR9tC9NQ80OhtIFiLi9TSRZrSWia26u/xbnvqxs=; b=lJHhQEVZ8hR6kERod
    y7g9oZzSC/o46uS751qth9BF1Vdn1LJP556ofXRJSNPsoMSdmqqanlaqL0fCF8tB
    gS2LVZ6YoPM9TAdrZo2xusfA4UkpSKw0KZlZPI5Ced8Ljx320k4OemML6KMnq1n4
    LxCqYc5nEbh6jmsJd+cq/PUHt4jDRiWZxzSeQVdUgyy5UQJviRSLm6jKx7LefvaD
    3fRc6KTMbWQBdF7ffSuFeqWoPHz6h5OKjkYb0ZpKhBrPowdCsOrzOdosBnj6y9ak
    rtbJr0vjGc8jxIv3Y97UijSmvV1qnO1GeNMj+6gapT0QP15sis/fmBBbF0BxfV/j
    sKUpg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 15 Mar 2018 12:05:22 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
 Jake Oshins <jakeo@microsoft.com>, Bjorn Helgaas <bhelgaas@google.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:03:07AM +0000, Sridhar Pitchai wrote:
> Whenever PCI bus is added, HyperV guarantees the BUS id is unique. Even

"Whenever a PCI bus is added"

> with that when a first device is added to the bus, it overrides bus domain
> ID with the device serial number. Sometime this can result in BUS ID not

Define "Sometime".

> being unique. In this case, when PCI_BUS and a device to bus is added, the
> first device overwrites the bus domain ID to the device serial number,
> which is 0. Since there exsist a PCI bus with domain ID 0 already the PCI

s/exsist/exist

> bus addition fails. This patch make sure when a device is added to a bus,
> it never updated the bus domain ID. 

s/updated/updates

> Since we have the transparent SRIOV mode now, the short VF device name
> is no longer needed.

I still do not understand what this means and how it is related to the
patch below, it may be clear to you, it is not to me, at all.

> Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")

Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")

I asked you an explicit question. Commit above was added for a reason
I assume. This patch implies that kernel has been broken since v4.11
which is almost a year ago and nobody every noticed ? Or there are
systems where commit above is _necessary_ and this patch would break
them ?

I want a detailed explanation that highlights *why* it is safe to apply
this patch and send it to stable kernels, commit log above won't do.

Thanks,
Lorenzo

> Cc: stable@vger.kernel.org
> Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
> ---
> 
> Changes in v3:
> * fix the commit comment. [KY Srinivasan, Michael Kelley]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
> index 2faf38e..ac67e56 100644
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
> 2.7.4 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
