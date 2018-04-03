Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-141800-1522717155-2-14409469522756540304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522717154; b=I51AQsLr7qAU+pY26bAKYkziK5bRZtJP3ChH2dHSjUbJqm9as1
    a5LFtlbu+M1NS90cLra4oCBzDEKX7vPuXtAsu5Nywsq3kLfOI9hnUIwd/c4ymguS
    YWBBDjD8lO8K9roxNH/nGli26DeF7Uj/kHXXQGlfK7reiSBZqE2tTdmRaNb6Ttxm
    +/H+K6nY1ScOPfBTH9TIsGvPO/IeSd5MxIgc9QcUpDDfZnpnPEI7r1ZpqZ9MWV45
    Bj4mXEIkpatsMOFH3K2p7nLN3VgginlMS93zUe1tNXJGTnW4TNg8B+nbMd2u4NkI
    uxcX+162dXZmptRCVV43G17JxA2qb5MdT6qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522717154; bh=IRmxydwUSp/C29p0roDUrUb7YpLGw8ibH75yTyjj6r
    c=; b=n2PbqRAwRZaBf+o1Tya+C1tX86uoZDBmH+H2LHVY2wetiOVh2xjVClQ1Is
    tsWvYY2TjdC+/N+VfaDijtsbYDpNDK4vmGawLreXr+IJBInji3OlQNG/ilkzZ3m8
    cdKdqAma/InMaROoI/uTTL1NTtOvcaXAtCwGDpr8wCQYiLSzw7FoVUxiKnVZJ/7N
    CQAIQh/GUWPRbxD6kZk4IopU62N1/ivhCXlagFXQzK1jKru97zLISTwGV9co4C9m
    f6xoKnq0NkNYXekyRDc4efXhERmj6yjRapB2kSvp22g43VhjIyeiNaRaZqC3n/M6
    LIxEtMdbY19wYnpur0OFc3QD89+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=msKnmBZz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fwT9TfD+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z+xyK7PA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=msKnmBZz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=fwT9TfD+ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Z+xyK7PA;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHO5lRMNTKTshT9N/qexdoMQmc4KI1JqsnEwq6voumt49QGxOct7u6JX5FiYCeuqGXyeu0BTW5t6h1qUUyv3WW1Yw+xb9PKf8hfxCodEX588GLbd+HLX
    2b6Oo5Wh9RUyfOJUk0ROaGBYwUrwcXBmCYvd8HMEKkw9Bmz6aKbsZpEecARwGEwUe9N7iHIFUW8RtOlzUkiMUdjC4ZrUDNnVpCyt3ZWWunSue+w9rO47r86/
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=8roLvd9qI6OLlgUwLloA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754691AbeDCA7N (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 20:59:13 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40141 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754604AbeDCA7L (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 Apr 2018 20:59:11 -0400
X-Google-Smtp-Source: AIpwx4/8pfsJC3lKpLyqeFSrbtZQKD8RR+xDMIaXGH3DDBQ5uJ4coHBtK/ivUeb3ttqdqSGNxWWRKV5CaEGScM4ko1Q=
MIME-Version: 1.0
In-Reply-To: <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org>
 <186aeb7e-1225-4bb8-3ff5-863a1cde86de@kernel.org>
From: Kees Cook <keescook@chromium.org>
Date: Mon, 2 Apr 2018 17:59:10 -0700
X-Google-Sender-Auth: a8T4tMJ04ka7T1xm-eZiCotGrTs
Message-ID: <CAGXu5j+UWQWDacMvvRCke3xUOb7uTkxn=WaHzG4kJTKWh-6tAA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
To: Andy Lutomirski <luto@kernel.org>
Cc: James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Garrett <mjg59@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Justin Forbes <jforbes@redhat.com>,
        linux-man <linux-man@vger.kernel.org>, joeyli <jlee@suse.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 2, 2018 at 5:37 PM, Andy Lutomirski <luto@kernel.org> wrote:
> On 03/30/2018 05:46 PM, James Morris wrote:
>>
>> On Sat, 31 Mar 2018, David Howells wrote:
>>
>>> Date: Thu, 26 Oct 2017 17:37:38 +0100
>>>
>>> Hi James,
>>>
>>> Can you pull this patchset into security/next please?  It has been in
>>> linux-next since the beginning of March.
>>>
>>> It adds kernel lockdown support for EFI secure boot.
>>
>>
>> Applied to
>> git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git
>> next-lockdown and next-testing
>>
>> Are there any known coverage gaps now?
>>
>>
>>
>
> This is an attempt at a review.  I'm replying here because I can't find the
> actual relevant patch emails.
>
> Cover letter:
>
>> Here's a set of patches to institute a "locked-down mode" in the
>> kernel and to trigger that mode if the kernel is booted in secure-boot >
>> mode or through the command line.
>
> I think this is seriously problematic in that it's not well defined.  It
> sounds like "locked-down mode" means "make me feel good about something".

Naming of this feature has been multi-year bikeshedding, so if we
could just leave the name, that'd be nice.

> For the rest of this review, I'm going to pretend that you actually want two
> features: "try-prevent-root-from-corrupting-the-kernel" and
> "try-to-prevent-root-from-reading-kernel-memory".

That is how I view it, yes. It's about creating a bright line between
uid-0 and ring-0. The most powerful of these distinctions was made
long ago with signed modules. It hasn't been enough, though, since
there have been many ways for uid-0 to read or write kernel memory. My
expectation for this was to reasonably fill all the remaining gaps.

> Also, there should be a justification that allows normal people (i.e. those
> who are not involved in the UEFI signing process) to understand *why* this
> should have anything to do with UEFI.  I can very easily see why it would
> make sense for a UEFI authenticated variable to tell the kernel to enable
> one or both of these modes or for there to be an authenticated mechanism for
> the bootloader to tell the kernel to enable it.  I do *not* see why the mere
> act of using Secure Boot should have this effect.
>
> In particular, UEFI Secure Boot should *not* enable
> "try-to-prevent-root-from-reading-kernel-memory", which means that, unless
> you actually implement the split, you should drop a bunch of the patches.
>
> In fact, I think the kernel should try to get away from the idea that UEFI
> Secure Boot should imply annoying restrictions.  It's really annoying and
> it's never been clear to me that it has a benefit.

FWIW, I've never been a fan of this being UEFI-centric: more than
Secure Boot needs this. For example, Chrome OS's static root of trust
and boot firmware isn't UEFI, but it wants this feature enabled.
Chrome OS would set it on the command line, since the command line is
part of the signed boot image along with the kernel, etc.

> "Restrict /dev/{mem,kmem,port} when the kernel is locked down": this should
> probably split into one restriction for read and one for write.

I think splitting read and write is only useful if there is a use-case
for only blocking one of them. I struggle to imagine allowing write
and blocking read, so really it's the case of wanting to allow read
and disallow write. Is there actually a use-case for this? In all the
"locked down" cases I've seen, both are desired.

-Kees

-- 
Kees Cook
Pixel Security
