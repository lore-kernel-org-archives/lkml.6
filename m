Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1694581-1524098827-2-67737418638196568
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
    1524098826; b=ws7E0VU8d+5KJW0sdzHtNpJ0/fmjxFK2gug3BmIuBymV4NKU94
    VEmCHhoqvkwBni0QKoqtOv8s2H16ouMBJ+g0n03+j6H2hftjBaj1X75l0KlOiVNN
    sF8XCCDcyUS3x22ZEM2552FD7m1wCi8kJoRx4k2mv+npnatjO9cbBWAXqwx8B1pz
    op8nP6ZRjlJ/GXfu9vDqnN+w9ZfU45Km0y5dWuLuXtIhkn3oiYMrL7dags/p+Vve
    ZhAYZ+jWYysDhua5xtBGd/o0ODOuUFoy2+1AFosxPv4EY0d7HqoHWrdz8uzOzOYF
    1pgWBU1jsoOMo21qGC+ejXnSllSpBHD8jeQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524098826; bh=+KDqy46Px77GQyj8ZicctdUWWjQySjizhYmGPp3G8M
    I=; b=otF8HI5Q5oRJXdxs2nSRdtnlqxFzUWOBlV6qf9Pa3JnlE6i8a4v8XxeAfz
    R+s193848KCw6ZajwuCVp1Do06DPYg/QeZ0LXrwnLeJA2BNG9Ql5jMm1TnRDzQj4
    krVdaKd1VnrQdyeX+o964k3eTJ2rcDPRyBx9z9v74T2johp7tdIM+fwkgDUxrX1i
    Ttqwphl0Di8wkRQ0Xin+wxIKXztiv6Wy/3jcrDJPtLGdoc6fbaKU9LZMBU2FS0x5
    oHuvARKyHk5KzsIUEH3Fg21bp9gb/o/RL1Q/BZifXCLlK+Vpj1MlPrmuCe4lwzV+
    hneNG7EkM9YewbiHnyH+gU/nF+Pw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=uTG6NZf5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=koXm1xEn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=uTG6NZf5 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=koXm1xEn;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJZytZQvbq8v7yhyBDoqEZ+cnN0CXKXi2AfgtViMDdvVhCEd8MArbpXoSz3Kp9dZucx+J9KVUPRefIJTgBLU3gOYP5feimXOMLKYRResa4K9lgvEboFU
    RqU3hKwEiOKhRS4KATn87Bq6PrcJVofieakmvfnkodrISJwUrTUMlGAYOH4J8WR++iO7xnC/0+LRrr8XxpSjb0Ekm4aWarxbg1YU5lW6In4eiUCZYHypYZXM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=vpqfxihKAAAA:8 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8
    a=VwQbUJbxAAAA:8 a=VWRE0PYZzb2vyAjLVCQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AULIiLoY-XQsE5F6gcqX:22 a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDSAqu (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:46:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:41812 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753097AbeDSAqr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:46:47 -0400
X-Google-Smtp-Source: AIpwx4/+NJiGGaIzJpa8B9hhTp0IMOyLspH4xJvXy5LYESvB2tkkheFSNEXKgeDkuF9OJAnbnAwvKk58Pzrxm+iN+bw=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <32d3e7a6-36f0-571a-bb91-67f746c7eafa@schaufler-ca.com>
References: <cover.1521179281.git.rgb@redhat.com> <e284617ad667ad8f17958dd8babb87fe1b4d7205.1521179281.git.rgb@redhat.com>
 <CAHC9VhTyvxxj2e2Gn+iyW6iLLeYB7hp8a+JvfeMmJ2nUPqtEaw@mail.gmail.com> <32d3e7a6-36f0-571a-bb91-67f746c7eafa@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 20:46:45 -0400
Message-ID: <CAHC9VhTz-pr-iUVv-+R3ShwEKSHDsweDGuN7255HV7Cu3ZYPEw@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 01/13] audit: add container id
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
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

On Wed, Apr 18, 2018 at 8:41 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 4/18/2018 4:47 PM, Paul Moore wrote:
>> On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
>>> Implement the proc fs write to set the audit container ID of a process,
>>> emitting an AUDIT_CONTAINER record to document the event.
>>> ...
>>>
>>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>>> index d258826..1b82191 100644
>>> --- a/include/linux/sched.h
>>> +++ b/include/linux/sched.h
>>> @@ -796,6 +796,7 @@ struct task_struct {
>>>  #ifdef CONFIG_AUDITSYSCALL
>>>         kuid_t                          loginuid;
>>>         unsigned int                    sessionid;
>>> +       u64                             containerid;
>> This one line addition to the task_struct scares me the most of
>> anything in this patchset.  Why?  It's a field named "containerid" in
>> a perhaps one of the most widely used core kernel structures; the
>> possibilities for abuse are endless, and it's foolish to think we
>> would ever be able to adequately police this.
>
> If we can get the LSM infrastructure managed task blobs from
> module stacking in ahead of this we could create a trivial security
> module to manage this. It's not as if there aren't all sorts of
> interactions between security modules and the audit system already.

While yes, there are plenty of interactions between the two, it is
possible to use audit without the LSMs and I would like to preserve
that.  Further, I don't want to entangle two very complicated code
changes or make the audit container ID effort dependent on LSM
stacking.

You're a good salesman Casey, but you're not that good ;)

-- 
paul moore
www.paul-moore.com
