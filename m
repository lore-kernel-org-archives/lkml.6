Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4C9C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA496223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PdjQqI8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA496223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729715AbeKMJFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:05:50 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39378 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeKMJFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:05:49 -0500
Received: by mail-ua1-f68.google.com with SMTP id k10so3658100ual.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 15:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sXvHHT6tiHBL+9VcRX4ZfaeM5bRD+9nM4CbmGQiTRUY=;
        b=PdjQqI8T9unmYxPs6mYWu1I1HWk3BUlX0JMWX3UNMcsrWMO3D2m1ehDNEGcmFtFxnj
         lNBNvAh3uiphE+Jg4FknvmLxxXqf/q1Jbkh0aahKTp/v1ujoAACD1ODIzpLtHl7IMnuZ
         Jhadx6zYCSyGkwifmcs9DhH92aLB5favvnGURfUD8PkBKAIINZaiCFD6qgOuSMiOi/Zz
         9gsfUWNb71+yY+wr2seg95At0NxoccEVSxtPgs5KXG5NNdjK7SKGBXBh9+d7EJw+BbeY
         bw3L+GXE58dla6IttWQaaN01+1Nebal3j4O+5D3yqucjrX56aKVo3j3rr3KSLuGbQSDy
         KwSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sXvHHT6tiHBL+9VcRX4ZfaeM5bRD+9nM4CbmGQiTRUY=;
        b=C61ZPQidvJijL2MbQxZ76dEr5qSZTju5UIlHTjzHQRmqMY3vu5vENnKVAManeUAbAh
         MppnfLURwUpcdJKnlXnlXjOKAOl5y8wSRKP/ZDinXZDyeL4WiwOL+489qTKWrqNmj0Tr
         DyFsLmS2wcn0ISKjtZ1rfLd041EiwquBLEYlnZrjjpQ9NPFSfO0ChMWMC5RTSy6jJLYc
         TIls3X9LsimAH9FxnkhIsvHk8IPIsXO0mVj1/Gs4I0Y2HQSupSrji9dZyWbkIyVk+P3F
         CH0ZgOmJXDsf8kwfpD1LQT1oul5jdfjepacqtGXZSxiI/uM2quUyBZsaL66j+Xdhpohd
         xwwA==
X-Gm-Message-State: AGRZ1gKH2o3E9l+NEOeAcrQ7J0vxDkYr6x0vzSlvmjgqepuPqeWa4onM
        cr1dXFafMOFT3k+4Cx8f2U+xt2Py4Q4+yd7qGZHv1A==
X-Google-Smtp-Source: AJdET5ffGWRFuAws3AJPGk3V8qgs13+UHqd5tH6VkhBCg/063gRDs0oZwkePz+Lm1cBDzKO+26ReMMPvLBBJd9nz/E8=
X-Received: by 2002:ab0:45e2:: with SMTP id u89mr1304912uau.13.1542064229356;
 Mon, 12 Nov 2018 15:10:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:9883:0:0:0:0:0 with HTTP; Mon, 12 Nov 2018 15:10:24
 -0800 (PST)
In-Reply-To: <alpine.DEB.2.21.1811122236240.18130@digraph.polyomino.org.uk>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <877ehjx447.fsf@oldenburg.str.redhat.com>
 <CAKOZues5SEESpJU=6MDTrPXTA1KTZFGNQE4Lw4t0fO-WBTU62w@mail.gmail.com>
 <875zx2vhpd.fsf@oldenburg.str.redhat.com> <CAKOZuetdgk1QYhx1538-98rFpogMin=8DkPnCtU9_=ip23Vk7w@mail.gmail.com>
 <CAKCAbMiHC9r54h=XeW7CkBZ1Z5eHr9MPH3Rn7KTc9DjoHG=8UA@mail.gmail.com>
 <CAKOZuev7zqq+xpjyDA2mSdy-zwyNjECCzLsBELF6_v1rwar_mA@mail.gmail.com>
 <87lg5ym7qi.fsf@oldenburg.str.redhat.com> <CAKOZues2bQo1y_1ynxFMHGTvtTjABsqVpKJt5MYMdZBq6-ikHA@mail.gmail.com>
 <alpine.DEB.2.21.1811122236240.18130@digraph.polyomino.org.uk>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 12 Nov 2018 15:10:24 -0800
Message-ID: <CAKOZueuM=3pxuXaJU4v571daWFCTJ1LYO-ApD6MrD7313RNYfQ@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Joseph Myers <joseph@codesourcery.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Zack Weinberg <zackw@panix.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Vlastimil Babka <vbabka@suse.cz>,
        "Carlos O'Donell" <carlos@redhat.com>,
        GNU C Library <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 2:51 PM, Joseph Myers <joseph@codesourcery.com> wrote:
> I see no obvious reason why a kernel-provided
> library, with all the problems that entails, should need to be involved,
> rather than putting new APIs either in libc

I initially wanted to put the APIs in libc. I still do. But that's
proving to be impractical, for the reasons we're discussing on this
thread.

> or in a completely separate
> libsignal

A separate library can't prevent some use of sigaction elsewhere in
the program stomping on its handler. One of the key aspects of the
registered-handler design is that registered handlers get to run
*before* the legacy process-wide handler. The only non-hacky way to do
that is to put the signal handler registration logic in the same logic
component that houses the legacy signal registration machinery.

> (I can imagine *other* parts of the toolchain being involved, if e.g. you
> want to have a good way of checking "is the address of the instruction
> causing this signal in this library?" that works with static as well as
> dynamic linking - for dynamic linking, I expect something could be done
> using libc_nonshared and __dso_handle to identify code in the library
> calling some registering function.  And indeed there might also be new
> kernel interfaces that help improve signal handling.)

Again: you're blocking a practical solution for the sake of some
elegant theoretical implementation that will never arrive, and so the
world remains in a poor state indefinitely. Incremental improvement is
good. Nothing about the registered signal handler approach precludes
this sort of enhancement in the future. The same goes for the system
call metadata database you've described: nice-to-have; shouldn't block
simpler and more immediately practical work.

> In the absence of consensus for adding such a new API for signals to
> glibc, it's unlikely one would get consensus for glibc to depend on some
> other library providing such an API either.

glibc would continue using an unsupported legacy system call
interfaces in lieu of a supported low-level interface library?
