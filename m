Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751240-1522799179-2-14771525378824815218
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522799179; b=iPxs/9hZQ6S0VBAOF63hp00lZia1lkU7oGwkZ9DleiJu0Ok/LQ
    tpjsKZMFaIvWNMpFv5eqHV+8zWiy8GfhF6c5NTReOQYthrmW7308quV6XspInS03
    S+Bh1T7M5wzX6LegrdOB2vWGr6+e4hAsavGrqxNhqF+If8lBpZqL+2zSA0vfR0y+
    Q102Hpb3Gc5rcIsdwdQxaf7oS+GqdPvzbu0J4dys1l95iidK0G3WvN7Q6fQEEieQ
    Hx8BocEmSxC5+vqO/DjPKLwS9B7tYWp/asUQprZwXzIXwCO+GIR5tylLUIaVw1UU
    jv1t1rc0hazZD7U33qoxicguWOeIuf+JxnwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522799179; bh=0KEvt76jyOvIoxYowX3M2YdjlUgzmSbbIfdF01keQu
    A=; b=UxKHSfesO2nyz9G5xnPdaNz45hh8JZ6io2qthfiCkEBaaZ6jAiLCSUuWIx
    TCfB22YcQbWmdmdfc94Th/LHERYgmxJ0/90/5FbaJCjIMR2XkyJYoRndI3bcCVTq
    ZDoAOOMYu59G63ZzdupWPBv3ZSQk8OkXK0f8iZREwsaH86zFz+U3MHJdxoayY2FX
    2LQOJ4jY5Lkall/O9ba0VoZW4ZaAzEmRA3Gy2YAln3Yp3Vb4edugD9EfjpSjS9Mi
    DP6P3mt9rdi2T/WT2xjbt7g5CcM8eNVoN0/94LdVkPf1dh0elLLdnzh7VjznUusC
    eT43D8tgJ0nvPQE+oPMYeSP5ix3w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=iwlMqa6+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W3IKYpkX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=iwlMqa6+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=W3IKYpkX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBDlVFG8KujtHgv+WP55U6IfEAYw4DKzqzso0HuzOnGT10IuOcOtSLSkFwjIqYXIY8LduAs9afYblzXLxGgPvk2elwCgFVjjw6XtRY4YJTdfR7tOpTwN
    GtHGq+Ac+nWqPQAHuk9ON/tq1/kryOII9TVr3qB+fCEH3hMuy4QzSTpT/0hid+akTL2g/asuKaer2NTQbI+I+VQZhldLf5anEJPZZzjN/MqMTWOxNzQ4LzOp
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=sRSyjSlltIdbRpipBvoA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753639AbeDCXqE (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:46:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53458 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755125AbeDCXqC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 19:46:02 -0400
X-Google-Smtp-Source: AIpwx4/kWOFEJ7bZU+KBCfqUFlMt5YPZHsHhGElhtrd6kprqHwdPHJnMRw1bgIkcCa0aSn9WuiAyFP+qLJkVYfXUgwU=
MIME-Version: 1.0
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
In-Reply-To: <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 23:45:50 +0000
Message-ID: <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 4:26 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 4:17 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> > 1) Secure Boot is intended to permit the construction of a boot chain
that
> > only runs ring 0 code that the user considers trustworthy

> No.

> That may be *one* intention, for some people.

> It's not an a-priori one for the actual user.

Secure Boot is intended to *permit* that. Without Secure Boot you're unable
to do that. Some users want that. Some users don't.

> > 2) Allowing arbitrary user code to run in ring 0 without affirmative
> > consent on the part of the user is therefore incompatible with the
goals of
> > Secure Boot

> Again, that has absolutely zero relevance.

> Those goals are not the *users* goals.

> Be honest now. It wasn't generally users who clamored for it.

If you ask a user whether they want a system that lets an attacker replace
their kernel or one that doesn't, what do you think their answer is likely
to be?

> If the user actually wanted it, and is asking for it, he can enable
> it. Independently of secure boot, which the user generally has little
> control over.

How? If the bootloader will boot kernels that don't impose this restriction
then an attacker just replaces whatever's enabling that feature. And, uh,
seriously, I've been asking for *years* for someone to point me at a PC on
the market that doesn't give the user control over Secure Boot, but Shim
was expressly designed to ensure that the user would have the ability to
enroll additional trusted keys (or disable signature validation entirely),
so which cases are you thinking of where the user doesn't have control?

> > 3) This patchset provides a mechanism to alter the behaviour of the
kernel
> > such that it is significantly more difficult for arbitrary user code to
run
> > in ring 0 without affirmative user consent

> That difficulty already exists, the new thing isn't somehow related to
> that at all.

> Look at our "uyou can only load modules if you're root" rules. Or the
> "you can only load modules if they are signed".

> See a pattern there? They don't magically enable themselves (or
> disable themselves) depending on whether you booted with secure boot
> or not.

What's the benefit of "You can only load modules if they are signed" if
root is able to just overwrite that policy bit in the kernel? The split
between unprivileged users and root is real, but right now module
signatures are theater - there's no significant security benefit from them.
But the reason to tie this to Secure Boot is that without that an attacker
who has root can just replace the kernel on disk (or patch the bootloader
to live-patch the kernel on boot, and yes that's an attack we've seen in
the real world), so while it's a feature that is arguably beneficial under
all circumstances it's a feature that only has significant benefit if you
have some way to actually validate what you're booting in the first place.

> > 4) Providing a mechanism for automatically enabling this behaviour when
> > running in a context that is intended to restrict access to ring 0 is a
> > rational thing to do, because otherwise it is difficult to achieve the
> > objective in (1)

> No. See why it's *NOT* rational, as explained already several times.

> Magically changing kernel behavior depending on some subtle and often
> unintentional bootup behavior detail is completely idiotic.

> It would be idiotic if it was that "check kernel module signatures"
> check. This is no less idiotic.

> Seriously, listen to your own arguments. If they don't make sense for
> checking kernel module signatures, why the hell would they make sense
> for something like lockdown.

> THE TWO THINGS ARE ENTIRELY INDEPENDENT.

Again, what is your proposed mechanism for ensuring that off the shelf
systems can be configured in a way that makes this possible?
