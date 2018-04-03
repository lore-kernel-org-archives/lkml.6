Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522789749-2-13464936386442909168
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522789749; b=KsVVGvpmpYV9U6NXm9+r/TmvyP9D/hvI8Io1bzO/zNcngQAGsy
    e6AocPN0ZtOIB9Gqhv14QBDrrolT4YLBma0/+C8u/LPiSrseGa2UOyLJ1MFFOAVU
    bFgH3vESjymhb9CNm4CaBEgmnxzqD3wBr/tP4skejEfm1klEkW5MZEtotPefyEMn
    I8UFRGdfoJkb6sEGxNjOEYSZ5LEgFkIkb7/2roKkmMXGw0hrpNWKksalCgJS88Tx
    7Gxd2knHRgMM26DDmt+dzvmuUTZ0+NFAnEenZiqp/lu1QaHLRY5n1jPQuZBf5Lud
    34aiTTqhHd1VXH6aoA1RrKhVO4neG8nQY6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522789749; bh=Kfd2VjrN95gxC92qecmz9aM4F9HJ5NrhOsUD22S3Wj
    k=; b=S0wODO8dFmvsFRebjQDh35HIi5G3PGzm3hg3dxyp2BFjMzmIn9mwbOAtCV
    FGD9IWMdRqkOyk1tbiUzcjDWQEyNUFkgKQgSBlsjR5quTtkRSXBjS5hLHSUQwddb
    hnOrNIdswsf/ULzCvOlxW9lrud/qF1EbQ2/UZVwfPYjSRc1+4W2W+0bcfDmcRhfk
    4lwKFjMNKI2R8d2kEI8SLbhGYWWWrAPZAcGY1+h43L/H58A7WeCoqJmfWmjTN5Ie
    4QsQ786yueMZc1mZV78CnyTQ1nbVHxXyu/rp9OHhJ9qf0NJaytFmH9UwN3hFL0bT
    STljsxPvjQlpbQppbZGQpEyESZLg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=rYLZlXfu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WDrBPk35;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=rYLZlXfu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=WDrBPk35;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC43t8sBcqnRn+6tBmOqqUE3QqC3I8oLJCgcuAM5x9itoMqSZHqXba4AScy6mhykZjsp2o6EcvtRu2bO8EqIHksljuBjgwR9/5betkU4Fbp+og/yNmcj
    Y5Ofwh3jIAcRwGjJVu21Ii98XTn7VmTxuJAFn0CZM1UYVRIPUn5g1IRPtsAiaSGnFl9sZdw1dtKA9UCN9g267o0j+9Y2rdXv12rh021xuREo2vr5LG4lGWVI
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=7PaVzum-VYpEuETboU0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752650AbeDCVJI (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 17:09:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:46792 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeDCVJG (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 17:09:06 -0400
X-Google-Smtp-Source: AIpwx49S/1FUA1JVjw9tHS83zaRwC4ZH9hXS++0MKeWO8qrBSYZUZwCHSe4Z02u+x4rMlIdqP/psu5kg/ACz0RSHieg=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
 <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com> <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
In-Reply-To: <CA+55aFzGFZT68ih446DeQbB69Fyk_wT6b7PGq0iz-gctUGQq_A@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 21:08:54 +0000
Message-ID: <CACdnJuvheCbuvTLyDWMQWcUytc4EvuSUaEKywfEX8Kp6qYL9dg@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: luto@kernel.org, David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 2:01 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 1:54 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> >> .. maybe you don't *want* secure boot, but it's been pushed in your
> >> face by people with an agenda?
> >
> > Then turn it off, or build a self-signed kernel that doesn't do this?

> Umm. So you asked a question, and then when you got an answer you said
> "don't do that then".

> The fact is, some hardware pushes secure boot pretty hard. That has
> *nothing* to do with some "lockdown" mode.

Secure Boot ensures that the firmware will only load signed bootloaders. If
a signed bootloader loads a kernel that's effectively an unsigned
bootloader, there's no point in using Secure Boot - you should just turn it
off instead, because it's not giving you any meaningful security. Andy's
example gives a scenario where by constraining your *userland* sufficiently
you can get close to having the same guarantees, but that involves you
having a read-only filesystem and takes you even further away from having a
general purpose computer.

If you don't want Secure Boot, turn it off. If you want Secure Boot, use a
kernel that behaves in a way that actually increases your security.
