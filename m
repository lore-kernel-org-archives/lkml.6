Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5642EC282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21FEC214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FvLBYAMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA0KKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:10:43 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39074 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfA0KKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 05:10:43 -0500
Received: by mail-pg1-f193.google.com with SMTP id w6so5983744pgl.6
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 02:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bm4S38OvUfth1WRH5V4BXnUuOcSzHRHuQVk6gI8gePY=;
        b=FvLBYAMiZyAefdFtHexkF6AbpbIbe80hESgpUPkfVf3j9I+Tpbma35KaMHfL/yJucw
         C10PNt7EfpT036g11c73yDJPRiF8IWdqeBxs25AlKCnO1TU8s1Kj3P5dAMGkBvB8/2bu
         qrvajqJt63LhLycDCsDeT5zxljhQXLiipwn79hgmyndLiObAngNK8I+pAbT9yKnE4soM
         p+A2EYVRSTQPF99X/TL7KzdISRCjI4hkjyBhy7GN5lj0T/dteeyme/BrYzLRUFcTuaja
         a7YpT5vm7/gp4044weUMV/X42wibfHirjZyl6u+QRc74RYN89vGf1XVoWe/OKLkcxhrp
         fupQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bm4S38OvUfth1WRH5V4BXnUuOcSzHRHuQVk6gI8gePY=;
        b=gAE0J6DmFJeuODFin5lH2NMtp6aAamOjCGcK5/6kY5X+YdQOgI4UAJx39fLgjavAJH
         eDk9ACwltHiYSD9Jl5E98gOGTBPE9wFRVYgAYOPs2ZcWxd4NQAQj5w8G2W1fwK72hzyj
         LxsjdVheOO65GZ8Rf/S+fiRg6bp1BjQfUbxxW9q0h/6qKZRPoUXs/6NgOiGxv3IIsyp8
         ERJ/0QP+2fHntAvLzhJ8btBs1DOlzilTNvb/L/57DBHkDbi3xx14yIVtRl1yrW3REzbn
         r2tllnz0y+/a2JUHEDZU4TWrOl2zt7bTB7WEYmgAJ7xO09I1DILu0bYWL1QhNqkZm3FT
         w52Q==
X-Gm-Message-State: AJcUukdaeZZLzDaoJ9Mn5nNNYNp6VSSO5qD5F073hxX6oBflrYTBjCUO
        Avk5t4YdD5Jf0PXVDlPMqNpZR4efnwdvDYP+pZDceA==
X-Google-Smtp-Source: ALg8bN5UPuQP+Ez8L+v9nq1tKv1cATjSUoct+X5uQfEcWN9ucvcBfmOIqKmojGHmaBblhlCI8rwuge2Dh7BJUCSnHgg=
X-Received: by 2002:a62:b80a:: with SMTP id p10mr17739933pfe.32.1548583841499;
 Sun, 27 Jan 2019 02:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20190127094251.GA9391@beast>
In-Reply-To: <20190127094251.GA9391@beast>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sun, 27 Jan 2019 02:10:31 -0800
Message-ID: <CAKwvOd=2ox6FyqSYfSTmc4yyKL7=pktdKJrdweS8wxDKc5a+XA@mail.gmail.com>
Subject: Re: [PATCH] selftests/harness: Update named initializer syntax
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 1:42 AM Kees Cook <keescook@chromium.org> wrote:
>
> The harness was still using old-style GNU named initializer syntax.
> Fix this so Clang will stop warning:
>
> seccomp_bpf.c:2924:1: warning: use of GNU old-style field designator extension
>       [-Wgnu-designator]
> ./../kselftest_harness.h:147:25: note: expanded from macro 'TEST'
>                         ^
> ./../kselftest_harness.h:172:5: note: expanded from macro '__TEST_IMPL'
>                   fn: &test_name, termsig: _signal }; \
>                   ^
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/kselftest_harness.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index 76d654ef3234..2d90c98eeb67 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -168,8 +168,8 @@
>  #define __TEST_IMPL(test_name, _signal) \
>         static void test_name(struct __test_metadata *_metadata); \
>         static struct __test_metadata _##test_name##_object = \
> -               { name: "global." #test_name, \
> -                 fn: &test_name, termsig: _signal }; \
> +               { .name = "global." #test_name, \
> +                 .fn = &test_name, .termsig = _signal }; \
>         static void __attribute__((constructor)) _register_##test_name(void) \
>         { \
>                 __register_test(&_##test_name##_object); \
> @@ -304,9 +304,9 @@
>         } \
>         static struct __test_metadata \
>                       _##fixture_name##_##test_name##_object = { \
> -               name: #fixture_name "." #test_name, \
> -               fn: &wrapper_##fixture_name##_##test_name, \
> -               termsig: signal, \
> +               .name = #fixture_name "." #test_name, \
> +               .fn = &wrapper_##fixture_name##_##test_name, \
> +               .termsig = signal, \

My favorite feature of C, stolen now in C++20.  Thanks for cleaning this up.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>          }; \
>         static void __attribute__((constructor)) \
>                         _register_##fixture_name##_##test_name(void) \
> --
> 2.17.1
>
>
> --
> Kees Cook



-- 
Thanks,
~Nick Desaulniers
