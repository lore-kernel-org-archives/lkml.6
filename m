Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2817436-1523336199-2-14588750667858701621
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523336198; b=Y9omU/lQDyUCoXewsGAioBoULHLs7LlCWOOpfBGHycxKM2JI79
    ANMgMhWMlAugSiD3lIk0ANdWYWnpvXede+ZSsgR33mRg4DaEXTBZ+/rWQCYtAlht
    AWwBDjmbD6OUgPISKz9oNuJ90CG+SalIgAIipeZ7W4DH+dSFNPn//EIhbuKwsGmT
    ocTeBsgBTnAeB5iS8pQO9hdQ/v7kBzPcfmx51JW+1L/EcJfKFfviGDFmGa2zyAOh
    KHNO7erP8nqo3hHOSmyxu0AGvDN/XhtsvpvsJdrXyDsdbSSXbUuyapWp417MSQwP
    TeeYl1CoT8f81Bmdq9JAMunH4XErhJqUFtrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=fm2; t=1523336198; bh=gpmtF8Qc3
    MZzsDKjhvs3MZuUkkShjDcdC3CngLSHI3I=; b=q02zwNPFKjaRai9OEYvToKiGX
    K8jNMYW0By5LbSluwjDtSxrPX1vlOKQ9bG0XI3Vu7zy7ZtNZIlLZ0aPwnTw/whfn
    3AbX+o8yCUAviPF+F5bJDi/fbRGeYTzmFrvUDHiORc0SywbGlhaD35fY5abk3mo5
    Kd7TJ8gUshemCCm8FAGEq96TKwqMDy1fpYrERJ7spYKozsft6FRxk911+m9ekTOm
    V7YPJ/QjuisKp7Y0a4JG7TMpMfVjzBswyJKu7DBnErVXsw95J6YFBhi+qXKL+33x
    DL5cSWmwB54g53sdkCYOsMCDVrqlh8S9Ahml3GcAx5yPwzgi6zZxMIKSiqTXg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=egQQSRIU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=egQQSRIU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE9WUaMwaLODMdGZ/A+i0FbUDSK39oEueEoD3tf3nJgmzGqw72HGtX/FuuZLJIQ96edsqcPxEkOnmp4dnh47MFf/TA5z07hDNKNb8Ucw3v3SpNjHMVuX
    dfvSC4a5q36wcRBdpfdyNStoRnpj8oqk9cy3pFrZTZYFLLAHfqyWLgk5GtNCRE0sSl0Dn4zUHyLcR1pG16WhuISCBU3oVdj9hfdT2mMEtMGFXAuCEHjEXLM2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=h0TMrea9ZsH5hRTzAw0A:9 a=CjuIK1q_8ugA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751595AbeDJE4X (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 00:56:23 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41841 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeDJE4H (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 10 Apr 2018 00:56:07 -0400
X-Google-Smtp-Source: AIpwx48ji5IxUyUq+zpSKFePbK1oCEvjymZvP4MyZ6N3/evJhtPB4MmikXh0mcjjixDu2CGhofJqPg==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] xhci: Fix USB ports for Dell Inspiron 5775
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180318151110.15308-1-kai.heng.feng@canonical.com>
Date: Tue, 10 Apr 2018 12:56:00 +0800
Cc: Greg KH <gregkh@linuxfoundation.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <7DBCE486-BE04-422B-9902-B9403AD85B37@canonical.com>
References: <20180318151110.15308-1-kai.heng.feng@canonical.com>
To: mathias.nyman@intel.com
X-Mailer: Apple Mail (2.3445.6.18)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matthias,

> On Mar 18, 2018, at 11:11 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> wrote:
>
> The Dell Inspiron 5775 is a Raven Ridge. The Enable Slot command timed
> out when a USB device gets plugged:
> [ 212.156326] xhci_hcd 0000:03:00.3: Error while assigning device slot ID
> [ 212.156340] xhci_hcd 0000:03:00.3: Max number of devices this xHCI host  
> supports is 64.
> [ 212.156348] usb usb2-port3: couldn't allocate usb_device
>
> AMD suggests that a delay before xHC suspends can fix the issue.
>
> I can confirm it fixes the issue, so use the suspend delay quirk for
> Raven Ridge's xHC.

I am hoping this patch can get merged in v4.17...

Thanks,
Kai-Heng

>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/usb/host/xhci-pci.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-pci.c b/drivers/usb/host/xhci-pci.c
> index d9f831b67e57..93ce34bce7b5 100644
> --- a/drivers/usb/host/xhci-pci.c
> +++ b/drivers/usb/host/xhci-pci.c
> @@ -126,7 +126,10 @@ static void xhci_pci_quirks(struct device *dev,  
> struct xhci_hcd *xhci)
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD && usb_amd_find_chipset_info())
>  		xhci->quirks |= XHCI_AMD_PLL_FIX;
>
> -	if (pdev->vendor == PCI_VENDOR_ID_AMD && pdev->device == 0x43bb)
> +	if (pdev->vendor == PCI_VENDOR_ID_AMD &&
> +		(pdev->device == 0x15e0 ||
> +		 pdev->device == 0x15e1 ||
> +		 pdev->device == 0x43bb))
>  		xhci->quirks |= XHCI_SUSPEND_DELAY;
>
>  	if (pdev->vendor == PCI_VENDOR_ID_AMD)
> -- 
> 2.15.1
