Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522859270-2-10385362908019429973
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522859270; b=BcuFLoZTPLHwIHSk+26hQUgO1TmAgT4j/VVL/CwIlplN7ZD4JV
    S7ng5gdsyo58kTdttvCnVDqETSIE01T4uUHsJfaSpPWfV/80KjK6kkxlpegjjKDs
    34FFrZ/IJuDAMIKRzBED34NYC7/cLxkk9rpWPP4d5VVSaXg0BTyZP/HJ1nOVLZ8Q
    R+YUrQjX8v7QmqvqCLYwUhBgtj002pwVRZOEb8jj9mDHvaqg1YOvC/tF0R9J9V1j
    YIwazQN8JfV0sRFaN7b5kt2j4K2tnsZdGV1hW74X+WZApchtOj5vNad+sZA3Bg9L
    kvtUY/8n+sQaGMk4zyb1i1nj/ww33etptYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522859270; bh=3T+RCnWjmaSSlNxtS+jEJaGo8nawrucWvKmfvJHMqI
    M=; b=IQeERCHBgtca2ONi0rlZyoCjdrUAovCWRZvhJLJvJycHvp17CzPJSWiIKU
    lNn5aeI0lDYZNO7o2Mzdo4Rk8OckdWJtWjBQIzAQiB7nCXH2YB3MjCq3Gzee70dp
    IqrihuS7NqJiSayO0cRIVhcqM+oL8+/S6G4Gihi94mGG0Qn7t+yhPEAwsWnVRBTe
    TSVH6iKBdH6qULwK6kihwvp0ci67sr8bkU8i9d+XQ9SRYU+VXURYvTFpO1i0Rs4H
    hfKZ8jJlnHzKqXDyJwfW+mVWLoM+2AEZSCzQgJ+8IgbgXkkhp5o015JJD8RBKESU
    iB2k4wG9k5cSxh05F0favHgQbYBA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=CmDcEIMz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BbUWxEFY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=CmDcEIMz x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BbUWxEFY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG1UwJoTwRTzTtQmshLEif6ZicByij9CZ0zLiuCY+mPU4PGeVPVW7WhiqGqMDEVjjgN/vjRl0ZTXWyNQl6gDRh9VOYsXrpdmnA45b2EV0E2+4iTsb9dB
    yT4wUKaQ24Nhh2RfJdBe5qe3k6ZlHTPscpYO/lD8kXbduBO2Wqq7aq5NdU6pQ/1tCvuU5fn2FBtyYJMHoGKQHv5L9U5kSE8wqQrJoaa0CCGydCuaYR54qMtL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=Hnm2Hy9fAAAA:8 a=VwQbUJbxAAAA:8
    a=GWAosDmGulpdkMD96qgA:9 a=QEXdDO2ut3YA:10 a=179r5xe0yFUA:10 a=x8gzFH9gYPwA:10
    a=5NXnnWeYSB0A:10 a=qByqzKpv1oajCkFmDuv_:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeDDQ05 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:26:57 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44323 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751772AbeDDQ0z (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:26:55 -0400
X-Google-Smtp-Source: AIpwx4/WnmWQwub2h+r+iLHsc4ncR3q9mdsXoLnZRhjNkxJSbfWgP0fyXgil5mUyrhcSsOqGklRgGELEsdClVtS1d0w=
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
 <CACdnJuti5Riqoi1sesqPALYHq9LT87o4MFj-0Y5BZqqzJ5579g@mail.gmail.com>
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com> <CANA3KFXyUH4cEJVTH-yoTwqAnZ+-9h-uboYTzO642Uo78H_wqg@mail.gmail.com>
In-Reply-To: <CANA3KFXyUH4cEJVTH-yoTwqAnZ+-9h-uboYTzO642Uo78H_wqg@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 16:26:43 +0000
Message-ID: <CACdnJuuXgpnkMw8oacgadJQL5nE897cw3-RZBqV7df+19NuiMQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: oiaohm@gmail.com
Cc: Linus Torvalds <torvalds@linux-foundation.org>, luto@kernel.org,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>, jmorris@namei.org,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org, jlee@suse.com,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-api@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 11:56 PM Peter Dolding <oiaohm@gmail.com> wrote:
> On Wed, Apr 4, 2018 at 11:13 AM, Matthew Garrett <mjg59@google.com> wrote:

> > There are four cases:
> >
> > Verified Boot off, lockdown off: Status quo in distro and mainline
kernels
> > Verified Boot off, lockdown on: Perception of security improvement
that's
> > trivially circumvented (and so bad)
> > Verified Boot on, lockdown off: Perception of security improvement
that's
> > trivially circumvented (and so bad), status quo in mainline kernels
> > Verified Boot on, lockdown on: Security improvement, status quo in
distro
> > kernels
> >
> > Of these four options, only two make sense. The most common
implementation
> > of Verified Boot on x86 platforms is UEFI Secure Boot,

> Stop right there.   Verified boot does not have to be UEFI secureboot.
>    You could be using a uboot verified boot or
> https://www.coreboot.org/git-docs/Intel/vboot.html  google vboot.
> Neither of these provide flags to kernel to say they have been
> performed.

They can be modified to set the appropriate bit in the bootparams - the
reason we can't do that in the UEFI case is that Linux can be built as a
UEFI binary that the firmware execute directly, and so the firmware has no
way to set that flag.

> Now Verified Boot on, lockdown off.   Insanely this can be required in
> diagnostic on some embedded platform because EFI secureboot does not
> have a off switch.    These are platforms where they don't boot if
> they don't have a PK and KEK set installed.  Yes some of these is jtag
> the PK and KEK set in.

> The fact that this Verified Boot on, lockdown off causes trouble
> points to a clear problem.   User owns the hardware they should have
> the right to defeat secureboot if they wish to.

Which is why Shim allows you to disable validation if you prove physical
user presence.
