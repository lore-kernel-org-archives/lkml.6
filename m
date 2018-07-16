Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBCCBECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A18DC208E0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 01:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+o25lCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A18DC208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbeGPB6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 21:58:14 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:32969 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbeGPB6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 21:58:14 -0400
Received: by mail-oi0-f67.google.com with SMTP id l10-v6so25161298oii.0
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 18:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r4mIILJaTnfYH3dZabMcN0bad66O8gCirxMTn/EUlZU=;
        b=C+o25lCR/4fuCeXfzWWE9wPdrmMdmwOtgpFoTGs459NaQbEQJeNe0LPFWq9GZOYzI5
         4bWhD33XHTTzoZ1iXdxnYzUzZPKwMsd8FWVlVBmkrZWZb0Llnv7IYXsBQn92JetRiObX
         I1ecBeWfUO9ELZ939C0thNlY612SphLjMaUGoJPETX7XwCswiox+ER3PYz9ZA7xpdTX2
         OoH1yTWho5jKrNQj+dZ2wVHU1JrXl1AmqX0OVyA5rt3OvOyrxK0v4G8QtASR94H7/NbO
         wMbyu37oOZsRZAbhxH5psuLnCQclVy7SkKAw11kKAMcekftmAuA4jojB1D/gzN4CvHLn
         wxEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r4mIILJaTnfYH3dZabMcN0bad66O8gCirxMTn/EUlZU=;
        b=eR3uRbxv44btlwdQ6ikRSGvE9g8yNLMUsSUS5E69hYnLuJ2Wr40wugJfPyJN/EPhPZ
         3ztFItSJksI4NALO6Nv/S+2hTq9MiFyWM4e/hQOB9tE0shEWwLOf1X07ObNNc/Vq1DKw
         O+YJ+70A82aUo4cBtM90F9EMDOkBwhcIJUDvupObMwJO/eXdnaMS4nWfUjF2PYWWJvRw
         DHjNDlU0UYwQ8NkX5EMV1hwBwLecexGD/n6zJ2+n+A05q9WVXgDUet1oWz9WZNbgY+60
         I7P3XeK/j9Lrsh0+Ur3mRkCwQ+Jt3izxnYoA3+PiziFkpo+DfqkL/XzqSObx93jTlpSV
         L5UQ==
X-Gm-Message-State: AOUpUlHFytE+6Q8mLu1xvn37Mxj7SK792imdq17ChKCsOL/F9l15TqP7
        vzLuVtE9U2ln+lo1FAHrQu8DNNN8uxHNLtZ0eB64Uw==
X-Google-Smtp-Source: AAOMgpeO1kff0M0+8un/pT01/wnsyd2MLE1NV0srnZErE5F17MrBvh34q6rBYR3hG46uuEaFJMqi5soG4EKzq4tLP3o=
X-Received: by 2002:aca:3002:: with SMTP id w2-v6mr14931557oiw.29.1531704796184;
 Sun, 15 Jul 2018 18:33:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180706215003.156702-1-jannh@google.com> <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
 <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com> <20180715220339.GA15435@gmail.com>
In-Reply-To: <20180715220339.GA15435@gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 16 Jul 2018 03:32:49 +0200
Message-ID: <CAG48ez16CXanHX3JgybWk5RBjiFYMcO3EjBCXerr5nZUtWEGqQ@mail.gmail.com>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
To:     Ingo Molnar <mingo@kernel.org>
Cc:     andriy.shevchenko@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Linus, Andy, Al from the other thread

On Mon, Jul 16, 2018 at 12:03 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Jann Horn <jannh@google.com> wrote:
>
> >  - A malicious user can pass an arbitrary file to a setuid binary as
> > stdin/stdout/stderr. When the setuid binary (expecting stdin/stdout to
> > be something normal, like a proper file or a pipe) then calls read(0,
> > <buf>, <len>), if the kernel disregards the length argument and writes
> > beyond the end of the buffer, it can corrupt adjacent userspace data,
> > potentially allowing a user to escalate their privileges; a write
> > handler is somewhat less interesting because it can probably (as in
> > this case) only leak out-of-bounds data from the caller, not corrupt
> > it, but it's still a concern in theory.
>
> BTW., a naive question: would it make sense to simply disallow 'special'
> fds to be passed to setuid binaries, and fix any user-space that breaks?
> (i.e. only allow regular files and pipes/sockets.)

If we do that, we'd probably want to do the same for file descriptor
passing through /dev/binder and SCM_RIGHTS. There are already LSM
hooks for most of that because SELinux filters these.

I guess the big question is, how exactly do you decide whether a file
is "special"? Something like a whitelist for files that are not
special based on their filesystem or their file_operations? /dev/null
and /dev/full are character devices, but should probably be things you
can pass to setuid binaries; /dev/fuse is a character device that is
passed over a unix domain socket by the fusermount setuid helper; on
the other hand, the infiniband "rdma_cm" miscdev had a buggy write
handler.
If the necessary whitelist is small enough, it might be a sensible
hardening measure.

> Also, don't allow splice() on special files either, except if the driver
> explicitly opts in to it.

In the thread "[PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
superblock creation [ver #9]", Andy Lutomirski suggested something
similar (https://lore.kernel.org/lkml/338BC3C4-F3E7-48F0-A82E-2C7295B6640E@=
amacapital.net/):
handler
| (Al- can=E2=80=99t we just stop allowing splice() at all on things that
don=E2=80=99t use iov_iter?)

Linus suggested
(https://lore.kernel.org/lkml/CA+55aFxGqLfu1pjT5421k7KbSd94NWU4fw0H-zJe-qSW=
wBfAeQ@mail.gmail.com/):

| We could add a FMODE_SPLICE_READ/WRITE bit, and let people opt in to
| splice. We probably should have.

> Sounds a lot more robust in the long run than playing whack-a-mole with t=
he
> *inevitable* hole in special read() and write() handlers in our 3,000+ de=
vice
> drivers...
