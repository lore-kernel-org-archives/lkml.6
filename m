Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3351577-1517606329-2-10984309538794961365
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517606328; b=W5yu9d8Tip5vIgkAav+4/RdTFJnjUU7P3ZgAalmg24fxqmo
    zZgff4lTu81yPUUqiEcLYVMAVbqpRjjaILhuptShFwSoLp3YKdg41gYYrjwBNgs7
    HnX8kDmrKpjwR0WUvoDkcPnuDLRkzpv4XEhvGkTp5i4D7huRaEEYFjCfT/LBhkbM
    vhURS3VymLEU7+2FVuZuWA3mH7HPr+wW6Fs3uV4D8af2/ISVsiTNIe9skCoKU40t
    HcpIybmO7LcLy0qXOI/TY4QUIkxofe3jCB606Czts9KhH4PgHV+wADVwyCFF/a/A
    vLar77RBnvgLOJJ+F8NaxkvIefyR7NKy6mLr0Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517606328; bh=EXRPbC2ZHvb6E0Ivsafxv1mf3t9s71LJ7BXlqO
    SX44w=; b=by0dkSulVa5mKLHAkTJvnHX1a9VgigNxQcqZpUrmAS4ruzfP4G9vBI
    I4nAXQH0MwRDNhVNzn+HYNX/d0zJLP9HGJwC5wdTMzzzgxIj8O2ZVadies8nP61y
    F9ny9WpIP90qYHP1CU2conIsQ7lDMF3eK1ijhWhiC0zwKOXRPSK5W+9VfNw93Bhr
    xk9JoZxCcbA1X8izdM23Jm8sRHtrCYa46/QmeloCwWUTa5wh8NHkCFXZbWDYO1NO
    J3DFn1DhIg28/qNSOAoKMsfYQJdBdS7NO0mxyaQpn2VVYJ8+Yyr6Q+t8D2yHakau
    1Xnb4z0PRAjIV3rBRJY4OsFsNfETcK7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=YGq16x3z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FTS+kIpF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=YGq16x3z x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=FTS+kIpF;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeBBVSr (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 16:18:47 -0500
Received: from mail-lf0-f54.google.com ([209.85.215.54]:38266 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeBBVSo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 2 Feb 2018 16:18:44 -0500
X-Google-Smtp-Source: AH8x225wjddj+sKp21svBzuzsl0LZyw/aAXij0gRtLeXRBe/zTeyHJ+YVipq+43QG3MwT5oGgQgqBYQsZi579pxgPCc=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <1515514736.3239.10.camel@redhat.com>
References: <20180109121620.wi7dq2423ugsraqv@madcap2.tricolour.ca> <1515514736.3239.10.camel@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 2 Feb 2018 16:18:41 -0500
Message-ID: <CAHC9VhSMnG9=h8YrrV7uS3mDGpdD5tDUivmbsOiKrmgT-ZpFYA@mail.gmail.com>
Subject: Re: RFC(V3): Audit Kernel Container IDs
To: Simo Sorce <simo@redhat.com>
Cc: Richard Guy Briggs <rgb@redhat.com>, cgroups@vger.kernel.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux Audit <linux-audit@redhat.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Network Development <netdev@vger.kernel.org>,
        mszeredi@redhat.com, jlayton@redhat.com,
        "Carlos O'Donell" <carlos@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, trondmy@primarydata.com,
        Eric Paris <eparis@parisplace.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Jan 9, 2018 at 11:18 AM, Simo Sorce <simo@redhat.com> wrote:
> On Tue, 2018-01-09 at 07:16 -0500, Richard Guy Briggs wrote:

...

>> Changelog:
>>
>> (Upstream V3)
>> - switch back to u64 (from pmoore, can be expanded to u128 in future if
>>   need arises without breaking API.  u32 was originally proposed, up to
>>   c36 discussed)
>> - write-once, but children inherit audit container identifier and can
>>   then still be written once
>> - switch to CAP_AUDIT_CONTROL
>> - group namespace actions together, auxilliary records to namespace
>>   operations.
>>
>> (Upstream V2)
>> - switch from u64 to u128 UUID
>> - switch from "signal" and "trigger" to "register"
>> - restrict registration to single process or force all threads and
>>   children into same container
>
> I am trying to understand the back and forth on the ID size.

I'm just now getting a chance to read Richard's latest draft, but I
wanted to comment on this quickly.

There are two main reasons for keeping this a 32 or 64 bit integer:

1) After the initial "be able to associate audit events with a
container" stage, we are going to look into supporting multiple audit
daemons on the system so that you could run an audit daemon inside a
container and it would collect events generated by the container
(we're tentatively calling this "phase 2", feel free to insert your
own "magic happens" joke).  There are a lot things that need to happen
in phase two, one of these things is the addition of an audit event
routing mechanism that will send audit records to the right audit
daemons (the "host" daemon will always see everything), in order to do
this we will need to be able to quickly compare audit container IDs,
this means an integer.

2) Whatever we pick for an audit container ID it is going to be wrong
for at least one container orchestrator.  There is no "one" solution
here, so we are providing a small and flexible mechanism that higher
level orchestrators can use to provide a more complete solution.

> >From an orchestrator POV anything that requires tracking a node
> specific ID is not ideal.
>
> Orchestrators tend to span many nodes, and containers tend to have IDs
> that are either UUID or have a Hash (like SHA256) as identifier.

You're helping me prove my reason #2.

> The problem here is two-fold:
>
> a) Your auditing requires some mapping to be useful outside of the
> system.
> If you aggreggate audit logs outside of the system or you want to
> correlate the system audit logs with other components dealing with
> containers, now you need a place where you provide a mapping from your
> audit u64 to the ID a container has in the rest of the system.

Yep, see my reason #2.  I want us to have something that "works" for a
single system as well as something that can be leveraged by higher
level tools for large networks of machines.

I realize it's easy, and tempting, to expand the scope of this effort;
but if we are to have any success it is only going to be through some
discipline.  We need to focus on a small solution which addresses the
basic needs and hopefully remains flexible enough for any potential
expansion while staying palatable to the audit folks and the general
kernel community.

> b) Now you need a mapping of some sort. The simplest way a container
> orchestrator can go about this is to just use the UUID or Hash
> representing their view of the container, truncate it to a u64 and use
> that for Audit. This means there are some chances there will be a
> collision and a duplicate u64 ID will be used by the orchestrator as
> the container ID. What happen in that case ?

That is a design decision left to the different container orchestrators.

-- 
paul moore
www.paul-moore.com
