Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:43:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 158AF2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 13:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158AF2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387555AbeKMXlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 18:41:10 -0500
Received: from a.mx.secunet.com ([62.96.220.36]:51666 "EHLO a.mx.secunet.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732728AbeKMXlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 18:41:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by a.mx.secunet.com (Postfix) with ESMTP id F210C201E1;
        Tue, 13 Nov 2018 14:42:56 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
        by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xTx-j5ps39n0; Tue, 13 Nov 2018 14:42:55 +0100 (CET)
Received: from mail-essen-01.secunet.de (mail-essen-01.secunet.de [10.53.40.204])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by a.mx.secunet.com (Postfix) with ESMTPS id 9C0A3201E0;
        Tue, 13 Nov 2018 14:42:55 +0100 (CET)
Received: from [10.182.7.41] (10.182.7.41) by mail-essen-01.secunet.de
 (10.53.40.204) with Microsoft SMTP Server (TLS) id 14.3.408.0; Tue, 13 Nov
 2018 14:42:55 +0100
Subject: Re: USB-C device hotplug issue
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
CC:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bin Liu <b-liu@ti.com>,
        "Maxim Moseychuk" <franchesko.salias.hudro.pedros@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dominik Bozek <dominikx.bozek@intel.com>,
        USB list <linux-usb@vger.kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.1810261000040.1467-100000@iolanthe.rowland.org>
 <ac4ea7fa-9fd7-0987-a70c-11a26465e680@linux.intel.com>
 <4140fee5-8935-daed-8438-d04d7f1198b2@secunet.com>
 <0427ea9d-a04c-61bf-9f64-5f2a42ab0072@linux.intel.com>
From:   Dennis Wassenberg <dennis.wassenberg@secunet.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dennis.wassenberg@secunet.com; keydata=
 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
 YPsSSSBN/R6Xmw==
Organization: secunet Security Networks AG
Message-ID: <429d1d3c-c287-e152-7ad7-60539d5f536b@secunet.com>
Date:   Tue, 13 Nov 2018 14:38:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <0427ea9d-a04c-61bf-9f64-5f2a42ab0072@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-G-Data-MailSecurity-for-Exchange-State: 0
X-G-Data-MailSecurity-for-Exchange-Error: 0
X-G-Data-MailSecurity-for-Exchange-Sender: 23
X-G-Data-MailSecurity-for-Exchange-Server: d65e63f7-5c15-413f-8f63-c0d707471c93
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10
X-G-Data-MailSecurity-for-Exchange-Guid: 9EDEE221-F557-4C1B-8CD9-0C5CC0074DCC
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.18 14:47, Mathias Nyman wrote:
> On 07.11.2018 11:08, Dennis Wassenberg wrote:
>>
>> On 05.11.18 16:35, Mathias Nyman wrote:
>>> On 26.10.2018 17:07, Alan Stern wrote:
>>>> On Fri, 26 Oct 2018, Dennis Wassenberg wrote:
>>>>
>>>>>>> --- a/drivers/usb/core/hub.c
>>>>>>> +++ b/drivers/usb/core/hub.c
>>>>>>> @@ -2815,7 +2815,9 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
>>>>>>>                        USB_PORT_FEAT_C_BH_PORT_RESET);
>>>>>>>                usb_clear_port_feature(hub->hdev, port1,
>>>>>>>                        USB_PORT_FEAT_C_PORT_LINK_STATE);
>>>>>>> -            usb_clear_port_feature(hub->hdev, port1,
>>>>>>> +
>>>>>>> +            if (!warm)
>>>>>>> +                usb_clear_port_feature(hub->hdev, port1,
>>>>>>>                        USB_PORT_FEAT_C_CONNECTION);
>>>>>>>                  /*
>>>>>>
>>>>>> The key fact is that connection events can get lost if they happen to
>>>>>> occur during a port reset.
>>>>> Yes.
>>>>>>
>>>>>> I'm not entirely certain of the logic here, but it looks like the
>>>>>> correct test to add should be "if (udev != NULL)", not "if (!warm)".
>>>>>> Perhaps Mathias can confirm this
>>>
>>> Sorry about the late response, got distracted while performing git
>>> archeology.
>>>
>>> "if (udev != NULL)" would seem more reasonable.
>>>
>>> Logs show that clearing the FEAT_C_CONNECTION was originally added
>>> after a hot reset failed, and before issuing a warm reset to a SS.Inactive
>>> link.  (see 10d674a USB: When hot reset for USB3 fails, try warm reset.)
>>>
>>> Apparently all the change flags needed to be cleared for some specific
>>> host + device combination before issuing a warm reset for the enumeration
>>> to work properly.
>>>
>>> The change to always clear FEAT_C_CONNECTION for USB3 was done later in patch:
>>> a24a607 USB: Rip out recursive call on warm port reset.
>>>
>>> Motivation was:
>>>
>>> "In hub_port_finish_reset, unconditionally clear the connect status
>>>   change (CSC) bit for USB 3.0 hubs when the port reset is done.  If we
>>>   had to issue multiple warm resets for a device, that bit may have been
>>>   set if the device went into SS.Inactive and then was successfully warm
>>>   reset."
>>>
>>>>> I don't know if clearing the USB_PORT_FEAT_C_CONNECTION bit is
>>>>> correct in case of a non warm reset. In my case I always observed a
>>>>> warm reset because of the link state change.
>>>>> Thats why I checked the warm variable to not change the behavoir for
>>>>> cases a didn't checked for the first shot.
>>>>
>>>> (The syntax of that last sentence is pretty mangled; I can't understand
>>>> it.)
>>>>
>>>> Think of it this way:
>>>>
>>>>      If a device was not attached before the reset, we don't want
>>>>      to clear the connect-change status because then we wouldn't
>>>>      recognize a device that was plugged in during the reset.
>>>>
>>>>      If a device was attached before the reset, we don't want any
>>>>      connect-change status which might be provoked by the reset to
>>>>      last, because we don't want the core to think that the device
>>>>      was unplugged and replugged when all that happened was a reset.
>>>>
>>>> So the important criterion is whether or not a device was attached to
>>>> the port when the reset started.  It's something of a coincidence that
>>>> you only observe warm resets when there's nothing attached.
>>>>
>>>>> During the first run of usb_hub_reset the udev is NULL because in
>>>>> this situation the device is not attached logically.
>>>>>
>>>>> [  112.889810] usb 4-1-port1: XXX: port_event: portstatus: 0x2c0, portchange: 0x40!
>>>>> [  113.201192] usb 4-1-port1: XXX: hub_port_reset: udev:            (nil)!
>>>>> [  113.201198] usb 4-1-port1: XXX: hub_port_reset (not clearing USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x1!
>>>>> [  113.253612] usb 4-1-port1: XXX: port_event: portstatus: 0x203, portchange: 0x1!
>>>>> [  113.377208] usb 4-1-port1: XXX: hub_port_reset: udev: ffff88046b302800!
>>>>> [  113.377214] usb 4-1-port1: XXX: hub_port_reset (not clearing USB_PORT_FEAT_C_CONNECTION): 0x203, portchange: 0x0!
>>>>> [  113.429478] usb 4-1.1: new SuperSpeed USB device number 7 using xhci_hcd
>>>>> [  113.442370] usb 4-1.1: New USB device found, idVendor=0781, idProduct=5596
>>>>> [  113.442376] usb 4-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
>>>>> [  113.442381] usb 4-1.1: Product: Ultra T C
>>>>> [  113.442385] usb 4-1.1: Manufacturer: SanDisk
>>>>> [  113.442388] usb 4-1.1: SerialNumber: 4C530001131013121031
>>>>>
>>>>> Or maybe we can skip clearing the USB_PORT_FEAT_C_CONNECTION bit in
>>>>> case of hub_port_reset completely without any other check?
>>>>
>>>> See above.
>>>
>>> Checking for udev sounds reasonable to me.
>>> Not sure if we should worry about the specific host+device combo that needed flags
>>> cleared before warm reset. See patch:
>>>
>>> 10d674a USB: When hot reset for USB3 fails, try warm reset.
>>> https://marc.info/?l=linux-usb&m=131603549603799&w=2
>>>
>>> -Mathias
>> Checking for udev works well too in my case. So there is no need to check the warm flag.
>>
>> Regarding the other point about the specific host+device combo which needs the flags cleared, I don't know how to
>> proceed.
>>
> 
> I support just adding a udev check patch, want to send one?
Ok, I will do so.
> 
> Current hub port reset code is wrong, causing real life issues today.
> 
> The issue with the specific host+device is from 2011,
> The port reset code has changed completely since then.
> If it turns out to still be a issue we can make a host/device specific quirk.
>> -Mathias
ok, understood.

Dennis
