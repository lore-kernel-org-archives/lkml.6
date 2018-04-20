Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2501084-1524257318-2-4164083804896861427
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524257317; b=C1ufXZLbQqKRTQdYgOslrsm6zbXpeyKl1XTJtK7zUT/RKwxClt
    xBJueDzrIfKEmk3VQfs8yt+PwZSYDdMm7GQzbtLuCImQHV4SAJEYz8k3WMsI0hy9
    6PSkdufiEUgKube0H8aKuxL0/O1sPVm7LOolz3O7LWM0PWAKqQsariIN/mMfv+7P
    G36TF540o0q2qnvVGPlDOf1OAMoBFazHpQRYxNU3k6QECTNRV23ISDzPXCvH7m1k
    itG3HDGUVtlgZKxZ0W37REJAavqt5ELIF5yJGX62LhLI8J0xU3HBRZlUGPsf8hId
    M+PPieqVs0ANlqx3btwJakb/ibAUExqW+UcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524257317; bh=6GKJGa6wVGCKKVflFayLTTQFjz0QOT
    o5KEo/Ky1chqk=; b=kNwrFz3ZOQQdHVuqmp+w3865q5sZ+6teFhfk5PXZ5E9G7Z
    NPRwF/QxvSHad2ZBx1HhMNpFCypvShQV7m4HHFClz6bvezclSXaHT9b0Dc7JnKBT
    Amc5r4SVA2DaUqBCcmYVKVSmKbPJyiE3mBuCrmuNfMmKpjBLsVIPcpjddsSaVTGD
    4gPurSFQYV+20w3KNpE9AlcHCA0/i+Ybg9OlOjGwMmawKUvgfj8cj0v+X7d8mtNB
    FfgnjUasv00oCezsHMCpwA2jfKkZDpyftxSrdujYX4ppza4pWms/UpMIF2F1/sAR
    iMksJl+4F3fxsmgZg4PhwkSI3z2oxjrRME6uAkKA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfHc3aQ2xl5GYvm+lW+wLeE4lmbY8KActe3LYSVlbEsTvUuEXFG5jSZR1RXygH+xOJI22Y/Eb0yvq7C9KopZmB1acBq5V3rsCWX8ikaik9wXA2+fIC8yq
    3MD1+mG+hKvCBt3a0UrQjjOx5Fv+h57PwP7nghB7M4T9W6Eam+fARanoS5FyXD54INERIJo1G0CYMwukNvTK3VC/VKfif3M6r9oFGTwEiO+mqQLIAiQPNR7U
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=QcksHfuFLWVeGvaRyk4A:9
    a=CjuIK1q_8ugA:10 a=jDz1Lg8WPqQA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeDTUsf (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 16:48:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60510 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752683AbeDTUse (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 20 Apr 2018 16:48:34 -0400
Date: Fri, 20 Apr 2018 16:42:25 -0400
From: Richard Guy Briggs <rgb@redhat.com>
To: Paul Moore <paul@paul-moore.com>
Cc: simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        ebiederm@xmission.com, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com, viro@zeniv.linux.org.uk
Subject: Re: [RFC PATCH ghak32 V2 11/13] audit: add support for containerid
 to network namespaces
Message-ID: <20180420204225.iik2lgtj6gx2ep4w@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com>
 <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
 <CAHC9VhRkstDMjd5T3w+iOUDjzDAs1AOm0xd3p6v_xn6fNGYQhA@mail.gmail.com>
 <20180420200226.7tyxzuovdbgclw3m@madcap2.tricolour.ca>
 <CAHC9VhTOYUAyCJidm99som6FVmjouQUGsEHarQ4h_NhwJxQQfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhTOYUAyCJidm99som6FVmjouQUGsEHarQ4h_NhwJxQQfw@mail.gmail.com>
User-Agent: NeoMutt/20171027
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-20 16:22, Paul Moore wrote:
> On Fri, Apr 20, 2018 at 4:02 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> > On 2018-04-18 21:46, Paul Moore wrote:
> >> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> >> > Audit events could happen in a network namespace outside of a task
> >> > context due to packets received from the net that trigger an auditing
> >> > rule prior to being associated with a running task.  The network
> >> > namespace could in use by multiple containers by association to the
> >> > tasks in that network namespace.  We still want a way to attribute
> >> > these events to any potential containers.  Keep a list per network
> >> > namespace to track these container identifiiers.
> >> >
> >> > Add/increment the container identifier on:
> >> > - initial setting of the container id via /proc
> >> > - clone/fork call that inherits a container identifier
> >> > - unshare call that inherits a container identifier
> >> > - setns call that inherits a container identifier
> >> > Delete/decrement the container identifier on:
> >> > - an inherited container id dropped when child set
> >> > - process exit
> >> > - unshare call that drops a net namespace
> >> > - setns call that drops a net namespace
> >> >
> >> > See: https://github.com/linux-audit/audit-kernel/issues/32
> >> > See: https://github.com/linux-audit/audit-testsuite/issues/64
> >> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> >> > ---
> >> >  include/linux/audit.h       |  7 +++++++
> >> >  include/net/net_namespace.h | 12 ++++++++++++
> >> >  kernel/auditsc.c            |  9 ++++++---
> >> >  kernel/nsproxy.c            |  6 ++++++
> >> >  net/core/net_namespace.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
> >> >  5 files changed, 76 insertions(+), 3 deletions(-)
> 
> ...
> 
> >> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> >> > index f6c5d33..d9f1090 100644
> >> > --- a/kernel/nsproxy.c
> >> > +++ b/kernel/nsproxy.c
> >> > @@ -140,6 +140,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
> >> >         struct nsproxy *old_ns = tsk->nsproxy;
> >> >         struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
> >> >         struct nsproxy *new_ns;
> >> > +       u64 containerid = audit_get_containerid(tsk);
> >> >
> >> >         if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
> >> >                               CLONE_NEWPID | CLONE_NEWNET |
> >> > @@ -167,6 +168,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
> >> >                 return  PTR_ERR(new_ns);
> >> >
> >> >         tsk->nsproxy = new_ns;
> >> > +       net_add_audit_containerid(new_ns->net_ns, containerid);
> >> >         return 0;
> >> >  }
> >>
> >> Hopefully we can handle this in audit_net_init(), we just need to
> >> figure out where we can get the correct task_struct for the audit
> >> container ID (some backpointer in the net struct?).
> >
> > I don't follow.  This needs to happen on every task startup.
> > audit_net_init() is only called when a new network namespace starts up.
> 
> Yep, sorry, my mistake.  I must have confused myself when I was
> looking at the code.
> 
> I'm thinking out loud here, bear with me ...
> 
> Assuming we move the netns/audit-container-ID tracking to audit_net,
> and considering we already have an audit hook in copy_process() (it
> calls audit_alloc()), would this be better handled by the
> copy_process() hook?  This ignores naming, audit_alloc() reuse, etc.;
> those can be easily fixed.  I'm just thinking of ways to limit our
> impact on the core kernel and leverage our existing interaction
> points.

The new namespace hasn't been cloned yet and this is the only function
where we have access to both namespaces, so I don't see how that could
work...

> paul moore

- RGB

--
Richard Guy Briggs <rgb@redhat.com>
Sr. S/W Engineer, Kernel Security, Base Operating Systems
Remote, Ottawa, Red Hat Canada
IRC: rgb, SunRaycer
Voice: +1.647.777.2635, Internal: (81) 32635
