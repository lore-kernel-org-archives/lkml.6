Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522800305-2-4430933410888125011
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522800305; b=rVh5/XjX6Fb6MtqeubMbPtHF0WP2SdxUiE77T9+/fdaeeebnLl
    oT+1GtfPgF5nDE05NlEZjUB44myX08GJ/90xmF+0KsGWUq/MlaF/QfOassfAB7tI
    atRTpB8u8fcQPbfr+C8Gd1qEYINTGOmvOP10deCD8joOvcLbnA0JqlzdoP/o2Ve1
    fdgStdYGxBAzBRh0i8LPhi++k/IvdbgOtfY84uhI6DgDl5uGZ1xlBvz/YHZTfsLA
    54m1NGZrIJeoTGNG0Ei5RrZvSMsDSG3jW4aRYP+XPZE5kGxvz0n0Yut9DyyJ+GFI
    2iyON6aNxxI8nG2DN2GHi1Owg/MmNIitTMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522800305; bh=Ph6hLpjYcCrqn/Jkh1Cp7fa9Jl4zn53mUpY09zhJMa
    A=; b=T1qFxxO/KBwFfp54iUJtCQKExrR4hvvXu1uND4TP3Lv3cz4CstP85yZb/5
    WhHStO4UAgXZ09hxWsoupGD0GWGnPFD+ipvj6qdnLG+f4oBH3InM3E92GaEB0huF
    kOmC6wr6dhBr23yTfuRnpX1I4iyXrW0GSelJpUm2ea9JUeqEnpmzP7yF5z/l0ZjZ
    MTuG4wqoCWzWQ+aFJ3Pp+MoizoqDjB9gbeLwi9iuqoolimZYDBQagrcYzytxKQb9
    AzlRC9bycN4tbP8YhLWPQEgMnMZw04nDJATF13KSOmfni4fy5LPr9oWmpU3+gO/H
    eHjue50VTybj9V/kGD2nuKS9FcYg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=jMZH7MhH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hqf1YNws;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=jMZH7MhH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hqf1YNws;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNk/qSrjPBbj6GGaBE9/x8sOC4bUiw2Cvfdr242Gqqjeoqp+/qEE5O6B5v4IY3Wubq7DIZ9okj/1CesJXwY7F0asOB8ChHK1VFfj2IgTzTaeBgIfcvav
    EVjNi7QTjuQAIhq8vl3S7ZEJTdXNJmAng3KF5lAJqzao0sqnVzJygJCiSdXdL1gsCy9octqyGHdXkmBK1VU+4p6kEyfLqh8kZZxrj9YFR5+l/Un79y5YwxMz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=lSc1NEvqt5ZZnCmUoOYA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756008AbeDDAFE (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:05:04 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38253 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755974AbeDDAFC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 20:05:02 -0400
X-Google-Smtp-Source: AIpwx49Q5YF69hZnmt7rPdp6pCMXp744v4aWgMWXYEvkk3byRTTuRw8jTn1j9BNxvway3rPM7tPKLQvwojqXF6WivBI=
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
 <CA+55aFx9u-O81MwSq8zpb+MKaWYjYvtEcFu1NLP1_s63ED6_3Q@mail.gmail.com>
 <CACdnJutkO9dgz=HZpPRR9PZC=+cHh97dRUiGB+D3gruZr6U9Kg@mail.gmail.com> <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
In-Reply-To: <CA+55aFxZN_p_cU94z7QN8=HnPanRrpRHH7UUkOBaFDSjfrivnQ@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 00:04:51 +0000
Message-ID: <CACdnJutOAPTmPm6dmHiw4+8rj=M7B1SiCkPaRZLmi9-CCuRyNg@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 5:02 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 4:47 PM, Matthew Garrett <mjg59@google.com> wrote:
> >> Another way of looking at this: if lockdown is a good idea to enable
> >> when you booted using secure boot, then why isn't it a good idea when
> >> you *didn't* boot using secure boot?
> >
> > Because it's then trivial to circumvent and the restrictions aren't
worth
> > the benefit.

> Bullshit.

> If there those restrictions cause problems, they need to be fixed
regardless.

How? When there are random DMA-capable PCI devices that are driven by
userland tools that are mmap()ing the BARs out of sysfs, how do we
simultaneously avoid breaking those devices while also preventing the
majority of users from being vulnerable to an attacker just DMAing over the
kernel?
