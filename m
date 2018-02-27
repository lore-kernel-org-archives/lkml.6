Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2628879-1519772587-2-8321423514702080162
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519772586; b=v0Zv6Gui4bY0rVgRd1NSz9JozFK3plpY0aI0WJNLTIz6h1M
    HgbeBJA66dNoOb27ydEmjhFKZxLCifwDY14EesJaQ1gRR/hQoZNS0zvkwxSC2eCf
    YozNwQICwz41o+AsB5Nojd/ZuWCaoBIxIyOqdWkhiLQ3ZRiyibHbd/fCRGUDyMu9
    n7pRdjsuunEOwMxJ9JUes+76jEimivApTwKw46QUrwOLrFAnzC4FRxu0R7XZF2uj
    FLL5nCQta5P4/CGR3LVqUlV1H5ZQtux1oEwutLRdgs6hqb5Q7xcdSNoGBpm70q8h
    KWbL07S/wLjwzwkTYHlrLbdd4zcu7x7qD6Dnosw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519772586; bh=88NKUcejempRrrnGd1QQFajwvh9loYDCOG8Vc82K5Pw=; b=B
    1sBkYeQSoRE9igQQt1W+/pX2ov/IqlF85uPvz1xSVcUw8BwFz4r5TQ1EYjE5RLGB
    UiG2zebRwmpqAFgyHGARSI7GxSL8m7iI4B0XAY0NiRh41wM1nVZ+qdcEIxw/DE02
    h390j2IdFtsRIwiJGKU5ePqr6friWYBlfz2x8JB39uDLJrazT3VL5hqvbTqGFszy
    gCQn6jIDztIl+ingFXvJ27ISa2wb38an0A/thNYou19C4GSI4NcioDxmV7MRt+sj
    EgBBtg8HtQkl8aUkCE8GvNEF1/tsrhDTTR3K7komiRfAJhunEzwIhoN1Pc3AOd82
    1OWvgNnfi1df56MkdisYQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeB0XC4 convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Tue, 27 Feb 2018 18:02:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:52096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751982AbeB0XCk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 27 Feb 2018 18:02:40 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB460217B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=luto@kernel.org
X-Google-Smtp-Source: AG47ELuw9StiFpAnm9JKSg+cfT53kYCqJilbMCxF2NY2qsYZq92Hrx0yl1el0cFW9NVMfW+m4vnB2ouw6yZNgA0q2kQ=
MIME-Version: 1.0
In-Reply-To: <0e7d0512-12a3-568d-aa55-3def4b91c6d0@digikod.net>
References: <20180227004121.3633-1-mic@digikod.net> <20180227004121.3633-9-mic@digikod.net>
 <CALCETrUpDbusLPyZijR6MpZd5-0x0d9KuQHBaavqP1_GZ2tjfg@mail.gmail.com>
 <D6B96EE0-8932-4845-BFA5-4C65E5189AFB@amacapital.net> <0e7d0512-12a3-568d-aa55-3def4b91c6d0@digikod.net>
