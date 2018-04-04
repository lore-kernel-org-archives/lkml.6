Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-470151-1522858693-2-16847887900431820519
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
    1522858691; b=ubaGkumaCTdJKo85x6co1qAAl2jUK7bLkmFfaLbK48/rF0aR6Q
    uR9nWIko9w3VcLFZlLhl4SHB2l9Cg/7PtG3dpspZHC78/FIxof8z4GeI6XyBENFX
    Ws3rekX327ADqv64p0LvKUIN6Fiw+16RVbpdfReFdcN3Ppycgs0RF/dDVNFHZRQW
    wyptfXhHT9mdXCdMVEz8sNmj8NeLP1PR8LgAiFKfFdMsFl3dv3FycsfnsqaUzWKg
    Ke1aI4anmRj9PceK9kkVjz9WKZGUWiSNdP7aQjkj4084BQaiDLYz8OKC+X3atjL7
    p0UaC5MyZJ/iw9m7KwuvsGTWISPf9roVTyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522858691; bh=s31N1QUXBg+4qslHpf9IVBi6zIxAhZg4mZ2nXIyqd8
    U=; b=aPuxPGoWdKLaF8T+LkCdlumMjgl7+lf4Cq9lWsBSCWY9vHofB2nSCGWv4L
    IvV2E/zrmHQS7vOYXI2SfuoqHG6K+/HoxaTAgU/PQA9ajfhDbprLVgj24rl9rICp
    4dAafjsGnZzGS6eJoFxI/s78e5hzCMD+CF8ZU6pnGMjhgUCN7a0ru4+KI42Q/trr
    0mpfDgH0JaI6Sdgeh54Y7jFjVlc+W8mKsKjEln9yO47o0yHm0xhdf7ycog25QLyC
    wwKxwCUjBtRudWuhDgMos3OjcIjKkm2k7DRyLdhzPZF0Nh2T/5F84H07ySfKnrhb
    LgMDtyQ/AXFW4WdKpD+RuK1cJJsg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=kwRVBmVp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=etLoASdm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=kwRVBmVp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=etLoASdm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIJSo1gePjeIsVO1OmkuYJY7UmWZyxDYcbobk1ylheKFllxpu1DS82BXbWgNYEG2VJLYiNdtsExLglJ+QQf21MPFu9bfzv9Y9AwAukmM+UIhGmUbA1Zk
    DmyVwYsByg1m9T5/6ilFvFC3oYj0Uj/1f2dIKwVvlmbMkADpa8vHBmZk8ZKQ2uxafMUgB+BPyNyhsJN67TQIwIwV8QGqnLFwZ3HiR4RXWn8xXvaFq5MBnHMm
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=cfky5UaXn-p7EsWy9QMA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDDQSJ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 12:18:09 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:45166 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbeDDQSH (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 12:18:07 -0400
X-Google-Smtp-Source: AIpwx49NPyVV9944S5WXWGpv4MiGG4PkRnYslngNKBDas0T/VTMQsEtv+s6oxXKdC7USXEu53nYxBVkPIYEdb5abE20=
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
 <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
 <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
 <CACdnJutuBaE3RaDx0KM5vDF9Sinrp=3tG9csrS-H3eU-J7-Utw@mail.gmail.com> <CA+55aFyyom+jje0Q8xwLfKCWGkRbWC2Gan6xPOPWaqBCSS=5Ow@mail.gmail.com>
In-Reply-To: <CA+55aFyyom+jje0Q8xwLfKCWGkRbWC2Gan6xPOPWaqBCSS=5Ow@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 16:17:55 +0000
Message-ID: <CACdnJuuvXsTnmJXWjyZF15TUGo-=t__ae8EtW94FKByWEMmdEQ@mail.gmail.com>
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
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 4, 2018 at 9:09 AM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 9:30 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> > Bear in mind that I'm talking about defaults here

> Mattyhew, I really want you to look yourself in the mirror.

> Those defaults are really horrible defautls for real technical reasons.

> You asked me why when I questioned this, but then when I replied, you
> entirely ignored it.

> So let me repeat: the defaults are *horrible*. They are horrible for a
> very simple reason: kernel behavior changes that depend on some subtle
> boot difference are truly nasty to debug, and nasty to get coverage
> for.

They're the defaults that the mainline distros have been shipping for
years. So what are you actually asking for here? If you're saying that it
should be possible to enable the lockdown functionality even in the absence
of any kind of verified boot, then yes, I agree - I just think it makes a
poor distro default to have that be the case out of the box. If you're
saying that it should be possible to disable the lockdown functionality
even in the presence of any kind of verified boot, then yes, I agree - I
just think it makes a poor distro default to have that be the case out of
the box. You're arguing against a patch that provides the default policy
that distros want to ship.
