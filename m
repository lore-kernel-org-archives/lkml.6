Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3142225-1518751445-2-12864020783831903323
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518751444; b=u8/iJBM5DC2SG2E3fsynVcYOO03I3uVWlP4lR0plsKjDIy0
    +o5qvK3pzrcx6TecGuHtitjM86XIp1Besvy+AgZoRgadD6x2d8UxZBbC+jaly3Ap
    LapzozHe7zfPa7eYN+pSB53w4Rrr0o817jv+f15v1EwcW4ljtDv7oENoAJbo2Q3Y
    8mhX15+CCFPeLvbaJwlB+LvOcQQbhX3BHuji/bTauhRmTDgO5gvadEsEjgMKBCXU
    9xrfsfX3kE2PLTxgJNExtLSlNqJdDFkS9JRUrDfUH7SGCk1wSIJsHwNkayb0xSSx
    5bKPv1VVkca+WSQicGh2/h5jJH+g5DCvYCTN/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518751444; bh=B547U+NAkruKlNugEoh6HX4NBFB8xoGzWlKzmNuWpOY=; b=U
    H55JSdDDr1h3mW6ABNrC/hN+sEsGrm1MjjsRhtzLzogOZ4BIWvmBHHZnWmQdhRij
    ACiwUKeyj4g0oMubCqj+AIrdkom4oSHcj0TUMjuwZVRjo63Ps9L/Y3YKObNKudMw
    gorovisMnD+0XBHlPjOBP0DtLC7yrRkSjjPil4gWF5iPB+9fzLsPbTcmVQLMvily
    Q25XZWjztV9CSgDAjkKlhHPoG7l/+drbbergG+mAZY3UyQ7nySIYF0hcCW/sEAS5
    nRWMMe6ufon3QemHf/dEmDrGvEeGXptBYgJiSqxKT0K8M+R6WSSRC6oOy9DD0FOv
    SlsgQCR57/ZspupdZ8CMQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BghIPa+C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nQeuOXc7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=BghIPa+C x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nQeuOXc7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423227AbeBPDYD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 22:24:03 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:45402 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423214AbeBPDYA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Feb 2018 22:24:00 -0500
X-Google-Smtp-Source: AH8x227iBNJ7d8JJ1cs8FgX+OURk0ktdYA9Fvvdqd+ql087yf0/1D5jMjFcfeF5tM4uhMsCHsSaagA==
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Brian Norris <briannorris@chromium.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6b599dc2-adde-3b68-3e00-58a9d52a1bad@roeck-us.net>
Date: Thu, 15 Feb 2018 19:23:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/15/2018 06:27 PM, Brian Norris wrote:
> Hi Hans,
> 
> On Tue, Feb 13, 2018 at 12:25:55PM +0100, Hans de Goede wrote:
>> On 13-02-18 03:24, Brian Norris wrote:
>>> On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
>>>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>>>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>>>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>>>
>>>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>>>> has several issues (see the original commit message). An added advantage
>>>> of moving over to the USB-core reset-resume handling is that it also
>>>> disables autosuspend for these devices, which is similarly broken on these.
>>>
>>> Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
>>> think so -- I'm using one now.
>>
>> And have you manually enabled USB autosuspend for it, or are you
>> running something which might have done so, e.g. powertop --auto-tune ?
>>
>> Because if you did not do that then you're already not using autosuspend
>> for your QCA devices and this patch will change nothing.
> 
> I use a set of udev rules that manually whitelist devices for
> autosuspend. You can see it here:
> 
> https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
> 
> You'll find at least one Rome chip in there.
> 
>>> Thus, this is a poor solution, which
>>> negatively affects my systems. However, I see that this patch was
>>> applied regardless...
>>
>> Note that there already is a quirk to handle broken suspend/resume
>> behavior on ALL QCA devices in older kernels. Also note that the
> 
> Yes, and the quirk was broken, and I made sure it got reverted when it
> broke my devices ;)
> 
>> patches series which this commit builds on top of was already
>> setting USB_QUIRK_RESET_RESUME for some devices in
>> usb/core/quirks.c.
>>
>> All my commit does is instead of duplicating all the QCA USB-ids in
>> usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
>> to btusb.c so that we don't need to duplicate the USB-id tables.
> 
> I was slightly more OK with marking specific IDs as broken, because
> those IDs didn't happen to be ones that I knew were currently working.
> Now you're breaking my systems again. But this time, it's more subtle
> because bluetooth will still work, but we just suck more power leaving
> our USB port active all the time.
> 
>> The result of the combination of these patches is that the custom
>> DIY reset on resume handling btusb.c was doing is now replaced
>> by setting the standard USB-core USB_QUIRK_RESET_RESUME quirk.
>>
>> As a (desirable) side effect this also disables USB autosuspend
>> for QCA devices since the USB-core does not allow USB autosuspend
>> on devices with the USB_QUIRK_RESET_RESUME quirk. Testing has shown
>> this to be necessary on at least some QCA devices and given that
>> these devices tend to loose there firmware on a suspend, it seems
>> sensible to not allow autosuspend on them.
> 
> But you're not accurately targeting the "some". AFAICT, you're wasting
> power on my system.
> 
>>> What justifications was found for this anyway? AIUI, this is a platform
>>> bug, and not entirely a chipset bug.
>>
>> No this is believed to be a chipset issue, hence also the quirk in
>> older kernels to always reset these devices after a normal suspend/resume.
> 
> I have Qualcomm telling me this is a platform issue. I haven't noticed
> problems with autosuspend nor system suspend/resume on my platform. Do
> you have any more detail on this issue? Have you consulsted QCA folks?
> 
> Unfortunately, Greg is already queueing this patch up to all the -stable
> trees, so I'm going to have to revert it yet again in Chromium
> kernels...
> 

Grumble Grumble Grumble. I'll try to remember to revert this patch when I merge
v4.14.20 into chromeos-4.14. Please remind me if I forget for some reason.

I don't see it queued in v4.4.y - is that still coming ? Hope I won't miss it.

Guenter
