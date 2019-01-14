Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70AFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAADE20663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 06:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cNTExYEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfANGrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 01:47:41 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:43098 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfANGrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 01:47:41 -0500
Received: by mail-io1-f67.google.com with SMTP id b23so16796349ios.10
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 22:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uMekQMBAQWpdU2bS28MdxystdPXbINwR2JAQC7wgnRE=;
        b=cNTExYEWiVE0K8MJW4WXhqhvJg/eyhvKOZhHjI1iD42e0hiIxnzoiqAycvHgJzbG37
         hBFTNy8gZyXr5whzBqd80ZZJzlD6UScstKVwiudNRTmEDQt9DJCPP8m68HiwoWD7QhOn
         GpcrRa90LhG/QcormFoYSr7Zakd0A4twlv6Pp2vAb3brqBunLIfsSxL0oXsCsLHuZ/9Q
         /OLcm+spRwWS1iN4fxc6d67qLx+UJJkWWN8p100l3iH8IMtly/grbrMWX8lDmne6neBa
         grIdtvnw+rhThZpJg4hlkw4d3/ffcUoAJB+Zzke/kZJQOf2Vj+5gd1wIRhqQD/2ZRlHT
         3uiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uMekQMBAQWpdU2bS28MdxystdPXbINwR2JAQC7wgnRE=;
        b=S6eaUz+W5USTTNRXJirRZO9Iehq4SQxivYFPqKJYMz5L90s36fozLnKN622y4fSZ2H
         FJN37058qMIN5hwjrJpgAc4jAgrT6vSbxMRQxfhKJbTDEW28TcEJHcIOCi9+7AnfzvsQ
         +G9GYeqM8+AB5Q6BgyqAm5cXaOaWqYNnzG590w/qcZifYKxJI4E7HuybTlIO5heeutr+
         6dDyj1xvEorMycWvsgNOeQygmDS/6vjnJGiGuOHniViQC6zJw/uTApneYeaN89C5sDrl
         sf2giVRCOvTRLjDp7kK2kEBmDj0gY4dG36RnMquwHRkKKc0V6TpSHeht93htd5UZscML
         3C3Q==
X-Gm-Message-State: AJcUukeIBFaaaEYnt7uE1t7SRGjj7867ku1iN5Tliff0ZlPWurY9XGTX
        ZIz8wZ0pcJoaB70haHggWiIOSWyL4WHHqmOrajAg2w==
X-Google-Smtp-Source: ALg8bN7uUIugd9+y5FnSDOENZXXgEv21SmcldQCOwH3BxKsxTTRA17p34KRP5n2GC4YvtiHc7x1By2kZEfqL1zrRuTA=
X-Received: by 2002:a6b:fa01:: with SMTP id p1mr9233738ioh.271.1547448459984;
 Sun, 13 Jan 2019 22:47:39 -0800 (PST)
MIME-Version: 1.0
References: <20190113183210.56154-1-olof@lixom.net>
In-Reply-To: <20190113183210.56154-1-olof@lixom.net>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 14 Jan 2019 07:47:28 +0100
Message-ID: <CACT4Y+baa--beaomge9yYhtxEfhAEtoCijSf17giZN+0ECbf+w@mail.gmail.com>
Subject: Re: [PATCH] lib: test_ubsan: VLA no longer used in kernel
To:     Olof Johansson <olof@lixom.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2019 at 7:32 PM Olof Johansson <olof@lixom.net> wrote:
>
> Since we now build with -Wvla, any use of VLA throws a warning.
> Including this test, so... maybe we should just remove the test?
>
> lib/test_ubsan.c: In function 'test_ubsan_vla_bound_not_positive':
> lib/test_ubsan.c:48:2: warning: ISO C90 forbids variable length array 'buf' [-Wvla]
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

Acked-by: Dmitry Vyukov <dvyukov@google.com>

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
