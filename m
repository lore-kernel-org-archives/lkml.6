Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-549093-1518799775-2-6688227308474747502
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
    t=1518799775; b=Y/bTGjvdbPonkULOVyKH3eK+1UWZ2WPcmhhpWpCdnNZrWKI
    JUwX0kuT6rtakQxiFxhLOS+jL5yG1M+NhlHNakWuTLwnEAN4xmHtHFCIDb74D3O3
    G2O+F7J+PlTPEK7iyIW4ADTY44b1VtsOQ02Z3H5PdPJo52cD0Adc2eXHqWudvJ2N
    cpJ87/GddLg6HW+FysxuTAsKPxGFjpX7xRZDy559XkJFDFaoAB/FEqyUkJnFPWR8
    veLn+9EP7pyHsj/OZv7U49ZYxaFMBybnO8py0mCMQgl+O2mCMCjIXqiVLGF+wtTa
    r0QJCTubZYObA7wrrOaewswyp2Za9UHv29EklqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518799775; bh=X/WVw998MCH2iOhWdQPeAhqadT
    Ei6RXfsHxFQhRIeHI=; b=ZZbdSbQXGHjaLGmzT2dY62xAMTqCj/asEFjA1NIm0C
    QwBqAOnut4JtSsHYS+tZCKwfgW/I91mbEGCa+i2rKWHpF22KBKEXXG80LYM1DvS+
    Sdx3fUGXbzKDSkSjUOdJIAIgUAtsvU2yNXng7pgLckwzAa5ZEowrBSXHkfGj5spx
    vFK3O9QqwXfn1mAvBth84c4iw1OeeBR17IwCaAx7m2NryNycH9y3be8oVc7dDBZl
    z9UHSOZpIBUb2UCSYX3r/Nre6heE+eFWvucueoUZVGgCcwk5BLU6105cX3MCuvCY
    lzQBkyiZJhS8gFeV+q78uM2dXvvVu+FXCKVJj/Gf+Hhw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=HVihWwIc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FwNHSZ0n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=HVihWwIc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FwNHSZ0n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161063AbeBPQtc (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Feb 2018 11:49:32 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:37513 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161337AbeBPQt3 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 16 Feb 2018 11:49:29 -0500
X-Google-Smtp-Source: AH8x225kuy2WTOVX7LuiZLrjlim2ebM30YF4LeqQ1SDtvkCc18hX/RI/QZFZb4/aY/N+3av8rhBaHQ==
Date: Fri, 16 Feb 2018 08:49:25 -0800
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
        Guenter Roeck <linux@roeck-us.net>,
        Benson Leung <bleung@chromium.org>
Subject: Re: udev USB autosupend whitelist (was Re: [PATCH] Bluetooth: btusb:
 Restore QCA Rome suspend/resume fix with a "rewritten" version)
Message-ID: <20180216164924.GA72213@rodete-desktop-imager.corp.google.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <0a13d0f3-8e0d-74df-df9c-2bf0622a9fb6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a13d0f3-8e0d-74df-df9c-2bf0622a9fb6@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

+ Benson (and there are probably others that know better answers)

Hi,

On Fri, Feb 16, 2018 at 09:26:37AM +0100, Hans de Goede wrote:
> Going a bit off-topic here, so changed the subject.
> I will reply on topic in another mail.
> 
> On 16-02-18 03:27, Brian Norris wrote:
> > I use a set of udev rules that manually whitelist devices for
> > autosuspend. You can see it here:
> > 
> > https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
> > 
> > You'll find at least one Rome chip in there.
> 
> Oh, that is a very interesting link for the work I've been doing to
> improve Linux power-consumption in general:
> 
> https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife
> 
> I was actually planning on at least doing such a list for WWAN modems,
> for btusb my approach has been to just enable it everywhere
> (except for QCA devices as I got bugreports for those).
> 
> Note that I plan to eventually submit this whitelist to the
> udev rules which are part of systemd upstream, so if chromeos
> is using systemd too, this is something to be aware of for you.

Chrome OS does not currently use systemd, but thanks for the heads up.

> Question, is the white-listing of the root and rate-limiting
> hubs really necessary? I thought these have this enabled by default?

This list is old and maintained by several of my team, originating from
quite a ways back (i.e., much older kernels). It's quite possible that
some of it is redundant today.

> Also any caveats here I should be aware of?

That it's only maintained for the express purpose of Chrome{device}s?
There's no guarantee that there aren't platform issues with other
systems, for instance :)

I'm not really aware of any particular caveats otherwise.

Brian
