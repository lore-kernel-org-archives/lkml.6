Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9BDBDC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52146208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 08:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqvXwqaS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52146208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965549AbeFOIvU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 04:51:20 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36909 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936185AbeFOIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 04:51:18 -0400
Received: by mail-vk0-f66.google.com with SMTP id w8-v6so5272896vkh.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 01:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QXNj93zNUmn86i366sRjWAoWBHlfeiG5u+n+lrREuFg=;
        b=cqvXwqaS8Q5HLtQtDWDmJPbCmn+84RGnE4cDo55xYMZpekcAi+tgYH3jFkGgvOPW+X
         wQ5bKydMAktHJZgDPvNM9u2c0O7oqWOImNzuMAh3STmgNGMnkjsjujN0q03ONXtwvyP8
         Wmy4ONiwy9oWSMOlR49Ix90NC2PPq+oV9q6Xw3Vus1LhHwWNcC8d4Zt/LXiD+pIDihHc
         rnUKFsxUSLq7rVKVvyPseGN1yxJ1cGHjZAMReBxtZGya2KOYz1z3NlmLrGWVX8FMjpR1
         DaYhLF3Yq41JqRyJfanyUunJL51T1e7akvWZATDV48nZpqtLiemCTyYC+rPrLIKBuIVC
         RzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QXNj93zNUmn86i366sRjWAoWBHlfeiG5u+n+lrREuFg=;
        b=buKrrpIeb3+o/9NalsQByDk3RgBq3itcuDPocIXBktQtQpLw0u2R0tQRVq342Qp55J
         7WTeCZyJchvPUNso3KS3IWF1CtGVVsv8VDopFWfpQdSxkFSoPSn5f0Vi0Ma0Y/NeXdrC
         HdHz4erKYDOO/PEwaNJc2EE1xv5ZIbZxKmpfm6O3bl5RNmIFfWvRtSMzvp7gV+ZPzahN
         sKmAVf4MpVfsfKWqivYiUu2OK0qIgH2aCHxUVNLU9QgrjQtqRVzi3rVw12ggdsL72qIA
         XKJaLPmswKASmW2H5+wrma8BJJ5hIL6U90vAlBnjcaQPdhfAXwafjPVrJ7meKC48UCCN
         y2HA==
X-Gm-Message-State: APt69E3+NncKU8A9XKzgIj84ZTwYBzlWuYPHQaVXaVO3sO2ACDJ/O+zX
        4upEqtU9OZBwsOWngYRgz5wbdvq/ZolPHnAgQe+BrA==
X-Google-Smtp-Source: ADUXVKKZ0TNyIop+SbCb4Ew8Brt7YuQ0NLNfpMmqIDw/tlJoISIIB8iAfjz4xKp7ktVasainj5FXJan9/nzrB8O5rTc=
X-Received: by 2002:a1f:860b:: with SMTP id i11-v6mr410436vkd.15.1529052678222;
 Fri, 15 Jun 2018 01:51:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 01:51:17
 -0700 (PDT)
In-Reply-To: <20180614212643.29563-1-johannes@sipsolutions.net>
References: <20180614212643.29563-1-johannes@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 15 Jun 2018 11:51:17 +0300
Message-ID: <CAHp75Vf372rACqseUNYEba3Gw1Hg+PmdFdn+a2ex=2JzWZ2nWQ@mail.gmail.com>
Subject: Re: [PATCH v2] bitfield: fix *_encode_bits()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:26 AM, Johannes Berg
<johannes@sipsolutions.net> wrote:
> There's a bug in *_encode_bits() in using ~field_multiplier() for
> the check whether or not the constant value fits into the field,
> this is wrong and clearly ~field_mask() was intended. This was
> triggering for me for both constant and non-constant values.
>
> Additionally, make this case actually into an compile error.
> Declaring the extern function that will never exist with just a
> warning is pointless as then later we'll just get a link error.
>
> While at it, also fix the indentation in those lines I'm touching.

I'm just wondering if we have test cases for that API.
If not, perhaps it's a good time to start (perhaps extend test_bitmap.c)?

Otherwise, the fix looks good!

>
> Fixes: 00b0c9b82663 ("Add primitives for manipulating bitfields both in host- and fixed-endian.")
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> v2: replace stray tab by space
>
> If you don't mind, I'd like to take this through the networking
> tree(s) as a fix since I have some pending code that depends on
> it.
> ---
>  include/linux/bitfield.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
> index cf2588d81148..147a7bb341dd 100644
> --- a/include/linux/bitfield.h
> +++ b/include/linux/bitfield.h
> @@ -104,7 +104,7 @@
>                 (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
>         })
>
> -extern void __compiletime_warning("value doesn't fit into mask")
> +extern void __compiletime_error("value doesn't fit into mask")
>  __field_overflow(void);
>  extern void __compiletime_error("bad bitfield mask")
>  __bad_mask(void);
> @@ -121,8 +121,8 @@ static __always_inline u64 field_mask(u64 field)
>  #define ____MAKE_OP(type,base,to,from)                                 \
>  static __always_inline __##type type##_encode_bits(base v, base field) \
>  {                                                                      \
> -        if (__builtin_constant_p(v) && (v & ~field_multiplier(field))) \
> -                           __field_overflow();                         \
> +       if (__builtin_constant_p(v) && (v & ~field_mask(field)))        \
> +               __field_overflow();                                     \
>         return to((v & field_mask(field)) * field_multiplier(field));   \
>  }                                                                      \
>  static __always_inline __##type type##_replace_bits(__##type old,      \
> --
> 2.14.4
>



-- 
With Best Regards,
Andy Shevchenko
