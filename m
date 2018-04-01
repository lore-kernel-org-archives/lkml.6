Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-670106-1522608886-2-9087128972915348397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522608886; b=AZ1L6s2anegHSPrRHU9FFNe3C7vv4eXts6+DZj6DDomisXPAok
    LIcFj8tGLXPTOsfWJuKXOc2dhNZYul1K6wnSMl7RJKgRsBtD8z1udXXltmUNkK0s
    PIMYOcL8mutFgTRNfoScRk6zbtClJ3Zr/o4iormBZLxMyUZ6d0p7pm/2oz7iUOW6
    dMVnXX48T8epAy9SwoNJsQ8tZGd0wYSRdO5LgZ+/1d3sTyhScJwYas0WKj1HRpic
    95lpAxftJhRxSICnY6agKGKvx9GOJRZl7MVdUH+UkTCShCWYYbxx8agr8edfBoeg
    Bue5BFAcDd/h9jF6rtDnBdmWNLlBmFNx7H6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522608886; bh=IV0xb1zRPHCtEA/Hod73W6RZTlKiuQm5Vcp+tfgUoV
    E=; b=PaHqfwp4ogDgX8UMmNNFJxFvmslZVTClZZgTMI6a1yhHFCOgrsU+EAfrEn
    mbhFbAMhVNEMDzOZoBAJnxBqrwnl33XusTPTJkGCnuTb/pxOU0DbYIpP4+mU6qV4
    YFQXvv6SUQQGgQQmAgz80WI1jjsiEcnfYNOBKYSg60AXUfQfNGS9eg1qC75wSKfC
    +oj10Hg+tx+eluvVBFTs8S/FY2FnGpSBFvxM0y1YMXeboGQltiBDY1/zqWf7QI/E
    cNUqxmqfUmkHGFfLW8ip8fVomovP7fRusRaAZBiA8H0vUB6JrsIX098Q0ur/Xhbu
    Hk5zLj0K9XYD4tv/xd2DGQhwpmmg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=oLHLDIKJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=rq4Sg7SR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=teYEBomH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=oLHLDIKJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=rq4Sg7SR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=teYEBomH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfK6RTcyTzQvnekvcLVOtxeczAHnD5cJt/5jcCzYu5OjwIxGSl9n5X4tHKGKfb/jvYWQ1zaPiPGlCLdDV0VNfvhfVugfg88EuK5q+li8KmYkf569gXGpB
    WG31th4lRhFgWxfdyhyQfwUW8fs74fBzIlXoDcPt464k41VcKynyol6EVKiBl7lLurQw3INkoAgX9hdKbVKB/5FYnzRW+SnvL9O270fyuhwST3BGnmh2RkxY
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=z1H5ADGQAAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=1pIWTMwhs-Wpeg77ZIUA:9
    a=0-P_Tjmbljq6deDA:21 a=IpZqebdM1PJyj4yV:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22 a=xmb-EsYY8bH0VWELuYED:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753850AbeDASyn (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 14:54:43 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:42618 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeDASym (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 1 Apr 2018 14:54:42 -0400
X-Google-Smtp-Source: AIpwx4/crD9qgdIB4LRrCe7tNAh95ThC9uK0DrJjA4DKfTh47BscuaWdfVdXlsJaup0CpM6thf/2kSwARq5NMNUd438=
MIME-Version: 1.0
In-Reply-To: <20180329143400.6d9256a5@alans-desktop>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
 <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
 <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
 <20180326192428.71c23abf@alans-desktop> <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
 <20180329143400.6d9256a5@alans-desktop>
From: Aaron Durbin <adurbin@chromium.org>
Date: Sun, 1 Apr 2018 11:54:41 -0700
X-Google-Sender-Auth: fi1rAHQevACk6uLPLGTqnqeY-T4
Message-ID: <CAE2855tmMwbOWDOs-iJS7i35=Y7gt0xun4ApfhZyY9Kr5N3NJA@mail.gmail.com>
Subject: Re: [PATCH 1/3] serial: 8250_early: Add earlycon support for AMD
 Carrizo / Stoneyridge
To: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Cc: Aaron Durbin <adurbin@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Kurtz <djkurtz@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Marc Gonzalez <marc_gonzalez@sigmadesigns.com>,
        Doug Anderson <dianders@chromium.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jeffy <jeffy.chen@rock-chips.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 29, 2018 at 6:34 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
> On Mon, 26 Mar 2018 20:56:45 -0600
> Aaron Durbin <adurbin@chromium.org> wrote:
>
>> On Mon, Mar 26, 2018 at 12:24 PM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> >> Sadly, this situation
>> >> is not unique to this hardware. There is hardware all over that does
>> >> not meet the current assumptions being made in the early uart drivers
>> >> within the kernel.
>> >
>> > Is there any fundamental reason you can't just embed dt entries in the
>> > ACPI table to describe the other features you need. I appreciate it
>> > doesn't solve the generic PC case but it ought to help for anything where
>> > the firmware cares about Linux ?
>>
>> What's the method for doing that? Using _DSD methods? Or have a
>> pointer to examples? Sorry, I haven't spelunked into the current state
>> of bridging ACPI and devicetree in a while.
>
> ACPI 5.1 adds an _DSD method UUID for device properties.
>
> The kernel device_property_* interface will pick them up just as if they
> came from DT tables etc.

But we don't have the full ACPI interpreter up in the early part of
the kernel. All these 'early' devices have their own setup/config
which is the source of the issue. Or maybe I am wrong about the full
interpreter and the early drivers are just not taking advantage of the
ACPI device binding?

-Aaron
