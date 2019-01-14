Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6335DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B6420850
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 00:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RF9wF+r4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfANAQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 19:16:27 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40333 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfANAQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 19:16:27 -0500
Received: by mail-vs1-f66.google.com with SMTP id z3so12618149vsf.7
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 16:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gV/PKF9/Zm8zOFVUbaQEx+VvGb9hekmvligQMgGd4KI=;
        b=RF9wF+r4IlXqNCVNp2JW+iaGci5r/NrfKEp0IvLeha3h4B1sbZfgy0qeNprzLL1Wrz
         VYGxuC6rIr57Sq9S23mQV/SJAXd7vN04k5VR9RoRlCoASVS3c+hwmH46/DvMg9Y9ypny
         +XLdF8H+WWDyUuhi/eSRRGt6JRZFK3lK0tf7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gV/PKF9/Zm8zOFVUbaQEx+VvGb9hekmvligQMgGd4KI=;
        b=RVUs1SPAiJoJ8Pgrau6aI3dECWcHMm/ww4fnalzNy+eDGzV0LXeDEjAKg0XXrEwliL
         fXly14U33sngCyUlmte5NUgrG1GL3n8zS2jjd6VyS0GSWI4k0dnshwQvkHRuinnGBIsa
         W67x3M6RnUcg2rAH+nKRAP5yJsLdZz0VWtDKefqnkpm9/nNu0tOaYM6oerj0V/w9ni1X
         s7v6xxAqV1w5QqkCaZFXvKAgZSnJOEgUaA3uzGF6/6dWOhgyvoq+Rdj0XHpAoMSnV1OX
         8SQjfdHZ9aMbl4c1g3Xda5uKLsauqETh4o1nfIT7absIxWtKmu/lbnFBGwWQOIuTFV8W
         l2Jw==
X-Gm-Message-State: AJcUukeh3y1NqyQto03G5j6CzJFWwsBF1cZAIUrvFqDaPfObgRSsvG+d
        qBCNdIAN+CCzwIxKl6zjtjH3N749Eck=
X-Google-Smtp-Source: ALg8bN7xFioRdttEzvP+htQv9OLiUVcBGF7yAijACOxEYztQeOiH/URqqwE/bKJ6NPORaEj2JJspVA==
X-Received: by 2002:a67:3d92:: with SMTP id p18mr9728829vsi.51.1547424985367;
        Sun, 13 Jan 2019 16:16:25 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id y78sm22804610vsc.6.2019.01.13.16.16.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 16:16:24 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id d19so6495646uaq.11
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 16:16:23 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr8037100uap.14.1547424983232;
 Sun, 13 Jan 2019 16:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20190113183210.56154-1-olof@lixom.net>
In-Reply-To: <20190113183210.56154-1-olof@lixom.net>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 13 Jan 2019 16:16:10 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLJF-uXFB5cVgc163VevYSUOGJNBOe8qb7rYFfs3xp+rw@mail.gmail.com>
Message-ID: <CAGXu5jLJF-uXFB5cVgc163VevYSUOGJNBOe8qb7rYFfs3xp+rw@mail.gmail.com>
Subject: Re: [PATCH] lib: test_ubsan: VLA no longer used in kernel
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 10:32 AM Olof Johansson <olof@lixom.net> wrote:
>
> Since we now build with -Wvla, any use of VLA throws a warning.
> Including this test, so... maybe we should just remove the test?
>
> lib/test_ubsan.c: In function 'test_ubsan_vla_bound_not_positive':
> lib/test_ubsan.c:48:2: warning: ISO C90 forbids variable length array 'buf' [-Wvla]

I patched the Makefile to remove -Wvla for the *SAN tests. Something
recently seems to be stripping it from the build command line, though.
I haven't figured out what's going on...

-Kees

>
> For the out-of-bounds test, switch to non-VLA setup.
>
> lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
> lib/test_ubsan.c:64:2: warning: ISO C90 forbids variable length array 'arr' [-Wvla]
>
> Cc: Colin Ian King <colin.king@canonical.com>
> Cc: Jinbum Park <jinb.park7@gmail.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
>
> ---
>  lib/test_ubsan.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/lib/test_ubsan.c b/lib/test_ubsan.c
> index 280f4979d00ed..9ea10adf7a66f 100644
> --- a/lib/test_ubsan.c
> +++ b/lib/test_ubsan.c
> @@ -42,14 +42,6 @@ static void test_ubsan_divrem_overflow(void)
>         val /= val2;
>  }
>
> -static void test_ubsan_vla_bound_not_positive(void)
> -{
> -       volatile int size = -1;
> -       char buf[size];
> -
> -       (void)buf;
> -}
> -
>  static void test_ubsan_shift_out_of_bounds(void)
>  {
>         volatile int val = -1;
> @@ -61,7 +53,7 @@ static void test_ubsan_shift_out_of_bounds(void)
>  static void test_ubsan_out_of_bounds(void)
>  {
>         volatile int i = 4, j = 5;
> -       volatile int arr[i];
> +       volatile int arr[4];
>
>         arr[j] = i;
>  }
> @@ -113,7 +105,6 @@ static const test_ubsan_fp test_ubsan_array[] = {
>         test_ubsan_mul_overflow,
>         test_ubsan_negate_overflow,
>         test_ubsan_divrem_overflow,
> -       test_ubsan_vla_bound_not_positive,
>         test_ubsan_shift_out_of_bounds,
>         test_ubsan_out_of_bounds,
>         test_ubsan_load_invalid_value,
> --
> 2.11.0
>


-- 
Kees Cook
