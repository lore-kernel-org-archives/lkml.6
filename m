Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1751301-1524233597-2-7516014187609670156
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
    1524233596; b=XP6uB4SgaMTCQKIZZ3wH6CoDzhcHT5gv8j4pl+pFGdPzxkGtj2
    U1wpDIYKg5GBS7dpwILAjLC1oooy8a03lYHBejs+gyrH9gLtIDiAeXVtUGwzNEx3
    dYTldv0Z/EjtJelgvldZekOC96D6zGhlspdwodrzTpjiSQhC7pHi/XeLUvfYulPL
    Md0kVRMSuwEkLNqDmgxwtwVMvEWXWo0NHNV9vMuhK09xsJ4OvaN8nzrEu85B7Hvy
    V4qZbs56M63bXv5EjohNtIo5+Qremg7OoVSbPqSwwSNvJv/Klpck9W7H/40pSAKp
    z0mKtCNvjZb36yt23yCqoInYVMUzsf0XxZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:mime-version:content-type:sender:list-id; s=fm2; t=
    1524233596; bh=GGoq6Uxy4jph8G07TviVSDK+hAds1i7RJit9ACt+5Oo=; b=n
    t0K99d1yH6nDNNE3Riol5KnEVfb1lUeI4TZZ/jwAAFIO52lkku1ufr/cL7lYfO9q
    7jSHiovTqPhnONeTjIeF0JmVHJCnGlLu4LLFybqFomJvBuw10zfrt8F3M/2/pNC9
    JMcW+wPLjPmXS7d3fSb9X6kcN9H7PZUrWGXW1pF4RcHVg6kKf9DiKHk27DeIYYkR
    oCzDYnxQw9NoU9LHL+LdfXqO8Ww2NhzMFE3f3ekE64ADKHG9wYaNa/9uKxNoyqAa
    8Sf+M/ERr45Y1is9xDIrSFsWkkrB30v2bl7pSgGnFwdTuoWenRT/zXld9vJxie+J
    wdwEbGU+uZUu69XSGY0PQ==
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
X-CM-Envelope: MS4wfAA8KIU8d9QSbT6Y1Ugl+ZfwUqhsGYN439EZu8k4l1KgrYUH9+mMSLvywoTXjbTzFTRB7DBpc+HXE5AAALPRF7IwkX7iFmnswdKGiwNmV1lq7MctCMX4
    garWey05PNKXn2lDB3Bpw/zuDPKf3sFM5A0jfZalMqvcxXCGen+kBK/4O8Q64pZC9kmuOeF9ptJLzi42slLcAOxtr+dseOeQmQ6FXk6fvB5cpQmRU/+/GkLt
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=QrDcchjUp35q_qlsFaUA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754966AbeDTOM5 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 10:12:57 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:48812 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1755221AbeDTOMx (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 20 Apr 2018 10:12:53 -0400
Date: Fri, 20 Apr 2018 10:12:52 -0400 (EDT)
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
Subject: Re: [PATCH V2] USB: Increment wakeup count on remote wakeup.
In-Reply-To: <20180420002752.181261-1-ravisadineni@chromium.org>
Message-ID: <Pine.LNX.4.44L0.1804201010110.1407-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 19 Apr 2018, Ravi Chandra Sadineni wrote:

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
> Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> ---
>  drivers/usb/core/hcd.c |  2 ++
>  drivers/usb/core/hub.c | 10 +++++++++-
>  2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
> index 777036ae63674..ee0f3ec57ce49 100644
> --- a/drivers/usb/core/hcd.c
> +++ b/drivers/usb/core/hcd.c
> @@ -2374,7 +2374,9 @@ static void hcd_resume_work(struct work_struct *work)
>  void usb_hcd_resume_root_hub (struct usb_hcd *hcd)
>  {
>  	unsigned long flags;
> +	struct device *dev = &hcd->self.root_hub->dev;
>  
> +	pm_wakeup_event(dev, 0);
>  	spin_lock_irqsave (&hcd_root_hub_lock, flags);
>  	if (hcd->rh_registered) {
>  		set_bit(HCD_FLAG_WAKEUP_PENDING, &hcd->flags);

In general, hcd->self.root_hub is guaranteed to be non-NULL only when 
hcd->rh_registered is set.  Therefore the assignment to dev and the 
call to pm_wakeup_event() should be moved within this "if" statement.

The rest of the patch looks okay.

Alan Stern

> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index f6ea16e9f6bb9..aa9968d90a48c 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -653,12 +653,17 @@ void usb_wakeup_notification(struct usb_device *hdev,
>  		unsigned int portnum)
>  {
>  	struct usb_hub *hub;
> +	struct usb_port *port_dev;
>  
>  	if (!hdev)
>  		return;
>  
>  	hub = usb_hub_to_struct_hub(hdev);
>  	if (hub) {
> +		port_dev = hub->ports[portnum - 1];
> +		if (port_dev && port_dev->child)
> +			pm_wakeup_event(&port_dev->child->dev, 0);
> +
>  		set_bit(portnum, hub->wakeup_bits);
>  		kick_hub_wq(hub);
>  	}
> @@ -3434,8 +3439,11 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
>  
>  	/* Skip the initial Clear-Suspend step for a remote wakeup */
>  	status = hub_port_status(hub, port1, &portstatus, &portchange);
> -	if (status == 0 && !port_is_suspended(hub, portstatus))
> +	if (status == 0 && !port_is_suspended(hub, portstatus)) {
> +		if (portchange & USB_PORT_STAT_C_SUSPEND)
> +			pm_wakeup_event(&udev->dev, 0);
>  		goto SuspendCleared;
> +	}
>  
>  	/* see 7.1.7.7; affects power usage, but not budgeting */
>  	if (hub_is_superspeed(hub->hdev))
> 

