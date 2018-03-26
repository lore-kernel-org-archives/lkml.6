Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-156720-1522043697-2-11470360607743876008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522043696; b=gocMZ40Cp4bsGGxN+ommwe8KUlHXPj+PH1LOKbQs9mA+Jal
    CyYwEB2oXQQya2w7xBoCsOMd4qtwrbo3MrEI5iCl+sr+m6i+dQ/Ztt1FrCmgx7XS
    jQSsqt8LYActPw38iOKuavuIAxBksirghDXSJnJDBHRdPBAeAyCDLEix0CVw+/Ol
    9qKv33BGSO585QOQHSzG0zLxekCH6v1pIl8j+6XJJPoQI+7Lw3GX3YrnXo0v26x1
    vHHNyHzIK416tMnB1wzgeUhvgHqjrOYY4XS4he/w2iBSiXKQHR9RjW1lDZy+49zC
    SXt2RU8ap0Ere8wL1jZmgtuXCRp0r4UsRmpRhdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1522043696; bh=WpB1m
    LLzW1jeaT7ojQmU93gA+BzVaJDNxFcmirhwYSM=; b=wHZ5LGbu0YS5UzJgVFteN
    I9w34WCAyghPtYMA/JvpCx4Z8SSUejGv8ir/GPHEQQY08iYu7ZQ57np1jdATT31H
    ziJg5rVPyOAg96DneaRh4yhmCSr9j5Alt1itRLy8fczwB6kGVjpG3rXozQdpEXm9
    p4BftBz2KeWj6JlN5Wi6AnJc0FTf9E2rOofz0JgsQP0WJTlZOVp3AP48oEtnwvUQ
    8k5N/CXB8FtpIAOlIoq0LeFWKiAAp16sgxsXej+A2ZYyHza1yYKiPgiAcTOgaeiR
    pyzQNLuf7e7Y7dBaBiFPJlC7OfaBBnO7eZpBk0UZvYFbuo10qclX8iK6nhOpyvGk
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JWZUbtFG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=JWZUbtFG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO0Yx7DRpUNd1sk43kMj5Mz0vELLg1NlfbLar/WAmekzRZKc66qC13lZs0p5wOOArHFvdRF7slwyhiAzB3a5DNHsbR8DUMWpC2g9iJ62P/21pnCYgKn/
    jdgRJ9Qg7oEGScdvzqfrPn4ewN3MQL1THiqMF4rx9aAEfYuB7oTctrVnU0vtQhZw12fKOggcZtLHi1F9Vp5Q+XDrBr2gH+uZcUTvj9ueQEZGaykYY2CVcyl2
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=DfNHnWVPAAAA:8 a=VwQbUJbxAAAA:8 a=0xD1uOI68rS6A9-mmcAA:9 a=CjuIK1q_8ugA:10
    a=rjTVMONInIDnV1a_A2c_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751133AbeCZFyp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Mar 2018 01:54:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42879 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeCZFyn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 26 Mar 2018 01:54:43 -0400
X-Google-Smtp-Source: AG47ELs4DpMYOgTpfmzZY86eNHntNHQ0DjJ6Upmo+ep+xR6SrUsjbqgG/KMcs23N/ct0SeOdmaBvfQ==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.15\))
Subject: Re: [PATCH v2] PCI / PM: Always check PME wakeup capability for
 runtime wakeup support
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180319140910.26496-1-kai.heng.feng@canonical.com>
Date: Mon, 26 Mar 2018 13:54:35 +0800
Cc: rafael.j.wysocki@intel.com, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <5DC805B1-51DA-4D0F-9A43-9D5FE549AB13@canonical.com>
References: <20180319140910.26496-1-kai.heng.feng@canonical.com>
To: bhelgaas@google.com
X-Mailer: Apple Mail (2.3445.6.15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Bjorn, Rafael,

> On Mar 19, 2018, at 10:09 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> wrote:
>
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
> After that commit, the device gets runtime suspended, so it does not
> respond to any PME#.
>
> usb_hcd_pci_probe() mandatorily calls device_wakeup_enable(), hence
> device_can_wakeup() in pci_dev_run_wake() always returns true.
>
> So pci_dev_run_wake() needs to check PME wakeup capability as its first
> condition.
>
> Fixes: de3ef1eb1cd0 ("PM / core: Drop run_wake flag from struct  
> dev_pm_info")
> Cc: stable@vger.kernel.org # 4.13+
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>


Is there any improvement I can address?
Or do you have any concern about this patch?

Kai-Heng

> ---
> v2: Explicitly check dev->pme_support.
>
>  drivers/pci/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index f6a4dd10d9b0..52821a21fc07 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2125,16 +2125,16 @@ bool pci_dev_run_wake(struct pci_dev *dev)
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
> 2.15.1
