Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B75C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E68B2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 20:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UHFtg8bq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E68B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936812AbeFRUmB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 16:42:01 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42125 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935090AbeFRUl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 16:41:59 -0400
Received: by mail-vk0-f66.google.com with SMTP id s187-v6so10372240vke.9;
        Mon, 18 Jun 2018 13:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+nrKEctQharwYQvhe+0cq45rewmulR+dLRzji3xruQM=;
        b=UHFtg8bqpWeePEiyZjg3o1uHBv1z0L7xoV6vW1UOBeJXy6FL4YAlw1jwKO3DwdhD16
         1kMW10ZPK9cs2HN0iTUbvIONw46nTH69cFCvBUdFPHYo9LIdDl9VqBU4oRzBGk/nwZb7
         p3J4fWIjgBUbODE8JA7eJb7GHml8psA8qZpAFVq5pFX/sluAp4ereSQDPN9tDZ3UDYuj
         SPZ3kBTa19ahDtCnod9JtUmBtoUCrCOUwWkVB009DZEDr3Zzi6gJD0gWcnLq2uF8+4AG
         WwRTcqjaMjWVg+DQd5ySr/Ok4PUANsrEmGMjmgi8sFxvdrwaAeEmpFGkNE2TDA8FBwoI
         KrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+nrKEctQharwYQvhe+0cq45rewmulR+dLRzji3xruQM=;
        b=lE4gTHArwfiNpDXs8EJXp6IvM9KAnkqcW4YRyxkTsT6SfU5mvUOZ954h275JDPh2Su
         UgmuspS3EWcytMHqxFbQRGbM4zzkK/VlAxhexmfyFKZoGI8PSTV0Zb42E2OX2kFa964r
         mMtD4Zl/ElH3U2xQOOxA97Tel3Gf0cOaamZMiHuOz4EoTWvoZUS1L3fxbw6tz/053749
         0peVoMYVNAlCkDd97qdMVunrMIxTHUR9HdQzaV/6G2etmUmqc80R1NzvxHXdkODZZFhF
         QYro+pbql5OVxRlD8z4v/0j7wivv7AubSlOHN/R/XLOGMyMscrpq1Q/mMR6rjzxzzw1v
         5d8g==
X-Gm-Message-State: APt69E3ac8763nVg/IaqUeKmJ6ujk7bempRF237NLYG4HaWbpJi0M2xW
        J4IyGkVAM5zsM5uQXLwY6++3SBQWEgT+mmk3CfQ=
X-Google-Smtp-Source: ADUXVKKi2AIF7299GnVqqpwnL1vi/knr06BzUNBRTsswYJJg2k8084zHvuhBxsqBI3BMjtzITFoEGKfokEr0Mbpb2ig=
X-Received: by 2002:a1f:1e10:: with SMTP id e16-v6mr8096550vke.176.1529354518940;
 Mon, 18 Jun 2018 13:41:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 13:41:58
 -0700 (PDT)
In-Reply-To: <20180618203750.28658-1-johannes@sipsolutions.net>
References: <20180618203750.28658-1-johannes@sipsolutions.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Jun 2018 23:41:58 +0300
Message-ID: <CAHp75Vedm5oFJXURSxS5_SN=LMXvyyuHCYESoz7tGywTtiG69Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] bitfield: fix *_encode_bits()
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:37 PM, Johannes Berg
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
>
> Finally, as suggested by Andy Shevchenko, add some tests and for
> that introduce also u8 helpers. The tests don't compile without
> the fix, showing that it's necessary.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>


> Fixes: 00b0c9b82663 ("Add primitives for manipulating bitfields both in host- and fixed-endian.")
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> ---
> v2: replace stray tab by space
> v3: u8 helpers, tests
> v4: minor cleanup (Andy)
>     split into two patches (Andy)
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
