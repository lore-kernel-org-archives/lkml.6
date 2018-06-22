Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3368C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8368524477
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="kDiGKLU5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8368524477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933830AbeFVPPW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:15:22 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36686 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933809AbeFVPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:15:19 -0400
Received: by mail-pg0-f65.google.com with SMTP id m5-v6so3110205pgd.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 08:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SrQxFtdLEf8pWIdaIK6c1iHMrCf7cvOqMqV8Y7ACpDk=;
        b=kDiGKLU5tadkEa0ZxN/exJFq8xEtTmRf6FY4WUPqoRt2HP8QWbrnNajtYL306DEsm+
         6+mbBiiR8gcfJ3KLVaIsMT0w0wM3cmNEHlOz7bHJhZ/dpdUST3csmeoSnvz+GoS81BfR
         4EVA2illQAu4PtOKYoiVhKFGeqHjg2age/ibMjIXFKJJk22EJM/OZDgSq1yyZ/YHEM2w
         uhskpj7YqOuwej29AvtDFJkv7mXMuRAt0fXlgejKKNLDTjfCq3aYLH7Fk8GTSY/JgaqS
         kBefyQixji8uW8J+PKi8J2VQd/XKQ04xKUlsUyKnR1T+mqzhrPlnWkflWCjK1pusRTVF
         wKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SrQxFtdLEf8pWIdaIK6c1iHMrCf7cvOqMqV8Y7ACpDk=;
        b=MygK7jnqxenqcPxUTMNZ/dK8thYVlr4btqj0L+Q5Xy96M8klDiIir32kxeV/aR6F8f
         j6i0FAN9n81WVj2HJLzS35QuviRbqI9nF7OrZXsmo5QB5xDOofj6pGL+5yUwA+bsqsWP
         14fNVWATRpTD+YBG8Z2o9Iu6wNswPlkFTxDUQ3bZV3zCnnTQMpmHdmXuox4IGQnIGeUz
         5ybe04dYJbU0dxbGWgLJMnV0JN9OsINAty4tLemDXn/yu9uRmMdaNeYF19oFWJBN9tql
         wOu6QCD1L8ULmpP/vZUILZdcqE6aziTCPvAZWKzKpUp7uU7Ds1I7P8eiens3CBHeAc8i
         9PSA==
X-Gm-Message-State: APt69E3diMywJAQY6EYg8cxl9f8ilt2qA1RDwgnxcJYHb7N+LkW7DoFW
        JMdu2BtBLa9/fSmuKj6k7TSDCA==
X-Google-Smtp-Source: ADUXVKJHFaXCUQGzlkhHAWs7XdrzpiZuhg9HprSehFq6X5edYYfi2BW4k4B0eckwuHQ8/kbsnchJqQ==
X-Received: by 2002:a63:bf0b:: with SMTP id v11-v6mr1740120pgf.29.1529680518908;
        Fri, 22 Jun 2018 08:15:18 -0700 (PDT)
Received: from cisco ([128.107.241.181])
        by smtp.gmail.com with ESMTPSA id t10-v6sm12478693pgn.20.2018.06.22.08.15.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 08:15:17 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:15:14 -0600
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
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
Message-ID: <20180622151514.GM3992@cisco>
References: <20180621220416.5412-1-tycho@tycho.ws>
 <20180621220416.5412-2-tycho@tycho.ws>
 <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Fri, Jun 22, 2018 at 04:40:20PM +0200, Jann Horn wrote:
> On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
> > This patch introduces a means for syscalls matched in seccomp to notify
> > some other task that a particular filter has been triggered.
> >
> > The motivation for this is primarily for use with containers. For example,
> > if a container does an init_module(), we obviously don't want to load this
> > untrusted code, which may be compiled for the wrong version of the kernel
> > anyway. Instead, we could parse the module image, figure out which module
> > the container is trying to load and load it on the host.
> >
> > As another example, containers cannot mknod(), since this checks
> > capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
> > /dev/zero should be ok for containers to mknod, but we'd like to avoid hard
> > coding some whitelist in the kernel. Another example is mount(), which has
> > many security restrictions for good reason, but configuration or runtime
> > knowledge could potentially be used to relax these restrictions.
> >
> > This patch adds functionality that is already possible via at least two
> > other means that I know about, both of which involve ptrace(): first, one
> > could ptrace attach, and then iterate through syscalls via PTRACE_SYSCALL.
> > Unfortunately this is slow, so a faster version would be to install a
> > filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOMP.
> > Since ptrace allows only one tracer, if the container runtime is that
> > tracer, users inside the container (or outside) trying to debug it will not
> > be able to use ptrace, which is annoying. It also means that older
> > distributions based on Upstart cannot boot inside containers using ptrace,
> > since upstart itself uses ptrace to start services.
> >
> > The actual implementation of this is fairly small, although getting the
> > synchronization right was/is slightly complex.
> >
> > Finally, it's worth noting that the classic seccomp TOCTOU of reading
> > memory data from the task still applies here, but can be avoided with
> > careful design of the userspace handler: if the userspace handler reads all
> > of the task memory that is necessary before applying its security policy,
> > the tracee's subsequent memory edits will not be read by the tracer.
> 
> I've been thinking about how one would actually write userspace code
> that uses this API, and whether PID reuse is an issue here. As far as
> I can tell, the following situation can happen:
> 
>  - seccomped process tries to perform a syscall that gets trapped
>  - notification is sent to the supervisor
>  - supervisor reads the notification
>  - seccomped process gets SIGKILLed
>  - new process appears with the PID that the seccomped process had
>  - supervisor tries to access memory of the seccomped process via
> process_vm_{read,write}v or /proc/$pid/mem
>  - supervisor unintentionally accesses memory of the new process instead
> 
> This could have particularly nasty consequences if the supervisor has
> to write to memory of the seccomped process for some reason.
> It might make sense to explicitly document how the API has to be used
> to avoid such a scenario from occuring. AFAICS,
> process_vm_{read,write}v are fundamentally unsafe for this;
> /proc/$pid/mem might be safe if you do the following dance in the
> supervisor to validate that you have a reference to the right struct
> mm before starting to actually access memory:
> 
>  - supervisor reads a syscall notification for the seccomped process with PID $A
>  - supervisor opens /proc/$A/mem [taking a reference on the mm of the
> process that currently has PID $A]
>  - supervisor reads all pending events from the notification FD; if
> one of them says that PID $A was signalled, send back -ERESTARTSYS (or
> -ERESTARTNOINTR?) and bail out
>  - [at this point, the open FD to /proc/$A/mem is known to actually
> refer to the mm struct of the seccomped process]
>  - read and write on the open FD to /proc/$A/mem as necessary
>  - send back the syscall result

Yes, this is a nasty problem :(. We have the id in the
request/response structs to avoid this race, so perhaps we can re-use
that? So it would look like:

- supervisor gets syscall notification for $A
- supervisor opens /proc/$A/mem or /proc/$A/map_files/... or a dir fd
  to the container's root or whatever
- supervisor calls seccomp(SECCOMP_NOTIFICATION_IS_VALID, req->id, listener_fd)
- supervisor knows that the fds it has open are safe

That way it doesn't have to flush the whole queue? Of course this
makes things a lot slower, but it does enable safety for more than
just memory accesses, and also isn't required for things which
wouldn't read memory.

> It might be nice if the kernel was able to directly give the
> supervisor an FD to /proc/$A/mem that is guaranteed to point to the
> right struct mm, but trying to implement that would probably make this
> patch set significantly larger?

I'll take a look and see how big it is, it doesn't *seem* like it
should be that hard. Famous last words :)

Tycho
