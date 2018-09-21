Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBCAC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5F4521523
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="vdKGzHtY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F4521523
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391228AbeIVASS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:18:18 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38804 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391102AbeIVASS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:18:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id t25-v6so4257941wmi.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DvL0MV040r5tEUQ0TdSiIDqY2QERNLaT9IjeENG3iXw=;
        b=vdKGzHtY+7oOfNdK/ocq6nnV0qac0jWv7jB+C7ONrUoLlasdO1RR4t/GuPd5B6h0nJ
         suh50CVWr0LIr8u5MWNpb0Q1SsHE+2b4+PsBRqrCkovR8zR2SmO8xKoc1jNzzs0nrehq
         hDKZ7aPzQ6EjQyM04RNovChnnZkGvfShYlYFzJJSremHjKmBPacps0vO3Gqz84aOwNSX
         edpqGogzH2Rn9Uy2cZ0iCYQLizxc9mGO3/YZ7Mo+67Y95eeq/muk3cNL0cinPq2j0hT9
         CweXQPtAK2iRkPP9C48XLXIOuiNKpRVjr7f96uR+OQ8lVTRK2soUqwQkrWm/rqOtGbkc
         jQfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DvL0MV040r5tEUQ0TdSiIDqY2QERNLaT9IjeENG3iXw=;
        b=Xwp47+YuKvTbuzZ937UVCHOxqKOVizvVHGqABzTGRfUPDIMkq12z6/LbVo86YKgrNr
         vNkq9b5UuJOQF/GRcPC3WyecK+o4xTh3W9Ke/tQLC04fAnus+kpH5mc2uZGjFX//TH5F
         DuQBunkA3zXVIL1yw2a5J6qT7781t5tiu6E9KsiVWwrP5jTn6vJsAI5cyJbJ2eall9Mh
         JxSx39K9tBF8X5tOZ00Tqn9wG2ouZgB+wo/5V3R4wUQc9DpxYMyMjoSn9jVvk+cl7N6E
         YmHNEiD+XIFy3ukXiqpFngDzJ3UKnoSN0Mgs19ZdslkN3727tx3MbCYb5vQZA2J+iLJd
         yJ1A==
X-Gm-Message-State: APzg51CCQp8yQZrocU6RHiXMqBEN5R7p+GxmVSSQVwW4j15gaqanhuIP
        NXWrHAaleYqGft+Rt9a6ilAjjnEn66j7ouJFIAntnA==
X-Google-Smtp-Source: ANB0VdaI347KRWLqgu7sb3f+qWDWz8kMGOaMcMIKC7kDyxFSiI4X2S2A4kI2hBgfyIhB11Ie1qlm9WQHJsgqYN1wAdo=
X-Received: by 2002:a1c:ac04:: with SMTP id v4-v6mr8182070wme.51.1537554491101;
 Fri, 21 Sep 2018 11:28:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180906152859.7810-1-tycho@tycho.ws> <20180906152859.7810-5-tycho@tycho.ws>
 <CALCETrWZmN4FeCSwemfMeayupBmQ-NqpVWQuqSU34CLvzdx8gw@mail.gmail.com>
 <20180919095536.GM4672@cisco> <C1406292-7496-459F-A76A-20C9EFBB12D6@amacapital.net>
 <20180919143842.GN4672@cisco> <CALCETrVuP0nQ5B01-iWrcQ87hisz7=jA08-Uisqud_r+zc74NQ@mail.gmail.com>
 <20180920234240.GR4672@cisco> <CALCETrWEr_VAtJu1mm1akTigsRUXAA7_7RHb-WGHqnyNy=j17Q@mail.gmail.com>
 <20180921133928.GS4672@cisco>
In-Reply-To: <20180921133928.GS4672@cisco>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 21 Sep 2018 11:27:59 -0700
Message-ID: <CALCETrWxjLw6-pMcOydDxbf6KfMrYZcdriTk5g7U3Ba6cRNJNg@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] seccomp: add support for passing fds via USER_NOTIF
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Akihiro Suda <suda.akihiro@lab.ntt.co.jp>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 6:39 AM Tycho Andersen <tycho@tycho.ws> wrote:
>
> On Thu, Sep 20, 2018 at 07:18:45PM -0700, Andy Lutomirski wrote:
> >
> > I think we just want the operation to cover all the cases.  Let PUT_FD
> > take a source fd and a dest fd.  If the source fd is -1, the dest is
> > closed.  If the source is -1 and the dest is -1, return -EINVAL.  If
> > the dest is -1, allocate an fd.  If the dest is >= 0, work like
> > dup2().  (The latter could be necessary to emulate things like, say,
> > dup2 :))
>
> ...then if we're going to allow overwriting fds, we'd need to lift out
> the logic from do_dup2 somewhere? Is this getting too complicated? :)
>

fds are complicated :-p

More seriously, though, I think it's okay if we don't support
everything out of the box.  getting the general semantics I suggested
is kind of nice because the resulting API is conceptually simple, even
if it encapsulates three cases.  But I'd be okay with only supporting
add-an-fd-at-an-unused-position and delete-an-fd out of the box --
more can be added if there's demand.

But I think that exposing an operation that allocates and reserves an
fd without putting anything in the slot is awkward, and it opens us up
to weird corner cases becoming visible that are currently there but
mostly hidden.  For example, what happens if someone overwrites a
reserved fd with dup2()?  (The answer is apparently -EBUSY -- see the
big comment in do_dup2() in fs/file.c.)  But there's a more
significant nastiness: what happens if someone abuses your new
mechanism to overwrite a reserved fd that belongs to a different
thread?  It looks like you'll hit the BUG_ON(fdt->fd[fd] != NULL); in
__fd_install().  So unless you actually track which unused fds you own
and enforce that the final installation installs in the right slot,
you have a problem.

BTW, socketpair() isn't the only thing that can add two fds.
recvmsg() can, too, as can pipe() and pipe2().  Some of the DRM ioctls
may as well for all I know.  But socketpair(), pipe(), and recvmsg()
can be credibly emulated by adding each fd in sequence and then
deleting them all of one fails.  Sure, this could race against dup2(),
but I'm not sure we care.

--Andy
