Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2022578-1524240676-2-15326308851213982602
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
    1524240675; b=kz/uwLdA0+H2ifzlfXljQCK4VXHNk/aX5pE40fYVeilLaG/35+
    e5h/kyQ0yos8lVqCrbF5f/VM7UXtwSQCopqzcaqJrzT3IRlXkhqRP6I2Qa6rglNY
    MTCwkbqvySxSFWdZeVfwp5lojTd4TMiHR8qSuRKbZoMGfJy998QpqxBnN+baVSy5
    eV8b74l6wYoCHHsgA7v/vM6CTqOU4J0vaOqmYXYhN8X2Mo8PZTfqB5irY1gxgvkf
    jNYVppkilAWeFe3fffBzKtJziLDRq7uY9/djSgZHBlG8likAVuYn5M3ts6JoBbjC
    8koq314MAfJme0uldxKkEP+85AK7/+fvZCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524240675; bh=pFsbjvDmPkg7cHmGcyOJhydo1Z9HsG2L+J3gqnq9NO
    k=; b=hmYDP90fWXa3LiYmfVusDIJOq97ALkS/SrijZeiujUrqGgNMa1K6vUgmOG
    EXovaOQOX3sFAjgrlTczL5B0X/FxZhagfJKw4i300Yh2Zerkq5l5naH0tiV7Os/f
    X7lANBi1VYFKQcEWtf0uYW+G95u0h9SQH7Gt6kFYG+WGx4XbqVM5uBrvRS4lCWMl
    N6ZopQNOCDTnTSN6PgIP8ZtVaMy8d3CD+aUACzZKTCEPhatMdKnzAki0oJIDfWiU
    JcEohJspPEclci6i2s5EgKKG7hakJVeQEENZJdxkTMBlInx47pSzK9m5im+/UrJz
    OUbP40eko8BuHxNN4sFmI13wHoBg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=E0emYWXc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g4Mwmk4W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=E0emYWXc x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=g4Mwmk4W;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNm0N+L/t9civcDOW8fNPiS/A0DDPzIFPR4ywEaWrhFj2YokSPgj33Po2pP1TrkCr3IvDLvpVBNKloX3jrdVbrR2DbVcm/jRWuzn1VKoFnF6OgJyO+AQ
    q9YeZkVygsaBDVgAOEKBYko5bP5KjOdb7UyxuY0L6kUhJ9SH9iPMpRLrZIJgtAV7CE1rhpHJAX/IiqLP3XphRseb0zzdzmb3QQMXIGOXj3LDVhN4aOBvmMeB
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=eK3bZVuwvPq4KtZJGdoA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeDTQLN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 12:11:13 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41083 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750858AbeDTQLM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 20 Apr 2018 12:11:12 -0400
X-Google-Smtp-Source: AIpwx494Hug258GPjZjNc/gYXDvUrTSz4jRSErS3cqWA0EijgliSTDBo9Mc9FCsVHsxgdukWXgzDjcsV18+yU3Ztfqo=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <20180420004218.tgndd474wgueyjzk@madcap2.tricolour.ca>
References: <cover.1521179281.git.rgb@redhat.com> <11174597083f89352f1d6491ec94e27f882625d9.1521179281.git.rgb@redhat.com>
 <CAHC9VhS6MKoLkzpfcmYBSNnvrtbL2FOF5PX9uOfivSVEWykkQg@mail.gmail.com> <20180420004218.tgndd474wgueyjzk@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 20 Apr 2018 12:11:09 -0400
Message-ID: <CAHC9VhS+QgCqdSvZuBY_wTqGK245BY8txFUugy=bx9K5aSroCQ@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 10/13] audit: add containerid support for
 seccomp and anom_abend records
To: Richard Guy Briggs <rgb@redhat.com>
Cc: simo@redhat.com, jlayton@redhat.com, carlos@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>, dhowells@redhat.com,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        ebiederm@xmission.com, luto@kernel.org, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        serge@hallyn.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 8:42 PM, Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-04-18 21:31, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>> > Add container ID auxiliary records to secure computing and abnormal end
>> > standalone records.
>> >
>> > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
>> > ---
>> >  kernel/auditsc.c | 10 ++++++++--
>> >  1 file changed, 8 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
>> > index 7103d23..2f02ed9 100644
>> > --- a/kernel/auditsc.c
>> > +++ b/kernel/auditsc.c
>> > @@ -2571,6 +2571,7 @@ static void audit_log_task(struct audit_buffer *ab)
>> >  void audit_core_dumps(long signr)
>> >  {
>> >         struct audit_buffer *ab;
>> > +       struct audit_context *context = audit_alloc_local();
>>
>> Looking quickly at do_coredump() I *believe* we can use current here.
>>
>> >         if (!audit_enabled)
>> >                 return;
>> > @@ -2578,19 +2579,22 @@ void audit_core_dumps(long signr)
>> >         if (signr == SIGQUIT)   /* don't care for those */
>> >                 return;
>> >
>> > -       ab = audit_log_start(NULL, GFP_KERNEL, AUDIT_ANOM_ABEND);
>> > +       ab = audit_log_start(context, GFP_KERNEL, AUDIT_ANOM_ABEND);
>> >         if (unlikely(!ab))
>> >                 return;
>> >         audit_log_task(ab);
>> >         audit_log_format(ab, " sig=%ld res=1", signr);
>> >         audit_log_end(ab);
>> > +       audit_log_container_info(context, "abend", audit_get_containerid(current));
>> > +       audit_free_context(context);
>> >  }
>> >
>> >  void __audit_seccomp(unsigned long syscall, long signr, int code)
>> >  {
>> >         struct audit_buffer *ab;
>> > +       struct audit_context *context = audit_alloc_local();
>>
>> We can definitely use current here.
>
> Ok, so both syscall aux records.  That elimintes this patch from the
> set, can go in independently.

Yep.  It should help shrink the audit container ID patchset and
perhaps more importantly it should put some distance between the
connected-record debate and the audit container ID debate.

I understand we are going to need a "local" context for some things,
the network packets are probably the best example, but whenever
possible I would like to connect these records back to a task's
context.

-- 
paul moore
www.paul-moore.com
