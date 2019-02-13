Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50479C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 123D0222BE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="mxQubxva"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390609AbfBMIV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:21:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54091 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387986AbfBMIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:21:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id d15so1405164wmb.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 00:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KCtzblF1jR9J0InpD4f0Wn6K8qgn39HtvksF7U+weeU=;
        b=mxQubxvawRjDb/feJX9gA2kRRytn5nwW6fNlmaQ09uB3tGhWC8g/Le/lwk/5b2qYYS
         v/VFadsIk9rGglWewtmksg8i6h5nMh7K0XQY8HhtYhahQenlebgT4pWK9X4LjYYTsYin
         Ag1dSAiGM9H9Vv7IuHWvbfMCyFQvIbN42FSKFdYqqT+5OQGYVuU5k9l7cUTPMN9+JrEQ
         yBpjE/stdtiLozPiUyRBvwww83D1IDeZgSlx3H/4yedHJqphJRUH4uJ/H/mFpkq5+q4b
         djx37mGUj9PkN/QkmSj1eI6GcboP9IcdgNdCeTzLIrVCEuTQZHwoFrhodzaTty/0WUXB
         rmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KCtzblF1jR9J0InpD4f0Wn6K8qgn39HtvksF7U+weeU=;
        b=ZEzIOo4rOpSo9wtMPzl3YWA0TnsXjHXXCqpVPyVkvG6RAGfCaP6RGfVSctZNRC2ycI
         2EinKNLWNNzRZn75u0djv6F+0UUcm2/cALI2EkDoG/pD3dTQ9M2rQEfbpUjoO/npogRw
         M7PRaXMdQ1PfdRQ7P5+dzhVNlcqmCwYv/LGJnsV+3QFxNvxs/BIXb2Ze5Sd4ZnYhV00q
         ioFhcm1sMvL3NiWGFbKm8mhlD1ogyd6/lW4NKClpw3OpZGKQYnlFnzk+7u+MEAxuE6n6
         KlG6CfZ9tPC/aJ3nverACaSAVcK8RoDkw3X7pGdln0dHKKNS5cYSTf3bmNqdxuCmld1T
         ZSGw==
X-Gm-Message-State: AHQUAubjzxPoKgeNQWH8PV/BgJft4EwHpJRfRpQGwQQ8jf4r7ABgx1iL
        KDMT9pHdpWPERxB0ZmnWM6lp419uhkiuTFUBZNAqnw==
X-Google-Smtp-Source: AHgI3IYOJXhh5BrMsE9kb/yfz3C0meGmQ1t7EEUghhGy0SLqR8+PRrhHhdMBB1zzlPhNl8HtACSDVXlDeRizyYnx35k=
X-Received: by 2002:a1c:1d15:: with SMTP id d21mr2128285wmd.132.1550046114963;
 Wed, 13 Feb 2019 00:21:54 -0800 (PST)
MIME-Version: 1.0
References: <20190119132650.9978-1-anup.patel@wdc.com> <mhng-3acc6cf0-4c86-4929-a653-11e87d0c6b48@palmer-si-x1c4>
In-Reply-To: <mhng-3acc6cf0-4c86-4929-a653-11e87d0c6b48@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 13 Feb 2019 13:51:43 +0530
Message-ID: <CAAhSdy25GUFWfkQHBDy6HysVCVFOpv-ZLY6vr+oH34XbqScYFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] Fixmap support and MM cleanups
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 4:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Sat, 19 Jan 2019 05:27:53 PST (-0800), Anup Patel wrote:
> > This patchset does:
> > 1. Moves MM related code from kernel/setup.c to mm/init.c
> > 2. Implements compile-time fixed mappings
> >
> > Using fixed mappings available, we can now get earlyprints
> > even without SBI calls. For example, we can use kernel
> > parameter "earlycon=uart8250,mmio,0x10000000" to get early
> > prints on QEMU virt machine without using SBI calls.
> >
> > The patchset is tested on QEMU virt machine. It is based on
> > Linux-5.0-rc2 and can be found at riscv_fixmap_v2 branch of:
> > https://github.com/avpatel/linux.git.
> >
> > Changes since v1:
> >  - Use more characters per line in changelog of PATCH3
> >  - Removed #ifndef __ASSEMBLY__ from PATCH5
> >  - Use more characters per line in commets of PATCH5
> >  - Added PATCH6 to implement keepinitrd kernel parameter
> >
> > Anup Patel (6):
> >   RISC-V: Move free_initrd_mem() to kernel/setup.c
> >   RISC-V: Setup init_mm before parse_early_param()
> >   RISC-V: Move setup_bootmem() to mm/init.c
> >   RISC-V: Move setup_vm() to mm/init.c
> >   RISC-V: Implement compile-time fixed mappings
> >   RISC-V: Implement keepinitrd kernel parameter
> >
> >  arch/riscv/Kconfig               |   3 +
> >  arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
> >  arch/riscv/include/asm/pgtable.h |   1 +
> >  arch/riscv/kernel/setup.c        | 114 ++++++----------------------
> >  arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
> >  5 files changed, 189 insertions(+), 97 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/fixmap.h
>
> I'm getting some git issue when trying to merge the third patch via email
>
>     $ mhng-pipe-show_stdout 4 | git am -s
>     Applying: RISC-V: Move setup_bootmem() to mm/init.c
>     error: patch failed: arch/riscv/kernel/setup.c:163
>     error: arch/riscv/kernel/setup.c: patch does not apply
>     Patch failed at 0001 RISC-V: Move setup_bootmem() to mm/init.c
>     Use 'git am --show-current-patch' to see the failed patch
>     When you have resolved this problem, run "git am --continue".
>     If you prefer to skip this patch, run "git am --skip" instead.
>     To restore the original branch and stop patching, run "git am --abort".
>
> can you send a PR with a signed tag?  I'll include this as part of the next
> merge window.
>
> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

Okay, I will prepare a PR with following patchsets:
1. Fixmap support and MM cleanups (Author: Anup Patel)
2. riscv: minor fixes and cleanups (Author: Johan Hovold)
3. RISC-V related changes from "Various SMP related fixes" (Author: Atish Patra)

All above patchsets touch same source files so this will
help you.

Regards,
Anup
