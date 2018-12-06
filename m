Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248ADC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:08:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B822082B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 03:08:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="ZZGQgm8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3B822082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brauner.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbeLFDIY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 22:08:24 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37585 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbeLFDIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 22:08:24 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so11038535pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 19:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UNmiUg8TwkIu7qQDHY1VTZMIXKgOh9FoBzaLTNL7yKI=;
        b=ZZGQgm8iFN0FJfVgBOtSj0tiPmwLa8CyENqhLhFJ8GCdNFrdxn/TvFVBryC9VX2EhB
         YE8WlUZpKvRtn4N3B1nYG3dLdORU1WKBe65mrwuqVAO4Wnb8o8lSk39N0Fih7L3sNP1N
         +vPFvF1jA6wL3m3KisLpLCgk2K0jvPN8p3n3c5qP757SAtSEPK4vzoWyqAthHIBxbrwR
         qTyxeXWVU0HB34GTFyfDh7fS0TjkQzOWHnpDt2Q3kD/I1NW8RDWhsyel+LZMmsc+80g4
         d8bkSoEd1WymarSJIJzwarYBRKM/jZJ2Rb6ILgSj0dM7ut97XvECoMYw9Q1or5M6LZuv
         g11A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UNmiUg8TwkIu7qQDHY1VTZMIXKgOh9FoBzaLTNL7yKI=;
        b=hH9kZUvUu/bwDTxze8oXTv4kaD732sMV5c4RgF3KnYb5O7DcnHLeO3wE7bX1gmoGTy
         VmRxbQ8naRJljYf4vZ4syQPmtJTqJdvYFo4jZYYGaLB0/310V0xVZ2q/0t93x2T7PSR2
         pSf/gHTOcOmdWjsAx6VWFj8N323By5lKiCTpcg7ZFIP0jm4Rnqgsyg8tgxjUyiAhF19Z
         /Xl8hxQzck1zW8IjoCLdx34GrS5Nor32IH83acHc1z+YdMmmT98v0GNCQeTDXPC3FDVM
         /U/6HWGEdoanU5hEZvWm+dbiddDSTzNVBolDY3PwMxRJHDpLJz16WtwFPx/ohUW/StNa
         ul1A==
X-Gm-Message-State: AA+aEWYQycv3UrH5nk88n8qQyz2p3Wd13e1CmIfU88WefQiU/6OEOQUK
        iyrY7/l84ZafN1XbkloM+mWeEQ==
X-Google-Smtp-Source: AFSGD/VkpHrdQrWcm64rC/4q096S+95IFKqjUSh6yCUCIpFjnUIlR4l7+nMEQQIh5wM4y8UBgrKlYA==
X-Received: by 2002:a63:f34b:: with SMTP id t11mr22798680pgj.341.1544065702977;
        Wed, 05 Dec 2018 19:08:22 -0800 (PST)
Received: from brauner.io ([130.195.55.139])
        by smtp.gmail.com with ESMTPSA id l5sm20827176pgp.82.2018.12.05.19.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Dec 2018 19:08:22 -0800 (PST)
Date:   Thu, 6 Dec 2018 04:08:12 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Tim Murray <timmurray@google.com>,
        linux-man <linux-man@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>
Subject: Re: [PATCH v3] signal: add procfd_send_signal() syscall
Message-ID: <20181206030810.jo5julsc4v5zy34z@brauner.io>
References: <20181205092203.14105-1-christian@brauner.io>
 <87zhtjn8ck.fsf@xmission.com>
 <20181205205242.hxgba5opiapinj56@brauner.io>
 <CAGXu5jJgYyhUBgzfkkcHGtu6AcC4MBpfwcEoj3M=Y+8q0FZ_dA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXu5jJgYyhUBgzfkkcHGtu6AcC4MBpfwcEoj3M=Y+8q0FZ_dA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 03:24:08PM -0800, Kees Cook wrote:
