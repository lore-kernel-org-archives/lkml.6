Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522801023-5-8369740435429820639
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522801023; b=pBAcuzP1X2EJpMNi/yHaD3TbNR1QRLl1c6zh8iiOK3/hfog4xf
    pn3gOEi+VAhkICQhe8UcJio4kBMB7eba5Xz24RhcmfXUwGOEkVZjkPrZ/nqOu/XY
    jRm96zB90IIzvI++SNb5Z87jxBl0len3tIm39QqsJVrPjl03Mbdds3OtKhssKTHV
    LyZZOnsaDqUraSH1L+cYq3rBpBDWxUOzkg/W+puA+kT/LvBoKo9WoXkHHfVXUEvt
    UfZQjsyLa7sr48KLn08S2mTK3EWqtrfdlZFnP8M1T0CvQTGD/rm6uXwAoTnhPTfA
    SrGd49zyPGyrcaTSGzLPxjsyWCuFqdeOoE4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522801023; bh=8+Y3k4gDWFeGExWg0JenopOspeIXWqg0Zy53tina4C
    Y=; b=FjCBA0xGEqR68A4UPc9UrlXrU/WfYVQRTG9OkZEVgkPZMLT7stE62yPErH
    1Es6EoyeEXlhFtPB01nhSzldbRwuqewBsnmvDpGB/ZsGrOnIBGiJrKGKVFe2yh9A
    F1lzSGn0rQQFwh/R09fGSuGM8FUDbyi/6KDYEYvMCqZy3h4BnMCJlwho0QU7XgQN
    +SMPyseKxJ8mXCV7+OY7PG+70OeqCwWfX6pP5W6drXIwelh50YKiz6A8MZ0SudOj
    a4bdNLKOFUmCf8tI+BwTEzcaMiemQd1KrCy8z7bSAUKlA+KO8VzORcZ8HDAWN0xl
    3v/apkShI6LtT2wH5S2Dp6wN535w==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=tH/tc2Fc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=St2RSdSZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=tH/tc2Fc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=St2RSdSZ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAOzLWyBBqgYwMeLG+DGa6vqraEY5wJjfhvpMzs2rpDjxPEdTwNcvwXSurLxgKV9lNqj8HUQPfa9bIIZr+0G4TvIb1p63W8/VH3I06PDwrme97R1jw0P
    Hwyvq6oWkKN6q9dk5yE5vqQfNr6nUqBu//EpJhLuElEbFFIF/M8MnnVedFsxzXNUNHU+fGKBxAiXDDTC4vkV65giVZvC5PDENHh0aFBXfxwNQ/tQT36EOTQC
    rfjYqQSGsUwUSXvgY97viQ==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=PXYbsz1D-GTmcUWmGSsA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756242AbeDDARA (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 20:17:00 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33727 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756104AbeDDAQ6 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 20:16:58 -0400
X-Google-Smtp-Source: AIpwx4+u4VLEMSn35Ccj5zL5tb44YZ5mc97SdZTC9ZU3DfmB5Um+wBG3Mu2EEePB5IxTIKni3DM+cpp92HxuMTjYEs4=
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
 <CACdnJuvFqXGLsAv1Km3MmdssHBfuH5-C_vG3A4eq4Yuj0HhFBA@mail.gmail.com> <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
In-Reply-To: <CA+55aFzYbpRAdma0PvqE+9ygySuKzNKByqOzzMufBoovXVnfPw@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Wed, 04 Apr 2018 00:16:46 +0000
Message-ID: <CACdnJuv-VpdhjEe1cMysdHb6Oy67jQqg-_TVHbUrOfH9GmCVvg@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 5:15 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:
> On Tue, Apr 3, 2018 at 5:10 PM, Matthew Garrett <mjg59@google.com> wrote:
> >
> >> Exactly like EVERY OTHER KERNEL CONFIG OPTION.
> >
> > So your argument is that we should make the user experience worse?
Without
> > some sort of verified boot mechanism, lockdown is just security theater.
> > There's no good reason to enable it unless you have some mechanism for
> > verifying that you booted something you trust.

> Wow. Way to snip the rest of the email where I told you what the
> solution was. Let me repeat it here, since you so conveniently missed
> it and deleted it:

I ignored it because it's not a viable option. Part of the patchset
disables various kernel command line options. If there's a kernel command
line option that disables the patchset then it's pointless.
