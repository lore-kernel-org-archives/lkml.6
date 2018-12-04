Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CBDC04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3272082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 00:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JoF//ver"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3272082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbeLDADU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 19:03:20 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:47037 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbeLDADT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 19:03:19 -0500
Received: by mail-lf1-f67.google.com with SMTP id f23so10557182lfc.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 16:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4K7yIBZFtcXnzyNWvJFcpBdx/s17elumaSwwTZXnU1Q=;
        b=JoF//verM7fYMxKhJvqgOX7fBd4H9+PbZUHbmzjUBGDL8E7ucFgV1lEUPYZelIQ1xf
         g4xuCd2x3opnVuSu/3vhVdE4ZMG3QUIC6L0KvvAaF9OKnEwadFCii10+IZpPW4m3cdEa
         Qics7JZJF9KcKUN0HJwmRu+JRfyop3VOCnACKckBHRPjG4VFPqGKFjgiMiTfkxdblICR
         kY6/0QVUzgVdUdZcOC2SNUBY4FwKf10AHOmrqBVLJuS4KKGa4g0f8h97XyswddgQGEzz
         bc8es7XdqPJRvTIOGQ90ueJrPBBJxl7Ojtm2gN6Xx+iRqdsJFNkYA6EbtGCvmIk3/J8Y
         tJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4K7yIBZFtcXnzyNWvJFcpBdx/s17elumaSwwTZXnU1Q=;
        b=GG651eaNUzjy8OJ8o5kTOcIjRtL+jWsNhD1X+3xpi6qMijcOJmXkBfn5RFZ7fXEQ5e
         zIH6y07PUDe/vYqzzB2MckAd7LxMrPMJHp+QOZSo7VDIV0DQIMQmMJJ1h6E1q5ct65Qr
         YvMfsSMwu3GTpaA7zzVaYTmQxK5FK435p9yPOJ+5ySpn5T/YyRvVxIj98xDMIKTBjLUX
         2PbqzfOtqoXFtClFlnZdyLH3GcxdcfwmbNQXRwwRkCTKGHfS9YiJmYPbQIp7gFlW+/Xa
         U0UVx9ofmMETDQBzRoLZY1UZE4/exT0rrmyFSnlQkgZIqUgguA59T8pqwBWo3WCHMBDo
         n7oA==
X-Gm-Message-State: AA+aEWbLvybIwgwv8nbSqZ5ezY7NmlMsAUBgZAcKqKq74bmh/elvEyVE
        J+Cg7KbNTiMXJQSqmZnFwgJLMvAmbjKIaPljezAD
X-Google-Smtp-Source: AFSGD/UJtAYMZRAvE0v8uG0QGntZniICdSLxWODrcPpwrTXC2UhYC0WXivTOng2eAw88GzftrcWA8IbnGCn8na8VAF4=
X-Received: by 2002:a19:6719:: with SMTP id b25mr9647612lfc.38.1543881797125;
 Mon, 03 Dec 2018 16:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20181203032827.27978-1-tycho@tycho.ws> <20181203032827.27978-3-tycho@tycho.ws>
 <20181203050108.GB31406@mail.hallyn.com>
In-Reply-To: <20181203050108.GB31406@mail.hallyn.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 3 Dec 2018 19:03:05 -0500
Message-ID: <CAHC9VhRsgv0bceoqCZt00qMc-KvuOkKsF1xaoYdmxUt93kPWmw@mail.gmail.com>
Subject: Re: [PATCH v9 2/4] seccomp: switch system call argument type to void *
To:     Serge Hallyn <serge@hallyn.com>
Cc:     Tycho Andersen <tycho@tycho.ws>, mtk.manpages@gmail.com,
        keescook@chromium.org, luto@amacapital.net, oleg@redhat.com,
        ebiederm@xmission.com, christian@brauner.io, tyhicks@canonical.com,
        suda.akihiro@lab.ntt.co.jp, asarai@suse.de, jannh@google.com,
        linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 12:01 AM Serge E. Hallyn <serge@hallyn.com> wrote:
