Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2706406-1522797465-2-16892855461516857849
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522797465; b=HQtpi7ev1SZSkExsRgY3EJLA35evjTC8t2RCN6mwwogesFh+kP
    e97ofrjtc+KvoguBmyNkfCC3BJo9DhqP6dQFrj9cqeZGuB0q+QuWkDSESrLFDkwb
    enrDOpyhwbXExyWe5sQn7XktqxNDK5yC44urp0XCRxABbj/KfERCnPBIP/VfA02g
    m/LzNxS5CddjaaPr2xxJNLWxvq+MagxGrh7hzdtCF37Ovah2i6kOTO7hNineRUXQ
    noCYFtpigZqvUqxeMjdzJX7wQNGf1Wkl9kft82tJYAL7ZDHIFy1Qx89lZkku7DFV
    wR4hefhQjvtFPXk3hD2uch5fyZkrKtKQe8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522797465; bh=DexARnWgr8e25ghit6kHFVFa80dNpUtGpBLfZad+RF
    Y=; b=v2fisqRL7Al8Pn4GVjZquKUn0lCzIp16oDHdN6JSJQWCFQ8clZqrIP0KQI
    1UhJX4fLClsSgKmMI9lqRHCTwnvomjL8g3uTcYptOiGSPz5jdnf92APtDEoNscpm
    s8lnTE1haYsMW2HMwh9PUDnp/0sRYAjYZRLH+gX7V8wArs+TSly8Tq+QU6tgDeh5
    UH1H9Fb8CVZb0meRvQa18R9bHvrob97uBQKCGgiE7CiUMe+EkqeEV/8GGZ7z5oPf
    6DXDndJx+d4lwplCZCiuWTItgk8r9UcGWbyU+9c2RaKe/CHahBrWsc9yvc4AhSOU
    12X9XYQeRT8617ebbEtPglXJ3cFA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ABistlYv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HDe9DOtC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=ABistlYv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=HDe9DOtC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFPRocOIhmgInS5xtaSl6z4+X/MJUKvoGYk+yektfBdGKGRM+vR63BhGKHiQVn0o3ePrWnFsPljpYgQ5pB+wXcaX8GErJiruSvXlSJd7RvVe3yl3J3Vg
    lgzSXzIiXECPhaHqaGDQOL+9/d/VpPgFMdOEgTh7QYR9bt8bK/F/KClj5PWLcVFffDTzWtVW9dG7C8JVDAuWUnX3og0n42keOtPabo9opAsb5uZNa8nMgIwg
    cvvjcF9M8LDgA2NDhyuVxA==
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=pLMB4RpLpBy61qV9ZPMA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755471AbeDCXRm (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:17:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:39465 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeDCXRl (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 19:17:41 -0400
X-Google-Smtp-Source: AIpwx4++OzNPN4fo1cnEgiWXHXzrVpiWHOwUm0PNI1n0xEcCzZTHeuUJExatTaRitdxojSv22QEr2owyRyoVifZJ7C8=
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
 <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com> <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
In-Reply-To: <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 23:17:29 +0000
Message-ID: <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com>
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
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:08 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> That's not the right approach to begin with, Matthew.  The onus is on
> *you* to explain why you tied them together, not on others to explain
> to you - over and over - that they have nothing to do with each other.

1) Secure Boot is intended to permit the construction of a boot chain that
only runs ring 0 code that the user considers trustworthy
2) Allowing arbitrary user code to run in ring 0 without affirmative
consent on the part of the user is therefore incompatible with the goals of
Secure Boot
3) This patchset provides a mechanism to alter the behaviour of the kernel
such that it is significantly more difficult for arbitrary user code to run
in ring 0 without affirmative user consent
4) Providing a mechanism for automatically enabling this behaviour when
running in a context that is intended to restrict access to ring 0 is a
rational thing to do, because otherwise it is difficult to achieve the
objective in (1)

Alternative approaches to achieve (1) rely on severely constraining
userland - ChromeOS, for instance, doesn't impose these restrictions at
present but also doesn't allow users to run arbitrary applications (you're
stuck inside either the Chrome or Android sandbox). So, if the goal is to
achieve (1) when the platform is in this state, what's a more reasonable
alternative?
