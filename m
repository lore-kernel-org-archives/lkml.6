Return-Path: <kernel-hardening-return-12020-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtSYOZO6NDEP6MOlxY3PnD0dfPYjp8zJJaF6c1TY2M6KMKg58majrUEG1LI4FNAMym+TMsM
ARC-Seal: i=1; a=rsa-sha256; t=1519769998; cv=none;
        d=google.com; s=arc-20160816;
        b=OFEyDagHphfMbqLeD3S2gUtyEL8SAkaw0jii5a1fdJbQQ9K0lYvqeAa0xliQidMucD
         IVLac5fow1TFPUQW+oHaBOzFSa0wDK4kuHV7AGU+y387qe6bIUzv46Cqa4nlixk1q9o4
         uUdDIhBsiEptAOAqYB6vTQGk6XLbFuePlJk0PInPSuiqyK4LES2Qx+1IIeAoP0IHiuwW
         ql6hMJcaSlK+0P7ubcNOnKzrHGE+erhsg5Ck+k9EajpRqFmxlUGIPkHr9f5YxJJZBo/+
         ovPGycDJAX5OwvBfVQ5HVFVzYiFlejEIMRLU13mfEUyeBhT7E/GqUGsTkH2q4f7zmk96
         y5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:delivered-to:list-id:list-subscribe:list-unsubscribe
         :list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=1KZOG6+LxL/tbUh9OW0+2vYqoUeYDroujv6MhHGqO78=;
        b=qNnPctLyZrYLUZ3TJUlwhn5cGrlJKXvARyAJM23ObOcs7xXOeuETjM6T/BHeXF0YFP
         WRkdYIMxMuYh+2ljk+zXuL+UJtd0KW03meWQ+0bNgrKrlvVwV4QEBuVx49kaN2yAE7Cq
         dlpUBWqRjsI+HXiGFqE6NAIDtiLmVJSU0YMvl/YDjOX2KKhjWanCESNRHxOyhbvFnakQ
         BFiEJ+mjR3OBt+NZxWLITl5SjiA2oxjKyoJjPymURaKdbEa1RM0AnJoEiKjexaTCpiCY
         OWC9QQylmEP9Bcr5/JOvmQwkl7kIgdlEIOQNvUjGs9/Yn6wK5Z/k5Ow3jQmtvqqeNgtU
         ElbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12020-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12020-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12020-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12020-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
To: Andy Lutomirski <luto@amacapital.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        David Drysdale
 <drysdale@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        James Morris <james.l.morris@oracle.com>, Jann Horn <jann@thejh.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Kees Cook <keescook@chromium.org>, Paul Moore <paul@paul-moore.com>,
        Sargun Dhillon <sargun@sargun.me>,
        "Serge E . Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Tejun Heo <tj@kernel.org>, Thomas Graf <tgraf@suug.ch>,
        Tycho Andersen <tycho@tycho.ws>, Will Drewry <wad@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-9-mic@digikod.net>
 <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <6509ae4f-cf7e-da71-adb3-d4cf2cb7bc55@digikod.net>
Date: Tue, 27 Feb 2018 23:18:21 +0100
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="i6YhnamGBZf9NUggMtTjX8wcInMCaoJov"
X-Antivirus-Code: 0x100000
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593512859761492731?=
X-GMAIL-MSGID: =?utf-8?q?1593594345921642902?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6YhnamGBZf9NUggMtTjX8wcInMCaoJov
Content-Type: multipart/mixed; boundary="aMdpPijkWkxWbd6h5LYqQVqvB23HviTFP";
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
Message-ID: <6509ae4f-cf7e-da71-adb3-d4cf2cb7bc55@digikod.net>
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
References: <20180227004121.3633-1-mic@digikod.net>
 <20180227004121.3633-9-mic@digikod.net>
 <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
In-Reply-To: <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>

--aMdpPijkWkxWbd6h5LYqQVqvB23HviTFP
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 27/02/2018 05:17, Andy Lutomirski wrote:
> On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod=
=2Enet> wrote:
>> A landlocked process has less privileges than a non-landlocked process=

