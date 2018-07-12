Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,SPF_PASS,
	T_DKIMWL_WL_MED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612F6C476E5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A07920878
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 16:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="iQa9+eEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A07920878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbeGLQdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 12:33:41 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:43289 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeGLQdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 12:33:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so20890258pfm.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=35OnGesK99ZOwShmDJR3A/7Pyg2gg8VvIWMpirwcrmo=;
        b=iQa9+eEZ/um+hMnRqG9FHdOIKQbC8yIeQyGsGnNWC6abvtZ3+LQTBZQRdNImQCA0x8
         Tl/xZqERDJaQ5aY6iNfbayH3etO4eR3B0wGxDC8t1XR9VEOT/it6QXCwepNbojob2AHO
         vB07AEJILoTdkS4f0H8kZAY6mbj0N5i0GyWXhAqK/TAj85hQ8NkWVHRTVDPyvlXmCAj6
         8SYeXimiXKLqQBoKyKkGtg6F0HtrKZzgq/L1N0V1drjKALZktN7O5TdE6qOpH9iFmroA
         0eiMH3UO/GTnYMH1pYjruGA2osF+Jum/zJXG1vVTpLiw327tRR84Bi2HncNnkFnmZUys
         ExuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=35OnGesK99ZOwShmDJR3A/7Pyg2gg8VvIWMpirwcrmo=;
        b=AifFO8jtvkBwx61ptMXC3YzDY++8rTf8f8TyN/Hxpg8PA0tY81Le2QtDXTfHsSEqC/
         l1aUZzg+fV0Xug+K+6Bf8Ou/hyaQIoOX5Bk/Q15JVmRitq6vnIRQqeeXdsV7YxJQVjqK
         Lgm1VXqfN++X+QFqAO4x5zsWGG2/5NJCYsWUBSAVkpV90PYDOjGSHGTwJTn3k9zVXWbU
         6mdSX1D6BkuQmoY1lO1RJE1EIpSTnBhCacVfmoeruAoewiVRVM8IOdVgbQNqn2TeCNwn
         bS5vrhCUhHs4AYZ6cWPqCtI51CAn2WjBLguENuXUhEZcK2824m9wCAKFeyThULxe5KWr
         BCqQ==
X-Gm-Message-State: AOUpUlFsWmubt3qWqJF/o/SfQgzm25Ddmbkwj9QJYIiSgfDxiKkeI32m
        0f/mwKIAUZOO1dNaXVCYHtd6EQ==
X-Google-Smtp-Source: AAOMgpftGVGhGkJKVarTVclumk+aQkst7rSsnet5pmn66dZYuop7DH5yH0n+VRo5Wr3a+XdiRPT9Pw==
X-Received: by 2002:a62:43c8:: with SMTP id l69-v6mr3161985pfi.196.1531412604993;
        Thu, 12 Jul 2018 09:23:24 -0700 (PDT)
Received: from ?IPv6:2600:1010:b052:968:4f0:92ce:1385:5f3d? ([2600:1010:b052:968:4f0:92ce:1385:5f3d])
        by smtp.gmail.com with ESMTPSA id o3-v6sm32678738pgp.3.2018.07.12.09.23.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 09:23:23 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for superblock creation [ver #9]
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15F79)
In-Reply-To: <7002.1531407244@warthog.procyon.org.uk>
Date:   Thu, 12 Jul 2018 09:23:22 -0700
Cc:     Andy Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>, tycho@tycho.ws
Content-Transfer-Encoding: quoted-printable
Message-Id: <338BC3C4-F3E7-48F0-A82E-2C7295B6640E@amacapital.net>
References: <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com> <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk> <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk> <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk> <7002.1531407244@warthog.procyon.org.uk>
To:     David Howells <dhowells@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 12, 2018, at 7:54 AM, David Howells <dhowells@redhat.com> wrote:
>=20
> Andy Lutomirski <luto@kernel.org> wrote:
>=20
>>> On Jul 11, 2018, at 12:22 AM, David Howells <dhowells@redhat.com> wrote:=

>>>=20
>>> Andy Lutomirski <luto@amacapital.net> wrote:
>>>=20
>>>>>  sfd =3D fsopen("ext4", FSOPEN_CLOEXEC);
>>>>>  write(sfd, "s /dev/sdb1"); // note I'm ignoring write's length arg
>>>>=20
>>>> Imagine some malicious program passes sfd as stdout to a setuid
>>>> program. That program gets persuaded to write "s /etc/shadow".  What
>>>> happens?  You=E2=80=99re okay as long as *every single fs* gets it righ=
t, but
>>>> that=E2=80=99s asking a lot.
>>>=20
>>> Do note that you must already have CAP_SYS_ADMIN to be able to call
>>> fsopen().
>>=20
>> If you're not allowing it already, someone will want user namespace
>> root to be able to use this very, very soon.
>=20
> Yeah, I'm sure.  And I've been thinking on how to deal with it.
>=20
> I think we *have* to open the source files/devices with the creds of whoev=
er
> called fsopen() or fspick() - that way you can't upgrade your privs by pas=
sing
> your context fd to a suid program.  To enforce this, I think it's simplest=
 for
> fscontext_write() to call override_creds() right after taking the uapi_mut=
ex
> and then call revert_creds() right before dropping the mutex.
>=20

If you make a syscall that attaches a block device to an fscontext, you don=E2=
=80=99t need any of this.  Heck, someone might actually *want* to grab a blo=
ck device from a different namespace.

All this override_creds() stuff is maybe okay if we were fixing an old broke=
n thing. But this is brand new.  And having write() call override_creds() an=
d do nontrivial things is a fascinating attack surface.

Just imagine what blows up if I abuse fscontext to open a block device on a p=
ath that traverses an AFS mount or /proc/.../fd or similar.  Or if I splice(=
) from a network filesystem into fscontext.

(Al- can=E2=80=99t we just stop allowing splice() at all on things that don=E2=
=80=99t use iov_iter?)

> Another thing we might want to look at is to allow a supervisory process t=
o
> examine the context before permitting the create/reconfigure action to
> proceed.  It might also be possible to do this through the LSM.

Cc Tycho. He=E2=80=99s working on this exact idea using seccomp. And he=E2=80=
=99d probably much, much prefer if configuration of an fscontext didn=E2=80=99=
t use a performance-critical syscall like write().

As a straw man, I suggest:

fsconfigure(contextfd, ADD_BLOCKDEV, dfd, path, flags);

fsconfigure(contextfd, ADD_OPTION, 0, =E2=80=9Cfoo=3Dbar=E2=80=9D, flags);

Etc. =20
