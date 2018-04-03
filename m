Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2706406-1522798053-5-13595179179699230065
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522798053; b=SWsOION9hIeVTwX3dWzGoC4qBAgp0/9hkLFNwMh+A+uLhtR3EL
    klCnpBJNZ/uOSxaBKW10JdO4RXLvI4w1kkYFOsroEP+t6q8zuNxEWKytSvf2jzGS
    cYShU7zIA6UAxXrX895J7/lnVvXq1iXvObEmSXWhAHvmlNcAbPRZHwTw7JZTh/ph
    Hx8/c21GaCUghKhaPLG2AOaUgyAfEXIRPvOaGTBxp6pg2XTZk5uKOFoX3KZ07JE0
    RCm1xcJdCae0E14VIRMjabA5ODb35gzEdB8L5ypMMPGbSjI6G9WL2AA+mCTR3Fi7
    J1WW8zWh52GqiaUMV8i0A8cnYeWoxibmwifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522798053; bh=k1kgRzcD+tPtBxhEShGvgVY4S0j3FOdK+p7jpNHm6u
    I=; b=PvYik/qBC0nT/iZF8FLnLpMf0Qykg7VVGpC6XMie91M3n5LUaD4db418cK
    jQjLc6Rw5vlmH5DzgAczC0bxD2+Ews4OEWK2/loPreTdLp30Qynue2piKNnnpclh
    ARvShCtFq5uVoTZcQIas/0tNB5mH/NnTOdoEQpo0rmnA5Cztr2hY3ICZEUo5TR11
    S4ipQVgh6SQox84xgz4GoIqH0UHVlMTMR8Q8p7/a9wCZ4vVd1f8lA7JEZn9ONDTL
    QcF4+HzLCm8TX4MhFE/PZrI35NLKgAGsBIFcUBVrEt7WzncZ3onDZ9aR9/R+FG8R
    e+RABaAoUdh1/EDPianrC/hjKw7Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VE0MgpWD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JgFkCf+m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UtiR6qP7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VE0MgpWD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=JgFkCf+m x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UtiR6qP7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC7G3HFwF+it0NXSHJz0dBQesvV/E0lrusUOp6C19v53/lL4ceTr2N6IQk0YuCTs+BLw55hm4R82FpP3tqKQ3kvAVECPBOENhvjPIxxBziTZ8TzPXOVM
    2psEFh9b4ih7LAAy/K31f/2zBnmeQsfW2Jm2P09UTzhs7VnfvrGT9HFOvAWpL4RyQ+zkGOFDv1DEPh+HmVEuYzV8KMFrj7ZPP9kgt8InkCR8u6b6VRMOYLOE
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=MqrLuBBcaSQT8kBTHjwA:9
    a=mkaj10dLGZ8OLYoF:21 a=COelctXQOu2P-CM6:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755102AbeDCX1b (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 19:27:31 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:36106 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754164AbeDCX13 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 19:27:29 -0400
X-Google-Smtp-Source: AIpwx48JAvvgTtOslSOrj99G6nHl4soy4xLRBiL0qFq6knrYqTXJxnr8y0tNz93BEH+zH/2NtGd8Y/OCFLWfGY2R4ME=
MIME-Version: 1.0
In-Reply-To: <10232.1522797179@warthog.procyon.org.uk>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com>
 <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com>
 <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com>
 <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com>
 <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com>
 <10232.1522797179@warthog.procyon.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 16:27:28 -0700
X-Google-Sender-Auth: 0bhHB1E77AOJB1NVuqIlkK30iso
Message-ID: <CA+55aFwJd_AqrnrKfiCX++pWqrTuoduKUKhEwxvx=wVhMaQH3g@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: David Howells <dhowells@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>,
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
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 4:12 PM, David Howells <dhowells@redhat.com> wrote:
>
> What use is secure boot if processes run as root can subvert your kernel?

Stop this idiocy.

The above has now been answered multiple times, several different ways.

The "point" of secure boot may be that you had no choice, or there was
no point at all, it just came that way.

Or the "point" of secure boot may be that you don't trust anybody else
than yourself, but once you've booted you do trust what you booted.

But the *real* point is that this has nothing what-so-ever to do with
secure boot. You may want (or not want) lockdown independently of it.
Don't tie magic boot issues with kernel runtime behavior.

                    Linus