> On Wed, Dec 5, 2018 at 12:53 PM Christian Brauner <christian@brauner.io> wrote:
> > On Wed, Dec 05, 2018 at 12:20:43PM -0600, Eric W. Biederman wrote:
> > > Christian Brauner <christian@brauner.io> writes:
> > > > [1]:  https://lkml.org/lkml/2018/11/18/130
> > > > [2]:  https://lore.kernel.org/lkml/874lbtjvtd.fsf@oldenburg2.str.redhat.com/
> > > > [3]:  https://lore.kernel.org/lkml/20181204132604.aspfupwjgjx6fhva@brauner.io/
> > > > [4]:  https://lore.kernel.org/lkml/20181203180224.fkvw4kajtbvru2ku@brauner.io/
> > > > [5]:  https://lore.kernel.org/lkml/20181121213946.GA10795@mail.hallyn.com/
> > > > [6]:  https://lore.kernel.org/lkml/20181120103111.etlqp7zop34v6nv4@brauner.io/
> > > > [7]:  https://lore.kernel.org/lkml/36323361-90BD-41AF-AB5B-EE0D7BA02C21@amacapital.net/
> > > > [8]:  https://lore.kernel.org/lkml/87tvjxp8pc.fsf@xmission.com/
> > > > [9]:  https://asciinema.org/a/X1J8eGhe3vCfBE2b9TXtTaSJ7
> > > > [10]: https://lore.kernel.org/lkml/20181203180224.fkvw4kajtbvru2ku@brauner.io/
> > > > [11]: https://lore.kernel.org/lkml/F53D6D38-3521-4C20-9034-5AF447DF62FF@amacapital.net/
> 
> I nominate this for 2018's most-well-documented syscall commit log award. ;)

Hahaha. If I win can I get my price in beer(s)? :)

> 
> > > > +   /*
> > > > +    * Give userspace a way to detect whether /proc/<pid>/task/<tid> fds
> > > > +    * are supported.
> > > > +    */
> > > > +   ret = -EOPNOTSUPP;
> > > > +   if (proc_is_tid_procfd(f.file))
> > > > +           goto err;
> > >
> > >       -EBADF is the proper error code.
> >
> > This is done so that userspace has a way of figuring out that tid fds
> > are not yet supported. This has been discussed with Florian (see commit
> > message).
> 
> Right, we should keep this -EOPNOTSUPP.
> 
> > > > +   /* Is this a procfd? */
> > > > +   ret = -EINVAL;
> > > > +   if (!proc_is_tgid_procfd(f.file))
> > > > +           goto err;
> > >
> > >       -EBADF is the proper error code.
> 
> Yeah, EINVAL tends to be used for bad flags... this is more about an
> improper fd.
> 
> > >
> > > > +   /* Without CONFIG_PROC_FS proc_pid() returns NULL. */
> > > > +   pid = proc_pid(file_inode(f.file));
> > > > +   if (!pid)
> > > > +           goto err;
> > >
> > > Perhaps you want to fold the proc_pid into the proc_is_tgid_procfd
> > > call.  That way proc_pid can stay private to proc.
> >
> > Hm, I guess we can do that for now. My intention was to have reuseable
> > helpers but I guess it would be fine for now.
> >
> > >
> > > > +   if (!may_signal_procfd(pid))
> > > > +           goto err;
> > > > +
> 
> Does the ns parent checking in may_signal_procfd need any locking or
> RCU? I know pid and current namespaces are "pinned", but I don't know
> how parent ns works here. I'm assuming the parents are stuck until all
> children go away?

Yeah, since they are hierarchical killing an ancestor means killing the
children. Also, in case you're interested, there's precedent for that:
kernel/pid_namespace.c:static struct ns_common *pidns_get_parent(struct ns_common *ns)
I'm not using this function because a) I would have to special case the
initial test-case and b) it takes a get() on the pid ns which would
force us to use another put which is unnecessary.

> 
> > > > +   ret = kill_pid_info(sig, &kinfo, pid);
> 
> Just double-checking for myself: this does not bypass
> security_task_kill(), so no problem there AFAIK.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks! :)
As a sidenote I'm switching the name from procfd_send_signal() to
taskfd_send_signal(). It seems to me the best way to handle Eric's
request to reflect that we can eventually both signal tgids and tids.

> 
> -- 
> Kees Cook
