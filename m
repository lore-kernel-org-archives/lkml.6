Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B601C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A09206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 23:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="N0mahbOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfAKXRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 18:17:09 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35548 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbfAKXRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 18:17:08 -0500
Received: by mail-lf1-f68.google.com with SMTP id e26so11975731lfc.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 15:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WMS4AhmZ1RhHfF22Nc+XLRPa8N0NnW+ncOe3a7YCZPg=;
        b=N0mahbOba9HL50kqBlHVjOKb8gKpb5eHFRMGQu0r01HaUc8GjpOtSd6Viub1YDx1pZ
         y9tqOOZKtBtmJAu4buLkwgBw3guVAK0z3rRIK7/VIKVQ0v0kw1/BuLKXGsLxYblmpQiv
         Li/Asy64QZgwZrNjBq7+XJa60WhTEKKSvFlikH+0KDwzDimoxzu1D2mtKUZuT2AH7liD
         NbNLyx+aKS17WArGNLHCYeIYAXEqHwUmjMKcVXV6xxfQItamt8mLv3Zb7wyENe9e1JMe
         WXCziQMogowBrkXnZRM/xBZ83udRDMKso6KoBCx10HyaOePdmEmSMYXKsvLOivFjvgL8
         YbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WMS4AhmZ1RhHfF22Nc+XLRPa8N0NnW+ncOe3a7YCZPg=;
        b=cdoA1LHnt+yKQ3TZmXEqjJq+iKNmdB8LRhsvVv5NckiciGQnohVhDUZ0Y95ZI3elKN
         by88fHw0GUmMagkMuVudSxkBiVOoc9lJ8ecIzxZGE03xNoKZmiROXTh0aNS4VE5EA8nS
         /6orXVPDhHvncUFhdob4eeYYHudl0pR1TZZvXehs0YEh3Kq1qzB+V5CPEwA3T+0qg0P0
         a6Yx29C99AV2/exXOFLAreb3Qhyb9u/El8bjr/i/2Pn1EzgrtQQeecinzeYrHk5L+c4H
         cJKr8ZSo9+RJspdZ7fqdFiUHyEFD0v3dg9OvXLoXfsWllDvHKo2c96tubcGjqiVTVX5G
         AoGA==
X-Gm-Message-State: AJcUukckbSbWrzKEvSXdejhKwtvvmEB45JYu74Macods5hmAepCV+V4g
        jOeHNR7J7XQKHGT9Ey8wRMXAXJFKa5C4JksbWxhr
X-Google-Smtp-Source: ALg8bN6O56MYFH6YtMg/Bps5K+sVqVQpXkMg9GTmpZmPqpsWr8+H3TgNqeld8QoZTf1c5Ihbt85KE+6fYPf0yvLgGAM=
X-Received: by 2002:a19:40cc:: with SMTP id n195mr9042757lfa.40.1547248624766;
 Fri, 11 Jan 2019 15:17:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <e41cb6760a8183c0955c378fce7b500819f9838f.1533065887.git.rgb@redhat.com>
 <CAHC9VhRPMAUsgs2zXkPEFZPQS6dmAO1-kBX1Y-7tRkD-kwGEjw@mail.gmail.com>
 <20181031211739.6jag6b5qve77qmmu@madcap2.tricolour.ca> <CAHC9VhTnj3Sg9R-XM0U9gqOsNXT+Tn+VVRXJtBTt0A0DPQ0GQg@mail.gmail.com>
 <20190110225847.vumlt2jor57djrdc@madcap2.tricolour.ca> <CAHC9VhSqPBKv5hmSNSsrMYcmQ86phaUWG54JtAH84sSkPrz_Nw@mail.gmail.com>
 <20190111033856.6lhtlls7bvttoxhd@madcap2.tricolour.ca>
In-Reply-To: <20190111033856.6lhtlls7bvttoxhd@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 11 Jan 2019 18:16:53 -0500
Message-ID: <CAHC9VhRMmGxovEkHhbe=qcu-CnORk=Ddss8gRe+sEvko0fbq+Q@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 06/10] audit: add containerid
 support for tty_audit
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     simo@redhat.com, carlos@redhat.com,
        containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-audit@redhat.com, ebiederm@xmission.com, luto@kernel.org,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 10:39 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2019-01-10 20:12, Paul Moore wrote:
