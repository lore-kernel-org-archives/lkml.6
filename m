Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2590670-1521720360-2-15319069630705292880
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521720360; b=OKQPSDmsqrJY7+iZTKH6t/pjatkzn9O+VHJ9gUy2OnL3eJR
    +ocKqWd/SgW13U8ue504rR5BAUd9ZvNMA1xl3SpDotFbluLbKxKGQGe+OxgGeSR0
    UyULnh11aBTl+OrtK4QPQ/xAkgbxPuOMCZaMW51JNO+UoBHYfAVSavpDpB888IQk
    3piqGVkHr38XDWVJ69X4jcGi4k4jAeUGA7OwzpVcd6QBDPyEqkLBDZ08IuDNU6KD
    XowOeQdXvvZRcaTMOwYO8L6Q9Jxi+K6ZRNoMLzb5MUdQhXO2HWR+nfO6T06DvLr1
    d0O17AwD9lCZGl7JuKf+1n/GYoO2OL6cIltGJgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521720360; bh=RNuF985WICvaLiyn6huNtk8MQe
    6cPsTQIFbZmWFZSiY=; b=VP39wQMN9CUHCKiLixWBPb78RVCiBmZII+WTaVYgVs
    cPJE/OQ7bAxn1onsPNlPioQ0Hnb0ZLsEvzU5zzYoi924vVvS3mP/qV+B4MmobcCF
    GCj4VzPzFwyxqxMxSrzVnFy4HEAjx3a50vWw4VDihhDJyWT3/ae5LYD/UaFKHM9W
    ZynomMqKAFAcNjV59oEgD58an/Bq57Ftan0ojYLWeemeLh1Ni3xgMEGoK5JFA/pZ
    Ofwot/Jfz4yyex+PSo/PKwuYo8GqGIrqF/NE0WjE3IAW4JQezWQ7x4vrS6WIKn0o
    xhfCWRxGOI57shL3nNI7dAVB8dx30Bo56PK8VtQUNFyw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753578AbeCVMFs (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Mar 2018 08:05:48 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57656 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752731AbeCVMFr (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 22 Mar 2018 08:05:47 -0400
Date: Thu, 22 Mar 2018 13:05:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Richard Leitner <dev@g0hl1n.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stern@rowland.harvard.edu, linux@roeck-us.net,
        mathias.nyman@linux.intel.com, johan@kernel.org,
        felipe.balbi@linux.intel.com, ekorenevsky@gmail.com,
        peter.chen@nxp.com, drake@endlessm.com, joe@perches.com,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v4] usb: core: introduce per-port over-current counters
Message-ID: <20180322120543.GA27923@kroah.com>
References: <20180320101713.5650-1-dev@g0hl1n.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320101713.5650-1-dev@g0hl1n.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 11:17:13AM +0100, Richard Leitner wrote:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> For some userspace applications information on the number of
> over-current conditions at specific USB hub ports is relevant.
> 
> In our case we have a series of USB hardware (using the cp210x driver)
> which communicates using a proprietary protocol. These devices sometimes
> trigger an over-current situation on some hubs. In case of such an
> over-current situation the USB devices offer an interface for reducing
> the max used power. As these conditions are quite rare and imply
> performance reductions of the device we don't want to reduce the max
> power always.
> 
> Therefore give user-space applications the possibility to react
> adequately by introducing an over_current_counter in the usb port struct
> which is exported via sysfs.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
> Changes v4:
> 	- reintroduce forgotten Changelog
> Changes v3:
> 	- Improve sysfs file description as recommended by greg k-h
> Changes v2:
> 	- rename oc_count to over_current_count
> 	- add entry to Documentation/ABI
> 	- add detailled description to commit message
> ---
>  Documentation/ABI/testing/sysfs-bus-usb | 10 ++++++++++
>  drivers/usb/core/hub.c                  |  4 +++-
>  drivers/usb/core/hub.h                  |  1 +
>  drivers/usb/core/port.c                 | 10 ++++++++++
>  4 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
> index 0bd731cbb50c..c702c78f24d8 100644
> --- a/Documentation/ABI/testing/sysfs-bus-usb
> +++ b/Documentation/ABI/testing/sysfs-bus-usb
> @@ -189,6 +189,16 @@ Description:
>  		The file will read "hotplug", "wired" and "not used" if the
>  		information is available, and "unknown" otherwise.
>  
> +What:		/sys/bus/usb/devices/.../(hub interface)/portX/over_current_count
> +Date:		February 2018
> +Contact:	Richard Leitner <richard.leitner@skidata.com>
> +Description:
> +		Most hubs are able to detect over-current situations on their
> +		ports and report them to the kernel. This attribute is to expose
> +		the number of over-current situation occurred on a specific port
> +		to user space. This file will contain an unsigned 32 bit value
> +		which wraps to 0 after its maximum is reached.
> +
>  What:		/sys/bus/usb/devices/.../(hub interface)/portX/usb3_lpm_permit
>  Date:		November 2015
>  Contact:	Lu Baolu <baolu.lu@linux.intel.com>
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index c5c1f6cf3228..6f779b518e75 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5104,8 +5104,10 @@ static void port_event(struct usb_hub *hub, int port1)
>  
>  	if (portchange & USB_PORT_STAT_C_OVERCURRENT) {
>  		u16 status = 0, unused;
> +		port_dev->over_current_count++;
>  
> -		dev_dbg(&port_dev->dev, "over-current change\n");
> +		dev_dbg(&port_dev->dev, "over-current change #%u\n",
> +			port_dev->over_current_count);
>  		usb_clear_port_feature(hdev, port1,
>  				USB_PORT_FEAT_C_OVER_CURRENT);
>  		msleep(100);	/* Cool down */
> diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
> index 2a700ccc868c..78d7f4dad618 100644
> --- a/drivers/usb/core/hub.h
> +++ b/drivers/usb/core/hub.h
> @@ -100,6 +100,7 @@ struct usb_port {
>  	unsigned int is_superspeed:1;
>  	unsigned int usb3_lpm_u1_permit:1;
>  	unsigned int usb3_lpm_u2_permit:1;
> +	unsigned int over_current_count;

This should be 'u32', right?  I'll go edit it by hand...

thanks,

greg k-h
