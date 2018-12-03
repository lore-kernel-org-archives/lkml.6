Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F2DC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECAC12081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:36:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECAC12081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbeLCIgW convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:36:22 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34433 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeLCIgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:36:21 -0500
Received: from mail-pf1-f199.google.com ([209.85.210.199])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gTjiE-0007qd-5T
        for linux-kernel@vger.kernel.org; Mon, 03 Dec 2018 08:36:18 +0000
Received: by mail-pf1-f199.google.com with SMTP id t2so10759594pfj.15
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 00:36:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=3hjeYE9LP0BekV2+NtYC8HRmRpvr0HUzYJnhuAL6kGU=;
        b=J6ROYeYnHmwvNgwxw5G2NM/5Xrs3jsJYR8kzmkWf6F4UBlKHbprvZOwExiGFjc9gih
         ihJFpNjFxzHQPQ8VY18wJpAO+iEWZeRl8Z2ULCe62lSWvn47luly5M3Hej0Nzbh88R+K
         ua/gGArdoyKhb7uGMtPDaBlqOkjVuxhnM2S7vMt1fvRUGgUiSBovzWilwKKGj/txsFlP
         Vc7iZnTtrUon/HyetdaIyALS8u7qy6qFdQuziAV/EXUXZn7EhHNqpcwbS0c7KRyVZAO0
         6pPSHavFmn0P1VwMz+QH9N3bu5OydUvdrvv0kJ3XZE0sDrR6E3+SuOurVg4ce2gyC8pw
         m9+w==
X-Gm-Message-State: AA+aEWbvzUMBlPc1gTAVtUSJGzz9qlXYWE54cpamC1wdLbXnT/7rK5+q
        pOprM20A+OaAj28C7bQznRVE7ebM5gm978cW8KScYNCMm19/seDtVdZ/DieH4ztfTr0OytT2jzo
        GwO7hnhtdjnOblXttvotpsZkP2xH/ITLY3QBGQUYxRw==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr15458708pld.337.1543826176583;
        Mon, 03 Dec 2018 00:36:16 -0800 (PST)
X-Google-Smtp-Source: AFSGD/WfjM6yv62Yc9PMIKHFE2aY/Bmt40sb90Y9MRqyK3ojMCCXR3jncWMaj/MEmXm7EjH/KW7idA==
X-Received: by 2002:a17:902:346:: with SMTP id 64mr15458691pld.337.1543826176250;
        Mon, 03 Dec 2018 00:36:16 -0800 (PST)
Received: from [10.101.46.245] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id t90sm26393605pfj.23.2018.12.03.00.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 00:36:15 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Subject: Re: [PATCH v3] USB: Don't enable LPM if it's already enabled
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181203083208.14420-1-kai.heng.feng@canonical.com>
Date:   Mon, 3 Dec 2018 16:36:13 +0800
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <30EED701-930E-4E0E-ADC1-BF8003E7836D@canonical.com>
References: <20181203083208.14420-1-kai.heng.feng@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.101.1)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 3, 2018, at 4:32 PM, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
> after S3:
> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
> 
> After some experiments, I found that disabling LPM can workaround the
> issue.
> 
> On some platforms, the USB power is cut during S3, so the driver uses
> reset-resume to resume the device. During port resume, LPM gets enabled
> twice, by usb_reset_and_verify_device() and usb_port_resume().
> 
> So let's enable LPM for just once, as this solves the issue for the
> device in question.

Please ignore this patch, I missed Greg’s suggestion to use _enable() and _disable() naming.

Will send a v4.

Kai-Heng

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3:
> - Consolidate udev->usb2_hw_lpm_capable and udev->usb2_hw_lpm_enabled
>   check to usb_set_usb2_hardware_lpm().
> v2:
> - Check udev->usb2_hw_lpm_enabled before calling usb_port_resume().
> 
> drivers/usb/core/driver.c  |  4 +++-
> drivers/usb/core/hub.c     | 13 ++++---------
> drivers/usb/core/message.c |  3 +--
> 3 files changed, 8 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 53564386ed57..f277a8de7498 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1901,7 +1901,9 @@ int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
> 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> 	int ret = -EPERM;
> 
> -	if (enable && !udev->usb2_hw_lpm_allowed)
> +	if (!udev->usb2_hw_lpm_capable ||
> +	    (enable && !udev->usb2_hw_lpm_allowed) ||
> +	    (enable && udev->usb2_hw_lpm_enabled))
> 		return 0;
> 
> 	if (hcd->driver->set_usb2_hw_lpm) {
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index e482e5f103d9..907793d38a82 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3210,8 +3210,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> 	}
> 
> 	/* disable USB2 hardware LPM */
> -	if (udev->usb2_hw_lpm_enabled == 1)
> -		usb_set_usb2_hardware_lpm(udev, 0);
> +	usb_set_usb2_hardware_lpm(udev, 0);
> 
> 	if (usb_disable_ltm(udev)) {
> 		dev_err(&udev->dev, "Failed to disable LTM before suspend\n");
> @@ -3249,8 +3248,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> 		usb_enable_ltm(udev);
>  err_ltm:
> 		/* Try to enable USB2 hardware LPM again */
> -		if (udev->usb2_hw_lpm_capable == 1)
> -			usb_set_usb2_hardware_lpm(udev, 1);
> +		usb_set_usb2_hardware_lpm(udev, 1);
> 
> 		if (udev->do_remote_wakeup)
> 			(void) usb_disable_remote_wakeup(udev);
> @@ -3533,9 +3531,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> 		hub_port_logical_disconnect(hub, port1);
> 	} else  {
> 		/* Try to enable USB2 hardware LPM */
> -		if (udev->usb2_hw_lpm_capable == 1 &&
> -		    !udev->usb2_hw_lpm_enabled)
> -			usb_set_usb2_hardware_lpm(udev, 1);
> +		usb_set_usb2_hardware_lpm(udev, 1);
> 
> 		/* Try to enable USB3 LTM */
> 		usb_enable_ltm(udev);
> @@ -5639,8 +5635,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> 	/* Disable USB2 hardware LPM.
> 	 * It will be re-enabled by the enumeration process.
> 	 */
> -	if (udev->usb2_hw_lpm_enabled == 1)
> -		usb_set_usb2_hardware_lpm(udev, 0);
> +	usb_set_usb2_hardware_lpm(udev, 0);
> 
> 	/* Disable LPM while we reset the device and reinstall the alt settings.
> 	 * Device-initiated LPM, and system exit latency settings are cleared
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index bfa5eda0cc26..a00952bdf645 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1243,8 +1243,7 @@ void usb_disable_device(struct usb_device *dev, int skip_ep0)
> 			dev->actconfig->interface[i] = NULL;
> 		}
> 
> -		if (dev->usb2_hw_lpm_enabled == 1)
> -			usb_set_usb2_hardware_lpm(dev, 0);
> +		usb_set_usb2_hardware_lpm(dev, 0);
> 		usb_unlocked_disable_lpm(dev);
> 		usb_disable_ltm(dev);
> 
> -- 
> 2.17.1
> 

