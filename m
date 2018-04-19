Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3169877-1524144140-2-3056652006807197794
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524144139; b=u5/mOryUmmLDqkmUBbS8KKm+dyMk144KYbYhvrMD8xuixFLmfM
    vULEBvxle1AOZAw4YB7E6/FB/hWdfF9GN3IuxkVpSJPMGGW5STJHeHx46HgF73J1
    PlMOygRYnrtXRUqjKIaxtntCnAhmEDAEF3CzCruo8ptRachjtfBYeHC6UnV2dneP
    gfQtpOS9IRfkhCOt5UOEeIsbPr9PefXKBisfJ80P2rah8KStfmibSip1RSMeP078
    wAsl9QgQ5CZsYYC0NnG60ReTU6Iep7vyuQ4qA9JQMjOKlOYDlcv0RHKQbiRQ311R
    O6MUrsImw6dHwyM7Cy+4vz+5MwuO4tSvuwNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524144139; bh=ag2rXM8ZfMSe82ef/6DsKBa9GkRyPMBvR3NrEv4/TQ
    Q=; b=YjHuZcBDkIEmtY2mBdWGPBu5pXFwEC6fPYSG1Xc9JPCaTPxKpo5pJA0whi
    BLOd1B3j/INw/hiUe4Vf9hXAf0vhcTmcvx52pvtCAUtnXSJ1OoS7pfUUbkx2XIjM
    yKElNHvnJL4btyrVdHtrbnrDt5Y2KPvAc1mTmDK4+GbDh4ePQDMqpTRFiTO2k9HC
    /Balw20g1tL85M99PVXAZKP5DZQjef82Kxf+h8jB7K211e4QRgy/iV2dPJfkH1Op
    hOeWX1Dv6quF3MT+qndPLspyzRtToi88/nGPPV3YlgosmDxdVUTuBph5YqKqq30O
    fUmz1vP+rbl5TKORTO6QA2zY0Txw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=zlQYljks x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C4D1HBCU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=zlQYljks x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=C4D1HBCU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfILP/KApopU1NwAbDK0XxVXts7BiE3CaLPpsDCYZB8z4/rUqWXc2XtzUx9fEm92Uo0PCn7IlHUzi3Bfcw30TkJtPFoE7T4JeGGPsabKvyOorfNuj6dTG
    mbZ3EBD4BnnTnliES/hppYgz57HUnHDhn7WesbAxazgtfHzEt8d0bHhRnx95SIujWCF4dTo+NGfBfRAsHnYJIBsGcxUUHjyNzT+Et8wxbS0/zcdSIMaIeALt
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=AMgd9u1d1vS74DpBshsA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752640AbeDSNWR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 09:22:17 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41775 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeDSNWP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Apr 2018 09:22:15 -0400
X-Google-Smtp-Source: AIpwx4/vkuZWWlYeDcjgcKn8+YULNnNPZOhmP6OUGATDr6y+YJ3TOip+NdMf/5VWgeybcotMphwVwqrsFgEgiQKJJuo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180419124550.7uknp4oebvwoo67s@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <66adde01c1dda792aff99a457eea576a0b08ca98.1521179281.git.rgb@redhat.com>
 <CAHC9VhR3BNRr24BPxud0X_eyFmSxUOh9bwjWNU4Z=rnDR0fENA@mail.gmail.com> <20180419124550.7uknp4oebvwoo67s@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Apr 2018 09:13:17 -0400
