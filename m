Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2485749-1518731816-2-14787780849940596542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518731814; b=W1fh+ddIemlXLeXN5tHry9wX6uAUtP6oyzZeGnlVVM+qF2q
    stikcyd7B8+gCe4lwercMu61KQlc56iXV6IRcSmJ/wn6ubt3KYKt8H6VOpwq4CCo
    GWvZB4hx0BeHHKv0RswhENOq/Vy4ibqEyShKqT8sxl9M6YycPJO/KWVjgGNHOCtL
    gU8nWB9aP7yEW+0SPdCu3VQFS65qnH92avwuxa7syLxNtE83uuxe44Ynm0uodlQY
    bhD1Lg3XfcU125ISKEz6pAB7adDyhJ+qpCrGShsIYVa4EGrSJ6xhAuqMa1wVopql
    n+S6zN+Dv53dcX0uVoDDeNjdfXIc4NjMztfEGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518731814; bh=09zs9apo26gfw+1jhcfpVt7suQhOypABdiKC8V
    z7Ta4=; b=lwZl7Qaz8Yij4QDli+beFcYPYPY0uz7TQ700O9JI3TZ2ZXqHZZdqRj
    B7EJqBU05MkoUtCCBYv1GVWaophCl+D+EGIvtBWtKlWjiZwq66geohcUGDguNFNs
    wBO5pzGKXkxBVrVtUTEO6sogeLyyBcD5jj96lM9603GHU0jdtPb21kRZZIo9mC7W
    +21cUWhAb5WRamGl7i8kWgionQKxYPA69FjsgehfH/b1rnAUt/QeBKEyAfTnD8r7
    TY3usR/7q1JPHWRrz4siCo2/lPqdzQys1RJw2AYND5mq2qvr7WaBRuWTrpOv4E5z
    FIT5fXlJT1OAFQi75pYkt56gO0Ec+GGA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=u9DjIS3u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sTgAY8fJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b=u9DjIS3u x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sTgAY8fJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=intel.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756027AbeBOV4Y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Feb 2018 16:56:24 -0500
Received: from mail-oi0-f67.google.com ([209.85.218.67]:47020 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752349AbeBOV4X (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Feb 2018 16:56:23 -0500
X-Google-Smtp-Source: AH8x224hVpZ679MrxkU1Tcfn3wAYV0cmJks+AwoVEDZRybC4EnWFu190suUDhLxwC6d1aFbvvEEp2vioVpCiAtfC9Ao=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzYyWLiWb_O3KFZiJAZPzoopaa2cuj8ByWDi4ERjg0ZHw@mail.gmail.com>
References: <CAPcyv4i-bULZp1WTUgUVtdEY5i_fTGkFWKBsVLDu6dsuxUwoug@mail.gmail.com>
 <20180215195209.15299-1-linux@rasmusvillemoes.dk> <CA+55aFzYyWLiWb_O3KFZiJAZPzoopaa2cuj8ByWDi4ERjg0ZHw@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 15 Feb 2018 13:56:22 -0800
Message-ID: <CAPcyv4hFn7jXLY43xTVPgzXVjECkpqhuj24mn5XXAyjiJq3Hyg@mail.gmail.com>
Subject: Re: [PATCH] linux/nospec.h: allow index argument to have
 const-qualified type
To: Linus Torvalds <torvalds@linux-foundation.org>
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

On Thu, Feb 15, 2018 at 12:59 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, Feb 15, 2018 at 11:52 AM, Rasmus Villemoes
> <linux@rasmusvillemoes.dk> wrote:
>>
>> This way, we can allow index to have const-qualified type, which will in
>> some cases avoid the need for introducing a local copy of index of
>> non-const qualified type.
>
> Ack.
>
> That said, looking at this header file, I find a couple of of other issues..
>
>  (a) we should just remove the array_index_mask_nospec_check() thing.
>
>  (b) once fixed, there's no reason for that extra "_s" variable in
> array_index_nospec()
>
> That (a) thing causes horrible code generation, and is pointless and wrong.
>
> The "wrong" part is because it wants about "index" being larger than
> LONG_MAX, and that's really stupid and wrong, because by *definition*
> we don't trust index and it came from user space. The whole point was
> that array_index_nospec() would limit those things!
>
> Yes, it's true that the compiler may optimize that warning away if the
> type of 'index' is such that it cannot happen, but that doesn't make
> the warning any more valid.
>
> It is only the sign of *size* that can matter and be an issue.
> HOWEVER, even then it's wrong, because if "size" is of a signed type,
> the check in WARN_ONCE is pure garbage.
>
> To make matters worse, that warning means that
> array_index_mask_nospec_check() currently uses it's arguments twice.
> It so happens that the only current use of that macro is ok with that,
> because it's being extra careful, but it's *WRONG*. Macros that look
> like functions should not use arguments twice.

Yes, that piece is new and I should have noticed that breakage when I
reviewed that patch from Will.

>
> So (a) is just wrong right now. It's better to just remove it.
>
> A valid warning *might* be
>
>     WARN_ONCE((long)(size) < 0, "array_index_mask only works for sizes
> that fit in a positive long");
>
> but honestly, it's just not worth the code generation pain.

So I don't mind removing it, but I don't think it is garbage. It's
there purely as a notification to the odd kernel developer that wants
to pass "insane" index values, It compiles away in most cases because
all current users are sane and have indexes that are right sized. It
also used to be the case that it was only used when the arch did not
provide a custom array_index_mask_nospec(), but now that it is "on all
the time" I do think it is in the way.
