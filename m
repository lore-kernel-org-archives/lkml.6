Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-682215-1520350439-3-2933538777542981172
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520350439; b=X7GkQwRs4VlR9JTX3fMnOywa+n060PFkfVqstMuZdH///27
    4HMidVpgwmxrMmA5pVVQ49c5cFI6Z1VwDjOsCCHuALDIfrUKRCMdVisDpRuZQgp4
    M6BZNAkUIii3ltYB8XUaAZUo5u+X7EpCQhMhhXO7Ccy1j5By8uyrTBhps+llRnXE
    YuGkWwk7qORYTr60v3hzu32RKyHS1poaNMjK4lMNMm/iKCIngbwTJKer6VCP26Vi
    hyPwq7mS7H1Pt6TFmnNE9nd8BqO3BXg+wuSivFN/HHJe3ExKGfwcLaQriRQY49IO
    StfrcocCl7sHYsi3+38bDSrM+4B7U7oqQzJvchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520350439; bh=c5zStcZ+cmjaLQoclDvKqlQ2rBmclvvOHZhxth
    M/jvQ=; b=CvZIpTnN1j4sskLpobHXObMPM/S1mGfHW/j7ArkHjGXf7AQ/ZOUARO
    7YLidhD7iFO+zqXFIWyxNPWXOhANMBXcGl4nwFliHbJ+T5v0GhkJ4/W9icLgjk40
    YggH1L8BFdpta48Qh1R4nGP53j5tVOk/v5AAX1wskKHhLbDaqLpoARait9u+4Pma
    Q01ZYlhSPtZ7AzMfC7G2NPQkpUgqTavID+gxK2/GMG+SCuWmTEGCh/5W0ZBqTW/I
    DHrIbhxe1u0l2qOLEe1K9LYH6pjQTB/XLsjq3S2xyHd+B2zEz8UrokbGoOnY1iN1
    q0dhlVHWYS37V2OJPxAzLniO0HrQy2iQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hIHYLt+3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=teYTC+jc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=hIHYLt+3 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=teYTC+jc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753713AbeCFPd4 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 10:33:56 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:36153 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753559AbeCFPdz (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 10:33:55 -0500
X-Google-Smtp-Source: AG47ELuVWcBhmz2rhMZvOGroWo2P6GRuAUm+isFsTmliK+Wm8lOVuU8u411W0/4+eZfeFj73e4NK1kAPQJ/WuRKmod0=
MIME-Version: 1.0
In-Reply-To: <20180306142012.GB13586@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com> <20180305102310.GC8588@sirena.org.uk>
 <20180305200744.afw64js6wnmyfqrb@sasha-lappy> <20180305203533.GP8588@sirena.org.uk>
 <CAOiHx=mmwzDeHq7Vsz-C+ButW34-b1HJgEhGManfz3Cs3WRm8w@mail.gmail.com> <20180306142012.GB13586@sirena.org.uk>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 6 Mar 2018 16:33:34 +0100
Message-ID: <CAOiHx=n6yEB8Yq6rDjYKdfos0Ha6=8uLY1H-cwduw62d4nWTtQ@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL for 4.9 002/219] spi/bcm63xx: make spi subsystem
 aware of message size limits
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <Alexander.Levin@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 March 2018 at 15:20, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Mar 06, 2018 at 02:42:43PM +0100, Jonas Gorski wrote:
>> On 5 March 2018 at 21:35, Mark Brown <broonie@kernel.org> wrote:
>
>> > It's exposing more capability information but it's in the "how did this
>> > ever work without the fix" range, and I'd worry that this might cause us
>> > to do something like start exercising handling code in client drivers
>> > that had never been tested.  Not that I can immediately see any client
>> > drivers in mainline that actually pay attention...  :/
>
>> I would assume that most spi client drivers use short messages, so
>> they aren't affected unless the max message size is really short.
>> m25p80 on the other hand will do arbitrarily large transfers/reads, so
>> there it was supported first.
>
> There's a bunch of SPI drivers that do firmware downloads which I'd
> expect to be affected, the limit the device has is tiny so it's
> relatively easy to bump into it.  It's very rare for devices to be so
> limited so unfortunately client drivers don't generally check though.

Well, at least for bcm63xx it's very rare to have something other than
a flash chip, a (broadcom) ethernet switch management interface, or a
SLIC/SLAC attached to the SPI controller. And AFAICT of these three
only the flash chip uses large SPI transfers. Furthermore, unless you
have a development board, you won't be able to attach anything
different to it. So the chance to bump into the limits with other
drivers is rather low.

I would assume that this is true for most systems with a limited SPI
controller. I would hope that most board designers are sensible enough
to not add devices that won't work ;-)


Regards
Jonas