From: Andy Lutomirski <luto@kernel.org>
Date: Tue, 27 Feb 2018 23:02:16 +0000
X-Gmail-Original-Message-ID: <CALCETrUTiUeV71jgYWup0CZwG8eQ3=W7X5FgJqmgPxnYbFsccw@mail.gmail.com>
Message-ID: <CALCETrUTiUeV71jgYWup0CZwG8eQ3=W7X5FgJqmgPxnYbFsccw@mail.gmail.com>
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
Content-Transfer-Encoding: 8BIT
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 10:14 PM, Mickaël Salaün <mic@digikod.net> wrote:
>
> On 27/02/2018 06:01, Andy Lutomirski wrote:
>>
>>
>>> On Feb 26, 2018, at 8:17 PM, Andy Lutomirski <luto@amacapital.net> wrote:
>>>
>>>> On Tue, Feb 27, 2018 at 12:41 AM, Mickaël Salaün <mic@digikod.net> wrote:
>>>> A landlocked process has less privileges than a non-landlocked process
>>>> and must then be subject to additional restrictions when manipulating
>>>> processes. To be allowed to use ptrace(2) and related syscalls on a
>>>> target process, a landlocked process must have a subset of the target
>>>> process' rules.
>>>>
>>>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>>>> Cc: Alexei Starovoitov <ast@kernel.org>
>>>> Cc: Andy Lutomirski <luto@amacapital.net>
>>>> Cc: Daniel Borkmann <daniel@iogearbox.net>
>>>> Cc: David S. Miller <davem@davemloft.net>
>>>> Cc: James Morris <james.l.morris@oracle.com>
>>>> Cc: Kees Cook <keescook@chromium.org>
>>>> Cc: Serge E. Hallyn <serge@hallyn.com>
>>>> ---
>>>>
>>>> Changes since v6:
>>>> * factor out ptrace check
>>>> * constify pointers
>>>> * cleanup headers
>>>> * use the new security_add_hooks()
>>>> ---
>>>> security/landlock/Makefile       |   2 +-
>>>> security/landlock/hooks_ptrace.c | 124 +++++++++++++++++++++++++++++++++++++++
>>>> security/landlock/hooks_ptrace.h |  11 ++++
>>>> security/landlock/init.c         |   2 +
>>>> 4 files changed, 138 insertions(+), 1 deletion(-)
>>>> create mode 100644 security/landlock/hooks_ptrace.c
>>>> create mode 100644 security/landlock/hooks_ptrace.h
>>>>
>>>> diff --git a/security/landlock/Makefile b/security/landlock/Makefile
>>>> index d0f532a93b4e..605504d852d3 100644
>>>> --- a/security/landlock/Makefile
>>>> +++ b/security/landlock/Makefile
>>>> @@ -3,4 +3,4 @@ obj-$(CONFIG_SECURITY_LANDLOCK) := landlock.o
>>>> landlock-y := init.o chain.o task.o \
>>>>        tag.o tag_fs.o \
>>>>        enforce.o enforce_seccomp.o \
>>>> -       hooks.o hooks_cred.o hooks_fs.o
>>>> +       hooks.o hooks_cred.o hooks_fs.o hooks_ptrace.o
>>>> diff --git a/security/landlock/hooks_ptrace.c b/security/landlock/hooks_ptrace.c
>>>> new file mode 100644
>>>> index 000000000000..f1b977b9c808
>>>> --- /dev/null
>>>> +++ b/security/landlock/hooks_ptrace.c
>>>> @@ -0,0 +1,124 @@
>>>> +/*
>>>> + * Landlock LSM - ptrace hooks
>>>> + *
>>>> + * Copyright © 2017 Mickaël Salaün <mic@digikod.net>
>>>> + *
>>>> + * This program is free software; you can redistribute it and/or modify
>>>> + * it under the terms of the GNU General Public License version 2, as
>>>> + * published by the Free Software Foundation.
>>>> + */
>>>> +
>>>> +#include <asm/current.h>
>>>> +#include <linux/errno.h>
>>>> +#include <linux/kernel.h> /* ARRAY_SIZE */
>>>> +#include <linux/lsm_hooks.h>
>>>> +#include <linux/sched.h> /* struct task_struct */
>>>> +#include <linux/seccomp.h>
>>>> +
>>>> +#include "common.h" /* struct landlock_prog_set */
>>>> +#include "hooks.h" /* landlocked() */
>>>> +#include "hooks_ptrace.h"
>>>> +
>>>> +static bool progs_are_subset(const struct landlock_prog_set *parent,
>>>> +               const struct landlock_prog_set *child)
>>>> +{
>>>> +       size_t i;
>>>> +
>>>> +       if (!parent || !child)
>>>> +               return false;
>>>> +       if (parent == child)
>>>> +               return true;
>>>> +
>>>> +       for (i = 0; i < ARRAY_SIZE(child->programs); i++) {
>>>
>>> ARRAY_SIZE(child->programs) seems misleading.  Is there no define
>>> NUM_LANDLOCK_PROG_TYPES or similar?
>>>
>>>> +               struct landlock_prog_list *walker;
>>>> +               bool found_parent = false;
>>>> +
>>>> +               if (!parent->programs[i])
>>>> +                       continue;
>>>> +               for (walker = child->programs[i]; walker;
>>>> +                               walker = walker->prev) {
>>>> +                       if (walker == parent->programs[i]) {
>>>> +                               found_parent = true;
>>>> +                               break;
>>>> +                       }
>>>> +               }
>>>> +               if (!found_parent)
>>>> +                       return false;
>>>> +       }
>>>> +       return true;
>>>> +}
>>>
>>> If you used seccomp, you'd get this type of check for free, and it
>>> would be a lot easier to comprehend.  AFAICT the only extra leniency
>>> you're granting is that you're agnostic to the order in which the
>>> rules associated with different program types were applied, which
>>> could easily be added to seccomp.
>>
>> On second thought, this is all way too complicated.  I think the correct logic is either "if you are filtered by Landlock, you cannot ptrace anything" or to delete this patch entirely.
>
> This does not fit a lot of use cases like running a container
> constrained with some Landlock programs. We should not deny users the
> ability to debug their stuff.
>
> This patch add the minimal protection which are needed to have
> meaningful Landlock security policy. Without it, they may be easily
> bypassable, hence useless.
>

I think you're wrong here.  Any sane container trying to use Landlock
like this would also create a PID namespace.  Problem solved.  I still
think you should drop this patch.

>
>> If something like Tycho's notifiers goes in, then it's not obvious that, just because you have the same set of filters, you have the same privilege.  Similarly, if a feature that lets a filter query its cgroup goes in (and you proposed this once!) then the logic you implemented here is wrong.
>
> I don't get your point. Please take a look at the tests (patch 10).

I don't know what you want me to look at.

What I'm saying is: suppose I write a filter like this:

bool allow_some_action(void)
{
  int value_from_container_manager = call_out_to_user_notifier();
  return value_from_container_manager == 42;
}

or

bool allow_some_action(void)
{
  return my_cgroup_is("/foo/bar");
}

In both of these cases, your code will do the wrong thing.

>
>>
>> Or you could just say that it's the responsibility of a Landlock user to properly filter ptrace() just like it's the responsibility of seccomp users to filter ptrace if needed.
>
> A user should be able to enforce a security policy on ptrace as well,
> but this patch enforce a minimal set of security boundaries. It will be
> easy to add a new Landlock program type to get this kind of access control.

It sounds like you want Landlock to be a complete container system all
by itself.  I disagree with that design goal.
