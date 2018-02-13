Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2933101-1518488705-2-18028893076260001578
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518488703; b=SMCFGYCl2dP1QykHtR7uVBc2M3IaeoFn5FAHOHwtm2Z5cyC
    T1DAMfVTn89s5ndHukKsqqOUCXn7kzSunoKOXtdtgFlbtPSp+Y4DyTHsjnf4+ztG
    5eUv0aMQVL0nBuG4hJf+SC+rwYEOqPbIikiikA0QKMaT5meNSVXkjfUIi1zPYlE8
    5UeyoiX/5HIUvKD6fS1LwgA3uzIm5k41lIzTqyvwaXTIVyEExONcaLnQmXRvGkjo
    GynC+zGIOtkniPB6NA7p12UXS6s01XLCTi1LErLo3JeSxItxbSaV0VLPoy685obd
    4eB3HLo1fwSebHHSwUhQ2Qo+72eC7SmIg2J5+iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518488703; bh=hw0hx3zLk8BNALQkg2zIjzKV3f
    yPBE6gzMkjjoszN2M=; b=ZacpdPFHL8PtqpFzQkHPunuyBDZJgGP0N+AdF+w6Os
    ZsECS9H3iiKSCes+Pv4cjCUAFQhlTi01vTGjqMwqOExsl5pLCytR5aNe1xZpkBoY
    UF2xw3D+ItctZGMg/WgfVAMFxg7rR5CUwzYmS4kMci4u/3fb+C3MpjW+CDbZEPLs
    UG6mcp8XQ/l1TCwl0naH22e0YHISQyPzufW3Tuj4C+d3QddnmEgqi/547qA1OsEb
    zuc+iSb+1++MowegOfcLOuAXP9ZH7h47bAaNeyIcuSkgaWTjdZbPto2fzxh1sTLv
    kCpa++/3UPBNKQeTpohzoFKWmQCoLgH4vn9pUl9JfoSg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=AgLEYwgA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=luMzMqVS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=AgLEYwgA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=luMzMqVS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933132AbeBMCZC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 21:25:02 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45624 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933312AbeBMCZA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 12 Feb 2018 21:25:00 -0500
X-Google-Smtp-Source: AH8x226E24mLyLbH6xktgLC37qeCSs6cBF2yzCReZWpCaYCJqTkYdvBN4FVwP2f8DAlJhDbSjRcTgQ==
Date: Mon, 12 Feb 2018 18:24:56 -0800
From: Brian Norris <briannorris@chromium.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Message-ID: <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180108094416.4789-1-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
> 
> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
> has several issues (see the original commit message). An added advantage
> of moving over to the USB-core reset-resume handling is that it also
> disables autosuspend for these devices, which is similarly broken on these.

Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
think so -- I'm using one now. Thus, this is a poor solution, which
negatively affects my systems. However, I see that this patch was
applied regardless...

What justifications was found for this anyway? AIUI, this is a platform
bug, and not entirely a chipset bug. Why should all users of this
chipset be penalized?

Brian

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
> Cc: stable@vger.kernel.org
> Cc: Leif Liddy <leif.linux@gmail.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note:
> 1) Once this has been merged, the 2 commits adding QCA device entries to
> drivers/usb/core/quirks.c should be reverted or dropped from bluetooth-next.
> 2) I don't have any of the affected devices, please test
> ---
>  drivers/bluetooth/btusb.c | 22 ++++++++++------------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4764100a5888..c4689f03220f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -23,6 +23,7 @@
>  
>  #include <linux/module.h>
>  #include <linux/usb.h>
> +#include <linux/usb/quirks.h>
>  #include <linux/firmware.h>
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
> @@ -388,9 +389,8 @@ static const struct usb_device_id blacklist_table[] = {
>  #define BTUSB_FIRMWARE_LOADED	7
>  #define BTUSB_FIRMWARE_FAILED	8
>  #define BTUSB_BOOTING		9
> -#define BTUSB_RESET_RESUME	10
> -#define BTUSB_DIAG_RUNNING	11
> -#define BTUSB_OOB_WAKE_ENABLED	12
> +#define BTUSB_DIAG_RUNNING	10
> +#define BTUSB_OOB_WAKE_ENABLED	11
>  
>  struct btusb_data {
>  	struct hci_dev       *hdev;
> @@ -3118,6 +3118,12 @@ static int btusb_probe(struct usb_interface *intf,
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
> @@ -3128,7 +3134,7 @@ static int btusb_probe(struct usb_interface *intf,
>  		 * but the USB hub doesn't notice any status change.
>  		 * Explicitly request a device reset on resume.
>  		 */
> -		set_bit(BTUSB_RESET_RESUME, &data->flags);
> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>  	}
>  #endif
>  
> @@ -3297,14 +3303,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>  		enable_irq(data->oob_wake_irq);
>  	}
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
> -- 
> 2.14.3
> 
