Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7C9C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C4D2146E
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 10:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A9WaN9ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfA0KZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 05:25:53 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34049 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbfA0KZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 05:25:53 -0500
Received: by mail-pl1-f196.google.com with SMTP id w4so6491315plz.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tS+O5bkgmYiBFdni5pqGZZn1R5zRkxdQHSgWhvetoIU=;
        b=A9WaN9eeTO7hh7E2rxwbKRiQalEmPq+qZLeyLUGaNIuy2/BWrsCtgkyGw033zoR+rV
         QiFbWHNO/p/DkWpIp2MvgkWKXSsh3HDbkNVthDXBTaX23yb75W2MF893OIj+m3uYxK8h
         TXMHZh0TVY4JO0ED5hpTvD5EbXlx8H8QOD+WIXX1imqoZNsVajqPn1jeQZ2l9uUyJvbp
         aV+opiL1wgzLWM+ICN0ktoiz+It29MXjozzciOP7yYf4ebFClOX04ykrtTbEsGA1Tc3J
         mCvx46ofuHPBjcyHZkDUSuuCe59cpj3k+qDSBUOlv6QgLWMx5yfqDDTNlzkq7hgZLYUm
         HbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tS+O5bkgmYiBFdni5pqGZZn1R5zRkxdQHSgWhvetoIU=;
        b=P73Niq70QzFrF+GXpZwUjcTftfznNi1Dg2rAtAHA5Y+Algj6VAbSSy5EXoftr1FFRq
         e5F1cGehWyAD306kmGRuAHt6pJT8ZD0nBkTIm20CO7MPYCl5+Mi33QvlTuvPkKBa2hqh
         xqnz8Dhf3my+LMJOcWbXyy+N7Bgyy7bAAwbBmlURm9EfinryRU1KYF5Ic3o+QV1UNc8d
         KgKTePkix9kWPFwCc0vF9x7pc0oOI0cmOSrR110RggHSkYaFe7SPlFgQ7zgIFEj/hfnb
         iu8y3638FUBxKxjR7SPcBg73v7BBGB8lphR9EWfa892eJKmsvbsLuDbWFPlkAQL2oF/t
         whPQ==
X-Gm-Message-State: AJcUukcaB8ti/2b41zy78CC45B9She5fEz9OZIVap7gNa8Dfif+jkkwi
        DrpYsuML7gHQO/iJpjKwY8ntKwtI4vg40haHRbiYJg==
X-Google-Smtp-Source: ALg8bN5PijNlNaaPXHqvD2Tu5CMHvKzQFKdOFkF0PzJJ1U6tfQRRlQ/053IFemACiNMprxdrjhN7ID6RsPyJwOfFr8s=
X-Received: by 2002:a17:902:29ab:: with SMTP id h40mr17689235plb.238.1548584752034;
 Sun, 27 Jan 2019 02:25:52 -0800 (PST)
MIME-Version: 1.0
References: <20190127094357.GA9436@beast>
In-Reply-To: <20190127094357.GA9436@beast>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sun, 27 Jan 2019 02:25:41 -0800
Message-ID: <CAKwvOdnUzTXSBPayebsy8pJGjJjPS3oi3qE8nRPtAhtv_PJ4xw@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: Actually sleep for 1/10th second
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 1:44 AM Kees Cook <keescook@chromium.org> wrote:
>
> Clang noticed that some none-zero sleep()s were actually using zero
> anyway. This switches to nanosleep() to gain sub-second granularity.
>
> seccomp_bpf.c:2625:9: warning: implicit conversion from 'double' to
>       'unsigned int' changes value from 0.1 to 0 [-Wliteral-conversion]
>                 sleep(0.1);
>                 ~~~~~ ^~~
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 067cb4607d6c..a9f278c13f13 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2569,6 +2569,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
>  {
>         long ret, sib;
>         void *status;
> +       struct timespec delay = { .tv_nsec = 100000000 };

"Omitted fields are implicitly initialized the same as for objects
that have static storage duration."
https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
https://godbolt.org/z/cuGqxM
(So this wont sleep an arbitrary amount of seconds, phew)

>
>         ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
>                 TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> @@ -2622,7 +2623,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
>         EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
>         /* Poll for actual task death. pthread_join doesn't guarantee it. */
>         while (!kill(self->sibling[sib].system_tid, 0))
> -               sleep(0.1);
> +               nanosleep(&delay, NULL);
>         /* Switch to the remaining sibling */
>         sib = !sib;
>
> @@ -2647,7 +2648,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
>         EXPECT_EQ(0, (long)status);
>         /* Poll for actual task death. pthread_join doesn't guarantee it. */
>         while (!kill(self->sibling[sib].system_tid, 0))
> -               sleep(0.1);
> +               nanosleep(&delay, NULL);

Interesting bug.  If the sleeps weren't doing anything, are they even
needed? Does adding the tests cause them to continue to pass, or start
to fail?  If they weren't doing anything, and the tests were passing,
maybe it's just better to remove them?

-- 
Thanks,
~Nick Desaulniers
