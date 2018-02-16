Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3839456-1518771395-2-3801561336541760930
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
    t=1518771394; b=jQgxl7Xndi7yJ8YtBwDHFz+CgsifOMnACwRagdHu8mzOt4V
    9/ybFXOnOI8It9sf79C0DR347FOhfxH3OP+mSmarPzC1fo9yyr91vtRXuL8Qtq0L
    9B/cw6LWagVgQui9527xY0674NxDPhX/Q3lWz+nR4Oc0n/ypUg8G+nB0ctFtmsi6
    89VqO8Z49twWW3wBQIwWMLru3qG8VIZufV4/i3JlOn9N1YmTXmnEN0ZInFA/R74z
    VAELQhuj6O3LaI7J6nFdQrWHTTFJj2/81UYMNjAMrMOTo9ApDG22jqBvEjyo4Cfc
    VXbD3FRiyOtMyf6BuDH6ErRfSH0qX36HImXR1pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518771394; bh=M+fKKnMYfCBn9Aynx5PVLNafjwA0rDiutp6DwxZ+Fmc=; b=m
    vOGrn3svwWb2XJaqCIjEdsJVM4jbHEY0KfFGt0DiSSjWUVRBtSTAGbLNnZ56oWZo
    exCEzKDjn0TH7qZLhMdJgHz1IAji92uwQ0NnkhYFRxsbPVJuEa0+F4fwD6FOoqCf
    1o6bHr1d59z6+9Fox41fO7vUzLT4vpYbqrm12IoazasVcL7/UHrXOwArxelzyi41
    LyDH1KBhJj34Bwf1+lhZF/4DCBM5+KaIbhDDfMtDXiqZUsJGVe8mwBRx8nNDTGZd
    nnjmzvdd91qrkm+dRNx6Qcv+Eppjs/3y0hGa0gqEmiPgonDLsGmxM2NYdul8Lk10
    WMJaWn74YRnkYa3BVjq6g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SQIVnamh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SQIVnamh;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755345AbeBPI4c (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 03:56:32 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:54689 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755348AbeBPI4a (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Feb 2018 03:56:30 -0500
X-Google-Smtp-Source: AH8x2275eBf1HOPi6y+95ATDfbC7bCQySLivi0Ejy6BDGqQd+IVcVvUgkMpYco1a9LuoamXX9zb0ug==
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
        matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
Date: Fri, 16 Feb 2018 09:56:27 +0100
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

Hi,

On 16-02-18 03:27, Brian Norris wrote:
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

Note that the revert for this:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d06d5895c15

Says: "This commit causes a regression on some QCA ROME chips. The USB device reset happens
in btusb_open(), hence firmware loading gets interrupted."

And says:

"If we really want to reset the USB device, we need to do it before btusb_open(). Let's
handle it in drivers/usb/core/quirks.c."

It does not mention that the quirk is not necessary on some devices only
that the implementation of it we had before had issues.

And the original commit of the quirk:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=fd865802c66bc451dc515ed89360f84376ce1a56

Says: "There's been numerous reported instances where BTUSB_QCA_ROME
bluetooth controllers stop functioning upon resume from suspend."

So it may be platform specific but it is not just limited to 1 or
2 platforms I think.

Note I'm not saying that I don't believe you that the quirk is not
necessary on your devices.

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

I see, sorry about that. Ok, so we are going to need to make the
reset-on-resume quirking more fine grained. I can see 3 ways to do this:

1) Make it a separate per usb-id BTUSB_RESET_RESUME flag in the
usb_device_id table inside btusb.c (I still believe duplicating most
ids to usb/core/quirks.c is a bad idea).

2) Use dmi based whitelisting to opt out of reset-resume behavior on
QCA btusb devices.

3) Use dmi based blacklisting which enables reset-resume behavior.

In retrospect I guess 3 would have been best, but if we do that now
it will cause regressions.

I guess we should go with 1. adding the BTUSB_RESET_RESUME to all the
QCA usb-ids except for the ones where you know things work and which
only seem to be used in working devices (based on you not having
objections against the additions of the quirk for some ids to
drivers/usb/core/quirks.c).

And if then those usb-ids do turn out to have broken suspend on
on some devices too I guess we need to move to 2.

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

OK, so it turns out that this is a platform problem, which was not
known to those involved until now. As mentioned before solution 3.
from my above list of solutions would then be ideal, but I don't see
how we can get there now without causing regressions where bluetooth
stops working completely for people.

Regards,

Hans
