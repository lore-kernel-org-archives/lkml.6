Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2706406-1522798793-2-14889603815907355516
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522798793; b=w1LuaA3bcvzQJqNL4NQuV7FKWE4Aw0ogwqVMhk1u1AGdiEQ9oF
    GtG0xhzRmerPSHLNWYCAzN5dCmxSkz9Uf17yHvXn9P4u4FdpQWOY24hD/xBTYyr0
    WCZ0qaasUSuMnyYBOQnJlvw+hyjXKrkwY+idx0vEm6ZxIYiaMRFJV93CQF3wETdB
    XLEGkL7l0R8HP5IrU6Dn1aVaHI47ZLYk1HPcutp7OojNm3VQiRZkpZrtUEhrwbKy
    0BnNp23tVMNuB2R4BzCIeBTf/DdOFhvsVGcOKbH9mtmN0k2KeTAUwoW/jarW+tzD
    Lf5E8y0emMSeCnRv8Sirm2m9fNzZyKIIFnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522798793; bh=+CvO/FV34kaks7NngMCxFh8J0LiJA9byqmpWCacjD2
    U=; b=RQO9+6qtnF4F93Dh7RScElVMwYZcYtjaIlNwvu2N+QZjxmtoYXWSH0S/OX
    kJAox48nfTSYz9govlRw3z9CUS0fcHdxv8MuCC06aPh4RkeeUqISPeoIZKVIxg5O
    GEFkC9VUMXtnShdwaiQPcwn5/WqZlIk+phDFXsRIvwstPaag/mHIs+Mvgdb5fGSk
    e5m8EuFGCJu/ICofyL8afAh9Bdpa/zHUCqslgE2nuftkCJOIn5VtvUFu5IHk09sg
    pcF6T6AT/JF9WDuHQjEt3QDjlU7NZVzWuJHFta9lFJtzVdIHmb6M76MmoL5ynfO5
    Mk9Z8XEmH0QPIal2i1YMsmU7EUAw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TLAPg/h9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PeWLzYkS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mlt0z+v7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TLAPg/h9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=PeWLzYkS x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mlt0z+v7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMwmk6qXOe+a81F7tfT+3Wm+50sz3OWgp372tWr6AZ9CsIqxJTGFhD3qPYrhpe9SFwzP6gPgf5NY/wyIm5XfCBgjPTTmpJ6WwJAAjWN3rl1Nw/a4jVAJ
    YnBokGdM3dODdt9QpFmKTtmTRMC/lRUCf86UpjVGA66fXVirZoFfR3FJfN36imw6O7X54+bcQnFQ3s7PHPLliMy0kNvoSTmMogJVzsKmztrZU2cNh1m96n13
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=rOtgyZGRsC0FuDTWkdEA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755318AbeDCXjw (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:39:52 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50789 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755316AbeDCXju (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 19:39:50 -0400
X-Google-Smtp-Source: AIpwx4/3QQXLS8s+SBh97SrmxWyZM0u0gkOvaG+P2TchjP7ier51ervAeHbH6Vs/4/eX09eqe8ezQAoDbbHm10vldrc=
MIME-Version: 1.0
In-Reply-To: <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com>
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com>
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com> <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 16:39:48 -0700
X-Google-Sender-Auth: rxzU67W-LJH4ldvOMOwabcBURoo
Message-ID: <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:26 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Magically changing kernel behavior depending on some subtle and often
> unintentional bootup behavior detail is completely idiotic.

Another way of looking at this: if lockdown is a good idea to enable
when you booted using secure boot, then why isn't it a good idea when
you *didn't* boot using secure boot?

That's the flip side of this whole argument.

People who boot without secure boot may be wanting all the same
protections. Maybe you have to disable it when you build your own
kernel, for example. Does that suddenly mean that lockdown is now a
bad idea?

And if it does, explain it. Explain why it's a bad idea to enable
without secure boot, but is a good idea to enable *with* secure boot.

In other words: explain the tie-in.

Because I really don't see it. All I see is illogical blathering that
tries to conflate issues that have nothing to do with each other.

Please explain to me why a distro or a user would want lockdown to be
disabled just because the user didn't use secure boot, but suddenly if
it's booted on another machine, it's not just a good idea, but
mandatory in your world view?

Honestly, if I were a distro maintainer, the *last* thing I'd want is
the kernel to act fundamentally differently in some security context
depending on some random bootup condition.

              Linus
