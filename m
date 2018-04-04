Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2906851-1522805808-2-16601874953897717071
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522805808; b=usGUgiXFTA9NCIXBWZCishSYZOsvn6GFQyLpFvH1w//5jWpwZN
    sS+uUOiXbHVmSG1+kz8QQdMM4lXZrBYLepJDqAi2JwqnzoI2a20JTNNicHthTJ/N
    63DYXtsA/0REQsPqoXUrIm2QtxzCUBM4/P1cCpAY2Gq/2Co9INcrQOQjiZ/BBiu+
    ikMx2qVYk51HT+xPJIyc2HxkR87aQESFjqjOvNr4zJANJUhgeP0B46VgGS7WnJ+m
    HERRKxR6EACJYlLgvozr8k71thZSihvC/0AVgIcJRLD7O2mRRdSp/7bQttLuwZMp
    4CxBqBU05KDRgNl+NTyusdjFrd/sauC86fNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522805808; bh=PRPR+sbaKvSNTCxxGmpmSF09lh6Iw2GzARmO+/8exq
    8=; b=J0nHTsDVDBvWou4+FAWKV8lxP87wu1/Maaef2zh3I2X3Qqmq7bGoBGsgKD
    BEWmhcaMFrwN1rPSeXwMarZEHugpS9OLpR6vPQK1Rrc0G4bBjfqiFkKz08zC2DHA
    z3EyhESreTiTb396PsXApcRHWKN71hP3jMy84SYDgsT1+CsDbEFUrGVGjwluNFfF
    lWgigocG8gArA5E7uy9YdaOUSW+/y6ntccQCItobETjEr/0w10vrZmxiuz9B/wuj
    eUF5fiiYVwY1dOi089zP37W2JibO0hEtTvDPgmMajTcjIWxq6h8FOmIcD9cjl6Xt
    Rlmxtto5BXfMGgN1ovzEDglDLUxQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PcjtfkRD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=PcjtfkRD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJETUrq/KN9U1gSjo4WeqGxgLXvK6xJEQQLjBzsaPjoP+uB6VebKwPUXLvRmA5stlcPmnFZ+6jzsME4kI/1+yMCxDkY6oV1niygrSVdJb6AToZexX5FS
    pRL31B/k1Nyte9TbRUl4zXZZ+6aEeYkNVkHBmv9KoDlhZ1pZoqkd3NTS5fq1aoyd5gQ8oo4C2grEYavbfuRdbQPCsl3HKfCks3p4Q4fc0RuWOSNkPtNPUVMg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=RTVaJPQtaUzJi0c2LgQA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754253AbeDDBgp (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 21:36:45 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33167 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754111AbeDDBgn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Apr 2018 21:36:43 -0400
X-Google-Smtp-Source: AIpwx4+jUPNWAKK1yzi5Ys970kaQxXYnqbC9+Tg7OW5SrY0LiUvEHrHdt/4aFek08ZO6l32uhCuPG9lq+t82/DayqUQ=
MIME-Version: 1.0
In-Reply-To: <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com>
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
From: Justin Forbes <jforbes@redhat.com>
Date: Tue, 3 Apr 2018 20:36:42 -0500
Message-ID: <CAFbkSA1YTN3DVNBQzYuJpu-Y4cWb6iwR_VeWyZjtZ2Ejd8w6DA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Garrett <mjg59@google.com>,
        Andrew Lutomirski <luto@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        James Morris <jmorris@namei.org>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Apr 3, 2018 at 7:56 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Apr 3, 2018 at 5:46 PM, Matthew Garrett <mjg59@google.com> wrote:
>>
>> The generic distros have been shipping this policy for the past 5 years.
>
> .. so apparently it doesn't actually break things? Why not enable it
> by default then?
>
> And if "turn off secure boot" really is the accepted - and actuially
> used - workaround for the breakage, then
>

While there is very little breakage in the *years* we have been
shipping this in distro kernels, the accepted and used workaround has
always been "turn off secure boot" or sign/import your own keys,
depending on the problems encountered.

>    WHY THE HELL DIDN'T YOU START OFF BY EXPLAINING THAT IN THE FIRST
> PLACE WHEN PEOPLE ASKED WHY THE TIE-IN EXISTED?
>
> Sorry for shouting, but really. We have a thread of just *how* many
> email messages that asked for the explanation for this? All we got was
> incomprehensible and illogical crap explanations.
>
> If there actually was a good explanation for the tie-in, it should
> have been front-and-center and explained as such.
>

Honestly, yes, the major distros have been shipping this patch set for
years now, and every time it comes to upstream, the same damn
arguments emerge.  I do not disagree that there are uses for lockdown
outside of secure boot, provided you have some other mechanism to
verify your chain, I believe chrome OS does. But the tie to secure
boot is because that is the use case that users have been using for
years, it was discussed at kernel summit quite a while ago, plans went
forward there seemed to be agreement, and when it comes time for a
pull request, people come out of the woodwork with an expectation that
it solves every problem or it doesn't need to exist. What is here is a
good starting point. I would expect that if it were merged, others
would build upon that and use much of the code already in place to
extend it. It is tied to secure boot because that is what has been
using this for years as it never seems to get upstream.  I am sure
that once it does finally land, it can and will be extended to other
things, but I don't think I would want to spend a lot of time trying
to leverage another external patch set that has been delayed upstream
so many times until it actually did land.
As for the ties to MS that come up every time, and have here as well,
there is no requirement on the MS signature. You can import your own
keys if you don't want them involved, I keep a "test key" imported for
actually running what I build locally.
