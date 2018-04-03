Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2706406-1522798004-2-1799107886717700894
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522798004; b=hESORaEp8eed/5VMm97N6cQz6sSg3Rl/eDt2sZddtQf41Wj0ol
    DzTHDXAnBXDDg9KWCBdR+p7LrIMtMLxH+4FgOugo/JH4LRTYa8WFGa9gvmfKhaZx
    5WaM4JiA04/OoNYq7GCl5hQtdKPxevSHxRmJm5XTg2+hxnZir7BoM9oR5R3Vm7ia
    9dP5dqi8tn1P8axTCmE2Mbl6yrxSik3bx6hG34qyE5d6e0vFDVo9r7NSMIoO/UKh
    a1H+0tEybdkJXrky/x4NShxIeKXEE/lqyO14sdjZniPqNE55tL/ORWXrK8+cAw6P
    5JrMRTAFe68eW2JabMjoi2BIt1w/tjD2hPIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522798004; bh=Z08NnNsuY6N79JfJeJVDw66o6Lvn3qDWUcRfms9DeA
    U=; b=Cu27keTnPse4UWfbbxNYmteB9UfGy4m5Xtt7WFhjLhmF9OOq2AgHc0i9Rk
    JuvHY8gff0HmarJu5pv+AhYUlfEFu8ds09w5eZu5T5yq0Z3CAVHRlEtiyhDnRSci
    zzg7H4jVevKS+5j2NsLUka2TvL1DsXouobxz/8PsZeeFNCsg9uFxUEOXgonlfo0e
    czS/kGLLNciAKvpupTURs2iiM4k1HaAN8efMfUPqOc6aNkSIeeWseh0xPQt/VYAB
    eKi7q4DiA47xkmGZ91kaLAJKUjVQQMlBB8gG3f9fkcC+sTXWv5tSZLNfV9zpYIaY
    d8i2YcpDccP/R74TFlRU/kpGvdFw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AvEteLw5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DohRjtmh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TurnXNvB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AvEteLw5 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=DohRjtmh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TurnXNvB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHA3uqW8jyazbY8qI13sMHEpZSetDiuEH7sLbZpqqTSIbybssP8AlKWuK2OLqiQ8uXHps7ZwnyZgSzVRJVNMwCDJtqqMyGzwW1upSGq3iKzv13GDOWkw
    eIc4cqVSKGNEpjgBvit93JIS65GEaMHGJhY8waZo1arS8NUwavZeTQGpq9HQX0M6j8oE5QxwxnvDvVJi5qmuYJCm7gkmjOTrth7RRhpQu2fihm6Ub2AjMp8K
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=NkYMiJ6Qy07zk7IcXbcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753773AbeDCX0j (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:26:39 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55979 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753630AbeDCX0h (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 19:26:37 -0400
X-Google-Smtp-Source: AIpwx49efh5ZJrgSsINUn1L1fD7vkesGrjWh+XXfw5/RiZIXLA2TRIz5ArCD0nPraHwNT8mAywk8TRML3CisjOPGdqY=
MIME-Version: 1.0
In-Reply-To: <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
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
 <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com> <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 16:26:36 -0700
X-Google-Sender-Auth: vkz5STVF3MWBjoVOfISfa3rkUD0
Message-ID: <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 4:17 PM, Matthew Garrett <mjg59@google.com> wrote:
>
> 1) Secure Boot is intended to permit the construction of a boot chain that
> only runs ring 0 code that the user considers trustworthy

No.

That may be *one* intention, for some people.

It's not an a-priori one for the actual user.

> 2) Allowing arbitrary user code to run in ring 0 without affirmative
> consent on the part of the user is therefore incompatible with the goals of
> Secure Boot

Again, that has absolutely zero relevance.

Those goals are not the *users* goals.

Be honest now. It wasn't generally users who clamored for it.

If the user actually wanted it, and is asking for it, he can enable
it. Independently of secure boot, which the user generally has little
control over.

> 3) This patchset provides a mechanism to alter the behaviour of the kernel
> such that it is significantly more difficult for arbitrary user code to run
> in ring 0 without affirmative user consent

That difficulty already exists, the new thing isn't somehow related to
that at all.

Look at our "uyou can only load modules if you're root" rules. Or the
"you can only load modules if they are signed".

See a pattern there? They don't magically enable themselves (or
disable themselves) depending on whether you booted with secure boot
or not.

Yet they are a HELL OF A LOT MORE IMPORTANT than this new patch series.

> 4) Providing a mechanism for automatically enabling this behaviour when
> running in a context that is intended to restrict access to ring 0 is a
> rational thing to do, because otherwise it is difficult to achieve the
> objective in (1)

No. See why it's *NOT* rational, as explained already several times.

Magically changing kernel behavior depending on some subtle and often
unintentional bootup behavior detail is completely idiotic.

It would be idiotic if it was that "check kernel module signatures"
check. This is no less idiotic.

Seriously, listen to your own arguments. If they don't make sense for
checking kernel module signatures, why the hell would they make sense
for something like lockdown.

THE TWO THINGS ARE ENTIRELY INDEPENDENT.

I'm done with you. You're not listening, and you're repeating bogus
arguments that make no sense.

No way in hell will I merge anything like this.

                Linus
