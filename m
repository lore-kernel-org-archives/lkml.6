Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3758820-1522829128-2-9132753243969290557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522829127; b=Ec7kVg3/mAxkvRaDDdl50IeCKuHLjbgBvIG2TOUdvL3HMyxX2r
    guP5J//VEdkVo8m7ZzF+7YBCt10YNmVAMAlvD65L8Fuvlh01A2Qzqd0DVKq2jkWR
    QPDEFS1XA2d/WuR5aOLsbhCh5KxZj8TOXFEvTHUBMU0M5mPxliQZsHa+YoLdL3pJ
    CPsEcaT2MdftJar6dBRZ7k/az0afSYwq+mjGHpZNe6S/O3n9/7scerCc4LFFK7No
    /NlTVQWrUfn3ZvnLm7m1dXSZPi/t1VJrI9Ou/vbYXZlYjc2kiPGEG7oAlM2XxIbB
    xof0GGf3pa2AOVVWi8dUxlEeR9ukAj1Mai8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:in-reply-to:references:to:cc:subject
    :mime-version:content-type:content-id:date:message-id:sender
    :list-id; s=fm2; t=1522829127; bh=t0yGuT39vhl6CExI3IsK2exFX6yotF
    MYhLYd2FOOtgY=; b=VVAmmxAelBQzPWsKM+jVDGdASVMEXAiLjLHywemyH/Nvk7
    mEP4YJLWJB2VcPft3Ime02Wx9e3RQlgZntOk3pqbqG9OwEf6/Zq0MuesM9nZEans
    Qaaw841hWgf/VrJ8DSUhfWDWP7WAtMoTXRIjQaTHQmBRzOejlXscIFXW3msQWAvm
    TqZfcLfbSn5fmCAd0uLZyC/ZgqP3He2qNnPx93Ab5zi/mX9PKux4HlPgV6qUEKl7
    /4kY6KUQpvQmgfz/n0YYUKsiCxkRlZiEQd+mFlefU84Lu1mA3KVLbM8AB3kZpdPs
    KK1K46cvHY/LC39s+WKrOg+9hlu/qUFEM9VZDLWA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPizays60jWXLR0Wa9wNeGBxYpp7kLaB3xmGfZwZKXq13cITNvYbZdcb1VC7gmwjN56vW7gZtKXfKl+msFZK5miCXGjy0DsgDq80eH9/m0L+uAI4kmEm
    Pn3Ej9pcr51cvvDLnCRN8bwhYGTGNl2CQjfKzJCNAtkRTXyAWfP4XauzqOVfEG1JblQ81/vJggbxazWLLKkrE+V7N7O9ShBY/1X7P0p9ca7XwgPj/PzV6aD1
    W2S3Sxo6aVj3DaoOvSdsLQ==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=XZlqF69kEOepoBahSegA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751167AbeDDIFY (ORCPT <rfc822;linux@kroah.com>);
        Wed, 4 Apr 2018 04:05:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750736AbeDDIFW (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 4 Apr 2018 04:05:22 -0400
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com>
References: <CALCETrXZWU1MC8LbLCg7VTVHMqKpXh51amnTjKePRCJ31jRiwg@mail.gmail.com> <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk> <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com> <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CALCETrXeVod=kNpG-M7yKAMM0-n+PMg_OakN6ecWrTPmKXgMLg@mail.gmail.com> <9758.1522775763@warthog.procyon.org.uk> <CALCETrWHS9p1My=j07=V=OP7v4SwQkW-kJ3JOx6EbPU8fb_XEQ@mail.gmail.com> <13189.1522784944@warthog.procyon.org.uk> <CALCETrX4CuHVpn38R24TCcJgCBLSbh-sOD-qcD5kYF8Zo53ZJw@mail.gmail.com> <9349.1522794769@warthog.procyon.org.uk> <CALCETrV6E+r942K+fu-ALNf-x6qOZ3o1hNKGeu7qEMvr8sMP9A@mail.gmail.com> <CA+55aFxKzxdRZthzaokaGPAsWCp3a-p3aVfJSutF+9Fp9sbaVA@mail.gmail.com> <CACdnJusSfwULV-ubvgtYd8G_cTF4LnJ4DAeTCux4XRhHKVpBUw@mail.gmail.com> <CA+55aFzG==xr2OLK8F03RH0nkUDeP6btWqepFTuHZqkPTAOWjQ@mail.gma
 il.com> <CACdnJuv_=ihPut=5OvCYEphdBOn7+JrKacBbNa0n3wv_JvFMzg@mail.gmail.com> <CA+55aFyWNok1K-Jo3TQAXGXHvFOTvuOb-Hw977B9RGjBa7prrg@mail.gmail.com> <CACdnJutZFKX+izBxRYbyxefT5KrKhVV0XsymU=vBhywd+TOE3A@mail.gmail.com> <CA+55aFwVUmjZ+Swe9xUdDOEE+EOoaU3dh7BcrH74BOLCi8y_Kw@mail.gmail.com> <CACdnJuvqQQ+hidokY5GA7g-yrAs5-358it0cs+m_d4RFDMuB_w@mail.gmail.com> <CA+55aFwJBGCr-anrdV9N63fUH4V_QJqgr0_fJyHhH=fuqGAoog@mail.gmail.com> <CAG48ez1MRsDGoea5MwGTXK6R0LJy9u0mX-1VrSSskwnV98kEjQ@mail.gmail.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: dhowells@redhat.com, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <20735.1522829117.1@warthog.procyon.org.uk>
Date: Wed, 04 Apr 2018 09:05:17 +0100
Message-ID: <20736.1522829117@warthog.procyon.org.uk>
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy Lutomirski <luto@kernel.org> wrote:

> As far as I can tell, what's really going on here is that there's a
> significant contingent here that wants to prevent Linux from
> chainloading something that isn't Linux.

You have completely the wrong end of the stick.  No one has said that or even
implied that.  You are alleging dishonesty on our part.

What we *have* said is that *if* we want to pass the secure boot state across
kexec, then we have to make sure that:

 (1) no one tampers with the intermediate kernel between boot and kexec
     otherwise the secure boot state is effectively invalidated, and

 (2) the image that gets kexec'ed is trusted.

Remember: you cannot know (2) if you don't have (1).

And if someone tampers with the aim of breaking, say, Windows, then someone,
e.g.  Microsoft, might blacklist the shim.

David
