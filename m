Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1114201-1524681433-2-211468080088126809
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
    1524681433; b=lhL5GmxaftomQfqUP0t2s5ETJrq4EMWEzuara/wLqnZJOhi22E
    /iRvlrqBh9VVoqlb1uOPJaQ6VZbZ5pQKHUrisB65nSa3S718JPvVNZ47Xs4g/s8I
    ve4pfyClNZogR+6g9IUYzEq9QUQ5SdthbvooOXkb5hrccYAwVAqEH2gGjfq4MIoc
    bwErhFhBikyLTXOCPWXpyU8l6fAVvRfKfH6iQ+CmdRr/gfExu69ihoyhsb33aWZf
    mjTNaZY7ZvCb1Oce7on1DEuoJb0jbiaBND2+ePklyB35u2+yoxTH3Bt2y9hOP3ap
    YkJ5sTBbIcVr4TLworfkzflNnKvYIr+AEhiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524681433; bh=18McRVaR64fnqHPmRi5ZLTJrPl96yKMsUU8NeByDYs
    k=; b=FyJutcEi6Q2611jPnNNFRTby3RDrK9DK2qp2hLkn4GioWW4zlE9zUBy0l0
    FBY+6soe1PuskQC4eMJxny1mh9HwYqdyPGuojkLze9WXULZNPjc5M1knypZoLB72
    2J2YQ3PsAWMeNH0gEXIwEg2dM1yJmBV5dRZwUMBuFJ0NVvvYclCwMOsghVGlEQHL
    TTgzSTFGOEjtphRjpW1XUSBurfFxBJEuIvehfxK+KLcsw3ovmvT09xxMMvLRqT34
    hwiGK+wqys/ki6O5di6yJkyI6xhPSSWeX1CtD4pkfuESacjSBYFL6/WW1MUgJzfP
    zn4POOCtrFUQDQM93hOABvNNiF8w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IPKYyZRC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iW7DaaZB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=IPKYyZRC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux-m68k.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=iW7DaaZB;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux-m68k.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfN/5meaTs0I0AEqcOC5IUITJvt8u/osjyGEcsH7QqEXfpM2xMYE/Not1ktEbN4+H3DYFeg2O3EcdbBAfUhxH6GchHP0eynYj0P2jRNYLrrn4XgqSB0Ht
    QDn4Y5FO6y5QfIteum6/8a1nOjAyijpGDh6Kq8+KinacASjaol5Jum03ux10FPLd0sf1KTg1lH3L8l9t5XFwF43CIP0dHF9frJhwavSqim4pvnHb9dzFZ6xz
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=tBb2bbeoAAAA:8 a=VwQbUJbxAAAA:8 a=S7MtJeccQPc5YmvJ8fkA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=Oj-tNtZlA1e06AYgeCfH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756454AbeDYSgu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 14:36:50 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:38703 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756021AbeDYSgp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 14:36:45 -0400
X-Google-Smtp-Source: AB8JxZqdgOT3f4UVji4CgHqQ6u0RaSetpUe6LdAjPmokrmJcYsBA84O+BAYkwrvdls3Y2mThrk4FvQeloTIhgmhTYFY=
MIME-Version: 1.0
In-Reply-To: <20180425160311.2718314-5-arnd@arndb.de>
References: <20180425160311.2718314-1-arnd@arndb.de> <20180425160311.2718314-5-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 25 Apr 2018 20:36:43 +0200
X-Google-Sender-Auth: ZKFqogDv3Iyis0_vWnFzh3Ybuac
Message-ID: <CAMuHMdXzNwNxbrcbJxdh+ON5MU7Wp2OPYriHq9mk3eViXOWaOg@mail.gmail.com>
Subject: Re: [PATCH 04/17] asm-generic: Remove unneeded __ARCH_WANT_SYS_LLSEEK macro
To: Arnd Bergmann <arnd@arndb.de>
Cc: y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        libc-alpha <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        netdev <netdev@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Albert ARIBAUD (3ADEV)" <albert.aribaud@3adev.fr>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 6:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> The sys_llseek sytem call is needed on all 32-bit architectures and
> none of the 64-bit ones, so we can remove the __ARCH_WANT_SYS_LLSEEK guard
> and simplify the include/asm-generic/unistd.h header further.
>
> Since 32-bit tasks can run either natively or in compat mode on 64-bit
> architectures, we have to check for both !CONFIG_64BIT and CONFIG_COMPAT.
>
> There are a few 64-bit architectures that also reference sys_llseek
> in their 64-bit ABI (e.g. sparc), but I verified that those all
> select CONFIG_COMPAT, so the #if check is still correct here. It's
> a bit odd to include it in the syscall table though, as it's the
> same as sys_lseek() on 64-bit, but with strange calling conventions.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

For m68k:
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
