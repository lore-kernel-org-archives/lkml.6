Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-379639-1519705088-2-896519853369468924
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
    t=1519705087; b=fksEmFn/HTgauwd7Hh7dmH9u1VRVX4fNeEPJMKYb3jZ0xg1
    YVKwHE6TKgK0/Y3FCuYw08PtPl85fg9y8y8oMz+oNVVUgZW4QjNx67LVpghJJUgS
    4RXpwpqtsi3U2QTelh1mjp0OHKr2QbaELDsq0sYlBLYLa+pvyAYiCoesZeaZFYHF
    4L+KKh/HUCqiWHP9MFxDUwb7FhKGIivfMdUVasfJC3ZHnwRp+OqtAFt0Mqhw+p7B
    Twfvn5Y1rmBNLJ6mfBvoLaLa4fY6mHqoFIgCiP4McGdyiENe0Gz3EAxGvuB8wnDC
    +WeziVo2EUSndxcOyljocsQbbaSDJxoK0VeRwDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519705087; bh=TUgqg/9xg0ohcYSNDaSvG4EoZRuNqntVcdSKP3lvAUo=; b=v
    B2ksqGJZc3bMpmaCh6VRBgQ7lYG2FKNqbt3C1ha9+8YfzgYlqAOyzSr02cNt+j7v
    28fV+AfwPi9w8xhD6/3UnU6GWkTRWtfb+HbHIcPVJYQ+iTSv5HiG5tJZDwYrDVxY
    KiovlJodd89NRDh83JwKdGwAFCZwgAXOqzPN6ARd2gOnGyoCIpsovxA4Wh72VfX8
    3iJ/KtLCr50oLvilMheF5OvYYzE+9g4pCcxbs15Zc3DRyx8YAOSxJxyxXLkOxs/l
    zjlfTsJpqWD3Bv/14YfhNENLvjWjYh+BBsYlVz3Uo8cOn4MEu41xvPntCEGLqVrv
    sfAuE4W/BYzdemc9vniGg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=Z33f4Rfu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QgaBuMID;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b=Z33f4Rfu x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=amacapital.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QgaBuMID;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=amacapital.net header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751836AbeB0ESF (ORCPT <rfc822;greg@kroah.com>);
        Mon, 26 Feb 2018 23:18:05 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:46457 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeB0ESD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 26 Feb 2018 23:18:03 -0500
X-Google-Smtp-Source: AG47ELuLW+2VUh4+tsU6QYEFA78jVZja9lBObQniDeh79C75RTknDj6BS91cRgnHZy5MzehIe8W+8T6Y+YVZ0QB4qL0=
MIME-Version: 1.0
In-Reply-To: <20180227004121.3633-9-mic@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net> <20180227004121.3633-9-mic@digikod.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 27 Feb 2018 04:17:42 +0000
Message-ID: <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 08/11] landlock: Add ptrace restrictions
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

On Tue, Feb 27, 2018 at 12:41 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.net=
> wrote:
> A landlocked process has less privileges than a non-landlocked process
> and must then be subject to additional restrictions when manipulating
> processes. To be allowed to use ptrace(2) and related syscalls on a
> target process, a landlocked process must have a subset of the target
> process' rules.
>
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andy Lutomirski <luto@amacapital.net>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: James Morris <james.l.morris@oracle.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> ---
>
> Changes since v6:
> * factor out ptrace check
> * constify pointers
> * cleanup headers
> * use the new security_add_hooks()
> ---
>  security/landlock/Makefile       |   2 +-
>  security/landlock/hooks_ptrace.c | 124 +++++++++++++++++++++++++++++++++=
++++++
>  security/landlock/hooks_ptrace.h |  11 ++++
>  security/landlock/init.c         |   2 +
>  4 files changed, 138 insertions(+), 1 deletion(-)
>  create mode 100644 security/landlock/hooks_ptrace.c
>  create mode 100644 security/landlock/hooks_ptrace.h
>
> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
> index d0f532a93b4e..605504d852d3 100644
> --- a/security/landlock/Makefile
> +++ b/security/landlock/Makefile
> @@ -3,4 +3,4 @@ obj-$(CONFIG_SECURITY_LANDLOCK) :=3D landlock.o
>  landlock-y :=3D init.o chain.o task.o \
>         tag.o tag_fs.o \
>         enforce.o enforce_seccomp.o \
> -       hooks.o hooks_cred.o hooks_fs.o
> +       hooks.o hooks_cred.o hooks_fs.o hooks_ptrace.o
> diff --git a/security/landlock/hooks_ptrace.c b/security/landlock/hooks_p=
trace.c
> new file mode 100644
> index 000000000000..f1b977b9c808
> --- /dev/null
> +++ b/security/landlock/hooks_ptrace.c
> @@ -0,0 +1,124 @@
> +/*
> + * Landlock LSM - ptrace hooks
> + *
> + * Copyright =C2=A9 2017 Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2, as
> + * published by the Free Software Foundation.
> + */
> +
> +#include <asm/current.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h> /* ARRAY_SIZE */
> +#include <linux/lsm_hooks.h>
> +#include <linux/sched.h> /* struct task_struct */
> +#include <linux/seccomp.h>
> +
> +#include "common.h" /* struct landlock_prog_set */
> +#include "hooks.h" /* landlocked() */
> +#include "hooks_ptrace.h"
> +
> +static bool progs_are_subset(const struct landlock_prog_set *parent,
> +               const struct landlock_prog_set *child)
> +{
> +       size_t i;
> +
> +       if (!parent || !child)
> +               return false;
> +       if (parent =3D=3D child)
> +               return true;
> +
> +       for (i =3D 0; i < ARRAY_SIZE(child->programs); i++) {

ARRAY_SIZE(child->programs) seems misleading.  Is there no define
NUM_LANDLOCK_PROG_TYPES or similar?

> +               struct landlock_prog_list *walker;
> +               bool found_parent =3D false;
> +
> +               if (!parent->programs[i])
> +                       continue;
> +               for (walker =3D child->programs[i]; walker;
> +                               walker =3D walker->prev) {
> +                       if (walker =3D=3D parent->programs[i]) {
> +                               found_parent =3D true;
> +                               break;
> +                       }
> +               }
> +               if (!found_parent)
> +                       return false;
> +       }
> +       return true;
> +}

If you used seccomp, you'd get this type of check for free, and it
would be a lot easier to comprehend.  AFAICT the only extra leniency
you're granting is that you're agnostic to the order in which the
rules associated with different program types were applied, which
could easily be added to seccomp.
