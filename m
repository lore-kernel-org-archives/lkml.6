Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1841884-1518710412-2-8042826315697802077
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518710411; b=P4D4TCMRPCiujAdPK2EZqJvQjtei1sGCeCkXu8Lnh+rkU29
    NcP5vvMghfSBauCR4t9Y44yHffUsbeMqJYrnhNkHm5HtMfXyVHjA4yzTqHMPSwwL
    OkzvGrFzRM1EPwITN02rQCWPX96y6GIfzMJZy1stoG6RejsOa0uCwqpHTQp15JKw
    GfsQJ7y72RHbTUSa0ckwslo0TmnGs0Z6dkB5z9zUJ0jShvrKUKvkuQaqh6YPE90y
    Y0lsMgFr0iaaR/15ckxLM9dtreaBd8oXesRUkLdN99JbrNAN2JbIUoItyDzkz4Cp
    VpRSd4XCwp2qLqhQxJ57OOOvKeuwFcJtC4NiK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518710411; bh=R8nmvt6KPec94lBE74Z/ffkenW4o7FRfRlZBU0
    C7cJo=; b=L/J57YK7AmiBqNl37qHMwwbVO3u45UsUDMN8hExZiuvB6NhksDwQsY
    DjOVX8p416xPYnsDmiLAeZy+P1bkMjh2qTQRCb62VJW8B1UuAEYGxQQ+Pjp4iwGH
    6Hn2kje3NazpfGILqMiZp8JykNIZnjmtWEwGWiiO8NJ5j0ciotPHjomTrym0O2cq
    bnbq3St+JwAavfHb8ZL3EBEoYCIDH+dmKj3xlEBE48OcrAJY4gOMGHy4vBxfqFg8
    fCZk7v+AIXrq3Q/akvkWrum/m2ZmUpLbDDTBwXC1fvS89hQMKHMBtKnFNnva3p80
    u+khpM5ka2M6D4YRPJ6UrKkohmQ3eA9A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=igKBh5TK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GSWqJ4R0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=igKBh5TK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GSWqJ4R0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424849AbeBOP7y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 10:59:54 -0500
Received: from mail-oi0-f48.google.com ([209.85.218.48]:38997 "EHLO
        mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424749AbeBOP7w (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 10:59:52 -0500
X-Google-Smtp-Source: AH8x224Vew4yEac6CX6eAYpH+0G3DxXbj+xNCx1IUvXXnkoGHTXJmJdY8h4Dp9bEGtTF/sksWO+0VywVTiY+462oF2I=
MIME-Version: 1.0
In-Reply-To: <20180215152521.eoz6mhgw22ekyaev@treble>
References: <CAK8P3a32XycubV_d8JpxLAD3LEB7LBdhMAgTfqsWpPNbmzok3g@mail.gmail.com>
 <20180214222412.arg77l6vjpkje6pj@treble> <20180214224525.esxiqt7yjjjpzyz4@treble>
 <CAK8P3a1Q8O7=Wt71RkB0hqZA1dPGZMaBxVwyrx0+d2pPsDb8gQ@mail.gmail.com> <20180215152521.eoz6mhgw22ekyaev@treble>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Feb 2018 16:59:50 +0100
X-Google-Sender-Auth: 5af7MaOb75C7ZPVpUkXymxpq0ys
Message-ID: <CAK8P3a1WVDLW=m0wUtsoiGjYHqvD9PpEea7n8tfbEy1A=8Ougw@mail.gmail.com>
Subject: Re: objtool warnings on 4.14-stable/gcc-7.3.0
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 4:25 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Feb 15, 2018 at 04:01:57PM +0100, Arnd Bergmann wrote:
>> On Wed, Feb 14, 2018 at 11:45 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > On Wed, Feb 14, 2018 at 04:24:12PM -0600, Josh Poimboeuf wrote:
>> >> On Wed, Feb 14, 2018 at 04:11:15PM +0100, Arnd Bergmann wrote:

> Ok, I expected something like that.  GCC "undefined behavior" strikes
> again.
>
> Kees, I suppose you'll need to obfuscate the code to stay one step ahead
> of GCC.
>
> While this may be an objtool bug, I might not fix it because it served a
> useful purpose here in finding GCC crap.
>
>> I would have expected an actual NULL pointer dereference to remain
>> in the function though, or at least another trapping instruction.
>>
>> >  Can you share the config for this one?
>>
>> https://pastebin.com/qFV6SPWP
>
> Would be interesting to analyze that config to understand what options
> are causing GCC to do that.  I don't see this "optimization" with my
> config.

This seems like a very rare combination, the flags I need to reproduce are
"gcc -O2 -mno-red-zone  -mpreferred-stack-boundary=3 -march=nocona",
however I do see the same behavior with every gcc version since 4.8!

Aside from -march=nocona, also bonnell, atom, silvermont, slm, and knl
show this, but none of the modern microarchitectures do.

        Arnd
