Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C25C433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 18:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DA4208B7
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 18:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tPrcMoWo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3DA4208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbeHZWOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 18:14:04 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:42488 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbeHZWOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 18:14:04 -0400
Received: by mail-qk0-f193.google.com with SMTP id g13-v6so5726458qki.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 11:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=rZbJl7JHITXDqLCiJ0mixDfNJXg2kqIX6kQo0ZP7pGw=;
        b=tPrcMoWocsBajXScPevl6D+H3wnLpZkNcbD9sq+Xy/rSJDoWXMRnGAZNKeek/V5kG1
         Lxvm0oSkaImxTXYu4SJCgAjVVflnV32vi6MCFrkynh8UdZnOqH3oMX6Mbjh7TFZEy3hq
         ZZ52EMRbXdzOi9GnMKqMR5EUWJRmICMr6BfuBEo+68fGJvCDo80XJRVCcHrim+O4rzkj
         3rKJ06ZLTGkzNqQhKuIfm5xRJ21gia7lKV2amYQj5e18IxE9EeuaMs2ge0lTAdDM7E2Y
         83psApp2Xp9ebZryrcFvCY33v07kFJy1bd7F9d6qONp4RZn/TCpVEsuGxJk3qeSQYk5B
         vQJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=rZbJl7JHITXDqLCiJ0mixDfNJXg2kqIX6kQo0ZP7pGw=;
        b=H/KhbY/o3wspX2PsrvkUPboVmYyBdQRxC0yeTVhIskKi3IVRiHhD4l9SGAOz9l2Qj4
         AGOGdDaH+V/rG5mywKFk+MIjd2XCXsDRoM7XYvfQ1bgeiL2ZrRI1FtT08T/kUFFUqsU3
         yi97LVoJvoKXqyC27kZ9f8hE3xxB4kbcA1XN+omiNu6Tr0nnVrvEKLYeGtrUaF987mWr
         ShY/veqOfVEJhYTxDT0LYchslaC599eom8X4PxMqO8lAMnOSmIx7Y2mM4jO0YvBBTNMt
         dcwscUYF+p2xR/bjgNTaqUayTs6NiiYbnNkYVhhOo5foOI2G3qeMHmX3pT2rkRNgZ6Vf
         ZyKA==
X-Gm-Message-State: APzg51BcCla9E4TYZz4c7PMUPsID4tcyGe6Cx8xkXWxrnZIf54urrQ0X
        I6nXwUwis/+fPpfHXnmwmlUzb4BUdTfY+bP9eiQ=
X-Google-Smtp-Source: ANB0VdZFbLqBHfk39rSydh1grrcT++SrTLRP5vYWHrQ+jwdK0fms5ybet9NQWPvugIDvQXLInyWTHSQZA/hGKo/d608=
X-Received: by 2002:a37:1383:: with SMTP id 3-v6mr10324490qkt.129.1535308244824;
 Sun, 26 Aug 2018 11:30:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:471a:0:0:0:0:0 with HTTP; Sun, 26 Aug 2018 11:30:24
 -0700 (PDT)
In-Reply-To: <20180826175748.GA29525@gmail.com>
References: <20180826175748.GA29525@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 26 Aug 2018 20:30:24 +0200
Message-ID: <CANiq72nYfCucffu4y9UMgZ357iXeeObZrhYoLb5e7cJgr170RA@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: Use feature checking instead
 of version checks for attributes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A couple of extra notes on my patch.

On Sun, Aug 26, 2018 at 7:57 PM, Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> +/*
> + * Optional attributes: your compiler may or may not support them.
> + *
> + * To check for them, we use __has_attribute, which is supported on gcc >= 5,
> + * clang >= 2.9 and icc >= 17. In the meantime, to support 4.6 <= gcc < 5,
> + * we implement it by hand.
> + */
> +#ifndef __has_attribute
> +#define __has_attribute(x) __GCC46_has_attribute_##x
> +#define __GCC46_has_attribute_assume_aligned 0
> +#define __GCC46_has_attribute_designated_init 0
> +#define __GCC46_has_attribute_externally_visible 1
> +#define __GCC46_has_attribute_noclone 1
> +#define __GCC46_has_attribute_optimize 1
> +#define __GCC46_has_attribute_no_sanitize_address 0

Note that:
  - assume_aligned came with gcc 4.9
  - no_sanitize_address came with gcc 4.8

So if we feel it is important to have them there (before gcc 5), we
would need here a quick version check here.

> +#endif
> +
> +/*
> + * __assume_aligned(n, k): Tell the optimizer that the returned
> + * pointer can be assumed to be k modulo n. The second argument is
> + * optional (default 0), so we use a variadic macro to make the
> + * shorthand.
> + *
> + * Beware: Do not apply this to functions which may return
> + * ERR_PTRs. Also, it is probably unwise to apply it to functions
> + * returning extra information in the low bits (but in that case the
> + * compiler should see some alignment anyway, when the return value is
> + * massaged by 'flags = ptr & 3; ptr &= ~3;').
> + */
> +#if __has_attribute(assume_aligned)
> +#define __assume_aligned(a, ...) __attribute__((assume_aligned(a, ## __VA_ARGS__)))
> +#else
> +#define __assume_aligned(a, ...)
> +#endif

Beforehand, these were !defined(__CHECKER__). I am not sure if sparse
complains too much about it. Maybe sparse could learn __has_attribute.

Cheers,
Miguel
