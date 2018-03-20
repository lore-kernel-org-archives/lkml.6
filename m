Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2043643-1521570740-2-3944601859377741413
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
    t=1521570740; b=ogFOTXa7LziE/W213hYOhJNtBfXgy9CAqpjMjneFGS2CTBN
    F8v+sKW1y0iosSdrW6LkBp6LryEHtYr4w/tc+zDYdiD/wjHStvp056ZnB2JBeQhW
    XFBtrH9uPMpylT6YOlAB05KjJxXKjCCm3dDZDfxVc0hs1F8U/U30rI0duRBLvVS3
    Sr7k/8E2ebbWja4StODlqeXrLBW7V9W6gPX5KfK+G4RbbvGVIYg6hLDFdq52GGy5
    3ckY+yO153aPEw1WXw+2huEO7LEO4K9gVRUAw8grYEB9HSEcWe58FUU5tzBJy4o4
    3Obj3qnhs4GG5Yrk4GOASOm6LtvOsNQRl0NCM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521570740; bh=7
    gRZ66YSMES+7MikuTuJWWpUAmwBQa5+Qs4asZ1X/9w=; b=KrpAEfOKF1HoRTfzw
    7/qCGZAw61ORQeKZoYzFVjXAGmcWevzsq1ktcb6nYVjLSnANWJICVOvPHRib1n/s
    9iGnebo99DuTxzFhLIY+vavx99Jatw+v5gf8r2J0CaA7vqcMaBoLZmt5pcMAWYon
    pVLjM/7/A0WKTEmPv6c7caqqh1DsV9IfrgeIojTHVCcFa2pgMPVESE5t1t4Anm0Q
    ErT1/wZ94XzPODFfSkd2+Qmt3nw1zPBJqJLPeS3Aj2mLdaOt32HIUTdDi5N2F5yO
    VJonGWtRjy0N+1J3waaxJU1/jcSeGt6d9u1BvZKfciiBAuE2w5zpc2hLCT6djnbI
    HxjRA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 20 Mar 2018 18:32:08 +0000
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v3]PCI: hv: fix PCI-BUS domainID corruption
Message-ID: <20180320183208.GB24991@e107981-ln.cambridge.arm.com>
References: <C600E28F-E581-431E-9CD4-47C776E8E70F@microsoft.com>
 <20180315120522.GA15651@e107981-ln.cambridge.arm.com>
 <DM5PR21MB0826439DF296763A3FA861C3F6D00@DM5PR21MB0826.namprd21.prod.outlook.com>
 <04DBCCAB-4BA7-4E05-A047-44824995963E@microsoft.com>
 <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <65B4E847-CC40-4166-BE8F-D44049EDB2FF@microsoft.com>
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

On Tue, Mar 20, 2018 at 05:56:15PM +0000, Sridhar Pitchai wrote:
> Hi Lorenzo,

> Are we good with the explanation? Can I send the patch with the
> updated commit comments?

Almost.

[...]

>     Since we have the transparent SRIOV mode now, the short VF device name
>     is no longer needed.

Can you correlate transparent SRIOV mode to the point you are making
below ? Please explain what transparent SRIOV mode allows you to remove
and why. The rest of the explanation seems OK.

Please follow this email format:

http://vger.kernel.org/lkml/#s3-9

Thanks,
Lorenzo

>     I still do not understand what this means and how it is related to the
>     patch below, it may be clear to you, it is not to me, at all.
>     
>     Sridhar >> the patch below, was introduced to make the device name small, by taking only
>     16bits of the serial number. Since we are not going to have the serial number
>     updated to the BUS id, this has to be removed.
>     
>     Fixes: 4a9b0933bdfc("PCI:hv:Use device serial number as PCI domain")
>     
>     Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
>     Sridhr >> yes
>     
>     I asked you an explicit question. Commit above was added for a reason
>     I assume. This patch implies that kernel has been broken since v4.11
>     which is almost a year ago and nobody every noticed ? Or there are
>     systems where commit above is _necessary_ and this patch would break
>     them ?
>     
>     I want a detailed explanation that highlights *why* it is safe to apply
>     this patch and send it to stable kernels, commit log above won't do.
>     
>     Sridhar>> HyperV provides a unique domain ID for PCI BUS. But it is modified by the child
>     device when it is added. This cannot produce a unique domain ID all the time.
>     Here in the bug, we see the collision between the serial number and already
>     existing PCI bus. The cleaner way is never touch the domain ID provided by
>     hyperV during the PCI bus creation. As long as hyperV make sure it provides a
>     unique domain ID for the PCI for a VM it will not break, and HyperV will
>     guarantees that the domain for the PCI bus for a given VM will be always unique.
>     The original patch was also intending to have a unique domain ID for the PCI
>     bus, by taking the serial number of the device, but it is not sufficient, when
>     the device serial number is number which is the domain ID of the existing PCI
>     bus.  With the current kernel we can repro this issue by adding a device with a
>     serial number matching the existing PCI bus domain id. (in this case that
>     happens to be zero).
>     
>     
>     Thanks,
>     Lorenzo
>     
>     Cc: stable@vger.kernel.org
>     Signed-off-by: Sridhar Pitchai <srpitcha@microsoft.com>
>     ---
>     Changes in v3:
>     * fix the commit comment. [KY Srinivasan, Michael Kelley]
>     ---
>       drivers/pci/host/pci-hyperv.c | 11 -----------
>       1 file changed, 11 deletions(-)
>     diff --git a/drivers/pci/host/pci-hyperv.c b/drivers/pci/host/pci-hyperv.c
>     index 2faf38e..ac67e56 100644
>     --- a/drivers/pci/host/pci-hyperv.c
>     +++ b/drivers/pci/host/pci-hyperv.c
>     @@ -1518,17 +1518,6 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>       	get_pcichild(hpdev, hv_pcidev_ref_childlist);
>       	spin_lock_irqsave(&hbus->device_list_lock, flags);
>       
>     -	/*
>     -	 * When a device is being added to the bus, we set the PCI domain
>     -	 * number to be the device serial number, which is non-zero and
>     -	 * unique on the same VM.  The serial numbers start with 1, and
>     -	 * increase by 1 for each device.  So device names including this
>     -	 * can have shorter names than based on the bus instance UUID.
>     -	 * Only the first device serial number is used for domain, so the
>     -	 * domain number will not change after the first device is added.
>     -	 */
>     -	if (list_empty(&hbus->children))
>     -		hbus->sysdata.domain = desc->ser;
>       	list_add_tail(&hpdev->list_entry, &hbus->children);
>       	spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>       	return hpdev;
>     --
>     2.7.4 
>     
>     
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
