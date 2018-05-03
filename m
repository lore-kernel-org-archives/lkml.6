Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2438926-1525347320-2-8061566374219832670
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525347320; b=I9P0plrJ7Ok8UoYLdnS6kHicHSw2F2M1adFURR7AILSzV4BYfK
    suwB3wdWI2tahsT2ZDQsJjGFRc+uyuhODh3P1MQElCwxFhAZkPymTDKXLQF78xW/
    PNO0ekpw3zZ4sRgh9Q+oTuRay8BUoGwwbFcZdSqQFptz+qHM+At4KO36LnUgHGEj
    zyJPPcIJxjqtBX1Ydb17GlN1YzPIzt0S0rUoXugfCUftv0DHPwEn4Ba29WkGSzF1
    LsYlm0marviN9M1567ryjIhpK7Vm4yVgg97Ptz2VjH9ghQsFzljmkzlvYTAVqzSH
    xkYEZbACug0hcKQuySOn2VZohVZQPDeclzkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525347320; bh=cauL+
    Bvc8e4idZOuQYl+OK8UKxUUVslHBXZ5grEzhbo=; b=WuEBu+1jMrVr9jYR3EjiW
    MQiWk9kR9B3RPhfogo320dZfht0/1T4SOLf3dIKtC3+F59OMKWXoJ/o4xJIRlumI
    0NcwQ3nrIXHaK1f9HcPAa2Lv/hl6Usaq21rPqcW1MoylneQnLSO70M3lsWFSF76c
    P6FGLtscOYqAu7DkZq/j+Gs1DwhsePqGk+doRnpFxVp2NVOsRhQl6AV4BO3A6bzf
    eeOd+nMgFiZ71EETJGI2/nP85BCtoVW+RNV1L/Tbt3QJiqO6bwGjkqFI+8D/7R+z
    O1LJyOQTnBUKNIQuSzCT/N2oMxGqO+6pPqub6b01T6WqxuC6OsGBL/hEUuuCQCDt
    w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=arm.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arm.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=arm.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBjcDBBc4q+onIATKITDQ+i3PLc/Vlo1hSduWfu9aIJrOBwGcq9PILg0Zwmq+oftjWz3fflMdDoaW4KiiG/C6f9ccPtxfRmRPH2jAtLHM6L5YWHpCkg+
    duVW/l+AcCliPRVcmpgboXWRcxht8hluWTYFtigxFh61741UwtybBqPBNzFSqY2kR2QobTWL02CTOEurPij8dTAgg/IW9KP7zWrflmoVirztXfaHyrmy/eJF
    oHsrU01XN615Yigi/4tqeA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=yMhMjlubAAAA:8 a=VwQbUJbxAAAA:8
    a=1XWaLZrsAAAA:8 a=DDOyTI_5AAAA:8 a=L9Nf0ijdpkS5pM-7eU8A:9
    a=0hAXxL274weQpw2Z:21 a=o-VsRqjNjq8-d2aR:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 3 May 2018 12:35:04 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Sridhar Pitchai <Sridhar.Pitchai@microsoft.com>
Subject: Re: [PATCH v8] PCI: hv: Make sure the bus domain is really unique
Message-ID: <20180503113504.GA21781@e107981-ln.cambridge.arm.com>
References: <6E619990-8EFD-4688-8C01-8D9C480B04AF@microsoft.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6E619990-8EFD-4688-8C01-8D9C480B04AF@microsoft.com>
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
 Bjorn Helgaas <helgaas@kernel.org>,
 "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 01, 2018 at 05:56:32PM +0000, Sridhar Pitchai wrote:
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
> commit 0c195567a8f6 ("netvsc: transparent VF management") avoids the need
> for commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain").  When scripts were used to configure VF devices, the name of
> the VF needed to be consistent and short, but with commit 0c195567a8f6
> ("netvsc: transparent VF management") all the setup is done in the kernel,
> and we do not need to maintain consistent name.
> 
> Revert commit 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI
> domain") so we can reliably support multiple devices being assigned to
> a guest.
> 
> This revert should only be backported to kernels that contain commit
> 0c195567a8f6 ("netvsc: transparent VF management").

I removed this last paragraph, the information is in the stable tag
below.

> Fixes: 4a9b0933bdfc ("PCI: hv: Use device serial number as PCI domain")
> Signed-off-by: Sridhar Pitchai <sridhar.pitchai@microsoft.com>
> Cc: stable@vger.kernel.org # v4.14+
> Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> ---
> Changes in v8:
> * fix the commit comment. [Lorenzo Pieralisi, Bjorn Helgaas]
> ---
>  drivers/pci/host/pci-hyperv.c | 11 -----------
>  1 file changed, 11 deletions(-)

Applied to pci/hv for v4.18, thanks.

Lorenzo

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
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
