Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2389629-1522788910-2-14729837213413806190
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522788910; b=HOtZ6XI3imVI04hm/YcIgvVRTdf4vuwDHeOmxWLHRopngS/bzp
    2hQ9LCDy/fbtFYWrFPCqAbYYxrkDVVD0CKP9JjuW8ji3PTkJt50+uwP6EkYRcH11
    PFWf3/Na16bty0p8EpPDl6BLGOVYH53dhfX4+EGH0kqMcXI7rblEkrYS2zJNfZfW
    JUEGCkUKrSstv+fTSrdnDLJKVujiPnvd7wegItPy9tkSX7ztnx8gv3Fv6uc2RfBh
    uaU8ngbTn79faARXLtR1/yGDX2JVpdUZSNH/tMdLaHAHLwPrJLS9koD0vevi5z4R
    1v8VOMFLfwRbeDS72N+vUsXbCAgqKmIqJpAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:references:in-reply-to:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522788910; bh=Lrgi4FcR+ioypRgmOryGTmI9tCRQ3sHZ1jhoRubxJB
    w=; b=TMvLAaJ44e769R0Mz+oOtlKADAqH1F0ES3XdLEGP1+z2o2b8xfQBsVt02T
    ZVO22aXO16ueTOG6gr46xH0DQ5gF26moOAK2mRXX/D7MZBrkiPM9XV2Hht1B8Q+8
    vnKqgCr56nTcTDR9PFCiT/LDFOtl0acgGAu322PxOBFy5qF81oU1R7ZmGDZ/qqWt
    pLFyJITIvwRgXAyfaHiFFhJOJ6zD8H8IH2KT7iNSXa7gpV2T/BjPFAIXJ7sty1fO
    V1M8l/wovmP6Np5Qk3h2DuFHdD8MNKc02u4+brWtuTRi/lldfk3hkDVk/wuI1IZS
    JwWWlZq6HTASBPJRvDlWAIIInrwg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=nuTxS9vp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M/nPG1U4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=nuTxS9vp x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=M/nPG1U4;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGd4s6kVrxoLa250m2Rll0MBAEJOYPdnGqVyObtjXumT0qTLDGqD+PtaJVs+6haUAiO6i2MDrBB/8Nnm+nj2JsrWhKW5NaIgIfNrUW+AbwJsF5B5oaZc
    EmhTFksWPJoqjmGoRwRZ+XA879YK0+nlYcH0DW4SNb6lGiWnaq77sFNJ051CMTkZTLj5IJ/NglJxguvC6aduXNUyAgKZXzYxE9o51Hfrw+SrJgz+oLQkDSZA
    p5YM+G8w3Sbej+lyYR6T1A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=1XWaLZrsAAAA:8 a=VwQbUJbxAAAA:8 a=mJy2-CvJIt31arywD5cA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752495AbeDCUzI (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 16:55:08 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:36537 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752863AbeDCUzH (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Tue, 3 Apr 2018 16:55:07 -0400
X-Google-Smtp-Source: AIpwx4/fbsApbYrdWpVgpUszuES/shRgt/lLs80V4ZkdP1o8j2eimruyoHm9HyJ+tXWPqbWrzcIdD27t4C0NlqdUIhM=
MIME-Version: 1.0
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org> <30459.1522739219@warthog.procyon.org.uk>
 <CALCETrUFOdrH5ShCCd8yguGjC2NtG8fJY7AW26HH467-02UVGA@mail.gmail.com>
 <CACdnJut31+ZtiR40nkOjm89cfUxS0EM=w-oG69PtWHbXYJQxPg@mail.gmail.com> <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
In-Reply-To: <CA+55aFy5EPxAyqyGGaYUUyakuLbjXHiseWCkz-oNdo=Y-878tg@mail.gmail.com>
From: Matthew Garrett <mjg59@google.com>
Date: Tue, 03 Apr 2018 20:54:55 +0000
Message-ID: <CACdnJuuXOP5T-BRAwMvc7XF8S49wyvp4ZYgcU=EZkaGNgPAQig@mail.gmail.com>
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

On Tue, Apr 3, 2018 at 1:53 PM Linus Torvalds
<torvalds@linux-foundation.org>
wrote:

> On Tue, Apr 3, 2018 at 9:29 AM, Matthew Garrett <mjg59@google.com> wrote:
> > On Tue, Apr 3, 2018 at 8:11 AM Andy Lutomirski <luto@kernel.org> wrote:
> >> Can you explain that much more clearly?  I'm asking why booting via
> >> UEFI Secure Boot should enable lockdown, and I don't see what this has
> >> to do with kexec.  And "someone blacklist[ing] your key in the
> >> bootloader" sounds like a political issue, not a technical issue.
> >
> > A kernel that allows users arbitrary access to ring 0 is just an
> > overfeatured bootloader. Why would you want secure boot in that case?

> .. maybe you don't *want* secure boot, but it's been pushed in your
> face by people with an agenda?

Then turn it off, or build a self-signed kernel that doesn't do this?
