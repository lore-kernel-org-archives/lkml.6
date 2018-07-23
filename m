Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C225AECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CEA420671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 18:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="OAxm4A1y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CEA420671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388106AbeGWTdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 15:33:55 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43360 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388058AbeGWTdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 15:33:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id m12-v6so1164706lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 11:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jl9N+vIKdPZXD2bA1vCp/ip+qMPn3HmCXAiDuY1w9J8=;
        b=OAxm4A1yatnhoX93nX4Mrcl3Jr0sVj0bJd5fFj2rVbIhY6JWqbwRYZeTtrB4CRtNSx
         4vU/4OgWn4aVg3PJc+w1PTQcHeTh/TMfZ+YGWjDKDplGO6fVsw5stiq/QaHk9SMWABw4
         Y9KIpEv0SEEu8XxcX8Zd61D9+QOxJKHZUFp0fyM7WUazm95RZ3UD6nL16pTvpHiVVOm+
         IqrFv3rUua/je3hVMJOo+C9eVg4ExPNLnStTJTA3b9AtewKTsFQ2dGXPJXa7GyPKZ8iN
         EOMZcv2FLLBK+ySH6EwXakzKdFkjH4UDL4sZF0X+58a6zNv9ooqz64skkyfO5573oe+q
         LQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jl9N+vIKdPZXD2bA1vCp/ip+qMPn3HmCXAiDuY1w9J8=;
        b=K+DakafcsFBki0tv/n2Tklsz4v4h0sBFuGGxYE2M/q2t1V06xn+VAOVPUbxp4IsAto
         AZK4RXkq4SDzILNpEWxH9W7p26Mw/ob4AdJmmlLWHpXFb+gnLwim3gO8d/f7b9JHiilq
         BhdX2J8OiZa5+YYtFsTN4ci5tV4vr4w7/+jLdzqhROYvModkpO+RXOj0APzJUW712PzW
         oPnLK4lX+OOJFknvi02C6848/vbkgGTGIXFAGKRpITNnjjo+Tb8GtOAp8OKsbtjqxwtN
         YpN0sgxb+FujeFw4qgSe6qemo+eqFKPg771qf4njCKkLR2LafsLTHdgGhGd6KAsUXCKN
         04sw==
X-Gm-Message-State: AOUpUlGj1JGIAOpDdk1u7R8miiyHyQ23Dis/nGA60CsxDMGFpw2w3XDk
        NpaBH9d482IOhChsVlq4fMulcJ5lb3AlGdBxciMU
X-Google-Smtp-Source: AAOMgpcpE7K81DgkGOvLIF9CqiMwFiw+2M6x2sp/JqSG92WE758nMsJhXbFhy91N/bxCf3lpwEX7r0dEd3YJzZlu0Iw=
X-Received: by 2002:a19:9a81:: with SMTP id c123-v6mr8431505lfe.106.1532370683233;
 Mon, 23 Jul 2018 11:31:23 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528304203.git.rgb@redhat.com> <3318670.y8SpQ3RC2W@x2>
 <20180723151148.hyu4jqy2etp5afpt@madcap2.tricolour.ca> <2739536.aL1iVigTi9@x2>
In-Reply-To: <2739536.aL1iVigTi9@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 23 Jul 2018 14:31:11 -0400
Message-ID: <CAHC9VhTkuf+2BwJp399-NzSgQyp21GgY1SZVDboDdXgpvEV=pQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak90 (was ghak32) V3 02/10] audit: log container
 info of syscalls
To:     sgrubb@redhat.com, rgb@redhat.com
Cc:     cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org, linux-audit@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        carlos@redhat.com, dhowells@redhat.com, viro@zeniv.linux.org.uk,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 23, 2018 at 12:48 PM Steve Grubb <sgrubb@redhat.com> wrote:
> On Monday, July 23, 2018 11:11:48 AM EDT Richard Guy Briggs wrote:
> > On 2018-07-23 09:19, Steve Grubb wrote:
> > > On Sunday, July 22, 2018 4:55:10 PM EDT Richard Guy Briggs wrote:
> > > > On 2018-07-22 09:32, Steve Grubb wrote:
> > > > > On Saturday, July 21, 2018 4:29:30 PM EDT Richard Guy Briggs wrote:
> > > > > > > > + * audit_log_contid - report container info
> > > > > > > > + * @tsk: task to be recorded
> > > > > > > > + * @context: task or local context for record
> > > > > > > > + * @op: contid string description
> > > > > > > > + */
> > > > > > > > +int audit_log_contid(struct task_struct *tsk,
> > > > > > > > +                            struct audit_context *context,
> > > > > > > > char
> > > > > > > > *op)
> > > > > > > > +{
> > > > > > > > +       struct audit_buffer *ab;
> > > > > > > > +
> > > > > > > > +       if (!audit_contid_set(tsk))
> > > > > > > > +               return 0;
> > > > > > > > +       /* Generate AUDIT_CONTAINER record with container ID */
> > > > > > > > +       ab = audit_log_start(context, GFP_KERNEL,
> > > > > > > > AUDIT_CONTAINER);
> > > > > > > > +       if (!ab)
> > > > > > > > +               return -ENOMEM;
> > > > > > > > +       audit_log_format(ab, "op=%s contid=%llu",
> > > > > > > > +                        op, audit_get_contid(tsk));
> > > > > > >
> > > > > > > Can you explain your reason for including an "op" field in this
> > > > > > > record
> > > > > > > type?  I've been looking at the rest of the patches in this
> > > > > > > patchset
> > > > > > > and it seems to be used more as an indicator of the record's
> > > > > > > generating context rather than any sort of audit container ID
> > > > > > > operation.
> > > > > >
> > > > > > "action" might work, but that's netfilter and numeric... "kind"?
> > > > > > Nothing else really seems to fit from a field name, type or lack of
> > > > > > searchability perspective.
> > > > > >
> > > > > > Steve, do you have an opinion?
> > > > >
> > > > > We only have 1 sample event where we have op=task. What are the other
> > > > > possible values?
> > > >
> > > > For the AUDIT_CONTAINER record we have op= "task", "target" (from the
> > > > ptrace and signals patch), "tty".
> > > >
> > > > For the AUDIT_CONTAINER_ID record we have "op=set".
> > >
> > > Since the purpose of this record is to log the container id, I think that
> > > is all that is needed. We can get the context from the other records in
> > > the event. I'd suggest dropping the "op" field.
> >
> > Ok, the information above it for two different audit container
> > identifier records.  Which one should drop the "op=" field?  Both?  Or
> > just the AUDIT_CONTAINER record?  The AUDIT_CONTAINER_ID record (which
> > might be renamed) could use it to distinguish a "set" record from a
> > dropped audit container identifier that is no longer registered by any
> > task or namespace.
>
> Neither of them need it. All they need to do is state the container that is
> being acted upon.

I think we should keep the "op" field for audit container ID
management operations, even though we really only have a "set"
operation at the moment, but the others should drop the "op" field
(see my previous emails in this thread).

-- 
paul moore
www.paul-moore.com
