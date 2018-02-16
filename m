Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3849420-1518770614-2-16756323563637914814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518770614; b=Aw71QOF1DYf1HyCvEE3X0tLPguV4TRLBnoB4PN1er++5pGt
    cVyLFVmNeQr+NQeg2kSDKIYL0e/C62fTnCM+Gff8yGVqv3vZzHtVr+vB2FEKz/cW
    Vdf6FfeIOfqynYRrYWlOMMkJ0vMaZyyb8h3Tp4Hiba4nPRVnQAfDGcJmUynB6T8q
    dBAJ+JaRC7EW/QQSE/QCCOKkMVxdavV22sI+GwA9itbi9SF0yzxhRXTBGJTr/d40
    YgJjlGybZAoUc+gd+tMs8TZlt1LSBaBJ7jJj9/lqqgTzgutC4p51KewNR8ka5p9p
    SKw8VQshj15Vq7N01xvIhEpFr9nR6nQDpFkiWHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1518770614; bh=n72mE
    H3Hn61ZLq2F+MLy6s5UjqKHhucttsgoAXJtd0w=; b=f+xq+0vGfhTKse5OmDdKq
    qLMzaMTgEmfOMD+6vzbX96izPVvPWYM2kMTGQiXChnxLyYL+Wv/3XXWbQnWDRzxn
    9kY/2q/uWLRObhHrANNaHbemrA8LASl/PkwguirGAECe4XlRxIxa7NyUHACJU8K4
    TBhrGpsjGkSJkev5Kk+WEHWZBdbk5xJ24WEoRwa+mKVlT4nzxk6nsN42DI5qe0Lv
    lj1/t70fzAnK4WYo0ac4dtoUsW9SueXOTdPfUEp1f2CI3Iwt6iDeEWv+PLsG5C0+
    3ped+JunFEm7o9QEYYXsbIxYQyj5j7jYmUWjsK5EqXCsz3FAWcg5rOIXpG/ozAmP
    Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=holtmann.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=holtmann.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754880AbeBPInV convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Fri, 16 Feb 2018 03:43:21 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:47026 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754775AbeBPInT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Feb 2018 03:43:19 -0500
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
Date: Fri, 16 Feb 2018 09:43:16 +0100
Cc: Hans de Goede <hdegoede@redhat.com>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Leif Liddy <leif.linux@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Drake <drake@endlessm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        matadeen@qti.qualcomm.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Transfer-Encoding: 8BIT
Message-Id: <6A7B0B8A-71AD-4FC6-AE2F-B959B3C4BA00@holtmann.org>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
To: Brian Norris <briannorris@chromium.org>
X-Mailer: Apple Mail (2.3445.5.20)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Brian,

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

if this is a platform issue, then doing this based on VID:PID pairs is wrong no matter what. Then again, if we have really dedicated VID:PID combination for certain platforms, we could also just whitelist them in the driver. The btusb.c already contains an extra blacklist check. It is easy to add another USB ID table for a QCA whitelist.

Regards

Marcel

