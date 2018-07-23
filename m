Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6865ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3660820854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 21:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="LE9CRfso"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3660820854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGWWD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 18:03:56 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:44567 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388109AbeGWWD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 18:03:56 -0400
Received: by mail-lf1-f44.google.com with SMTP id g6-v6so1453127lfb.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IrB6alzCcsA2cBmWipaiXQNqFleBghFpiQmO4z7c78Q=;
        b=LE9CRfso2Ot0vDgvyflvb0SKCamD+Mf+OBYE1puFllWmRDNLeLv2XJACHpFV1Sr9Je
         IBBX2jPzRgqMosyoMTC3Ymax/AKvBg3jP1pmlJGDgv4zqpW+AbtkQFpXXKTo1IM4lCVf
         T/FSD/EqmiKy9kHSOW6EQn5nlMIQyE2YXQ9avDdjZTjZtVZ6TSgRXSXRMn7FvCWgSmIl
         EVF/2lR/zPmSBoXUq+KCWR0OVXfwYRo8O2WdbAllTRGcGiCUchdlQ5VANU8Sh/A/v06b
         An9WNhDsVGyabH8qmu2MU+3bZA+EZZnamZ9kL81cUIuw0WlD6epfzRTzuVxuUpVoPOrD
         6+6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IrB6alzCcsA2cBmWipaiXQNqFleBghFpiQmO4z7c78Q=;
        b=MAQhlUi0P3JfmYpRgL5J5Wr3vyRwRpBZ5IaRejcCPm/cd5vCshql3xrJnBB6JOYt6+
         xlzkKpv3H+AGE3pq8IqY5C1n0HLsfuvFzmQB/lTZWsGrFaswTmlIr02whs6/73GBJbAn
         QZCd1D3tEyWRSy9rVjBzU9LEf7hgGSYpuvUcpaTmlXYeYP834kUeRY+VMHQSj8w/+zZT
         sRYi2ew8b+FJCbd3PIs4eboQp+O6vw4BYvrFNeO5dU4/QkrZ0wxo2MC/ChFQSKwZHnmZ
         1XmnmiGFcjW0ma29bSUgVHuB8/kXej19kLqmzQv+VECGmIv34fGtMWUa3pElbz+olqYr
         dIzQ==
X-Gm-Message-State: AOUpUlGRBGurqX0oOusruep5yXDGpCL4gMHJempPRihE62TLANvsfrKh
        No19vaom96OFG0QxF7cEwH2fiZlZdlmL+4Obo9Dv
X-Google-Smtp-Source: AAOMgpf1/9FxIz0KQigTMyFaCCC+7trHnG88az8YpevRNOked5FZiD9rEqI0tpabrW0e261nbukTCApVQJ60CQb4/WE=
X-Received: by 2002:a19:169f:: with SMTP id 31-v6mr8056709lfw.72.1532379653076;
 Mon, 23 Jul 2018 14:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1529003588.git.rgb@redhat.com> <907e32319825bb6336a662f4f6f6d173f56f3226.1529003588.git.rgb@redhat.com>
 <CAHC9VhSKcxHScr-ZNQU3iVrqhU4CDKW7tpn3e+NBKAAmnpRP4g@mail.gmail.com>
 <20180712214608.ed4chli7mdc7ymin@madcap2.tricolour.ca> <20180723164035.wkazolpmpf3mvdxw@madcap2.tricolour.ca>
In-Reply-To: <20180723164035.wkazolpmpf3mvdxw@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jul 2018 17:00:41 -0400
Message-ID: <CAHC9VhQ3qxHQ6mHhs1JNMg5qr3qJJh2DpD147QWnfsXdM7=rGA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak59 V1 3/6] audit: exclude user records from
 syscall context
