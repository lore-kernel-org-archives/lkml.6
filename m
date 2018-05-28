Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-280420-1527499958-2-8488477589975509357
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527499957; b=hbLu0YG/zZG6INTeQ3LvaQkcD3iL+hfJstzvZarBlZ7pRQTKFt
    9hhtQqDkAAwjzWZnHXo1jBJcsgwOKIOk7jleA2wFPO3lR3lwJ4TqoVWKqW06gSY4
    JEkQ+u43tm5s7rRM2ejJUELPqHLZObGZvwn4aKC79dXeBfSPi55lgRgxAnX4Hj1U
    ZIUQqG3Vzh7R3eskPgQIAq7tFVlbtbDaLQ1dOp2msHOs9IhFcI9PGKjK2t0JlqyX
    XsaJzgnP+0efxlcoBfVx8iCA+DFIVlKxAKpvQlhulMpMQ/3awaj5FjL7rS5LKTRm
    Ai1VKHcWXehbAz6JMbQV+ZvK7Kl9W0AtOVGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527499957; bh=lt3vMmGgeUvaVgCCC0uVH1VOvxV0eSuC0a+j9165E0
    k=; b=ScwWufGKWU63QduMTuHjp1xC14Sa2Sf/51+B0nqFaMgg7tuXuHkpLAHSPq
    pEk/BSiceAOME+sAQXICNTmVAjk5ZjVNBnQPSDjxLfCQNGlUk6iu59UTetdP9/F0
    46daqI+EQXdJBNNuuMFfJCfx/Ijc8kKuD2NX4jUVUzHgrUxAvOYtl/+HQrHeLpF2
    V7P5jTjHXrl1Lj6CReOwQ5mJwQhPKd1Q2JJe4McCHiimhogGQVMNzH6pyIHA4jkF
    TsB0VhtW+uaIEhVLWSYO+OLVFG7AII1xAjaniOA7BYdr5A7ZSMkTFLLd2DXL8+KM
    b1FMLAloZVvcv7V8NkDapwzza/fg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=gUiycgvp
    header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=oE2Z95/w;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=gUiycgvp
      header.a=rsa-sha256 header.s=20161025 x-bits=2048;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=oE2Z95/w;
    x-ptr=pass smtp.helo=vger.kernel.org policy.ptr=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIsuucFneAAUbz4m5qiVek6OqIDwBNnrJTjvZt1X0BMJsCUumXdvju0U9d/ASEJQ9n9EqvMrC673h7l5fPi3MMyQeYonXgnJsCQY8MhKqaA+m57r6/w0
    QGsUvSnGdz65p+i5X7yKGC7wTsgGbwlC6HpcuQno3DSe0QjZ9VcZl9jmoxiPjzJhObzhKiX3MyTGTkyxRKprjR5LBw6P7Pl1TkXqMc0uaYd0pHSVSI+i0WYX
    TJ8tQ5y1YWkFcL8yEDmEMA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=8r6i9kuyV-oA:10 a=VUJBJC2UJ8kA:10 a=Z4Rwk6OoAAAA:8 a=cm27Pg_UAAAA:8
    a=VwQbUJbxAAAA:8 a=q4xLdUcud8kkguz4o8YA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=HkZW87K1Qel5hWWM3VKY:22 a=xmb-EsYY8bH0VWELuYED:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754171AbeE1Jcf (ORCPT <rfc822;linux@kroah.com>);
        Mon, 28 May 2018 05:32:35 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:32879 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754121AbeE1Jce (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 28 May 2018 05:32:34 -0400
X-Google-Smtp-Source: ADUXVKJHGWuHbvl+YYVRUJK8qDxO/X02F0o7FqvYAlVG79S5TEZ2X7TKsi+7OWBeQUl1NHMhTSIwlS4JRG6t2y6kfgE=
MIME-Version: 1.0
In-Reply-To: <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com> <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
From: Salvatore Mesoraca <s.mesoraca16@gmail.com>
Date: Mon, 28 May 2018 11:32:13 +0200
Message-ID: <CAJHCu1Ky09DWskcD4nVW5u1C5faWMv1A4kcxWzdiap7+G1SPkg@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Davidlohr Bueso <dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-05-27 3:33 GMT+02:00 Linus Torvalds <torvalds@linux-foundation.org>:
> On Sat, May 26, 2018 at 5:32 PM Kees Cook <keescook@chromium.org> wrote:
>
>> I went through some old threads from 2012 when e268337dfe26 was
>> introduced, and later when things got looked at during DirtyCOW. There
>> was discussion about removing FOLL_FORCE (in order to block writes on
>> a read-only memory region).
>
> Side note, we did that for /dev/mem, and things broke.
>
> Thus commit f511c0b17b08 "Yes, people use FOLL_FORCE ;)"
>
> Side note, that very sam ecommit f511c0b17b08 is also the explanation for
> why the patch under discussion now seems broken.
>
> People really do use "write to /proc/self/mem" as a way to keep the
> mappings read-only, but have a way to change them when required.

Oh, I didn't expect this, interesting...
A configurable LSM is probably the right way to do this.

Thank you for your time,

Salvatore
