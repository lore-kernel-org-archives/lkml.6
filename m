Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43705C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 059C52082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 19:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SOhodhg+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059C52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbeJ3EiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 00:38:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40220 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbeJ3EiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 00:38:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id f18-v6so5744184qkm.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jAAOcWZXrc9pNA9zgpJnUaBbYEUNJCtGEP2DciOoHTw=;
        b=SOhodhg+8z2QLVwE9sh5BDJGHrPZqrA7xpbiRKqqJL5+rAuwySOcDmXAkdtG1BN2IG
         uRTaAW/8+h/HHrpwF+CaVUoLk9sRSfTI4s0WHuE3WVQC/yasuChDpUci9KGGlyFJyiuH
         i/eIfZkDM5o5LgI/Yoht6sTtCvr2E26wjq3pSZhCKUJ02ICSIrm9Dq29OFVjXIqguZUP
         lS6WvVS+6tyx8H90lm2fnjM51doePmWHYNRu3I7QoZ8Rmajlud18L6IZP8hw+oXdJwbJ
         bu8rPbov6HDTRiEmmCMkx1coRh/OJYMFpYKmdno6B8jZ8PZAKn/OGk0C2QCp/OnPRu03
         wzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jAAOcWZXrc9pNA9zgpJnUaBbYEUNJCtGEP2DciOoHTw=;
        b=TIEsnxDfqvG+p8AhV2A9nTQzT54JwMCos1juS1vrQwZTdTa+BzzOPoBzgJaCWYiSAg
         5pO6GDbuG6HM+5JerVOGmIm55Hb6Qov7/Gt+4i5qUxQybQ63YAKB044MNJ8WDdw2/dmn
         pKpf9p8cYudnTAmnLD3RJMbmXM83+eTwfA0JjkP84CD5BzBYgktDzWWVjGTny1Ht4Vyj
         wVnOmZaMtUOo5CPJ88SXITLTfWhuH+KZPFt1P2NUaRAZUlLhzJq+hUOEqmm3Rn+XSkrB
         tOI+rALVeArT7THQE1g90MyALiGr4I9I9jUf8tJaXx3tlI+xGWX0bY9UNNb4AscVs1hm
         1Zuw==
X-Gm-Message-State: AGRZ1gJSEtM18lt60YwzzuD80eTZPKuCMD7kQqXVFzqyAFWArDqkR+Rx
        m93mSXFvEJs6MmaSxtvurGyaDEfQCOnRccInCstqBQ==
X-Google-Smtp-Source: AJdET5dFoZ9sxJkTWP5K44m2QpQjNb2ptuHVNk7ZM6bsnB1ibK5s4L0VB+u8UeN1QUvcx2yw6uyJtxCinpr2hwqlqNw=
X-Received: by 2002:a37:12a1:: with SMTP id 33mr12822845qks.189.1540842491115;
 Mon, 29 Oct 2018 12:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181029175322.189042-1-dancol@google.com> <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
In-Reply-To: <CAJWu+opR5bU7b0ux5GZjO-Wu+=2F8sARke-E_y4PpH0XSubx9g@mail.gmail.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Mon, 29 Oct 2018 12:47:57 -0700
Message-ID: <CAJWu+oro6rxxCdU7s00ZBhV0UZi6s8Cmupr1U9njo4cvhaqk9g@mail.gmail.com>
Subject: Re: [RFC PATCH] Minimal non-child process exit notification support
To:     Daniel Colascione <dancol@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 12:45 PM Joel Fernandes <joelaf@google.com> wrote:
>
> On Mon, Oct 29, 2018 at 10:53 AM Daniel Colascione <dancol@google.com> wrote:
> >
> > This patch adds a new file under /proc/pid, /proc/pid/exithand.
> > Attempting to read from an exithand file will block until the
> > corresponding process exits, at which point the read will successfully
> > complete with EOF.  The file descriptor supports both blocking
> > operations and poll(2). It's intended to be a minimal interface for
> > allowing a program to wait for the exit of a process that is not one
> > of its children.
> >
> > Why might we want this interface? Android's lmkd kills processes in
> > order to free memory in response to various memory pressure
> > signals. It's desirable to wait until a killed process actually exits
> > before moving on (if needed) to killing the next process. Since the
> > processes that lmkd kills are not lmkd's children, lmkd currently
> > lacks a way to wait for a proces to actually die after being sent
> > SIGKILL; today, lmkd resorts to polling the proc filesystem pid
>
> Any idea why it needs to wait and then send SIGKILL? Why not do
> SIGKILL and look for errno == ESRCH in a loop with a delay.
>

Sorry I take that back, I see it needs to wait after sending the kill,
not before (duh). Anyway if the polling is ever rewritten, another way
could be to do kill(pid, 0) and then check for return of -1 and errno
== ESRCH; instead of looking at /proc/
