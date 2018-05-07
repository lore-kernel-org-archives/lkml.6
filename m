Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1682199-1525729702-2-10205609791578776663
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
    1525729701; b=LG8V50MP2YlAomuj0k7+kUPBrbP40YicE92o4Keg30vO+OzgZV
    O75p5cGd3/ybIUTBZlVNzuDLs+3HZ7xkPumV7b3fXytg1ZOJc0cDYr0qzb97eBB7
    0VxNPGq7+ojEN+g8Dn+BKfO893bA4c4SHfs7zouDXDTnjrKNr7RU0dlfS2DLPDCR
    AXbu+UPjMBd8nu8IvfKIIWBF0oo21IUeK0BuFDJfFu6URRV2yjprOSsgdoht6h5J
    nVIrd40ty50zDYiXHn5OT7gQjhmdcJxRSlpWgKagitMiLEDN6zdrXTShXYl3/w2C
    9myC44V+VQvWFj87/jLXnmeLhFIRTWxZeYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525729701; bh=hJdNlDj4g3QgnzPCPdMYverrZPx1WW
    x1ETfdRHhrKj4=; b=fv73cBGVTGbptXv+9CDAc8jOpjlhq8HhSRnyTVSE76+CsT
    BB0bV0xrUc5vNzTQSaoso+aCuFhSSPWFheAlUyRw0vmUclfwZ5IxxAwGirYABuKB
    mGjQE74vdL4CtmGZNRzdsl+1ulqwdN5yDsggbxd812H6tV/Vj7f/Ef9z3SvaHO9a
    jm+NG6veTINyGiFxTuAShjawawmt+2IyM/DfY2wtGZRtejAfJwcV+qJXlOpLYzlq
    2AP936/WBNp77jR//QrWAjEJZQhFKM0lN7vzuwyXjNgaRZuwA/xAaAEai0ip8lCz
    jdy0Yi3mR0VSEV8QHpn1TIdttdVwvr79vj5Y7ijA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=hLYMj8s1 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=hLYMj8s1 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfE91mFTHFFh1dpZPJIEXRGEBCAgGixrcMhIUCuVlbS//Zs1syRnOe2YkEizU89LjzQOMl1Tm/+BrdNwtIMHNaa5SoROFFOA5GjD+R2GA3VFHgVHXNgGf
    x2PqF0Hs1idHczKpnLTTnSj07h2leKyMBPSBIer2t55c/qc+eCcO2SSXcgqJ8IMvjW84jAPl1JbSJWfeV+/jqFKoy0wLfkJwhdEzTO9oqrGavn4BQ30R4l1c
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=DfNHnWVPAAAA:8 a=1XWaLZrsAAAA:8 a=0xD1uOI68rS6A9-mmcAA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=rjTVMONInIDnV1a_A2c_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752676AbeEGVsU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 17:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752550AbeEGVsT (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 7 May 2018 17:48:19 -0400
Date: Mon, 7 May 2018 16:48:17 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: bhelgaas@google.com, rafael.j.wysocki@intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v4] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
Message-ID: <20180507214817.GC133147@bhelgaas-glaptop.roam.corp.google.com>
References: <20180507061120.3683-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507061120.3683-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 02:11:20PM +0800, Kai-Heng Feng wrote:
> USB controller ASM1042 stops working after commit de3ef1eb1cd0 ("PM /
> core: Drop run_wake flag from struct dev_pm_info").
> 
> The device in question is not power managed by platform firmware,
> furthermore, it only supports PME# from D3cold:
> Capabilities: [78] Power Management version 3
>        Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0-,D1-,D2-,D3hot-,D3cold+)
>        Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
> 
> Before commit de3ef1eb1cd0, the device never gets runtime suspended.
> After that commit, the device gets runtime suspended to D3hot, which can
> not generate any PME#.
> 
> usb_hcd_pci_probe() unconditionally calls device_wakeup_enable(), hence
> device_can_wakeup() in pci_dev_run_wake() always returns true.
> 
> So pci_dev_run_wake() needs to check PME wakeup capability as its first
> condition.
> 
> In addition, change wakeup flag passed to pci_target_state() from false
> to true, because we want to find the deepest state that the device can
> still generate PME#. In this case, it's D0 for the device in question.
> 
> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct dev_pm_info")
> Cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Rafael, can you queue this up?  de3ef1eb1cd0 went through your tree,
and I don't really understand the patch, so I'll rely on your review.

> ---
> v4: Correct some errors in commit log.
> 
> v3: State the reason why the wakeup flag gets changed.
> 
> v2: Explicitly check dev->pme_support.
> 
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index a04197ce767d..c2616cad3a1d 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2138,16 +2138,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
>  {
>  	struct pci_bus *bus = dev->bus;
>  
> -	if (device_can_wakeup(&dev->dev))
> -		return true;
> -
>  	if (!dev->pme_support)
>  		return false;
>  
>  	/* PME-capable in principle, but not from the target power state */
> -	if (!pci_pme_capable(dev, pci_target_state(dev, false)))
> +	if (!pci_pme_capable(dev, pci_target_state(dev, true)))
>  		return false;
>  
> +	if (device_can_wakeup(&dev->dev))
> +		return true;
> +
>  	while (bus->parent) {
>  		struct pci_dev *bridge = bus->self;
>  
> -- 
> 2.17.0
> 
