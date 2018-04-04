Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2906851-1522804407-2-7381205993084389494
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522804406; b=ETKQjwn1c/nQSDqJFjpx7bK1zG07FCHtrb5cFhKKvGHmUPu5xq
    xi8XEWWqHEwzZb68tSHvgmYu18jb4TSqEC1WVDid66xY1tqUHFr5cTW/RNI6523h
    V4GZycQQFRutEHncPZ5y7tvw36UA4UUghZI7wKM5harq+kLDX7N/6p2S5/4X1IlW
    3OxrZEYLW2jQLO3GcrMc2EhfGExyaDGLJ9/JPuz0xCUV5i23h5mE1cw/f8+bfy1E
    Ove1RVgPH649vpiehFjj0sjKvqf25Mnl0W7qIl/wjmFklIKCja+xCqlhF2Xv6RMQ
    wuQ/l8FB8WtsAPhU/nGY1cRqWsF4dp6boV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522804406; bh=J2AzXVzFNvRJA14FZqzEQq8bUQrE6XmfTp0os2dlga
    0=; b=KcsQi9axJfZ8s3wLpSEo+Ugm7uHOgdYzoEFWk82/bqA8YosGAN50a+EkMo
    j41ipiTlWHU7clwHTYq1sHvS1MoQwVyEg4bZo6GrQVPChsEce/0VxwRAVuQheKQj
    GNnzQI1LCguqgx3oQwTwIEehZ09j9kTCzNaEJm1yYLkjdUg0rm5yhfhbzNyH6f1h
    /GgUHy5njfvfNJGByBSFb2zoUub2Tf4XKm9IOdRDyMSK0cNuWEpQvf2DBJduwRYl
    LsdkZNAVJ6mph4lBriGgwGXPx1qSY/hAcyNGCKXRDUjtEqSltYdWxxExIWnbHlB0
    ajMSrMpM6oVclX3FfH10jo9Dzm8A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=SDjgmioN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ON91R/P5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=SDjgmioN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ON91R/P5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAepjB45ixMPmDekRuqdHohjxCMFD1/M1NAR47NRc4ozLXdyA1s/A0Q+giBh5R1LfmqHySBxkAhAodfK5jXbzaJA2W5+DaDORnqPNCU7Lc4V3xK1CiMQ
    L25K6hOCgiqE9fLVWdYhsY80SQA8rnDOCmHfUHOIYTJB4UICXrWBTvBNOCMOH5XCxhkK/O5wK5vfBqMWW+ZdEW6VsxxjXQJDQWquNSz/56pc2tVOt97JTQ63
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=iwB4P2d5OmKV7Oa7gz0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755142AbeDDBNZ (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 21:13:25 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:41484 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755133AbeDDBNW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 21:13:22 -0400
X-Google-Smtp-Source: AIpwx4/6u6M3w8/dymvvr+mpmVvR4SsBc9CM8g65D6jQrKJEqMmKxVeaoRizug/OeSYB5xwhB0bO8bVJ+Xr8HtE1uZQ=
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
 <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
 <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com>
 <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com>
 <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com>
 <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com>
 <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com>
 <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com>
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
 <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
 <CA+55aFzJ2sQR13T+20MKEJ5co-f3Ev8rRxQkRCWVaeDSUU3yhQ@mail.gmail.com>
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com> <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
In-Reply-To: <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 01:13:10 +0000
Message-ID: <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 5:56 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 5:46 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> > The generic distros have been shipping this policy for the past 5 years.

> .. so apparently it doesn't actually break things? Why not enable it
> by default then?

Because it does break things, and the documented fix is "Disable Secure
Boot by running mokutil --disable-validation".

> And if "turn off secure boot" really is the accepted - and actuially
> used - workaround for the breakage, then

>     WHY THE HELL DIDN'T YOU START OFF BY EXPLAINING THAT IN THE FIRST
> PLACE WHEN PEOPLE ASKED WHY THE TIE-IN EXISTED?

> Sorry for shouting, but really. We have a thread of just *how* many
> email messages that asked for the explanation for this? All we got was
> incomprehensible and illogical crap explanations.

There are four cases:

Verified Boot off, lockdown off: Status quo in distro and mainline kernels
Verified Boot off, lockdown on: Perception of security improvement that's
trivially circumvented (and so bad)
Verified Boot on, lockdown off: Perception of security improvement that's
trivially circumvented (and so bad), status quo in mainline kernels
Verified Boot on, lockdown on: Security improvement, status quo in distro
kernels

Of these four options, only two make sense. The most common implementation
of Verified Boot on x86 platforms is UEFI Secure Boot, so this patchset
includes an option that (if set) results in the kernel doing the right
thing without user intervention. This makes it easy for a user to switch
between the two states that make sense by running a single command and then
following some prompts on the next reboot. The alternative would be to
provide a signed kernel that always enabled lockdown and an unsigned kernel
that didn't, which would (a) increase load on distributions and (b) force
users to both run mokutil --disable-validation and also install a different
kernel.

I'm sorry if I've appeared tetchy in this discussion - having several of my
coworkers shot has not done wonders for my mood.
