Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3062572-1518748052-2-498821614243426764
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
    t=1518748051; b=YnqmmdFngfeR50cx9vgilyr5pqBXRs+PrKk4w/AfVukLM9s
    69sGWzVCitkilShTO494KKqqw/m8ex3MuSfM7kjC71J7xkC7ozjWlunfW5WtC6qA
    SBXSG3VhaQcvXmIg+mreAhJqqjug6iHYtkc6mG0NHydW1Enwtynp919ZvcgVYZbT
    uEF3jrUdZEiDGlD1aaAJeYwerURzrXuRqs2BboI3x8S4KUA6A+xMFxMg/R9WveHC
    gpo40KvW8NIGCc9FsQPNPjiL0ILqaV0fJSKU/DdG7At2L8w1KlulG8DtwLFooPbJ
    JGNjenQ8OH4WbveJDauQEkgUV4zxLbtN4jQ0c/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518748051; bh=1BnpaLnd2356HvkPj2S/zhIds1
    7KGUai3IQuXXCWd0U=; b=SRUSeNcj87XVFmxS9NwYphvIu/xW2BPj3x938t4egF
    Vem65XCh1/Zmf1I9gEt5GRYHZudbfSzevhS5abZBrNMlQ8n6OA+nuJb6Rm5TZudr
    fm45iOsU3XTNDin9VjcCothN5WZM13bmraaimZ5u286buF6GY9ytScuOae+ySeHS
    ZE2qykxBxovZ0UkTxJtepuRFgp4tDZwV3yFYc4T+NFff9r+/XnYFDfB5PMLC3y+P
    o9r2Xca+WAbzwb9qC05nbDgcaoMFy0ZQcTfEVjtOJby5i6YunKlxKcx5VK2h7GiB
    Ecwbk784OJ1guBuzf1KoHHrjQn11YyZdOLSxn5obs1tw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=JbzxFCCp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gTZUEbOu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=JbzxFCCp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=gTZUEbOu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757234AbeBPC12 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 21:27:28 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42698 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757212AbeBPC11 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Feb 2018 21:27:27 -0500
X-Google-Smtp-Source: AH8x224uwx6v1OQxIyFxrhiqpmTf62JJUZto9NION0JG5ZbeTKmoipGtBEwbK0bLq7BKnLavHbrykA==
Date: Thu, 15 Feb 2018 18:27:23 -0800
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
        matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Message-ID: <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Hans,

On Tue, Feb 13, 2018 at 12:25:55PM +0100, Hans de Goede wrote:
> On 13-02-18 03:24, Brian Norris wrote:
> > On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
> > > Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> > > removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
> > > instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
> > > 
> > > This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
> > > has several issues (see the original commit message). An added advantage
> > > of moving over to the USB-core reset-resume handling is that it also
> > > disables autosuspend for these devices, which is similarly broken on these.
> > 
> > Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
> > think so -- I'm using one now.
> 
> And have you manually enabled USB autosuspend for it, or are you
> running something which might have done so, e.g. powertop --auto-tune ?
> 
> Because if you did not do that then you're already not using autosuspend
> for your QCA devices and this patch will change nothing.

I use a set of udev rules that manually whitelist devices for
autosuspend. You can see it here:

https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83

You'll find at least one Rome chip in there.

> > Thus, this is a poor solution, which
> > negatively affects my systems. However, I see that this patch was
> > applied regardless...
> 
> Note that there already is a quirk to handle broken suspend/resume
> behavior on ALL QCA devices in older kernels. Also note that the

Yes, and the quirk was broken, and I made sure it got reverted when it
broke my devices ;)

> patches series which this commit builds on top of was already
> setting USB_QUIRK_RESET_RESUME for some devices in
> usb/core/quirks.c.
> 
> All my commit does is instead of duplicating all the QCA USB-ids in
> usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
> to btusb.c so that we don't need to duplicate the USB-id tables.

I was slightly more OK with marking specific IDs as broken, because
those IDs didn't happen to be ones that I knew were currently working.
Now you're breaking my systems again. But this time, it's more subtle
because bluetooth will still work, but we just suck more power leaving
our USB port active all the time.

> The result of the combination of these patches is that the custom
> DIY reset on resume handling btusb.c was doing is now replaced
> by setting the standard USB-core USB_QUIRK_RESET_RESUME quirk.
> 
> As a (desirable) side effect this also disables USB autosuspend
> for QCA devices since the USB-core does not allow USB autosuspend
> on devices with the USB_QUIRK_RESET_RESUME quirk. Testing has shown
> this to be necessary on at least some QCA devices and given that
> these devices tend to loose there firmware on a suspend, it seems
> sensible to not allow autosuspend on them.

But you're not accurately targeting the "some". AFAICT, you're wasting
power on my system.

> > What justifications was found for this anyway? AIUI, this is a platform
> > bug, and not entirely a chipset bug.
> 
> No this is believed to be a chipset issue, hence also the quirk in
> older kernels to always reset these devices after a normal suspend/resume.

I have Qualcomm telling me this is a platform issue. I haven't noticed
problems with autosuspend nor system suspend/resume on my platform. Do
you have any more detail on this issue? Have you consulsted QCA folks?

Unfortunately, Greg is already queueing this patch up to all the -stable
trees, so I'm going to have to revert it yet again in Chromium
kernels...

Brian
