Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FD1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA50E20855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="sy5XkojQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbfAQRhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 12:37:12 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:36871 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbfAQRhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 12:37:11 -0500
Received: by mail-lf1-f68.google.com with SMTP id y11so8456840lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 09:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G/THK+qaZMV6onb+whGUS01TPNUJ8oRJ6JjQya0Gf5I=;
        b=sy5XkojQVNXw6SJDkiL+Km0JZWx0aGku+BZKQSmmcxErd0WafWamZPyB0ExoovwIpS
         sHjtVoqwzGeOx+NhUZUwXsJ5FeKYZ5vivM3kgdcYhPrrI3o9MIbCNKvCvl/8cInOaGXN
         eh1kl+EaQj+upNvmgjc6AQvR91wKWTCc1er+ymfnL/1oRTztnILpRin5cTiZn71oTOgL
         EGaVsx+u+guj9C6s/s137ecHZdx/NHtPKz9fDoHd5ltNoMhPqeiE/rz2a8q0z3dbHVLs
         FeZBnT1TuUag8/mLySo9eoQ2oiVOcmyt6p8LEjoK7N5EzkKBA+pNA5kKAPb7latOTP8j
         nP1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G/THK+qaZMV6onb+whGUS01TPNUJ8oRJ6JjQya0Gf5I=;
        b=LfVejvXjsWdJ/wdlphYikfr9vn4yq1ml2eKIAieKc/lgAq8yFX3Qdyy8DsKquY3v1z
         j1LAR4ya0WJcwoOklM1FmuofxW3n2ucFvVFsqRnI7/wK0pkmMFVPBLhviGP0T9kVMVby
         GKHoUGm1PCU4c7myV+iUisM9BQVAsHgwOPUCnyXHSOLbglB0qgpJy2U/uycDaVZl7gv1
         TmlmtfdDsExQXYp/6piLxON/uDE/iXMAIHKVMA3DtJb92K/ncoFq4eD8bzAMBwbrQXrM
         x4UdKAc0WPWfPrTRC/Q64an7qn6BTB1M0XZ9+9vdvYAJDVB1491Xs3RVKVvkRi8qBVHU
         wLpw==
X-Gm-Message-State: AJcUukfagJRypHUgDnqxFzjn2yp770pHl1cKsnCiMhegNOZ8tQeZbqjd
        ZZEz3U5zZoV1DlqQXZ21YHSxuI6rMSnfAtZtufeh
X-Google-Smtp-Source: ALg8bN7jzs6+Ni9VR60QNYXHqkscXGIV5R2X98Xmzx1BFsg2kDcgoUPbky1NsJoz99qgZMlizQCJZEiaUhgMZJny3iY=
X-Received: by 2002:a19:5402:: with SMTP id i2mr10729689lfb.128.1547746628075;
 Thu, 17 Jan 2019 09:37:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1544477629.git.rgb@redhat.com> <43548fafdfa98ee64ecfd0d7a69a2f5cb2c31c50.1544477629.git.rgb@redhat.com>
 <CAHC9VhSaTvVgSWVWo42Ur2k6hVNJ1XBkLwrd-J4-SUuidwXUYg@mail.gmail.com>
 <20190117103255.1f640a42@ivy-bridge> <CAHC9VhQvk+6AFjVU_ygyn8Q6FGwVy_JqXj7wWSNYYp5zSiBcuw@mail.gmail.com>
 <20190117170815.40131a69@ivy-bridge>
