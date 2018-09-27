Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A459C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2612216FE
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:04:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="z6BUNv5/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2612216FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728278AbeI1AXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 20:23:47 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46072 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727612AbeI1AXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 20:23:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id a23-v6so2427765pfi.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PVeVP6wrlR/Kkx+zEt2gMYHwcYZRXu1qGypYVgaZHnE=;
        b=z6BUNv5//GXBiVsZbbiGiU9oUlaneXWUku1rbe0LuupaZwaTIhXL7dZu7bxA/vvEzm
         cc7Zw/oirGZjQltOqoTleNt2NdZ38UmaX6KUqYbD6jwTCbQlY+DMITgzCRue+Jdfi0cX
         ++xTcxORF1XwqWwSQJt7EMEeGaISpIlygpbfl9edQQ7TnaAD+fPycx29k0NDMScj0Eau
         Wj8nQguhPF/BVK/EWjTJVVied2SCijcGrMvLPy4KCt80yd8p1SRK7itdu+FAS329GXO2
         /YM923Dq6EvwT9WfDrJG83dZL2YkE8COuf7sbk6cO3gBzs4Cmhnu6G0NozJiUhxb3Aee
         HjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PVeVP6wrlR/Kkx+zEt2gMYHwcYZRXu1qGypYVgaZHnE=;
        b=BoeZslOrSm5IXxzzqn+azm5bOM09yMRrwU1rg28WKeuUgFtOK+8hKbtufXKN+c4xlG
         LVKwseX4vzqqhgvKhjUR6VnI32Xr0O8KQH1JTFOKzAe7A00jyJW6WeDeUHpQNcisop2r
         qEeR1hIIcvynen9B6efnJ72zQgkQW4aihmCopg+iORdi55E28BnYgFtOTjvBTLLp6nG1
         etWsm43IDVyXUxMjRYVGLq5wvj/X+m9On6sAH2xidiRdLAKtKtJSt1WBmCSLo9nml2jf
         1I8xMMK20B2jOXZCVXlSzA4kL5b+vuHxB8DyFviGtkiHWAOH13H/NftL5K22akAetrbQ
         XRwg==
X-Gm-Message-State: ABuFfogs9l8ZlbHHyP2Yf1KP0qDAMMynGWssuhI5zn+jQuDsMsI7Bawy
        hQVlbeFJvJMOamm5MHL/RpCdPA==
X-Google-Smtp-Source: ACcGV61/TfYHXo/Zwgtz0DXhqbIIXaYSXlmx3zgHcqCGmHSwAloCok/QDSPB3nBZSMCk0YeXcPPzWQ==
X-Received: by 2002:a63:ac11:: with SMTP id v17-v6mr11379710pge.196.1538071459590;
        Thu, 27 Sep 2018 11:04:19 -0700 (PDT)
Received: from cisco.cisco.com ([128.107.241.165])
        by smtp.gmail.com with ESMTPSA id b76-v6sm6171562pfj.16.2018.09.27.11.04.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:04:18 -0700 (PDT)
Date:   Thu, 27 Sep 2018 12:04:15 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Jann Horn <jannh@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, linux-fsdevel@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v7 4/6] files: add a replace_fd_files() function
Message-ID: <20180927180415.GA15491@cisco.cisco.com>
References: <20180927151119.9989-1-tycho@tycho.ws>
 <20180927151119.9989-5-tycho@tycho.ws>
 <CAG48ez1eU_j_Ti0nRh05Qv6hv7-7hv5i+8gnJS5e30mTti2Jhg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1eU_j_Ti0nRh05Qv6hv7-7hv5i+8gnJS5e30mTti2Jhg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 06:49:02PM +0200, Jann Horn wrote:
> On Thu, Sep 27, 2018 at 5:11 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > Similar to fd_install/__fd_install, we want to be able to replace an fd of
> > an arbitrary struct files_struct, not just current's. We'll use this in the
> > next patch to implement the seccomp ioctl that allows inserting fds into a
> > stopped process' context.
> [...]
> > diff --git a/fs/file.c b/fs/file.c
> > index 7ffd6e9d103d..3b3c5aadaadb 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -850,24 +850,32 @@ __releases(&files->file_lock)
> >  }
> >
> >  int replace_fd(unsigned fd, struct file *file, unsigned flags)
> > +{
> > +       return replace_fd_task(current, fd, file, flags);
> > +}
> > +
> > +/*
> > + * Same warning as __alloc_fd()/__fd_install() here.
> > + */
> > +int replace_fd_task(struct task_struct *task, unsigned fd,
> > +                   struct file *file, unsigned flags)
> >  {
> >         int err;
> > -       struct files_struct *files = current->files;
> 
> Why did you remove this? You could just do s/current/task/ instead, right?

No reason, probably just flailing around trying to figure out what
exactly I wanted. I'll make the change, thanks.

> >         if (!file)
> > -               return __close_fd(files, fd);
> > +               return __close_fd(task->files, fd);
> >
> > -       if (fd >= rlimit(RLIMIT_NOFILE))
> > +       if (fd >= task_rlimit(task, RLIMIT_NOFILE))
> >                 return -EBADF;
> >
> > -       spin_lock(&files->file_lock);
> > -       err = expand_files(files, fd);
> > +       spin_lock(&task->files->file_lock);
> > +       err = expand_files(task->files, fd);
> >         if (unlikely(err < 0))
> >                 goto out_unlock;
> > -       return do_dup2(files, file, fd, flags);
> > +       return do_dup2(task->files, file, fd, flags);
> >
> >  out_unlock:
> > -       spin_unlock(&files->file_lock);
> > +       spin_unlock(&task->files->file_lock);
> >         return err;
> >  }
> >
> > diff --git a/include/linux/file.h b/include/linux/file.h
> > index 6b2fb032416c..f94277fee038 100644
> > --- a/include/linux/file.h
> > +++ b/include/linux/file.h
> > @@ -11,6 +11,7 @@
> >  #include <linux/posix_types.h>
> >
> >  struct file;
> > +struct task_struct;
> >
> >  extern void fput(struct file *);
> >
> > @@ -79,6 +80,13 @@ static inline void fdput_pos(struct fd f)
> >
> >  extern int f_dupfd(unsigned int from, struct file *file, unsigned flags);
> >  extern int replace_fd(unsigned fd, struct file *file, unsigned flags);
> > +/*
> > + * Warning! This is only safe if you know the owner of the files_struct is
> > + * stopped outside syscall context. It's a very bad idea to use this unless you
> > + * have similar guarantees in your code.
> > + */
> > +extern int replace_fd_task(struct task_struct *task, unsigned fd,
> > +                          struct file *file, unsigned flags);
> 
> I think Linux kernel coding style is normally to have comments on the
> implementations of functions, not in the headers? Maybe replace the
> warning above the implemenation of replace_fd_task() with this
> comment.

Will do.

Cheers,

Tycho
