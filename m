Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2421993-1518728402-2-16412659088652513911
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
    t=1518728401; b=j7E2SJdzWReXCna7TIr+PvU4haNfmCBIr/8YP0o7kyV2Su7
    +zu6AR5GEzEVfWBFDfX/pr6IicWX8KAMQ+H5jVZcS6/P3rzXPXtSYDGaPDYWz/TS
    IVgFy8YAM1LxibCUdk+z5HKUpIvfm5cpQZ9BkM/KvnUkR8TacZtK9gpySN7O7V/x
    zBeyZsZFKLh2Th4GZdRSvunzaq02/1enTvZajb6XIJ5EYjGipE3lIB83CJ6BM74I
    rnypQhF4n0zYZfyPVIgwt0P3IeU+czW9N7RMN21mT9TvXvOmiEWfiEM5JpJo0tVS
    GoLygctj9h45LRMF+z3957F4pWwpSck/eTEDspQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518728401; bh=pMS038pvPkl3VgY7Io+JyDX0Y2mlUhyZrOJqyd
    9Sn3g=; b=gpC3wwQ+H3aN2b2r7KD9HKUMvFHqnbqa/+vrTjRySdHcKc/DuwYbVp
    2WBjjFUviooQZKHYBukubnv1UgM+HorW4cH8EjOWfOQO9MTmJTruSxFoGxmetcqa
    pSsDaRzrfFGKdS/jsQbv8GjxhkYMGmBvGaqQzVLN9U4DT660NA9pR5c3cVPuUedO
    uS0+c8ZxpIDvAftmeK/RMJneh353aPt5s2JGwtDgbYK+1bmjjQnrg+DEfHkfTRU6
    YcwG02F5aPv8GIkW5TNzKWvTqFsP09/8RCFhuWzKjlqHvWJLFaygezUlHAF6XZiA
    IlqBCX7Qa+6bfYqt/X58/QgKqSGSDTMw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AWqeSqav x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EuTNjHIY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=AWqeSqav x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-foundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EuTNjHIY;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-foundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163254AbeBOVAA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 16:00:00 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36494 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162995AbeBOU77 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 15:59:59 -0500
X-Google-Smtp-Source: AH8x227u1n8dOROkKYKEXYCumgCdb/HdM+4Elv8U+WNbXmLkpxGSr8SFgxSqFmalL1B9GEukpt7NR7HZiSK45tph97c=
MIME-Version: 1.0
In-Reply-To: <20180215195209.15299-1-linux@rasmusvillemoes.dk>
References: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
 <20180215195209.15299-1-linux@rasmusvillemoes.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2018 12:59:57 -0800
X-Google-Sender-Auth: l90_Co4jDxAK2gmmVo91keouAJM
Message-ID: <CA+55aFzYyWLiWb_O3KFZiJAZPzoopaa2cuj8ByWDi4ERjg0ZHw@mail.gmail.com>
Subject: Re: [PATCH] linux/nospec.h: allow index argument to have
 const-qualified type
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
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

On Thu, Feb 15, 2018 at 11:52 AM, Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> This way, we can allow index to have const-qualified type, which will in
> some cases avoid the need for introducing a local copy of index of
> non-const qualified type.

Ack.

That said, looking at this header file, I find a couple of of other issues..

 (a) we should just remove the array_index_mask_nospec_check() thing.

 (b) once fixed, there's no reason for that extra "_s" variable in
array_index_nospec()

That (a) thing causes horrible code generation, and is pointless and wrong.

The "wrong" part is because it wants about "index" being larger than
LONG_MAX, and that's really stupid and wrong, because by *definition*
we don't trust index and it came from user space. The whole point was
that array_index_nospec() would limit those things!

Yes, it's true that the compiler may optimize that warning away if the
type of 'index' is such that it cannot happen, but that doesn't make
the warning any more valid.

It is only the sign of *size* that can matter and be an issue.
HOWEVER, even then it's wrong, because if "size" is of a signed type,
the check in WARN_ONCE is pure garbage.

To make matters worse, that warning means that
array_index_mask_nospec_check() currently uses it's arguments twice.
It so happens that the only current use of that macro is ok with that,
because it's being extra careful, but it's *WRONG*. Macros that look
like functions should not use arguments twice.

So (a) is just wrong right now. It's better to just remove it.

A valid warning *might* be

    WARN_ONCE((long)(size) < 0, "array_index_mask only works for sizes
that fit in a positive long");

but honestly, it's just not worth the code generation pain.

             Linus
