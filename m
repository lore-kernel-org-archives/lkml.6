Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3414120-1524152812-2-15153654911475479275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524152797; b=X9K86ujxQgRBkNzTgFQPQR9XSg6iONuuFcKVX6FKeVoc+IWkEA
    RfCtggwoU62EXLAl8ijVidbi5Xe/3RY8EZuYIPOlQ3SdjuQhzGgSBJN0di3FiZV7
    t8/W2f0X8cteYt1A4QHlA7XIBrPXuRsw+KBTopk8qWB/PWSlXsnf1M6co/UUluwH
    UEl2KUWk1ANHmO4lL2VGsReWDhCEy74+VBdIj70nAf+bDdnjbD3dASZqurN6ZPVk
    IKb6ozBOC4K4gzdxyRSRyUJDu9obN/0rWjPHGFv9uYE1L6vQgbAV79jpg2TqCw9+
    qAsK9EfMnXU7y9b8s3m2NfbrGjx3urbI7YHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524152797; bh=P4lugnh1Je2CtUQuJK49+3r5G6nMUz0FndpX2ZmO9R
    s=; b=K2y6OBNu1yDe9UHdiJdezru2Azk7pfRF2DivLYwbWxinssrDinLm1Wv6Ps
    U4Q1YyRsnLras5RlypA2qFqrWoteOngo2zrtbcBj8EJs1Qdt5c4qEHOZJK4zV+xd
    gt48gVxEvuWcwZOOz7vwcC5pOfvLixsILr2bjPOAVfZ2/dG5BvuqWNrqLN2lqgAl
    L7fm/fEkmm1Kve41vmAZAegejH3AYjaE6mtn6f3i1e9zeKxp7WPICi9615h5JTc/
    tpOu5zPHIZbUqHesZHSiF57vopujg3/4Q5kHF0nElmsX1OltwNPh7abUjKtn/ug2
    iPazbrHIawOZx0l/hh8k0U1QxJ+w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=panix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=panix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=panix.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=panix.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP2j3iJsLhSCqowaSJlrQpKGk4tkYo3FhtfBO21Ann2UI+K3jhoKOLrwhbjUWgcRCK2x/Yr243q+Yc46yjlUOthe/WIjkGrbzraOGi+9ajPqB/Sukq9L
    i7cZO5s9FjRNdbQ4a+RhvSWpC6rOaSknwiN/e273HDcltmgVlom7qikgp4xaLcudLrPaiuxoxntiLQOCJuzo4LuN5iZmcnT+BveawMQd1hOqKKrJM14O7Vuo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=DTUWVYYc6FLxNi0q3IMA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752899AbeDSPqg (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 11:46:36 -0400
Received: from l2mail1.panix.com ([166.84.1.75]:57190 "EHLO l2mail1.panix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752679AbeDSPqf (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 11:46:35 -0400
X-Google-Smtp-Source: AIpwx48be9fqmuhunWdgbRw2QfJojdIRKZ6YM3HJ8iXlkzej8DkgfQq4ZD+SCzh1flIzCpy2/S2MwdrmEPEfeystRoU=
MIME-Version: 1.0
In-Reply-To: <20180419143737.606138-2-arnd@arndb.de>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
From: Zack Weinberg <zackw@panix.com>
Date: Thu, 19 Apr 2018 11:30:34 -0400
X-Gmail-Original-Message-ID: <CAKCAbMiaX31mpfEMRQrQbPO+kTfowA6=_KhBSs56=zZ1s0aXhw@mail.gmail.com>
Message-ID: <CAKCAbMiaX31mpfEMRQrQbPO+kTfowA6=_KhBSs56=zZ1s0aXhw@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org,
        GNU C Library <libc-alpha@sourceware.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 10:37 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> Most architectures now use the asm-generic copy of the sysvipc data
> structures (msqid64_ds, semid64_ds, shmid64_ds), which use 32-bit
> __kernel_time_t on 32-bit architectures but have padding behind them to
> allow extending the type to 64-bit.
>
> Unfortunately, that fails on all big-endian architectures, which have the
> padding on the wrong side. As so many of them get it wrong, we decided to
> not bother even trying to fix it up when we introduced the asm-generic
> copy. Instead we always use the padding word now to provide the upper
> 32 bits of the seconds value, regardless of the endianess.
>
> A libc implementation on a typical big-endian system can deal with
> this by providing its own copy of the structure definition to user
> space, and swapping the two 32-bit words before returning from the
> semctl/shmctl/msgctl system calls.

This seems generally like a sound approach, but I need to ask whether
any of the structures involved can ever appear in a sendmsg() control
message (that is, in the data pointed to by msg_control), or an
AF_NETLINK message, or any other situation where the kernel
communicates a structured message of arbitrary size to user space or
vice versa.  libc can't munge those messages, because new message
types can be added faster than libc can keep up with them, and because
I/O primitives like sendmsg() generally aren't allowed to allocate
arbitrarily-large scratch buffers.

zw