> > On Thu, Jan 10, 2019 at 5:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > On 2019-01-03 15:11, Paul Moore wrote:
> > > > On Wed, Oct 31, 2018 at 5:17 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > > On 2018-10-19 19:17, Paul Moore wrote:
> > > > > > On Sun, Aug 5, 2018 at 4:33 AM Richard Guy Briggs
> > > > <rgb@redhat.com> wrote:
> > > > > > > Add audit container identifier auxiliary record to tty logging rule
> > > > > > > event standalone records.
> > > > > > >
> > > > > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > > > > Acked-by: Serge Hallyn <serge@hallyn.com>
> > > > > > > ---
> > > > > > >  drivers/tty/tty_audit.c | 5 ++++-
> > > > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> > > > > > > index 50f567b..3e21477 100644
> > > > > > > --- a/drivers/tty/tty_audit.c
> > > > > > > +++ b/drivers/tty/tty_audit.c
> > > > > > > @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
> > > > > > >         uid_t uid = from_kuid(&amp;init_user_ns, task_uid(tsk));
> > > > > > >         uid_t loginuid = from_kuid(&amp;init_user_ns, audit_get_loginuid(tsk));
> > > > > > >         unsigned int sessionid = audit_get_sessionid(tsk);
> > > > > > > +       struct audit_context *context = audit_alloc_local(GFP_KERNEL);
> > > > > > >
> > > > > > > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
> > > > > > > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
> > > > > > >         if (ab) {
> > > > > > >                 char name[sizeof(tsk->comm)];
> > > > > > >
> > > > > > > @@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
> > > > > > >                 audit_log_n_hex(ab, data, size);
> > > > > > >                 audit_log_end(ab);
> > > > > > >         }
> > > > > > > +       audit_log_contid(context, "tty", audit_get_contid(tsk));
> > > > > > > +       audit_free_context(context);
> > > > > > >  }
> > > > > >
> > > > > > Since I never polished up my task_struct/current fix patch enough to
> > > > > > get it past RFC status during this development window (new job, stolen
> > > > > > laptop, etc.) *and* it looks like you are going to need at least one
> > > > > > more respin of this patchset, go ahead and fix this patch to use
> > > > > > current instead of generating a local context.  I'll deal with the
> > > > > > merge fallout if/when it happens.
> > > > >
> > > > > Sure, I will switch it to current in the call to audit_get_contid().
> > > > >
> > > > > The local context is a distinct issue.  Like USER records, I prefer
> > > > > local due to potential record volume, it is already trackable as far as
> > > > > Steve is concerned, and if it is to be connected with the syscall
> > > > > record, it should be linked to syscall records in a seperate new github
> > > > > issue with its own patch.  It accumulates events until the buffer is
> > > > > flushed to a record, so the timestamp only represents the flush (usually
> > > > > user "CR/enter").
> > > >
> > > > Generally, yes, associating records is a separate issue, but in this
> > > > particular case you are changing this record by making it a "local"
> > > > record, which as we've discussed before, I view as a necessary evil
> > > > and something that must be minimized.  A quick look at the
> > > > tty_audit_log() callers shows tty_audit_tiocsti() which is an ioctl
> > > > handler (and thus current should be valid and correct), and
> > > > tty_audit_buf_push() whose callers all seem have valid and correct
> > > > current values; if you find that not to be the case please let me
> > > > know.
> > >
> > > Unless I'm misunderstanding what "local" means, it already had a local
> > > context by virtue of having a NULL context since it was never previously
> > > connected to syscall events, so changing it to a local context doesn't
> > > change that other than making it possible to associate an auxiliary
> > > audit container identifier record.
> > >
> > > The reasoning I'm also applying here is that the contents of this record
> > > don't all come from this one syscall, but most likely came in from an
> > > entire line of individual keystrokes, so the syscall information is only
> > > from the last one of those syscalls, though that syscall information
> > > other than the timestamp should be the same.
> >
> > Looking at the callers to tty_audit_log(), I think we can all agree
> > that in the tty_audit_tiocsti() case it is correct to associate the
> > tty record with current, as it is the current task which sent the
> > ioctl with the data.  Do you not agree?
>
> I'm fine with that, yes.
>
> > With tty_audit_buf_push() we need to do a bit more work to track down
> > all the callers.  Looking quickly it appears that all of the
> > tty_audit_add_data() callers are copying data to/from userspace, so
> > associating these tty records with their syscall would seem
> > appropriate.  With tty_audit_push() it either appears to be
> > tty_audit_tiocsti() (again) or more userspace copy routines.  I didn't
> > bother looking at tty_audit_exit() because that seemed pretty clear to
> > be something worth associating with a syscall.  You may find that if
> > you dig deeper into the call stacks things fall apart and there are
> > cases where the records shouldn't be associated with the current
> > syscall, but based on what I'm seeing right now that doesn't appear to
> > be the case.
>
> Ok.  Except that it might be multiple subsequent calls that assemble
> that data, only flushed to an audit record on exceeding N_TTY_BUF_SIZE
> (4k) or that task switching device and flushing the previous device or
> that task switching icanon mode.

It seems just as reasonable to associate it with that final triggering
syscall just as much as it seems reasonable to log the buffered tty
data via the audit subsystem.  If for some reason we need to
dissociate the tty data from the syscall data I don't see why we can't
make that change in the future.

> > > Reading your reply above it isn't clear to me that I had made these two
> > > points clear previously.  If you still think this record should be
> > > associated to a syscall despite my reasoning above, I'm willing to
> > > connect it, but will do so in a seperate issue/patch.
>
> So can I conclude that you are fine with the buffering of the data from
> multiple syscalls being associated with the output of that buffer to one
> audit record with the last of those syscalls?

-- 
paul moore
www.paul-moore.com
