Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC8ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CD32089F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="hkET5GiQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K8Znm6EP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1CD32089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbeGOCKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 22:10:30 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:41378 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbeGOCKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 22:10:30 -0400
Received: by mail-yw0-f195.google.com with SMTP id q129-v6so10290419ywg.8
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 18:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7XpD6qbQsRu/9MCwId1Gu1dCBvskrl8mWMeOZWorsA0=;
        b=hkET5GiQYYsSeFbvSca/Bn35CXwjaLsvDskCDWJkXPAENX5k4K400pEf39vH0B5VEC
         z/K3i+RVQWbA3tAerFfwwifCBaNkyje+VvXveg7R/+ZhkSE56KCnYhAhI9UbwEaai6/2
         zOoVCaeNRikMNitS3CJmO0RNzCxKfXZ1yQPn4BURNEOQri2bYR9QxXDUd5YxQU7Col7g
         piiEnW6CLaVGrMQ5gu5W/QeiD+Cw13acCpOoeTowpKTSOCDN38AaKCqQf7O7rDH3NMNd
         8hMVIWIO6ovxtYTSvZFht9Kt2aHXf9VsAP2b0js0f68o/yyEmJKEirxNC0ZisCsmaRl5
         iopg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=7XpD6qbQsRu/9MCwId1Gu1dCBvskrl8mWMeOZWorsA0=;
        b=K8Znm6EPVeqjKZPNfgXJuMuk07Mvw2u9nrTsg2exnpqCM4darl5woJKPzYULODbvjR
         08au7YzmPw3mZtEnGj9LLmJWxZqZO1+TGEUoxmA9bAXZUI4rB19IjWaADy4wBDreixSr
         eqnU5L1o1LljciO+TohPniGloxB3Pt8EX/HKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=7XpD6qbQsRu/9MCwId1Gu1dCBvskrl8mWMeOZWorsA0=;
        b=D76BqQGB+VanStr7GsgY4/Nfr10jrq8x6BQg+ohSFUAYb9YDEzBvmdJT2NN8qmWYQI
         VKb26nSNaDxmA1ezKKC32ceoWBQ8UP4QXVSydZ9iNMN4PiPVt4teF/t6GTFvtzmCY4dX
         PtLwvVQiVEmxT/w9OuvwQ16h8pAFwPrhhaEl+zibJm1yT1kaJwDcWM75z3FcW5B4q3gG
         iYrPqDR3E1i+UZO3XbBNSZIY8t4sFIZRBRSDV/MOjmX7rm/akzIscQnvwLLz2fNLSZ3f
         unkMRjP+PQIljdRZl4iJR1LvzhTdRIR3YG0RsO3EzIhl+kRoRG6NxKr0flhRVjZJGY3j
         dD5w==
X-Gm-Message-State: AOUpUlGMuOsirffmJCtKYpNFUT7VhOeWeBLwg/73dENmSfc7BU4fLhza
        7M3JnAFR1h0WkRd9YAs8mzGAUqjyArDUMp4klKT1RA==
X-Google-Smtp-Source: AAOMgpd6DuwI6EAWKIarofhdI6PNsM0gF6ujUc3fr54vET8ytU2kEvXGdhGkOka6Tljh2qNITUSNYWQmxVCTycInyNE=
X-Received: by 2002:a0d:e2cd:: with SMTP id l196-v6mr5705907ywe.38.1531619364867;
 Sat, 14 Jul 2018 18:49:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 14 Jul 2018 18:49:24
 -0700 (PDT)
In-Reply-To: <20180705161709.17028-1-bart.vanassche@wdc.com>
References: <20180705161709.17028-1-bart.vanassche@wdc.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 14 Jul 2018 18:49:24 -0700
X-Google-Sender-Auth: jLGmqQNtZjy5pJ7GFKlkuwIC-6c
Message-ID: <CAGXu5jJJLh+oMcZ94nkrwCvyJzk6MzOATvt66WC-rHfxGTJh0Q@mail.gmail.com>
Subject: Re: [PATCH] kernel.h: Avoid that sparse complains about using sizeof(void)
To:     Bart Van Assche <bart.vanassche@wdc.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 9:17 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> The macro __is_constexpr() causes sparse to report the following:
>
>     warning: expression using sizeof(void)
>
> Avoid this by using __builtin_constant_p() instead.
>
> Fixes: 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Cc: <stable@vger.kernel.org>
> ---
>  include/linux/kernel.h | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> index d23123238534..a9f0d0d48971 100644
> --- a/include/linux/kernel.h
> +++ b/include/linux/kernel.h
> @@ -811,13 +811,19 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
>  #define __typecheck(x, y) \
>                 (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>
> +#ifndef __CHECKER__
>  /*
>   * This returns a constant expression while determining if an argument is
>   * a constant expression, most importantly without evaluating the argument.
> - * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>
> + * Glory to Martin Uecker <Martin.Uecker@med.uni-goettingen.de>. However, this
> + * macro causes sparse to report the warning "expression using sizeof(void)".
> + * Hence use __builtin_constant_p() instead when using sparse.
>   */
>  #define __is_constexpr(x) \
>         (sizeof(int) == sizeof(*(8 ? ((void *)((long)(x) * 0l)) : (int *)8)))
> +#else
> +#define __is_constexpr(x) __builtin_constant_p((x))
> +#endif
>
>  #define __no_side_effects(x, y) \
>                 (__is_constexpr(x) && __is_constexpr(y))

I'm fine with this; it'll only activate for sparse. I'd like to get
Linus's eyes on it, though, since this macro caused us SO much pain
that I'm nervous to change it without some greater level of review. :)

Acked-by: Kees Cook <keescook@chromium.org>

Thanks!

-Kees

-- 
Kees Cook
Pixel Security
