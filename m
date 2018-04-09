Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1388873-1523289618-2-8145263260634823172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523289618; b=tMjgdTE/uqAqUp1XBhvhWLGtTz0Sl8QrzM9q2QLYuQx4WR/mz3
    DPQKOCOvaXwXv8UTceG1SQYbWyrwwmffUbkXQF2TePx+AkBMUWcRVbSGnCq72rSr
    I/uDZVzz79UvAlxeMIocF9a4xFgVbaQZQX+EdEkp0brLhUw1Jk4+xM3zMDPZZJVN
    aMI02R6CUVAnu1zBgoZ7W1BMour6Ef70kKShyNiJXIs1tQ2fixDg1Tbh64lAGZTF
    HkVcwNIS55+o4EE8VJAfqrsKdlukAXmZpMh62QKwvXWBgHhf5eFEAyYiuRW2J6qU
    TywwWDjXPNa9N6Wh24CsteFKuMrYENPJvRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523289618; bh=23ArPzYV85yivoAQYRWC7W44MXsYiSMNpxAMlZCg44
    E=; b=hdX3KCierf8wTz5b3C/1QQFJsDswqLVpKpdqRCDTucSNl4YRTfrTcyi2D3
    OhqYdc9I97Ez8/1b2qN6ptzJTa4FgvoBrNsNESx2Wh1gCZM2rFxpCi7OIwUKJxhi
    4iu0gMPfSiT3GnU5mtqauoWFLVEpbTCuN7A9vXn6QmpCZP3+NoFkEEm/2IKa0A71
    bz8FogM2prEE0KI7zJy33cBlHt3dU2sNjZ4MO1d6blA5wiAYGzQtujm3Spf6wzoN
    Pyxp6v8zukHfCHWvFNQrMRjNwMs192USILFKwn8A1t9SQ2ReMMxtsVh59jHflzi2
    WQc8tIqkxjANiOqNB8tk3v0QxKFA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=WOQ88AIv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=sccTlw5W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NhXT72uU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=WOQ88AIv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=sccTlw5W x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=NhXT72uU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFxMSIEv1aUFSA3HYujvjsim8h8WgWUZ2zDgOATqXHEG6VGFIUnBnJikMKzaDZE2Wqo4PzGITBfyuvp3euglTlxlTg5dlun5F2w5qMccbft8GWvR/DBY
    JWZQQxw2UqYJcN1WB2W+sDeNvHwCNKD45QVi83y25A/6yEgJAX/4twE4OMsO2S3vwsUeE1RXL5celtRdf/WBw6xxZ7q5HblqCzmPJiOqRCRXE/v05ZVDQhx6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=z1H5ADGQAAAA:8 a=VwQbUJbxAAAA:8 a=x8fIiaOb7dvUb--WDIUA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cNhwqobjEIRUxE0uuXBi:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753188AbeDIQAR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 9 Apr 2018 12:00:17 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:44320 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752799AbeDIQAP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Apr 2018 12:00:15 -0400
X-Google-Smtp-Source: AIpwx4/tHNrJlKsRYBfPwqpMu/UB5pW3tdsUkjieUCU9zxYVIihigYyHP3Vw3NtQaz3SQFmH/N2u8zHjID39f6vbuNw=
MIME-Version: 1.0
In-Reply-To: <20180406144713.30d1ca00@alans-desktop>
References: <20180314003655.12141-1-djkurtz@chromium.org> <20180314003655.12141-2-djkurtz@chromium.org>
 <CAPybu_0uLNz=tRvwqnMfoogJ=A4b5SgMecE9ZihrZdFrbRvcEw@mail.gmail.com>
 <CAGS+omCuEYSHFPmknvvvjUpCWFP_rCmwa9utQiO=aEmdm-anwg@mail.gmail.com>
 <CAHp75VehhNv6pPrRiM9jBAK9FsqZ2Defo8HKhutwn+GPnCFp3w@mail.gmail.com>
 <CAE2855tGe0i9XoEPe9iLFpCds3fXyj9uGhDACvK06KaqvhvYBg@mail.gmail.com>
 <20180326192428.71c23abf@alans-desktop> <CAE2855tGOq2jjqaZUnWJKL953iM6+9JCgkCAEXhKLkkLRdgUBg@mail.gmail.com>
 <20180329143400.6d9256a5@alans-desktop> <CAE2855tmMwbOWDOs-iJS7i35=Y7gt0xun4ApfhZyY9Kr5N3NJA@mail.gmail.com>
 <20180406144713.30d1ca00@alans-desktop>
From: Aaron Durbin <adurbin@chromium.org>
Date: Mon, 9 Apr 2018 10:00:13 -0600
X-Google-Sender-Auth: kTIFRcYnyL5o1NeYeRtSCtkkaBA
Message-ID: <CAE2855vVXr24bOjXvU7pVcDs_X-6G-xndsUf=9jtyXVJS5G6bA@mail.gmail.com>
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

On Fri, Apr 6, 2018 at 7:47 AM, Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>> But we don't have the full ACPI interpreter up in the early part of
>> the kernel. All these 'early' devices have their own setup/config
>> which is the source of the issue. Or maybe I am wrong about the full
>> interpreter and the early drivers are just not taking advantage of the
>> ACPI device binding?
>
> In very early boot with serial console you just have to pray. No change
> there. Once ACPI comes up you however have the information to populate
> everything and configure correctly.
>
> So it should work fine except for kernel hackers trying to do early boot
> debug, which is a small (but important) cornercase ?

Yes, I think we're on the same page. This patch series is trying to
get the early console working correctly given the current code
assumptions.

-Aaron
