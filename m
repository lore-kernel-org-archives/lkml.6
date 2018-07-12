Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F794ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA2A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 21:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CqXsPx/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA2A20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbeGLVw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 17:52:28 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42101 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733113AbeGLVw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 17:52:27 -0400
Received: by mail-io0-f194.google.com with SMTP id r24-v6so29544965ioh.9;
        Thu, 12 Jul 2018 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYw+ZJGSxGm6J74XTNum40LIC28Ukp7NFhdm52rnKUc=;
        b=CqXsPx/yRbvIu0uQQ6NOvpSOb82EF3aswz9WDv0HX/EFKF2YWnAe6lU7ApLJIdBlUv
         jU4/Rs9AwF7jHOVVhJHuJX57YX8el9tgkwFZU/hP0J4Q2ONWyV2zXtlrOdOmo0TthxPY
         sH4/Z3if1o9+Fnb46BBHTJA/pklnurc9MvL4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYw+ZJGSxGm6J74XTNum40LIC28Ukp7NFhdm52rnKUc=;
        b=FHuL/79mYplBMQ/c//DcE37ejnpwEgGwDOAZCuHPhVxgIPb+Yjuj0GTeRmXx3rZ4ub
         /v4K/x3J2y6Oe2MFZ7aCmeH3ZsBtyhMhe+IlmXC90GaEigH7f9x02Uyrgsb/mOqOOI2r
         g+OAwTBhcu1asgCRo394hDeoRZDRMf/9HGYFfLvEawNe4ZzzQLIDiGQhPt3V3DLvsWUU
         WTQCqyP98ND3TsF9Bxp6XIc/NZqXGexSUr1iw7dEBmJZR1m2v22sg3JpYZDhR8zXLFXa
         7e9O77K8FcGmHMTKBRSXci9aXXIGhhMM3djZVhTx18kGAhBFyicUkZM1MBnu+W1jHCC6
         kIXQ==
X-Gm-Message-State: AOUpUlHINnFq+7PPt/qFKCy7ZGiSUDnz1MQDp+YYry/fw35QHK3mK3Nd
        jY4f0wO1kGpnBPW7w5Qn1vq+tQAVwjvIdi0VtpGvDM6C
X-Google-Smtp-Source: AAOMgpeOFt6KSpevw4Lar12JjiAby270VQxFAKkTVURpQRahRSivpB3lwBiShD/tVsgKrN1b481ROB/Ac0Zfa6D4ecI=
X-Received: by 2002:a6b:274f:: with SMTP id n76-v6mr30313690ion.259.1531431660330;
 Thu, 12 Jul 2018 14:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <153126248868.14533.9751473662727327569.stgit@warthog.procyon.org.uk>
 <153126264966.14533.3388004240803696769.stgit@warthog.procyon.org.uk>
 <686E805C-81F3-43D0-A096-50C644C57EE3@amacapital.net> <22370.1531293761@warthog.procyon.org.uk>
 <CALCETrU3kbh-ZRHDj7-Asq+OH-35dQ2p_erpHpYUvN5+BdAoVQ@mail.gmail.com>
 <7002.1531407244@warthog.procyon.org.uk> <CA+55aFx+xm333ZZ7d2Z39QuhDu=0XM6nTMChbHvWQOXNk32yxw@mail.gmail.com>
 <16699.1531426991@warthog.procyon.org.uk> <CA+55aFw1WyKY+-2dg62M-QT_F0-waCTCrba1DW4dStYz-f_fjA@mail.gmail.com>
 <18233.1531430797@warthog.procyon.org.uk>
In-Reply-To: <18233.1531430797@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jul 2018 14:40:49 -0700
Message-ID: <CA+55aFw7ACqm4fzG_52xTR3B-MqB0hLvcprgjm3jayPDDn6=-A@mail.gmail.com>
Subject: Re: [PATCH 24/32] vfs: syscall: Add fsopen() to prepare for
 superblock creation [ver #9]
To:     David Howells <dhowells@redhat.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 2:26 PM David Howells <dhowells@redhat.com> wrote:
>
> The problem is that there's more than one actual "open" involved.

No. The problem is "write()".

This is not about open, about fsopen, or about anything at all.

This is about the fact that "write()" by definition can happen in a
different - and unexpected - context. Whether that be due to suid or
due to splice, or due to any other random issue is entirely
immaterial.

(The same is true of "read()" too, but very few people try to make
"read()" have side effects, so it's less of an issue. It does happen,
though).

But once you have another interface than "read/write()", the issues go
away. Those other interfaces are synchronous, and now you can decide
"ok, I'll just use current creds".

>  (1) Pass the creds from ->get_tree() all the way down into pathwalk and make
>      sure *every* check that pathwalk does uses it.

No. See above.

If your write() does anything but buffering data, it's not getting merged.

>  (2) When do_the_create_thing() is invoked, it wraps the call to ->get_tree()
>      with override_creds(file->f_cred).

No.

We do not wrap creds in any case. It's just asking for *another* kind
of security issue, where you fool some higher-security thing into
giving you access because it wrapped the higher-security case instead.

>  (3) Forget using an fd to refer to the context.  fsopen() takes absolutely
>      everything, perhaps as a kv array and spits out an O_PATH fd.

That works.

Or you know - do what I told you to do ALL THE TIME, which was to not
use write(), or to only buffer things with write().

But yes, any option that simply avoids read and write is fine.

You can even have a file descriptor. We already have file descriptors
that cannot be read from or written to. It's quite common for special
devices, the whole "open /dev/floppy with O_NONBLOCK only to be able
to do control operations with it" goes back to pretty much day #1.

More recently, we have the whole "FMODE_PATH" kind of file descriptor,
which works as a directory entry, but not for read and write.

So file descriptors can have very useful properties.

But no. We do not use "write()" to implement actions. If you think you
need to check permissions and think you need a "cred", then you're not
using write(). It really is that simple.

Not using write just avouds *all* the problems. If you can fool a suid
application to do arbitrary system calls for you, then it's not the
system call that is the security problem.

                Linus
