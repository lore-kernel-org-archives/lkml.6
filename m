Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6795BC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BB2E2084C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 03:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WnI6vM4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BB2E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729858AbeLKDPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 22:15:20 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:46721 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728756AbeLKDPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 22:15:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id x202so10839913oif.13;
        Mon, 10 Dec 2018 19:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=icCcTnABKx19XzkVCBxNCuN9FZSKKDlNBlB7inNpAWE=;
        b=WnI6vM4EtFLsmvlpkrFiL57h0teb3ykEO8BRVA8MUBYBgjeI4OXG02VuGsMmiu80HS
         KkeALMKZ4dvxYGPPgzJd4CE/6o0Ny9HLlktdIo/CkIewR1JmKFqLeUDedL915jGjN3t4
         xLwc646lR6sLzPwRkNc7lIY6MBwItD/www3O6rsoGec3P0VO8bsIlP2KnpGyepGLSN3Q
         DzRNEF1qcR8COQaCQyGgciuGSRewJmt2cI1sVwedLolqEoE1l9hUJz4nm4rTVk7/uojr
         zkJIKd4JhgK0Svmub/2sHwWoOaK175pztDhlgg8NYm4LlmrG3Ut/aWDmeYBRIYzk2Zco
         HB/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=icCcTnABKx19XzkVCBxNCuN9FZSKKDlNBlB7inNpAWE=;
        b=Fx89sC6ymoztSdh84FqKIlzMDJE1+Bln9vccjbtrrUFvhF2PtdAvlTC+lCtOvm4gSh
         jiPPbVcQmtUUkeyFzSnhbW0Wx/HZGZ0V/K5yWxswoTeGG4YJI8+heT0onE9W7KI2GptR
         0I1/yjFTvrxkM7Ju9+V15iSMMT7cIIkyXQ2STQAvgeLcGuwYm0ADfx+mhGDXundSJuUy
         FB+0075LkP5lcHboUp3dv98Z1qfVug4y7XVxOUVkSav71MsRIFpss+VQ+RlQrehR80q2
         0dpzqzPYE9Gliq1TnE+sZI74uIU/iU55rh1tTRDXXRDPfveo+SKav3rHL9cVbLok+xQq
         gRMw==
X-Gm-Message-State: AA+aEWafprG/7+GsyqZzdyMjTWb525QWuDJSIGzhUfJAQABecZ+zLcX9
        al4huJiCn5cgEjPlIucC3n9GAdRzevvue3Dgipy0UtA9
X-Google-Smtp-Source: AFSGD/XUpPuJPa1h5/2TKAt4U0QC9cUEcDwMGgd5Ny5TG1lQ5mUK5RbYxzDe0iJqHv9jzmQrSoGDn5koBV9j2EX//Qo=
X-Received: by 2002:aca:dc46:: with SMTP id t67mr313491oig.279.1544498118769;
 Mon, 10 Dec 2018 19:15:18 -0800 (PST)
MIME-Version: 1.0
References: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
In-Reply-To: <CALCETrXoRAibsbWa9nfbDrt0iEuebMnCMhSFg-d9W-J2g8mDjw@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 10 Dec 2018 19:14:41 -0800
Message-ID: <CAMe9rOp0m5sn59AsD2F2i2Ad2tb7ufPU1mMg-vUOfh+TnGMeaw@mail.gmail.com>
Subject: Re: Can we drop upstream Linux x32 support?
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Florian Weimer <fweimer@redhat.com>,
        Mike Frysinger <vapier@gentoo.org>,
        Rich Felker <dalias@libc.org>, x32@buildd.debian.org,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 5:23 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> Hi all-
>
> I'm seriously considering sending a patch to remove x32 support from
> upstream Linux.  Here are some problems with it:
>
> 1. It's not entirely clear that it has users.  As far as I know, it's
> supported on Gentoo and Debian, and the Debian popcon graph for x32
> has been falling off dramatically.  I don't think that any enterprise
> distro has ever supported x32.

I have been posting x32 GCC results for years:

https://gcc.gnu.org/ml/gcc-testresults/2018-12/msg01358.html

> 2. The way that system calls work is very strange.  Most syscalls on
> x32 enter through their *native* (i.e. not COMPAT_SYSCALL_DEFINE)
> entry point, and this is intentional.  For example, adjtimex() uses
> the native entry, not the compat entry, because x32's struct timex
> matches the x86_64 layout.  But a handful of syscalls have separate

This becomes less an issue with 64-bit time_t.

> entry points -- these are the syscalls starting at 512.  These enter
> throuh the COMPAT_SYSCALL_DEFINE entry points.
>
> The x32 syscalls that are *not* in the 512 range violate all semblance
> of kernel syscall convention.  In the syscall handlers,
> in_compat_syscall() returns true, but the COMPAT_SYSCALL_DEFINE entry
> is not invoked.   This is nutty and risks breaking things when people
> refactor their syscall implementations.  And no one tests these
> things.  Similarly, if someone calls any of the syscalls below 512 but
> sets bit 31 in RAX, then the native entry will be called with
> in_compat_set().
>
> Conversely, if you call a syscall in the 512 range with bit 31
> *clear*, then the compat entry is set with in_compat_syscall()
> *clear*.  This is also nutty.

This is to share syscalls between LP64 and ILP32 (x32) in x86-64 kernel.

> Finally, the kernel has a weird distinction between CONFIG_X86_X32_ABI
> and and CONFIG_X86_X32, which I suspect results in incorrect builds if
> the host doesn't have an x32 toolchain installed.

X86-64 binutils and GCC can be used to build x86-64 kernel with x32 support.

> I propose that we make CONFIG_X86_X32 depend on BROKEN for a release
> or two and then remove all the code if no one complains.  If anyone
> wants to re-add it, IMO they're welcome to do so, but they need to do
> it in a way that is maintainable.


-- 
H.J.
