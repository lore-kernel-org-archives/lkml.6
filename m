Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78595C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE7220874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="Rw7o0o1k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE7220874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388809AbeGXVpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:45:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36472 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388766AbeGXVpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:45:07 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so4759789lji.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIbVHphLjgSJJLxUqiq5n6fMPKzB2BCtuKudKI24qQo=;
        b=Rw7o0o1kQNpYMzdrn5M5oShHbXK7UumYZslCkIZc3zlViwoQAaSWrLEgbeqgQ5iY3p
         w8XLcUGZnnp/wXd6G+rmf6cw/Qsgkjh3AurHIJE094aMkEIjXCAeYGfb/w+/d8YUKt35
         qvoxmH4+gs54Grs45jrlGgqTlRA4gXxHVWR6Qiwhxp1jIk3QkeWHpt1whGGaiHkeHwsK
         E5uFu9uRO4y+Bufj4xZXAaVs5bmxk6B3HFdWH2sX51vkDY7Jh5ocZs8260zD3+KA7QgY
         VCByExcPN3jGSqYySToot6+DCpTnqmmRWokUff4fIxFEzCXaDo+ZYz2KowuuiP0DY+B7
         Yqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIbVHphLjgSJJLxUqiq5n6fMPKzB2BCtuKudKI24qQo=;
        b=R5m397HdbImssDzTJHnVy/Eilx9B/4Npow5P2oYfV3oSBGO5exmB5JmjlKNprS3YVB
         QsR5wF+8GR21UzthJhurDt7/VUs9SpnCh81Bp68+jWTDBQkyDtMHD2mcakIe+UVKOg4q
         QVP1XEleByOWX6G/gAFBx/52WhUUtw355mYEvUerLsw5KQiZ/IpEgyB9++9n9rk3AjXd
         rTV1UjtfyrRKZvBzgpN67Al77kdQ5iMa6R1BKzag87euz64AVITQJaey9uImW1PBzm+c
         tZ2EBdw+ZBos64DmKkkMW5lBg9HjdQAZOTP2v7DfipyaThAnh1snj3uz+tMDfe3FoMKG
         U5+Q==
X-Gm-Message-State: AOUpUlFSWk43Qf9GkJYBbTkl29s9dYyynTp/rwyLtMG/+NBx4qranV/a
        V+kqb954/LyMtDAJ0EqvsMPCjTa9BO07++/ljnKQ
X-Google-Smtp-Source: AAOMgpcMDTIWu7H/HAfLDzf+tjBlY0rHtL86phwxS004I26oyiPqXAzLCDTcKa7W/Avmar/Gl9KVwO7clFdW1njYQA4=
X-Received: by 2002:a2e:291c:: with SMTP id u28-v6mr12760409lje.70.1532464614000;
 Tue, 24 Jul 2018 13:36:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <28ab8ad3c4e5de6f61b928eeb2af030b04a8820b.1528304204.git.rgb@redhat.com>
 <CAHC9VhTTJVbFq_Cmu8E7EzQD-JXjkbDz7P1EY8ePVrXpQAqPdw@mail.gmail.com> <20180724140721.yyi5e7y3czxsjwug@madcap2.tricolour.ca>
In-Reply-To: <20180724140721.yyi5e7y3czxsjwug@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 16:36:42 -0400
Message-ID: <CAHC9VhR9EYLfiDK+krfFLM4nSB2FCbyE0f1wFec1iKxg9jAXRQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 05/10] audit: add containerid
 support for tty_audit
To:     rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 10:10 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-20 18:14, Paul Moore wrote:
> > On Wed, Jun 6, 2018 at 1:04 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Add audit container identifier auxiliary record to tty logging rule
> > > event standalone records.
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > >  drivers/tty/tty_audit.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
> > > index e30aa6b..66bd850 100644
> > > --- a/drivers/tty/tty_audit.c
> > > +++ b/drivers/tty/tty_audit.c
> > > @@ -66,8 +66,9 @@ static void tty_audit_log(const char *description, dev_t dev,
> > >         uid_t uid = from_kuid(&init_user_ns, task_uid(tsk));
> > >         uid_t loginuid = from_kuid(&init_user_ns, audit_get_loginuid(tsk));
> > >         unsigned int sessionid = audit_get_sessionid(tsk);
> > > +       struct audit_context *context = audit_alloc_local();
> >
> > We should be using current's audit_context in tty_audit_log().
> > Actually, we should probably just get rid of the tsk variable in
> > tty_audit_log() and use current directly to make things a bit more
> > obvious.
>
> Ok, agreed.  At this point, it it current passed in anyways so no harm
> other than efficiency.
>
> > <time passes>
> >
> > I did some digging and I have a two year old, half-baked patch that
> > cleans up this tsk/current usage as well as a few others.  I just
> > rebased it against audit/next and surprisingly it seems to pass a
> > basic smoke test (kernel boots and audit-testsuite passes); I'll post
> > it to the list as a RFC once I'm done reviewing these patches.
>
> I'll leave this patch the way it is since there should be no difference
> and trust this other patch will work its way through the system and
> solve that.

Yep, that's a merge issue I'll deal with when we get to that point.
Although, I would expect that when you post an updated patchset that
it applies cleanly to the then-current audit/next tree (or Linus'
tree, but audit/next is preferable).  In other words, please rebase
your development branch before doing your final dev testing and
posting.

> > > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_TTY);
> > > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_TTY);
> > >         if (ab) {
> > >                 char name[sizeof(tsk->comm)];
> > >
> > > @@ -80,6 +81,8 @@ static void tty_audit_log(const char *description, dev_t dev,
> > >                 audit_log_n_hex(ab, data, size);
> > >                 audit_log_end(ab);
> > >         }
> > > +       audit_log_contid(context, "tty", audit_get_contid(tsk));
> > > +       audit_free_context(context);
> > >  }
> >
> > --
> > paul moore
> > www.paul-moore.com
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
