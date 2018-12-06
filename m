Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE58FC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E37214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 22:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WPnC+DN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E37214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbeLFWBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 17:01:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36571 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbeLFWBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 17:01:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id x23so1784365oix.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 14:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AQDh1O2lpA262K5Uyvruh1xnwad03V8WhzDflNbjN50=;
        b=WPnC+DN1aIU6aI9aqrjgU48WLRz1OvtIn65km5e0+diBhXxiU0A9IHlQuHiaQP5lZ9
         NZIWK8R/47W/5STgTgYm3a3b0TSQLD/SsD0xj86C2DFc5COY5H9bOzUp1jsqkW85eeHY
         xFP1l2NQXKvfdLEtmYVWIJKDs7TOxKbfxgx1mrv/U6svZIb3C5DbetClKEMMhPFCwSzj
         DPiyMwrbe6El9RQlo02TrSjSx95ZWV+KS0hHQnzRuhYjdxR5He0Xv2G9oNDayyFs2rIy
         IveY5RCgjam0pHPxMlBpYMqeVD992x6OEx9GOpvKBs4cTJ2SvoMpMAdbpxj3w62JMEQh
         Xzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AQDh1O2lpA262K5Uyvruh1xnwad03V8WhzDflNbjN50=;
        b=AKoBfZ1PLw2xy5ND9Vi8D/8SuKXgCHYVrek8Kqzc1lRjPj2uCMppxMbWaj6iiOjmHF
         rXSMTK9iwSWbXguumOEe8iQNhn9xDbtS9fZdqU/6qD2TJdieT50BVkHpjBOKL55rkd6g
         RQffLGzYYwcMsuEdwSTioqcF4duWVT9yUdLd/h83J9r2hi07N8ktlCw+Mvp60E7TvevU
         /VJeHBXSXredyiCLQccrZjgvn2vkjWUZK7d0d8yvtcUQJWfUn9eku/aerMe2X8CpcS2B
         CnQk7xsBTEiVFfV+ONkahkRsMmGAG5YORJs+6Bu5Ygv9n722ALd0PtOfpxX1smrvbE/o
         t2hA==
X-Gm-Message-State: AA+aEWb/HAmYvtNLfXbKq1scBo2/ESRyz/1ciLycV22+1D6d/lTzWPpH
        9Xm8QD/69VIJhC/KZYMmKWe41r8HdqmAtO1ewU9raA==
X-Google-Smtp-Source: AFSGD/W0SvSbd1zhf5t0ul8aXdVJcC+ympPWdsd5OCv4xMnLnAs0ZY+ZnBhW0WlebFy/IeGpb6swFEgrR96RtJWBTGY=
X-Received: by 2002:aca:a60d:: with SMTP id p13mr19381459oie.2.1544133695950;
 Thu, 06 Dec 2018 14:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20181206121858.12215-1-christian@brauner.io> <87sgzahf7k.fsf@xmission.com>
 <D372C766-572C-4897-8F02-2FD0E72CCFAC@brauner.io> <875zw6bh2z.fsf@xmission.com>
 <20181206193017.wpxls5p3zgjd6rv2@brauner.io> <871s6u9z6u.fsf@xmission.com>
 <20181206213152.gvci7ijr3dokew7w@brauner.io> <87o99y72gi.fsf@xmission.com>
In-Reply-To: <87o99y72gi.fsf@xmission.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Thu, 6 Dec 2018 14:01:23 -0800
Message-ID: <CAKOZuetc_mFO=8tUHRJWpv6gyCYSR4u3AWkEAKZsd+a-CV7E5w@mail.gmail.com>
Subject: Re: [PATCH v4] signal: add taskfd_send_signal() syscall
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Florian Weimer <fweimer@redhat.com>, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 6, 2018 at 1:47 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Christian Brauner <christian@brauner.io> writes:
>
> >> Your intention is to add the thread case to support pthreads once the
> >> process case is sorted out.  So this is something that needs to be made
> >> clear.  Did I miss how you plan to handle threads?
> >
> > Yeah, maybe you missed it in the commit message [2] which is based on a
> > discussion with Andy [3] and Arnd [4]:
>
> Looking at your references I haven't missed it.  You are not deciding
> anything as of yet to keep it simple.  Except you are returning
> EOPNOTSUPP.  You are very much intending to do something.

So what *should* happen in that case? A panic? Come on. There's
nothing wrong with returning an error pending an expansion of
capabilities later.

> Decide.  Do you use the flags parameter or is the width of the
> target depending on the flags.

Huh?

> That is fundamental to how the system call and it's extensions work.
> That is fundamental to my review.

Your review makes no sense and comes off as an increasingly nitpicky
strategy of blocking the change no matter what Christian does. On
several occasions, you've just said "no, I don't like this" without
constructively trying to suggest an alternative that allows us to make
progress. That's obstruction, and this patch should get into the tree
over your nack.

> Until that is decided.
> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>
> There are a lot of fundamental maintenance issues and you can very easily
> get them wrong if you are not clear on the job of the file descriptor
> and the job of the flags argument.

There are no maintenance issues. Christian has bent over backwards
trying to address all the code concerns raised in this thread, and
nothing has been good enough.

> I want don't want new crap that we have to abandon that has a nasty set
> of bugs because no one wanted to think through the system call all of
> the way and understand the corner cases.

What bugs? You have identified no bugs. There is no problem with the
API signature. It signals a task. You get that from proc.
