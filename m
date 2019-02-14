Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EE8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F404B2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 08:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="XKrJ9+pB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437498AbfBNI2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 03:28:55 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54796 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388304AbfBNI2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 03:28:55 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so5294288wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 00:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhCnZvf23aeo06nIRSdaHF4egKBLiYeTJxSjOgwTDYc=;
        b=XKrJ9+pBjGPkXDmUzz4oN+e+A16SNuQde6dQsKxEmM5tWCWdAQNdGYwIz3NaP8t5XZ
         bAVPl89OWKreVzDzPzItjlcir/pZqRItpGNPN6iFmxlRFwpn8M2aDqh0464VaVAsRK8W
         wMzReVl6xLnrnSd8xO+SM0H4vwftkROmNAoYyxvO81FxRjjxDOlkwyPq7Y3Nt9jU5Lg9
         AUzIMrKaoQXwtLmyUDS1m0DKmX31bC4vprp+5LE2fOnATIQ6DN3blenE+C/mspP6cL45
         q0hYlBnkrzZ9+O2NqACS2OV1MCeFlW4moNgPa0h7cih+dgh29xlZkgk+oxJjk+2PAdsi
         GfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhCnZvf23aeo06nIRSdaHF4egKBLiYeTJxSjOgwTDYc=;
        b=pME094OFUY/iVxsXVw8DK7XRslIDE3sEd1C2r2tZ6kxu81V4RU5efNNWaQbZrkMhX0
         VT0qAGhGH12LYnhje6/i9lQAmJAs6fycgW8eWloz52ot6nz51ouAPiKNv7XEYWeMhct+
         09E4NIiuXX4TYYHxSvmZB4e047INJBqQx8S228lYGx1uWmQlxicaIgqsV1/v8HoKI2Rg
         K77OTnvxhftj1JYBjoTB8jqy/awZZMXTAuPexHe8/bvDX29DnC+E0NpGmx9bhpLuD2PC
         Q/w4xEQd3utYTqoT+k8BjuY7/sF8epZ98r7Gj9j6goHUyEhR582eGCb3hpFW6rYFTpPF
         7sEQ==
X-Gm-Message-State: AHQUAuZWTirdlmNdB9Ev4dQBZ1dYhy1FnRy2uIdFj8QtyybKUjJqwUEb
        PxXtmVgWq2sWSowMPPZotkTTLT34fsT0syb2b6Bp/g==
X-Google-Smtp-Source: AHgI3IYDDZrhBQ1SSy2IPkGdV8sM0X0rEyH2uMYWDKF2iPyTd6VJWPmoAUXFYvC2E6MQWIOCXZkS8B9csMW+LaiqGEA=
X-Received: by 2002:a1c:a3c3:: with SMTP id m186mr1685443wme.16.1550132931258;
 Thu, 14 Feb 2019 00:28:51 -0800 (PST)
MIME-Version: 1.0
References: <CAAhSdy25GUFWfkQHBDy6HysVCVFOpv-ZLY6vr+oH34XbqScYFQ@mail.gmail.com>
 <mhng-c25efbc6-094f-46ab-a4d8-480b53944cde@palmer-si-x1c4>
In-Reply-To: <mhng-c25efbc6-094f-46ab-a4d8-480b53944cde@palmer-si-x1c4>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 14 Feb 2019 13:58:39 +0530
Message-ID: <CAAhSdy3Bnpq7MawudNB_XyQYxBOietdp4vWyB5aoj06o+8yNSg@mail.gmail.com>
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

On Thu, Feb 14, 2019 at 6:07 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Wed, 13 Feb 2019 00:21:43 PST (-0800), anup@brainfault.org wrote:
> > On Wed, Feb 13, 2019 at 4:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Sat, 19 Jan 2019 05:27:53 PST (-0800), Anup Patel wrote:
> >> > This patchset does:
> >> > 1. Moves MM related code from kernel/setup.c to mm/init.c
> >> > 2. Implements compile-time fixed mappings
> >> >
> >> > Using fixed mappings available, we can now get earlyprints
> >> > even without SBI calls. For example, we can use kernel
> >> > parameter "earlycon=uart8250,mmio,0x10000000" to get early
> >> > prints on QEMU virt machine without using SBI calls.
> >> >
> >> > The patchset is tested on QEMU virt machine. It is based on
> >> > Linux-5.0-rc2 and can be found at riscv_fixmap_v2 branch of:
> >> > https://github.com/avpatel/linux.git.
> >> >
> >> > Changes since v1:
> >> >  - Use more characters per line in changelog of PATCH3
> >> >  - Removed #ifndef __ASSEMBLY__ from PATCH5
> >> >  - Use more characters per line in commets of PATCH5
> >> >  - Added PATCH6 to implement keepinitrd kernel parameter
> >> >
> >> > Anup Patel (6):
> >> >   RISC-V: Move free_initrd_mem() to kernel/setup.c
> >> >   RISC-V: Setup init_mm before parse_early_param()
> >> >   RISC-V: Move setup_bootmem() to mm/init.c
> >> >   RISC-V: Move setup_vm() to mm/init.c
> >> >   RISC-V: Implement compile-time fixed mappings
> >> >   RISC-V: Implement keepinitrd kernel parameter
> >> >
> >> >  arch/riscv/Kconfig               |   3 +
> >> >  arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
> >> >  arch/riscv/include/asm/pgtable.h |   1 +
> >> >  arch/riscv/kernel/setup.c        | 114 ++++++----------------------
> >> >  arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
> >> >  5 files changed, 189 insertions(+), 97 deletions(-)
> >> >  create mode 100644 arch/riscv/include/asm/fixmap.h
> >>
> >> I'm getting some git issue when trying to merge the third patch via email
> >>
> >>     $ mhng-pipe-show_stdout 4 | git am -s
> >>     Applying: RISC-V: Move setup_bootmem() to mm/init.c
> >>     error: patch failed: arch/riscv/kernel/setup.c:163
> >>     error: arch/riscv/kernel/setup.c: patch does not apply
> >>     Patch failed at 0001 RISC-V: Move setup_bootmem() to mm/init.c
> >>     Use 'git am --show-current-patch' to see the failed patch
> >>     When you have resolved this problem, run "git am --continue".
> >>     If you prefer to skip this patch, run "git am --skip" instead.
> >>     To restore the original branch and stop patching, run "git am --abort".
> >>
> >> can you send a PR with a signed tag?  I'll include this as part of the next
> >> merge window.
> >>
> >> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
> >
> > Okay, I will prepare a PR with following patchsets:
> > 1. Fixmap support and MM cleanups (Author: Anup Patel)
> > 2. riscv: minor fixes and cleanups (Author: Johan Hovold)
> > 3. RISC-V related changes from "Various SMP related fixes" (Author: Atish Patra)
> >
> > All above patchsets touch same source files so this will
> > help you.
>
> Thanks.  There's also a handful of comments from Christoph that I agree with
> about the keepinitrd stuff.

I have sent PR with Fixmap patches only.

Johan and Atish will rebase their patches based on your tree.

Regards,
Anup
