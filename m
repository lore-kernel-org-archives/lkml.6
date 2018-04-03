Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522799942-2-18320735333746468102
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522799942; b=hsd/HqCCVWqNGS9nszOPGUkmzl6QYN9Z8Q301H77olfeBEPoYB
    fls55lspy9cdrmd41dzdUuySxCcDz4GKL+qJ5wwp933ITxY6ibR9LX203Jg8Tdi4
    PHF/fQOnQ6hnV7MvazQLiI5Z+ou9b3IIF7f7IkqEbl99BHmnxyOla8cguEo3Qd34
    t13AdGJc5nZIKzRFNcS8/BYuzU3aPrBBbS5IM2bKfx6iaiPNUtiBawnk1o+gVtbI
    VDDFIrCagQv/OqjenV7VnIUsKvcGRd+DyaQ1r/kCuejtz7D4epk/363oVhCpCzFr
    2cS6jxubszgnQt+NKr9dxm9y0XX6nd4HBu+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522799942; bh=MvvVziEszjXcpm/WVOCt9xO62kTcjD7hb9676mnrpu
    k=; b=RoDiD+wTr2PdkX7zkJAolF0d+xbl2rysKocKjdXE+EM5vwA4C4hsyvdQi9
    80f4qehaVcTUsTGKp4eqJ2e99wXtDdLGtwL1k8mkvVCQBhBDtD8khOP/7THB7nbx
    Aypwg7PKIgtfXkBzHmRmc8Mo2fHowCoGKw3+dF0OMBy028SZVrkb99DkpxZlzbNq
    FOBKPCulpybIRmFH7zkxWgwuEZy5rOFER3KyDvQaQX2GClAt4S9VePk850yGxWEd
    3qk1hQgmYktm138MMKaYiXeO2FOwE8dzxdJ7sqDyeKUgLnC+l0N2Eh1VPTvjDFrG
    R+6ooW2DYzzs8QUTvKmBp6AqyEVQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TwiKmmrE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o5VkQAas x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QwpmkisG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TwiKmmrE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=o5VkQAas x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QwpmkisG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNPgcJsWzvGWa8U+qPA5hMBaA5wb5+jUqWTjvm7sn5wm8Lv7TrsVzgHVv2ueVA7CC3My7WG3O3mU/QiLbq5myvS+aJl2dOwaRWImoxauTF4RLeFFVX5q
    1bnhcZaVu80YVGKBFWbnOh2NSQs1CLbblTJPVA7WdiCJgfkFk85Q4AohccOMMFGA6k5vHAR2RyUcAknxOZGlOfj1+RMReNcViY66aEkzioFYBR6dtN89LFmn
    gmCCMrmHMtPEmPOYOL5esw==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=I98y0XD6Bt_G521KzaQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755866AbeDCX67 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:58:59 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:42809 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeDCX65 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 19:58:57 -0400
X-Google-Smtp-Source: AIpwx48nWRTjoYDSuoGze+jljTc8TB949uCPux8nMjSUvBhFaT0DC0HoeYfgLtFbfBT2F9ncPOd2SQyawJBhs4IuLLE=
MIME-Version: 1.0
In-Reply-To: <11444.1522799762@warthog.procyon.org.uk>
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
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com> <11444.1522799762@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 16:58:55 -0700
X-Google-Sender-Auth: cyyq1T8pU33kVQr3hGhmfEyM2kY
Message-ID: <CA+55aFx8hQRdBp-7Jv=62Acy9vU53shsd09gFXiE-OYN+ynHEA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Matthew Garrett <mjg59@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
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
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:56 PM, David Howells <dhowells@redhat.com> wrote:
=>
> Most users haven't even given this a moment's thought, aren't even aware of
> the issues, don't even know to ask and, for them, it makes no difference.
> They trust their distribution to deal with stuff they don't know about.

Right.

Like perhaps trusting the distribution to just enable all those
security measures _regaredless_ of whether they booted in using secure
boot or not?

See?

If lockdown breaks something, the distro would need to fix it
regardless of secure boot.

So why is the enablement dependent on it again?

I'm not arguing "lockdown shouldn't be on".

I'm arguing "lockdown being on or off has _nothing_ to do with whether
the machine was booted in EFI mode with secure boot or not".

You don't seem to get it.

                Linus
