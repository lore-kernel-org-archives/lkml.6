Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522801190-2-10623297341680627421
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801189; b=twaz3J+nu9AGvFhE/IBN6pNlg2/V+duY/EM2+Lgc84JNVdW3TS
    I/y307dljMC0HCMFN/+y26tee1AW/l1yBBxX23YpzeXKm5D35l4/F1NnZmxKlLHN
    02BCuyORjWF1IRjarZrZ3aE7mEOuAyUN+epygnB2Fc3OPTHfszmFPRtfXkRTZi7E
    QR8fzdn1O1d6Tc8Joz8mb9c4K6BkuoOjRJSzVTOpdsRrJA5wE3tODdbSRa1zjNzt
    KEhc2vCjRkC8ub4HlfjfImaztsLShLD8X3IuM9KaR//UhE6etgnlyrinqlfJjfjg
    zKU3Mb4+p1u2Gjas8E/NoObXUazZHyLJjmfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522801189; bh=+n3P0vopFLHKwMYIlsJn5VIfZOOII/oDfQuvoDguzE
    Y=; b=e5dWptUya39peJxjKeF97pdDMSqUiuVK+0z3Uen5OuTtn0F8AK8oyuJNu2
    wM2dilb8JP8rHYnpn7huoB3D9LKGsgsQkzqOg51ZSSTnhHWwzb81gtdACjV6M5E9
    IiM7yyELwXcRCxYARY+zlJI4EExDsC+fMQERj0QRj1rI1uYqHk/jHU79em74CQuT
    XAzdwnTzfj+tSdXQqXCVx6PA43r/bSbIxcfELeDzw6UIPOBjKmXPl15QXfo9aSJz
    sgDX/VKaLZ9bT3rIF+USKBUt/ROuFI8Mfx7+FVPVyns1biLSaPuc+9jgNQLiYJ4y
    k/PL6pIPyYeWmHyNqYDkPvxB3pQg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bWT0ARWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=evSQepbW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=bWT0ARWv x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=evSQepbW;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCromEt6/Pe8RqdDDI2rQBV/zH3TjwDm7ttyDUOUiaUqeSwDyFzZuiPqfR7bBuAMFiikqJ5gKMULfrJAFnFcmChIVCeLdD3eV7kh2q5I2ku75SPgmuTO
    toHpmYrBYxnCuvSV+0Qn4O9mFkSkAuXA5xngJ58TGTh7i9M4J+ToZgUgU9+AgXHMF4QO0rFsvKDsPlBbkZ/yG2/65PPbgR4/mCMUP0L98K95XF2CvRREtGxm
    Xjuj5XfZq7ZSVxpcFBsxyw==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=6nUXITN49fC6jhMlmTEA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756637AbeDDATs (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:19:48 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:37724 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756385AbeDDATq (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 20:19:46 -0400
X-Google-Smtp-Source: AIpwx49R7F1mrTXdDxuUXFG12LVBMaxhlJJ7Klh58eeg4cSjOXibW2QwquwEQ1zbR6Xq2Ws99URiyPC2HzBAtahhTyQ=
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
 <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com> <CALCETrVF2vSvoz0sBCrfMKcbJ4hmi=1QJZbUxdvurkimVXr0nA@mail.gmail.com>
In-Reply-To: <CALCETrVF2vSvoz0sBCrfMKcbJ4hmi=1QJZbUxdvurkimVXr0nA@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 00:19:35 +0000
Message-ID: <CACdnJutmTU4U0nMik0oqGHDEd-xd4Vhi06t3RsZ5tpUgugfNbQ@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: luto@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
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
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 5:18 PM Andy Lutomirski <luto@kernel.org> wrote:

> if your secure boot-enabled bootloader can't prevent a bad guy from
> using malicious kernel command line parameters, then fix it.

How is a bootloader supposed to know what the set of malicious kernel
command line parameters is?
