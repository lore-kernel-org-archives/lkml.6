Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD09C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF0E20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 06:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfAGGk1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 01:40:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfAGGk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 01:40:27 -0500
Received: from mail-pf1-f197.google.com ([209.85.210.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ggOaF-0000QU-PG
        for linux-kernel@vger.kernel.org; Mon, 07 Jan 2019 06:40:23 +0000
Received: by mail-pf1-f197.google.com with SMTP id i3so42632682pfj.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jan 2019 22:40:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=A8LMqy1Ds4TqOSFdYSQa8lZXQL01qjKmESvfgDI6HZs=;
        b=R3Cd0ANZp6Wd7LrtvDrdjnE3FyGjtDe3b0N+n6f1p3+9O2if+/DJaSqVntHpkI8huU
         6/tatbSUmwwxO/QkaEdFpHZTH+x54RJ8fLih+fi7rzQFZ8VtF0+GSGvtzQoN6ENIe+Ot
         09su0xJCNLcSIEb9dlosYm60BicW1a8pAnuiamVuzMXEkzlQvWE1nZuJ+91qXeIfknZs
         CeVv93mfSUTeiF5fccLITyLUO3yAqBlk6qedsW6x3tOgoXL2xvN5IIrZ0Qdj1Ys0bWfx
         clc33FYmhvFGyv8VHPYq66YcsPJ+IlNCsvc6QbxeQ4ueJauaEzF3Ju8W+HO7fVjdKpXx
         C28A==
X-Gm-Message-State: AJcUukc/2v/UjIYLcRfa/+6jEvLMDcRhTm5g4Me1PCD67Jo79c9om7rY
        J4hacfcT26VaOsdkOt87GnPUCOFp0a2CqmzGYA/pNX8xbGcflkRQs4oULPy/SUymo8vPdPDmoCW
        y5YRh4CGNm0nykYm3Dk92an4Zn8fMDSQIawI5QSDG2g==
X-Received: by 2002:a65:448a:: with SMTP id l10mr9969413pgq.387.1546843222352;
        Sun, 06 Jan 2019 22:40:22 -0800 (PST)
X-Google-Smtp-Source: ALg8bN7gP3QDUyAx9xyA6vsWLE8ZkY+RXpXVXI9afFEbywFpfOtiuN5y65a2tpsAPK+Lh7doGh2ODQ==
X-Received: by 2002:a65:448a:: with SMTP id l10mr9969397pgq.387.1546843221964;
        Sun, 06 Jan 2019 22:40:21 -0800 (PST)
Received: from 2001-b011-380f-3f3d-8c0d-0ee6-8d41-4b74.dynamic-ip6.hinet.net (2001-b011-380f-3f3d-8c0d-0ee6-8d41-4b74.dynamic-ip6.hinet.net. [2001:b011:380f:3f3d:8c0d:ee6:8d41:4b74])
        by smtp.gmail.com with ESMTPSA id t3sm76652949pgv.31.2019.01.06.22.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 06 Jan 2019 22:40:21 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20181203102643.22690-1-kai.heng.feng@canonical.com>
Date:   Mon, 7 Jan 2019 14:40:19 +0800
Cc:     Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <F24F822F-E721-47DC-9860-A2D0847C09DB@canonical.com>
References: <20181203102643.22690-1-kai.heng.feng@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Dec 3, 2018, at 18:26, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
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
> 
> Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
> and usb_disable_usb2_hardware_lpm().

Please review my new approach, hopefully this can be included in Linux v5.0. 

> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v4:
> - Use usb_enable_usb2_hardware_lpm() and
>   usb_disable_usb2_hardware_lpm() to control USB2 LPM.
> v3:
> - Consolidate udev->usb2_hw_lpm_capable and udev->usb2_hw_lpm_enabled
>  check to usb_set_usb2_hardware_lpm().
> v2:
>  - Check udev->usb2_hw_lpm_enabled before calling usb_port_resume().
> 
> drivers/usb/core/driver.c  | 23 +++++++++++++++++++----
> drivers/usb/core/hub.c     | 16 ++++++----------
> drivers/usb/core/message.c |  3 +--
> drivers/usb/core/sysfs.c   |  5 ++++-
> drivers/usb/core/usb.h     | 10 ++++++++--
> 5 files changed, 38 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index 53564386ed57..8987cec9549d 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1896,14 +1896,11 @@ int usb_runtime_idle(struct device *dev)
> 	return -EBUSY;
> }
> 
> -int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
> +static int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
> {
> 	struct usb_hcd *hcd = bus_to_hcd(udev->bus);
> 	int ret = -EPERM;
> 
> -	if (enable && !udev->usb2_hw_lpm_allowed)
> -		return 0;
> -
> 	if (hcd->driver->set_usb2_hw_lpm) {
> 		ret = hcd->driver->set_usb2_hw_lpm(hcd, udev, enable);
> 		if (!ret)
> @@ -1913,6 +1910,24 @@ int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
> 	return ret;
> }
> 
> +int usb_enable_usb2_hardware_lpm(struct usb_device *udev)
> +{
> +	if (!udev->usb2_hw_lpm_capable ||
> +	    !udev->usb2_hw_lpm_allowed ||
> +	    udev->usb2_hw_lpm_enabled)
> +		return 0;
> +
> +	return usb_set_usb2_hardware_lpm(udev, 1);
> +}
> +
> +int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
> +{
> +	if (!udev->usb2_hw_lpm_enabled)
> +		return 0;
> +
> +	return usb_set_usb2_hardware_lpm(udev, 0);
> +}
> +
> #endif /* CONFIG_PM */
> 
> struct bus_type usb_bus_type = {
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 0f9381b69a3b..b4439ee2d144 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -3210,8 +3210,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> 	}
> 
> 	/* disable USB2 hardware LPM */
> -	if (udev->usb2_hw_lpm_enabled == 1)
> -		usb_set_usb2_hardware_lpm(udev, 0);
> +	usb_disable_usb2_hardware_lpm(udev);
> 
> 	if (usb_disable_ltm(udev)) {
> 		dev_err(&udev->dev, "Failed to disable LTM before suspend\n");
> @@ -3249,8 +3248,7 @@ int usb_port_suspend(struct usb_device *udev, pm_message_t msg)
> 		usb_enable_ltm(udev);
>  err_ltm:
> 		/* Try to enable USB2 hardware LPM again */
> -		if (udev->usb2_hw_lpm_capable == 1)
> -			usb_set_usb2_hardware_lpm(udev, 1);
> +		usb_enable_usb2_hardware_lpm(udev);
> 
> 		if (udev->do_remote_wakeup)
> 			(void) usb_disable_remote_wakeup(udev);
> @@ -3533,8 +3531,7 @@ int usb_port_resume(struct usb_device *udev, pm_message_t msg)
> 		hub_port_logical_disconnect(hub, port1);
> 	} else  {
> 		/* Try to enable USB2 hardware LPM */
> -		if (udev->usb2_hw_lpm_capable == 1)
> -			usb_set_usb2_hardware_lpm(udev, 1);
> +		usb_enable_usb2_hardware_lpm(udev);
> 
> 		/* Try to enable USB3 LTM */
> 		usb_enable_ltm(udev);
> @@ -4425,7 +4422,7 @@ static void hub_set_initial_usb2_lpm_policy(struct usb_device *udev)
> 	if ((udev->bos->ext_cap->bmAttributes & cpu_to_le32(USB_BESL_SUPPORT)) ||
> 			connect_type == USB_PORT_CONNECT_TYPE_HARD_WIRED) {
> 		udev->usb2_hw_lpm_allowed = 1;
> -		usb_set_usb2_hardware_lpm(udev, 1);
> +		usb_enable_usb2_hardware_lpm(udev);
> 	}
> }
> 
> @@ -5638,8 +5635,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> 	/* Disable USB2 hardware LPM.
> 	 * It will be re-enabled by the enumeration process.
> 	 */
> -	if (udev->usb2_hw_lpm_enabled == 1)
> -		usb_set_usb2_hardware_lpm(udev, 0);
> +	usb_disable_usb2_hardware_lpm(udev);
> 
> 	/* Disable LPM while we reset the device and reinstall the alt settings.
> 	 * Device-initiated LPM, and system exit latency settings are cleared
> @@ -5742,7 +5738,7 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
> 
> done:
> 	/* Now that the alt settings are re-installed, enable LTM and LPM. */
> -	usb_set_usb2_hardware_lpm(udev, 1);
> +	usb_enable_usb2_hardware_lpm(udev);
> 	usb_unlocked_enable_lpm(udev);
> 	usb_enable_ltm(udev);
> 	usb_release_bos_descriptor(udev);
> diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
> index bfa5eda0cc26..4f33eb632a88 100644
> --- a/drivers/usb/core/message.c
> +++ b/drivers/usb/core/message.c
> @@ -1243,8 +1243,7 @@ void usb_disable_device(struct usb_device *dev, int skip_ep0)
> 			dev->actconfig->interface[i] = NULL;
> 		}
> 
> -		if (dev->usb2_hw_lpm_enabled == 1)
> -			usb_set_usb2_hardware_lpm(dev, 0);
> +		usb_disable_usb2_hardware_lpm(dev);
> 		usb_unlocked_disable_lpm(dev);
> 		usb_disable_ltm(dev);
> 
> diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
> index ea18284dfa9a..7e88fdfe3cf5 100644
> --- a/drivers/usb/core/sysfs.c
> +++ b/drivers/usb/core/sysfs.c
> @@ -528,7 +528,10 @@ static ssize_t usb2_hardware_lpm_store(struct device *dev,
> 
> 	if (!ret) {
> 		udev->usb2_hw_lpm_allowed = value;
> -		ret = usb_set_usb2_hardware_lpm(udev, value);
> +		if (value)
> +			ret = usb_enable_usb2_hardware_lpm(udev);
> +		else
> +			ret = usb_disable_usb2_hardware_lpm(udev);
> 	}
> 
> 	usb_unlock_device(udev);
> diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
> index 546a2219454b..d95a5358f73d 100644
> --- a/drivers/usb/core/usb.h
> +++ b/drivers/usb/core/usb.h
> @@ -92,7 +92,8 @@ extern int usb_remote_wakeup(struct usb_device *dev);
> extern int usb_runtime_suspend(struct device *dev);
> extern int usb_runtime_resume(struct device *dev);
> extern int usb_runtime_idle(struct device *dev);
> -extern int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable);
> +extern int usb_enable_usb2_hardware_lpm(struct usb_device *udev);
> +extern int usb_disable_usb2_hardware_lpm(struct usb_device *udev);
> 
> #else
> 
> @@ -112,7 +113,12 @@ static inline int usb_autoresume_device(struct usb_device *udev)
> 	return 0;
> }
> 
> -static inline int usb_set_usb2_hardware_lpm(struct usb_device *udev, int enable)
> +static inline int usb_enable_usb2_hardware_lpm(struct usb_device *udev)
> +{
> +	return 0;
> +}
> +
> +static inline int usb_disable_usb2_hardware_lpm(struct usb_device *udev)
> {
> 	return 0;
> }
> -- 
> 2.17.1
> 

