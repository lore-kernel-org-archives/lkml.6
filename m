Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BFDC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A57A120859
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 00:24:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="cibXxBE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfAPAYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 19:24:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33768 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbfAPAYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 19:24:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id i26so3541653lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 16:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+fg7QbZbOcdcVHlJSnobJ6ACH2Nq1ev/xVq38eoWVk=;
        b=cibXxBE6L5LG/oXEGunhbabVwd5lHapOCaQi88S8uk/olxqt5nu/X4qn9+jzlvB94H
         rie7MYVMoxbl4yiylufZpCXB0B8atl2yqAijx0cR05MNWdvnsju/ISOSNSqyO5SnHFYb
         i1qO6x5k7GsGaWFu7Z8RL8G0fItJYrK7wkVqROle58Rqvxc5K/Bt7jyF8vqg4YKLFEWq
         GJjbtZtzJJXFE1gqkwldbBX9ns+4yetPuL9XoVPPl8wdxD2Li0vocseRtX5HH1155rZ6
         jN7SiBHEXYHSGWsAcAeIu94wyNEP7U1+St2kffcUzcygtqyhvpyJVj2tJn/MOTY4A7VS
         61UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+fg7QbZbOcdcVHlJSnobJ6ACH2Nq1ev/xVq38eoWVk=;
        b=CLPPI9aXqvwEX6GNSWPYVD+pbFZqBJeWrzP7yq9gq1c0v0nj5n0uNQKe9URuwcOUVn
         cfubyd5aw2DGZ5uK3gmD3m9oMBqcE+bQIBcSL9yQ+QmRmJMiYLawugtvIuj3a3chy7to
         fTZEmQY53eBQ8vdCAZ6jvxAHcV8Phj/RC5v0y61F/NeYME3FWBteN5uXWu56KqYVWTOh
         cGfPTuQ15n90sFlUQRiv4kUu9iQrginTq7z4x+ZLZQhUfWffenMnOSRB98p7iXFvRqkm
         rxnrrSS5ti/zFiuLvIC0yqDd9Az7hsfkwQJk/pBXyau9MaiqR1ldAGl/hezsY262rxvH
         mr2A==
X-Gm-Message-State: AJcUukd6O44WASh/cYmawIPzbP+NA2/IH2Jj/qfApvLu5ZEzZQwi7uwN
        ngPF2H0jEhwQuXnEaz46RjcJE/vLP2zCGtIFvgRV
X-Google-Smtp-Source: ALg8bN63IqFMQ0eeVrqsxnSMy5eV2EPbsXGFwu5JCnoVWjbZ9EKG5foASBzJsGXWYcbfofzm4yxzY63LJis8gQxkUnI=
X-Received: by 2002:a19:f115:: with SMTP id p21mr1381093lfh.20.1547598240121;
 Tue, 15 Jan 2019 16:24:00 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com> <20190115162112.jq6m2j4wmyk4rq25@madcap2.tricolour.ca>
In-Reply-To: <20190115162112.jq6m2j4wmyk4rq25@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 15 Jan 2019 19:23:49 -0500
Message-ID: <CAHC9VhQb5o5bxEqMW6CA36Qp60DkitBpcEskQ74EG0m3cGYYyQ@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:21 AM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2019-01-14 17:58, Paul Moore wrote:
> > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Tie syscall information to all CONFIG_CHANGE calls since they are all a
> > > result of user actions.
> > >
> > > Exclude user records from syscall context:
> > > Since the function audit_log_common_recv_msg() is shared by a number of
> > > AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> > > and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> > > syscall accompanied record type, special-case the AUDIT_USER_* range of
> > > messages so they remain standalone records.
> > >
> > > See: https://github.com/linux-audit/audit-kernel/issues/59
> > > See: https://github.com/linux-audit/audit-kernel/issues/50
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  kernel/audit.c          | 27 +++++++++++++++++++--------
> > >  kernel/audit_fsnotify.c |  2 +-
> > >  kernel/audit_tree.c     |  2 +-
> > >  kernel/audit_watch.c    |  2 +-
> > >  kernel/auditfilter.c    |  2 +-
> > >  5 files changed, 23 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index 0e8026423fbd..a321fea94cc6 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -1072,6 +1073,16 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > >         audit_log_task_context(*ab);
> > >  }
> > >
> > > +static inline void audit_log_user_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > +{
> > > +       audit_log_common_recv_msg(NULL, ab, msg_type);
> > > +}
> >
> > This makes sense because this is used by "user" records ...
> >
> > > +static inline void audit_log_config_change_alt(struct audit_buffer **ab)
> > > +{
> > > +       audit_log_common_recv_msg(audit_context(), ab, AUDIT_CONFIG_CHANGE);
> > > +}
> >
> > ... and I don't believe this makes sense because there is no real
> > logical grouping with the callers like there is for
> > audit_log_user_recv_msg().
>
> I don't follow "logical grouping".  They are all CONFIG_CHANGE record
> prefixes with the current context.

The audit_log_user_recv_msg() callers have a logical grouping because
they are all user generated records which we've decided shouldn't be
associated with any audit records tied to the current task.

The audit_log_config_change_alt() callers seem only to be grouped by
the fact that they are share some common audit_log_config_change_alt()
parameters; they don't appear to have anything else in common.  Yes,
sometimes we do create functions like audit_log_config_change_alt()
for reasons such as these, but I don't believe it is necessary, or
desirable, in this particular patch(set).

My comments on your v2 of this patchset suggested the creation of
audit_log_user_recv_msg() instead of what you did with
__audit_log_common_recv_msg().  You made that suggested change for v3
- good - but with v3 you also introduced audit_log_config_change_alt -
not good.

Get rid of audit_log_config_change_alt() (respin, retest, etc.) and
post this revised single patch (the others in the patchset that are ok
are already in audit/next) and we can get it into audit/next.

> Can you suggest an alternate name or another way of sharing
> audit_log_common_recv_msg() since the only differences between the two
> are a NULL context vs current task's context and the message type.  I
> wasn't particularly happy with this name either.  I'd really like to
> refactor this with all the rest of the CONFIG_CHANGE records, but there
> is too much of a format difference to make it work without reordering or
> deleting useless fields.
>
> I know you had suggested making two different functions, but I think
> they are more similar than different and merit the common factored code.
>
> > paul moore
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635

-- 
paul moore
www.paul-moore.com
