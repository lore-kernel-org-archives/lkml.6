Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 293A1C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:37:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7A7520879
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 19:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="egpKvoyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbfA0ThG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 14:37:06 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41062 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfA0ThG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 14:37:06 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so7007782pfi.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 11:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iswaYtuRIpgorJbr5F8vgDkzhyObrL9Z2r//oUkkKdk=;
        b=egpKvoypm3wNHa4XbB1fp0HbrjejpFiSb0wMlXB6cJEA87jXhpyVr7JWCBDo2hRNMK
         BpLHDwDXky+1Qpbst4vHnk7lPj66pTgKCEM5v2fnzMA7SOOJ1pI00MAjpOL43eceJwT+
         PqIUXrDukEOY8jgIN02rsveR+b0zCc1nBjqDEfufacStzddUCZH9tpXCoRGTSo3NsVyl
         CQeRukvbq5UICDxFJ4EspH0RMmDyUGMjrxlXP4Ar5MmBZMl3Gf39Xwj3dYk9LR4FdhBM
         0xpu62RgatUyErdnNayF33J1440hHvd79YWBdCs6rasV0tdnGCZPL0j2fO0bTL8zIiWH
         7KbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iswaYtuRIpgorJbr5F8vgDkzhyObrL9Z2r//oUkkKdk=;
        b=THbGTqIywZXK3yf6fQi5cWORNal+nugywFNkljigijG/3XSVLx3sDFzgxBaUaz/v8M
         xP1VqkN+g0REGH6aG20bQto1ay0mg/fYndFH0I9GYlIDoR/Zl+PgOKGFcwHJG8g50cfC
         xCm9KvF3VlO8tKxKx9OgzYlUeSQVLUKY19PLuRJlBTSRcGMM5zeEl7dA5vPsIo9w3Ma/
         UG18umWnHVVJokqUtqISlWTX5iu5HS4ofFeUUpJ84Iwu/sWKm4B16TKs0IE9pMdpX36w
         YdVVcvHsJ2DRIQx2hYKBZd21xFd/78fGW9J9xMbL2k/nC6nB5Mj4cFbk/hPmEqmdSWrJ
         h9kg==
X-Gm-Message-State: AJcUukfOQex4GobIunIUMVLLVaBgI9RbwHUp4KTdL5OHG5OnIkk0ylRI
        bg9JTz2tyX3P68N7UEo0+tZIe2HsYb+CFx5X+exlIw==
X-Google-Smtp-Source: ALg8bN7h5rZ7kRlac2/1UrwwkVSmvIdRJ+aJ3nO2OVezKbVQdBD6y0zHKAWB9VK4VT631AAvDmbalY7wlFhb+RCLdmg=
X-Received: by 2002:a62:2c81:: with SMTP id s123mr19100501pfs.174.1548617824791;
 Sun, 27 Jan 2019 11:37:04 -0800 (PST)
MIME-Version: 1.0
References: <20190127094357.GA9436@beast> <CAKwvOdnUzTXSBPayebsy8pJGjJjPS3oi3qE8nRPtAhtv_PJ4xw@mail.gmail.com>
 <CAGXu5jKDdutht_+hVhKan6cNZ+bS7e0gom5yXmcMgKE9KuZwYg@mail.gmail.com>
In-Reply-To: <CAGXu5jKDdutht_+hVhKan6cNZ+bS7e0gom5yXmcMgKE9KuZwYg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Sun, 27 Jan 2019 11:36:54 -0800
Message-ID: <CAKwvOdkvV+1qVUTz7G+nfftdzUfTGL+RnQ_8rA_RAhRrpvRLBA@mail.gmail.com>
Subject: Re: [PATCH] selftests/seccomp: Actually sleep for 1/10th second
To:     Kees Cook <keescook@chromium.org>
Cc:     Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 11:13 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Sun, Jan 27, 2019 at 11:25 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, Jan 27, 2019 at 1:44 AM Kees Cook <keescook@chromium.org> wrote:
> > >
> > > Clang noticed that some none-zero sleep()s were actually using zero
> > > anyway. This switches to nanosleep() to gain sub-second granularity.
> > >
> > > seccomp_bpf.c:2625:9: warning: implicit conversion from 'double' to
> > >       'unsigned int' changes value from 0.1 to 0 [-Wliteral-conversion]
> > >                 sleep(0.1);
> > >                 ~~~~~ ^~~
> > >
> > > Signed-off-by: Kees Cook <keescook@chromium.org>
> > > ---
> > >  tools/testing/selftests/seccomp/seccomp_bpf.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > > index 067cb4607d6c..a9f278c13f13 100644
> > > --- a/tools/testing/selftests/seccomp/seccomp_bpf.c
> > > +++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
> > > @@ -2569,6 +2569,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
> > >  {
> > >         long ret, sib;
> > >         void *status;
> > > +       struct timespec delay = { .tv_nsec = 100000000 };
> >
> > "Omitted fields are implicitly initialized the same as for objects
> > that have static storage duration."
> > https://gcc.gnu.org/onlinedocs/gcc/Designated-Inits.html
> > https://godbolt.org/z/cuGqxM
> > (So this wont sleep an arbitrary amount of seconds, phew)
>
> Yup. :) Even an empty initializer works ... = { };
> (Except that padding bytes aren't always included in the zeroing...)
>
> >
> > >
> > >         ASSERT_EQ(0, prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
> > >                 TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
> > > @@ -2622,7 +2623,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
> > >         EXPECT_EQ(SIBLING_EXIT_UNKILLED, (long)status);
> > >         /* Poll for actual task death. pthread_join doesn't guarantee it. */
> > >         while (!kill(self->sibling[sib].system_tid, 0))
> > > -               sleep(0.1);
> > > +               nanosleep(&delay, NULL);
> > >         /* Switch to the remaining sibling */
> > >         sib = !sib;
> > >
> > > @@ -2647,7 +2648,7 @@ TEST_F(TSYNC, two_siblings_not_under_filter)
> > >         EXPECT_EQ(0, (long)status);
> > >         /* Poll for actual task death. pthread_join doesn't guarantee it. */
> > >         while (!kill(self->sibling[sib].system_tid, 0))
> > > -               sleep(0.1);
> > > +               nanosleep(&delay, NULL);
> >
> > Interesting bug.  If the sleeps weren't doing anything, are they even
> > needed? Does adding the tests cause them to continue to pass, or start
> > to fail?  If they weren't doing anything, and the tests were passing,
> > maybe it's just better to remove them?
>
> It was just spinning.

So this test has been broken? If so, do you know for how long? Or
who's monitoring them?  Either way, thanks for noticing and fixing.

+Guenter; did you notice if this test was failing? Are your boot tests
running kselftests?

> This restores the intention of not being so
> aggressive in the wait loop. While the sleep could be removed, that
> wasn't the intention.

Oh, yeah I guess the comment above it about pthread_join is relevant.
I just get highly highly suspicious whenever I see sleeps added to any
code.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