Message-ID: <CAHC9VhSjvS81AZ55dtQVtuwJw1wSy2iJHyzERh9T6p0CR72ULA@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 12/13] audit: NETFILTER_PKT: record each
 container ID associated with a netNS
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 8:45 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-18 22:10, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Add container ID auxiliary record(s) to NETFILTER_PKT event standalone
>> > records.  Iterate through all potential container IDs associated with a
>> > network namespace.
>> >
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  kernel/audit.c           |  1 +
>> >  kernel/auditsc.c         |  2 ++
>> >  net/netfilter/xt_AUDIT.c | 15 ++++++++++++++-
>> >  3 files changed, 17 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/audit.c b/kernel/audit.c
>> > index 08662b4..3c77e47 100644
>> > --- a/kernel/audit.c
>> > +++ b/kernel/audit.c
>> > @@ -2102,6 +2102,7 @@ int audit_log_container_info(struct audit_context *context,
>> >         audit_log_end(ab);
>> >         return 0;
>> >  }
>> > +EXPORT_SYMBOL(audit_log_container_info);
>> >
>> >  void audit_log_key(struct audit_buffer *ab, char *key)
>> >  {
>> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> > index 208da962..af68d01 100644
>> > --- a/kernel/auditsc.c
>> > +++ b/kernel/auditsc.c
>> > @@ -975,6 +975,7 @@ struct audit_context *audit_alloc_local(void)
>> >         context->in_syscall = 1;
>> >         return context;
>> >  }
>> > +EXPORT_SYMBOL(audit_alloc_local);
>> >
>> >  inline void audit_free_context(struct audit_context *context)
>> >  {
>> > @@ -989,6 +990,7 @@ inline void audit_free_context(struct audit_context *context)
>> >         audit_proctitle_free(context);
>> >         kfree(context);
>> >  }
>> > +EXPORT_SYMBOL(audit_free_context);
>> >
>> >  static int audit_log_pid_context(struct audit_context *context, pid_t pid,
>> >                                  kuid_t auid, kuid_t uid, unsigned int sessionid,
>> > diff --git a/net/netfilter/xt_AUDIT.c b/net/netfilter/xt_AUDIT.c
>> > index c502419..edaa456 100644
>> > --- a/net/netfilter/xt_AUDIT.c
>> > +++ b/net/netfilter/xt_AUDIT.c
>> > @@ -71,10 +71,14 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>> >  {
>> >         struct audit_buffer *ab;
>> >         int fam = -1;
>> > +       struct audit_context *context = audit_alloc_local();
>> > +       struct audit_containerid *cont;
>> > +       int i = 0;
>> > +       struct net *net;
>> >
>> >         if (audit_enabled == 0)
>> >                 goto errout;
>>
>> Do I need to say it?  I probably should ... the allocation should
>> happen after the audit_enabled check.
>
> Already fixed in V3 in my tree a couple of weeks ago...

... which you never posted, at least not anywhere I've seen.  Which
effectively means I wasted a good chunk of time reviewing this code
late last night.  Awesome.

> More timely review please?

More patience on your part?

>> > -       ab = audit_log_start(NULL, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
>> > +       ab = audit_log_start(context, GFP_ATOMIC, AUDIT_NETFILTER_PKT);
>> >         if (ab == NULL)
>> >                 goto errout;
>> >
>> > @@ -104,7 +108,16 @@ static bool audit_ip6(struct audit_buffer *ab, struct sk_buff *skb)
>> >
>> >         audit_log_end(ab);
>> >
>> > +       net = sock_net(NETLINK_CB(skb).sk);
>> > +       list_for_each_entry(cont, &net->audit_containerid, list) {
>> > +               char buf[14];
>> > +
>> > +               sprintf(buf, "net%u", i++);
>> > +               audit_log_container_info(context, buf, cont->id);
>> > +       }
>>
>> It seems like this could (should?) be hidden inside an audit function,
>> e.g. audit_log_net_containers() or something like that.
>
> Perhaps...  It was open-coded since at this point there are no other
> users.  That'll make this tidier though.

If the code was all contained within a single subsystem them I would
generally agree that open coding is preferable, but since we are
crossing a subsystem boundary I think it would be preferable to
abstract away the details into a separate function.

This will probably also be necessary once you change to using the
audit_net/net_generic mechanism.

-- 
paul moore
www.paul-moore.com
