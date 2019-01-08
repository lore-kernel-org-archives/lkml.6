Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B67C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF35A2070B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 18:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="qP1PP0At"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbfAHSZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 13:25:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42526 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729168AbfAHSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 13:25:58 -0500
Received: by mail-io1-f66.google.com with SMTP id x6so3911059ioa.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LqbJEgnwFSMh8OaA05elhekOIYxmD23wvX6gAD5hh6w=;
        b=qP1PP0At6zzd1KJCClXAkHIWW/UjBNYEESq8CRc+uOwNgvn0H1kOddguao9clkLMgm
         D0+/qOpNsK/kPa5/eM14w+5lc0PP8ibtzy4jRd4VvHuL4xICYGSr93+oEHAHZMhLiR+s
         yiCtfW3YGHVQsHVWrN21qFejoJ9R/M6ihcU/9KTV2Fx9u0iwPk0J6Jci/9Ow10LmGciQ
         b0woMutiq0tLmm0R/AUpKbFPocnFPl94nBKHKgO86ncue8abOHLFO4/IoXLaSfmK97k4
         teHNDnclHx9LClT252IN/6Zdb3skZ2WyBSJ6K+wLympxKScPE82m2cnToT7hTTToZ6yP
         P5mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LqbJEgnwFSMh8OaA05elhekOIYxmD23wvX6gAD5hh6w=;
        b=TllgoZW2iEU4hDNeHdhGlQKm1qXH1sZPeNN6hAjSpnryQlr394HcoxbBVA6M035cO8
         i3RpGw/M8ka7gG8skRHJ53Jz+5IWd0/FBLZeAKwVd1dDtqB8wI08CSWjadm1OM8Di0Sl
         7ExS/V10ilyj8JDnMYDdZEabd6/rYfZtU/0Z+b/fljWQgJZCvkCJIZ+GDaO+s47EafwH
         GxtXsKPcLwzklNgUN9YKu+HSLcUuLlAvguvEVzCY3IAdUPKGp6vTcPLxin8E5Mm+j/7Q
         BvChBTANkUmnxmjCcy7QffKWegVi29oTuPUD9CddRaXcfWTEHgiwdyapwvSg0pssWl61
         Hjpw==
X-Gm-Message-State: AJcUuke5NwQVFM6gwIBo+4+lU1eL9qAseCdjCrc56qJvV92iCbgkjcco
        ECPgAgjDjmQw7RB2+j2tZKlZoQ==
X-Google-Smtp-Source: ALg8bN5mR7KavNRP3GjMw1QHz/2tvcai4AMuymnLK2hOB2LNct+V0rlSbaZA7lUm4oidLMT+F7gg7Q==
X-Received: by 2002:a6b:d618:: with SMTP id w24mr1937306ioa.24.1546971957333;
        Tue, 08 Jan 2019 10:25:57 -0800 (PST)
Received: from cisco ([2601:282:901:dd7b:c092:9114:ac14:211f])
        by smtp.gmail.com with ESMTPSA id p19sm7291135itp.13.2019.01.08.10.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Jan 2019 10:25:56 -0800 (PST)
Date:   Tue, 8 Jan 2019 11:25:54 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Christian Brauner <christian@brauner.io>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, luto@kernel.org, arnd@arndb.de,
        keescook@chromium.org, akpm@linux-foundation.org, jannh@google.com,
        oleg@redhat.com, cyphar@cyphar.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, dancol@google.com,
        timmurray@google.com, fweimer@redhat.com, tglx@linutronix.de,
        x86@kernel.org, ebiederm@xmission.com
Subject: Re: [PATCH v7 2/2] selftests: add tests for pidfd_send_signal()
Message-ID: <20190108182554.GB28330@cisco>
References: <20190102161654.9093-1-christian@brauner.io>
 <20190102161654.9093-2-christian@brauner.io>
 <20190108175306.GF29009@cisco>
 <20190108175415.GA22353@mail.hallyn.com>
 <20190108175843.GA26016@cisco>
 <20190108181742.GA22614@mail.hallyn.com>
 <20190108182023.GA28330@cisco>
 <20190108182444.e6kq2gqftde23jou@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190108182444.e6kq2gqftde23jou@brauner.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 07:24:46PM +0100, Christian Brauner wrote:
> On Tue, Jan 08, 2019 at 11:20:23AM -0700, Tycho Andersen wrote:
> > On Tue, Jan 08, 2019 at 12:17:42PM -0600, Serge E. Hallyn wrote:
> > > On Tue, Jan 08, 2019 at 10:58:43AM -0700, Tycho Andersen wrote:
> > > > On Tue, Jan 08, 2019 at 11:54:15AM -0600, Serge E. Hallyn wrote:
> > > > > On Tue, Jan 08, 2019 at 10:53:06AM -0700, Tycho Andersen wrote:
> > > > > > On Wed, Jan 02, 2019 at 05:16:54PM +0100, Christian Brauner wrote:
> > > > > > > +			/*
> > > > > > > +			 * Stop the child so we can inspect whether we have
> > > > > > > +			 * recycled pid PID_RECYCLE.
> > > > > > > +			 */
> > > > > > > +			close(pipe_fds[0]);
> > > > > > > +			ret = kill(recycled_pid, SIGSTOP);
> > > > > > > +			close(pipe_fds[1]);
> > > > > > > +			if (ret) {
> > > > > > > +				(void)wait_for_pid(recycled_pid);
> > > > > > > +				_exit(PIDFD_ERROR);
> > > > > > > +			}
> > > > > > 
> > > > > > Sorry for being late to the party, but I wonder if this whole thing
> > > > > > couldn't be simplified with /proc/sys/kenrel/ns_last_pid?
> > > > > 
> > > > > no, bc it's not namespaced :)
> > > > 
> > > > Huh? It looks like it is...
> > > > 
> > > > static int pid_ns_ctl_handler(struct ctl_table *table, int write,
> > > >                 void __user *buffer, size_t *lenp, loff_t *ppos)
> > > > {
> > > >         struct pid_namespace *pid_ns = task_active_pid_ns(current);
> > > >         struct ctl_table tmp = *table;
> > > >         int ret, next;
> > > > 
> > > >         if (write && !ns_capable(pid_ns->user_ns, CAP_SYS_ADMIN))
> > > >                 return -EPERM;
> > > > 
> > > >         ...
> > > 
> > > Oh - hah, but that's ns_last_pid.  You'd want pid_max.  And that one
> > > is not namespaced.
> > 
> > Perhaps I'm misunderstanding, but isn't the point of all this code to
> > get the same pid again? So can't we just fork(), kill(), then set
> > ns_last_pid to pid-1, and fork() again to re-use?
> 
> Maybe. It's just a selftest that works reliably as it is so unless
> there's a technical issue with the patch I'm not going to do another
> version just because of that unless people feel super strongly about
> this.
> Another advantage is that the code we have right now works even when
> CONFIG_CHECKPOINT_RESTORE is not selected.

No, it's fine as is. Just a lot less code if we do it the other way.

Cheers,

Tycho
