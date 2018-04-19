Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2833786-1524134903-2-4751780491871109542
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524134903; b=PAEyeFaclpE2SuJMWvqLHoSyqo/U1yEs1eP45Wx0ihjogMzJbu
    k6c+OiVY9gq2ltbo8zFItqKDZYbH0to3VlXyzg7HsktzT3KKtBMG5rO7oBYDwiNs
    LPyzx5REBdusGaaU/JTF5fekE08azAUba6B+6cm+bZp6NUiw04y9AUzjE81BKW2o
    7+LWe1B5FNMShrxBH86y1dQ/+hTiS2Ogyoda0qNq+OyRWs+zlTloDGFmMdW7rF/V
    hQfNLvv/5KK7ydtSnEYH8PweY98rXWlSBuWwjgpWSD2IE53e9lNPEgB4PoFKhUw0
    4RGGtp1qkeVAHQO+VBoSdB/dmyzLzYbjCxCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1524134903; bh=U7zkjaAZHbzYwoihzj9Q6NBselLyCyE1DVWyd3Q
    PtSM=; b=haJj9xjhZShOMXy7ZqumRc0aLtYHXZiu1eWkTWp0OZSzojwwSSw4Xx8
    RW7f0UP4FWg2ojzzpR+M+2caXJA2ayGg7PHctZArUtPNsKxPR30OgdW2zHT96GPZ
    x96wQhvlLGhIbVlbzXj6BSD6muSb7K5pI+AK9MIvmFIOvbwGGCjxdBMOnbb6voq5
    zlXRK0JW1N3h9ipDszgq+EmiuM4Hyj6y2VkEZVBxreAMxqdvxsjxSHgfykN+F7+R
    FCJ3g8o2EebaPXPKgvIMYScRYHqaBq+gozznjaCypqHjMJHnZWtlhrntOGysKsVH
    XT/2m9FYFHhu0XKd86W/9AdLwlzv4YA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPV4QVuKzOJJQt/DabqJZ+4V+FAiUPKSXfI5FHSCMkOBkSTcWyBrBplZa6VYYY9qD8IXm+h9M2xHgOxxYR1OgNDWRkNmDINfIOhIrp0E1PQ+BbrRGExO
    DQbNSIrwUs1OGdHvTvsrM7qnBU6t8hE1G8A4ERlUTWEAPyKh5JvS1t5BYQYfGr8W/J2BLF3iY00nKx7et+HY+m8V4rzgdTZ4kBHqzKWXZrF21IzsnAno0jW5
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=zBK5yZjOAAAA:8 a=yXamyXGPjskp7YhjAoAA:9 a=CjuIK1q_8ugA:10
    a=l1He_3m2cmAA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=G2qRo79WSoo1por5PxPA:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbeDSKsU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 06:48:20 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39087 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751042AbeDSKsU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 06:48:20 -0400
Date: Thu, 19 Apr 2018 12:48:11 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Arnd Bergmann <arnd@arndb.de>
cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [tip GIT PULL] y2038: timekeeping syscall changes
In-Reply-To: <CAK8P3a2CEK=4Os4gbnXbR7VJJgaXVQ7NLjihr7rvMSK6g3_tNA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804191240510.1563@nanos.tec.linutronix.de>
References: <CAK8P3a2CEK=4Os4gbnXbR7VJJgaXVQ7NLjihr7rvMSK6g3_tNA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, 19 Apr 2018, Arnd Bergmann wrote:

> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git+ssh://gitolite@ra.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git
> tags/y2038-timekeeping

Please don't use the +ssh address as that's only accessible for those who
have a k.org account.

     git://git.kernel.org/

is accessible for everyone.

> ----------------------------------------------------------------
> Arnd Bergmann (2):
>       compat: add an asm-generic/compat.h file

Please start the subject line sentence with an uppercase letter.

>       sparc: compat: allow including asm/compat.h for 32-bit
> 
> Deepa Dinamani (10):
>       compat: Make compat helpers independent of CONFIG_COMPAT
>       include: Move compat_timespec/ timeval to compat_time.h

The proper subsystem is 'time:' not 'include:'

>       compat: enable compat_get/put_timespec64 always

>       arch: introduce CONFIG_64BIT_TIME
>       arch: Introduce CONFIG_COMPAT_32BIT_TIME

At least it should be consistent..

>       posix-clocks: Make compat syscalls depend on CONFIG_COMPAT_32BIT_TIME

'posix-timers:' please

>       include: Add new y2038 safe __kernel_timespec

'time:'

>       fix get_timespec64() for y2038 safe compat interfaces

Bah. This lacks a subsystem, i.e. 'time:'

>       change time types to new y2038 safe __kernel_* types

Ditto

>       nanosleep: change time types to safe __kernel_* types

Can you please fix that and send me an updated pull request?

Thanks,

	tglx
