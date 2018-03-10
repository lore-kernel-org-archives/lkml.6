Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1986828-1520649729-2-7688170222206824814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520649728; b=tk2gs9s3ey55hpWtziN9XJ8NFOMJWfRTUh5G0+B3glmvBBY
    ZXlTP7LUBqNYSb9B38iCaM1Di+HBb4ELeJ8Hd0XnKsP/DKkrF/4b9e5wCrXrQqn+
    YzJUkI2SWeUNqWmuLn7GLNfiLLwPb6BNRAaNLQnTWHpI1oLeydusv1uwo9r2UJSS
    zjZROgVAsywQthw44oE1YDlLUsrArDJ2QaKRFNeMUwO+fpWE9u9RVOrZ4lV5Xy11
    UicKTBvotkHfxmMgHDbXTz4JeAhs20UZuMxABTLmFYmAB01CpCVj//HkkiJj2ytZ
    AgeNCCCiEYh3zm9FUVZXc/AJCRx+leYx59Mb2aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520649728; bh=74hM6vSI9PqjGmaeUNbOh+tCkYqPVEEjp9VgAJ
    5PwqQ=; b=UyFD8iZ3b0XU2t/+VBWsQi5QL0kJ8UHzlzPV0tc6t3t5ST2b/KgLpD
    Xtvo4l18ixXrn06K3uNrd7Iq++OnBGOWAaeo87i9TmV+yu453g7sVYg/Y+IZvSd8
    yIvP4arb2j8QrlG8UCTqrAZvKEtboAuk7ewVLbly+v/oPD/+CAqWtGJz4voU+p5W
    6mHBcPLX/kQb0m1EZeuMHwVmOGj0iy8bETVSEB8A6qp12IdD6oeYjgrvf9Aqw029
    6EP59afUMmCNVabGc23xou8YkmChGMK5+u4HyQ/Oet5sR0bMdPmftsmaheA6nS6h
    AQD3S0nZ3wQWukWyKC/bAtznmJyjaoPQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AEkgSEt4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RLcoQ7x7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AEkgSEt4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RLcoQ7x7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeCJCmH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Mar 2018 21:42:07 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:40098 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCJCmF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 9 Mar 2018 21:42:05 -0500
X-Google-Smtp-Source: AG47ELsvOyfOEpM68PQI9FGZcZq0UMOb3cLmzHULlqq5EZDGZm+A9QruCfl+na5VuTjAJWdc+mIPvvTkqS9/t/ZfdqY=
MIME-Version: 1.0
In-Reply-To: <CAAbRKOsejuTNdRBJ7g1omS_07DSHuPHpwW2JEsADNOhG6fnWDA@mail.gmail.com>
References: <20180108094416.4789-1-hdegoede@redhat.com> <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com> <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com> <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com> <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com> <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
 <a6090910-7941-b194-c094-7ce3ef047974@redhat.com> <CA+ASDXOGhi4t2R5qrbXHTFkjtzvUL=qHxkJqku4XKJ6u8Wr+cg@mail.gmail.com>
 <cdf043ef-b7d5-61f9-b8ea-7e75cb22485f@redhat.com> <1711ebe8-8d1a-7d96-bcbe-17238988557a@redhat.com>
 <CAAbRKOsejuTNdRBJ7g1omS_07DSHuPHpwW2JEsADNOhG6fnWDA@mail.gmail.com>
From: Leif Liddy <leif.linux@gmail.com>
Date: Sat, 10 Mar 2018 03:42:04 +0100
Message-ID: <CAAbRKOs+tV5LW+-5GWBnu9p3+b02n0uj=QLFoqhQEEToRgxXmg@mail.gmail.com>
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
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hans,

Everything is now working perfectly fine without commit 61f5acea8737.
I suspended the laptop for hours at a time, the bluetooth controller
comes up fine every time. Whatever the underlying issue was, it's been
resolved elsewhere in the kernel.  There's no longer any need to
implement any sort of RESET_RESUME logic for this device (0cf3:e300).
I appreciate all of the work that you and other developers do. Thanks
for staying on top of this issue!

-Leif


