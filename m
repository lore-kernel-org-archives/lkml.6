Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2032044-1524241301-2-17870341368023022843
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
    1524241300; b=WYSlqptongDi3p8V17yhWcZMs3pXauhLS2y5iZql0+rXewXYvZ
    4Y2EaHae1p3sbKe791E3N2q/dxrZC8WRlx+nZ/ZTzHOiWmfPkNFIbV2cUY+G8tSQ
    L4NN6Z32LH8MKac6D2Z1K0GU6FpzKq5sCbiQsvK6JCiSeu2VE9WfacFDcGT/NvEY
    NI50dsFL2a8lbEv5tWo4bkCb3xqj89VX7BLMVbNUUf6eUxca8UeD6dBBqQJfAMvj
    pzM0Xnjh0oAVNPW16dXh3F/Z3Ak46d6jdPL3HOgLNg2RNilgM668zvs9xxXvYCd7
    KaCH4S9VuM++7L3cOyikTNcR8HL0V5vfoeiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524241300; bh=8e8b+6NEVQif8egwiyr2ZaJbb5JOjckn4A90P3GbVf
    k=; b=nR1KW/ZdA9B0rSONMiEcqQBYcBOMSydVIKirS26scCKzhmlLc9WAcz6rz8
    L4vKtSlpsFdS9UpBJdR4JY14TLEH6B4igBiri++mCzV3QPKs59uBGO6QKyOU5Y4N
    skwjFNYoZKndYBxigZStr6zG9/mvebhDo+po2w7MpkSFUkrt9lOrgxnpVn4mlwGv
    9K2NKDEJfBSrEdKmVy/I0hNKumVPZXQbrP2HKSfty6wecWETTnROYbjbno5jBwml
    sWS3UUm9YTP4zoK1NQC6c8k1DYCgXlcE4l71wQr7+dLh5k+tBu1uHUgsSbUNO/3K
    +ZrVHUbWUwthObGSqxc57yJ+BWxA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=HHUxz6Ot x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ol+hQcIb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=HHUxz6Ot x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=ol+hQcIb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH36Y+rkwUQ4y4Mn7/fKTuqllWFDW/OxChIpvCwkSNpAlc3sXjeyDIEKuyG4DOejRmqi5HPIV2b5MwGq7hQRQUwNYro/ihdlrNM6rzi/c8l84Ohh+ZMw
    10/ydWWbNTsTMdPHQ/TMATBSJ+XYszPtThrgOAp2xFNHjuslEFOx3D6KD3P/ZmtiVEbkTC6Iraa8aLYTYTVY6lPhMJ+6JhSXWvkPMyTBid1Fw/sZAkFzOQIh
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=3TohEddqfK6R_iPe8JAA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752085AbeDTQVh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 12:21:37 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33788 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTQVf (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 12:21:35 -0400
X-Google-Smtp-Source: AIpwx48FN/EtnlLNo3z0y7H0uhCCw1kgEV1O3tCKqZgmcKH2mgEjhobV4lhdVljzG7+1CUet30Br3u6muxTm2Vy0TYE=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180420012346.udnga5pfdjoazcfc@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <ee2a945fb09a939b3c214f45e49dab6a770d83e6.1521179281.git.rgb@redhat.com>
 <CAHC9VhQbPbnrbxCD1fyTSxWgrXXXYnZw_=nbOhfMCO5Q5eSsWQ@mail.gmail.com> <20180420012346.udnga5pfdjoazcfc@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Apr 2018 12:21:33 -0400
Message-ID: <CAHC9VhRe2UMmwcdPfDs5wLdg8JjL7U+711LAR=URS=7rBGjw2A@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 06/13] audit: add support for non-syscall
 auxiliary records
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

On Thu, Apr 19, 2018 at 9:23 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-18 20:39, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Standalone audit records have the timestamp and serial number generated
>> > on the fly and as such are unique, making them standalone.  This new
>> > function audit_alloc_local() generates a local audit context that will
>> > be used only for a standalone record and its auxiliary record(s).  The
>> > context is discarded immediately after the local associated records are
>> > produced.
>> >
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  include/linux/audit.h |  8 ++++++++
>> >  kernel/auditsc.c      | 20 +++++++++++++++++++-
>> >  2 files changed, 27 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/audit.h b/include/linux/audit.h
>> > index ed16bb6..c0b83cb 100644
>> > --- a/include/linux/audit.h
>> > +++ b/include/linux/audit.h
>> > @@ -227,7 +227,9 @@ static inline int audit_log_container_info(struct audit_context *context,
>> >  /* These are defined in auditsc.c */
>> >                                 /* Public API */
>> >  extern int  audit_alloc(struct task_struct *task);
>> > +extern struct audit_context *audit_alloc_local(void);
>> >  extern void __audit_free(struct task_struct *task);
>> > +extern void audit_free_context(struct audit_context *context);
>> >  extern void __audit_syscall_entry(int major, unsigned long a0, unsigned long a1,
>> >                                   unsigned long a2, unsigned long a3);
>> >  extern void __audit_syscall_exit(int ret_success, long ret_value);
>> > @@ -472,6 +474,12 @@ static inline int audit_alloc(struct task_struct *task)
>> >  {
>> >         return 0;
>> >  }
>> > +static inline struct audit_context *audit_alloc_local(void)
>> > +{
>> > +       return NULL;
>> > +}
>> > +static inline void audit_free_context(struct audit_context *context)
>> > +{ }
>> >  static inline void audit_free(struct task_struct *task)
>> >  { }
>> >  static inline void audit_syscall_entry(int major, unsigned long a0,
>> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> > index 2932ef1..7103d23 100644
>> > --- a/kernel/auditsc.c
>> > +++ b/kernel/auditsc.c
>> > @@ -959,8 +959,26 @@ int audit_alloc(struct task_struct *tsk)
>> >         return 0;
>> >  }
>> >
>> > -static inline void audit_free_context(struct audit_context *context)
>> > +struct audit_context *audit_alloc_local(void)
>> >  {
>> > +       struct audit_context *context;
>> > +
>> > +       if (!audit_ever_enabled)
>> > +               return NULL; /* Return if not auditing. */
>> > +
>> > +       context = audit_alloc_context(AUDIT_RECORD_CONTEXT);
>> > +       if (!context)
>> > +               return NULL;
>> > +       context->serial = audit_serial();
>> > +       context->ctime = current_kernel_time64();
>> > +       context->in_syscall = 1;
>> > +       return context;
>> > +}
>> > +
>> > +inline void audit_free_context(struct audit_context *context)
>> > +{
>> > +       if (!context)
>> > +               return;
>> >         audit_free_names(context);
>> >         unroll_tree_refs(context, NULL, 0);
>> >         free_tree_refs(context);
>>
>> I'm reserving the option to comment on this idea further as I make my
>> way through the patchset, but audit_free_context() definitely
>> shouldn't be declared as an inline function.
>
> Ok, I think I follow.  When it wasn't exported, inline was fine, but now
> that it has been exported, it should no longer be inlined ...

Pretty much.  Based on a few comments I've seen by compiler folks over
the years, my current thinking is that we shouldn't worry about
explicit inlining static functions in C files (header files are a
different story).  The basic idea being that the compiler almost
always does a better job than us stupid developers.

> ... or should use
> an intermediate function name to export so that local uses of it can
> remain inline.

Possibly, but my guess is that the compiler could (will?) do that by
itself for code that lives in the same file.

-- 
paul moore
www.paul-moore.com
