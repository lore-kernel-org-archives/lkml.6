Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2795407-1522801527-2-13658971931505426484
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801526; b=pzhTEkYJ4RaoYXxTbf8LAN5RCTPm1hY5HViWDWuElFY9Glg5gi
    9scg2Qg7wjq39d2H9zQrMyfavVXlCFe/PPwChDgnr4bKPwh/Qtx8ckPlCTuYhOqs
    dU9f6uDaigezL4xAXjvZAUh/+NBfzYUtYoPYCwdTYBc0kOLiAeYTmsaIIaL5rnNf
    DQ8bgEyKLVS5hhm6MkOI7LlC+LpHIicWIN3PzHNWKlbDy4hwdE8UhYlpRZ6E4gnJ
    QqO3shMugF3tIWeauuiXQIuQ88up0k4X3KRZ9fppIoyxowaQ3Wtb/j+1RSGwGcAg
    nEuvq0E7ON3iX3r3H1+IxpaXkbSgJtrU+FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522801526; bh=edPlOAxQg5wcurDmoJ0iQCw5rH+Zny0wtetKBEAgHd
    g=; b=GJlurhoaKcWMVVZvlhnHLU3lPQTZ26hQSSyf9C9LF6kabjAoe8bDMfo+8m
    j/3EdBnxZ+GNmK8XMXk83p6hGnUZn5BICz3vqUIxKRN/4yOY1yAagUkmjNW3durV
    o8FGM+Mke0rBPcfJWefjIhhs72i3CY4VEMFxtB3jml0l1G7o4jdtCUqcbFHc+3BJ
    0MVbLObWCVaOvmFb81Fqys0U7sGzXavm+widHo3Svgl7Vybtfi1JKareDPEtAkKu
    zGSkQJoILM4nbN4Xvjd1lNtWLTPSPnasK2HY8cdHQToZb1MJ7i0r/NoxMtWmLZFQ
    Jkd+ZQvquV6NzBSn4NEp2l2YLxUw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cz49vIjB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CiQZKqu7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KBPoAiAp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cz49vIjB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=CiQZKqu7 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KBPoAiAp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPivS27tBO0UYs1Lzbm7FkW8MPuBEJ0cPFdR6inis73Ol+PwHwwCVZUblakTvVpQb0oGJ30ka2H7Kp+xrFGir/hF9/m2qLOEg5FZyxvii6epiZ/Cmu/x
    me7FsYxHZH0e9EIdYEHAJ+aN/YJ5uoisUCVHaz4OfsEPaV+TDP1jzZrFp0bwR1/vtxsVOoX8yXOFPbXtIWYBwnodtmHBqOjR0UMbujFrsSXTzh545v2oQFWV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=b_tOiNjrinbQ0pQHFG4A:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756569AbeDDAZY (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:25:24 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:55271 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756404AbeDDAZW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 20:25:22 -0400
X-Google-Smtp-Source: AIpwx48EJdtjUoiDVhSuxZVkhPwdZOO74uES48VCAvHiFh9klbyVB+k/jk5fq2mY4c55w7vYsLJ7KvHonoIWNTzpIqA=
MIME-Version: 1.0
In-Reply-To: <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
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
 <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com> <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 17:25:20 -0700
X-Google-Sender-Auth: sY4B3IsqG_M8VJNwRhHi3IHWOLk
Message-ID: <CA+55aFwvuoSHhKnn82VnDndZ6oXMJgwHF604gZ=h3ehHyC600A@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Matthew Garrett <mjg59@google.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
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

On Tue, Apr 3, 2018 at 5:16 PM, Matthew Garrett <mjg59@google.com> wrote:
>
> I ignored it because it's not a viable option. Part of the patchset
> disables various kernel command line options. If there's a kernel command
> line option that disables the patchset then it's pointless.

Honestly, I don't think the patchset is viable at all in that case.

No way will any sane distribution take it, potentially breaking a lot
of machines, and have no way to unbreak them except for "oh, btw, you
have to disable secure boot to get things to work again".

That would be insane.

So you'd better allow some command line options.

One reasonable option may be to just disable lockdown by default (to
make machines work reliably), and then have a "if you're anal about
security, add 'lockdown' to the kernel command line".

People who care about this already need to check the secure boot
status, so this would be just one more thing they'd check.

                Linus
