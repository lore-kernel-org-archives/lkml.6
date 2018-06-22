Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCBC43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FDE72470D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 18:09:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="wwoSSA/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FDE72470D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934167AbeFVSJS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 14:09:18 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34865 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934082AbeFVSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 14:09:15 -0400
Received: by mail-pg0-f68.google.com with SMTP id i7-v6so3305686pgp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 11:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=obV3+oN3IjTNIKRAWj+SbAQsQ0qqu7h/HJLkFk+NGL8=;
        b=wwoSSA/QH8JjcaWFFFECZm3qA9jA86ZVdNV1j49XqlWPiCy7nvlj1jaOdMYUTdHOPX
         EO1CcOP12dY3WiyRU1qMU9Otrz/+EqDvyjOrxAl15VIcDbTWuF3EWZKSTJgdqaS1N2jT
         CsAjL+pvOjbgQvtJg5c1BeM9Gm9nohqveTUxiabbpynIfVKhFuE6N0qCHYou/89D8jDl
         NK7HyoQCiM16uZkTKpx6tBoFScoJ6OLHpyiAyEfOC6fkfPz0HR7fBLOVGme3eIC0+xfh
         mY8Ag2reKgVF1w+e2ttCTgE6X/tUKRJ5IvvvEkhiurTHlfcexTSyxL00nLiFr/OXoGog
         e/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=obV3+oN3IjTNIKRAWj+SbAQsQ0qqu7h/HJLkFk+NGL8=;
        b=aqCR5emNel7wAVY3iS/bjSuOAyzYRqRiZLHw5qo5lQz2KPsBiLZnTNZdcSsxGaQAWi
         X6HpPmMRDSRIjX7UVmD+DDX3AqZFffFZO8Wb54xZcxNthBI/vKgLxQiTv/eSb2P5eqBw
         hCBqgHE0Ss5FPzmFnhBKiPlr4wmfry9ukZnNaQ4G+pDSScWHT6QVaN/NNFdVeHILa/Rn
         QI1XPSA8I3Y5K7jznklzbJLRI9QHkMQvXXPWG5d+8MnP9tq9qYucxrKGDgej3vjyCV8x
         4Q9XvhADIkRdyOLsFSNKObKByFpHDwN/7bOlt9IF00RGB31HkK7Crc+ni3NbXS2QBxZi
         uWlQ==
X-Gm-Message-State: APt69E1Kl6EBoLMWhrh+aBAdG+StXyj4BXC1n904V5mT8GOiQb+KjwXE
        0nh0vvXIVmN4vcmWCdjmFX5t2G86h4g=
X-Google-Smtp-Source: ADUXVKLTmZbJwQsrjJu48sKPpS0eAQrx8zja1Uh+TA1yamlkBpLtz6BIYHuSYAPxY2DRl+oOPntCRw==
X-Received: by 2002:a62:1411:: with SMTP id 17-v6mr2840282pfu.3.1529690954209;
        Fri, 22 Jun 2018 11:09:14 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:2cd9:e530:8535:a508:f820? ([2600:1010:b065:2cd9:e530:8535:a508:f820])
        by smtp.gmail.com with ESMTPSA id x72-v6sm22735354pff.176.2018.06.22.11.09.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 11:09:12 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4 1/4] seccomp: add a return code to trap to userspace
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <20180622151514.GM3992@cisco>
Date:   Fri, 22 Jun 2018 11:09:08 -0700
Cc:     Jann Horn <jannh@google.com>, Kees Cook <keescook@chromium.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        containers@lists.linux-foundation.org,
        Linux API <linux-api@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        suda.akihiro@lab.ntt.co.jp, "Tobin C. Harding" <me@tobin.cc>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E8029AD7-7009-4CBF-911E-186328237176@amacapital.net>
References: <20180621220416.5412-1-tycho@tycho.ws> <20180621220416.5412-2-tycho@tycho.ws> <CAG48ez3Ek_KG54ejR=Q=XtW_HDs8hQ+cgFODzn4rQ0nVDVpODg@mail.gmail.com> <20180622151514.GM3992@cisco>
To:     Tycho Andersen <tycho@tycho.ws>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 22, 2018, at 8:15 AM, Tycho Andersen <tycho@tycho.ws> wrote:
>=20
> Hi Jann,
>=20
>> On Fri, Jun 22, 2018 at 04:40:20PM +0200, Jann Horn wrote:
>>> On Fri, Jun 22, 2018 at 12:05 AM Tycho Andersen <tycho@tycho.ws> wrote:
>>> This patch introduces a means for syscalls matched in seccomp to notify
>>> some other task that a particular filter has been triggered.
>>>=20
>>> The motivation for this is primarily for use with containers. For exampl=
e,
>>> if a container does an init_module(), we obviously don't want to load th=
is
>>> untrusted code, which may be compiled for the wrong version of the kerne=
l
>>> anyway. Instead, we could parse the module image, figure out which modul=
e
>>> the container is trying to load and load it on the host.
>>>=20
>>> As another example, containers cannot mknod(), since this checks
>>> capable(CAP_SYS_ADMIN). However, harmless devices like /dev/null or
>>> /dev/zero should be ok for containers to mknod, but we'd like to avoid h=
ard
>>> coding some whitelist in the kernel. Another example is mount(), which h=
as
>>> many security restrictions for good reason, but configuration or runtime=

