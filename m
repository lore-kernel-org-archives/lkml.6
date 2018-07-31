Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655F0C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14AB620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 16:57:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jMR4a0f2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AB620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbeGaSiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 14:38:10 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34005 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbeGaSiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 14:38:10 -0400
Received: by mail-wm0-f67.google.com with SMTP id l2-v6so11578129wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=80+Z3QF4ydz0CEa1ALsh113dfvbq9TQsUYXd8Ns4Ms8=;
        b=jMR4a0f2O6D7iBo5TRwYC7BnYxhGfxtZa5fu6KcqPKj0XCnI5qjr8CF90INkHdJILG
         hVNQjhb65/F4zXGjEvGD3hMZ3SMbfshLnmnUDshhVIxc3JP/hzoIIk8fmJojQtGqxKiV
         bEU/Rw/pLSCA/mRsRCe+X04y6QXh1fJZHX7b8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=80+Z3QF4ydz0CEa1ALsh113dfvbq9TQsUYXd8Ns4Ms8=;
        b=I4QMM7mUTZAHvULjcIX50O6+NccYhiDoGB2s02vuwlC2L8yTjzwYH4h4u6U+vN8BkW
         p/JVZ05ReC9Lc1MD8MSS3/hYUbHMuvDNlFPOJdLDeWdP74nJw1ZKuM3DMJZr0KSz3D71
         wsraJelyCo2lqXI67sUybdfRT7JPCHIYQpTyQ0EJWLsiDB53+iSY75kmhNN73Hli6fyQ
         0mY+RlK6buqS5tGhdS4RESv/RwQUefx/dX7EiWbgkNB2obZTAXa2k78RjJDRvf+6u6Mn
         cQ1zB18MVnVP1oDCEDZaXqI4duuu2in2M2nV5iymOyRphQbYTsICmTtxOa+QNob9806c
         AX+A==
X-Gm-Message-State: AOUpUlE0HUrTRDgAP8eduM2tjCbL3KXGeBX7UhrcWsIH1+9q3ZtbjD5D
        6CMafjpJsgKaed99U+1367wfm66SBFmEV5kX5+0OAg==
X-Google-Smtp-Source: AAOMgper8Y1W90d1mhBYzR2jl80ngIpy25iD5PvJVUBRhucxVTI/3LO8owOAuggAnm4z7WobvMJ9+R7V4cjeb9HMKHs=
X-Received: by 2002:a1c:2b43:: with SMTP id r64-v6mr316833wmr.96.1533056216814;
 Tue, 31 Jul 2018 09:56:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 09:56:55
 -0700 (PDT)
In-Reply-To: <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
References: <CA+55aFxpFefwVdTGVML99PSFUqwpJXPx5LVCA3D=g2t2_QLNsA@mail.gmail.com>
 <CAMi1Hd0fJuAgP09_KkbjyGwszOXmxcPybKyBxP3U1y5JUqxxSw@mail.gmail.com>
 <20180730130134.yvn5tcmoavuxtwt5@kshutemo-mobl1> <CA+55aFwxwCPZs=h5wy-5PELwfBVuTETm+wuZB5cM2SDoXJi68g@mail.gmail.com>
 <alpine.LSU.2.11.1807301410470.4805@eggly.anvils> <CA+55aFx3qR1FW0T3na25NrwLZAvpOdUEUJa879CnaJT2ZPfhkg@mail.gmail.com>
 <alpine.LSU.2.11.1807301940460.5904@eggly.anvils> <CALAqxLU3cmu4g+HaB6A7=VhY-hW=d9e68EZ=_4JiwX_BigzjPQ@mail.gmail.com>
 <CAMi1Hd0-2eDod4HiBifKCxY0cUUEW_A-yv7sZ7GRgL0whWQt+w@mail.gmail.com> <CA+55aFx=-tHXjv3gv4W=xYwM+VOHJQE5q5VyihkPK7s560x-vQ@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 31 Jul 2018 09:56:55 -0700
Message-ID: <CALAqxLXyiE=FkBBwEa0-jhyVb-sp+j8bQR7_+Af8nQw3coKjLA@mail.gmail.com>
Subject: Re: Linux 4.18-rc7
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        youling 257 <youling257@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Colin Cross <ccross@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 9:29 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Jul 30, 2018 at 11:40 PM Amit Pundir <amit.pundir@linaro.org> wrote:
>>
>> This ashmem change ^^ worked too.
>
> Ok, let's go for that one and hope it's the only one.
>
> John, can I get a proper commit message and sign-off for that ashmem change?

Will do. Just doing some local testing myself to make sure all is well.

> Kirill - you mentioned that somebody reproduced a problem on x86-64
> too. I didn't see that report. Was that some odd x86 Android setup
> with Ashmem too, or is there something else pending?

Krill mentioned "zygote crashing, but on x86-64" and zygote is Android
so I assume it is the same issue.

thanks
-john
