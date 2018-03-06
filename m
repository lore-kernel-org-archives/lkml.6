Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1470797-1520375217-2-14922531265690227135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
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
    t=1520375216; b=uK2Hqz6A68tcg1RRw6gQ/28jaM+J6JeuxwFAzxnJekWC0tO
    ZX3HAhYXTgsVY9TYwD0NdlH+jJGSB1fc4utwSAklw2IxYCgvGMGiSdJpNJow1LQX
    M0CM3F0khH5skrImsUbOwHev2Mktq6CmLTiuL3ZTOxFKK5MuIHu2eCz+LuZYyls+
    p720hFOlt6cHwl4G/qKYzJxDL/WMKXQdL/xNRrnXGcz8XU1EaaFTUAetsNYZAqDP
    IjWu/z7AlICCcs1GO5/OKfr0o0XklZgCQZdczaOCz7MJhduL2U52cdRacdc82Nzb
    eVpBrtI4VAQSBYosWsn6ENNr38S/5QNJ0w5ObUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    arctest; t=1520375216; bh=ZefJiZqk8YtYRfcVJv5iaJeQ0b6feIQjwn6gtu
    nYvK4=; b=bT/Z9+jCMFVAQqs2YoPIMcE0Uh1/X3Bia5QmBP/9Eo/6wMHLPMC2qz
    gH+p7zvz4MuYH3gnfNE+RuHP+Y/gK9Fwgn3KmvAAA0Tx8EczbekTwannhLcjv09K
    RqXL5PV4ZGY02cwP5a3Qx6FNkqd1MMUcIBYHxUbTzKPRtgPSNzJzvXc4fG6vZIAs
    TlMnKBeK6WmGRlzj6/+XDhqRkQjIOOo7QzLQR/8n/cKfmb+mNULB+hS1Y/1BjGYQ
    s//Snh0leCjGwa/s4sdyGWG3q60efjmDo1jw2rbhGkGa6mXxRyv6nrDyBOwuz6f/
    peFy51FhUCvsEFCTxT3s2Y4cMOC3AE+w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
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
        id S1753868AbeCFW0y (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 17:26:54 -0500
Received: from smtp-sh.infomaniak.ch ([128.65.195.4]:49847 "EHLO
        smtp-sh.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753805AbeCFW0x (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 17:26:53 -0500
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
To: Andy Lutomirski <luto@amacapital.net>
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
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
 <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
Date: Tue, 6 Mar 2018 23:25:31 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PvZReyUi33n28IxqiwHX1q5FTHMFGG1i5"
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PvZReyUi33n28IxqiwHX1q5FTHMFGG1i5
Content-Type: multipart/mixed; boundary="sEcIHHJqCS6B4cMrH9dqyVOUmWwcXc4Pq";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
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
 Thomas Graf <tgraf@suug.ch>, Tycho Andersen <tycho@tycho.ws>,
 Will Drewry <wad@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Linux API <linux-api@vger.kernel.org>,
 LSM List <linux-security-module@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Message-ID: <a70b41ee-78cb-52cc-152c-ac5e43b7e45c@digikod.net>
Subject: Re: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
References: <20180227004121.3633-1-mic@digikod.net>
 <CALCETrV3OZb70o83uOG437PubwBwaUJ6SKQucq_7g1BuBOmxzg@mail.gmail.com>
 <2e06621c-08e9-dc12-9b6e-9c09d5d8f458@digikod.net>
 <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>
In-Reply-To: <CALCETrWnJ7WkkfiymyahQd7YqO0KXP4mG1pRMq7fp8LG8Bwtcw@mail.gmail.com>

--sEcIHHJqCS6B4cMrH9dqyVOUmWwcXc4Pq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 28/02/2018 00:09, Andy Lutomirski wrote:
> On Tue, Feb 27, 2018 at 10:03 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod=
=2Enet> wrote:
>>
>> On 27/02/2018 05:36, Andy Lutomirski wrote:
>>> On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>>>> Hi,
>>>>
>=20
>>>>
>>>> ## Why use the seccomp(2) syscall?
>>>>
>>>> Landlock use the same semantic as seccomp to apply access rule
>>>> restrictions. It add a new layer of security for the current process=

>>>> which is inherited by its children. It makes sense to use an unique
>>>> access-restricting syscall (that should be allowed by seccomp filter=
s)
>>>> which can only drop privileges. Moreover, a Landlock rule could come=

>>>> from outside a process (e.g.  passed through a UNIX socket). It is t=
hen
>>>> useful to differentiate the creation/load of Landlock eBPF programs =
via
>>>> bpf(2), from rule enforcement via seccomp(2).
>>>
>>> This seems like a weak argument to me.  Sure, this is a bit different=

>>> from seccomp(), and maybe shoving it into the seccomp() multiplexer i=
s
>>> awkward, but surely the bpf() multiplexer is even less applicable.
>>
>> I think using the seccomp syscall is fine, and everyone agreed on it.
>>
>=20
> Ah, sorry, I completely misread what you wrote.  My apologies.  You
> can disregard most of my email.
>=20
>>
>>>
>>> Also, looking forward, I think you're going to want a bunch of the
>>> stuff that's under consideration as new seccomp features.  Tycho is
>>> working on a "user notifier" feature for seccomp where, in addition t=
o
>>> accepting, rejecting, or kicking to ptrace, you can send a message to=

>>> the creator of the filter and wait for a reply.  I think that Landloc=
k
>>> will want exactly the same feature.
>>
>> I don't think why this may be useful at all her. Landlock does not
>> filter at the syscall level but handles kernel object and actions as
>> does an LSM. That is the whole purpose of Landlock.
>=20
> Suppose I'm writing a container manager.  I want to run "mount" in the
> container, but I don't want to allow moun() in general and I want to
> emulate certain mount() actions.  I can write a filter that catches
> mount using seccomp and calls out to the container manager for help.
> This isn't theoretical -- Tycho wants *exactly* this use case to be
> supported.

Well, I think this use case should be handled with something like
LD_PRELOAD and a helper library. FYI, I did something like this:
https://github.com/stemjail/stemshim

Otherwise, we should think about enabling a process to (dynamically)
extend/patch the vDSO (similar to LD_PRELOAD but at the syscall level
and works with static binaries) for a subset of processes (the same way
seccomp filters are inherited). It may be more powerful and flexible
than extending the kernel/seccomp to patch (buggy?) userland.

>=20
> But using seccomp for this is indeed annoying.  It would be nice to
> use Landlock's ability to filter based on the filesystem type, for
> example.  So Tycho could write a Landlock rule like:
>=20
> bool filter_mount(...)
> {
>   if (path needs emulation)
>     call_user_notifier();
> }
>=20
> And it should work.
>=20
> This means that, if both seccomp user notifiers and Landlock make it
> upstream, then there should probably be a way to have a user notifier
> bound to a seccomp filter and a set of landlock filters.
>=20

Using seccomp filters and Landlock programs may be powerful. However,
for this use case, I think a *post-syscall* vDSO-like (which could get
some data returned by a Landlock program) may be much more flexible
(with less kernel code). What is needed here is a way to know the kernel
semantic (Landlock) and a way to patch userland without patching its
code (vDSO-like).


--sEcIHHJqCS6B4cMrH9dqyVOUmWwcXc4Pq--

--PvZReyUi33n28IxqiwHX1q5FTHMFGG1i5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlqfFVsACgkQIt7+33O9
apXBpgf+IexCxH4mYe+h7ZXCYbbX2SNVuELlcdHdOc0/nWAtQp1iE60Q5cerYFzd
2GyIc2aNTXQo8bxcvUIubzGPmvIiDkuAB5FvaDsjgkC/02YisW6N9QegxMx7duD6
QtHTiW8LqIektN1IkNstUXn6M796ToUjMMrJo+Mh/hyUV488wepbsPNvRQwTD9g8
sbvC1CVnQQtjqPNkgqaI1uA4n3hRB75a+9JH8tRu/Z7CP9EiTpqVuJhx02R7jO8P
k2aMZXLNbdO3p14nk67gL/TMhLIIPLEcVWICjmDexGMY+o3ehARIYV+KqEXVbzO4
rgQ9zEHUngRX4523Yf46CtEZUgn+3A==
=i3OW
-----END PGP SIGNATURE-----

--PvZReyUi33n28IxqiwHX1q5FTHMFGG1i5--
