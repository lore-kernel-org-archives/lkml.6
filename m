Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7731C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA06206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="SbTXfvp3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbfAHSYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:24:51 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40350 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfAHSYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:24:50 -0500
Received: by mail-ed1-f66.google.com with SMTP id g22so5153333edr.7
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NSHDeMu8V/RkKQRrewbiRW7AjiPGZuYZn1RgP9ePDo=;
        b=SbTXfvp3Qaa4ccNpHJ8ADAJA4Q+j7t2leDuNGO/nnzgIU3VNLlbP5hKa9Sagufuer3
         h0aH6EYRdqspwKhO6KuzpYFloN6m8rwH3kJ/6ZbhRps9H2D8bjHbvKYJkt2bLDUzg3hL
         l9sBcVP8XQ46Wlx90msp5vx+iIM/r6XB/KDhYVbz6AL/or3ExyC3FdMEOFBq1L77AUnv
         u9RSSGxVCgi1yY5OrY6iL1CdYOFLgM9SFy3DK9eij8J/LfdGx7jAhirDu0I8YAkNKWk1
         GH03vuDTaEwE8+XFDFcOMqQnTIZSIrNhqmf6RdLI2ciVKwVAO717Rq4ywkvPy3ADDWs4
         3NnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NSHDeMu8V/RkKQRrewbiRW7AjiPGZuYZn1RgP9ePDo=;
        b=YN3oM8jHFZuYAG0fkeUlNjZjMGZEloqe+5ZrDZu9fl4/iM89AH2aF2s9wLq8X4uneq
         US2WK8QpdQP108sNcSu+OcHoe8pIRrxp89gFBEQLaWtDWzg5Wmfyu0GeuHFX/qCnJeKj
         cJDRd+kd0LjXmiBvMFzzUoLkOXn83Wm6TILjy8Hg+bGGgSyel16J36QirBjLk2BQ6JwT
         mV+Nsg5uMo//hDxb+PQOcGkOO0GljP63HpuUg+pIVuKrT5bcBUPrQDLBlkZKpl+Q2Rdm
         KWlkRWZbTokiOKzuAeknwRdp4fYUQ9+4ryvorGWWGCJrS/UVkddHMjElc3LFl9P/TIn2
         Ldzw==
X-Gm-Message-State: AJcUukcPXaWH3BNHstity/T0jABxjjCAojDm5GHfK5w7VQgw/Aqf3zRa
        XssXEomgesQ9IYcjt4yQ6UcUdQ==
X-Google-Smtp-Source: ALg8bN5GJyKqKB8ug6X1g/nCmB8HQv4wsGWsM7TpJRtdKsuXK3waBC7PfgSl+nlVlUfutEV5m7vlcQ==
X-Received: by 2002:a17:906:2313:: with SMTP id l19-v6mr2860297eja.204.1546971887812;
        Tue, 08 Jan 2019 10:24:47 -0800 (PST)
Received: from brauner.io ([2a02:8109:b6c0:d6c:9810:663f:f898:8929])
        by smtp.gmail.com with ESMTPSA id p7-v6sm261066ejx.27.2019.01.08.10.24.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:24:47 -0800 (PST)
Date:   Tue, 8 Jan 2019 19:24:46 +0100
From:   Christian Brauner <christian@brauner.io>
To:     Tycho Andersen <tycho@tycho.ws>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, luto@kernel.org, arnd@arndb.de,
        keescook@chromium.org, akpm@linux-foundation.org, jannh@google.com,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v7 2/2] selftests: add tests for pidfd_send_signal()
Message-ID: <20190108182444.e6kq2gqftde23jou@brauner.io>
References: <20190102161654.9093-1-christian@brauner.io>
 <20190102161654.9093-2-christian@brauner.io>
 <20190108175306.GF29009@cisco>
 <20190108175415.GA22353@mail.hallyn.com>
 <20190108175843.GA26016@cisco>
 <20190108181742.GA22614@mail.hallyn.com>
 <20190108182023.GA28330@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190108182023.GA28330@cisco>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 11:20:23AM -0700, Tycho Andersen wrote:
> On Tue, Jan 08, 2019 at 12:17:42PM -0600, Serge E. Hallyn wrote:
> > On Tue, Jan 08, 2019 at 10:58:43AM -0700, Tycho Andersen wrote:
> > > On Tue, Jan 08, 2019 at 11:54:15AM -0600, Serge E. Hallyn wrote:
> > > > On Tue, Jan 08, 2019 at 10:53:06AM -0700, Tycho Andersen wrote:
> > > > > On Wed, Jan 02, 2019 at 05:16:54PM +0100, Christian Brauner wrote:
> > > > > > +			/*
> > > > > > +			 * Stop the child so we can inspect whether we have
> > > > > > +			 * recycled pid PID_RECYCLE.
> > > > > > +			 */
> > > > > > +			close(pipe_fds[0]);
> > > > > > +			ret = kill(recycled_pid, SIGSTOP);
> > > > > > +			close(pipe_fds[1]);
> > > > > > +			if (ret) {
> > > > > > +				(void)wait_for_pid(recycled_pid);
> > > > > > +				_exit(PIDFD_ERROR);
> > > > > > +			}
> > > > > 
> > > > > Sorry for being late to the party, but I wonder if this whole thing
> > > > > couldn't be simplified with /proc/sys/kenrel/ns_last_pid?
> > > > 
> > > > no, bc it's not namespaced :)
> > > 
> > > Huh? It looks like it is...
> > > 
> > > static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> > >                 void __user *buffer, size_t *lenp, loff_t *ppos)
> > > {
> > >         struct pid_namespace *pid_ns = task_active_pid_ns(current);
> > >         struct ctl_table tmp = *table;
> > >         int ret, next;
> > > 
> > >         if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> > >                 return -EPERM;
> > > 
> > >         ...
> > 
> > Oh - hah, but that's ns_last_pid.  You'd want pid_max.  And that one
> > is not namespaced.
> 
> Perhaps I'm misunderstanding, but isn't the point of all this code to
> get the same pid again? So can't we just fork(), kill(), then set
> ns_last_pid to pid-1, and fork() again to re-use?

Maybe. It's just a selftest that works reliably as it is so unless
there's a technical issue with the patch I'm not going to do another
version just because of that unless people feel super strongly about
this.
Another advantage is that the code we have right now works even when
CONFIG_CHECKPOINT_RESTORE is not selected.
