Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14842C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE5FF20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kSsgnz5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfAQQL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:11:59 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:45384 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAQQL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:11:59 -0500
Received: by mail-vs1-f67.google.com with SMTP id x28so6507465vsh.12
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvCbfe6+BA4bmqxvE40CWH2joCgUYyZEipOu/2VQ8xY=;
        b=kSsgnz5o9kzIxXZtwAh+sEjpW/YLb/9iioznbwxo9loHME/W7b4pk+Q1BN2JDhQ9bk
         JUe/SEji4jnow8RwzkudpkUtNYFqV9uOwgx3aYOoHHFPmRHGHLNi7+b40wX9oJgFwB3P
         e5BfAJrjuoSACpw5dd9uMg1or/7Yxf6aQalUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvCbfe6+BA4bmqxvE40CWH2joCgUYyZEipOu/2VQ8xY=;
        b=GAs2nG/R+bX7ws5CTA7Z1o8465pd0on0s8HKFB/rScBpH4WVTZZfIfW3VWPITstP44
         qFlC/ytMNt4vCLHEv1N7yNikHy4D0vMZ7AmVe/ezw//8jnxgWQS0XtSnP/CPlGo8wo/S
         v5Qzhixs84drEbhnQKUgUXrcG9jJdKw3xeIBhWwY/UaJYqUpfJCmhEgpEg9tuIfaSYmv
         Vme5q4LWWoOmloaZaqCyYhOVymt+scbtHZoox7WXgHjVwOfB6rjVyTGjQSxM4X0kwFbW
         zyeTDwMOSRx/KIrnLrSiBV/WXg4p2Jd255E2Fsuhdo0wqyz2sNxxr6bWcdxgE2Px0Gvr
         jm0w==
X-Gm-Message-State: AJcUukeRD2ZC+rIeADYJPmSTvAyhssqFYKJKsAaI0h5yQnaVw1wAedqk
        ymNG+FeFd0RVtD6JhYGEJrCFQF9EuTE=
X-Google-Smtp-Source: ALg8bN5z2s9X79wAkd2PbpXY7O6yS2A6bhk4NT5eCQ4KBN4vwJiSiuq5xMPW1my3ob+QqdAnaOAvYA==
X-Received: by 2002:a67:4441:: with SMTP id r62mr6245767vsa.38.1547741517072;
        Thu, 17 Jan 2019 08:11:57 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id x20sm2984972uan.12.2019.01.17.08.11.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:11:55 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id h78so6544578vsi.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 08:11:55 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr6096175vsl.188.1547741514481;
 Thu, 17 Jan 2019 08:11:54 -0800 (PST)
MIME-Version: 1.0
References: <7cd7d5bc-1d69-57f5-4a98-81b036f81682@kernel.org>
 <CAGXu5jLGqXstRCmM1_fxUxn4djs1YLUun2Fc8ExcaN4-CKyELQ@mail.gmail.com> <20190117004416.GA17449@cisco>
