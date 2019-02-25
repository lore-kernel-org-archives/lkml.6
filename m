Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD73C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263F820989
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 08:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgQvuOrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfBYIUA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 03:20:00 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38934 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBYIUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 03:20:00 -0500
Received: by mail-pg1-f195.google.com with SMTP id h8so3632448pgp.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 00:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3cPa30E1rgy2vfUYFwdsPSAj6Eg0WKI8aXIT/iyba6w=;
        b=YgQvuOrCZGrC4PMjZS7heFHgp/9Ry7OGUCvDmQek2ytIJnWGFnzaNB3BP1YctkngxD
         asimOBkCYcjjt6J6JWjEj17+yMXu7A3mWVn26jEcilviZlJFEolQByFZDvrRcre26uZl
         wvVMV+xbQLw5l4veEww+GYnPB79Mey4aTV7YQxZl4I9csKaZklBRJSg7qHUDO8ZDno4S
         MEwO6cqk3Vp3nViubQ7X2GyScZKhrTwGWNrql7zSf2pL/Hn9kdXVSHu1QsThbzUQwFLm
         raac9dcM84lX+csEfQuH8FeARvSevFvAZJVpCFN1Qdpx12l5e1KxI1AsOimjhPeK/CxV
         K6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3cPa30E1rgy2vfUYFwdsPSAj6Eg0WKI8aXIT/iyba6w=;
        b=olUGYvjaVp+aphZhVSYkPLsCYWNwi2/t9yrw77bXgTCcpOxYOJNiTtvlJl++uhUSZy
         MQS7uviHDGO9gbqRWTYsET0o3glWdbsE/GvGOVfpfI+Jkq+pwUHaYLSocw+rI6PyXIni
         bJ/pyfnI679ZE8YACPps/EFw5BvafwSoQDeq265LBj25hpMQvFhK7vLIMSKKbU0gf8TA
         bZYnPxDcYWCQOhmUS0E0IJHviOsnz8yWvFyTuPR07RWk908FAtx/ySgm6H/SExg7xBla
         75EzvOg5iShLHgzswvb2incxhVEQQMk8UlDBp5o9fmiLq1ev6lgehJ/54fp5xBcY86P5
         /H3Q==
X-Gm-Message-State: AHQUAuZo2wanM6sOCOfnx9HdhuV/vWe5bgUOClYpq+RNEvM+c6IdhbeO
        gwDsFsbklX1L0/THATg/YNVjRnLNGGR1iQYpcuk=
X-Google-Smtp-Source: AHgI3IbDQ+JU1g6BkB3iGKy7qbw3kXVRE2NuL6puo6naUXcL3HQXgRM8pS+GdsrDPqWlmDXV3lUVfJ4xEimLYWP0mQk=
X-Received: by 2002:a63:1a25:: with SMTP id a37mr18327091pga.428.1551082799324;
 Mon, 25 Feb 2019 00:19:59 -0800 (PST)
MIME-Version: 1.0
References: <20190225041534.27186-1-tobin@kernel.org> <20190225041534.27186-2-tobin@kernel.org>
In-Reply-To: <20190225041534.27186-2-tobin@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 25 Feb 2019 10:19:47 +0200
Message-ID: <CAHp75Vfq5KQupcyx_84YcSOQ8mvNDvFE3R20KdyLEqEz74p3OQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] lib/string: Add strscpy_pad() function
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 6:17 AM Tobin C. Harding <tobin@kernel.org> wrote:
>
> We have a function to copy strings safely and we have a function to copy
> strings and zero the tail of the destination (if source string is
> shorter than destination buffer) but we do not have a function to do
> both at once.  This means developers must write this themselves if they
> desire this functionality.  This is a chore, and also leaves us open to
> off by one errors unnecessarily.
>
> Add a function that calls strscpy() then memset()s the tail to zero if
> the source string is shorter than the destination buffer.
>
> Add test module for the new code.

> --- /dev/null
> +++ b/lib/test_strscpy.c
> @@ -0,0 +1,175 @@

> +// SPDX-License-Identifier: GPL-2.0

> +MODULE_LICENSE("GPL");

License mismatch.

Do we need a separate module for this test?

-- 
With Best Regards,
Andy Shevchenko