>> and must then be subject to additional restrictions when manipulating
>> processes. To be allowed to use ptrace(2) and related syscalls on a
>> target process, a landlocked process must have a subset of the target
>> process' rules.
>>
>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: James Morris <james.l.morris@oracle.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> ---
>>
>> Changes since v6:
>> * factor out ptrace check
>> * constify pointers
>> * cleanup headers
>> * use the new security_add_hooks()
>> ---
>>  security/landlock/Makefile       |   2 +-
>>  security/landlock/hooks_ptrace.c | 124 ++++++++++++++++++++++++++++++=
+++++++++
>>  security/landlock/hooks_ptrace.h |  11 ++++
>>  security/landlock/init.c         |   2 +
>>  4 files changed, 138 insertions(+), 1 deletion(-)
>>  create mode 100644 security/landlock/hooks_ptrace.c
>>  create mode 100644 security/landlock/hooks_ptrace.h
>>
>> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
>> index d0f532a93b4e..605504d852d3 100644
>> --- a/security/landlock/Makefile
>> +++ b/security/landlock/Makefile
>> @@ -3,4 +3,4 @@ obj-$(CONFIG_SECURITY_LANDLOCK) :=3D landlock.o
>>  landlock-y :=3D init.o chain.o task.o \
>>         tag.o tag_fs.o \
>>         enforce.o enforce_seccomp.o \
>> -       hooks.o hooks_cred.o hooks_fs.o
>> +       hooks.o hooks_cred.o hooks_fs.o hooks_ptrace.o
>> diff --git a/security/landlock/hooks_ptrace.c b/security/landlock/hook=
s_ptrace.c
>> new file mode 100644
>> index 000000000000..f1b977b9c808
>> --- /dev/null
>> +++ b/security/landlock/hooks_ptrace.c
>> @@ -0,0 +1,124 @@
>> +/*
>> + * Landlock LSM - ptrace hooks
>> + *
>> + * Copyright =C2=A9 2017 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License version 2, as=

>> + * published by the Free Software Foundation.
>> + */
>> +
>> +#include <asm/current.h>
>> +#include <linux/errno.h>
>> +#include <linux/kernel.h> /* ARRAY_SIZE */
>> +#include <linux/lsm_hooks.h>
>> +#include <linux/sched.h> /* struct task_struct */
>> +#include <linux/seccomp.h>
>> +
>> +#include "common.h" /* struct landlock_prog_set */
>> +#include "hooks.h" /* landlocked() */
>> +#include "hooks_ptrace.h"
>> +
>> +static bool progs_are_subset(const struct landlock_prog_set *parent,
>> +               const struct landlock_prog_set *child)
>> +{
>> +       size_t i;
>> +
>> +       if (!parent || !child)
>> +               return false;
>> +       if (parent =3D=3D child)
>> +               return true;
>> +
>> +       for (i =3D 0; i < ARRAY_SIZE(child->programs); i++) {
>=20
> ARRAY_SIZE(child->programs) seems misleading.  Is there no define
> NUM_LANDLOCK_PROG_TYPES or similar?

Yes, there is _LANDLOCK_HOOK_LAST, but this code seems more readable
exactly because it does not require the developer (or the code checking
tools) to know about this static value.


--aMdpPijkWkxWbd6h5LYqQVqvB23HviTFP--

--i6YhnamGBZf9NUggMtTjX8wcInMCaoJov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEUysCyY8er9Axt7hqIt7+33O9apUFAlqV2S0ACgkQIt7+33O9
apXu7wgAn36DDjmFXW49DSrMteDmxiTQryn8MAANheqMD6r22H9Curl5yh07VW9Z
4+L+NAmz6Uceefy7IVs6IXJy0nk8h04zjmXamXyJqdgFirjOX12ZjKJn8pT+JRik
chuWr9L/0NOgGkGUrhwInhFOtIxc/fwnZQg3bbOFEkU1XzIWzBy46c99ec5WiS7v
3KubJis1teJUeAuP+L46kCfDVpClD5eA51fWaQHrC8dN2seNyygVidzuHJtCIs0e
T8wTEYurpkYsVkDU95nN5/9Q0tfnKQlsWcAt3dM75BHayoZOXgCfXmhtemdhtM9q
gV+gB05VGqTepFX3Cs5nhK3AgZ4pwA==
=x1YA
-----END PGP SIGNATURE-----

--i6YhnamGBZf9NUggMtTjX8wcInMCaoJov--
