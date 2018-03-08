Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3120443-1520553222-2-9565934172786596040
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, T_TVD_MIME_EPI 0.01,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: from='UTF-8', plain='utf-8'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520553221; b=QJp0EGYYH4T6+tDmRJujvPhD9X2MDJAiGH4XgzNjR8w9Q4n
    1yI6gPKCVIwg725rA6VlJGQJ1g+yk/BR0OHLCLD6UGjAoYkKUMF9kRrCA2U/xmVb
    ll0/YB/uIXkxBKlRms4SqokAlUq90NwS4Z0b3Kl3D7kyMENShmfnTnrwYPxIlLeG
    WXzOKbXs/xvH5AyEQuDGUwr3cup1TQNuCu8yG5SAVUGr/Yhk0eF9lCGEzBApOzJL
    mirqzZ5Vk1B8q8DEsH6/HjwXEz1tX8SZYOWNSenitf4HqCRf5nDstv6WbT/gXG40
    iDsoszLtJO8DZoxb07v7jOE3wmQv0lt1uxCj68Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520553221; bh=+BnUEPhQGMzl2iqQRV4xoCxSbCoi+8pOA5dI2A
    vJ6tM=; b=F5+G0WOP77hZ90sr5CpslMMt0HnfCw6R65NTDoTXBReER+1Ol1F6zu
    wv0VA/7XlboTmaNDPUYcj6IchEDlvu6T7a2p4hl7Ui0lm2b0oizyUPvDf4g8t/gX
    YM/695f56vJ+SkORGvUv7SofcDNAAfp+F7e/2UxydhRamzn7UwyIs85d+n/KLmOb
    I+fOUVCHLw1rmuWd8D7COLTKPmUGqHJ1ezc4t6Se1Yx50jjwQLxqIt7A9PLiQtG3
    CHQWYtycaHaAQFUu9wG6N2L+kTth+w9WzQQL1WrfWCMlkQrVXbxXb3U28IoJejQf
    YGoS9pX1AaPbuUyIyXnUtamwSeEXIhfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbeCHXxW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 18:53:22 -0500
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:43082 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeCHXxU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 18:53:20 -0500
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
To: Andy Lutomirski <luto@amacapital.net>
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
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
 <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
 <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
 <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
 <20180306224636.wf5z3kujtc7r5qyh@cisco>
 <7082be04-d6af-b853-4bb7-f331836662e2@digikod.net>
 <CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <cd811155-9e0d-283a-9291-4adfcec848e6@digikod.net>
Date: Fri, 9 Mar 2018 00:51:51 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="r6BxumTg3uL0bNiir2lPR7tZALVVtIZ8D"
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6BxumTg3uL0bNiir2lPR7tZALVVtIZ8D
Content-Type: multipart/mixed; boundary="6AKbTuUXCFlZGfbDTtMAsaqAO7wsT7K6i";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Tycho Andersen <tycho@tycho.ws>, LKML <linux-kernel@vger.kernel.org>,
 Alexei Starovoitov <ast@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Daniel Borkmann <daniel@iogearbox.net>, David Drysdale
 <drysdale@google.com>, "David S . Miller" <davem@davemloft.net>,
 "Eric W . Biederman" <ebiederm@xmission.com>,
 James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
 Jonathan Corbet <corbet@lwn.net>, Michael Kerrisk <mtk.manpages@gmail.com>,
 Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
 Sargun Dhillon <sargun@sargun.me>, "Serge E . Hallyn" <serge@hallyn.com>,
 Shuah Khan <shuah@kernel.org>, Tejun Heo <tj@kernel.org>,
 Thomas Graf <tgraf@suug.ch>, Will Drewry <wad@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linux API <linux-api@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Message-ID: <cd811155-9e0d-283a-9291-4adfcec848e6@digikod.net>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
 <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
 <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
 <CALCETrUQYp0ta4tLgUWJ79pZVwp3WRY7cp-XaPcn1WyTc=wZyg@mail.gmail.com>
 <20180306224636.wf5z3kujtc7r5qyh@cisco>
 <7082be04-d6af-b853-4bb7-f331836662e2@digikod.net>
 <CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>
In-Reply-To: <CALCETrXT8JUXVwDNKGVRG7=aenthDRePD+T+YiDY6cceaazDeA@mail.gmail.com>

