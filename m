Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2960132-1522807090-2-7346497851808576012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522807090; b=hEd2ecNYR/2syVyK1cioNlkBhqSiEubiWbxbMzTpEAJgQhGQO2
    IHiLU93tyrw8SJKIkXJ/V94pK9rPpy0/B4L4Wv6JwNdzBOnvVjDhi7bK84Kuadej
    uHCXcWAVVLBrFjExxT0VGvRz5Unf4niOq5iRxm3P/Eq7PFOmbc4Qy+O1cTIEkRe8
    +VYvs/NHSfAONQALX99EwM8WtZ7LyhiogXu8+c+w826ZyMgCRFOTy46khvuxyoRx
    /xhKC21wC3Fm7AY3kHUgX4XjtNxE59LZ9sMiNZaF/JOQyS720Jj7FyvO6nTxmke8
    zT85Pl+McNnXrrNv8O7a9daLToCSdnWUbbcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522807090; bh=O7spP2c5DvSLV/g1iOimBbwtQ/DzhqVuD0uv+FVVhI
    s=; b=hy915m9I2CfEmGgSEEOm0JQQ3zaKV02hYkpqel6cwDTadiDhILv+N6YJZG
    Ttdito3hIQTP9w3JEjc8RpJdZQ91mYr/o/7n+PXXAxD97zZd2GfjyWwoeAWGLOua
    dGPmwqyu4J4SVgmQ0ybv+JKDnoyU62PvUzcGtxupSL5SOZtic2tt8kHW4LR/ItK1
    BZNmRRNq2hF6f2ITu3fkC70GNZJf+v917THg+k3g9wvd15nta6sM4VBjT3l0CY5t
    ir5VJbbYCjnpyQYiVVsr8A/AFNVDH75+beJ63aOpTQd1R9v1XcD0GdOCCx1gIx5d
    eo5koWWEF45kKQy9MLdBO5024/Qw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U9NnnwrL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sqKa7VrC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N4C+BVdY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=U9NnnwrL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=sqKa7VrC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N4C+BVdY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTkEI66a9xZ4bNxDJWNAtSJPcwKQvNQBGyQmdQw8fAsuuIO+ZkuUwhV9G6az+AJ/Dz/NdLJa8yDXLvPq+zOdlA2gCguu5ummqZ7lUCYvvS1WcF0CjH5
    x+iXyHCZr9G/7MbMf8gXnVKBuRq5j4loqwP2wtHwmmSDvC4i7Sn82MDxRujPkDIeSvlWi8lKPGGOZG+5zx1efbGbSIWq67kQDpAlHzM5AqsfKgsh1PnJjo8E
    wN2HB+ek8umzoYMIjdGTRg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=9qT49oP9OcZM68Mw1QQA:9
    a=sBXk-BIWODszrEqo:21 a=9irfx8GaDnYMu7FP:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeDDB6H (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 21:58:07 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36218 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDDB6F (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 21:58:05 -0400
X-Google-Smtp-Source: AIpwx482W/SvaXFztJiymv5Y+6CQ4qnJDFh58t++je78jBtxKIIWjQA1F6R1PCAuWfC8+urL/Rod7kb3z4tff8SiucU=
MIME-Version: 1.0
In-Reply-To: <CAFbkSA0ursG3RGWU19LQiD6u30h5V=Aqj3oVyHQCiX6MLopYUg@mail.gmail.com>
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
 <CA+55aFwhi=gz3HLoGST9--n1_kLJNP6jsf8GSesSFxTDCdPdtQ@mail.gmail.com> <CAFbkSA0ursG3RGWU19LQiD6u30h5V=Aqj3oVyHQCiX6MLopYUg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 3 Apr 2018 18:58:03 -0700
X-Google-Sender-Auth: SwEPnjFBhkDS4mBJUdknFg354rI
Message-ID: <CA+55aFwGmbNCjHpXHhtMWLobVkX=eq6_xEg=42jQ+M-EK4Tq2g@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Justin Forbes <jforbes@redhat.com>
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
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 6:30 PM, Justin Forbes <jforbes@redhat.com> wrote:
>>
>> If there actually was a good explanation for the tie-in, it should
>> have been front-and-center and explained as such.
>>
> Honestly, yes, the major distros have been shipping this patch set for years
> now, and every time it comes to upstream, the same damn arguments emerge.

Well, I think it's because the explanations have been bogus.

Just look at this thread. It took closer to a hundred emails (ok, so
I'm exaggerating, but not _that_ much) until the *real* reason for the
tie-in was actually exposed.

For the first 50+ emails, the explanation was "oh, only if you do
secure boot does this make sense".

Which is still pure BULLSHIT. Of _course_ that kind of stuff raises
peoples hackles and makes people not trust the messenger - he's
clearly being evasive and there must be something else going on.

So instead of the bullshit explanations, just explain the purely
_practical_ side.

Because I find it a *lot* more convincing to hear:

   "We'd like to just enable it all the time, but it's known to break
    some unusual hardware cases that we can't fix in software, and we
    wanted *some* way to disable it that requires explicit and verified
    user intervention to do that, and disabling secure boot is the
    easiest hack we could come up with".

See? No bullshit. Just straight talk about the *actual* reason why
people decided on this particular tie-in, and admitting that it's a
hack, but also clearly stating the reason for the hack.

Now, I still don't necessarily agree that it's the best possible
option, but when stated in those terms I at least understand why that
option was picked as a reasonable one, and it changes the discussion a
lot, and (at least for me) makes it much more palatable.

Because as long as the explanation is just some "you must use secure
boot or you've already lost and further security is pointless"
hocus-pocus magical thinking, I immediately go "no, that sounds
completely bogus, and it makes testing and coverage much worse, we've
done other things quite like that without this secure boot tie-in".

             Linus