>>> knowledge could potentially be used to relax these restrictions.
>>>=20
>>> This patch adds functionality that is already possible via at least two
>>> other means that I know about, both of which involve ptrace(): first, on=
e
>>> could ptrace attach, and then iterate through syscalls via PTRACE_SYSCAL=
L.
>>> Unfortunately this is slow, so a faster version would be to install a
>>> filter that does SECCOMP_RET_TRACE, which triggers a PTRACE_EVENT_SECCOM=
P.
>>> Since ptrace allows only one tracer, if the container runtime is that
>>> tracer, users inside the container (or outside) trying to debug it will n=
ot
>>> be able to use ptrace, which is annoying. It also means that older
>>> distributions based on Upstart cannot boot inside containers using ptrac=
e,
>>> since upstart itself uses ptrace to start services.
>>>=20
>>> The actual implementation of this is fairly small, although getting the
>>> synchronization right was/is slightly complex.
>>>=20
>>> Finally, it's worth noting that the classic seccomp TOCTOU of reading
>>> memory data from the task still applies here, but can be avoided with
>>> careful design of the userspace handler: if the userspace handler reads a=
ll
>>> of the task memory that is necessary before applying its security policy=
,
>>> the tracee's subsequent memory edits will not be read by the tracer.
>>=20
>> I've been thinking about how one would actually write userspace code
>> that uses this API, and whether PID reuse is an issue here. As far as
>> I can tell, the following situation can happen:
>>=20
>> - seccomped process tries to perform a syscall that gets trapped
>> - notification is sent to the supervisor
>> - supervisor reads the notification
>> - seccomped process gets SIGKILLed
>> - new process appears with the PID that the seccomped process had
>> - supervisor tries to access memory of the seccomped process via
>> process_vm_{read,write}v or /proc/$pid/mem
>> - supervisor unintentionally accesses memory of the new process instead
>>=20
>> This could have particularly nasty consequences if the supervisor has
>> to write to memory of the seccomped process for some reason.
>> It might make sense to explicitly document how the API has to be used
>> to avoid such a scenario from occuring. AFAICS,
>> process_vm_{read,write}v are fundamentally unsafe for this;
>> /proc/$pid/mem might be safe if you do the following dance in the
>> supervisor to validate that you have a reference to the right struct
>> mm before starting to actually access memory:
>>=20
>> - supervisor reads a syscall notification for the seccomped process with P=
ID $A
>> - supervisor opens /proc/$A/mem [taking a reference on the mm of the
>> process that currently has PID $A]
>> - supervisor reads all pending events from the notification FD; if
>> one of them says that PID $A was signalled, send back -ERESTARTSYS (or
>> -ERESTARTNOINTR?) and bail out
>> - [at this point, the open FD to /proc/$A/mem is known to actually
>> refer to the mm struct of the seccomped process]
>> - read and write on the open FD to /proc/$A/mem as necessary
>> - send back the syscall result
>=20
> Yes, this is a nasty problem :(. We have the id in the
> request/response structs to avoid this race, so perhaps we can re-use
> that? So it would look like:
>=20
> - supervisor gets syscall notification for $A
> - supervisor opens /proc/$A/mem or /proc/$A/map_files/... or a dir fd
>  to the container's root or whatever
> - supervisor calls seccomp(SECCOMP_NOTIFICATION_IS_VALID, req->id, listene=
r_fd)
> - supervisor knows that the fds it has open are safe
>=20
> That way it doesn't have to flush the whole queue? Of course this
> makes things a lot slower, but it does enable safety for more than
> just memory accesses, and also isn't required for things which
> wouldn't read memory.
>=20
>> It might be nice if the kernel was able to directly give the
>> supervisor an FD to /proc/$A/mem that is guaranteed to point to the
>> right struct mm, but trying to implement that would probably make this
>> patch set significantly larger?
>=20
> I'll take a look and see how big it is, it doesn't *seem* like it
> should be that hard. Famous last words :)

One possible extra issue: IIRC /proc/.../mem uses FOLL_FORCE, which is not w=
hat we want here.

How about just adding an explicit =E2=80=9Cread/write the seccomp-trapped ta=
sk=E2=80=99s memory=E2=80=9D primitive?  That should be easier than a =E2=80=
=9Copen mem fd=E2=80=9D primitive.=
