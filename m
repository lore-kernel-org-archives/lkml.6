Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1763885-1519355561-2-1493263549240891661
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519355560; b=vr5ey/VV0Zd7Db6KfNhDYoOUQZUj521j1UJKBmPH024hgsM
    Sg5CjjWTNYz1lsrPBISBmP0L05g5QSiK6aA692M7dc0CUdH/+oQMmTT/QKAOsaw/
    QeIi7+0tdlN/9FynCdnndwnFTYfDDovsRw1TArTj3llOIYzi7TztIgKKiBHfaH+1
    5KtAJgbZ16pxbxnjkmszTysCfHn5xmm7mEBplotODkialPyeNR9suf1mo4+7YgDN
    LdOxGWoXfbEPbWMvT+rHkl/LgsJYHA79F3WIj7TKFyZonLLOnLEWlC7EPaJyaeC7
    B+PKeRlSIQ8ZQnmoFTsH74MtXhnRjANexfLHd4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519355560; bh=rwR9d5Vj9eKryOnYTr3IX7XpQ5
    VKiQnOKt8/4GOiYPM=; b=PbRLGIFoh3XcJyiLp37HmZoUa0PACeHPEW19aQDeeb
    N9po12nYZqmrIKH8imXrj/XgFcswgoFP394g2GHRrpi6n6MUAzzibYfEpUijQi9N
    tV53xp69ZCzYF4pkjzyN0VPC7pyNEiGU4Ba2WKPc3HU64pFIcYrctEJWJdSFrzWy
    1U12/WJfjbVr+RRV8r0k1UL5G3wj/uH2c3etwFs3o4oyzv5Yhu/GSHLNhWXcrlU4
    EtbICce9llKSyoe0cc+6xM1LPFJct0nKCf9gCcOW7V0DocYotQ9J2pgqCNqoDH09
    PZfFLZ79oxsISGOOj3LVQBQjXIWBMSS0h6+LHOiSo+rw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=LQECzo/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q+19Fmik;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=LQECzo/h x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q+19Fmik;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751405AbeBWDM1 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 22:12:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:47061 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751265AbeBWDMW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Feb 2018 22:12:22 -0500
X-Google-Smtp-Source: AH8x225BvPi2QS87dUDA0MCcTIhDGKuuMxbgZCVvXNv6ELT5Q8SWUR0Tnc5nyEEQziCobUXBIAqmxg==
Date: Thu, 22 Feb 2018 19:12:18 -0800
From: Brian Norris <briannorris@chromium.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
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
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Message-ID: <20180223031216.GA230265@rodete-desktop-imager.corp.google.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
 <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
 <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Hans,

Sorry if I'm a little slow to follow up here. This hasn't been my
top priority...

On Mon, Feb 19, 2018 at 11:17:24AM +0100, Hans de Goede wrote:
> On 16-02-18 18:59, Brian Norris wrote:
> > On Fri, Feb 16, 2018 at 01:10:20PM +0100, Hans de Goede wrote:
> > > Ok, I've asked the reporter of:
> > > 
> > > https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> > 
> > Are you even sure that this reporter is seeing the original symptom at
> > all (BT loses power, and therefore firmware)? Their report shows them
> > running 4.15, which had this commit:
> > 
> > fd865802c66b Bluetooth: btusb: fix QCA Rome suspend/resume
> > 
> > which is admittedly completely broken. It breaks even perfectly working
> > BT/USB devices, like mine. That's where I first complained, and we got
> > this into 4.16-rc1:
> > 
> > 7d06d5895c15 Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
> > 
> > Isn't it possible your reporter has no further problem, and none if this
> > is actually important to them? I'd just caution you to be careful before
> > assuming you need to add blacklist info for their DMI...
> 
> Thanks, that is a good question. His problems only started when I
> enabled usb-autosuspend by default for btusb devices and he got things
> working by adding "btusb.enable_autosuspend=n" on the kernel commandline,
> so he was not hitting the firmware loading race introduced by
> fd865802c66b and runtime suspend/resume is really broken for him.

Hmm? I'm not sure I completely follow here when you say "he was not
hitting the firmware loading race". If things were functioning fine with
system suspend (but not with autosuspend), then he's not seeing the
controller (quoting commit fd865802c66b) "losing power during suspend".

So, that would suggest he could only be seeing the race (as I was), and
that his machine does not deserve a RESET_RESUME quirk?

Or maybe I'm really misunderstanding.

> > As I read it, you need to investigate who are the "numerous reported
> > instances" that generated commit fd865802c66b in the first place. That's
> > where this mess started, IIUC. >
> > But otherwise, yes, option 3 sounds OK. FWIW, my systems are ARM based
> > and don't have DMI data, so option 2 wouldn't work.
> 
> Right I think we all agree that the new plan now is to go back to
> QCA behaving normally wrt (runtime) suspend/resume and then set the
> USB-core RESET_RESUME quirk (which does not have the firmware
> loading race) based on a DMI blacklist.
> 
> I only have the one report for which I will write a patch implementing
> this new policy soonish. And Kai-Heng Feng has another report which
> might even be the machine. I certainly would not be surprised if it
> is another Lenovo machine.

It seems like you folks moved forward on that one. Thanks.

Brian
