Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26C9C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828422183F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 19:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OyX0wzEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727135AbfBHTvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 14:51:02 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37209 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfBHTvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 14:51:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id r10-v6so4016451ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qOYQNrLIv4ghYg9cJs/kFayOVviMNWKea8x1M/btUwQ=;
        b=OyX0wzEFwz/6B3oUovySoSdj87UyroJwU08G3xNJoOnjsbu6Dq0hCgkf1L42WN6nW1
         jwoJPZp5H1TptNE7ujv4YSzeQ1S9iqAxD7F1/8fIrL0nE3FasZpSYcLqdNGwta+XmVQT
         r5DkKnmqomQZhOV3nS7bhb+cUUVEYNQaa28wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qOYQNrLIv4ghYg9cJs/kFayOVviMNWKea8x1M/btUwQ=;
        b=mDGF3Qg0qg13tLcR8JkxzRd5tbfmOfnrczwjDKlAhFsN1xwS9MrhEN0gKUaB22YUE8
         XrgERnpLQ4J+4XLSnLytWZNr7oa0BH9sv9NX/ubvgGVfG9q6bAySA4GeaMpG1zzQ3bh3
         3Kh/18O3TL2D7C2HfmmjPmt60dj/5+aN+Vz4m7ymkl+2HYt5qu+N5KGfzNPq2unVLCki
         btjbk9Kxf6IRv8iycVrHUT6w1q9097ukCDx9Ls3/eigA3o5STRJXXOx2b7zWwKyz5XyY
         egEiZ//jE9ZsFr4HjP74KtMX8IbFwo4KLxACtrlKh3pUE9DvmWlbGRv5bDjcRZ8yZbvt
         /M+Q==
X-Gm-Message-State: AHQUAuYnl2ael6iHCD6e2vvTJSeJ1vP6mLa/CKAqq6/sUrsXP9TmgiRQ
        i2UAtw7bfdTOrmxfIUAZUTW21f7b7zwD5A==
X-Google-Smtp-Source: AHgI3IZfMV+hgppzYM9bSSnZw+hfpq7YTt9Zf7/fGRKpSwtS8iN8KRKPD94/1ZVhGUDfUmrQvbZvAw==
X-Received: by 2002:a2e:7d04:: with SMTP id y4-v6mr9854031ljc.127.1549655458918;
        Fri, 08 Feb 2019 11:50:58 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id l7sm574728lfc.55.2019.02.08.11.50.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 11:50:57 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id q12so3459732lfm.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 11:50:56 -0800 (PST)
X-Received: by 2002:ac2:4191:: with SMTP id z17mr14335535lfh.117.1549655456495;
 Fri, 08 Feb 2019 11:50:56 -0800 (PST)
MIME-Version: 1.0
References: <1549566446-27967-1-git-send-email-longman@redhat.com>
In-Reply-To: <1549566446-27967-1-git-send-email-longman@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Feb 2019 11:50:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
Message-ID: <CAHk-=wjfyrFBjifzmgMVrkrvEePEPaBTDq7D=f2i5kD2E=SqRQ@mail.gmail.com>
Subject: Re: [PATCH-tip 00/22] locking/rwsem: Rework rwsem-xadd & enable new
 rwsem features
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch <linux-arch@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 11:08 AM Waiman Long <longman@redhat.com> wrote:
>
> This patchset revamps the current rwsem-xadd implementation to make
> it saner and easier to work with. This patchset removes all the
> architecture specific assembly code and uses generic C code for all
> architectures. This eases maintenance and enables us to enhance the
> code more easily.
>
> This patchset also implements the following 3 new features:
>
>  1) Waiter lock handoff
>  2) Reader optimistic spinning
>  3) Store write-lock owner in the atomic count (x86-64 only)

The patches are kind of hard to read, with most of them just doing
prep-work that doesn't necessarily matter to the big picture.

What I'd really like to see is

 (a) an overview of the new locking logic

 (b) what's the new fastpath case

 (c) some performance numbers

to explain the changes from a "this is the point of the whole
exercise" standpoint.

And yes, I realize that the lock handoff and optimistic spinning is a
big deal, since I've seen the same regression numbers that presumably
caused this effort to be resurrected. So it's not that I don't find
this intriguing and worthwhile, it's literally that I'd like a summary
not so much of the individual patches, but of the new model.

Please?

             Linus
