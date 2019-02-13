Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB89DC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A87A222C0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550049615;
	bh=brUapftCa140wSMsnWrE2JPLWZ6vMFVMAwmpsIS9dik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=m/NbvkAku2DJojZd2C8fLobEUmPcKlRVGBliiEWDdm1nXB97Pwljo0JB2s1eR99RD
	 10OQ1EyQ4ldno/QN2hAJlz8fWGbEaouPHe8dJCZyoyCZ+4BrDSJxTLlQZlqZ762du4
	 HIMlEUqoaj8hlXYmuhOd8ea3h/lZTQGsLxQGgowE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391318AbfBMJUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:20:14 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42738 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727614AbfBMJUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:20:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so1192911lfh.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 01:20:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yV3tHrb36nm7qguc30iL89qUkzz5TfCHBJryEVaPhcI=;
        b=OkhGouxne9IzJwQyOnOf5bHH8yf2UeM4M0zROTzpW+ThMyPLHM7h4tacKOCHdI/qhe
         DNyShXTBSUUI+G07qksyFC2/PLFveXDP3fjs1tlsaz/VY1A13CHWiGwrkwXyDmRh6UN+
         K13DwrQgzqHPautkUspn/9Qfru85+kFPVsKkbUBhvQoF3GOT/RPxOtX34vsPANNbazT6
         8yrtAogn2hFySH75B6hjxIhkfagM8uydL6w6UoIIWc4j31SXg+sVVC+5KcAbKRYNDEz0
         V43B1t7uxT3apAJxKGHgRKQxB6NZRy1W+YXZpa4zNciNVH6c332YlOW/HPBdkHkR3pJm
         Q4Ug==
X-Gm-Message-State: AHQUAuYB4t6tlW2JQAl5KvNQXEz8S0tL4FagdLiAkH8Jv06KTcD4uc6G
        nhxiIvmg3+QlqT7MR9O5Ghw=
X-Google-Smtp-Source: AHgI3IbnucUO9uKFA3Qc3Zzc/Gj1xrQpGuOkq3oZefH7xWneDAvgdVL26JtR4wyuMJIWBKMb6kgMVA==
X-Received: by 2002:a19:ec0e:: with SMTP id b14mr1551184lfa.151.1550049611358;
        Wed, 13 Feb 2019 01:20:11 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id t18sm129617ljc.54.2019.02.13.01.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 01:20:10 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gtqi3-0007eO-DY; Wed, 13 Feb 2019 10:20:04 +0100
Date:   Wed, 13 Feb 2019 10:20:03 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] Fixmap support and MM cleanups
Message-ID: <20190213092003.GF28278@localhost>
References: <20190119132650.9978-1-anup.patel@wdc.com>
 <mhng-3acc6cf0-4c86-4929-a653-11e87d0c6b48@palmer-si-x1c4>
 <CAAhSdy25GUFWfkQHBDy6HysVCVFOpv-ZLY6vr+oH34XbqScYFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy25GUFWfkQHBDy6HysVCVFOpv-ZLY6vr+oH34XbqScYFQ@mail.gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 01:51:43PM +0530, Anup Patel wrote:
> On Wed, Feb 13, 2019 at 4:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Sat, 19 Jan 2019 05:27:53 PST (-0800), Anup Patel wrote:
> > > This patchset does:
> > > 1. Moves MM related code from kernel/setup.c to mm/init.c
> > > 2. Implements compile-time fixed mappings

> > >  arch/riscv/Kconfig               |   3 +
> > >  arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
> > >  arch/riscv/include/asm/pgtable.h |   1 +
> > >  arch/riscv/kernel/setup.c        | 114 ++++++----------------------
> > >  arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
> > >  5 files changed, 189 insertions(+), 97 deletions(-)
> > >  create mode 100644 arch/riscv/include/asm/fixmap.h
> >
> > I'm getting some git issue when trying to merge the third patch via email
> >
> >     $ mhng-pipe-show_stdout 4 | git am -s
> >     Applying: RISC-V: Move setup_bootmem() to mm/init.c
> >     error: patch failed: arch/riscv/kernel/setup.c:163
> >     error: arch/riscv/kernel/setup.c: patch does not apply
> >     Patch failed at 0001 RISC-V: Move setup_bootmem() to mm/init.c
> >     Use 'git am --show-current-patch' to see the failed patch
> >     When you have resolved this problem, run "git am --continue".
> >     If you prefer to skip this patch, run "git am --skip" instead.
> >     To restore the original branch and stop patching, run "git am --abort".
> >
> > can you send a PR with a signed tag?  I'll include this as part of the next
> > merge window.
> >
> > Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> 
> Okay, I will prepare a PR with following patchsets:
> 1. Fixmap support and MM cleanups (Author: Anup Patel)
> 2. riscv: minor fixes and cleanups (Author: Johan Hovold)
> 3. RISC-V related changes from "Various SMP related fixes" (Author: Atish Patra)
> 
> All above patchsets touch same source files so this will
> help you.

I'd suggest keeping these separate. Your series failed to apply, and it
looks like you've now posted a v4 to address that.

If your series is merged before mine, I'm sure any conflicts are
trivial, or I can always respin.

Atish's series might need another revision, so that one should not be
included either.

Johan
