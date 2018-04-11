Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3039319-1523471734-5-10303318807000927509
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523471734; b=FfOOp7WGn2A8MGr1JjhYkJEuNL/CEwbaFlvSfiEWeD8f3UR98L
    fiXr1sB+Qqmjgk+XZJ3t9IAP6mHiaq8VIztFhC29rVD2QzlW28N0c9PCfWwagTOZ
    NCbobN3eirT+AhyD/Zlfog5blZul5FyfNWWaLx1GXaJH7QHupkiuNqy3POvu7qnr
    3eCqlbUpiScHjb8Bo6w/NrxIF5Jg4zVhqWCX3QO21G8+WgsiL44SGV0TlA8I8dTi
    e8/J5sD4DIUzA85nixycDywZvBLKqT6W+9BnJ0Z1YsonEUKSSJ/c28A5maG7aamE
    cMkLrhso6DYbEndcnbHFFZY5L6iy6o2IVrAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523471734; bh=r+i3qMHB7YQghww+Mei3Od5qw/ErYCH6Dmx59gt5XH
    s=; b=ofHqcBeNWL7OGHyY8u1AJIX8dUJCEGgDfFxLbYjkMbPjpks/b0E8PMvTZz
    KaeI7OXE61ASyKYMmYwCYnK39t/A4znha0tzs3b/9R2GkC4vaJGJenVDdXNd5qrS
    2ngDYRzRCgqhJdOe256wOKREb+VIs9K69JQgFKZbCOd1YYyl/oW8v5C5MMnYQqeH
    /7WyqxEhiZnkKRY8UDglmUgrliyOIggFL3vLVhNT2YtCVIPp3GFYzZZUxXQwE5eD
    ppTfXPOQ7QPWixcbv5q/izJf5FWVnTi+LXIDvFTBlzbcaZBYg9k12wSGHHmqoz4Q
    zQERBNiPxhstazeGo9/n2AdybjAQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linuxtx.org header.i=@linuxtx.org header.b=PAJqGwhh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxtx.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UVqsQnMX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxtx.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=linuxtx.org header.i=@linuxtx.org header.b=PAJqGwhh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxtx.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UVqsQnMX;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxtx.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFbz8q9D8h1c6GkvHQUBKWcaxaqnMosBchl8PmXvlisBKHwPblLmvFWJulw7z0k6K/B3SxZ2haHxc2s/l+mm+F4DWCn7XD2KBaptZXXqTwB2O4bUew2j
    8sdtp83UcSHb9rz0IgQA3L+z+vYF1lcn6gDQIOJs1ffKogX0+3xlEWiFsdjVIwwHPRqkmp9WQTs4apQA6nfqw+C+3IKANg3kacmWeWm2LgYbA6t0TUYa1wcD
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=c8CfeJAGUBVAh792mY4A:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753231AbeDKSfc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:35:32 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37531 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbeDKSfa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 14:35:30 -0400
X-Google-Smtp-Source: AIpwx4/gOQsWnQ4TmNCWdXqFZffo82wHkgIp+oqd79vuy5Okg3WJWrw9B0oRgJMcMoygX/KXamYl45zV2ZwBy0ogDqY=
MIME-Version: 1.0
In-Reply-To: <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
References: <152346387861.4030.4408662483445703127.stgit@warthog.procyon.org.uk>
 <152346388583.4030.15146667041427303547.stgit@warthog.procyon.org.uk> <CA+55aFzPo-dip8dgyo0U+g5qai9SAJU+D1c+AFJ0zV9_PBAB8Q@mail.gmail.com>
From: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 11 Apr 2018 13:35:29 -0500
Message-ID: <CAFxkdApe5gFJC2RZi-aQ0jTMDabi3QR5AnJde5QT7aVfTvzoNQ@mail.gmail.com>
Subject: Re: [PATCH 01/24] Add the ability to lock down access to the running
 kernel image
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        James Morris <jmorris@namei.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 1:09 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Apr 11, 2018 at 9:24 AM, David Howells <dhowells@redhat.com> wrote:
>> Provide a single call to allow kernel code to determine whether the system
>> should be locked down, thereby disallowing various accesses that might
>> allow the running kernel image to be changed, including:
>>
>>  - /dev/mem and similar
>>  - Loading of unauthorised modules
>>  - Fiddling with MSR registers
>>  - Suspend to disk managed by the kernel
>>  - Use of device DMA
>
> So what I stlll absolutely detest about  this series is that I think
> many of these things should simply be done as separate config options.
>
> For example, if the distro is sure that it doesn't need /dev/mem, then
> why the hell is  this tied to "lockdown" that then may have to be
> disabled because *other* changes may not be acceptable (eg people may
> need that device DMA, or whatever).
>
> If that /dev/mem access prevention was just instead done as an even
> stricter mode of the existing CONFIG_STRICT_DEVMEM, it could just be
> enabled unconditionally.
>
> So none of these patches raise my hackles per se. But what continues
> to makes me very very uncomfortable is how this is all tied together.
>
> Why is this one magical mode that then - because it has such a big
> impact - has to be enabled/disabled as a single magical mode and with
> very odd rules?
>
> I think a lot of people would be happier if this wasn't so incestuous
> and mixing together independent things under one name, and one flag.
>
> I think a lot of the secure boot problems were exacerbated by that mixup.
>
> So I would seriously ask that the distros that have been using these
> patches look at which parts of lockdown they could make unconditional
> (because it doesn't break machines), and which ones need that escape
> clause.
>

Optionally, it might make sense to add separate config options for
each of these pieces which can be unconditionally enabled, and a
separate option for secure boot which selects all of them? As much as
I hate select, it might make sense here.  Of course the flip side to
that, is users no longer have one big switch "turn off secure boot"
which turns it all off in case of trouble.

Justin
