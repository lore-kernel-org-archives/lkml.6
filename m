Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2429AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89462086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 22:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hs7UApHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D89462086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731920AbeKTJP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:15:29 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:42993 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730419AbeKTJP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:15:29 -0500
Received: by mail-ot1-f66.google.com with SMTP id n46so29235543otb.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 14:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FTrqOBzCYW0EqmnRSq/KX6M623z4yUnSrlisGH7jWSk=;
        b=Hs7UApHA4lHIKAMiNHV8QeAwHFUCpL0TKvKBsmn4kSNY6p01JTJ1QdoqdtNfjP5oz4
         DR6pq+ATuYOh75ch+iGdBPdjTJJEET+syVJvghk7Kov3Aml0cSQpHAkmIMVYGv879a+U
         RekhOiTPNsPJM3Iy/xxpdl625Ks3vEifQY1AMqnm4j+USCBNrXrdgDFIyPylhCcw7gl8
         /KBY4xDP7/AvveyIt8zMHc5/QEMHkv/OskeNa2XbTzH/ARbnQGO1fNQPfdjUdULDp4LN
         w4VVrVDrimlZtC9S6s4WaPBV601+vGjHxMc26WABzRyEp6zYM+0f3pGkFE0fqIEIG/09
         DhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FTrqOBzCYW0EqmnRSq/KX6M623z4yUnSrlisGH7jWSk=;
        b=M+sxHqtTFuX+xzRug5b4h7ivXRTCR6qE5D85zceKCuUr2Yp/zBnMRvNjL+PIMxKPoE
         fvKu+XU7UhiZMylmXpDX6E8nyOVZDoqd0USDPLH0aX//gsDxDTImiiz8+iF3qwt9XQuS
         OAeybpo+K0XazO0EPuPxgqECK0WhAysy/Ju6D+03YMC40YbfT+6RgtCDSKV56zaDcxu/
         fNqLgwIo0ztqah7PPvN817yTcULasFC1cjqSdHqYlBjQMPKUp5y/yjrg02fWrOSGnJkT
         O5CpIj8Z0FJWAvEKm9hDIt/HxQl5amUHZhlI1I7TZBY2TukLhm1daMunMTfYS2wTfHV/
         9X3Q==
X-Gm-Message-State: AGRZ1gLNexaYHiGDeA8TmrB4amSE7AkA7eBDSMNkE/F3vQQdHZNFU/b4
        863nB29JdFV0QUzo+psGgLRvk7ug8/kF/uF302qfaQ==
X-Google-Smtp-Source: AJdET5cJlm2IDa51qZKUBwE0Js+dkSAamJQ2x4mpXrbfcdjocGPywcmwqAc+ZF+vmzs9e7yrNAK/3xaxSotwta2WzOw=
X-Received: by 2002:a9d:12d:: with SMTP id 42mr13623236otu.352.1542667774520;
 Mon, 19 Nov 2018 14:49:34 -0800 (PST)
MIME-Version: 1.0
References: <20181119103241.5229-1-christian@brauner.io> <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco>
In-Reply-To: <20181119223954.GA4992@cisco>
From:   Daniel Colascione <dancol@google.com>
Date:   Mon, 19 Nov 2018 14:49:22 -0800
Message-ID: <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
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

On Mon, Nov 19, 2018 at 2:40 PM Tycho Andersen <tycho@tycho.ws> wrote:
> Can I just register an objection here that I think using a syscall
> just for this is silly?

Yes, you can argue that the bikeshed should be ioctl-colored and not
syscall-colored.

> My understanding is that the concern is that some code might do:
>
> unknown_fd = recv_fd();
> ioctl(unknown_fd, SOME_IOCTL, NULL); // where SOME_IOCTL == PROC_FD_KILL
> // whoops, unknown_fd was a procfd and we killed a task!
>
> In my experience when writing fd sending/receiving code, the sender and
> receiver are fairly tightly coupled. Has anyone ever actually fixed a
> bug where they had an fd that they lost track of what "type" it was
> and screwed up like this? It seems completely theoretical to me.

Yes, I have fixed bugs of this form.

> The ioctl() approach has the benefit of being extensible.

The system call table is also extensible. ioctl is for when a given
piece of functionality *can't* realistically get its own system call
because it's separated from the main kernel somehow. procfs is a core
part of the kernel, so we can and should expose interfaces to it using
system calls.

> Adding a
> syscall means that everyone has to do all the boilerplate for each new
> pid op in the kernel, arches, libc, strace, etc.

These tools also care about ioctls. Adding a system call is a pain,
but the solution is to make adding system calls less of a pain, not to
permanently make the Linux ABI worse.
