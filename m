Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E20C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73734208AF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 07:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpSWWxw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73734208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbeGIHlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 03:41:40 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44559 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeGIHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 03:41:39 -0400
Received: by mail-oi0-f66.google.com with SMTP id s198-v6so34099911oih.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 00:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NIL9G9WrC8IrWDe2Sf+Y8ngg9k4SI+ofklhinD4ODNU=;
        b=TpSWWxw7TlUlttCa/5uvpJ4aMXzgpKj7a155EoYNWzDZmr5287UGIcN886Lc5FxUGB
         xB4chWbP4LdNzRTozPe9dPtQSZbNawp9WfVZnm+d0xbgPT60Dr+yNBCauqNX4RczeNW1
         7jjt0C8ghNfc0/vSgfIHtugdzfck3WanRlzFPHYeCcIWfJa2Mf01mf/BtwfnJptf+tuB
         ghc0AJ9W30WYmc23g0SoGB1PbF+gFIQdZR2qqv8J0KsSjhamxrQtsF+01v1e2ij/dlkz
         VJoRp7Qwb7aE5qzXyL06XrVi2ONnn395sxybwTv5H9Fp8h8yr/BIfJPJLTx5KskaJwWw
         siIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NIL9G9WrC8IrWDe2Sf+Y8ngg9k4SI+ofklhinD4ODNU=;
        b=H5FinMBX2trpAL9oP5GGWjwfzWJNKmFcELDhKOHZ43KHMLnkZ1BAoLoOA15wZUbY0Z
         HKjfnlH8Gw93kGZEKmgly+jdWvBw74UUiELogRNVNg+rwx0F36u441oz3FrOTUjrRODG
         Zpb33G5fOjePa0KwFN/MieJThcaZffdyS73zh8vRZttc6bl9cj1Q0LlhJybIi5+OcAZh
         eSeD+bPQEeSJh92nVA0rAFmGSzjCs64/3n1WUj/fa+Gz0JBwPTOz7vZBMxc4FwM3Cck8
         oCPWteMxRGknspiOoFCw5IZ5ZtkY1Hmlox4qGktDdyYkPxe/dXzG6GXGRox3I6nnvN2M
         IpOw==
X-Gm-Message-State: APt69E1yP20PJqKyJPB8bhToBMX+TzXtxV0UCYqJRNp4wpdIm0T4hA2t
        Yx4Cl83ERtrgv19N1Lr0mTmGs/vFcwIDrYyMzZvvYg==
X-Google-Smtp-Source: AAOMgpe+GAGOPQfcr+MtfR6vzrzpIGMnRB8uTuzdjGvqO0ZCal649e6BEVKR2diCI7lg2ipxqTC8Ima328UQfFwWz00=
X-Received: by 2002:aca:6044:: with SMTP id u65-v6mr21840831oib.323.1531122098328;
 Mon, 09 Jul 2018 00:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180706215003.156702-1-jannh@google.com> <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
In-Reply-To: <f9c8cf81df29006bc9c79932f3bcd599b559b408.camel@linux.intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 9 Jul 2018 09:41:11 +0200
Message-ID: <CAG48ez105Jan3BDAKssThnbNcr3yBMFTbdQHEHwXdmZUvE5VQw@mail.gmail.com>
Subject: Re: [PATCH] x86/mtrr: don't copy out-of-bounds data in mtrr_write
To:     andriy.shevchenko@linux.intel.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 9, 2018 at 8:53 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, 2018-07-06 at 23:50 +0200, Jann Horn wrote:
> > Don't access the provided buffer out of bounds - this can cause a
> > kernel
> > out-of-bounds read when invoked through sys_splice() or other things
> > that
> > use kernel_write()/__kernel_write().
> >
>
> Can you elaborate a bit this change?
>
> Only few places in the kernel do this way and I would like to understand
>  why in most of the cases it's okay to supply maximum available length
> and here is not the one.

In many contexts, it is fine to do something like strncpy_from_user()
with a fixed length without further checks - for example, in normal
syscall handlers, or in ioctl handlers, because invocation of these
implies an intent by the calling code to trigger specifically this
behavior. ->read() and ->write() handlers are special exceptions that
have to adhere to stricter rules because, in essence, reads and writes
on files can be performed by one security context on a file that was
maliciously supplied by another security context. In other words,
invocation of ->read() and ->write() doesn't imply caller intent
beyond "I want to move this many bytes between that file and this
buffer". Specifically, this can happen in two ways:

 - A malicious user can pass an arbitrary file to a setuid binary as
stdin/stdout/stderr. When the setuid binary (expecting stdin/stdout to
be something normal, like a proper file or a pipe) then calls read(0,
<buf>, <len>), if the kernel disregards the length argument and writes
beyond the end of the buffer, it can corrupt adjacent userspace data,
potentially allowing a user to escalate their privileges; a write
handler is somewhat less interesting because it can probably (as in
this case) only leak out-of-bounds data from the caller, not corrupt
it, but it's still a concern in theory.
 - Almost any ->read() and ->write() handler can be invoked by the
kernel with a buffer argument that points at a *kernel* buffer; when
this happens, *the address limit checks are disabled*, allowing the
->read() or ->write() handler to read and write *kernel memory* using
copy_from_user()/copy_to_user() and other "userspace" accessor
functions. The easiest way to trigger this behavior from userspace is
to use sys_splice().

It's not a big deal in this case because if you can open the mtrr
device, you're probably very highly privileged already, and it's just
a read, not a write, and the data has to adhere to a rather specific
format to be parsed to a point where an attacker could grab the parsed
data - but it's still wrong.

An older mitigation patch for a somewhat similar, but more severe,
problem in another subsystem is the following commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/infiniband?id=e6bd18f57aad1a2d1ef40e646d03ed0f2515c9e3
- Infiniband improperly read pointers to userspace memory in its
->write() handler and then accesses those userspace pointers using
userspace accessor functions. I wrote a PoC back then that could abuse
this to write to an arbitrary kernel address from unprivileged
userspace via sys_splice(), provided that the vulnerable kernel module
was loaded.

> > Fixes: 7f8ec5a4f01a ("x86/mtrr: Convert to use strncpy_from_user()
> > helper")
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> >  arch/x86/kernel/cpu/mtrr/if.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/cpu/mtrr/if.c
> > b/arch/x86/kernel/cpu/mtrr/if.c
> > index 4021d3859499..40eee6cc4124 100644
> > --- a/arch/x86/kernel/cpu/mtrr/if.c
> > +++ b/arch/x86/kernel/cpu/mtrr/if.c
> > @@ -106,7 +106,8 @@ mtrr_write(struct file *file, const char __user
> > *buf, size_t len, loff_t * ppos)
> >
> >       memset(line, 0, LINE_SIZE);
> >
> > -     length = strncpy_from_user(line, buf, LINE_SIZE - 1);
> > +     len = min_t(size_t, len, LINE_SIZE - 1);
> > +     length = strncpy_from_user(line, buf, len);
> >       if (length < 0)
> >               return length;
> >
>
> --
> Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Intel Finland Oy
