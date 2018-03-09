Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520559496-2-17168117752400492683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520559495; b=w1LL3URIGgh7CxLh1W0JOuhTTw9xAOtLX3XE/tnQj88XcdK
    JrgcJIfs1NbaMWtuUfnWtIYif2SJIxAqYOK6S6XM4ekIB1qu9IEshj+qZfmX1eq9
    b9dGoUzlHso4ODdJomjyUUGxwNHdPv2LDnhUX/BpQEtfASCWScullYc54qh0J8PV
    CTUSW4Pn+n4+NRjV7pB9Mz0uJxxjrxnZ80A5x+LdKRoOficMhI6rnvCrJQrHm2UO
    r3ohtQd5jR37sCaT5mSIBwDN/ziswagNlJ1mBkFL8hB1PcJuJ0igIahGavu1baCO
    zYsEvgAIUbt/r3zg1Yu7zb7a87IEqtm31f5xHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520559495; bh=fDHquWwKggiiqtAXxPTkTvrapQdI9MeEH1a8O4
    EKh1w=; b=U0mGbeL4ZC8F6BaLsI1Vil0PieH7d6cpgM7n/rZ/SqHcgu7MGyV4ID
    50R0hdSKB4i6eObUNeZHCTObwDWuP08FoyNQL6pa480XsbsjHbfXQl71kbdja74B
    qox22hTgFFMUGBlTf4VtrmI++vvAWzWnGzrW/83QJ7C3g8zNI+YOjolKIL75Fp33
    7FdZ+VDzZlz+vWE1kqdRCM15aO7dx6wJ+hes3+nhkPoS2St8nIPd0fD+NlUXON7Q
    xqz+7is/869tdr5F4VaO+jjh4/8verYyDzXsyAYCszTKemqtdJHG4YWae8w99NHP
    VwtUk7cs9JKc2S+BABHn9KIi6ZqvkglQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aIY+kf3Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Od3DQ83s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ox6RtQWg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aIY+kf3Z x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Od3DQ83s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Ox6RtQWg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbeCIBiO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 20:38:14 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:37166 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbeCIBiN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 20:38:13 -0500
X-Google-Smtp-Source: AG47ELuELk25ggGAPLazq/W49af+6U3iA4iogxWejIA5uZ54czulbIXPIs0jMbBLoS/kSRGfX9PiSKRxaU4sIoNuNrs=
MIME-Version: 1.0
In-Reply-To: <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org> <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
 <CALCETrX=Vfk1T-XegwnjtUqeEsyUFXH1744d0yGkufQvDA5xkQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Mar 2018 17:38:12 -0800
X-Google-Sender-Auth: _DQgERCMfoeD8rf10_P3zBfM0E4
Message-ID: <CA+55aFwJPDub+tdShCgeTz3UejeskVE7_x+eQLq75mCjYPyP8w@mail.gmail.com>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf binaries
To: Andy Lutomirski <luto@amacapital.net>
Cc: Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 8, 2018 at 4:59 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>
> Also, I don't see how this is any more exploitable than any other
> init_module().

Absolutely. If Kees doesn't trust the files to be loaded, an
executable - even if it's running with root privileges and in the
initns - is still fundamentally weaker than a kernel module.

So I don't understand the security argument AT ALL. It's nonsensical.
The executable loading does all the same security checks that the
module loading does, including the signing check.

And the whole point is that we can now do things with building and
loading a ebpf rule instead of having a full module.

         Linus
