Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4015520-1518521165-2-16798392638466594925
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518521164; b=mZYENqG1x/5kewXPmPclNoyMEX4oucBx0pEurKDHiQQrOEO
    AYuDJC8sFMxuWKdWlrhH2Uh53LmQvu8loiJUSGk2INyo3+/Dbf+m1Kk0nhumcDjV
    3szeAqkfGE2crq2bIkiAyUqyccxNjLAMVqBHYWkzWcRMHHUrl/Plvux6Gew9iYNo
    2Rwo46Q5JV9mcck5TIJo3CjpMRYMoBieLV16xkesTzwnJI67jVqCaL5wmsedakZh
    j7EXl0LfWTUePoYpF7lTPsFELrTGWeLlTU2590MKQr7Rv3glw413Lxvk5ygrPauo
    k8g5U9q/upJn+ydC089JJzZbgSlabYcg86Qckjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518521164; bh=UKDYPTkykX0WEHoH36om5CS8rdNBRQuOWe9NG0m3rFA=; b=X
    Lzm4IbzRP7fXyJPpOR/cXXFy+Dzp22LJjEECCuYk6Uu7E/r7PSOlE/r789+i1/CO
    dcnJ5qMc3RjIVn4yxOzhP6qokOMDuy6R26+YoNKgEch59uQ+lBBZMdAw/G7UQkOy
    4RNYh5tkqmj2SJQ57Dvetx8l4IdLMx4Ndc3ZrF2rEy/D4mRpjODDyaGxaUXgn76w
    yik+mWWqfUr3+S8IU1ED6e3mJmxfam97RbyGuSFQEoom2SszoP9Pbq87jlE/o193
    S+hdcc+vrBLKwYCuCRBzE2HrTsgTJpYflBPhDLW8Hcli0ZklfMozSsKVJt67TCfe
    lDI9bTcb5ySolk1RJQLSw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IEQSzjHF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IEQSzjHF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934563AbeBML0B (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 06:26:01 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53428 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeBMLZ7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 13 Feb 2018 06:25:59 -0500
X-Google-Smtp-Source: AH8x226eBFqHJ9tNiIuyZQTljMIgB73jr6XbEh/fmuIF8PysgZAgH0VJsyBLdNCNiI03/hCsZasKow==
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Brian Norris <briannorris@chromium.org>
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
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
Date: Tue, 13 Feb 2018 12:25:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 13-02-18 03:24, Brian Norris wrote:
> Hi,
> 
> On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>
>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>> has several issues (see the original commit message). An added advantage
>> of moving over to the USB-core reset-resume handling is that it also
>> disables autosuspend for these devices, which is similarly broken on these.
> 
> Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
> think so -- I'm using one now.

And have you manually enabled USB autosuspend for it, or are you
running something which might have done so, e.g. powertop --auto-tune ?

Because if you did not do that then you're already not using autosuspend
for your QCA devices and this patch will change nothing.

> Thus, this is a poor solution, which
> negatively affects my systems. However, I see that this patch was
> applied regardless...

Note that there already is a quirk to handle broken suspend/resume
behavior on ALL QCA devices in older kernels. Also note that the
patches series which this commit builds on top of was already
setting USB_QUIRK_RESET_RESUME for some devices in
usb/core/quirks.c.

All my commit does is instead of duplicating all the QCA USB-ids in
usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
to btusb.c so that we don't need to duplicate the USB-id tables.

The result of the combination of these patches is that the custom
DIY reset on resume handling btusb.c was doing is now replaced
by setting the standard USB-core USB_QUIRK_RESET_RESUME quirk.

As a (desirable) side effect this also disables USB autosuspend
for QCA devices since the USB-core does not allow USB autosuspend
on devices with the USB_QUIRK_RESET_RESUME quirk. Testing has shown
this to be necessary on at least some QCA devices and given that
these devices tend to loose there firmware on a suspend, it seems
sensible to not allow autosuspend on them.

 > What justifications was found for this anyway? AIUI, this is a platform
 > bug, and not entirely a chipset bug.

No this is believed to be a chipset issue, hence also the quirk in
older kernels to always reset these devices after a normal suspend/resume.

Regards,

Hans




> 
> Brian
> 
>> But there are 2 issues with this approach:
>> 1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
>>     devices.
>> 2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
>>     added to usb/core/quirks.c and if we fix the Realtek case the same way
>>     we need to add an additional 14 entries. So in essence we need to
>>     duplicate a large part of the usb_device_id table in btusb.c in
>>     usb/core/quirks.c and manually keep them in sync.
>>
>> This commit instead restores setting a reset-resume quirk for QCA devices
>> in the btusb.c code, avoiding the duplicate usb_device_id table problem.
>>
>> This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
>> code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
>> usb_device.
>>
>> This commit also moves the BTUSB_REALTEK case over to directly setting the
>> USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
>> BTUSB_RESET_RESUME code.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>> Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> Cc: stable@vger.kernel.org
>> Cc: Leif Liddy <leif.linux@gmail.com>
>> Cc: Matthias Kaehlcke <mka@chromium.org>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Daniel Drake <drake@endlessm.com>
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note:
>> 1) Once this has been merged, the 2 commits adding QCA device entries to
>> drivers/usb/core/quirks.c should be reverted or dropped from bluetooth-next.
>> 2) I don't have any of the affected devices, please test
>> ---
>>   drivers/bluetooth/btusb.c | 22 ++++++++++------------
>>   1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 4764100a5888..c4689f03220f 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -23,6 +23,7 @@
>>   
>>   #include <linux/module.h>
>>   #include <linux/usb.h>
>> +#include <linux/usb/quirks.h>
>>   #include <linux/firmware.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_irq.h>
>> @@ -388,9 +389,8 @@ static const struct usb_device_id blacklist_table[] = {
>>   #define BTUSB_FIRMWARE_LOADED	7
>>   #define BTUSB_FIRMWARE_FAILED	8
>>   #define BTUSB_BOOTING		9
>> -#define BTUSB_RESET_RESUME	10
>> -#define BTUSB_DIAG_RUNNING	11
>> -#define BTUSB_OOB_WAKE_ENABLED	12
>> +#define BTUSB_DIAG_RUNNING	10
>> +#define BTUSB_OOB_WAKE_ENABLED	11
>>   
>>   struct btusb_data {
>>   	struct hci_dev       *hdev;
>> @@ -3118,6 +3118,12 @@ static int btusb_probe(struct usb_interface *intf,
>>   	if (id->driver_info & BTUSB_QCA_ROME) {
>>   		data->setup_on_usb = btusb_setup_qca;
>>   		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
>> +
>> +		/* QCA Rome devices lose their updated firmware over suspend,
>> +		 * but the USB hub doesn't notice any status change.
>> +		 * explicitly request a device reset on resume.
>> +		 */
>> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>>   	}
>>   
>>   #ifdef CONFIG_BT_HCIBTUSB_RTL
>> @@ -3128,7 +3134,7 @@ static int btusb_probe(struct usb_interface *intf,
>>   		 * but the USB hub doesn't notice any status change.
>>   		 * Explicitly request a device reset on resume.
>>   		 */
>> -		set_bit(BTUSB_RESET_RESUME, &data->flags);
>> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>>   	}
>>   #endif
>>   
>> @@ -3297,14 +3303,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>   		enable_irq(data->oob_wake_irq);
>>   	}
>>   
>> -	/* Optionally request a device reset on resume, but only when
>> -	 * wakeups are disabled. If wakeups are enabled we assume the
>> -	 * device will stay powered up throughout suspend.
>> -	 */
>> -	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
>> -	    !device_may_wakeup(&data->udev->dev))
>> -		data->udev->reset_resume = 1;
>> -
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.14.3
>>
