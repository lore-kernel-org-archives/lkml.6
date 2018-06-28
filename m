Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6953C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716352726B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C0Q/OmdV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716352726B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965298AbeF1Mk2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:40:28 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:38369 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeF1Mk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:40:27 -0400
Received: by mail-pl0-f67.google.com with SMTP id d10-v6so2706841plo.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 05:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bFyBM/eDJt61jxPJA5XzlcvnP+c/0AgQX6AvucAUAc=;
        b=C0Q/OmdVb+ohJODNlhiELySm6DN2unyVnPuxWUCgz5pjFnOx6y1UGHlOV1kFZg578l
         6vIOv5FMU1dqFRsnk746UoDnGhBuiXNSWJNzOIhJQR+sViadhivWoYd0mOlalzJTHVGA
         YsMf9fWVTrAsYcVoEtPB7dTWZep7omXuAcMSnG8lJs+rNiH3KeMyC7BS76NyJwpeUypn
         L6NzlkDYwXnQHldW+g8bINKwxHEYIuY4SgZs+u2DyVuWeN/td6eogrr+uq3bc3sNtCBa
         MUvHhPYpOuZHbKB413O3+/fdSNuQJXd3NahLpgDZVAtdelr3EprXpE70WdfrPz0nGA9/
         DgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bFyBM/eDJt61jxPJA5XzlcvnP+c/0AgQX6AvucAUAc=;
        b=GqtWjUxFgEv5Y3xdspzFDT/1IKxeAmI7zlJhpkBi4rtnyE5+GXPbzn7Zy4RjagsH69
         j4g1dJP5Py9/ke1nJCb7Hn5CJYvBJ4bwUA+o0i1YA/dwtHvTncpRnsT2jSkUBjrZv9Cf
         O2UYmVfaOdcl9XaTHYaUl8eYhXiFSLjco0jLiD8TM9Q+nTSmy5+7BRdiOidrDH49REcW
         H7W/2lfSOkKuv3g1I2c+ed3zITbHGVw3s5u84X7pcWl0p5vrsyMc/5PeCoTLoMoVuPH5
         /2k3+fTfZacP08wYfc6Yjaq+7uHqkXtLO6fllgFicrLnd91aLGAwRo/X2cwilR+Pu6bL
         3lug==
X-Gm-Message-State: APt69E3EEZZnT2AT+HQPBWlVq38EfgowtRz1LAtH+P95GTeFpa6Pz9cR
        /f9HmC6iXNlQjhktdagQy0RaowyRxG+d8wOBdhwHhw==
X-Google-Smtp-Source: ADUXVKJt3pndMpTDCoOTrB353IN/5T6ndgp0gqI5bSx/TK6Ocs8PQsMqeJw7Hi3YcGtp2NvzIlcEtjKqDIfn4XG/kmA=
X-Received: by 2002:a17:902:7586:: with SMTP id j6-v6mr10238430pll.262.1530189626441;
 Thu, 28 Jun 2018 05:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180627194614.188210-1-ghackmann@google.com> <20180628093928.GB10751@arm.com>
In-Reply-To: <20180628093928.GB10751@arm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 28 Jun 2018 08:40:14 -0400
Message-ID: <CAKwvOdnhPhXc+V2aTzpyCDCeCmFtzPe+-7+YrRrPeWDF1f5s1A@mail.gmail.com>
Subject: Re: [PATCH] arm64: remove no-op -p linker flag
To:     Will Deacon <will.deacon@arm.com>
Cc:     ghackmann@android.com, Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Greg Hackmann <ghackmann@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 5:38 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Wed, Jun 27, 2018 at 12:46:14PM -0700, Greg Hackmann wrote:
> > Linking the ARM64 defconfig kernel with LLVM lld fails with the error:
> >
> >   ld.lld: error: unknown argument: -p
> >   Makefile:1015: recipe for target 'vmlinux' failed
> >
> > Without this flag, the ARM64 defconfig kernel successfully links with
> > lld and boots on Dragonboard 410c.

Ha! Just one single unknown linker flag, to link and boot? That's not too bad.

> > After digging through binutils source and changelogs, it turns out that
> > -p is only relevant to ancient binutils installations targeting 32-bit
> > ARM.  binutils accepts -p for AArch64 too, but it's always been
> > undocumented and silently ignored.

Nothing in the man pages for ld in regards to -p.  Seems like it was
shortform for "--no-pipeline-knowledge: Stop the linker knowing about
the pipeline length".

Looks like it was added to binutils via this commit in 1999:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=7ca69e9e10ef290eb3dd62a1e6bebbe4c87fa202

And removed in 2004:
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=commit;h=dea514f51da1051f9f3cd7a746e3b68085aa1a72

arch/arm/Makefile has -p as a LD_FLAGS.  Is it actually needed there
too, or can it be removed from there?  I assume we'll want to use lld
for arm32 at some point.

> > A comment in
> > ld/emultempl/aarch64elf.em explains that it's "Only here for backwards
> > compatibility".

Yep: https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob;f=ld/emultempl/aarch64elf.em;h=edc548f65298e563481bdd9d547fcb9c6b13da04;hb=HEAD#l405

armelf.em also has that comment.

Looks like -p has been in arch/arm64/Makefile since the initial commit
that added that file. So likely copy+pasted from arch/arm/Makefile.

commit 8c2c3df31e3b ("arm64: Build infrastructure"):
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm64/Makefile?id=8c2c3df31e3b87cb5348e48776c366ebd1dc5a7a

And it looks like arch/arm/Makefile has has -p since the move to git
for Linux 2.6:

commit 1da177e4c3f4 ("Linux-2.6.12-rc2")
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/arm/Makefile?id=1da177e4c3f41524e886b7f1b8a0c1fc7321cac2

So nothing in the kernel commit history to hint at what it was ever used for.

As long as you have a version of binutils that not 14 years old, you
should be good.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

-- 
Thanks,
~Nick Desaulniers
