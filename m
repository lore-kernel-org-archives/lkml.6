Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1150044-1522620387-2-6337560715515440972
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
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522620386; b=DvEYuMj+pGp9lZGmq+C8KwoOrXVEIOShW16lH5U4FGXyWc0BS1
    laj6mVBBmd+Ne34uDoN8uhcC8Itr78OHjwOyGeNee4MV9/FuuZUO3lYWc6eOOi8o
    PX47B1xWvGKytp1Ua/KKi9ryksnHpnfw3yym0NBhzkzriBjFL30EmV7bMhOyWuWn
    HgJ0yFsBvePoSgIs2/0+yxu+09bOehsNKhrKGcbIZ8zvXKLgUvDxsQt5E/pnCuJa
    5TvK5ESrMVoNK4TbuqF/oquwOfWzjee4t1iCzmxQE0lU99p4LkWgVgJtSRHKUx0x
    RZYsMTnEQpttKJDbyHZR0yZPIw5Tpdg3dU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type:sender:list-id; s=
    fm2; t=1522620386; bh=NWiui1P0zMsPun3AP06sqz7vUp+8OuPjLMTvWNQ7W8
    A=; b=kOrkbg4lPlyKtyfB5dGLp4XyRy+6xUlHTaNLUtejl6ZimQeNbBuTv8/FaL
    aICpx+NM5pBYDtvL4jUrI2avnSMypeB4jiwxxttF1o8K/Y6TUcJDQaHaokYbzKzw
    Y/iRQpMHyDv1aFEzcqIFskuT7D6H8sFfcgb99QKCAPSMzt2YzsRprF9z+Zfo7Ed5
    7bLOjncHK6kwm+xguOcrOgfFEjfPJS/nxgQ3Vs7KYETZ8QRQ15EWDMbPceWGTbX3
    PWVIFYdmb5gGt/4wLSZJOuFL8kVXQhMk7ylFD7jN4N3I0Ig8fH5YbqukrzqBD3pO
    vfoLoFISr18rUM+b1p8IuOddMgpQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=digikod.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=digikod.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBro+JwYatOEsKIbpPV1adxC5/d9JptLOJ5BxiPGpDbWEdYcKw+vaov/klcl1qRZ9ixhUUKJw+2hvFy1009QNQivhvg+HpQaCxMwnk2gmYbiDVVyO0RY
    /FNQnKI3jgmU6Axn7GyNkQMe/OdrL5DbbjHiTMTwjssq7+B/Mii8jzXzzNIrleVPrXwsdzYGYT7ibL0pxGMKzUvheoalD/55RQR7+SHWS2D/7as50Q5MorzD
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=13zjGPudsaEWiJwPRgMA:9
    a=edGIuiaXAAAA:8 a=NEAV23lmAAAA:8 a=u0g3DNdEotHYdBcwH1sA:9
    a=EeRac8_LPce7KGSK:21 a=v1Xy5OI-KIA9XODu:21 a=QEXdDO2ut3YA:10
    a=Hx2OsaOEbP_rrlqbww4A:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=fUSZZkATYxXnQMecnGkA:9 a=x8gzFH9gYPwA:10 a=4kyDAASA-Eebq_PzFVE6:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeDAWGZ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 1 Apr 2018 18:06:25 -0400