--6AKbTuUXCFlZGfbDTtMAsaqAO7wsT7K6i
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 07/03/2018 02:21, Andy Lutomirski wrote:
> On Tue, Mar 6, 2018 at 11:06 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
>>
>> On 06/03/2018 23:46, Tycho Andersen wrote:
>>> On Tue, Mar 06, 2018 at 10:33:17PM +0000, Andy Lutomirski wrote:
>>>>>> Suppose I'm writing a container manager.  I want to run "mount" in=
 the
>>>>>> container, but I don't want to allow moun() in general and I want =
to
>>>>>> emulate certain mount() actions.  I can write a filter that catche=
s
>>>>>> mount using seccomp and calls out to the container manager for hel=
p.
>>>>>> This isn't theoretical -- Tycho wants *exactly* this use case to b=
e
>>>>>> supported.
>>>>>
>>>>> Well, I think this use case should be handled with something like
>>>>> LD_PRELOAD and a helper library. FYI, I did something like this:
>>>>> https://github.com/stemjail/stemshim
>>>>
>>>> I doubt that will work for containers.  Containers that use user
>>>> namespaces and, for example, setuid programs aren't going to honor
>>>> LD_PRELOAD.
>>>
>>> Or anything that calls syscalls directly, like go programs.
>>
>> That's why the vDSO-like approach. Enforcing an access control is not
>> the issue here, patching a buggy userland (without patching its code) =
is
>> the issue isn't it?
>>
>> As far as I remember, the main problem is to handle file descriptors
>> while "emulating" the kernel behavior. This can be done with a "shim"
>> code mapped in every processes. Chrome used something like this (in a
>> previous sandbox mechanism) as a kind of emulation (with the current
>> seccomp-bpf ). I think it should be doable to replace the (userland)
>> emulation code with an IPC wrapper receiving file descriptors through
>> UNIX socket.
>>
>=20
> Can you explain exactly what you mean by "vDSO-like"?
>=20
> When a 64-bit program does a syscall, it just executes the SYSCALL
> instruction.  The vDSO isn't involved at all.  32-bit programs usually
> go through the vDSO, but not always.
>=20
> It could be possible to force-load a DSO into an entire container and
> rig up seccomp to intercept all SYSCALLs not originating from the DSO
> such that they merely redirect control to the DSO, but that seems
> quite messy.

vDSO is a code mapped for all processes. As you said, these processes
may use it or not. What I was thinking about is to use the same concept,
i.e. map a "shim" code into each processes pertaining to a particular
hierarchy (the same way seccomp filters are inherited across processes).
With a seccomp filter matching some syscall (e.g. mount, open), it is
possible to jump back to the shim code thanks to SECCOMP_RET_TRAP. This
shim code should then be able to emulate/patch what is needed, even
faking a file opening by receiving a file descriptor through a UNIX
socket. As did the Chrome sandbox, the seccomp filter may look at the
calling address to allow the shim code to call syscalls without being
catched, if needed. However, relying on SIGSYS may not fit with
arbitrary code. Using a new SECCOMP_RET_EMULATE (?) may be used to jump
to a specific process address, to emulate the syscall in an easier way
than only relying on a {c,e}BPF program.


--6AKbTuUXCFlZGfbDTtMAsaqAO7wsT7K6i--

--r6BxumTg3uL0bNiir2lPR7tZALVVtIZ8D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlqhzJcACgkQIt7+33O9
apWgVwgAl1dBFNgiitkw/hxWaEtKaPGCXPJigUT/86EJ0ZNqnQG3njJQCFaaVxal
2XJOqJHaniJ/P/B8JKgdzGlCWWGQOi7ZLWx6+RaN3pHc3YS1xzFNOIdcyxKa59OC
iqv79nIBCN1SFX9W7pV8qyRMmSDVteZHZ2UW/x2TsWv4PMCY1/AIdBOCOLPElF7G
qmhX0LpcrCpP6OqEi7YlTflNmKAx4WYV9oA5AERb15iyO6YN+111XyyJZmZDyNav
CwHJi1dFZ10AGSsYYUDlJ5UjNm8NMzS/HvFDcj5HwFUUvrkwhC7wirE1fuE+pSxu
dONxdFA8kw3AFG6g38ZL4eGkkVvswg==
=l9jE
-----END PGP SIGNATURE-----

--r6BxumTg3uL0bNiir2lPR7tZALVVtIZ8D--
