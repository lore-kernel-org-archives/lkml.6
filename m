Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAB6EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96F04208A3
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 07:17:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96F04208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbeISMxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 08:53:51 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:37499 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeISMxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 08:53:50 -0400
Received: by mail-vk1-f195.google.com with SMTP id 79-v6so934990vkm.4;
        Wed, 19 Sep 2018 00:17:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZaRTSgonUAJF326MDlLsru21w5efg9JeVlaNyEAj4E=;
        b=JRYwHjwkoMRMtm08I2kZkbcTer7A5Olrw95uQsLxB3Z5IALAou7HDd3UdtGwWLFykF
         iE23FshyZvpgCPhucPUiZoZeoUYvg8HcNACn7YpS2vavuoi25omliHu5YT6y9VZEGT02
         FABAaYKHBrkT+vCNfuiFLJ+6X0cR8booz80SBsAIBQyxAYpJsAkstztv9yFlnAoz37F8
         TlbStAp02X0gEWkecdcsVHW660T0dc5psVs21+kDGAB/45TzUGDzaYCe9UjXRwwTOAVC
         ozGrR7VVIaTJLpkPktLgDLkP/MsD/wcySXNZv7hU9CfKK/ILz3Zk/YpinxrbeuDxT3ht
         pxjw==
X-Gm-Message-State: APzg51ATWluN+0w/MOUfh3cW7eE+7CVIxBeWgIsfdv8SrH9YcjM+K4yC
        KP8JUv5sDtXeUldX5GTzhGehYs1rkJs+XRu8zPzBPdyV
X-Google-Smtp-Source: ANB0VdZ25QkW7WtsGSHUu82ZgR5iLhq6fNyoluGe3DdPJPNutEYzlw5IVfQFcmnYeEoT5GCh/UGk2uCzjFa3QjYGJeI=
X-Received: by 2002:a1f:cc41:: with SMTP id c62-v6mr9010372vkg.74.1537341435362;
 Wed, 19 Sep 2018 00:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180919073826.02370812@canb.auug.org.au> <20180910133525.28c5dd20@canb.auug.org.au>
 <15925.1537309041@warthog.procyon.org.uk> <20180919094847.2103082b@canb.auug.org.au>
In-Reply-To: <20180919094847.2103082b@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Sep 2018 09:17:03 +0200
Message-ID: <CAMuHMdUyazZR1MhUm6ekFHJ3HPtVEBhejsyAvNVEtfuGVvDrNA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the vfs tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 19, 2018 at 1:50 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Tue, 18 Sep 2018 23:17:21 +0100 David Howells <dhowells@redhat.com> wrote:
> > Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > > > After merging the vfs tree, today's linux-next build (powerpc
> > > > allyesconfig) failed like this:
> > > >
> > > > samples/vfs/test-fsinfo.c: In function 'fsinfo':
> > > > samples/vfs/test-fsinfo.c:37:17: error: '__NR_fsinfo' undeclared (first use in this function); did you mean 'fsinfo'?
> >
> > I think the problem is that I haven't allocated system call numbers for any
> > arches other than x86 - even the x86 syscall numbers are provisional until the
> > patchset is taken upstream.  I'm not sure of the best way to deal with this -
> > make the samples dependent on the X86 arch?
>
> But the sample programs are built with HOSTCC, so you can't depend on
> ARCH (since I, for one, am cross compiling).  Maybe SUBARCH.  Better
> would be to use either Kconfig's shell primitive or some make magic to
> figure out if the syscall number define's are defined.
>
> > > > samples/vfs/test-fsinfo.c:180:30: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type '__u64' {aka 'long unsigned int'} [-Wformat=]
> > > >   printf("\tmax file size: %llx\n", f->max_file_size);
> >
> > Sigh.  On powerpc __u64 is unsigned long, but on x86_64 it's unsigned long
> > long.  Is it possible to shift all arches to use unsigned long long for __u64?
>
> I doubt it - that would probably cause more warnings in the arch code.

In kernelspace, it's unsigned long long on all architectures.
In userspace, it may still be unsigned long on early 64-bit architectures.

> Instead, just explicitly cast it to unsigned long long.

Or use C99's PRIx64?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
