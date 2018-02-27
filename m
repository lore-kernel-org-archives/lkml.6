Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-452929-1519707695-2-11930471046618469012
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519707694; b=AlZKzdRof3shGC4tDFGlJtyhwJz89WrGZsVi45hGjC/8oVf
    e0dva9C0AhRM/9QNuuHEApMyc6W/nMuT74vb2E+dENegM1J/9KRfarBKurlrpNtC
    nYDxxfuPZXyvRTjnNVbMHYGTMcAvIAafd7BjIaHognokHDbOsR6EgiNeWWTXmEbR
    ppScRePtmDyuGDIP1act3RkYBVjgX75Sm7xKQ3fu9vt4KyHs5OW3im73hJTzq7W+
    np8JcaiCkCldQZPF2zu8Unw3GWUtW+uEcjz/vQdKt5ARSs7yIIpjrLCnL72YDCaZ
    s6UeadI6MJRRd7HNNmoWpBs0iNkcY6pNBryHM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:mime-version:subject:from
    :in-reply-to:date:cc:content-transfer-encoding:message-id
    :references:to:sender:list-id; s=arctest; t=1519707694; bh=EOqjo
    /XiuCJJQZZcVZuP/eUwM/X/HVmgbkfAcz/xDjM=; b=qqg6XJRnPJIc/kLTikP1w
    Al8FK9LCEEv1USJoyOqEq43eyDSxKmx3p8ttKoY5mt+ecVMPH75sInZwbl0+IEfa
    tm0Yy0IfqWFGzyAf//QabeFncN1dhxbuuBSK/GTkmv0TomiijJ8DjXfKaf85Akx5
    DiZqwkA36+OiQeon+f7VIA/TjyQAqp0RfZwHApVrPPxUn1/Jln9GAO9NZtbLwQdT
    8LE3vce2xxFLQZecMRZtM4lEWOd2x88SULhM4n33il/T+f0d4Bg7n0SqFrvh8wNm
    772PeHtLI+1h9PXYEiynoZ7bXYcQmcl3po0PPO7t6eayWR+sUAt4QE9HtTJaa8Pg
    w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=ex8/2UFX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YnI8r9jK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=ex8/2UFX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=YnI8r9jK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeB0FBd (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 00:01:33 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:42108 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbeB0FBa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 27 Feb 2018 00:01:30 -0500
X-Google-Smtp-Source: AH8x224YdBcbTf159rp/2oEKth406ZTj1ij9sXhg5rkdM/H7O3vohAv8C1ymoXYaRSj+6DX1NNwJKw==
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
From: Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15D60)
In-Reply-To: <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
Date: Mon, 26 Feb 2018 21:01:28 -0800
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <D6B96EE0-8932-4845-BFA5-4C65E5189AFB@amacapital.net>
References: <20180227004121.3633-1-mic@digikod.net> <20180227004121.3633-9-mic@digikod.net> <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On Feb 26, 2018, at 8:17 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>=20
>> On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.n=
et> wrote:
>> A landlocked process has less privileges than a non-landlocked process
>> and must then be subject to additional restrictions when manipulating
>> processes. To be allowed to use ptrace(2) and related syscalls on a
>> target process, a landlocked process must have a subset of the target
>> process' rules.
>>=20
>> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
>> Cc: Alexei Starovoitov <ast@kernel.org>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>> Cc: David S. Miller <davem@davemloft.net>
>> Cc: James Morris <james.l.morris@oracle.com>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Serge E. Hallyn <serge@hallyn.com>
>> ---
>>=20
>> Changes since v6:
>> * factor out ptrace check
>> * constify pointers
>> * cleanup headers
>> * use the new security_add_hooks()
>> ---
>> security/landlock/Makefile       |   2 +-
>> security/landlock/hooks_ptrace.c | 124 ++++++++++++++++++++++++++++++++++=
+++++
>> security/landlock/hooks_ptrace.h |  11 ++++
>> security/landlock/init.c         |   2 +
>> 4 files changed, 138 insertions(+), 1 deletion(-)
>> create mode 100644 security/landlock/hooks_ptrace.c
>> create mode 100644 security/landlock/hooks_ptrace.h
>>=20
>> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
>> index d0f532a93b4e..605504d852d3 100644
>> --- a/security/landlock/Makefile
>> +++ b/security/landlock/Makefile
>> @@ -3,4 +3,4 @@ obj-$(CONFIG_SECURITY_LANDLOCK) :=3D landlock.o
>> landlock-y :=3D init.o chain.o task.o \
>>        tag.o tag_fs.o \
>>        enforce.o enforce_seccomp.o \
>> -       hooks.o hooks_cred.o hooks_fs.o
>> +       hooks.o hooks_cred.o hooks_fs.o hooks_ptrace.o
>> diff --git a/security/landlock/hooks_ptrace.c b/security/landlock/hooks_p=
trace.c
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
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2, as
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
>=20
>> +               struct landlock_prog_list *walker;
>> +               bool found_parent =3D false;
>> +
>> +               if (!parent->programs[i])
>> +                       continue;
>> +               for (walker =3D child->programs[i]; walker;
>> +                               walker =3D walker->prev) {
>> +                       if (walker =3D=3D parent->programs[i]) {
>> +                               found_parent =3D true;
>> +                               break;
>> +                       }
>> +               }
>> +               if (!found_parent)
>> +                       return false;
>> +       }
>> +       return true;
>> +}
>=20
> If you used seccomp, you'd get this type of check for free, and it
> would be a lot easier to comprehend.  AFAICT the only extra leniency
> you're granting is that you're agnostic to the order in which the
> rules associated with different program types were applied, which
> could easily be added to seccomp.

On second thought, this is all way too complicated.  I think the correct log=
ic is either "if you are filtered by Landlock, you cannot ptrace anything" o=
r to delete this patch entirely. If something like Tycho's notifiers goes in=
, then it's not obvious that, just because you have the same set of filters,=
 you have the same privilege.  Similarly, if a feature that lets a filter qu=
ery its cgroup goes in (and you proposed this once!) then the logic you impl=
emented here is wrong.

Or you could just say that it's the responsibility of a Landlock user to pro=
perly filter ptrace() just like it's the responsibility of seccomp users to f=
ilter ptrace if needed.

I take this as further evidence that Landlock makes much more sense as part o=
f seccomp than as a totally separate thing.  We've very carefully reviewed t=
hese things for seccomp.  Please don't make us do it again from scratch.=
