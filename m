Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085DC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A02FE20684
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aVCWuwo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfAVNyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:54:40 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:37681 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfAVNyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:54:40 -0500
Received: by mail-it1-f196.google.com with SMTP id b5so20106281iti.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vrt00XEE7hMYYWS1xWhRin/2a/MlUA+hgmbfZmskq54=;
        b=aVCWuwo7Clp4I+pwA2arLHCfiUT/pe0mMTF8n50T7goZtbdII5liIo8jGnMvTLuIdS
         Of/q0OyHMLQeEjJHPO40KdjvAUL1pHXivYdWbG/UjbAHlSWJDW33IDQbgeZLH8vEQkcW
         u10vFfMlkrukxsHOK69wftPOtYvn3Tt3HrY11UFrK/YE52KuhOXfZ2YUGETZEwlAYmLQ
         hznJaOetOSXedOMQBWYYPq8/JmRQ2xrUgtlrQqlPbIbsaWmigylrCEPFaiZSKXG0aeWq
         Aga//7XrkWjOfrpmzRJXXZ6I3KMbXThCkKy41e94FW4xpeq3fEwdnOwrP2U+JJ+wg3u0
         KhWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vrt00XEE7hMYYWS1xWhRin/2a/MlUA+hgmbfZmskq54=;
        b=JvllbrEiy5Q4d/oPGGTN+0exJUkw8vaMbL3S9o3YvEOiqUzmmX50V7ixK84LLQg7xV
         khWGUr73YMzxhH9InSXw5Tvb5s7msOEhd4TOen7yDekkqjBhzJ1EHAw/XYR/bZCCcPA8
         xkcnveSw8Nj2/s7ltZg2FWLzPBn11lMScCzqnl0Qp5nS6EqPf2mHSnf0EUaJa0DiyIha
         cJELlIjfpWtHKyl8zACc+dgxJMu1MclhGscVG+iywrbMR9H6hNDHDSbIYcpZkdqO9IRP
         N3Ju9bXMpW6qaEcPUwDOt39tCX+B3Nj6jmUTy6BbVxXgRRbz9jHSYt+seL7qB0x5wibP
         8RAg==
X-Gm-Message-State: AJcUukfhVrfnGNYJ2oHKzr5lx2E9/4vH7YRn5VU/l/nkRqhw8inkvZif
        YVe0aq3T8FC6YbeBxZhiOA+FnPxlT09/PZO859q3dw==
X-Google-Smtp-Source: ALg8bN6M2+jLT9rXMFMYl0B6nASDNw3BP84b2+cgjyKYFpCgE6X3oicOiLJQvstcujV4l7DY9diQS1zg1kBSR9UAq1Q=
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr18479073jan.72.1548165279311;
 Tue, 22 Jan 2019 05:54:39 -0800 (PST)
MIME-Version: 1.0
References: <000000000000f7a28e057653dc6e@google.com> <20180920141058.4ed467594761e073606eafe2@linux-foundation.org>
 <CAHRSSEzX5HOUEQ6DgEF76OLGrwS1isWMdtvneBLOEEnwoMxVrA@mail.gmail.com>
 <CAEXW_YSot+3AMQ=jmDRowmqoOmQmujp9r8Dh18KJJN1EDmyHOw@mail.gmail.com>
 <20180921162110.e22d09a9e281d194db3c8359@linux-foundation.org>
 <4b0a5f8c-2be2-db38-a70d-8d497cb67665@I-love.SAKURA.ne.jp>
 <CACT4Y+ZTjCGd9XYUCUoqv+AqXrPwX4OqWMC0jFgjNxZRFkNYXw@mail.gmail.com>
 <c56d4d0b-8ecc-059d-69cb-4f3e91f9410c@i-love.sakura.ne.jp> <CACT4Y+YA38BfnByA_jrocbhbbqg7NWRe4-5UAp5Q-iKFi9hGQA@mail.gmail.com>
In-Reply-To: <CACT4Y+YA38BfnByA_jrocbhbbqg7NWRe4-5UAp5Q-iKFi9hGQA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 22 Jan 2019 14:54:28 +0100
Message-ID: <CACT4Y+b7KhMECUF01fz0+1LJOiqzJhTRHOvezN4baPNd02om0Q@mail.gmail.com>
Subject: Re: possible deadlock in __do_page_fault
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        syzbot+a76129f18c89f3e2ddd4@syzkaller.appspotmail.com,
        Andi Kleen <ak@linux.intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 2:52 PM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Tue, Jan 22, 2019 at 11:32 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >
> > On 2019/01/22 19:12, Dmitry Vyukov wrote:
> > > On Tue, Jan 22, 2019 at 11:02 AM Tetsuo Handa
> > > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> > >>
> > >> On 2018/09/22 8:21, Andrew Morton wrote:
> > >>> On Thu, 20 Sep 2018 19:33:15 -0400 Joel Fernandes <joel@joelfernandes.org> wrote:
> > >>>
> > >>>> On Thu, Sep 20, 2018 at 5:12 PM Todd Kjos <tkjos@google.com> wrote:
> > >>>>>
> > >>>>> +Joel Fernandes
> > >>>>>
> > >>>>> On Thu, Sep 20, 2018 at 2:11 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >>>>>>
> > >>>>>>
> > >>>>>> Thanks.  Let's cc the ashmem folks.
> > >>>>>>
> > >>>>
> > >>>> This should be fixed by https://patchwork.kernel.org/patch/10572477/
> > >>>>
> > >>>> It has Neil Brown's Reviewed-by but looks like didn't yet appear in
> > >>>> anyone's tree, could Greg take this patch?
> > >>>
> > >>> All is well.  That went into mainline yesterday, with a cc:stable.
> > >>>
> > >>
> > >> This problem was not fixed at all.
> > >
> > > There are at least 2 other open deadlocks involving ashmem:
> >
> > Yes, they involve ashmem_shrink_scan() => {shmem|vfs}_fallocate() sequence.
> > This approach tries to eliminate this sequence.
> >
> > >
> > > https://syzkaller.appspot.com/bug?extid=148c2885d71194f18d28
> > > https://syzkaller.appspot.com/bug?extid=4b8b031b89e6b96c4b2e
> > >
> > > Does this fix any of these too?
> >
> > I need checks from ashmem folks whether this approach is possible/correct.
> > But you can ask syzbot to test this patch before ashmem folks respond.
>
> Right. Let's do this.
>
> As with any kernel changes only you really know how to apply it, git
> tree/base commit info is missing, so let's do guessing and
> finger-crossing as usual:
>
> #syz fix: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> master

This of course should be:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master