In-Reply-To: <20190117170815.40131a69@ivy-bridge>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 17 Jan 2019 12:36:56 -0500
Message-ID: <CAHC9VhQqT9HW=m5_sbru2Q7HoJC6oSrzMzrkRxgeDB7sWFLA-A@mail.gmail.com>
Subject: Re: [PATCH ghak59 V3 2/4] audit: add syscall information to
 CONFIG_CHANGE records
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:08 AM Steve Grubb <sgrubb@redhat.com> wrote:
> On Thu, 17 Jan 2019 08:21:40 -0500
> Paul Moore <paul@paul-moore.com> wrote:
>
> > On Thu, Jan 17, 2019 at 4:33 AM Steve Grubb <sgrubb@redhat.com> wrote:
> > > On Mon, 14 Jan 2019 17:58:58 -0500
> > > Paul Moore <paul@paul-moore.com> wrote:
> > >
> > > > On Mon, Dec 10, 2018 at 5:18 PM Richard Guy Briggs
> > > > <rgb@redhat.com> wrote:
> > > > >
> > > > > Tie syscall information to all CONFIG_CHANGE calls since they
> > > > > are all a result of user actions.
> > >
> > > Please don't tie syscall information to this. The syscall will be
> > > sendto. We don't need that information, its implicit. Also, doing
> > > this will possibly wreck things in libauparse. Please test the
> > > events with ausearch --format csv and --format text. IFF the event
> > > looks better or the same should we do this. If stuff disappears,
> > > the patch is breaking things
> >
> > We've discussed this quite a bit already;
>
> Yes, and you still don't seem be listening. You have to cooperate on
> modifying events. We as a community need to respect each other's needs
> and work together to solve problems. What this is saying sounds a lot
> like I don't care if it breaks things, I'm gonna do it my way. Tough
> luck.

I see you added LKML to the To/CC line.  Fun.  Unless they've been
following the audit list for the past several years I'm not sure they
have all the context to fully understand some of the things in this
thread, but sure, why not.

I understand you are frustrated Steve, I get it.  I can also
understand how you feel that I'm not listening to you because I'm not
agreeing with you on this, I get this too.  However, we've talked
about this quite a bit and keeping individual audit records split
across multiple events when they are all part of the same event just
doesn't make sense to me.  The users who have commented on this also
agree that associated records should be combined into one event.  I
definitely don't want to put words in Richard's mouth, but I believe
he has also said that he believes that associating all related records
into a single event makes sense.

I'm listening to you Steve - look at all the times I've asked for your
perspective when it comes to certification requirements? - I just
don't always agree with you.

> You do not have to make sense of any of these events. So, what does it
> really matter to you how the event is formed? What I'm asking for is
> have these changes been vetted to ensure that they are not breaking
> things?

We are not changing the record formats, all we are doing is changing
the timestamp/event counter so that related records are grouped
together into the same event.  For example, in this particular case
(describing this for the LKML crowd that may be reading this) we are
combining the syscall audit record that triggers the audit
configuration change with the audit configuration change record into a
single event.  The code currently treats the syscall record and the
audit config change record as separate events - which is just silly as
they belong to the same event, triggered by the same user action -
this patch should fix this by associating the two records so they are
part of the same audit event.  From my perspective this is a bug fix.

> > connecting associated records into a single event is something that
> > should happen, needs to happen, and will happen.  Conceptually it
> > makes no sense to record the syscall (and any other associated
> > records) which triggers the audit configuration change, and the
> > configuration change record itself as two distinct events - they are
> > the same event.
>
> Except that they are not. The design of the audit system is to save
> disk space as much as possible by emitting single record events on
> certain event types that are simple. To add a syscall to it adds useless
> information (such as a socket address record), slows down processing,
> and wastes disk space. If you get a SYSCALL record, that indicates that
> you have triggered an event that the system admin has placed explicit
> rules on. That is different than the common criteria required
> configuration change event.

I've said this many times in the past, I believe Richard has said the
same too (maybe it was in a GH issue?), but I'll say it again ... if
the system's audit config is such that syscall records are not being
generated, then this patch will not cause them to be generated; all
this patch does is ensure that *if* a syscall record is being
generated *and* an audit config change record is being generated, then
the two records will share the same event counter and treated as a
single event.  This change does not cause any change to the amount of
information emitted by the kernel, all it does is group the related
records together.

> >  We've also heard from a prominent user that
> > associating records in this way is desirable.
> >
> > If the ausearch csv and text audit log transformations can't handle
> > this particular change, I would consider that a shortcoming of that
> > code.  We have multi-record events now, and this is only going to
> > increase in the future.
>
> Isn't there some kind a guideline about not breaking user space?

Yes, when that bit of userspace code predates the change.  You knew
this was coming when you wrote that tool, writing userspace
applications that make poor assumptions and using that as a way to
block kernel development is not something I look upon favorably.

-- 
paul moore
www.paul-moore.com
