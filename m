Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-854779-1522738596-2-8684085483291483284
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522738595; b=Iz5NMcphqHuh3VaOS5nLnuWzgkMnA658+6P5hdWaEaiobkxxsG
    2CbY7RtbqQMbfCImG/IeuAnmOMiF2kye6Smhde/vDgHsdBvmXL9edPlTYzkH6+rB
    9zfEx0CsD2xVLStHFoekNLL0313qmfK9Hp6kKSPLY13J3Y34l0n3tN4s/ILqKdxf
    0wM2gXyr/3MKAk5wF9rJB0l9gJHrJFCKztOY6iZn09xJTLaCc6v15TOd0P7jEnpx
    M4kPW0L/WCEDHpoZwnm7/R6zg/GMd3+XfFcd9se8J4sAJoi7boFiduIYTINPvq6x
    MKUmi/NvkZGDHuUc4wFU0XQ44pcG0sBIq6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522738595; bh=y5qVFeB3HcnT6EdI6KFk965sUqagmL
    Zp13fz/SD5JAc=; b=vmx+HX9ex6RKYFGE9F+vYTL27zBDsYSZxMi8I71lOAPvAb
    KLg6k+AO9mtUCj7iorkqx9mOGc+NrzJBuqF8KZj+YYXmIXt87GDrvzzoJS34t32r
    8CXDBWN3f7K3VgFf9zVV36IuN6yKrOSUcLxvg9anfZKTV1i7N4Nw94VqJ/MjNLGC
    wqdlHza3ZJx5OxrRTbtr2F+8jDtTOz30sA/fos5G1/nc5CgBT9ZH7tJvImYr0fpY
    aXDeMIEchN17pFCDd250qrJV4JZVvnjElnfwREp0XtjRlBXesThkG8mS4yB1JRj2
    GxJvsFSTcqKiCxmQiY/p4kAQqYOt5jsXOn/QXfaw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPmYBT/UwaRHRHFbHT4LrKxgOG7MC/qARVbrEjEjOz9sEQY8ANSgLgKFn5xRN46aNou2eickgcM0O77KdMDOephEWIUNP49+nFHubxRdmxrNwVN1Gngf
    C3bRaaFEG8qsVNAZM9bCBknc0Xh4r9J0/h11FgwjizUNAQiLCkP2xuWrmajnHuAUr0qOk5Gzeo2WBLV4Uo/pM8yjed51wJb+jMx5Jzbuu1Fkp/buaVmeZ0eD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=59GpDURnLakumOhCUjMA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751785AbeDCG4V (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 02:56:21 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46994 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeDCG4V (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 02:56:21 -0400
Date: Tue, 3 Apr 2018 08:56:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: valentina.manea.m@gmail.com, shuah@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usbip: vhc_hcd: prevent module being removed while
 device are attached
Message-ID: <20180403065618.GA1093@kroah.com>
References: <20180402205232.21659-1-shuahkh@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180402205232.21659-1-shuahkh@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 02, 2018 at 02:52:31PM -0600, Shuah Khan wrote:
> vhci_hcd module can be removed even when devices are attached. Fix to
> prevent module removal when devices are still attached.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  drivers/usb/usbip/vhci_sysfs.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/usbip/vhci_sysfs.c b/drivers/usb/usbip/vhci_sysfs.c
> index 48808388ec33..6a54b9aa92be 100644
> --- a/drivers/usb/usbip/vhci_sysfs.c
> +++ b/drivers/usb/usbip/vhci_sysfs.c
> @@ -9,6 +9,7 @@
>  #include <linux/net.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/module.h>
>  
>  #include "usbip_common.h"
>  #include "vhci.h"
> @@ -252,6 +253,8 @@ static ssize_t detach_store(struct device *dev, struct device_attribute *attr,
>  	if (ret < 0)
>  		return -EINVAL;
>  
> +	module_put(THIS_MODULE);
> +
>  	usbip_dbg_vhci_sysfs("Leave\n");
>  
>  	return count;
> @@ -302,7 +305,7 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>  	struct vhci_hcd *vhci_hcd;
>  	struct vhci_device *vdev;
>  	struct vhci *vhci;
> -	int err;
> +	int err, ret;
>  	unsigned long flags;
>  
>  	/*
> @@ -339,10 +342,18 @@ static ssize_t attach_store(struct device *dev, struct device_attribute *attr,
>  	else
>  		vdev = &vhci->vhci_hcd_hs->vdev[rhport];
>  
> +	/* get module ref to avoid being removed with active attached devs */
> +	if (!try_module_get(THIS_MODULE)) {
> +		ret = -EAGAIN;
> +		goto module_get_err;
> +	}

That's really not a good idea, trying to grab your own module reference
is considered racy and we stopped adding that code pattern to the kernel
a long time ago.

What's wrong if you remove the vhci module if devices are attached?  You
can do that today for any other USB host driver, this shouldn't be
"special".

Also, kernel modules are never automatically removed by the system, so
someone has to do this by hand, so they knew what they were doing :)

thanks,

greg k-h
