Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2399110-1518598820-2-11179678515606439252
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518598819; b=BO/IcYkXS7LhYD0uZAXfEuc9o6nuF0xsHUX1lyxyXMFiq7X
    8xbj5uP2JZ+sGA1sXczNPsr53Tnna8JcBPZaxsd8hzR7xx00+uC52xiK1fsTzBT3
    ZDf+8/RIa7S9aD0SRV3OYxSG62rVBZ8NbsW/5/C5PgBGQgMhsP+mvRpHpWuevqpq
    Qj1xaYFIwc4AtxqOb03nDdfl05SCWCmUILi2R1A4qd6F87OLJsyv09f8BRC8F9Gy
    Zl10T0fwKzbA9J8/XkG1AVVzmGvacpnK/O9DusJlq9lsjQ+cF4k5/0qSBk5I2Par
    AbD4AYZp10B12LYlRZ0EF+lJcT2uHRBpbsemgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518598819; bh=kaz461HWyMCRqmMsg16/7NtoYG5FI4J8XyXnJP
    wJTAA=; b=orrNqFHw339xdf2ewsOKeYuYQLe2eHsldOE6zTqHIFxMHR8tMc0hhJ
    c/+ZrWYjSNwVDzU2/EBBAEa+ehG+Ep7cn+TFaUx52LgBwRG50fZF5hxV1db5RA83
    6b9m6vJYA/mgaMWf/giTrOJCInwQBb7aXv8xhGoDUAz0MriXgYpCMN6RrFf9UfE6
    psYx1gaZmTMHr2T/9xz9fd2x+BSYWESGjeSv17As9De6q9G9Gnfe1yVnDA4QQDKX
    herHgivEF3JB8+er9MoyRbSg0RFqxQpbtE1VWfE0RU8BEex5FW7KYU8gJjQdr8dg
    Cq3d6Yn9JUX7lniCVL45QUME/bjYgg7A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fF6tnX5v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BNLFsqWC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=fF6tnX5v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=BNLFsqWC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754676AbeBNJAS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Feb 2018 04:00:18 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:47054 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbeBNJAR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 14 Feb 2018 04:00:17 -0500
X-Google-Smtp-Source: AH8x226P0oRyZxngvpB/QW9lap1tBdsuYa1w9nV0ik+2dWsWBsbBLORzhmT9eU8lzTcq2GC3/PpXLRhGH7jZrEEo/+8=
MIME-Version: 1.0
In-Reply-To: <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
References: <20171030124358.GF23278@quack2.suse.cz> <76a4d544-833a-5f42-a898-115640b6783b@alibaba-inc.com>
 <20171031101238.GD8989@quack2.suse.cz> <20171109135444.znaksm4fucmpuylf@dhcp22.suse.cz>
 <10924085-6275-125f-d56b-547d734b6f4e@alibaba-inc.com> <20171114093909.dbhlm26qnrrb2ww4@dhcp22.suse.cz>
 <afa2dc80-16a3-d3d1-5090-9430eaafc841@alibaba-inc.com> <20171115093131.GA17359@quack2.suse.cz>
 <CALvZod6HJO73GUfLemuAXJfr4vZ8xMOmVQpFO3vJRog-s2T-OQ@mail.gmail.com>
 <CAOQ4uxg-mTgQfTv-qO6EVwfttyOy+oFyAHyFDKTQsDOkQPyyfA@mail.gmail.com>
 <20180124103454.ibuqt3njaqbjnrfr@quack2.suse.cz> <CAOQ4uxhDpBBUrr0JWRBaNQTTaUeJ4=gnM0iij2KivaGgp1ggtg@mail.gmail.com>
 <CALvZod4PyqfaqgEswegF5uOjNwVwbY1C4ptJB0Ouvgchv2aVFg@mail.gmail.com>
 <CAOQ4uxhyZNghjQU5atNv5xtgdHzA75UayphCyQDzxjM8GDTv3Q@mail.gmail.com>
 <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com> <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 14 Feb 2018 11:00:15 +0200
Message-ID: <CAOQ4uxhRW=AN5UUHiWYaQp=Nw29ys_1Ak6ADCAvCLTUOqaYn6g@mail.gmail.com>
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
To: Shakeel Butt <shakeelb@google.com>
Cc: Jan Kara <jack@suse.cz>, Yang Shi <yang.s@alibaba-inc.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 12:20 AM, Shakeel Butt <shakeelb@google.com> wrote:
> On Tue, Feb 13, 2018 at 1:54 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>> On Tue, Feb 13, 2018 at 11:10 PM, Shakeel Butt <shakeelb@google.com> wrote:
[...]
>>>> The question is, do we need the user to also explicitly opt-in for
>>>> Q_OVERFLOW on ENOMEM with FAN_Q_ERR mark mask?
>>>> Should these 2 new APIs be coupled or independent?
>>>>
>>>
>>> Are there any error which are not related to queue overflows? I see
>>> the mention of ENODEV and EOVERFLOW in the discussion. If there are
>>> such errors and might be interesting to the listener then we should
>>> have 2 independent APIs.
>>>
>>
>> These are indeed 2 different use cases.
>> A Q_OVERFLOW event is only expected one of ENOMEM or
>> EOVERFLOW in event->fd, but other events (like open of special device
>> file) can have ENODEV in event->fd.
>>
>> But I am not convinced that those require 2 independent APIs.
>> Specifying FAN_Q_ERR means that the user expects to reads errors
>> from event->fd.
>>
>
> Can you please explain what you mean by 2 independent APIs? I thought
> "no independent APIs" means FAN_Q_ERR can only be used with
> FAN_Q_OVERFLOW and without FAN_Q_OVERFLOW, FAN_Q_ERR is ignored. Is
> that right or I misunderstood?
>

What I initially meant to say was, we actually consider several
behavior changes:
1. Charge event allocations to memcg of listener
2. Queue a Q_OVERFLOW event on ENOMEM of event allocation
3. Report the error to user on metadata->fd (instead of FAN_NOFD)
4. Allow non Q_OVERFLOW event to have negative metadata->fd.

#3 is applicable both to Q_OVERFLOW event and other events that
can't provide and open file descriptor for some reason (i.e. ENODEV).

#1 and #2 could be independent, but they both make sense together.
When enabling #1 user increases the chance of ENOMEM and therefore
#2 is desired. So if we are going to let distro/admin/programmer to
opt-in for what we believe to be a "change of behavior for the best", then
we could consider that opting-in  for #1 will also imply opting-in for #2
and #3 (as the means to report Q_OVERFLOW due to ENOMEM).

I guess we will need to allow user to opt-in to #4 and #3 by FAN_Q_ERR
mask flag to cover the ENODEV case independently from opting-in to
charging memcg.

How was I doing in the balance of adding clarity vs. adding confusion?

Thanks,
Amir.
