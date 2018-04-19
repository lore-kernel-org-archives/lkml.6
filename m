Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3081306-1524142357-2-3194695320712907128
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524142357; b=FpffzyWEsYtZ/jDXYeiglsYjr9Zn2XY+4GXLwE7ViN3zflE4Tr
    vKOYa9gPzL3WArMrSmUc3sdnZEzC++dEd/RHkKLZVnQqFXfvHCwfoF8CVS1Y8NAd
    bOeETX7YRAE8GZKbsyJCWojNNdh3r+MUxwF7Vg4uEZS2rWXM5D23Lb6JPvUeOZ4a
    ZgRNKXnz3O22OXBIhbN1dDL1+kvki8dc1zIo21TgNRzjXpL1pVMTVijXeWmNPfik
    Xv/aoM9va8N0gJ0EvH7kO6ceBeU2IKw2GTztEydVzMPBwdZGFsu5qYXt53k0eejE
    i4u19ps3ZoqsYE5fOUrUPco8Psa2rRUdAagg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524142357; bh=5gJlV5woevWpP3hA4QzgGq9l0rgPNH
    wLhDl1ZtTyevA=; b=EqR9KgUdGnhqPFvbSX9Otzv23MGxQc8v/twwUC4kB797mB
    w8vQwCf9BDnnsNxIRsWXGWWGcqyF08CsrAUhS5/m21FiCtEh8DOcCZ/NfrvcNO+k
    Bys3qADMgxy/hxEgFzVeI5R9LmjVqglhHu9Nz3/wZ68dzHbg34bDvx4wEPcxKAkH
    dL3LEzXkyfqD9YMf7ld+9f3YuyEmcSduaEkPfxbCfR/jeev1CPNIzhd77BaGykTF
    i+T+ARhRJL8P2keRbcjp7s+ecg+R3kSeneq6mUyWS21IxPhYdBc9G+TR3paS+763
    wAZBqAfRt4xWrG7vui1qHeGBaovZ6yyNJopPDBRA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMtElo+Aj5OQnIDYwaAWrxXlLAam/gN1uJiKGJLocHMGEHvP250k3j4Bh/XH0Lq45xHGNeJUrtR2DDQIcQZzO6dSD2BsbxYix/bUNaOsmMfRalEnuuIQ
    IAC29DMNdR9GHFURYMdUmULAclP3mTTpcuWBj+rr58+FWe/KjA9xK9Gl2S6003YVu2XauVsIl4OF9/m0YB9xW24Ap8mFN1WbFnLDhYsA7DHL4Ad7NG85nR7g
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8 a=E_7rcF2wgcJJuGLFI3YA:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752864AbeDSMwA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 08:52:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41646 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752623AbeDSMv5 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Thu, 19 Apr 2018 08:51:57 -0400
Date: Thu, 19 Apr 2018 08:45:51 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Subject: Re: [RFC PATCH ghak32 V2 12/13] audit: NETFILTER_PKT: record each
 container ID associated with a netNS
Message-ID: <20180419124550.7uknp4oebvwoo67s@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <66adde01c1dda792aff99a457eea576a0b08ca98.1521179281.git.rgb@redhat.com>
 <CAHC9VhR3BNRr24BPxud0X_eyFmSxUOh9bwjWNU4Z=rnDR0fENA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR3BNRr24BPxud0X_eyFmSxUOh9bwjWNU4Z=rnDR0fENA@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-18 22:10, Paul Moore wrote:
> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > Add container ID auxiliary record(s) to NETFILTER_PKT event standalone
> > records.  Iterate through all potential container IDs associated with a
> > network namespace.
> >
> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > ---
> >  kernel/audit.c           |  1 +
> >  kernel/auditsc.c         |  2 ++
> >  net/netfilter/xt_AUDIT.c | 15 ++++++++++++++-
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/audit.c b/kernel/audit.c
> > index 08662b4..3c77e47 100644
> > --- a/kernel/audit.c
> > +++ b/kernel/audit.c
> > @@ -2102,6 +2102,7 @@ int audit_log_container_info(struct audit_context *context,
> >         audit_log_end(ab);
> >         return 0;
> >  }
> > +EXPORT_SYMBOL(audit_log_container_info);
> >
> >  void audit_log_key(struct audit_buffer *ab, char *key)
> >  {
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index 208da962..af68d01 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -975,6 +975,7 @@ struct audit_context *audit_alloc_local(void)
> >         context->in_syscall = 1;
> >         return context;
> >  }
> > +EXPORT_SYMBOL(audit_alloc_local);
> >
> >  inline void audit_free_context(struct audit_context *context)
> >  {
> > @@ -989,6 +990,7 @@ inline void audit_free_context(struct audit_context *context)
> >         audit_proctitle_free(context);
> >         kfree(context);
> >  }
> > +EXPORT_SYMBOL(audit_free_context);
> >
> >  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
> >                                  kuid_t auid, kuid_t uid, unsigned int sessionid,
> > diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
> > index c502419..edaa456 100644
> > --- a/net/netfilter/xt_AUDIT.c
> > +++ b/net/netfilter/xt_AUDIT.c
> > @@ -71,10 +71,14 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> >  {
> >         struct audit_buffer *ab;
> >         int fam = -1;
> > +       struct audit_context *context = audit_alloc_local();
> > +       struct audit_containerid *cont;
> > +       int i = 0;
> > +       struct net *net;
> >
> >         if (audit_enabled == 0)
> >                 goto errout;
> 
> Do I need to say it?  I probably should ... the allocation should
> happen after the audit_enabled check.

Already fixed in V3 in my tree a couple of weeks ago...
More timely review please?

> > -       ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> > +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
> >         if (ab == NULL)
> >                 goto errout;
> >
> > @@ -104,7 +108,16 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
> >
> >         audit_log_end(ab);
> >
> > +       net = sock_net(NETLINK_CB(skb).sk);
> > +       list_for_each_entry(cont, &net->audit_containerid, list) {
> > +               char buf[14];
> > +
> > +               sprintf(buf, "net%u", i++);
> > +               audit_log_container_info(context, buf, cont->id);
> > +       }
> 
> It seems like this could (should?) be hidden inside an audit function,
> e.g. audit_log_net_containers() or something like that.

Perhaps...  It was open-coded since at this point there are no other
users.  That'll make this tidier though.

> >  errout:
> > +       audit_free_context(context);
> >         return XT_CONTINUE;
> >  }
> 
> -- 
> paul moore
> www.paul-moore.com

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
