Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4D1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C1520834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 21:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37C1520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727623AbeJZGaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 02:30:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbeJZGaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 02:30:12 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A5C7EC9DD8;
        Thu, 25 Oct 2018 21:55:47 +0000 (UTC)
Received: from ivy-bridge (ovpn-116-33.ams2.redhat.com [10.36.116.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8D0F9CDB;
        Thu, 25 Oct 2018 21:55:26 +0000 (UTC)
Date:   Thu, 25 Oct 2018 23:55:27 +0200
From:   Steve Grubb <sgrubb@redhat.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     rgb@redhat.com, simo@redhat.com, carlos@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, dhowells@redhat.com,
        linux-audit@redhat.com, netfilter-devel@vger.kernel.org,
        ebiederm@xmission.com, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, viro@zeniv.linux.org.uk
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info
 of syscalls
Message-ID: <20181025235527.15a39d75@ivy-bridge>
In-Reply-To: <CAHC9VhScaG8aOFYRV5hPXEKob1QRth5YFEbHNY=ZgKKAKxBBsQ@mail.gmail.com>
References: <cover.1533065887.git.rgb@redhat.com>
        <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
        <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
        <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca>
        <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
        <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca>
        <20181025080638.771621a3@ivy-bridge>
        <CAHC9VhR02siURgadQs0EikcOm0d_TPAi4jJYCx4NkA=wQ5rjSA@mail.gmail.com>
        <20181025122732.4j4rbychjse3gemt@madcap2.tricolour.ca>
        <20181025175745.5b2b13e9@ivy-bridge>
        <20181025173830.4yklhnrydt5qvr67@madcap2.tricolour.ca>
        <CAHC9VhScaG8aOFYRV5hPXEKob1QRth5YFEbHNY=ZgKKAKxBBsQ@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 25 Oct 2018 21:55:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Oct 2018 16:40:19 -0400
Paul Moore <paul@paul-moore.com> wrote:

> On Thu, Oct 25, 2018 at 1:38 PM Richard Guy Briggs <rgb@redhat.com>
> wrote:
> > On 2018-10-25 17:57, Steve Grubb wrote:  
> > > On Thu, 25 Oct 2018 08:27:32 -0400
> > > Richard Guy Briggs <rgb@redhat.com> wrote:
> > >  
> > > > On 2018-10-25 06:49, Paul Moore wrote:  
> > > > > On Thu, Oct 25, 2018 at 2:06 AM Steve Grubb
> > > > > <sgrubb@redhat.com> wrote:  
> > > > > > On Wed, 24 Oct 2018 20:42:55 -0400
> > > > > > Richard Guy Briggs <rgb@redhat.com> wrote:  
> > > > > > > On 2018-10-24 16:55, Paul Moore wrote:  
> > > > > > > > On Wed, Oct 24, 2018 at 11:15 AM Richard Guy Briggs
> > > > > > > > <rgb@redhat.com> wrote:  
> > > > > > > > > On 2018-10-19 19:16, Paul Moore wrote:  
> > > > > > > > > > On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs
> > > > > > > > > > <rgb@redhat.com> wrote:  
> > > > >
> > > > > ...
> > > > >  
> > > > > > > > > > > +/*
> > > > > > > > > > > + * audit_log_contid - report container info
> > > > > > > > > > > + * @tsk: task to be recorded
> > > > > > > > > > > + * @context: task or local context for record
> > > > > > > > > > > + * @op: contid string description
> > > > > > > > > > > + */
> > > > > > > > > > > +int audit_log_contid(struct task_struct *tsk,
> > > > > > > > > > > +                            struct audit_context
> > > > > > > > > > > *context, char *op) +{
> > > > > > > > > > > +       struct audit_buffer *ab;
> > > > > > > > > > > +
> > > > > > > > > > > +       if (!audit_contid_set(tsk))
> > > > > > > > > > > +               return 0;
> > > > > > > > > > > +       /* Generate AUDIT_CONTAINER record with
> > > > > > > > > > > container ID */
> > > > > > > > > > > +       ab = audit_log_start(context, GFP_KERNEL,
> > > > > > > > > > > AUDIT_CONTAINER);
> > > > > > > > > > > +       if (!ab)
> > > > > > > > > > > +               return -ENOMEM;
> > > > > > > > > > > +       audit_log_format(ab, "op=%s contid=%llu",
> > > > > > > > > > > +                        op,
> > > > > > > > > > > audit_get_contid(tsk));
> > > > > > > > > > > +       audit_log_end(ab);
> > > > > > > > > > > +       return 0;
> > > > > > > > > > > +}
> > > > > > > > > > > +EXPORT_SYMBOL(audit_log_contid);  
> > > > > > > > > >
> > > > > > > > > > As discussed in the previous iteration of the
> > > > > > > > > > patch, I prefer AUDIT_CONTAINER_ID here over
> > > > > > > > > > AUDIT_CONTAINER.  If you feel strongly about
> > > > > > > > > > keeping it as-is with AUDIT_CONTAINER I suppose I
> > > > > > > > > > could live with that, but it is isn't my first
> > > > > > > > > > choice.  
> > > > > > > > >
> > > > > > > > > I don't have a strong opinion on this one, mildly
> > > > > > > > > preferring the shorter one only because it is
> > > > > > > > > shorter.  
> > > > > > > >
> > > > > > > > We already have multiple AUDIT_CONTAINER* record types,
> > > > > > > > so it seems as though we should use "AUDIT_CONTAINER"
> > > > > > > > as a prefix of sorts, rather than a type itself.  
> > > > > > >
> > > > > > > I'm fine with that.  I'd still like to hear Steve's
> > > > > > > input.  He had stronger opinions than me.  
> > > > > >
> > > > > > The creation event should be separate and distinct from the
> > > > > > continuing use when its used as a supplemental record. IOW,
> > > > > > binding the ID to a container is part of the lifecycle and
> > > > > > needs to be kept distinct.  
> > > > >
> > > > > Steve's comment is pretty ambiguous when it comes to
> > > > > AUDIT_CONTAINER vs AUDIT_CONTAINER_ID, but one could argue
> > > > > that AUDIT_CONTAINER_ID helps distinguish the audit container
> > > > > id marking record and gets to what I believe is the spirit of
> > > > > Steve's comment.  Taking this in context with my previous
> > > > > remarks, let's switch to using AUDIT_CONTAINER_ID.  
> > > >
> > > > I suspect Steve is mixing up AUDIT_CONTAINER_OP with
> > > > AUDIT_CONTAINER_ID, confusing the fact that they are two
> > > > seperate records.  As a summary, the suggested records are:
> > > >     CONTAINER_OP    audit container identifier creation
> > > >     CONTAINER       audit container identifier aux record to an
> > > > event
> > > >
> > > > and what Paul is suggesting (which is fine by me) is:
> > > >     CONTAINER_OP    audit container identifier creation event
> > > >     CONTAINER_ID    audit container identifier aux record to
> > > > an event
> > > >
> > > > Steve, please indicate you are fine with this.  
> > >
> > > I thought it was:  
> >
> > It *was*.  It was changed at Paul's request in this v3 thread:
> >         https://www.redhat.com/archives/linux-audit/2018-July/msg00087.html
> >
> > And listed in the examples and changelog to this v4 patchset:
> >         https://www.redhat.com/archives/linux-audit/2018-July/msg00178.html
> >
> > It is also listed in this userspace patchset update v4 (which should
> > also have had a changelog added to it, note to self...):
> >         https://www.redhat.com/archives/linux-audit/2018-July/msg00189.html
> >
> > I realize it is hard to keep up with all the detail changes in these
> > patchsets...
> >  
> > > CONTAINER_ID audit container identifier creation event
> > > event. CONTAINER audit container identifier aux record to an
> > > event
> > >
> > > Or vice versa. Don't mix up creation of the identifier with
> > > operations.  
> >
> > Exactly what I'm trying to avoid...  Worded another way: "Don't mix
> > up the creation operation with routine reporting of the identifier
> > in events."  Steve, can you and Paul discuss and agree on what they
> > should be called?  I don't have a horse in this race, but I need to
> > record the result of that run.  ;-)  
> 
> See my previous comments, I think I've been pretty clear on what I
> would like to see.

And historically speaking setting audit loginuid produces a LOGIN
event, so it only makes sense to consider binding container ID to
container as a CONTAINER event. For other supplemental records, we name
things what they are: PATH, CWD, SOCKADDR, etc. So, CONTAINER_ID makes
sense. CONTAINER_OP sounds like its for operations on a container. Do
we have any operations on a container?

-Steve
