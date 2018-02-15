Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2542822-1518732236-2-17149597830120183431
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518732235; b=CUeuZQN+/h8qNWy4YBODxrxLYg4hkQX4A6wIaHwwW9AeLwk
    1tcnhpffBdFSQHKOfEPS2IIPNm0A1R+Cqf0DVDPiY0+8zVLiWLPVGy6kdxOFHxqf
    gvs6aR4PNNnGBEp0iDllcU6G4yZDwb+HDPlkXJ5SNpCZOovCs2jLnQVRJIiWRgjq
    /zGazJr2F4IzR9ROypyfYWH1K+CDVD9Z0ZihkjBMADkbv4Rt/tWb9G7eAW2ceM5h
    zwntm0LXVIyzYO7p0keFDpFU7a5KYBiYVhE6JfM9hW5sZw+D8MgctcbmzTbXbn3f
    8JbeVb9ln0cO9OUT3ulT41jOqI6Xyx3GK14nCHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518732235; bh=WSvqLp6LfKkho5iW8GL6hr7b3kaDQoiQ2UmvHs
    m0f7U=; b=i4tIrdfJOx2aBaooBc1cVJlp5UDqLZ6I2LWZNFMjWw4ja9Xc+a9Ffj
    Dks2eayykDopnxexip6hzU8dT/8nexfsKyyfsFA39xHzpAj4pMsyLASCAPMTx92k
    Y5Br/FS7fnI4BXVk4UJWLbzIaf+J9FtUEpcjjZYaDB9xfOgpDm+L3jT2JbYZxT1l
    018IsJH7V5A5SbFfsT1FUZ+s/V+XGBqGd1yfCajhm4/ssvxWL5nlkRlkXm5U1sdD
    FQImgpyC3tMoqbIb3y3c6Ja10kmtu+ydZj7nfzhac7Y1LbvYpb/isIX3m/Q/6nzE
    c27uLOXl/oTnkQJTEfEaZdaztXwgk8RA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OaIomgt/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F9HlQ1KN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OaIomgt/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=F9HlQ1KN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162984AbeBOWDx (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 17:03:53 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:39051 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162966AbeBOWDw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 17:03:52 -0500
X-Google-Smtp-Source: AH8x225j4nh2eWztW2RwEabob5f/10QWXOTqfAGdG1gUCwyFhZKho0y5PLh0KtGmMaUqPcfeajQrIc1I2N/+fdD1IVM=
MIME-Version: 1.0
In-Reply-To: <CAPcyv4hFn7jXLY43xTVPgzXVjECkpqhuj24mn5XXAyjiJq3Hyg@mail.gmail.com>
References: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
 <20180215195209.15299-1-linux@rasmusvillemoes.dk> <CA+55aFzYyWLiWb_O3KFZiJAZPzoopaa2cuj8ByWDi4ERjg0ZHw@mail.gmail.com>
 <CAPcyv4hFn7jXLY43xTVPgzXVjECkpqhuj24mn5XXAyjiJq3Hyg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2018 14:03:51 -0800
X-Google-Sender-Auth: 0utQtXn6uejwmQgE0Pb0CcMOR6g
Message-ID: <CA+55aFz7g4wuwgc7hNFfYf+OqgPax3-F=yz8Xar7iemTin=FEg@mail.gmail.com>
Subject: Re: [PATCH] linux/nospec.h: allow index argument to have
 const-qualified type
To: Dan Williams <dan.j.williams@intel.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        stable <stable@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 1:56 PM, Dan Williams <dan.j.williams@intel.com> wrote:
>
> So I don't mind removing it, but I don't think it is garbage. It's
> there purely as a notification to the odd kernel developer that wants
> to pass "insane" index values,

But the thing is, the "index" value isn't even kernel-supplied.

Here's a test:  run a 32-bit kernel, and then do an ioctl() or
something with a negative fd.

What I think will happen is:

 - the negative fd will be seen as a big 'unsigned int' here:

        fcheck_files(struct files_struct *files, unsigned int fd)

which then does

                fd = array_index_nospec(fd, fdt->max_fds);

and that existing *STUPID* and *WRONG* WARN_ON() will trigger.

Sure, you can't trigger it on 64-bit kernels because there the
"unsigned int" will be small compared to LONG_MAX, but..

It is simply is *wrong* to check the "index".  It really fundamentally
is complete garbage.

Because the whole - and ONLY - *point* of this is that you have an
untrusted index. So checking it and giving a warning when it's out of
range is pure garbage.

Really. That warning must go away. Stop arguing for it, it's stupid and wrong.

Checking _size_ is one thing, but honestly, that's questionable too.

                  Linus
