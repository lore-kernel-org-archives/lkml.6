Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2771174-1527005201-2-15110968935803688257
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527005201; b=ehtC2xkEhKf3fD5t7nTV5sC/XqML5ke2jt7h3IC3fbE9sqhCww
    9H6PfarvMDGjr6FP75OHrezbdDx3D+spUZF9uKB9IsKtP5p3i64Y2KECYOIFsFVz
    RXU8g1SgFybBLkEQghENbDEYDcNuWygHla1b6mvo1Ca2uSIekL/Vd8AEJVlcYnc+
    EtNdYXQ3uFrFQ92jkEfdD4FgyfQW9OumU08xrwNOuA0DoLNTK8AQwmvdAeO+RVvG
    6wau7F9noJks0zPl2IhcY9KdPFl0D1p8p0bWpqy+4nKUMHPeRb9F9l4GwiE90VAe
    HiDIVK40am8wOR+CvEcs8AMxKwpI5Tn7+5ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527005201;
    bh=Ie6E1uwcwYm6tLzHz1029wHIK6TiRE6b6qcMZc4qy28=; b=ACc0U4hG5fJr
    A36lDATZVyEudHtSGPMonlHrB9zojfD5RS8PvAota55Mu/EaDhVoxAd4sZKyDVyE
    /hRG1U2J+40VQx5+G+nq3IitStm/WOTh064p/G01GYAoTnR4WuXJxnXh+bxA3Buj
    L8hLQfnwlWnLngquMtXfTfeDSs2vNOeg51mSU+8VfktrSO5LALI9D9jT1NXpUO0l
    3SuqOKkIIZ9EKzv50IdkZAsltAL79oQuPuOyVqz3JntRqM2B+kL34w6z0DCIy9OX
    kIGjU2P91B5YI5WtG2LvqhTCl132k8BOFClZ7+myOwaD21ayjshXvU28u9fwbVrk
    BvYYLWJ3vA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
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
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPoO6mhrdj39+kRVkjfS+A/hwLpXkIxYwPlK71WWg9bMa1ztw/fr0nhQm4MHhabkNo1e2ELQ1GZLtQ5g48se+BZ8uhC49+JL2al1O/Xu/YphXeEf8g97
    I8VzrTDPP69qtDrVIHmCIm6aR+rGozO3x3n/S/y9k4fDJllzn7vDDUzHB+A/F7cwuMlMRVR8YNOZyDAlzdiz91P6Y2swSvhD6JuQ36mmgOVJiT93JSYZN0wh
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=REXF9Z7TwrSuUXGxeXcA:9 a=GjyNhGUp6eUF2itY:21
    a=NSVpAJkfRq20TsRh:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeEVQGj (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 12:06:39 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:36161 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751257AbeEVQGi (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 22 May 2018 12:06:38 -0400
Subject: Re: [PATCH] usbip: dynamically allocate idev by nports found in sysfs
To: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        Shuah Khan <shuah@kernel.org>
References: <20180518143947.27963-1-m.grzeschik@pengutronix.de>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <05a0fd16-cd54-1bb8-7566-0d88e1bd73cf@kernel.org>
Date: Tue, 22 May 2018 10:06:27 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518143947.27963-1-m.grzeschik@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Michael,

Thanks for the patch. Couple of comments below:

On 05/18/2018 08:39 AM, Michael Grzeschik wrote:
> As the amount of available ports varies by the kernels build
> configuration. To remove the limitation of the fixed 128 ports
> we allocate the amount of idevs by using the number we get
> from the kernel.
> 
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  tools/usb/usbip/libsrc/vhci_driver.c | 11 ++++++++---
>  tools/usb/usbip/libsrc/vhci_driver.h |  3 +--
>  2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/usb/usbip/libsrc/vhci_driver.c b/tools/usb/usbip/libsrc/vhci_driver.c
> index c9c81614a66ad..9a8acfc7697fa 100644
> --- a/tools/usb/usbip/libsrc/vhci_driver.c
> +++ b/tools/usb/usbip/libsrc/vhci_driver.c
> @@ -266,11 +266,11 @@ int usbip_vhci_driver_open(void)
>  	if (vhci_driver->nports <= 0) {
>  		err("no available ports");
>  		goto err;
> -	} else if (vhci_driver->nports > MAXNPORT) {
> -		err("port number exceeds %d", MAXNPORT);
> -		goto err;
>  	}
>  
> +	vhci_driver->idev = calloc(vhci_driver->nports,
> +			sizeof(struct usbip_imported_device));
> +

Missing check for memory allocation failure. Please add it.

>  	vhci_driver->ncontrollers = get_ncontrollers();
>  	dbg("available controllers: %d", vhci_driver->ncontrollers);
>  
> @@ -287,6 +287,9 @@ int usbip_vhci_driver_open(void)
>  err:
>  	udev_device_unref(vhci_driver->hc_device);
>  
> +	if (vhci_driver->idev)
> +		free(vhci_driver->idev);
> +
>  	if (vhci_driver)
>  		free(vhci_driver);
>  
> @@ -305,6 +308,8 @@ void usbip_vhci_driver_close(void)
>  
>  	udev_device_unref(vhci_driver->hc_device);
>  
> +	free(vhci_driver->idev);
> +
>  	free(vhci_driver);
>  
>  	vhci_driver = NULL;
> diff --git a/tools/usb/usbip/libsrc/vhci_driver.h b/tools/usb/usbip/libsrc/vhci_driver.h
> index 418b404d51210..67dbd1551e159 100644
> --- a/tools/usb/usbip/libsrc/vhci_driver.h
> +++ b/tools/usb/usbip/libsrc/vhci_driver.h
> @@ -13,7 +13,6 @@
>  
>  #define USBIP_VHCI_BUS_TYPE "platform"
>  #define USBIP_VHCI_DEVICE_NAME "vhci_hcd.0"
> -#define MAXNPORT 128
>  
>  enum hub_speed {
>  	HUB_SPEED_HIGH = 0,
> @@ -41,7 +40,7 @@ struct usbip_vhci_driver {
>  
>  	int ncontrollers;
>  	int nports;
> -	struct usbip_imported_device idev[MAXNPORT];
> +	struct usbip_imported_device *idev;
>  };
>  
>  
> 

Rest looks good.

thanks,
-- Shuah