To:     rgb@redhat.com
Cc:     Eric Paris <eparis@parisplace.org>, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:43 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-07-12 17:46, Richard Guy Briggs wrote:
> > On 2018-06-28 18:11, Paul Moore wrote:
> > > On Thu, Jun 14, 2018 at 4:23 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > > Since the function audit_log_common_recv_msg() is shared by a number of
> > > > AUDIT_CONFIG_CHANGE and the entire range of AUDIT_USER_* record types,
> > > > and since the AUDIT_CONFIG_CHANGE message type has been converted to a
> > > > syscall accompanied record type, special-case the AUDIT_USER_* range of
> > > > messages so they remain standalone records.
> > > >
> > > > See: https://github.com/linux-audit/audit-kernel/issues/59
> > > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > > ---
> > > >  kernel/audit.c | 12 +++++++++---
> > > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > >
> > > I think this is fine, but see my previous comment about combining 2/6
> > > and 3/6 as a safety measure.
> >
> > This one I left as a seperate patch for discussion.  We'd previously
> > talked about connecting all possible records with syscall records if
> > they exist, but this one I'm unsure about, since we don't really care
> > what userspace process is issuing this message.  It is just the message
> > content itself that is important.  Or is it?  Are we concerned about
> > CAP_AUDIT_WRITE holders/abusers and want as much info about them as we
> > can get in case they go rogue or pear-shaped?
>
> I'm waiting on re-spinning this patchset because of this open question.
>
> Is connecting AUDIT_USER* records desirable or a liability?

Like I said, I think special casing the AUDIT_USER* records so they
are *not* associated with other records is okay, and perhaps even the
right thing to do.  The problem is that we don't have the necessary
context (har har) to match any kernel events (and there is the
possibility that there are none) to the userspace generated
AUDIT_USER* event.  Further, I don't think this is something we would
ever be able to solve in a reasonable manner.

> > > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > > index e469234..c8c2efc 100644
> > > > --- a/kernel/audit.c
> > > > +++ b/kernel/audit.c
> > > > @@ -1057,7 +1057,8 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
> > > >         return err;
> > > >  }
> > > >
> > > > -static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > > +static void __audit_log_common_recv_msg(struct audit_context *context,
> > > > +                                       struct audit_buffer **ab, u16 msg_type)
> > > >  {
> > > >         uid_t uid = from_kuid(&init_user_ns, current_uid());
> > > >         pid_t pid = task_tgid_nr(current);
> > > > @@ -1067,7 +1068,7 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > >                 return;
> > > >         }
> > > >
> > > > -       *ab = audit_log_start(audit_context(), GFP_KERNEL, msg_type);
> > > > +       *ab = audit_log_start(context, GFP_KERNEL, msg_type);
> > > >         if (unlikely(!*ab))
> > > >                 return;
> > > >         audit_log_format(*ab, "pid=%d uid=%u", pid, uid);
> > > > @@ -1075,6 +1076,11 @@ static void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > >         audit_log_task_context(*ab);
> > > >  }
> > > >
> > > > +static inline void audit_log_common_recv_msg(struct audit_buffer **ab, u16 msg_type)
> > > > +{
> > > > +       __audit_log_common_recv_msg(audit_context(), ab, msg_type);
> > > > +}
> > > > +
> > > >  int is_audit_feature_set(int i)
> > > >  {
> > > >         return af.features & AUDIT_FEATURE_TO_MASK(i);
> > > > @@ -1341,7 +1347,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
> > > >                                 if (err)
> > > >                                         break;
> > > >                         }
> > > > -                       audit_log_common_recv_msg(&ab, msg_type);
> > > > +                       __audit_log_common_recv_msg(NULL, &ab, msg_type);
> > > >                         if (msg_type != AUDIT_USER_TTY)
> > > >                                 audit_log_format(ab, " msg='%.*s'",
> > > >                                                  AUDIT_MESSAGE_TEXT_MAX,
> > > > --
> > > > 1.8.3.1
> > > >
> > >
> > >
> > > --
> > > paul moore
> > > www.paul-moore.com
> > >
> > > --
> > > Linux-audit mailing list
> > > Linux-audit@redhat.com
> > > https://www.redhat.com/mailman/listinfo/linux-audit
> >
> > - RGB
> >
> > --
> > Richard Guy Briggs <rgb@redhat.com>
> > Sr. S/W Engineer, Kernel Security, Base Operating Systems
> > Remote, Ottawa, Red Hat Canada
> > IRC: rgb, SunRaycer
> > Voice: +1.647.777.2635, Internal: (81) 32635
> >
> > --
> > Linux-audit mailing list
> > Linux-audit@redhat.com
> > https://www.redhat.com/mailman/listinfo/linux-audit
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
