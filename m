Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2960132-1522806190-2-17193087483718021816
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522806190; b=ly7PCPSS6ROzueG8jAGjYArTgtCppQPenwr2QafuickUnaw4JP
    mh3jUxCx70c4q3RPwHiH8X4fArLf7zLMDXofTIlWwPDwQl0nzw727nSpTQAImjo5
    mHHrBsuxSbFSXYyIbOQFo0Wj6CjrKebmygyeQCYS55lAo/zk8nHJjdHZh/vqRSE5
    9YjwSb4DpBr380cSyNmL/LV11ZCAZGZp4Z2ffFioZQCqFGKj+9zvtBvUWED/2FNn
    1DCB5CGsMGXJVVcns3cdEjbJUlKJ5eWbOiK1f8udvmUDWYpoU1bPs5dUrsH0ULA0
    AQ4caxjg1o800tRsoroDxNU8AWa4yvj8H+Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522806190; bh=79dy/I2MyJ7FR4UUQUaaQ0B7ZSCPPr6rVjlfxfCSij
    Q=; b=kK5sTLNE11GCW8nbSVsOkhAmUSr4KtC3In2YJilqTtYGwbdSXlGW5U2tvo
    K5utKrqyYO0Zq15UImg7x6mtR06Pj4ihezzFi1XubuJ4y3DhsDN4XfFomOpY2xsF
    RnR+FzEY1rb6XVHzt5mF0kKy66GCCWzN0v+SHoggjQnzOgJiontnG3zouQrtKlrr
    2end3J8s4oMW6N1Exy0ZDhapsRRE8bmJffixozqEm9LBYavSVkmQKnWHHxYrYeoe
    6MxoIzkkF2H9bJ4rOrEw3RwdXMjFRvaBjIVOl/SpZZIZXw0L+lELcRxla8ORpvSp
    a9P2Zs7AdP/2h6tVrqS/IGHJ02LA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OXBc40hs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=caem7X/S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dDY2d0WP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OXBc40hs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=caem7X/S x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dDY2d0WP;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHvWE8soNkrY9z5DXSNo6SQb3boLxdpRPvxLakXvRXTP1pjqAo7uZEE5Gu6+ZD2bBUZF1Vo4am2tDQFHCnMQk5zJfQ6d/Qo9ameEHhiGH32DwovDRtq8
    JBKP1UcUMoHzPRXAj4WhDCI4PvXTHG9Qw2Tylqqqcn6dXDiemut5XPQSdsYcz/mRinoD2ud65lGpvEVw3x6heUk538qxoj5kj7v5fp8Dh737KPbb+yANwAif
    hXFTgPbIs9ex1uNpI4xYIw==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=dz-9qWB1JFyATZL4qpcA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754268AbeDDBnI (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 21:43:08 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:41804 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753733AbeDDBnG (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 21:43:06 -0400
X-Google-Smtp-Source: AIpwx4/MqrsTchkrcaPYUhZY41evAKRQ1bXGzupAWlpoXt77+wQWpHCYkZ+JKdZgfP9omkT/0gICxurbVglkTIPqcY4=
MIME-Version: 1.0
In-Reply-To: <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
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
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com> <CACdnJuuek-sS3esmomNOkjBMV_6VPL2NFCzRd+UGxbZrMe=4nw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 18:43:04 -0700
X-Google-Sender-Auth: jQebqk9CTwdcP7Wc4BLmF_wWETM
Message-ID: <CA+55aFxgrh5eeG9MRSEsJtyL5yTe0TehZ=BS2josGJaLxoMMBQ@mail.gmail.com>
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
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 6:13 PM, Matthew Garrett <mjg59@google.com> wrote:
>
> There are four cases:

No.

Matthew., stop with the agenda already.

This shit is what I'm talking about:

> Verified Boot off, lockdown on: Perception of security improvement that's
> trivially circumvented (and so bad)

You're doing some serious value judgement that is simply bogus.

If lockdown actually helps avoid CPL0 execution attacks, then it helps
even if secure more is off.

Sure, you can do things like try to install kernels and reboot, but
honestly, that's not "trivially circumvented". It can be quite hard to
hide even if you don't have secure boot. Things like disk encryption
(common for a lot of people) for example means that you simply won't
be booting that machine without the user noticing.

Or think of virtual machines - which people often use on purpose for
security things. Again, they very much are _not_ going to have secure
boot, but it's not necessarily even possible to "replace the kernel
and reboot" at all, because the kernel came from outside the virtual
machine entirely, and rebooting might just kill the VM rather than
restart anything.

So I really think you're pushing this whole "not secure boot" means
"trivial circumvention" much much too hard.

To the point of it being an outright lie.

I think the kind of people who run stuff in virtual machines could
easily want to also enable lockdown measures, simply to reduce the
attack window within that VM. Wouldn't you agree? Those are often
security-conscious people.

This is what I mean by having an agenda.  We all know you are a big
proponent of secure boot. But it seems to cloud your arguments, by
turning your assumptions and your agenda into an "argument" that is
simply not even TRUE.

See what I'm unhappy about?

> Verified Boot on, lockdown off: Perception of security improvement that's
> trivially circumvented (and so bad), status quo in mainline kernels

I think this is entirely false too. Again, the "trivial circumvention"
shows a bias and agenda that isn't really all that true.

> Of these four options, only two make sense.

No.

You say that, because you have that bias and that agenda.

But that simply doesn't make it true.

Now, what actually seems to be a real and valid argument is *this* part:

> This makes it easy for a user to switch
> between the two states that make sense by running a single command and then
> following some prompts on the next reboot. The alternative would be to
> provide a signed kernel that always enabled lockdown and an unsigned kernel
> that didn't, which would (a) increase load on distributions and (b) force
> users to both run mokutil --disable-validation and also install a different
> kernel.

THAT is an actual argument. Admittedly I think it's a horrible hack,
but it's a hack that can be explained without outright lying. And it
may be a hack that is "the best we can reasonably do"

See what I'm saying?

One argument is based on your value judgments that not everybody else
believes in.

The other argument is based purely on cold hard particular facts.

Guess which argument is better for people who aren't Matthew Garrett?

That said, wouldn't it be equally good to just make the whole thing be
a protected EFI variable instead? Once you have physical access to the
EFI shell (to turn off secure boot) you have access to that too.

Which would allow the "switch off/on" case even if there are other
reasons why changing secure boot isn't a great option (possibly
because secure boot isn't an option to begin with due to being so
invonvenient).

              Linus
