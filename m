Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B662ECDFB1
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:47:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1845920871
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:47:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S8WI4ePf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1845920871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbeGPCLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:11:14 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:38546 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeGPCLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:11:14 -0400
Received: by mail-it0-f65.google.com with SMTP id v71-v6so18960623itb.3
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 18:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fV4IPbi9QFdqz+94u/qiNK+fp5o/FS8395LUNRnDDVM=;
        b=S8WI4ePfDfR7mzf/Qe0IpbkhrHkJwX66zkgkPaqxE0qvL1vS4qyutok0LrA/LQHwI5
         iihaxKHbJt9OZTqRejcn0973gk+KrfLrJjUh0NxaeTzUmN8M7eToTX+kNBuASLw7TFQX
         Au4QZ2MY0zOcFUdCzbLVL8ZJAZTi11bkGOFZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fV4IPbi9QFdqz+94u/qiNK+fp5o/FS8395LUNRnDDVM=;
        b=ie0sVz048KORo69xe8U8PXY6LBeO+d3g8oDNO+qDI2UoqLo671eczrNKExvz1chha8
         UIdcw6yL1vxB3RWjCMc59VJHE14gNMj2X1elr2xdZ+tth2hLLj0ENYymW1lw2rVIjb/O
         kkOD8eRVq61804zKqoA/3xqmPU/7V1kZH9vQh/yazRbd109ZazfevHTvUh4IYiv5w4Yx
         VyiVrYxZ141sMrkyGwzvUTYB0EqB5Kb/JbHMT4D9SWXAgRS8XPmnkZTu90OYpppnnbTy
         F0gSBEnk8BajYTWfCbvu9LiJtbcPVa2dbaxmwXPd731kGKn2xKHtUjYb0F+JKJFL9v6Z
         QU8Q==
X-Gm-Message-State: AOUpUlGVEC6a02mNiw4RdBgAUtQk7tWWbbQRU7rJbi2QvJVw6OwkCR71
        bWwoRqG5Ux4YC348pIwL6MDkt/UA0JT/FjTUa6k=
X-Google-Smtp-Source: AAOMgpf1KYW89gd5qWKMgQ+/tXYLOk4slQ9CijosGbuNLnCQZbc7uJA5so0+DhsKX8+FrrSbmMGlgk/oODz4Bq2XuPI=
X-Received: by 2002:a24:94f:: with SMTP id 76-v6mr11018257itm.113.1531705574302;
 Sun, 15 Jul 2018 18:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20180706215003.156702-1-jannh@google.com> <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
 <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
 <20180715220339.GA15435@gmail.com> <CAG48ez16CXanHX3JgybWk5RBjiFYMcO3EjBCXerr5nZUtWEGqQ@mail.gmail.com>
In-Reply-To: <CAG48ez16CXanHX3JgybWk5RBjiFYMcO3EjBCXerr5nZUtWEGqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 15 Jul 2018 18:46:03 -0700
Message-ID: <CA+55aFyVBvW65avVaevMaDA5LuuSrFoOnBY_UBskjCKeC24s4Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
To:     Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2018 at 6:33 PM Jann Horn <jannh@google.com> wrote:
>
> +Linus, Andy, Al from the other thread
>
> On Mon, Jul 16, 2018 at 12:03 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> > BTW., a naive question: would it make sense to simply disallow 'special=
'
> > fds to be passed to setuid binaries, and fix any user-space that breaks=
?
> > (i.e. only allow regular files and pipes/sockets.)
>
> If we do that, we'd probably want to do the same for file descriptor
> passing through /dev/binder and SCM_RIGHTS. There are already LSM
> hooks for most of that because SELinux filters these.

I think it's unlikely to make much sense to try to limit fd passing. I
can't really see any sane model for doing so. By definition, the file
descriptor was opened by the "weak" party (non-suid), and dammit,
that's supposed to be the real permission boundary.

So I don't think "don't pass fd to suid binary" makes any sense at
all. It might break things, and all it does is to paper over the real
issue. It smells like a pointless hack that makes little sense.

The fact that we have had problems in this area is sad, but I'm hoping
people are at least a bit more aware of it.

However:

> > Also, don't allow splice() on special files either, except if the drive=
r
> > explicitly opts in to it.
>
> In the thread "[PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
> superblock creation [ver #9]", Andy Lutomirski suggested something
> similar (https://lore.kernel.org/lkml/338BC3C4-F3E7-48F0-A82E-2C7295B6640=
E@amacapital.net/):
> handler
> | (Al- can=E2=80=99t we just stop allowing splice() at all on things that
> don=E2=80=99t use iov_iter?)
>
> Linus suggested
> (https://lore.kernel.org/lkml/CA+55aFxGqLfu1pjT5421k7KbSd94NWU4fw0H-zJe-q=
SWwBfAeQ@mail.gmail.com/):
>
> | We could add a FMODE_SPLICE_READ/WRITE bit, and let people opt in to
> | splice. We probably should have.

Right. We already use FMODE_xyz to limit various operations (ie we can
already say "this file is not seekable" etc), and I have to say, the
special magiuc splice() behavior has been an issue.

We did the "FMODE_PREAD/PWRITE" flags exactly because we wanted to
have the right ESPIPE behavior from file descriptors that simply
couldn't do lseek. And splice() is very much another "some file
descriptors do not like it".

So adding FMODE_SPLICE_READ/WRITE and then just forcing subsystems to
opt in to it sounds fairly simple. The people who really want splice
tend to just want pipes, regular files and network sockets, so
starting out with those opted it should pretty much cover it.

            Linus
