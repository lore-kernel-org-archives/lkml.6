Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2984537-1518748315-2-5896187946500322780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518748315; b=Ii78/J9GYtZl7GMCOd1wNNtMw4+thRO3hb7OBt3HWh76OQI
    /q0W/1rxhBBFiap1wjoY4v1N4UzZlM6sa+2KqjW+uZEv739Y376QhQ8OEvlob6C+
    h7sKKrrUN/Yo3rMG/WsFDTnhmUNXfksxaEC3A7yx4LmYkMt1fMtvZPj02sQqeMbp
    80RWTOOFUq9Cc8lvmpKpaR6VWLWlz49c76LpVUi4whSj0gF5wWF8lszKhUqO/mcj
    QlArrAhNCUh3BKCYydfe1F4GrPLhoJJ4ygFVdqOnkkrAaLrz/PfKuYzRFSE/sZOS
    dnLPlGoXSfZ17P4r4IywTy6uFhXPBqVVL2gL0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518748315; bh=YQ3Fy/CtpGbq+6Kqge6cFJMlDY
    51DjfsmbWZWPDBP4c=; b=nj1oTdwItgmjAc/g747DqUIbPC0iPFFBq1K8/YPQZa
    xRhFEeQCTx2dwT5LufFiCHLrmfWD2ALA7OfPifcnVMUBTdTzGjMwrW/Xw+1Hux9n
    7vsRPLZlmUJZxgBu0WgR3BGtBY4m0nyk1QU3RAgomy42J3peLQNAq4Vd+nJoIETl
    tEybvN2ayu4ml78RkdDaWIIkpwbAb4ipxklgCJCiC4XDbhQfZA2MKB24KP26TrZ6
    WWCFQjAvCKqWZsNzkcMSSo8lZhEGLaB3OA2X0U2auI3UdcFHGexWpR2iAW9N7JFE
    xVzuaBwultSrGj9Cs4BpTOgOSM4t6aHojDHSx9e+CuYQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=VfC+b91Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rU1ePa23;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=VfC+b91Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rU1ePa23;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757251AbeBPCbx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 21:31:53 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36722 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757233AbeBPCbv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 21:31:51 -0500
X-Google-Smtp-Source: AH8x225j+qvr9FxrrMzkeALIMIcoTltRNEH/pWGaz23I82J7MI8BBebPAKZw6UXoyCNwdC8dNbIAsA==
Date: Thu, 15 Feb 2018 18:31:48 -0800
From: Brian Norris <briannorris@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.4 095/108] Bluetooth: btusb: Restore QCA Rome
 suspend/resume fix with a "rewritten" version
Message-ID: <20180216023147.GB69988@rodete-desktop-imager.corp.google.com>
References: <20180215151222.267507937@linuxfoundation.org>
 <20180215151235.620152736@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215151235.620152736@linuxfoundation.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 04:17:32PM +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.

Consider this an objection:

I'm currently arguing that this is unnecessarily regressing power
consumption here:

https://patchwork.kernel.org/patch/10149195/

I'll leave it up to you what to do with this, but if this ends up in
Chromium OS kernels, I'm likely to revert it there...

Brian

> ------------------
> 
> From: Hans de Goede <hdegoede@redhat.com>
> 
> commit 61f5acea8737d9b717fcc22bb6679924f3c82b98 upstream.
> 
> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
> 
> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
> has several issues (see the original commit message). An added advantage
> of moving over to the USB-core reset-resume handling is that it also
> disables autosuspend for these devices, which is similarly broken on these.
> 
> But there are 2 issues with this approach:
> 1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
>    devices.
> 2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
>    added to usb/core/quirks.c and if we fix the Realtek case the same way
>    we need to add an additional 14 entries. So in essence we need to
>    duplicate a large part of the usb_device_id table in btusb.c in
>    usb/core/quirks.c and manually keep them in sync.
> 
> This commit instead restores setting a reset-resume quirk for QCA devices
> in the btusb.c code, avoiding the duplicate usb_device_id table problem.
> 
> This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
> code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
> usb_device.
> 
> This commit also moves the BTUSB_REALTEK case over to directly setting the
> USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
> BTUSB_RESET_RESUME code.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> Cc: Leif Liddy <leif.linux@gmail.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/bluetooth/btusb.c |   21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/usb.h>
> +#include <linux/usb/quirks.h>
>  #include <linux/firmware.h>
>  #include <asm/unaligned.h>
>  
> @@ -360,8 +361,8 @@ static const struct usb_device_id blackl
>  #define BTUSB_FIRMWARE_LOADED	7
>  #define BTUSB_FIRMWARE_FAILED	8
>  #define BTUSB_BOOTING		9
> -#define BTUSB_RESET_RESUME	10
> -#define BTUSB_DIAG_RUNNING	11
> +#define BTUSB_DIAG_RUNNING	10
> +#define BTUSB_OOB_WAKE_ENABLED	11
>  
>  struct btusb_data {
>  	struct hci_dev       *hdev;
> @@ -2969,6 +2970,12 @@ static int btusb_probe(struct usb_interf
>  	if (id->driver_info & BTUSB_QCA_ROME) {
>  		data->setup_on_usb = btusb_setup_qca;
>  		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> +
> +		/* QCA Rome devices lose their updated firmware over suspend,
> +		 * but the USB hub doesn't notice any status change.
> +		 * explicitly request a device reset on resume.
> +		 */
> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>  	}
>  
>  #ifdef CONFIG_BT_HCIBTUSB_RTL
> @@ -2979,7 +2986,7 @@ static int btusb_probe(struct usb_interf
>  		 * but the USB hub doesn't notice any status change.
>  		 * Explicitly request a device reset on resume.
>  		 */
> -		set_bit(BTUSB_RESET_RESUME, &data->flags);
> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>  	}
>  #endif
>  
> @@ -3136,14 +3143,6 @@ static int btusb_suspend(struct usb_inte
>  	btusb_stop_traffic(data);
>  	usb_kill_anchored_urbs(&data->tx_anchor);
>  
> -	/* Optionally request a device reset on resume, but only when
> -	 * wakeups are disabled. If wakeups are enabled we assume the
> -	 * device will stay powered up throughout suspend.
> -	 */
> -	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
> -	    !device_may_wakeup(&data->udev->dev))
> -		data->udev->reset_resume = 1;
> -
>  	return 0;
>  }
>  
> 
> 