On Fri, Mar 9, 2018 at 1:56 AM, Leif Liddy <leif.linux@gmail.com> wrote:
> Sorry for being a bit slow to respond to this.
>
> I'm the original author of commit:
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=fd865802c66bc451dc515ed89360f84376ce1a56
>
>> Says: "There's been numerous reported instances where BTUSB_QCA_ROME
>> bluetooth controllers stop functioning upon resume from suspend."
>
>> So it may be platform specific but it is not just limited to 1 or
>>2 platforms I think.
>
> This issue might very well be limited to just a few platforms.
> Here's a link to the original bug report I submitted.
>
> https://bugzilla.kernel.org/show_bug.cgi?id=193571
>
> There was a number of people who reported they were having similar
> issues with various QCA Rome bluetooth devices.
> The userspace fix that seemed to work for everyone was resetting the usb device.
>
> ie
>
> #!/bin/bash
> echo 0 > /sys/bus/usb/devices/1-4/authorized
> echo 1 > /sys/bus/usb/devices/1-4/authorized
>
> or
>
> #!/usr/bin/python
> from usb.core import find as finddev
> dev = finddev(idVendor=0x0cf3, idProduct=0xe300)
> dev.reset()
>
> It's difficult to ascertain what the underlying issue was for each
> person (and associated device) who commented. I can only speak
> authoritatively for my own device.
> It's a Samsung ATIV Book 9 12.2 (2015) laptop that contains an
> integrated bluetooth controller that's attached to the internal usb
> bus.
>
> # lsusb
> Bus 001 Device 005: ID 0cf3:e300 Atheros Communications, Inc.
>
> After suspending the laptop for an extended length of time (sometimes
> it would take an hour or two before issue occurred), and resuming
> --the bluetooth controller would not come back on-line. After reading
> through various forums, I suspected the issue I was experiencing was
> due to the bluetooth device losing it's firmware during suspend.
> The original patch I created did fix the issue. (I do realize that
> targeting all QCA Rome chipset's was the wrong decision). Hans de
> Goede's rewritten version (commit: 61f5acea8737) also worked for my
> device. Since, some people think that the underlying issue may been
> fixed elsewhere in the kernel. I'm going to remove Hans' commit and
> see if the issue persists (with kernel 4.15.6). I'll report back
> tomorrow with the results.
>
>
> -Leif
>
> On Wed, Feb 28, 2018 at 11:54 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>>
>> On 27-02-18 15:07, Hans de Goede wrote:
>>>
>>> Hi,
>>>
>>> On 27-02-18 03:29, Brian Norris wrote:
>>>>
>>>> On Thu, Feb 22, 2018 at 11:14 PM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>>>>
>>>>> On 23-02-18 04:12, Brian Norris wrote:
>>>>>>
>>>>>> Hmm? I'm not sure I completely follow here when you say "he was not
>>>>>> hitting the firmware loading race". If things were functioning fine
>>>>>> with
>>>>>> system suspend (but not with autosuspend), then he's not seeing the
>>>>>> controller (quoting commit fd865802c66b) "losing power during suspend".
>>>>>
>>>>>
>>>>>
>>>>> He was running a kernel with the original "fd865802c66b Bluetooth:
>>>>> btusb:
>>>>> fix QCA Rome suspend/resume" commit, which fixes regular suspend for
>>>>> devices which are "losing power during suspend", but does nothing for
>>>>> runtime-suspend.
>>>>>
>>>>> He ran tests both with and without runtime-pm enabled with that same
>>>>> kernel
>>>>> and he needed to disable runtime-pm to get working bluetooth.
>>>>
>>>>
>>>> Did he ever test with commit fd865802c66b reverted?
>>>>
>>>> My symptoms were exactly the same as you described. BT was broken as
>>>> of v4.14 if I had runtime suspend enabled. Things were fine if I
>>>> either (a) reverted the patch or (b) disabled runtime suspend. I
>>>> obviously preferred (a), which is why I continued to complain :)
>>>>
>>>> Did your tester ever try (a)? If not, then I don't think you've really
>>>> ensured that he really needed a "fixed" version; he may not have
>>>> needed the patch at all.
>>>>
>>>> Or an alternative question: did that system work on an older Fedora
>>>> release (and presumably an older kernel)? If so, then he probably also
>>>> did not need that patch.
>>>>
>>>>>> So, that would suggest he could only be seeing the race (as I was), and
>>>>>> that his machine does not deserve a RESET_RESUME quirk?
>>>>>
>>>>>
>>>>>
>>>>> I hope my above answer helps to clarify why I believe the quirk is
>>>>> necessary on his machine.
>>>>
>>>>
>>>> I'm sorry, but no it doesn't. If anything, it suggests to me even more
>>>> that it may not have been necessary.
>>>
>>>
>>> Ok, I've started another test-kernel build for the reporter this time
>>> without any quirks at all and I've asked him to test.
>>
>>
>> You were right, the Yoga 920 works fine without any quirks, thank you
>> for being persistent on getting this tested properly.
>>
>> I will submit a patch dropping the Yoga 920 from the
>> btusb_needs_reset_resume_table.
>>
>> Regards,
>>
>> Hans
