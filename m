Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3352333-1524150088-2-9054710755512929294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='edu', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524150088; b=BEDVjig0dz4cJvx5QG5aT9nj1Z9bIiAu4x4bBCNAu1Gh6eVj0F
    X9j/LGH+aPevf/XRVzM4clrKC+tG3drOU1OGrLAX8RcrysieNT5XaeaQoMs+Pi/W
    a1nDUOIsgQ5xhIW429UaOdx/vbFK/dHmZSsIJOEPVSKNX/SzbkMwTVRF3sz2j1La
    1zzr/1Ym2B10XLKMoORZsrk4jLInwOGpBjpcaEy3cIzzu69pUdS3O4VouOfzwXhS
    K7qyMswsTO4jCbw5ENnuNnIjUWZ4vEQHPmhnJpNcPx+EOwcKCgShjCsYb3nBB4SF
    LubV5GiJ/l6KUalTsDXxzRtgiHZ4guS7+20A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1524150088; bh=mS5CkIEp+2dgryRoK4Yss+qkopz2opHXjsrEn9D6BRM=; b=C
    /p7T2D7D/UOLO3CeuowuJ76VHwquxy0G/kOOM1tb7CblxrSeFkv0pYIoAozaoR2b
    Q3Y7YC+65ylmyhCxK6sDGL/gH9oQ9E4HTY1CPDs+zvV7PtHe+qOHgF1LEDZhzWjB
    SvSQUOBMFM7taF9fnYet3+fJsdZtg3j5yzrpqiY3Yx6IMuf7OTIxKgw2TKNw+Od8
    +aCzqxp/IPs6Fhfs1yx1po7NDXmebnnzDNOKxjkmB0rt5Bo/Y35dIrLETnfMHsOt
    YCKMmz82KqCQ0aDTKvsuBzyXtV1rnBtSx687WJJ86pO5kCmYxG76TPtYFYYwvM/l
    NbARK9dKeovwm0v+nYljg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=rowland.harvard.edu;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=rowland.harvard.edu header.result=pass header_org.domain=harvard.edu header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGXRmO9cP5u1hdHD1pItYLAPEdTB4v418EWKvsIsa8k/4oW2Vu8XLokEMVzCz2559+Rb/9UdiUHFPRACRoVEMTEJAbjZm0qWLvw6rpqWQSx9r/QfKpe+
    udANV9nmmL/tNlQNbiRbTqHHOjGaaKxQbH80xX8LLVz2NV67Ea0q0bwHkNRCJ8+o2CsD9oCn8r5EGT1AhvAdZfsJTFymHYmXCPtjjnXLbXRaeeqHWdhe3d1k
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=I08wRrAMQdQY7cZk-WwA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752915AbeDSPBW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:01:22 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:60732 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1753153AbeDSPBU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 19 Apr 2018 11:01:20 -0400
Date: Thu, 19 Apr 2018 11:01:19 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Ravi Chandra Sadineni <ravisadineni@chromium.org>
cc: gregkh@linuxfoundation.org, <martin.blumenstingl@googlemail.com>,
        <ravisadineni@google.com>, <chunfeng.yun@mediatek.com>,
        <johan@kernel.org>, <arvind.yadav.cs@gmail.com>, <dtor@google.com>,
        <anton.bondarenko.sama@gmail.com>, <f.fainelli@gmail.com>,
        <keescook@chromium.org>, <mathias.nyman@linux.intel.com>,
        <felipe.balbi@linux.intel.com>, <ekorenevsky@gmail.com>,
        <peter.chen@nxp.com>, <joe@perches.com>, <tbroch@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rajatja@google.com>, <bleung@google.com>
Subject: Re: [PATCH] USB: Increment wakeup count on remote wakeup.
In-Reply-To: <20180419001850.133110-1-ravisadineni@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1804191053410.1288-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 18 Apr 2018, Ravi Chandra Sadineni wrote:

> On chromebooks we depend on wakeup count to identify the wakeup source.
> But currently USB devices do not increment the wakeup count when they
> trigger the remote wake. This patch addresses the same.
> 
> Resume condition is reported differently on USB 2.0 and USB 3.0 devices.
> 
> On USB 2.0 devices, a wake capable device, if wake enabled, drives
> resume signal to indicate a remote wake (USB 2.0 spec section 7.1.7.7).
> The upstream facing port then sets C_PORT_SUSPEND bit and reports a
> port change event (USB 2.0 spec section 11.24.2.7.2.3). Thus if a port
> has resumed before driving the resume signal from the host and
> C_PORT_SUSPEND is set, then the device attached to the given port might
> be the reason for the last system wakeup. Increment the wakeup count for
> the same.
> 
> On USB 3.0 devices, a function may signal that it wants to exit from device
> suspend by sending a Function Wake Device Notification to the host (USB3.0
> spec section 8.5.6.4) Thus on receiving the Function Wake, increment the
> wakeup count.
> 
> Signed-off-by: ravisadineni@chromium.org
> ---
>  drivers/usb/core/hcd.c |  1 +
>  drivers/usb/core/hub.c | 12 ++++++++++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 777036ae63674..79f95a878fb6e 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2375,6 +2375,7 @@ void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
>  {
>  	unsigned long flags;
>  
> +	pm_wakeup_event(dev, 0);

Instead of dev, you probably want to use hcd->self.sysdev.  Or maybe
hcd->self.controller, although the difference probably doesn't matter 
for your purposes.

On the other hand, this wakeup event may already have been counted by
the host controller's bus subsystem.  Does it matter if the same wakeup
event gets counted twice?

(This is inevitable with USB devices, in any case.  If a device sends a 
wakeup request, it will be counted for that device, for all the 
intermediate hubs, and for the host controller.)

> @@ -3432,10 +3437,13 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  
>  	usb_lock_port(port_dev);
>  
> -	/* Skip the initial Clear-Suspend step for a remote wakeup */
>  	status = hub_port_status(hub, port1, &portstatus, &portchange);
> -	if (status == 0 && !port_is_suspended(hub, portstatus))
> +	/* Skip the initial Clear-Suspend step for a remote wakeup */

What is the reason for moving the comment line down after the 
hub_port_status() call?

Alan Stern

> +	if (status == 0 && !port_is_suspended(hub, portstatus)) {
> +		if (portchange & USB_PORT_STAT_C_SUSPEND)
> +			pm_wakeup_event(&udev->dev, 0);
>  		goto SuspendCleared;
> +	}
>  
>  	/* see 7.1.7.7; affects power usage, but not budgeting */
>  	if (hub_is_superspeed(hub->hdev))
> 

