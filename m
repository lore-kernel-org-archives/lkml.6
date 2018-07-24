Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79215C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2876B20685
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="urQVxL9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2876B20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbeGXVaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:30:22 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45684 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbeGXVaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:30:22 -0400
Received: by mail-lf1-f66.google.com with SMTP id j143-v6so3856520lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 13:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ItUME5GIOBjyfwMZIV3URKIJHkcBt9LkCkj2lh8zsZc=;
        b=urQVxL9pIGo8y04NmsE6ma5M2iZFCOBAVKtCN10VfP7bKHyeu3ZsKHg9hyJhDgKzXL
         JEBto2KJnTL3DZnMppXP0RaKj/GBEzhTE1l3ES4Oat/9v8mtqNyRsf0Zy9heviOcSCdO
         FK/TL7Vs2lunjlN9ffDPdM/yeQrguw8B9vsoFt81HLGYYYuETXY+KcQtnLJWTkwTSBmG
         gqQ+xdMoOUh19fgHGeaRR5pTvQpX9YkV9Q1L044LQi91B6/RlAoowueWloBa673g1NJf
         DppYMCb+pj4mLJrrvnPf6cc00OmfhKzbd3YOLFbi22v6YgymwTsXwF9RyfrbulRjMtCe
         3cng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ItUME5GIOBjyfwMZIV3URKIJHkcBt9LkCkj2lh8zsZc=;
        b=uJ9roJVal2OpU33MelDJtuksDMLlfLmEtaI8+2N6qRI3XHxt+q6JwyGDayQS1803iz
         hEVhhMDTwQSovgwtB4le/Sa9dFyU59QEIMBu4+E5sPLvUpZ6xKzSbg9+CWy4nQIJfs6g
         BdEVE6Z1BfGcVlM/Z3Lm4OI9IHgnJqR1fCE9KPbySonKI4q20UsjBFFq3P8U50VMD2sw
         zodASylwl3ztSzavaUEsYgLlFroAA37rqQ5fDY/3cPASoXXg10VA+86d0gDHXrcM2S8G
         bLkikR2AhYUj86WTvWrA9wFxGVPkbQW/RJ6M38WPJMLGwwLc3qc/3QHr42eMz+EMUnPA
         gI9w==
X-Gm-Message-State: AOUpUlGeIBsSjvRUoYiRpMeCJnYBJG1IgaB38xgQ09OyXrKS+c3QsNQF
        y13CDf5SMEYPuk0wZ8BVvqJzuPels+L62oZlkVzC
X-Google-Smtp-Source: AAOMgpfRE8kNUosFnn5nDm8pEX17PZMmid5WVLA7uzmfx//WsbtJ0DCp+/XklsSkGIBd2vzoObkB95Zxexw3CbWW2bo=
X-Received: by 2002:a19:de4e:: with SMTP id v75-v6mr10531212lfg.14.1532463731688;
 Tue, 24 Jul 2018 13:22:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <c6b64f6540e2e531636142ced36d51f0744d0e1f.1528304204.git.rgb@redhat.com>
 <CAHC9VhQCxdOzcYHFtJ8eTLkNQxwvdAnuLOEguqHT_zU4V9d0OA@mail.gmail.com> <1748819.SHaROlQLoH@x2>
In-Reply-To: <1748819.SHaROlQLoH@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 24 Jul 2018 16:22:00 -0400
Message-ID: <CAHC9VhRiqp5ttCfh1EttLgbpPowr5P_B7nC6sP4pq=XBfEYqJg@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 08/10] audit: NETFILTER_PKT:
 record each container ID associated with a netNS
To:     sgrubb@redhat.com
Cc:     rgb@redhat.com, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, jlayton@redhat.com,
        carlos@redhat.com, dhowells@redhat.com, viro@zeniv.linux.org.uk,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 3:48 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Friday, July 20, 2018 6:15:00 PM EDT Paul Moore wrote:
> > On Wed, Jun 6, 2018 at 1:03 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > > Add audit container identifier auxiliary record(s) to NETFILTER_PKT
> > > event standalone records.  Iterate through all potential audit container
> > > identifiers associated with a network namespace.
> > >
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > include/linux/audit.h    |  5 +++++
> > > kernel/audit.c           | 20 +++++++++++++++++++-
> > > kernel/auditsc.c         |  2 ++
> > > net/netfilter/xt_AUDIT.c | 12 ++++++++++--
> > > 4 files changed, 36 insertions(+), 3 deletions(-)
> >
> > ...
> >
> > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > index 7e2e51c..4560a4e 100644
> > > --- a/include/linux/audit.h
> > > +++ b/include/linux/audit.h
> > > @@ -167,6 +167,8 @@ extern int audit_log_contid(struct audit_context
> > > *context, extern void audit_contid_add(struct net *net, u64 contid);
> > > extern void audit_contid_del(struct net *net, u64 contid);
> > > extern void audit_switch_task_namespaces(struct nsproxy *ns, struct
> > > task_struct *p); +extern void audit_log_contid_list(struct net *net,
> > > +                                struct audit_context *context);
> >
> > See my comment in previous patches about changing the function name to
> > better indicate it's dedicate use for network namespaces.
> >
> > > extern int                 audit_update_lsm_rules(void);
> > >
> > > @@ -231,6 +233,9 @@ static inline void audit_contid_del(struct net *net,
> > > u64 contid) { }
> > > static inline void audit_switch_task_namespaces(struct nsproxy *ns,
> > > struct task_struct *p) { }
> > > +static inline void audit_log_contid_list(struct net *net,
> > > +                                       struct audit_context *context)
> > > +{ }
> > >
> > > #define audit_enabled 0
> > > #endif /* CONFIG_AUDIT */
> > > diff --git a/kernel/audit.c b/kernel/audit.c
> > > index ecd2de4..8cca41a 100644
> > > --- a/kernel/audit.c
> > > +++ b/kernel/audit.c
> > > @@ -382,6 +382,20 @@ void audit_switch_task_namespaces(struct nsproxy
> > > *ns, struct task_struct *p) audit_contid_add(new->net_ns, contid);
> > > }
> > >
> > > +void audit_log_contid_list(struct net *net, struct audit_context
> > > *context) +{
> > > +       struct audit_contid *cont;
> > > +       int i = 0;
> > > +
> > > +       list_for_each_entry(cont, audit_get_contid_list(net), list) {
> > > +               char buf[14];
> > > +
> > > +               sprintf(buf, "net%u", i++);
> > > +               audit_log_contid(context, buf, cont->id);
> >
> > Hmm.  It looks like this will generate multiple audit container ID
> > records with "op=netX contid=Y" (X=netns number, Y=audit container
> > ID), is that what we want?  I've mentioned my concern around the "op"
> > values in these records earlier in the patchset, that still applies
> > here, but now I'm also concerned about the multiple records.  I'm
> > thinking we might be better served with a single record with either
> > multiple "contid" fields, or a single "contid" field with a set of
> > comma separated values (or some other delimiter that Steve's tools
> > will tolerate).
> >
> > Steve, thoughts?
>
> A single record is best. Maybe pattern this after the args listed in an
> execve record.

I'm concerned that an execve-like approach might not scale very well
as would could potentially have a lot of containers sharing a single
network namespace ("a%d=%d" vs ",%d").  Further, with execve we log
the argument position in addition to the argument itself, that isn't
something we need to worry about with the audit container IDs.

-- 
paul moore
www.paul-moore.com