Received: from smtp-sh2.infomaniak.ch ([128.65.195.6]:50572 "EHLO
        smtp-sh2.infomaniak.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbeDAWGW (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 1 Apr 2018 18:06:22 -0400
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Subject: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
 sandboxing
To: Andy Lutomirski <luto@kernel.org>
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
 <cd811155-9e0d-283a-9291-4adfcec848e6@digikod.net>
 <CALCETrUwkV4_65y7UjSgrq5WHOcZZ=+znKArehvhb1xEGG9HXw@mail.gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mic@digikod.net; keydata=
 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
 RjVFnCHFbtPhnyvGdQQ=
Message-ID: <0f355079-7ee2-c06a-2d47-a7a2fa6d98fe@digikod.net>
Date: Mon, 2 Apr 2018 00:04:36 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CALCETrUwkV4_65y7UjSgrq5WHOcZZ=+znKArehvhb1xEGG9HXw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="7ETR9AiFPQ2Uq7fMG9rud0cfSy2GGUryC"
X-Antivirus-Code: 0x100000
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7ETR9AiFPQ2Uq7fMG9rud0cfSy2GGUryC
Content-Type: multipart/mixed; boundary="F0X3aGkiRSyJCWu2SB4Vbzc5KAEyYJSt8";
 protected-headers="v1"
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To: Andy Lutomirski <luto@kernel.org>
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
Message-ID: <0f355079-7ee2-c06a-2d47-a7a2fa6d98fe@digikod.net>
Subject: [PATCH bpf-next v8 00/11] Landlock LSM: Toward unprivileged
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
 <cd811155-9e0d-283a-9291-4adfcec848e6@digikod.net>
 <CALCETrUwkV4_65y7UjSgrq5WHOcZZ=+znKArehvhb1xEGG9HXw@mail.gmail.com>
In-Reply-To: <CALCETrUwkV4_65y7UjSgrq5WHOcZZ=+znKArehvhb1xEGG9HXw@mail.gmail.com>

--F0X3aGkiRSyJCWu2SB4Vbzc5KAEyYJSt8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable


On 03/09/2018 12:53 AM, Andy Lutomirski wrote:
> On Thu, Mar 8, 2018 at 11:51 PM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
>>
>> On 07/03/2018 02:21, Andy Lutomirski wrote:
>>> On Tue, Mar 6, 2018 at 11:06 PM, Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>>>>
>>>> On 06/03/2018 23:46, Tycho Andersen wrote:
>>>>> On Tue, Mar 06, 2018 at 10:33:17PM +0000, Andy Lutomirski wrote:
>>>>>>>> Suppose I'm writing a container manager.  I want to run "mount" =
in the
>>>>>>>> container, but I don't want to allow moun() in general and I wan=
t to
>>>>>>>> emulate certain mount() actions.  I can write a filter that catc=
hes
>>>>>>>> mount using seccomp and calls out to the container manager for h=
elp.
>>>>>>>> This isn't theoretical -- Tycho wants *exactly* this use case to=
 be
>>>>>>>> supported.
>>>>>>>
>>>>>>> Well, I think this use case should be handled with something like=

>>>>>>> LD_PRELOAD and a helper library. FYI, I did something like this:
>>>>>>> https://github.com/stemjail/stemshim
>>>>>>
>>>>>> I doubt that will work for containers.  Containers that use user
>>>>>> namespaces and, for example, setuid programs aren't going to honor=

>>>>>> LD_PRELOAD.
>>>>>
>>>>> Or anything that calls syscalls directly, like go programs.
>>>>
>>>> That's why the vDSO-like approach. Enforcing an access control is no=
t
>>>> the issue here, patching a buggy userland (without patching its code=
) is
>>>> the issue isn't it?
>>>>
>>>> As far as I remember, the main problem is to handle file descriptors=

>>>> while "emulating" the kernel behavior. This can be done with a "shim=
"
>>>> code mapped in every processes. Chrome used something like this (in =
a
>>>> previous sandbox mechanism) as a kind of emulation (with the current=

>>>> seccomp-bpf ). I think it should be doable to replace the (userland)=

>>>> emulation code with an IPC wrapper receiving file descriptors throug=
h
>>>> UNIX socket.
>>>>
>>>
>>> Can you explain exactly what you mean by "vDSO-like"?
>>>
>>> When a 64-bit program does a syscall, it just executes the SYSCALL
>>> instruction.  The vDSO isn't involved at all.  32-bit programs usuall=
y
>>> go through the vDSO, but not always.
>>>
>>> It could be possible to force-load a DSO into an entire container and=

>>> rig up seccomp to intercept all SYSCALLs not originating from the DSO=

>>> such that they merely redirect control to the DSO, but that seems
>>> quite messy.
>>
>> vDSO is a code mapped for all processes. As you said, these processes
>> may use it or not. What I was thinking about is to use the same concep=
t,
>> i.e. map a "shim" code into each processes pertaining to a particular
>> hierarchy (the same way seccomp filters are inherited across processes=
).
>> With a seccomp filter matching some syscall (e.g. mount, open), it is
>> possible to jump back to the shim code thanks to SECCOMP_RET_TRAP. Thi=
s
>> shim code should then be able to emulate/patch what is needed, even
>> faking a file opening by receiving a file descriptor through a UNIX
>> socket. As did the Chrome sandbox, the seccomp filter may look at the
>> calling address to allow the shim code to call syscalls without being
>> catched, if needed. However, relying on SIGSYS may not fit with
>> arbitrary code. Using a new SECCOMP_RET_EMULATE (?) may be used to jum=
p
>> to a specific process address, to emulate the syscall in an easier way=

>> than only relying on a {c,e}BPF program.
>>
>=20
> This could indeed be done, but I think that Tycho's approach is much
> cleaner and probably faster.
>=20

I like it too but how does this handle file descriptors?


--F0X3aGkiRSyJCWu2SB4Vbzc5KAEyYJSt8--

--7ETR9AiFPQ2Uq7fMG9rud0cfSy2GGUryC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlrBV3oACgkQIt7+33O9
apW/BwgAqUk8+THqVZY7dPxk0Y4kTe3qwu9scB3Kx57Cx/v+cMpbmeySP9XJthTo
YDTcKLyeCiHJofBXFqxDq1AI0rtPJNgPRmhS8I038dnQf3qPr/kLdVd0uVJ79ugv
H7GeP46pPrPXTw3/JZlJVm9c9TtsCYLFxVNt+rwNgNtm9y5vhN7D8WEKthS8dwb1
kfc2HdNTGnlXGtz4ZKOhUg5YceNmgcL6kvX2GswUZ2D7YRZBhMDfoD/JvGqTli8q
dQUGma4Dr9bbzzJhkdNG7uSJTHM2G0EIeWSGOZ+6Zmm5210JPJ1OUdDcNrApuInp
qrmx31lKVQgLKbsqitN79O2Bsos9AA==
=eLbl
-----END PGP SIGNATURE-----

--7ETR9AiFPQ2Uq7fMG9rud0cfSy2GGUryC--
