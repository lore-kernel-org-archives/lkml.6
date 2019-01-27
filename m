Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB007C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81FF42133D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JatgrwFl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfA0TNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:13:18 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:38372 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726589AbfA0TNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:13:17 -0500
Received: by mail-ua1-f67.google.com with SMTP id p9so4910777uaa.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 11:13:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Eizg2jlYq1toUm/1B81h9RQBkK4qhbPPlgl/r1/VguQ=;
        b=JatgrwFlGGTh00WR6rTnmZptjOePWFHebv8Mt5wvu5+EgeUpm3wz2/+IPOeUBHQUIa
         zoglWvaSU8Q9uMOhd3+gBDZHKObu7NlhWTtsJlceoZ/xZn6rDVxcgmaJF9Jl3++biweD
         FaJfU+/v3bH86nC6VF9mIpQdzWvYbWrx95caw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eizg2jlYq1toUm/1B81h9RQBkK4qhbPPlgl/r1/VguQ=;
        b=kNOwYIaHf4By3DEMH2Sk1MJaP0wIBErJ7O1SUBudicNaTEb4IC7QZM2F+Zm4qgLMt1
         omV6cDK3f6041syeLwu9X15uQ4Kv865yaDlWm1nyf89ZDOt8gbHecD/wsCpvz3I+nW/h
         lFP4x3RSxpaaI+rZEBDbShtI8cKQU//mI/NT2bPBY1tb2DRiAcvjvz3CKSfPlSusOoZX
         8tkXAJ+vOxrefWSh0gwkTm3ASyAv88rwPJI/xp3nOsq8UdNQqwLoB3Nx7k8HMqb2oFNB
         aqhF+aosHP2gIHhU15RqiWTTOqVJwY6uC4/KztvUkDdcvgH4kqFJPPNI7udclTKKD0me
         crGA==
X-Gm-Message-State: AJcUukeLFYJJyPTvvrISzQR1We4ozX2o42joBASi6TGIhng/gU5dA/qU
        Kddx8HbUGyH9m51vlplTLnBmGShiHQU=
X-Google-Smtp-Source: ALg8bN5CftxJbU9HAd9qe4lro3WPGtvtoBQO8ez1xsW+BwIMwrJFpwA8eQeGjKyA2f17FMIPuNj/bw==
X-Received: by 2002:ab0:1425:: with SMTP id b34mr7576045uae.64.1548616395948;
        Sun, 27 Jan 2019 11:13:15 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id t133sm31385370vsc.8.2019.01.27.11.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 11:13:14 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id z24so4901443ual.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 11:13:14 -0800 (PST)
X-Received: by 2002:ab0:740a:: with SMTP id r10mr7447977uap.14.1548616394306;
 Sun, 27 Jan 2019 11:13:14 -0800 (PST)
MIME-Version: 1.0
References: <20190127094357.GA9436@beast> <CAKwvOdnUzTXSBPayebsy8pJGjJjPS3oi3qE8nRPtAhtv_PJ4xw@mail.gmail.com>
In-Reply-To: <CAKwvOdnUzTXSBPayebsy8pJGjJjPS3oi3qE8nRPtAhtv_PJ4xw@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 28 Jan 2019 08:13:01 +1300
X-Gmail-Original-Message-ID: <CAGXu5jKDdutht_+hVhKan6cNZ+bS7e0gom5yXmcMgKE9KuZwYg@mail.gmail.com>
Message-ID: <CAGXu5jKDdutht_+hVhKan6cNZ+bS7e0gom5yXmcMgKE9KuZwYg@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: Actually sleep for 1/10th second
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 11:25 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, Jan 27, 2019 at 1:44 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Clang noticed that some none-zero sleep()s were actually using zero
> > anyway. This switches to nanosleep() to gain sub-second granularity.
> >
> > seccomp_bpf.c:2625:9: warning: implicit conversion from 'double' to
> >       'unsigned int' changes value from 0.1 to 0 [-Wliteral-conversion]
> >                 sleep(0.1);
> >                 ~~~~~ ^~~
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > index 067cb4607d6c..a9f278c13f13 100644
> > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > @@ -2569,6 +2569,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
> >  {
> >         long ret, sib;
> >         void *status;
> > +       struct timespec delay = { .tv_nsec = 100000000 };
>
> "Omitted fields are implicitly initialized the same as for objects
> that have static storage duration."
> https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> https://godbolt.org/z/cuGqxM
> (So this wont sleep an arbitrary amount of seconds, phew)

Yup. :) Even an empty initializer works ... = { };
(Except that padding bytes aren't always included in the zeroing...)

>
> >
> >         ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> >                 TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> > @@ -2622,7 +2623,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
> >         EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
> >         /* Poll for actual task death. pthread_join doesn't guarantee it. */
> >         while (!kill(self->sibling[sib].system_tid, 0))
> > -               sleep(0.1);
> > +               nanosleep(&delay, NULL);
> >         /* Switch to the remaining sibling */
> >         sib = !sib;
> >
> > @@ -2647,7 +2648,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
> >         EXPECT_EQ(0, (long)status);
> >         /* Poll for actual task death. pthread_join doesn't guarantee it. */
> >         while (!kill(self->sibling[sib].system_tid, 0))
> > -               sleep(0.1);
> > +               nanosleep(&delay, NULL);
>
> Interesting bug.  If the sleeps weren't doing anything, are they even
> needed? Does adding the tests cause them to continue to pass, or start
> to fail?  If they weren't doing anything, and the tests were passing,
> maybe it's just better to remove them?

It was just spinning. This restores the intention of not being so
aggressive in the wait loop. While the sleep could be removed, that
wasn't the intention.

-- 
Kees Cook
