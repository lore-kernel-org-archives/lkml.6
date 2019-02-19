Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB5AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43E121902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+Jv2ioR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfBSLC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:02:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36395 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfBSLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:02:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so10086088pfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 03:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ap/5PNbxopgdnFsaO1fAdPfrpnzoC2q6YZiOIH231TE=;
        b=c+Jv2ioRn1ikhWkWZGUXcvlzT4veU4HFGgDVfvD8rOmZ210liSf958m6ZNjbtaflXF
         bUulqugaOfmjd7b6/E4Y7+AU8lRGTih8pHz2yLZVHaiD5N8LUMxUQLq03gwvJoFDWmLV
         Hz0GpzJ4yzVvKJ2IUzWTx9qJHanx4oqyJF4XzlpZyZYD4oGsEniZcwQ58Z+AgTtCnTFZ
         LDKRdM3HvLrFE+FRGlrjcCpXH6XtB/72x+icYKN1yK12DhA9qN0m5NINb3cp7pO/6BkD
         THiCS9eG7f6jY1qEzdeq8A7R3wWn7EO0uahzeJRenKOZJWLMU88ylNi6PxqgyyxpYYUp
         1vTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ap/5PNbxopgdnFsaO1fAdPfrpnzoC2q6YZiOIH231TE=;
        b=SWiz/EKJ+WJWUb5H+aoLp0hYWbFsX24kR7/K3oHd314tW0/HB4NPASuhpOvrhpRoqy
         O+R+ffOGJLxqDkRq6Y5OiwwllPXgjUOwr388GEGhCy6+5yynD3epNe4lA2t7GUwNd68s
         yaY+J26Mvq8tUxTAbXFza+oKwHnN4w1LJyjcrmHZrXl8EM5LqBkWEERPm+Wy+EjCv89x
         W6u+XEZ/gy3+jKo6uyI4TZWCQNKJcO+HCwDRmkRFFQDd4HTRuYNpOoygH1VhaRTCnXE9
         d+5tFccU4uxXCPnObxk0ZgEqTp/GNneCf6K/IE8qGQkIhsUlvEz9i4HmGiPXJFt8ZC2b
         zy9g==
X-Gm-Message-State: AHQUAuafJI2CJJXtEZB0PW4q8wBjVvEY2O4NuzH5pj61eeVvARB5j8Ne
        7qoOkUkgC8ooA7hQe1hhvE2H9LkacjeUzjBBmqQ=
X-Google-Smtp-Source: AHgI3IYFDnCgQupyFj9qWrTX//IcQghivPSiWfHuMf4CtKMyhSVpukL9bsZ45LUhMvcfIjuzxfj2iY0Rl0Ep2+je7G0=
X-Received: by 2002:a63:f148:: with SMTP id o8mr23517324pgk.337.1550574176455;
 Tue, 19 Feb 2019 03:02:56 -0800 (PST)
MIME-Version: 1.0
References: <20190208152310.29531-1-pmladek@suse.com> <20190208152310.29531-9-pmladek@suse.com>
 <20190219033003.GA2284@jagdpanzerIV>
In-Reply-To: <20190219033003.GA2284@jagdpanzerIV>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 19 Feb 2019 13:02:45 +0200
Message-ID: <CAHp75VfeNvThbue+v1VHK_zxw9N82AkOQZUL=nH6xy21WXX7sg@mail.gmail.com>
Subject: Re: [PATCH v6 8/9] vsprintf: Prevent crash when dereferencing invalid pointers
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Tobin C . Harding" <me@tobin.cc>, Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.cz>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 5:35 AM Sergey Senozhatsky
<sergey.senozhatsky.work@gmail.com> wrote:
> On (02/08/19 16:23), Petr Mladek wrote:

> Hmm... So the assumption here is that the target buffer always has
> at least strlen("(efault)") bytes and, thus, we always can write the
> error message to it.

Same assumption as for pointers, 8 or 16 bytes. Same will happen if
it's not enough room.

> > +static int check_pointer(char **buf, char *end, const void *ptr,
> > +                          struct printf_spec spec)
> > +{
> > +     const char *err_msg;
> > +
> > +     err_msg = check_pointer_msg(ptr);
> > +     if (err_msg) {
> > +             *buf = string_nocheck(*buf, end, err_msg, spec);
> > +             return -EFAULT;
> > +     }
> > +
> > +     return 0;
> > +}
>
> Suppose in my driver I sprintf() pointers to 4-bytes strings and, thus,
> have only 5 spare bytes in target buffer. But one of the pointers is
> faulty and now sprintf() writes "(efault)" to target buffer which can
> hold only 5 bytes.

And if it's not? You will get in either case incomplete information,
but at least with "(e" (or even "(") you might get a clue that it
errornous conditions.

-- 
With Best Regards,
Andy Shevchenko
