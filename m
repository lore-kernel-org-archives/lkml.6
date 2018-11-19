Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F76C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CEF92086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 21:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bfsZvvLn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CEF92086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbeKTIHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 03:07:12 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46820 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731258AbeKTIHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 03:07:11 -0500
Received: by mail-vs1-f68.google.com with SMTP id r14so18675498vsc.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 13:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GU3TnvgcFfbK+HKMP9elr0xQDZ3OfrM2HTww2/am9rc=;
        b=bfsZvvLnHLB9a/UrM7/uN7JgQQtTF61We8C39OTZcoZAcIaKn5hsmtj4BZLCP2U6o/
         QT3T2vV5ohtX9uLul5dv1OuMy3+gE5JZaE9RIXXJBMy5y77IrTsba0Fl4u2bT4PtqUs2
         g+L+btPKhftoHl/GUZHzSBHmPJqXKEcjZXkcAWkXXo0OkIV2p9vVAr95jn1KgclGeEqp
         Tz18uDjZuMfq5m3XGj3o7ocFagAg/qMjgGY+eID2xw81tDr4wkFiEzkGMo52ZR95D6eW
         fyyJ7UsqAgtHiQf88zXEmSuWqvKuGZCDuU932P8JBH78sVle4/m2QGy57csHPUUJVUSC
         CBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GU3TnvgcFfbK+HKMP9elr0xQDZ3OfrM2HTww2/am9rc=;
        b=gNfUbkfVJvMdmqk0pSxAkcUU/y/VBPvWDtKM2cCsapP4L/4o65KkoWnXeeY1cryUAt
         2uDp1tuh95/Y5r5QuRo8pAiuuFypzIMHLPDqc9pg6Ys/tK6CqP4bT4EGU0PSoWavSDaH
         uqckFL0Nn3POvv5A990WdW4k2h9vULcRv+7C3szuLZ/t6IgQSN+2p/1lKB9fA5XrIP6P
         8NS5VVGIPwoDCPfJ//ekGrlOaknHpsfS/3fJZD07sXo85ItKGHLReFYIJdnwD7ImYDf/
         Xb67Jk3WopeItmngQoP394tOV+i96xgPRDhC5Mk//KExi28xm3Q7NM+9DEsG+TPHniFr
         oZgQ==
X-Gm-Message-State: AGRZ1gKFrbeTdsoeyAj9oZYAIYl3QBlm/ewLqE1seqsVl+0Ndqx5zSN+
        0CDqXCy/Tx4DhUvLgVK8zSpp43Ec9F+gwz+wKNTvhA==
X-Google-Smtp-Source: AJdET5eOAfCOE/LEzGElLqooWV4XAdRxU2EEVPbbcGXJ+0Vz5GyqYsUYvVcid2Hl2uMk+VcgtBT//tTw0m+aD4s7N2U=
X-Received: by 2002:a67:6346:: with SMTP id x67mr9699500vsb.114.1542663693374;
 Mon, 19 Nov 2018 13:41:33 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <20181119202857.k5zw742xjfrw677j@yavin> <20181119205518.btew3vxwgva4w3zh@brauner.io>
 <20181119211810.73ptfhnwdmkngfi4@yavin> <20181119212126.u2nkijmula6wcfqi@brauner.io>
 <CAKOZuevEx6CbcxrR8eVZrUXDcN5y1GPsXdSoHfQteSQKypx0qw@mail.gmail.com> <20181119213722.z54huio5g4kuldxk@brauner.io>
In-Reply-To: <20181119213722.z54huio5g4kuldxk@brauner.io>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 13:41:21 -0800
Message-ID: <CAKOZueup5L9Fd=tTK5g1415x0muLP_cPkxf4o26-kCPtH_caqw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Christian Brauner <christian@brauner.io>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 1:37 PM Christian Brauner <christian@brauner.io> wrote:
>
> On Mon, Nov 19, 2018 at 01:26:22PM -0800, Daniel Colascione wrote:
> > On Mon, Nov 19, 2018 at 1:21 PM, Christian Brauner <christian@brauner.io> wrote:
> > > That can be done without a loop by comparing the level counter for the
> > > two pid namespaces.
> > >
> > >>
> > >> And you can rewrite pidns_get_parent to use it. So you would instead be
> > >> doing:
> > >>
> > >>     if (pidns_is_descendant(proc_pid_ns, task_active_pid_ns(current)))
> > >>         return -EPERM;
> > >>
> > >> (Or you can just copy the 5-line loop into procfd_signal -- though I
> > >> imagine we'll need this for all of the procfd_* APIs.)
> >
> > Why is any of this even necessary? Why does the child namespace we're
> > considering even have a file descriptor to its ancestor's procfs? If
>
> Because you can send file descriptors between processes and container
> runtimes tend to do that.

Right. But why *would* a container runtime send one of these procfs
FDs to a container?

> > it has one of these FDs, it can already *read* all sorts of
> > information it really shouldn't be able to acquire, so the additional
> > ability to send a signal (subject to the usual permission checks)
> > feels like sticking a finger in a dike that's already well-perforated.
> > IMHO, we shouldn't bother with this check. The patch would be simpler
> > without it.
>
> We will definitely not allow signaling processes in an ancestor pid
> namespace! That is a security issue! I can imagine container runtimes
> killing their monitoring process etc. pp. Not happening, unless someone
> with deep expertise in signals can convince me otherwise.

If parent namespace procfs FDs or mounts really can leak into child
namespaces as easily as Aleksa says, then I don't mind adding the
check. I was under the impression that if you find yourself in this
situation, you already have a big problem.