In-Reply-To: <20190117004416.GA17449@cisco>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 17 Jan 2019 08:11:41 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJKrCo7Sf0-nq2KxZ6+LZZ-cPTw8FY41QFWXZ9o_Mpz_w@mail.gmail.com>
Message-ID: <CAGXu5jJKrCo7Sf0-nq2KxZ6+LZZ-cPTw8FY41QFWXZ9o_Mpz_w@mail.gmail.com>
Subject: Re: Linux 5.0-rc2 seccomp_bpf user_notification_basic test hangs
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     shuah <shuah@kernel.org>, James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 4:44 PM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Wed, Jan 16, 2019 at 04:30:26PM -0800, Kees Cook wrote:
> > On Wed, Jan 16, 2019 at 4:01 PM shuah <shuah@kernel.org> wrote:
> > >
> > > Hi Kees and James,
> > >
> > > seccomp_bpf test hangs right after the following test passes
> > > with EBUSY. Please see log at the end.
> > >
> > > /* Installing a second listener in the chain should EBUSY */
> > >          EXPECT_EQ(user_trap_syscall(__NR_getpid,
> > >                                      SECCOMP_FILTER_FLAG_NEW_LISTENER),
> > >                    -1);
> > >          EXPECT_EQ(errno, EBUSY);
> > >
> > >
> > > The user_notification_basic test starts running I assume and then
> > > the hang.
> > >
> > > The only commit I see that could be suspect is the following as
> > > it talks about adding SECCOMP_RET_USER_NOTIF
> > >
> > > commit d9a7fa67b4bfe6ce93ee9aab23ae2e7ca0763e84
> > > Merge: f218a29c25ad 55b8cbe470d1
> > > Author: Linus Torvalds <torvalds@linux-foundation.org>
> > > Date:   Wed Jan 2 09:48:13 2019 -0800
> > >
> > >      Merge branch 'next-seccomp' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security
> > >
> > >      Pull seccomp updates from James Morris:
> > >
> > >       - Add SECCOMP_RET_USER_NOTIF
> > >
> > >       - seccomp fixes for sparse warnings and s390 build (Tycho)
> > >
> > >      * 'next-seccomp' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security:
> > >        seccomp, s390: fix build for syscall type change
> > >        seccomp: fix poor type promotion
> > >        samples: add an example of seccomp user trap
> > >        seccomp: add a return code to trap to userspace
> > >        seccomp: switch system call argument type to void *
> > >        seccomp: hoist struct seccomp_data recalculation higher
> > >
> > >
> > > Any ideas on how to proceed? Here is the log. The following
> > > reproduces the problem.
> > >
> > > make -C tools/testing/selftests/seccomp/ run_tests
> > >
> > >
> > > seccomp_bpf.c:2947:global.get_metadata:Expected 0 (0) ==
> > > seccomp(SECCOMP_SET_MODE_FILTER, SECCOMP_FILTER_FLAG_LOG, &prog)
> > > (18446744073709551615)
> > > seccomp_bpf.c:2959:global.get_metadata:Expected 1 (1) == read(pipefd[0],
> > > &buf, 1) (0)
> > > global.get_metadata: Test terminated by assertion
> > > [     FAIL ] global.get_metadata
> > > [ RUN      ] global.user_notification_basic
> > > seccomp_bpf.c:3036:global.user_notification_basic:Expected 0 (0) ==
> > > WEXITSTATUS(status) (1)
> > > seccomp_bpf.c:3039:global.user_notification_basic:Expected
> > > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > > seccomp_bpf.c:3040:global.user_notification_basic:Expected
> > > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > > seccomp_bpf.c:3041:global.user_notification_basic:Expected
> > > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > > seccomp_bpf.c:3042:global.user_notification_basic:Expected
> > > seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog) (18446744073709551615) == 0 (0)
> > > seccomp_bpf.c:3047:global.user_notification_basic:Expected listener
> > > (18446744073709551615) >= 0 (0)
> > > seccomp_bpf.c:3053:global.user_notification_basic:Expected errno (13) ==
> > > EBUSY (16)
> >
> > Looks like the test is unfriendly when running the current selftest on
> > an old kernel version. A quick look seems like it's missing some
> > ASSERT_* cases where EXPECT_* is used. I'll send a patch.
>
> ASSERT will kill the test case though right? I thought we were
> supposed to use EXPECT when we wanted it to keep going. In particular,
> it looks like in the get_metadata test, we should be using expect
> instead of assert in some places, so we can get to the write() that
> does the synchronization. Something like,
>
> diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> index 067cb4607d6c..4d2508af2483 100644
> --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> @@ -2943,11 +2943,11 @@ TEST(get_metadata)
>                 };
>
>                 /* one with log, one without */
> -               ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
> +               EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER,
>                                      SECCOMP_FILTER_FLAG_LOG, &prog));
> -               ASSERT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
> +               EXPECT_EQ(0, seccomp(SECCOMP_SET_MODE_FILTER, 0, &prog));
>
> -               ASSERT_EQ(0, close(pipefd[0]));
> +               EXPECT_EQ(0, close(pipefd[0]));
>                 ASSERT_EQ(1, write(pipefd[1], "1", 1));
>                 ASSERT_EQ(0, close(pipefd[1]));

Yeah, if it breaks badly on a failure, let's do it.

> But also, is running new tests on an old kernel expected to work? I
> didn't know that :).

It should at least not hang. :)

-- 
Kees Cook
