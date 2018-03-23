Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1725073-1521823720-2-6842880504089333747
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521823719; b=ptZZSiRMHKSIaUaSpraXj5BYdf00hke7XxQBmy03t0MoZ5G
    1p7FE1YRs05tOiuHAy4iqipN5Rw/FkSVEo8HK4z72K8CZ0vjHLsRHuV2GpT4xkt6
    +WWRJPUWSbnigB5G6BZLPEZsMP5OkGlf1F4cEOq+ANX13KR1lEnIMu2kn9pHMk7H
    /pS5Yx4ogKnkvR8jeMw3EQOmuTC9opWqJEsGSFEGNV5EdUFKa2M+djriz4gEYmr3
    EAp+9oMMDgi7K5V6ahUam6fhJbdAilvAN4HSeZPeXQUqnxT17e2mEJ0QjASzwjZi
    eRrj2jxEPOv+7uQHWkfF+4RrcWZFqCvQ5VT1cyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521823719; bh=b
    tJ2z2XgeR1PgfT4YwlWmZ1qaf2Mqcbt0gMINnJdsyc=; b=V5m6JNXgPAVWVpqzr
    SGmNFyaTGR5zsLWz0FqIpSbcdtoJMUIexNpTnijntvfQnwR1rml4R2tkmb2a1KB4
    8Jjukr8mGDYicYeNhk84ZKS0s/mRkQDlws02LuEMiDFTPNhjDcxgDiRBn6SfPhw0
    3gX5UrlX1Zq7PYru7HB2D83+PwYnJ+lSCT19mNPH7McP/SPBOH2Tt2I6B+6ztQwQ
    VQuRSDYg75RoxMTPoHrocy09RIt7bHegabKjtWg/8a4+1UwfxhYEMG0A0WI29EtA
    0rUATMecJdqHJo/8uei3fNsXqm36ZGQDDnujyketbAx6FcRj7k+0JDd0wkcdy7Et
    g2Wxw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 23 Mar 2018 17:48:32 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v4] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180323164832.GB7794@kroah.com>
References: <2C72A4DB-2108-41DF-87B5-9E438C84C3F2@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <2C72A4DB-2108-41DF-87B5-9E438C84C3F2@microsoft.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
 Bjorn Helgaas <bhelgaas@google.com>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 04:12:58PM +0000, Sridhar Pitchai wrote:
> When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual
> PCI bus to the guest, Hyper-V always provides unique PCI domain.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> overrode unique domain with the serial number of the first device added
> to the virtual PCI bus. The reason for that patch is to have a consistent
> and short name for the device. But commit 4a9b0933bdfc ("PCI: hv: Use
> device serial number as PCI domain") will not guarantee unique domain id.
> For example, if the serial number of the device is 0 and there exists a
> PCI bus with domain 0 already, this will cause the PCI bus registration
> with kernel fails.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") need to be reverted. Also, we no longer need it, as commit
> 4a1626dd233e ("netvsc: transparent VF management") remove the
> need for it.
> 
> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> This revert should only be backported to kernels that contain commit
> 4a1626dd233e ("netvsc: transparent VF management").
> 
> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org
> 
> ---
> Changes in v4:
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
>     get_pcichild(hpdev, hv_pcidev_ref_childlist);
>     spin_lock_irqsave(&hbus->device_list_lock, flags);
> 
> -   /*
> -    * When a device is being added to the bus, we set the PCI domain
> -    * number to be the device serial number, which is non-zero and
> -    * unique on the same VM.  The serial numbers start with 1, and
> -    * increase by 1 for each device.  So device names including this
> -    * can have shorter names than based on the bus instance UUID.
> -    * Only the first device serial number is used for domain, so the
> -    * domain number will not change after the first device is added.
> -    */
> -   if (list_empty(&hbus->children))
> -       hbus->sysdata.domain = desc->ser;
>     list_add_tail(&hpdev->list_entry, &hbus->children);
>     spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>     return hpdev;
> --
> 2.14.1

Your whitespace is totally wrong, it was probably eaten by your email
client and so the patch can not be applied :(
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
