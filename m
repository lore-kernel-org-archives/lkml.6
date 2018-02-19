Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3946214-1519035456-2-2638866480877831389
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
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519035456; b=NlBvIplmSs+YDrl63qPydRLpLRwQIik/j3nCYA408iGC9ge
    /pFladJ2N/emj7HDlqIOXoAsH9SLGoPZBd4oLg0SA8Ui24gzRe35OPoJHgBvwXMF
    81FyFQ4E6auZqaV18qMe2+UbRsIWEtr0fusxVrFqWdUKXmZQqdc6mKfBBx0exBIH
    z1fDBSF5hGDm7G71Zj6idXF0EQ44TfScjRVkIWL6/aEp2VPbfJNiEOGLHGFP4zoc
    ivEok1JvKGIifxryxSnpZvzk9SaXBC482nYKMpjkd1Ihdgw8xIqj1BqM+Iai/vrV
    Uj8Plsk9i3osHR/7HL/xpXMQT8hM7JimmLRY8Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519035456; bh=KyrL1lJuVWhtz/lfWNfiR4MxebGoiCi+UoWAqMW3DFs=; b=W
    fcNXHYgR0l9Z9oH8McZd1YaM3R6ikRLgComE/WP6qfElRznO9daWCP6XOM5f6in0
    tI8rKrkV74HZDZZb9mU4/aChTKWtBm0ZZXnPYbrhbjEmmF4oHMC9XBWbcTc69EvK
    5PGzMp82SsyKRYP/JYNnyFfYlxS7UZW8YvBozPjH3EH09dsXgw90mf7uNnztqUDW
    ufFF/VSYRutm6k9AugiclXF6rzTvPTjwZDlG1CgO8oopNVJUrDJPm3qQqsXtPo/b
    NmOYZldz4U/iUwXKZnIQa5p58GyrUvCZJqaEWztlYbOxl5flCg6OsEjfSnzF7bI0
    Gfgqtm36o3mH7sPiBqoUQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Nuk3fFje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Nuk3fFje;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752703AbeBSKRa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 05:17:30 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36189 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752594AbeBSKR1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 05:17:27 -0500
X-Google-Smtp-Source: AH8x2251Qw8KfafRhDC91zOGB7PPo05+odFfMschJsh4p4e80p3R/autYxOVdfw9XgxoCSlo8INPbw==
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
To: Brian Norris <briannorris@chromium.org>
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
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
 <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <a846c1ac-7dea-a30a-4133-32eac606d101@redhat.com>
Date: Mon, 19 Feb 2018 11:17:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216175955.GA80944@rodete-desktop-imager.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

HI,

On 16-02-18 18:59, Brian Norris wrote:
> Hi,
> 
> On Fri, Feb 16, 2018 at 01:10:20PM +0100, Hans de Goede wrote:
>> On 16-02-18 12:45, Marcel Holtmann wrote:

<snip>

>>> actually if this is really platform related as Qualcomm is indicating, then we should just go with 3) and the two platforms that previously added quirks to usb/core/quirks.c and blacklist these. I am all for figuring out what is going on here. So lets blacklist these and see how this goes. Maybe there are only two bad platforms out there and we are making too much fuzz about this. Before we added quirks in the USB core these platforms were just plain broken as well. So not much different situation than before. We need to push the DMI blacklisting back into -stable as well and that means any impact of a 3rd broken platform briefly working and then be broken again is slim and also fixable via -stable.
>>
>> Ok, I've asked the reporter of:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> 
> Are you even sure that this reporter is seeing the original symptom at
> all (BT loses power, and therefore firmware)? Their report shows them
> running 4.15, which had this commit:
> 
> fd865802c66b Bluetooth: btusb: fix QCA Rome suspend/resume
> 
> which is admittedly completely broken. It breaks even perfectly working
> BT/USB devices, like mine. That's where I first complained, and we got
> this into 4.16-rc1:
> 
> 7d06d5895c15 Revert "Bluetooth: btusb: fix QCA Rome suspend/resume"
> 
> Isn't it possible your reporter has no further problem, and none if this
> is actually important to them? I'd just caution you to be careful before
> assuming you need to add blacklist info for their DMI...

Thanks, that is a good question. His problems only started when I
enabled usb-autosuspend by default for btusb devices and he got things
working by adding "btusb.enable_autosuspend=n" on the kernel commandline,
so he was not hitting the firmware loading race introduced by
fd865802c66b and runtime suspend/resume is really broken for him.

> As I read it, you need to investigate who are the "numerous reported
> instances" that generated commit fd865802c66b in the first place. That's
> where this mess started, IIUC. >
> But otherwise, yes, option 3 sounds OK. FWIW, my systems are ARM based
> and don't have DMI data, so option 2 wouldn't work.

Right I think we all agree that the new plan now is to go back to
QCA behaving normally wrt (runtime) suspend/resume and then set the
USB-core RESET_RESUME quirk (which does not have the firmware
loading race) based on a DMI blacklist.

I only have the one report for which I will write a patch implementing
this new policy soonish. And Kai-Heng Feng has another report which
might even be the machine. I certainly would not be surprised if it
is another Lenovo machine.

Regards,

Hans
