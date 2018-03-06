Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1470797-1520375638-2-3622142741661333123
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520375637; b=I+flpS2mjSsX2DSXuctjMH38u3ZjHgaHzJDjqqzRtChLtig
    ECn3VX2Ff89nyr9rpZSoDCEiEz1VIHH6ShggywpTTVnvon36rYj4RpNeV0hcQd6v
    LKGPjJlXideS1mTvE9E0gfaLH5yihY2IWq7cIHRpqnP2z0eWqzITHN8oraJ9chGh
    pSrnSOXMlBnLlm4JIrLdOyKjvccUlxDreYyoUfGEMqZcl4IqfB5umT7ipCFAvpTc
    Y7WnGtyzEtkXrAMbE+kM0R/7rkJ9cnwEOxunC43RPpgtjIWX2bunYs/lvpXr8pwF
    odGPPO63IkY/Zy9o/BlTd4ftLXZ8ZwVeSpbEZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520375637; bh=BM2OLUr+QeC6B12ubG4zKDzhlB4/2MC08NFmi6/5T9g=; b=E
    +Qq+cG2wzy+/z7sJ8ZNwSg/eNjryUeLNq5KMmEzjojcFmVlSoSJSLBYCUQ1B+nqQ
    7XtADWblW9rd3+0nU4veghrnVsorC1qvsj4ubZKgU6Tdf7OHkpiPbPU/B7qdczRe
    TGwtcJcHi8iiI7Wsbm+tPhM/QmMEcUMNLVfjn4K4zBH2TA7INweU0ogGBMgDom9G
    phDLSaq1QGVBiiqrBfohEKKni6doAw5CczlFNcxQYP59HKAnTZtXYtR9GgzwIOVl
    SFxQjLkUIzMQE4hybwClsozQ+9JSs6SNbvLgBUa0+SqEGbxHrGZ3UGQYqOfkeFNh
    kUx/LGVFLJbC6WFoBVc8g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=Ts9+hnyK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bkn1hBaS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=Ts9+hnyK x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=bkn1hBaS;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754232AbeCFWdk (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 17:33:40 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:38796 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754213AbeCFWdi (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 17:33:38 -0500
X-Google-Smtp-Source: AG47ELsjLY6hjXTOJNgM876V2nZlqui3DEH0MEuh970aWZIBJoAl35qi6+rjP/yTOynQ6WFENrBPIpvfjAMBE3VSv3M=
MIME-Version: 1.0
In-Reply-To: <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net> <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net> <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
 <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 6 Mar 2018 22:33:17 +0000
Message-ID: <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged sandboxing
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>,
        Jann Horn <jann@thejh.net>, Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
        Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
        Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 10:25 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
>
> On 28/02/2018 00:09, Andy Lutomirski wrote:
>> On Tue, Feb 27, 2018 at 10:03 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
>>>
>>> On 27/02/2018 05:36, Andy Lutomirski wrote:
>>>> On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>>>>> Hi,
>>>>>
>>
>>>>>
>>>>> ## Why use the seccomp(2) syscall?
>>>>>
>>>>> Landlock use the same semantic as seccomp to apply access rule
>>>>> restrictions. It add a new layer of security for the current process
>>>>> which is inherited by its children. It makes sense to use an unique
>>>>> access-restricting syscall (that should be allowed by seccomp filters=
)
>>>>> which can only drop privileges. Moreover, a Landlock rule could come
>>>>> from outside a process (e.g.  passed through a UNIX socket). It is th=
en
>>>>> useful to differentiate the creation/load of Landlock eBPF programs v=
ia
>>>>> bpf(2), from rule enforcement via seccomp(2).
>>>>
>>>> This seems like a weak argument to me.  Sure, this is a bit different
>>>> from seccomp(), and maybe shoving it into the seccomp() multiplexer is
>>>> awkward, but surely the bpf() multiplexer is even less applicable.
>>>
>>> I think using the seccomp syscall is fine, and everyone agreed on it.
>>>
>>
>> Ah, sorry, I completely misread what you wrote.  My apologies.  You
>> can disregard most of my email.
>>
>>>
>>>>
>>>> Also, looking forward, I think you're going to want a bunch of the
>>>> stuff that's under consideration as new seccomp features.  Tycho is
>>>> working on a "user notifier" feature for seccomp where, in addition to
>>>> accepting, rejecting, or kicking to ptrace, you can send a message to
>>>> the creator of the filter and wait for a reply.  I think that Landlock
>>>> will want exactly the same feature.
>>>
>>> I don't think why this may be useful at all her. Landlock does not
>>> filter at the syscall level but handles kernel object and actions as
>>> does an LSM. That is the whole purpose of Landlock.
>>
>> Suppose I'm writing a container manager.  I want to run "mount" in the
>> container, but I don't want to allow moun() in general and I want to
>> emulate certain mount() actions.  I can write a filter that catches
>> mount using seccomp and calls out to the container manager for help.
>> This isn't theoretical -- Tycho wants *exactly* this use case to be
>> supported.
>
> Well, I think this use case should be handled with something like
> LD_PRELOAD and a helper library. FYI, I did something like this:
> https://github.com/stemjail/stemshim

I doubt that will work for containers.  Containers that use user
namespaces and, for example, setuid programs aren't going to honor
LD_PRELOAD.

>
> Otherwise, we should think about enabling a process to (dynamically)
> extend/patch the vDSO (similar to LD_PRELOAD but at the syscall level
> and works with static binaries) for a subset of processes (the same way
> seccomp filters are inherited). It may be more powerful and flexible
> than extending the kernel/seccomp to patch (buggy?) userland.

Egads!
