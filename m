Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3285773-1520557004-2-13981537700457370706
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520557004; b=TzGb724ghi03/CVcHuBlfk3szjMNWjkhaKFxlVpfxBFnGvG
    +s6rRLRTlnPO+NcJLTypLmC5aZToMbTU5gEkOJN/HD8gp01N5NGYE8mc5X+tBH/Y
    889oBardIR8cFneL7INtlC0AHaPS9TwAb3+Ca4rhPe3f0PjQQk9DNAv8CmNl7B7V
    a41PQNmx4M56Xbha1vCGbGkniAFQ2M6/H+WW3+6zuMtxbqFVLs+oQsHw2+AfIGx7
    0B/okLohCBBYKqV7Kv0GCn1xGdG+jzZMY3I+gVO97ViaEwDXaxHSeEtvQzBVdJLE
    qSB3inh2EL5cl1O0gEE7tYy3Nw4Rw80g57FFjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520557004; bh=GEX6S1TN2iv1j0eo4hDLFzDsaYxp4KQ2uTgIDR
    /Aa0c=; b=p4TEmdp/rIIkN9ItxymZJNLXjaGMS0q7jeCvRHlWkahwDOgjCPoKeh
    si+gKtMY6idKDkHnrVm+3rBM2CF5+Js33X/JV9MkSMQfS0XvBUrdbdO7nalcb5Gj
    rP1K7wfqovKSXOutLydQwavpUX8JTZdx8T2nN5FEOycm4vb34krbjamPF1CSyBAc
    j8gCCKJP1Iw/+F66SOB9LItWRkpE8Do9z56y7ysDmR3TnhssATClOZ7Jt5Tl8UV8
    2ja5z2kzvVapCp3z0gBAcUFxJesiJlkrdRTx36pU3tDgbYaK/Eh6084Wro7tcdF6
    rkXiuuot9gzNG3JuCfLEp/r6/u9pdIgQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Jrc5n39q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hwx3WACR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Jrc5n39q x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hwx3WACR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932085AbeCIA4a (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 19:56:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:40407 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeCIA42 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 19:56:28 -0500
X-Google-Smtp-Source: AG47ELvrlD7Cr1oADSsl4+XhkD4T4MtNTyzDJaAHf5gylLxjFW3peinb140sPutMfGCPlm2ZJYISG54vjcU6iJI7NrM=
MIME-Version: 1.0
In-Reply-To: <1711ebe8-8d1a-7d96-bcbe-17238988557a@redhat.com>
References: <20180108094416.4789-1-hdegoede@redhat.com> <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com> <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com> <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com> <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com> <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
 <a6090910-7941-b194-c094-7ce3ef047974@redhat.com> <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
 <cdf043ef-b7d5-61f9-b8ea-7e75cb22485f@redhat.com> <1711ebe8-8d1a-7d96-bcbe-17238988557a@redhat.com>
From: Leif Liddy <leif.linux@gmail.com>
Date: Fri, 9 Mar 2018 01:56:26 +0100
Message-ID: <CAAbRKOsejuTNdRBJ7g1omS_07DSHuPHpwW2JEsADNOhG6fnWDA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Hans de Goede <hdegoede@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matadeen Mishra <matadeen@qti.qualcomm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Sorry for being a bit slow to respond to this.

I'm the original author of commit:
https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=fd865802c66bc451dc515ed89360f84376ce1a56

> Says: "There's been numerous reported instances where BTUSB_QCA_ROME
> bluetooth controllers stop functioning upon resume from suspend."

> So it may be platform specific but it is not just limited to 1 or
>2 platforms I think.

This issue might very well be limited to just a few platforms.
Here's a link to the original bug report I submitted.

https://bugzilla.kernel.org/show_bug.cgi?id=193571

There was a number of people who reported they were having similar
issues with various QCA Rome bluetooth devices.
The userspace fix that seemed to work for everyone was resetting the usb device.

ie

#!/bin/bash
echo 0 > /sys/bus/usb/devices/1-4/authorized
echo 1 > /sys/bus/usb/devices/1-4/authorized

or

#!/usr/bin/python
from usb.core import find as finddev
dev = finddev(idVendor=0x0cf3, idProduct=0xe300)
dev.reset()

It's difficult to ascertain what the underlying issue was for each
person (and associated device) who commented. I can only speak
authoritatively for my own device.
It's a Samsung ATIV Book 9 12.2 (2015) laptop that contains an
integrated bluetooth controller that's attached to the internal usb
bus.

# lsusb
Bus 001 Device 005: ID 0cf3:e300 Atheros Communications, Inc.

After suspending the laptop for an extended length of time (sometimes
it would take an hour or two before issue occurred), and resuming
--the bluetooth controller would not come back on-line. After reading
through various forums, I suspected the issue I was experiencing was
due to the bluetooth device losing it's firmware during suspend.
The original patch I created did fix the issue. (I do realize that
targeting all QCA Rome chipset's was the wrong decision). Hans de
Goede's rewritten version (commit: 61f5acea8737) also worked for my
device. Since, some people think that the underlying issue may been
fixed elsewhere in the kernel. I'm going to remove Hans' commit and
see if the issue persists (with kernel 4.15.6). I'll report back
tomorrow with the results.


-Leif

On Wed, Feb 28, 2018 at 11:54 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
>
> On 27-02-18 15:07, Hans de Goede wrote:
>>
>> Hi,
>>
>> On 27-02-18 03:29, Brian Norris wrote:
>>>
>>> On Thu, Feb 22, 2018 at 11:14 PM, Hans de Goede <hdegoede@redhat.com>
>>> wrote:
>>>>
>>>> On 23-02-18 04:12, Brian Norris wrote:
>>>>>
>>>>> Hmm? I'm not sure I completely follow here when you say "he was not
>>>>> hitting the firmware loading race". If things were functioning fine
>>>>> with
>>>>> system suspend (but not with autosuspend), then he's not seeing the
>>>>> controller (quoting commit fd865802c66b) "losing power during suspend".
>>>>
>>>>
>>>>
>>>> He was running a kernel with the original "fd865802c66b Bluetooth:
>>>> btusb:
>>>> fix QCA Rome suspend/resume" commit, which fixes regular suspend for
>>>> devices which are "losing power during suspend", but does nothing for
>>>> runtime-suspend.
>>>>
>>>> He ran tests both with and without runtime-pm enabled with that same
>>>> kernel
>>>> and he needed to disable runtime-pm to get working bluetooth.
>>>
>>>
>>> Did he ever test with commit fd865802c66b reverted?
>>>
>>> My symptoms were exactly the same as you described. BT was broken as
>>> of v4.14 if I had runtime suspend enabled. Things were fine if I
>>> either (a) reverted the patch or (b) disabled runtime suspend. I
>>> obviously preferred (a), which is why I continued to complain :)
>>>
>>> Did your tester ever try (a)? If not, then I don't think you've really
>>> ensured that he really needed a "fixed" version; he may not have
>>> needed the patch at all.
>>>
>>> Or an alternative question: did that system work on an older Fedora
>>> release (and presumably an older kernel)? If so, then he probably also
>>> did not need that patch.
>>>
>>>>> So, that would suggest he could only be seeing the race (as I was), and
>>>>> that his machine does not deserve a RESET_RESUME quirk?
>>>>
>>>>
>>>>
>>>> I hope my above answer helps to clarify why I believe the quirk is
>>>> necessary on his machine.
>>>
>>>
>>> I'm sorry, but no it doesn't. If anything, it suggests to me even more
>>> that it may not have been necessary.
>>
>>
>> Ok, I've started another test-kernel build for the reporter this time
>> without any quirks at all and I've asked him to test.
>
>
> You were right, the Yoga 920 works fine without any quirks, thank you
> for being persistent on getting this tested properly.
>
> I will submit a patch dropping the Yoga 920 from the
> btusb_needs_reset_resume_table.
>
> Regards,
>
> Hans
