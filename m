Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-287146-1526673849-2-14872076634806216873
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526673848; b=QHBwi1lVuGeNt1zBQlzGbU6eMDZpfVhePnzpmKbrJ8y++wEy2b
    ktyzNNEKPi+5iqI5rjlcNLXSrlWaHgiNeWxdpoe215XZbxSlM100BKIFU8wjG05s
    R2L6OuLm21rPAv3oiwDSESANJRRUTDoTVfpBQh7/ped2idqC4sG2efeIn8RO9bYr
    MqUs6dgxCvpbcmzz2Hc7xg59oCFYIKJXtCnqrtTxJ5sTLLVHChX9lrzUspv49/8v
    f1oUrQbpcyQW3vacaHw1y3fG6lams19xrmxXyUQenwxGJ5ucVCGMngZ0IDLchSQI
    Dy1Gzm+zu9tL4wlZrAUFj36I3F6+6yAEK1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526673848; bh=eSsJU16R2z8JJhvi0PPfnXlYKmNpulVKbusSmhc7ja
    0=; b=lzBmJAKAhuSqixnIC04HV1My8qR/2GfNnNmqtytd3Rvy9nIj8Dh5MW2rKE
    iFLjUjfpujhFA2aZqcPkSzKs38bohbCCJasvPPt9tXSn9CJZaeG6giYE6qROq9p+
    2UX9ztGD7E36VajVyC9VJUAS2wMaOW6jGgQGOGsg8Ew/isFjA13liirZjMKZVqFI
    VYsSP3yYBKdPrMjfuuSs0EQgBX8XcKQcZpkl/fRje/F2HVKdcKMrzzXA3j4eA6/+
    DslTGbW9C34N2hhvoaFC+gEEHouizUKXDprOylIPRe6RGwKwnvhg33fvfJaraQmU
    TToh8CEFfrtXv5mqBNijUPNnltTQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=rIYVpFZs x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=bolg1tVE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=rIYVpFZs x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=bolg1tVE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA+eZzPCWNHzD4s6JhJigZv5I8bIKFGWCLcJQ1hjAKntnlmntLQBH3W1EoLXpDsVIHfzszoqOvAXcluPQC4OhrvbEEQEkXhhKI4PdkoL25LOeADsGZLF
    H9rqwpC3CzkuVkOenDxe7SkP17FPVq8WXmdQvIfdQlyB+/ufh0voneU+OxWdfXXOjFd1Xt3Mu/9eFZoqzMDRsszhBRRckwT2jqomQNndVWC876nrVlgXtXlt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=SbiFeICAywIA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=sLPyv-bZoFUbdCuCgRcA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752026AbeERUEF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 16:04:05 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:41098 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeERUED (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 18 May 2018 16:04:03 -0400
X-Google-Smtp-Source: AB8JxZp2Wosif1skkopuBVLcSEGM9ke967AaCG9CpTKcqCPQtPE/n6+urYjK6AOnxcGWDIOPyLog3yB3h6EjYLnu8Is=
MIME-Version: 1.0
In-Reply-To: <20180518151543.GA6501@kroah.com>
References: <9365397f-7206-728e-ee76-146629bfd186@molgen.mpg.de>
 <20180515160047.GB26720@kroah.com> <69da4aa4-3d4b-0ffc-81ce-500713cd3743@molgen.mpg.de>
 <20180516080226.GC3536@kroah.com> <20180516115814.GB11469@kuha.fi.intel.com>
 <df6610738db046e9bd1db77d4346cfc3@ausx13mpc120.AMER.DELL.COM>
 <20180517085930.GD11469@kuha.fi.intel.com> <40707f34-e0a6-3114-36a3-6603bdcd8d82@molgen.mpg.de>
 <20180518104000.GA13595@kuha.fi.intel.com> <20180518150823.GA14756@kuha.fi.intel.com>
 <20180518151543.GA6501@kroah.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 18 May 2018 22:04:02 +0200
X-Google-Sender-Auth: o2acnuu9LeZwDlLMLdkcIB6jz60
Message-ID: <CAJZ5v0hbpgvvmvCvxEVGed8VcOXoO1TTEXK9zsXxCGP4wLqrZA@mail.gmail.com>
Subject: Re: `ucsi_acpi: probe of USBC000:00 failed with error -12` on Dell
 XPS 13 9360/9370
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Paul Menzel <pmenzel+linux-usb@molgen.mpg.de>,
        Mario Limonciello <mario.limonciello@dell.com>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:"
        <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 18, 2018 at 5:15 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Fri, May 18, 2018 at 06:08:24PM +0300, Heikki Krogerus wrote:
>>
>> Rafael, the problem here with these Dell laptops is that a memory page
>> that is used as a mailbox for special communication between EC FW and
>> OS (called UCSI mailbox) should be in uncached memory, but the memory
>> is marked as cached.

Well, why don't we map it as uncached, then?

>> I'm actually not even sure if the cache mode is something that is set
>> based on information from ACPI tables, or is it something that the
>> BIOS handles separately?

We map the ACPI tables as cached as a rule, so that may be the reason.

>> If it's information coming from ACPI tables, can we help pin point the
>> place the BIOS guys at Dell should fix?

I'm not sure where this particular piece comes from.

> Given that Windows works with this same set of ACPI tables, perhaps the
> requirement isn't that this memory location be uncached?
>
> We shouldn't have to fix up ACPI tables just for Linux, we've been down
> that path before :(

Yes, pretty much.

Thanks,
Rafael
