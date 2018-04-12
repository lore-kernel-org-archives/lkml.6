Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-591792-1523524677-2-4403628671452830609
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, HEXHASH_WORD 2.999,
  MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523524676; b=UY0xuCEmdUcYKMiNRvjHx1MMtTHAMWtuWg3Q3yWcISso+lVjTH
    ZItfLCNES3CVGLk4x2pm5gg/KlPGUkkwSoUFtsSQHwe/x5fUoSvHRRQ7R4w6zSP3
    lccC047tzy+vFbqHB9NJixowZMJJniGV9nHJFEChoW7RwAtnWKQ1u7EbXWiZwBCO
    gzNyvtGO1/s/my7gFZEzYxmPyeJpg8lN0rLXzHHrmLjnpfr1Xu5WpDKZR1yoRWNb
    trboo1nSEGxnjUfM5szhUQikv0PoanK7vIOITlA0se7Q+GfstlwWV0A+KgMWIAOB
    nfFlPK8RxW8BNT/RuKaL+GnhctMVVy1CCAWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523524676; bh=/3iXU
    FUxf7cv6TGGNCBxTq0LGDa/78Gn6DX7uuktyeo=; b=CGWTCfJ5VnZeITqcwuPQo
    Nk5xtCYen2MUEr5Oi9r59GMqqziELc6HyektNmIdYM/eMtI7iJoAc8SzhE2T+cKS
    kNLo5FPZnle1lSpDppY6sivMvbVJRNyJk0zGmaxtnEZYGDZjyMLdlAmPWbcB+bI0
    0tMy9BMK/MkUSsVsd4BFDpTkvLYyCVFsqDS616Q/r14TsZZksUI8f0zdFyzFR+zi
    Dp5a+qW5AXR32jyg4YzpWQiH7fEm+es6RaD6/TBUPkrYBZsyVnBp8O5mMZAYLW7p
    LsOnXRWZlH6FX85lSL0tUWHEMB0Dkct3A8ZqGC0ZfezbPm4DOZAjAT7CYiBnSEn1
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=arm.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCiNuNhyapOYEDptRPfRMXBIeRTGt9PydY8cAAxWsoOpJFQ6YDq/duxFf/9n/cLACKJoyjhC2c52nQHgMpP9w0dipji1yQkErKL8h14M0qTGibp16u5p
    2fL/zd8IxSIkN6Ju5mNMiFxUJaxi97jodL9GFRdd7+F9CZaWtiR4kQCDAgdokvReP29wxuBRZoA0Dbn669g9NQoN9sJfPNHwLEybLioZ5UP5NovG0B/Tik2U
    GMJGVSGk57/t+WW9nIBMZg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=gu6fZOg2AAAA:8 a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8 a=_gdl5x-7BR-a16W4YwwA:9
    a=W_1ggfZVtu3VBnsM:21 a=Xih0gMf_XIvTcDKG:21 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=2RSlZUUhi9gRBrsHwhhZ:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 12 Apr 2018 10:17:42 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v7] Revert "PCI: hv: Use device serial number as PCI
 domain"
Message-ID: <20180412091742.GA31251@e107981-ln.cambridge.arm.com>
References: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <FE7CB779-F2C9-4967-BCF1-A0DFE846B2E5@microsoft.com>
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
 Bjorn Helgaas <helgaas@kernel.org>, Jake Oshins <jakeo@microsoft.com>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:44:42AM +0000, Sridhar Pitchai wrote:
> When Linux runs as a guest VM in Hyper-V and Hyper-V adds the virtual PCI
> bus to the guest, Hyper-V always provides unique PCI domain.
> 
> commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> overrode unique domain with the serial number of the first device added to
> the virtual PCI bus.
> 
> The reason for that patch was to have a consistent and short name for the
> device, but Hyper-V doesn't provide unique serial numbers. Using non-unique
> serial numbers as domain IDs leads to duplicate device addresses, which
> causes PCI bus registration to fail.
> 
> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org

I am still not happy with this patch.

-  You do not explain at all the dependency on commit 0c195567a8f6 and
   you should because that's fundamental, if that patch is not present
   this revert breaks the kernel as per previous discussions[1].
-  You are sending this patch to all stable kernels that contain the
   commit you are fixing - some that may not contain the commit above
   (that was merged in v4.14), you are breaking those kernels, if not
   explain me why please

You must mark the stable kernels you want this revert to be applied to
eg:

Cc: <stable@vger.kernel.org> # v4.14+

and for kernels that do not contain the 0c195567a8f6 commit you have to
add the dependency. Please read the documentation Greg provided you in
relation to stable kernel rules.

Use:

git tag --contains

to detect in what kernel version the given commits are present.

[1] https://marc.info/?l=linux-pci&m=152158684221212&w=2

> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> Changes in v7:
> * fix the commit comment. [Bjorn Helgaas]
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