> On Sun, Dec 02, 2018 at 08:28:25PM -0700, Tycho Andersen wrote:
> > The const qualifier causes problems for any code that wants to write to the
> > third argument of the seccomp syscall, as we will do in a future patch in
> > this series.
> >
> > The third argument to the seccomp syscall is documented as void *, so
> > rather than just dropping the const, let's switch everything to use void *
> > as well.
> >
> > I believe this is safe because of 1. the documentation above, 2. there's no
> > real type information exported about syscalls anywhere besides the man
> > pages.
> >
> > Signed-off-by: Tycho Andersen <tycho@tycho.ws>
> > CC: Kees Cook <keescook@chromium.org>
> > CC: Andy Lutomirski <luto@amacapital.net>
> > CC: Oleg Nesterov <oleg@redhat.com>
> > CC: Eric W. Biederman <ebiederm@xmission.com>
> > CC: "Serge E. Hallyn" <serge@hallyn.com>
>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> Though I'm not entirely convinced there will be no ill effects of changing
> the argument type.  I'll feel comfortable when Michael and Paul say it's
> fine :)

Well, looking at the seccomp(2) manpage on my system (dated
2018-02-02) the third argument is already shown as a "void *args":

 SYNOPSIS
      #include <linux/seccomp.h>
      #include <linux/filter.h>
      #include <linux/audit.h>
      #include <linux/signal.h>
      #include <sys/ptrace.h>

      int seccomp(unsigned int operation, unsigned int flags, void *args);

... so I think we're safe :)

From a libseccomp perspective, we always call seccomp(2) via
syscall(2) so it is unlikely we would ever run into problems, not too
mention that we are just talking about the pointer type used in the
kernel; from a syscall ABI perspective it is still a pointer value and
that is the important part.

> > CC: Christian Brauner <christian@brauner.io>
> > CC: Tyler Hicks <tyhicks@canonical.com>
> > CC: Akihiro Suda <suda.akihiro@lab.ntt.co.jp>
> > ---
> >  include/linux/seccomp.h | 2 +-
> >  kernel/seccomp.c        | 8 ++++----
> >  2 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
> > index e5320f6c8654..b5103c019cf4 100644
> > --- a/include/linux/seccomp.h
> > +++ b/include/linux/seccomp.h
> > @@ -43,7 +43,7 @@ extern void secure_computing_strict(int this_syscall);
> >  #endif
> >
> >  extern long prctl_get_seccomp(void);
> > -extern long prctl_set_seccomp(unsigned long, char __user *);
> > +extern long prctl_set_seccomp(unsigned long, void __user *);
> >
> >  static inline int seccomp_mode(struct seccomp *s)
> >  {
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 96afc32e041d..393e029f778a 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -924,7 +924,7 @@ static long seccomp_get_action_avail(const char __user *uaction)
> >
> >  /* Common entry point for both prctl and syscall. */
> >  static long do_seccomp(unsigned int op, unsigned int flags,
> > -                    const char __user *uargs)
> > +                    void __user *uargs)
> >  {
> >       switch (op) {
> >       case SECCOMP_SET_MODE_STRICT:
> > @@ -944,7 +944,7 @@ static long do_seccomp(unsigned int op, unsigned int flags,
> >  }
> >
> >  SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
> > -                      const char __user *, uargs)
> > +                      void __user *, uargs)
> >  {
> >       return do_seccomp(op, flags, uargs);
> >  }
> > @@ -956,10 +956,10 @@ SYSCALL_DEFINE3(seccomp, unsigned int, op, unsigned int, flags,
> >   *
> >   * Returns 0 on success or -EINVAL on failure.
> >   */
> > -long prctl_set_seccomp(unsigned long seccomp_mode, char __user *filter)
> > +long prctl_set_seccomp(unsigned long seccomp_mode, void __user *filter)
> >  {
> >       unsigned int op;
> > -     char __user *uargs;
> > +     void __user *uargs;
> >
> >       switch (seccomp_mode) {
> >       case SECCOMP_MODE_STRICT:
> > --
> > 2.19.1



-- 
paul moore
www.paul-moore.com
