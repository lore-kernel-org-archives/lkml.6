Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2955833-1527432113-2-10037764162502724745
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527432112; b=Bgj/wdxYnxL1ROlxT3anQDcpv281hNcYrbpqq8o7/Lqq+F0j0o
    KmQ8AOBus45XH9DE7+pT1LKc3lCxZ2jER7UwieBUSUcE08azFard/56TbFUhhpYH
    rjYhlj97pqDP7iQdGLnToUP2gXoLGyiL60QoVcmQJWomPXExUMj/SAlkKVy7W0yp
    VulsYYWdS2/INaj5vGnjYj0VCMjiUhHsuu+o+HCjYIjkss+UP+sRcDv0Dt5SwpJZ
    yjKTblMGv5ToQNj6JYtn41PmamQXIN7EErnWx68c9vbve9STsaSkCx64axgxjM51
    HZQ3ll4BXqtxO2UlxxkYNGrhDPFdguYYM/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1527432112; bh=9ipuLu7e8NbqP7Xv60oArnFmet3EKUDj4pGFB/jb+s
    E=; b=QFUyXUJ8alvwIGo9Sbt2FQsT1/SBgaKIvjJXnxFXArXqZqhNNZ8HQ7bXN8
    Cl0b5xgXen9ZKRuGMhTOHf3As5usHdnoBp7JbS5t3AydZh0qBE1KBJ+9+VLGCwWo
    YW0ECrYpK35Sa90irBWoUrDuUDqidw5tL3bQ5GuAEKIZXfkwtu9sdc+RZSAYlWHV
    WXnhwVW6MB+7G+e0Y4XvsA/JNsX9irI5oZlO4EOk/67t7qxTWhq4IrgpTrNkkayj
    kjH9sDUFe5fbkoCpzFPy9Oua8MToQRLxjOYZYHseJhXGqlUffVKiJAaek/N/ARVn
    gwJFLLrTy62V+NPwyDxnF8XG8Grg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
    header.d=chromium.org header.i=@chromium.org header.b=YAclngd5
    x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=rn4Zgw06 x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=EMo3++l7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=chromium.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 1024-bit rsa key sha256)
      header.d=chromium.org header.i=@chromium.org header.b=YAclngd5
      x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=rn4Zgw06 x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=EMo3++l7;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=chromium.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPiDo6ST5o7i/XGiRHUIQqdks9VBckE48ZSPtd4JAfniBkJBw/KLTbiQS6tVE6JyROEwbDR16r0miRxMu0XVKXKiSbrllhd5OsQ58I41IUYiFp6AoAjh
    mYRkuVvZ9Atu+rAvFfQRsAyYP6je1F21cXa677ReW/kuElgRhboGuM3gfInAUfBDvsppYl4IFF2oCPTEKSyb1fjhTzywtfViGwV+3yyu3b3HKHqdyHqDpco9
    FzEXqTG7c5uppqlGscviPQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=h-S6D512bQwJWK2uGKkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=HkZW87K1Qel5hWWM3VKY:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030337AbeE0Oli (ORCPT <rfc822;linux@kroah.com>);
        Sun, 27 May 2018 10:41:38 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46335 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032669AbeE0Olg (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Sun, 27 May 2018 10:41:36 -0400
X-Google-Smtp-Source: ADUXVKL8OcHj7GsAwLpbVfutX4eAWKSlXM7++vtyCl5e5ECauFJYpG0MkvpQXMJb9Gz3t4q7EIfRN5erEoohvUKX4D4=
MIME-Version: 1.0
In-Reply-To: <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
References: <1527346246-1334-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5j+PHzDwnJxJwMJ=WuhacDn_vJWe9xZx+Kbsh28vxOGRiA@mail.gmail.com> <CA+55aFx6DBp+d33_fytOGPWw11xg_L0MdGp1M2e5Obc0N9kMRQ@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Sun, 27 May 2018 07:41:34 -0700
X-Google-Sender-Auth: MBxWaeJKZn9g-ucVVcsszG2pvEc
Message-ID: <CAGXu5jK_YfFLKt4vde__bzmhH9SCEz01ET9wyycYkhSSQj5+RA@mail.gmail.com>
Subject: Re: [PATCH] proc: prevent a task from writing on its own /proc/*/mem
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Jann Horn <jannh@google.com>,
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

On Sat, May 26, 2018 at 6:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> Thus commit f511c0b17b08 "Yes, people use FOLL_FORCE ;)"
>
> Side note, that very sam ecommit f511c0b17b08 is also the explanation for
> why the patch under discussion now seems broken.
>
> People really do use "write to /proc/self/mem" as a way to keep the
> mappings read-only, but have a way to change them when required.

Ah! Yes, that is the commit I was trying to find. Thanks!

-Kees

-- 
Kees Cook
Pixel Security
