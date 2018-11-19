Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D53BBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F6A20823
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 23:07:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="I1PMPoHC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91F6A20823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeKTJdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 04:33:12 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40965 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731651AbeKTJdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 04:33:12 -0500
Received: by mail-pl1-f193.google.com with SMTP id u6so4402617plm.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 15:07:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dI+p9Pbih8erbmRN0W/Me9mMEc3sgCVErGWyJMQz/GI=;
        b=I1PMPoHCz9RDkB17uLAFIhVk5mQyQfLkWOuNETjczWlBP50R9JZyv1X4O3Hd8LrrwL
         gAqZpCkcF0BWu2nVFGt8FSJ5L3xdb8FX4/zTaK332Cchr8rGzzdNaQt2f35K2zCk0bDs
         lZNYfdCY7Z+/Pr1vHNM4Z5LMLduiVdjxRrqDnBeEF/Qe1MIWwAMutbXSeRVq1kENNAui
         oA+kz+j+BZql+Zj608dRI5VYojnP81lz4CMtY297pqKii7zgmzAdekToxr+2XQbsXrW5
         X1E+iJNQDrREyneZt4PUW7f4iugciYB1aKMonXX3P0jobSj1WdJh2oXjc4XNUac0xAt/
         GA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dI+p9Pbih8erbmRN0W/Me9mMEc3sgCVErGWyJMQz/GI=;
        b=QdhJejcQdWIv0XlSVLCf/EHlh5lWwI+A3thqOSay9MT0P24eOA84Wj37SX7AhBDMXG
         C8hiSmy4EIBe8ZzIIMmaNvVGovWqWwYTUlXnmwfRB71I4Gt2XbQ5MHtu1kZf1oEcHFO9
         6DhWkotBz56AYNjHrvl2O8yMjxSYWMuw2YLSurGELTq5r9ON7G31clp0sgDil0M/TJwp
         dW5fpqtOka2SK4YRYWMnb2Xc/1eRt4d8hNYiJiqy/FNEWoc1DJLKZzwpERFTyKpUtIxz
         E4Axj/zJuSxYlqF5dYofC4PRID8Ft/OC6XCPNo/NbB989h8YdmPHKdJhbIazNQAin4Le
         EUsw==
X-Gm-Message-State: AGRZ1gI/7t/bqglb7QWi2o1fy1jlhuoKmiSDO4K3+QEyrvCmeRjmDBzZ
        i7Hly27aZrEG3WlrigfPEOMkOA==
X-Google-Smtp-Source: AJdET5cqconDm3CW9fHYWHvqTZdCRn4GqBnZ0zXltAG7XNY1s6jpUHHZ55PJULsNft2N40OLez23qw==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36-v6mr24344521plg.243.1542668832764;
        Mon, 19 Nov 2018 15:07:12 -0800 (PST)
Received: from cisco ([128.107.241.178])
        by smtp.gmail.com with ESMTPSA id 128-v6sm45967218pfd.64.2018.11.19.15.07.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 15:07:11 -0800 (PST)
Date:   Mon, 19 Nov 2018 16:07:09 -0700
From:   Tycho Andersen <tycho@tycho.ws>
To:     Daniel Colascione <dancol@google.com>
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
Subject: Re: [PATCH v1 2/2] signal: add procfd_signal() syscall
Message-ID: <20181119230709.GB4992@cisco>
References: <20181119103241.5229-1-christian@brauner.io>
 <20181119103241.5229-3-christian@brauner.io>
 <20181119223954.GA4992@cisco>
 <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKOZuetQDziWeRLydHbDNv1abGM3LyF=WohLFvbzmtdT_+nBdg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 02:49:22PM -0800, Daniel Colascione wrote:
> On Mon, Nov 19, 2018 at 2:40 PM Tycho Andersen <tycho@tycho.ws> wrote:
> > Can I just register an objection here that I think using a syscall
> > just for this is silly?
> 
> Yes, you can argue that the bikeshed should be ioctl-colored and not
> syscall-colored.
> 
> > My understanding is that the concern is that some code might do:
> >
> > unknown_fd = recv_fd();
> > ioctl(unknown_fd, SOME_IOCTL, NULL); // where SOME_IOCTL == PROC_FD_KILL
> > // whoops, unknown_fd was a procfd and we killed a task!
> >
> > In my experience when writing fd sending/receiving code, the sender and
> > receiver are fairly tightly coupled. Has anyone ever actually fixed a
> > bug where they had an fd that they lost track of what "type" it was
> > and screwed up like this? It seems completely theoretical to me.
> 
> Yes, I have fixed bugs of this form.
> 
> > The ioctl() approach has the benefit of being extensible.
> 
> The system call table is also extensible.

But not infinitely so. The x32 ABI starts at 512, and right now I see
334 syscalls on x86_64. So the next 178 people can say "let's just
define a syscall", and after that? I suppose we could move to setting
BIT(10), but how much userspace assumes > 512 => compat syscall and
blocks it via seccomp or whatever?

Contrast that with the ioctl space, which is an unsigned long and
fairly sparse still (Documentation/ioctl/ioctl-number.txt).

> ioctl is for when a given piece of functionality *can't*
> realistically get its own system call because it's separated from
> the main kernel somehow. procfs is a core part of the kernel, so we
> can and should expose interfaces to it using system calls.

I suppose it's obvious, but I disagree.

> > Adding a
> > syscall means that everyone has to do all the boilerplate for each new
> > pid op in the kernel, arches, libc, strace, etc.
> 
> These tools also care about ioctls. Adding a system call is a pain,
> but the solution is to make adding system calls less of a pain, not to
> permanently make the Linux ABI worse.

For user-defined values of "worse" :)

Tycho
