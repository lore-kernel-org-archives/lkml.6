Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB17DC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F582086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 17:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCmrQSBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbeLQRzH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:55:07 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45422 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbeLQRzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 12:55:07 -0500
Received: by mail-yw1-f66.google.com with SMTP id d190so5517800ywd.12
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R142Af8S4+nDvwizS8eKxPf6ARzbdnXloXlKGZpi1XU=;
        b=TCmrQSBemDM/tVpSOFKHAtSxIFnMCqaEcLHVn6jICkghFSgO0jWtZUcj5XpJuonAxf
         ij527Wac+XiTBtm6uJJ/1kD2eexMVew4XCX2d3xyCNRn8hCFYFmZeIr0yI6dd5x2Fb/b
         R1QmQfbDCAwue6AvUT8+IdADbZwyrSNkCizuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R142Af8S4+nDvwizS8eKxPf6ARzbdnXloXlKGZpi1XU=;
        b=MY0KZoxq83V41LXiw1vUaosqOfcnBmiLq67lrCj6FUQ4hxqiYr4gqMHrufkSkZbCS9
         coWkYaJpLNLwFAPtMlRVagjHqJUf0C1Hr8xAsS5Gx0Y4BltvNLhrWPjcYhFv7k+MckOL
         QMpit8+YeX4Z7aZJ1rIHoeYhP8lqEN5QSiCMkUBgKoYW44ZAXR8BRZi96WJwUabwT/V6
         MD7OQ8vWHd5Sh/YsXW+uzk4CgR6xE2j9eeEwHnJ8Zi3L4de+4rynoTrX5yM83+lz7eNh
         NqEwHKbOeMCZ1OaVb7gaD1e5mNB3NJEYMvDfI+y7GOP/4pdoyMlkfM20axPxNwFPLfWB
         wsBg==
X-Gm-Message-State: AA+aEWaYWkize2P7IEVatVOQI7SVo2ggxFOPste7tKxB5KO5LiaXRj81
        CHkhkGXhdSgSJMqMB6vRJK43MJraHqc=
X-Google-Smtp-Source: AFSGD/V8cCI7dw5c25pEewyRUtLep3O6bl/FoeNWR+vL3fvKWZlfhhY4rvRYfjhHr91LUJ43S4+EOA==
X-Received: by 2002:a81:30d6:: with SMTP id w205mr14679403yww.27.1545069305195;
        Mon, 17 Dec 2018 09:55:05 -0800 (PST)
Received: from mail-yw1-f48.google.com (mail-yw1-f48.google.com. [209.85.161.48])
        by smtp.gmail.com with ESMTPSA id x82sm4607477ywb.34.2018.12.17.09.55.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 09:55:02 -0800 (PST)
Received: by mail-yw1-f48.google.com with SMTP id i73so4368416ywg.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 09:55:01 -0800 (PST)
X-Received: by 2002:a81:71c5:: with SMTP id m188mr14685603ywc.353.1545069301263;
 Mon, 17 Dec 2018 09:55:01 -0800 (PST)
MIME-Version: 1.0
References: <20181213201030.4072-1-tycho@tycho.ws> <CAGXu5jLY16CjNZZ0QvkyaKep-qD8kEVZEnTQ7JqfozqAm=so_Q@mail.gmail.com>
 <20181217124154.GA3560@osiris>
In-Reply-To: <20181217124154.GA3560@osiris>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Dec 2018 09:54:47 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJqMtpzO2xCKJE3s0qthRFmGD6Q4_puXk27WaGxrdhDMQ@mail.gmail.com>
Message-ID: <CAGXu5jJqMtpzO2xCKJE3s0qthRFmGD6Q4_puXk27WaGxrdhDMQ@mail.gmail.com>
Subject: Re: [PATCH] seccomp, s390: fix build for syscall type change
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        James Morris <jmorris@namei.org>
Cc:     Tycho Andersen <tycho@tycho.ws>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        prudo@linux.vnet.ibm.com, linux-s390 <linux-s390@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Next <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 4:42 AM Heiko Carstens
<heiko.carstens@de.ibm.com> wrote:
>
> On Thu, Dec 13, 2018 at 04:50:06PM -0800, Kees Cook wrote:
> > On Thu, Dec 13, 2018 at 12:10 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > >
> > > A recent patch landed in the security tree [1] that changed the type of the
> > > seccomp syscall. Unfortunately, I didn't quite get every instance of the
> > > forward declarations, and thus there is a build failure. Here's the last
> > > one that I could find, for s390. It should go through the security tree,
> > > although hopefully some s390 people can check and make sure it looks
> > > reasonable?
> > >
> > > The only oddity is the trailing semicolon; some lines around this patch
> > > have it, and some lines don't. I've left this one as-is.
> > >
> > > [1]: https://lore.kernel.org/lkml/20181212231630.GA31584@beast/T/#u
> > >
> > > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> >
> > Thanks! Added to my -next tree.
> >
> > -Kees
>
> Hi Kees,
>
> did you forget to push your tree? At least today's linux-next kernel
> fails to compile on s390 because of this missing patch.

I sent a pull request to James for this. James, can you pick this up please?

-Kees

>
> > >  arch/s390/kernel/compat_wrapper.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
> > > index 2ce28bf0c5ec..48c4ce668244 100644
> > > --- a/arch/s390/kernel/compat_wrapper.c
> > > +++ b/arch/s390/kernel/compat_wrapper.c
> > > @@ -164,7 +164,7 @@ COMPAT_SYSCALL_WRAP3(finit_module, int, fd, const char __user *, uargs, int, fla
> > >  COMPAT_SYSCALL_WRAP3(sched_setattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, flags);
> > >  COMPAT_SYSCALL_WRAP4(sched_getattr, pid_t, pid, struct sched_attr __user *, attr, unsigned int, size, unsigned int, flags);
> > >  COMPAT_SYSCALL_WRAP5(renameat2, int, olddfd, const char __user *, oldname, int, newdfd, const char __user *, newname, unsigned int, flags);
> > > -COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, const char __user *, uargs)
> > > +COMPAT_SYSCALL_WRAP3(seccomp, unsigned int, op, unsigned int, flags, void __user *, uargs)
> > >  COMPAT_SYSCALL_WRAP3(getrandom, char __user *, buf, size_t, count, unsigned int, flags)
> > >  COMPAT_SYSCALL_WRAP2(memfd_create, const char __user *, uname, unsigned int, flags)
> > >  COMPAT_SYSCALL_WRAP3(bpf, int, cmd, union bpf_attr *, attr, unsigned int, size);
>


-- 
Kees Cook
