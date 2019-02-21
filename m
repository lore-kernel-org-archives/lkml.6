Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35106C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8B392084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 12:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nr9wslsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbfBUMDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 07:03:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36027 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfBUMDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 07:03:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id n22so13691940pfa.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 04:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JWJ1HG9+5QnKTQbV+d9xGT+vA0HxMAGf74I6H6DUnaw=;
        b=nr9wslsUmExUI53sptebBygsJAG/A2veL6f4UdtRQpO5Mo68A0u4JQcgrq8vCfzUtZ
         AZbHvFVmPBdWkc6Eq6VRykJo5w4QNKkylH2WYzZfb0Xt8lflqOFVR8snT18dhvIKOiGm
         VQgKg9Om+ItSi/nPZA185F8XlqlY0Oh7H2VS7tVG/Z5Nh1vTModtoWVONalPZVAP+Vb3
         wwwcAKnN3iqY2nsDZDCJFX8cTq5aAjAUgfuO+OAx5w9JKtyipEkREElskhvVOPzr1TzD
         shxuJieTb8HTzc8HFxC3o7Np8MOJw6ZkO7YlGkhfuqD7sItF+aft+/5FX4QMtC7NQRKd
         smjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JWJ1HG9+5QnKTQbV+d9xGT+vA0HxMAGf74I6H6DUnaw=;
        b=gIPN94IkMb0nSCJqyS0Ur5R/2xKCDi6GrPCsNG8vk6ukSFmxFp0Dfj6M7gRYkxCsI6
         qWm7ROGL6//snnHZMzVZHzTRT5YJaZ5cGmtnWno+yTNBsv8nnN6pcjEeOSQHxeXNoWcY
         SY8j3vfOgaZqiNuF5wgq1NGkqZNTU6rKD3zk7i2rVMyQeBjnPVk9GAHjlrSD/kUaZLeg
         AEwr3FqTJk1RbDERZo/swI7M3Kh8zULjzDotBS6zErXdh/QFZsQEoTu7wTKJrtTEOWTO
         loHzjJ1hKHI4lTjSA91+Jz9i4zMWtCh0v2kF6NJteknDWd9L1kpjBeXw8q+s/L3EfP7Y
         zmew==
X-Gm-Message-State: AHQUAuY0smmpS+egZUPUdAmTEVGaV7rII0+Ri/sIUaRnp7pRYQ5hrSV4
        ssuYurzXuNlOClA6QOdZQUR2HGiY4ZLydE7sfx8=
X-Google-Smtp-Source: AHgI3Ib60FLYJ+6YpD5CZn8Rc+DKUdpy9AXAI3LdbwFfMBqCTGXWYfGCzre3zVs8xT5Nj6zO/9/0j6iqjfFzdN3qNTQ=
X-Received: by 2002:a62:864c:: with SMTP id x73mr40176650pfd.49.1550750588987;
 Thu, 21 Feb 2019 04:03:08 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-5-tobin@kernel.org>
 <CAGXu5jJe7CiQ0aResT4Hnsuhm+grZyLTcVAkdwsBdtbdrnBbuQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJe7CiQ0aResT4Hnsuhm+grZyLTcVAkdwsBdtbdrnBbuQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 21 Feb 2019 14:02:57 +0200
Message-ID: <CAHp75VfO0SQ41zV1r3R2h2n2eRuGJzdsgHFzK7nRj85m7Xahgw@mail.gmail.com>
Subject: Re: [PATCH 4/6] lib/string: Add string copy/zero function
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:49 AM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > We have a function to copy strings safely and we have a function to copy
> > strings _and_ zero the tail of the destination (if source string is
> > shorter than destination buffer) but we do not have a function to do
> > both at once.  This means developers must write this themselves if they
> > desire this functionality.  This is a chore, and also leaves us open to
> > off by one errors unnecessarily.
> >
> > Add a function that calls strscpy() then memset()s the tail to zero if
> > the source string is shorter than the destination buffer.

> > +/* Wrapper function, no arch specific code required */
> > +ssize_t strscpy_zeroed(char *dest, const char *src, size_t count);
>
> bikeshed: I think "pad" is shorter and more descriptive. How about
> something like strspad() strscpy_pad() or strscpy_zero()? (just to
> shorten it slightly)

zero / zeroed examples in the kernel have semantics of getting some
area completely zeroed. OTOH pad means different and we have examples
as well (see seq_pad() as one).

So, I would definitely vote for _pad b/c of semantics.

-- 
With Best Regards,
Andy Shevchenko
