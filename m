Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7326C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8663C2081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 21:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bJwh9xQa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8663C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbeLDVVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 16:21:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42787 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbeLDVVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 16:21:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id 64so8840260pfr.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 13:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Okg2dLAdUq9xzknRgDrH/k6iGHxYSlP2kr+i2uhoW4c=;
        b=bJwh9xQaiwIdwcdg3WTWOEat47vkaTIHqYf6iKfqjU+V7OWvZGQedfvnTONkZCLO+T
         3iNslwneI9t8DiNylQw6l0yhKkNRjjWnU/P2h6SVzFeqttY8pUCIIc+qmAFWr/hfF5Na
         5IrAYF0Vutahdbg0tOs7lic8fX+IPFljxwRujRoIgVpy4ZKgv6sTtTBKyI6kIfIGi3Nx
         GC2+xAJ8QBGkYqYEE/KXvEECgv5qSKPEeb8zKE1rnnDcH/p2btFhw2Xt6f54rqrhWkfq
         WRez80PKxpnFpkN/nZsampersDAjyhuv04hms+eCknyVDRdBV2o8XARy91q2FxKNolE9
         /8gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Okg2dLAdUq9xzknRgDrH/k6iGHxYSlP2kr+i2uhoW4c=;
        b=tWU2alMtpEudb07eV0AzAPWt+bPEfeYtAU1eKZ8PqdJd23PLQl8gbdO5AVrSKxoBVu
         CBq7iLSuIefoMwQ1CwGBqGeaabAct/IVPb9kkdyL4LOURyDWofJIfQ528bXtHt/8yNUA
         q0smWT92RXw8c3NOuTnfrpRw25RBUR517zCqCFoOxdt92mVCnSPookT+JRMhP+ik69Ww
         oyuGt1m1ko+TV/jBbqtP6B9lwyXsUidlEeOsFz4rSRJhRpvxC2wj6BKRqeAzfKAdKm+x
         RPr1BxLflgumu720cb/d9v8HmNIiEJ7LvfEBVh+mAfGkveuNRxR+SWUoSIii1iqgz2oa
         NFQQ==
X-Gm-Message-State: AA+aEWZB3OsZqiJt7wJ4UQdAxDkbzG+GTBRSjBcQLUlApR9vrSMQybAL
        610gZjXHmg8fLKXw/RhITP9n/6Ppe2Di5l/HYVNMyQ==
X-Google-Smtp-Source: AFSGD/VtaEfRh2hiWuXDBLKccWPb8c44tm9rpMePzuDP7PUczO4XVyHUAbON4bt9PiFyHi3D+B1O6VNpXhxiWRBozTw=
X-Received: by 2002:a62:7e13:: with SMTP id z19mr21631726pfc.94.1543958496523;
 Tue, 04 Dec 2018 13:21:36 -0800 (PST)
MIME-Version: 1.0
References: <20181128140852.178260-1-liuxiaozhou@bytedance.com> <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
In-Reply-To: <CANiq72kzHqQ-M2Gyrf7iy1BQMabM6txChYwa8hrDkMmc3w8ORw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 4 Dec 2018 13:21:25 -0800
Message-ID: <CAKwvOdk3K_fUU-nUbpDVXvGr0CzBzznZOjCJN1cg2T+aW2vTEg@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: move kernel-only attributes into __KERNEL__
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     liuxiaozhou@bytedance.com,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        paul.burton@mips.com,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 9:35 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Xiaozhou,
>
> On Wed, Nov 28, 2018 at 3:09 PM Xiaozhou Liu <liuxiaozhou@bytedance.com> =
wrote:
> >
> > Attributes such as `__gnu_inline' are meant to be used within the
> > kernel. When userspace somehow includes <linux/compiler.h>
> > (eg. tools/bpf), compilation errors would be shown:
> >
> >         "error: unknown type name =E2=80=98__gnu_inline=E2=80=99"
> >
> > So just move these things into __KERNEL__ and the behavior is kept
> > as before.
>
> That is not exactly correct -- a3f8a30f3f00 moved some attributes to
> another file, moving them into __KERNEL__ (in particular,__gnu_inline
> is).
>
> The problem is, instead, that __gnu_inline is not anymore defined
> outside __KERNEL__, but something else that uses it is (the inline
> macro definition, if I had to guess).
>
> If your problem is fixed by putting __gnu_inline into __KERNEL__
> again, it means we can simply move the inline definition inside
> __KERNEL__ too. That way, we don't pollute userspace users with macro
> definitions.
>
> Having said that, does someone know whether userspace should have
> access to those attributes (or rather, other code that uses in turn
> those attributes)?

This is tricky territory; the kernel is redefining `inline` in headers
in order to get __attribute__((gnu_inline)) semantics.  If non kernel
users include those headers, the kernel may be redefining the
semantics of `inline` for those programs (unexpectedly).  Admittedly,
gnu_inline kind of an edge case so most users might not notice, but
that may be an argument for `-f gnu_inline` rather than redefining
`inline` in a header.

>
> Cheers,
> Miguel



--=20
Thanks,
~Nick Desaulniers
