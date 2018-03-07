Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816594-1520385715-2-12312254958044741451
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
    t=1520385715; b=GK2uiNN6LYWPfdTd8i0Y2ajZ/CrK/Qt5fVQUcwy5nYw0kjd
    YqI5jc9DNOrTD73AalkDlnLuVUjuz0XhqZWCjE33je64hNBMFZj5aBMwMyiM9P3l
    3iL85kPjmXURYNwInMXNZIrMiOXuTy/sx8cJv3gkQtNLs/IbGJEh4D3cTDDFBRFI
    io34ZdZn/fXdXTuGq8nLvucbb+5u2PM7fNMD9m1N6hixLi5Ug/bSdrDSN4QaqDv6
    ObNiJMYoKDIYoFAmMrGZu9PPp3vxc75q73+xKzIqJSoLfgd0kojs3ckuVdOg5haZ
    KAuvIrA6eGLpWu1SJoCirKxuvi1pJFptOU3tJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520385715; bh=N45Md4Ko/1I0uWrclgw24Fq5oew+U2mBXjladzS2ooM=; b=j
    ceiFKVvQ74zoAPh3I0INtR1rLeANB9NIJT1YvInPN2bcK3uEZC7Y5/7s+kkHWVcz
    P8d89AJm/aSWbZ3Z3Stelyb5qUtp/DmqfjfSR74r3jbtXBuNqafmp48XK4SLlaUC
    uvg5pfx+DQSksElWb0P+x4UHFPLTlnX1jHeLAjgwEX01TdCyugMVDomDVC3cVdIz
    Ym0sWDlEEG2HE2+onGR1nBz4aZ59j9yPpDN5ODXdDToBuiO9jHAUsXoz52DfGo3A
    rE0VZjbGjvy+w+P8cbWFvFs0k+b6LUYBh2/640Gv2TjhLBjKk0ZmdyooXCmqIXHz
    Mc9bJ2dgzD0+n5qB7xThQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=q1lC2X6w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GwIv2C7h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=q1lC2X6w x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GwIv2C7h;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933183AbeCGBVe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 20:21:34 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:50490 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933236AbeCGBVd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 20:21:33 -0500
X-Google-Smtp-Source: AG47ELuEtriKuli9OMt1hKzYFmqagUjni3S8P1QhCh9LWDGA+RSaohgVW0Rb0tjwROtsqfRVcJ5uKN2jRSJHEQsULIg=
MIME-Version: 1.0
In-Reply-To: <7082be04-d6af-b853-4bb7-f331836662e2@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net> <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net> <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
 <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net> <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
 <20180306224636.wf5z3kujtc7r5qyh@cisco> <7082be04-d6af-b853-4bb7-f331836662e2@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 7 Mar 2018 01:21:11 +0000
Message-ID: <CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged sandboxing
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Tycho Andersen <tycho@tycho.ws>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Thomas Graf <tgraf@suug.ch>, Will Drewry <wad@chromium.org>,
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

On Tue, Mar 6, 2018 at 11:06 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>=
 wrote:
>
> On 06/03/2018 23:46, Tycho Andersen wrote:
>> On Tue, Mar 06, 2018 at 10:33:17PM +0000, Andy Lutomirski wrote:
>>>>> Suppose I'm writing a container manager.  I want to run "mount" in th=
e
>>>>> container, but I don't want to allow moun() in general and I want to
>>>>> emulate certain mount() actions.  I can write a filter that catches
>>>>> mount using seccomp and calls out to the container manager for help.
>>>>> This isn't theoretical -- Tycho wants *exactly* this use case to be
>>>>> supported.
>>>>
>>>> Well, I think this use case should be handled with something like
>>>> LD_PRELOAD and a helper library. FYI, I did something like this:
>>>> https://github.com/stemjail/stemshim
>>>
>>> I doubt that will work for containers.  Containers that use user
>>> namespaces and, for example, setuid programs aren't going to honor
>>> LD_PRELOAD.
>>
>> Or anything that calls syscalls directly, like go programs.
>
> That's why the vDSO-like approach. Enforcing an access control is not
> the issue here, patching a buggy userland (without patching its code) is
> the issue isn't it?
>
> As far as I remember, the main problem is to handle file descriptors
> while "emulating" the kernel behavior. This can be done with a "shim"
> code mapped in every processes. Chrome used something like this (in a
> previous sandbox mechanism) as a kind of emulation (with the current
> seccomp-bpf ). I think it should be doable to replace the (userland)
> emulation code with an IPC wrapper receiving file descriptors through
> UNIX socket.
>

Can you explain exactly what you mean by "vDSO-like"?

When a 64-bit program does a syscall, it just executes the SYSCALL
instruction.  The vDSO isn't involved at all.  32-bit programs usually
go through the vDSO, but not always.

It could be possible to force-load a DSO into an entire container and
rig up seccomp to intercept all SYSCALLs not originating from the DSO
such that they merely redirect control to the DSO, but that seems
quite messy.
