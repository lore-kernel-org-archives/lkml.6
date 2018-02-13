Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-965545-1518556255-3-15877955008304253654
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
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
    t=1518556253; b=L5Ee9pkiuhEuZr55UxnRlwR5PcYxNrWZPm67+zKkOIe1FWj
    Ig42LKsnI+mVpc4hVWTOhrcyqbsh6/rAKc2h8pFrTeCjk1JCpiCBVfr4LCt3a1dM
    XA9BTbtVvpLIaDGHT0gW+eAouV0H8nKdnbzlGMRoDlvt4hDA4rdFL28WdxVTTFXF
    //WUsTdikQsg1KHoFiLV63RsY+J8KQzGSmogHlSYTwT2LQylO9A31NOrJuXuwvlD
    DMDA6tVnc2uc+McZNuPuqx4fBe2UX9E1WiISlmQxXYK8jJKfYbKGTC2HbMlZXmMR
    9qrlIu+/9EgdjNQx6laNLog+ZkNShIr0A1x/sqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1518556253; bh=o6zcnm8bho5PuawgiSw3TA4CL9t7dBXnqdsgUD
    7KgnM=; b=bzz5n2lzIIin+ix1uIGJZcq51Fj+8ypfCrz3ufZkBtinPstSwAdrak
    xvZXGXnGOXEjGHROEcAGjv9S+Kub/0/KevDOk09x6VGCmXZkocD7nGcLLhqvTcJm
    o8kuXhImVKcXK66dgF5O1WMHtmpv3VTJBZMHEfPfULpR2JX1e19zuZnHm1MDVXq9
    T/L6DB8MaowUlxBgMSJBATSYWW9ghT4TQprNwtrvdBouGXNvQg3EJGKc6c9PZGFb
    BUDt5FSOcrfnDJoHXLbyAhLedAkVi76AMA2Ndui2pilpobQVmdvsGkb1Llpg8FtX
    Udchcd2319gimhdYf95Xwx3DLYJ0xrCQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Tdure8/k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wap1s3j8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=Tdure8/k x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Wap1s3j8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965818AbeBMVKw (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 16:10:52 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:39424 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965781AbeBMVKu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Feb 2018 16:10:50 -0500
X-Google-Smtp-Source: AH8x224H1zHbDHbtIdyzsjRNGRs6YW2u69ztAsI+Mtz3uJv42wRdVXlDDrFIn9bwcW+MZMHKmORXvEx7yvKzZ5PpG4c=
MIME-Version: 1.0
In-Reply-To: <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
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
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com> <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
From: Shakeel Butt <shakeelb@google.com>
Date: Tue, 13 Feb 2018 13:10:47 -0800
Message-ID: <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
To: Amir Goldstein <amir73il@gmail.com>
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

On Mon, Feb 12, 2018 at 10:30 PM, Amir Goldstein <amir73il@gmail.com> wrote:
> On Thu, Jan 25, 2018 at 10:36 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>> On Thu, Jan 25, 2018 at 10:20 PM, Shakeel Butt <shakeelb@google.com> wrote:
>>> On Wed, Jan 24, 2018 at 11:51 PM, Amir Goldstein <amir73il@gmail.com> wrote:
>>>>
>>>> There is a nicer alternative, instead of failing the file access,
>>>> an overflow event can be queued. I sent a patch for that and Jan
>>>> agreed to the concept, but thought we should let user opt-in for this
>>>> change:
>>>> https://marc.info/?l=linux-fsdevel&m=150944704716447&w=2
>>>>
>>>> So IMO, if user opts-in for OVERFLOW instead of ENOMEM,
>>>> charging the listener memcg would be non controversial.
>>>> Otherwise, I cannot say that starting to charge the listener memgc
>>>> for events won't break any application.
>>>>
>>>
>
> Shakeel, Jan,
>
> Reviving this thread and adding linux-api, because I think it is important to
> agree on the API before patches.
>
> The last message on the thread you referenced suggest an API change
> for opting in for Q_OVERFLOW on ENOMEM:
> https://marc.info/?l=linux-api&m=150946878623441&w=2
>
> However, the suggested API change in in fanotify_mark() syscall and
> this is not the time when fsnotify_group is initialized.
> I believe for opting-in to accounting events for listener, you
> will need to add an opt-in flag for the fanotify_init() syscall.
>

I thought the reason to opt-in "charge memory to listener" was the
risk of oom-killing the listener but it is now clear that there will
be no oom-kills on memcg hitting its limit (no oom-killing listener
risk). In my (not so strong) opinion we should only opt-in for
receiving the {FAN|IN}_Q_OVERFLOW event on ENOMEM but always charge
the memory for events to the listener's memcg if kmem accounting is
enabled.

> Something like FAN_GROUP_QUEUE  (better name is welcome)
> which is mutually exclusive (?) with FAN_UNLIMITED_QUEUE.
>

There is no need to make them mutually exclusive. One should be able
to request an unlimited queue limited by available memory on system
(with no kmem charging) or limited by limit of the listener's memcg
(with kmem charging).

> The question is, do we need the user to also explicitly opt-in for
> Q_OVERFLOW on ENOMEM with FAN_Q_ERR mark mask?
> Should these 2 new APIs be coupled or independent?
>

Are there any error which are not related to queue overflows? I see
the mention of ENODEV and EOVERFLOW in the discussion. If there are
such errors and might be interesting to the listener then we should
have 2 independent APIs.

> Another question is whether FAN_GROUP_QUEUE may require
> less than CAP_SYS_ADMIN? Of course for now, this is only a
> semantic change, because fanotify_init() requires CAP_SYS_ADMIN
> but as the documentation suggests, this may be relaxed in the future.
>

I think there is no need for imposing CAP_SYS_ADMIN for requesting to
charge self for the event memory.

thanks,
Shakeel
