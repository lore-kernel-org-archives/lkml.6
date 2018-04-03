Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2751240-1522799335-2-4483850549156512591
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522799335; b=iaDVq5tIB+HZnkRC5VPl4+ZHN0BQAiUuPLqLOz7jYIPE//UvvM
    bCfhijQxSgCR6UR6ZoUxtMXHol8TrbA6DHU2qiZMN/2GDBKCOpt1CuMfmbjhgoZC
    2IyvMDv0GrUl9hMSYDDCbOW+L8Gv0DMyoWwldQFXmnAVaPUQ29dCHusKwHj2pubA
    j7bVI+YhTd26VaYjPXuvAFtWuCYok6FDY32127kouD/15fZvivtUttc8GyBACqwe
    3zjWrTJQYBrFrbpEDpKbAgmuNok4UO6CYhvJ+1Fhsv6Wwt4fa5dF0t4EZCR0zJal
    C+f/D+XUdcczHe3lEL4qf6EFx1c3A/D/eiWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522799335; bh=qtGR8+jCCO6RKRhcz6XBj294hwR0F0iLv69IIrvb2E
    o=; b=cvA+r9GPBstrhDV8AVo4QI8At/q8halQ7rlvQhtg6bVZWRQy1IA5L87GXZ
    fjB89QQKGq7TQ5e6zIAT0EvP5wBsEFu5npJlTaPkyzWe/XHcr13VUbFgL9WPDwT/
    PMg144AuZByJ/NJmqIsXukbX3gFIECsUOfkMgvTXGHGXx7o7tMgj0/necracAR9z
    I9CgtxC8RgXZi78hMTWHqpqTcRAD/FR1HfcXGRKCaLw+NboSYusSS6JY6nZeHjeK
    SksOfpRd8e5afUWT8bAKu6/sboqZA2OWBn55tDumwUAMHn9HzOuABmUPB99RV1jv
    mh1KQsshrqiy20u9W4/8yUonS94w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEgY/F4F3NbTbQG4GcT6vPvFNxYtCxKMt9Rcs0Bm5tlB68uyO6ndg68TqxK/yTjYxx3DswHWkAvYr6Kph8fC0rQY98ByUQg9lKXzqH+cKg35x78/i1UW
    E4sdVDeiuz+26ehnjOnd3Gpt+b9UCj2d77nB3Yktpsd1T1UMbmZ3kzlAcvtbtLScPO8dH/gSpbvm6CCd2tFcGRYtJeWqPreohRC78EVC3DuFBVOSPpTtwLoa
    TJntSv2mdlfoyRPCx+OXZg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=63JgcoMelTkTVU2mQy0A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755312AbeDCXsy (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:48:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:56428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbeDCXsw (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 19:48:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E4872183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AIpwx4/b39fXYzOht989weLYQ5UOQ0WbHduVawi+VUE3G2XdGucZenmdtmbbfdxOhSAjeHimRVQqGbp+A6dsRQFECMI=
MIME-Version: 1.0
In-Reply-To: <10718.1522798745@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com> <10718.1522798745@warthog.procyon.org.uk>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 3 Apr 2018 16:48:31 -0700
X-Gmail-Original-Message-ID: <CALCETrWDtRQ1M=JGuB-6E6aBgO9S3+43AFKCq2AyftDutYcuNQ@mail.gmail.com>
Message-ID: <CALCETrWDtRQ1M=JGuB-6E6aBgO9S3+43AFKCq2AyftDutYcuNQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
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

On Tue, Apr 3, 2018 at 4:39 PM, David Howells <dhowells@redhat.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>> The same thing is true of some lockdown patch. Maybe it's a good thing
>> in general. But whether it's a good thing is _entirely_ independent of
>> any secure boot issue. I can see using secure boot without it, but I
>> can very much also see using lockdown without secure boot.
>>
>> The two things are simply entirely orthogonal. They have _zero_
>> overlap. I'm not seeing why they'd be linked at all in any way.
>
> I'm not sure I agree.  Here's my reasoning:
>
>  (1) Lockdown mode really needs to activated during kernel boot, before
>      userspace has a chance to run, otherwise there's a window of opportunity
>      in which the kernel *isn't* locked down.

That's simply not true.  A sensible verified boot chain (a la Chrome
OS) is likely to load, as one verified chunk, a kernel and initramfs.
Then initramfs can flip on lockdown all by itself before it enables
networking or any other attack vectors.
