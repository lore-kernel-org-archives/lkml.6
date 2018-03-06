Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-343908-1520343789-2-1252197919010050888
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
    t=1520343788; b=kL9pqRVj77c3JIZF2CPjllc2TItgtwC/lHz3EFCFTFOzoC2
    Ob/xSd1XoSnnz0W3iN9hK56ol76SuuJYzemylumvFNmumuK5uKpzQDe2hvUA+KPx
    bRsM7QjJsEgWXVXLW8/6SwhF4hDxSIdvgsGsReYRksNBIs3qO2p0PHe0C+Y4GD84
    sLZUAPlvgc8UeqeO514JezkydLHDqJU2OzAPYkMfZ7R+0fP+27L+C1yP9UiLfQwz
    yF8E8B9iw0P5ArWFiu8kQP1KkHeW2rbs+/XK6ruGy3hcmLRzC6IfSJRxHd6llvCP
    +90jYtmnLO6ZUkBRVlSlOXyueGJ5UAtHo7oljTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520343788; bh=eM8BHotGNza2PPF+scPVaZxypmaxM9rkgAVbap
    T78xQ=; b=ujK7gbTVJIiRrdzV50tokPHfNWFZGYQPKboTwg0OLfXViIEm96hDr2
    9Lmr81BUp1r1UiIQqiHonZ5kG3AgW7ZxHjIg7+658mS6h6e2ERdFKk0PgC3WLByo
    cPQm9nkx+AdwWpXAW3lB3ek2WiTbQHEprax7hf/tlzayGYxSlOlotUTKmDsmZsUC
    t3Nn2HS2uJf0z8S0AVOwDpz9/T17DNyX5ncxXVCLNOdYTmk1f0I2vn/5RWIwrPkH
    RfP9emMA766Ge9Xt4GTK6VtMt7QCwSwtOSiICoTPh3qF7s7FyRD/rfGldWrvNEPL
    ArLCPiWrBzbuK1oaBaPZLTsTT/NjQViA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A6iNQIAN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ilzPwHkI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=A6iNQIAN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ilzPwHkI;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753024AbeCFNnF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 08:43:05 -0500
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36523 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCFNnE (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 08:43:04 -0500
X-Google-Smtp-Source: AG47ELt5tdKq+JPVl38mo02ZuKttKhFInKkxpQxgQlrMBbv659+qknIYksB5eRySdwihY7ZsGg+vXJoPYGQYxyZQd2I=
MIME-Version: 1.0
In-Reply-To: <20180305203533.GP8588@sirena.org.uk>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
 <20180303222716.26640-2-alexander.levin@microsoft.com> <20180305102310.GC8588@sirena.org.uk>
 <20180305200744.afw64js6wnmyfqrb@sasha-lappy> <20180305203533.GP8588@sirena.org.uk>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 6 Mar 2018 14:42:43 +0100
Message-ID: <CAOiHx=mmwzDeHq7Vsz-C+ButW34-b1HJgEhGManfz3Cs3WRm8w@mail.gmail.com>
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

On 5 March 2018 at 21:35, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Mar 05, 2018 at 08:07:46PM +0000, Sasha Levin wrote:
>> On Mon, Mar 05, 2018 at 10:23:10AM +0000, Mark Brown wrote:
>> >On Sat, Mar 03, 2018 at 10:27:56PM +0000, Sasha Levin wrote:
>
>> >> The bcm63xx SPI controller does not allow manual control of the CS
>> >> lines and will toggle it automatically before and after sending data,
>> >> so we are limited to messages that fit in the FIFO buffer. Since the CS
>> >> lines aren't available as GPIOs either, we will need to make slave
>> >> drivers aware of this limitation so they can handle them accordingly.
>
>> >This seems really aggressive for stable...
>
>> Why so?
>
> It's exposing more capability information but it's in the "how did this
> ever work without the fix" range, and I'd worry that this might cause us
> to do something like start exercising handling code in client drivers
> that had never been tested.  Not that I can immediately see any client
> drivers in mainline that actually pay attention...  :/

I would assume that most spi client drivers use short messages, so
they aren't affected unless the max message size is really short.
m25p80 on the other hand will do arbitrarily large transfers/reads, so
there it was supported first.

m25p80 supports max_transfer_size since 4,9, and max_message_size
since 4.11 with commit 9e276de6a367cde07c1a63522152985d4e5cca8b. So
that one would need to be backported as well for the max_message_size
being actually meaningful.

tinydrm-helpers also observes max_transfers_size since 4.11 with
commit 9f69eb5c36a644571cca6b2f8dc5f6a7cba04a8b where it was added,
but since this is a larger commit and not just a "bugfix" one, this
doesn't seem like a candidate for backporting.


Regards
Jonas
