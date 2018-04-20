Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2475615-1524255770-2-11995371695956496773
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
    1524255770; b=omk5PUYW+rnpZylFFc3OxVZZm5HEeipNBCAuye9DYH1qIYl8Rx
    GK0sLn9rH4ubYlR/crKowm19o6Y99QUAm4E6bjoxwVWm3ah8JjRLftKqVWCmDq1n
    EdEeQw/4w8QBX7dMozsWrQJDTr1lw+WC1T0f3R1TDGTbHUiINPLiPQU6ojrdNXVm
    sk9KDFx5Xc7M7gJUr+azVQQ/4WxaXIMsTt6Qv56aQLfBkp7SuYdC70UOGQJ0tGBn
    UzJwnkb3Vf6y3bX1tzpZYEAxkLlWmYnyKz+ItUXsVbZCAE1GsDbnKgUAiclMhiSG
    6gTcUFpw/iRdqDmjxftHklUVaRYS5X6i2d1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524255770; bh=gs3zZbnp8VX7JZkHdvzJiXUkvX4rgouK3T1vZM7vLe
    g=; b=gz9IWgb9iQX0K5Tj7lkjd3GaHMd70KaozkqGeDtxOFiceBTKpvrpoNIJUH
    oVBtTXwz0k0D/LWy313htD93gv6QQY7cCycevzxPHUl6wLaS+j7VRhIICd6EXz0E
    ICVwfpm8Tt2zu5ifAlWf3QlAUuMt68oBef2CffUpgCLE00poFAbCjM0e3zU5EbWK
    y3v9y4Aigg/nOKlUJuMFCyB1lUhC79rfSpQqa8RoxFICpblxgAl6eFweyWbjUzZz
    N2CMhpVS+JGxRIh9VnaEtqEEvYLk4hWZSDGJVv1+TxWsv+HKdxMdNVccpmRsuJdB
    Lk9vqN62KJwHwzlMjyH55gxl9C1g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=iTUwY8Ug x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dnTme/Bp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=iTUwY8Ug x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dnTme/Bp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOgdjvfnLA6Lky1WgPArAuX3fiIFk+xOn1RlC4bWaPiEFCRNhARfkJEn85nu40Rl+s4EYkhpxstnGCTMFqEC7wSFdQVVEjAvab0Pc+pKz02BZUMsou3q
    O1U+7WGwh3ijfC6uK4fZpGAAH3ObW6IVRehR+kKa01E1O95rAmAwYLyziFSaQhv2qFh5h8G0C/Ijfj3GjfLoQAh2pQhdY/pVF12f2pQkOuUVWgLimzIvlSl5
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=NEAV23lmAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=MFB5GGBsn9crlFb6g8AA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbeDTUWX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 16:22:23 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34730 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbeDTUWV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 16:22:21 -0400
X-Google-Smtp-Source: AB8JxZqSqvlfPuXlRTexOrGhubmokGxQtl0NmgQ0QWR9QibviCl4yThDVeitcZg80bztuUOxPvBQKiAAZD535r9pk0g=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180420200226.7tyxzuovdbgclw3m@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <11b43a498e768a14764594c808a96b34d52be0af.1521179281.git.rgb@redhat.com>
 <CAHC9VhRkstDMjd5T3w+iOUDjzDAs1AOm0xd3p6v_xn6fNGYQhA@mail.gmail.com> <20180420200226.7tyxzuovdbgclw3m@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Apr 2018 16:22:18 -0400
Message-ID: <CAHC9VhTOYUAyCJidm99som6FVmjouQUGsEHarQ4h_NhwJxQQfw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 11/13] audit: add support for containerid to
 network namespaces
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

On Fri, Apr 20, 2018 at 4:02 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-18 21:46, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Audit events could happen in a network namespace outside of a task
>> > context due to packets received from the net that trigger an auditing
>> > rule prior to being associated with a running task.  The network
>> > namespace could in use by multiple containers by association to the
>> > tasks in that network namespace.  We still want a way to attribute
>> > these events to any potential containers.  Keep a list per network
>> > namespace to track these container identifiiers.
>> >
>> > Add/increment the container identifier on:
>> > - initial setting of the container id via /proc
>> > - clone/fork call that inherits a container identifier
>> > - unshare call that inherits a container identifier
>> > - setns call that inherits a container identifier
>> > Delete/decrement the container identifier on:
>> > - an inherited container id dropped when child set
>> > - process exit
>> > - unshare call that drops a net namespace
>> > - setns call that drops a net namespace
>> >
>> > See: https://github.com/linux-audit/audit-kernel/issues/32
>> > See: https://github.com/linux-audit/audit-testsuite/issues/64
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  include/linux/audit.h       |  7 +++++++
>> >  include/net/net_namespace.h | 12 ++++++++++++
>> >  kernel/auditsc.c            |  9 ++++++---
>> >  kernel/nsproxy.c            |  6 ++++++
>> >  net/core/net_namespace.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
>> >  5 files changed, 76 insertions(+), 3 deletions(-)

...

>> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
>> > index f6c5d33..d9f1090 100644
>> > --- a/kernel/nsproxy.c
>> > +++ b/kernel/nsproxy.c
>> > @@ -140,6 +140,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>> >         struct nsproxy *old_ns = tsk->nsproxy;
>> >         struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
>> >         struct nsproxy *new_ns;
>> > +       u64 containerid = audit_get_containerid(tsk);
>> >
>> >         if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
>> >                               CLONE_NEWPID | CLONE_NEWNET |
>> > @@ -167,6 +168,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
>> >                 return  PTR_ERR(new_ns);
>> >
>> >         tsk->nsproxy = new_ns;
>> > +       net_add_audit_containerid(new_ns->net_ns, containerid);
>> >         return 0;
>> >  }
>>
>> Hopefully we can handle this in audit_net_init(), we just need to
>> figure out where we can get the correct task_struct for the audit
>> container ID (some backpointer in the net struct?).
>
> I don't follow.  This needs to happen on every task startup.
> audit_net_init() is only called when a new network namespace starts up.

Yep, sorry, my mistake.  I must have confused myself when I was
looking at the code.

I'm thinking out loud here, bear with me ...

Assuming we move the netns/audit-container-ID tracking to audit_net,
and considering we already have an audit hook in copy_process() (it
calls audit_alloc()), would this be better handled by the
copy_process() hook?  This ignores naming, audit_alloc() reuse, etc.;
those can be easily fixed.  I'm just thinking of ways to limit our
impact on the core kernel and leverage our existing interaction
points.

-- 
paul moore
www.paul-moore.com
