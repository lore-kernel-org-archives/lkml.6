Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC784C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996582083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="SFYHNJwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBNAhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:37:51 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32928 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBNAhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:37:50 -0500
Received: by mail-pf1-f194.google.com with SMTP id c123so2080405pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=4YNhA6G9lOW17v41GSeYMA4e4WObkqs7yOUhebPENCA=;
        b=SFYHNJwao4o90ci76fZTWarqbVmPkwGywvih8o8qdaKTFg5KfiNuLhkEXoK9EBRdaq
         Yy888l6TL/uQk3JGPY2WCYZWPu0B1GJGB8uin+O8I/X+/ybQAHHwQkynA6IK3/vZEVij
         j/GBPR6WjMtQsQhy6wR6gfiqBhgzgLu8qY3E4iM9TXAkE6Q30gxWyfZAMNU6HII73NiS
         prJEqQV3zwuTLIeOrE3Q4DVPd8oQzDmAEg4AzeWqrM2/ZLMoHStDgcIq95GCCLqaNvpb
         5JVZ14C3KJj+8hLLAAP6QJ5q7b2zF10dvbvMlIicmLfTaKI6zQTOIdDi3Ant52Ebcqu/
         p52Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=4YNhA6G9lOW17v41GSeYMA4e4WObkqs7yOUhebPENCA=;
        b=qhqvCeSuHt59XbsuGFB7kBz5H5NGYv3o/d3fXQotBhMi6WxtKHQiQ0WrKgolPOahfb
         S353gsUTgRZQzlyv/JfDoJ9kvuCJbWSyIW/hutKtG8JYenkRRRpDLpv8w/dah1cIgcSL
         b2ujrzXAmoLmcUx8vI0pm1Hie5kUMLZ6b8py0yIqPUZngEyYTeRcZWyNA+I5saPlEkXf
         aL7rBPyqySuc0vSVAMOLYdSDuVNwFA8ySUd2aV0nRf4Ojyu+dg63yOFw5GiflqhxrfrS
         T2LErle7xmrn8QBzPWgU3wRAKO+aiaT2qFBG+TsWpWYlffysd2Cklclwfr8KZiOZEGHT
         feZw==
X-Gm-Message-State: AHQUAuYZRj1xd0n6F0Wn6dZtTc/dZrRoB4iNz6kZ2Z1Q5Wu7tzyYjrnZ
        CpGanUrvlS5HWv0u4Fd7X/9pUA==
X-Google-Smtp-Source: AHgI3IZo3qJsAB1d7GpfiCPPVovu00Txb4as/tL1c/8lGjP1SPQEI2Uj55x+uU/DGwmDZFnH4EUkOg==
X-Received: by 2002:a63:2705:: with SMTP id n5mr954284pgn.429.1550104669632;
        Wed, 13 Feb 2019 16:37:49 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 184sm685108pfe.106.2019.02.13.16.37.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:37:48 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:37:48 -0800 (PST)
X-Google-Original-Date: Wed, 13 Feb 2019 16:18:21 PST (-0800)
Subject:     Re: [PATCH v2 0/6] Fixmap support and MM cleanups
In-Reply-To: <CAAhSdy25GUFWfkQHBDy6HysVCVFOpv-ZLY6vr+oH34XbqScYFQ@mail.gmail.com>
CC:     Anup Patel <Anup.Patel@wdc.com>, aou@eecs.berkeley.edu,
        Atish Patra <Atish.Patra@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     anup@brainfault.org
Message-ID: <mhng-c25efbc6-094f-46ab-a4d8-480b53944cde@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 00:21:43 PST (-0800), anup@brainfault.org wrote:
> On Wed, Feb 13, 2019 at 4:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> On Sat, 19 Jan 2019 05:27:53 PST (-0800), Anup Patel wrote:
>> > This patchset does:
>> > 1. Moves MM related code from kernel/setup.c to mm/init.c
>> > 2. Implements compile-time fixed mappings
>> >
>> > Using fixed mappings available, we can now get earlyprints
>> > even without SBI calls. For example, we can use kernel
>> > parameter "earlycon=uart8250,mmio,0x10000000" to get early
>> > prints on QEMU virt machine without using SBI calls.
>> >
>> > The patchset is tested on QEMU virt machine. It is based on
>> > Linux-5.0-rc2 and can be found at riscv_fixmap_v2 branch of:
>> > https://github.com/avpatel/linux.git.
>> >
>> > Changes since v1:
>> >  - Use more characters per line in changelog of PATCH3
>> >  - Removed #ifndef __ASSEMBLY__ from PATCH5
>> >  - Use more characters per line in commets of PATCH5
>> >  - Added PATCH6 to implement keepinitrd kernel parameter
>> >
>> > Anup Patel (6):
>> >   RISC-V: Move free_initrd_mem() to kernel/setup.c
>> >   RISC-V: Setup init_mm before parse_early_param()
>> >   RISC-V: Move setup_bootmem() to mm/init.c
>> >   RISC-V: Move setup_vm() to mm/init.c
>> >   RISC-V: Implement compile-time fixed mappings
>> >   RISC-V: Implement keepinitrd kernel parameter
>> >
>> >  arch/riscv/Kconfig               |   3 +
>> >  arch/riscv/include/asm/fixmap.h  |  44 +++++++++++
>> >  arch/riscv/include/asm/pgtable.h |   1 +
>> >  arch/riscv/kernel/setup.c        | 114 ++++++----------------------
>> >  arch/riscv/mm/init.c             | 124 ++++++++++++++++++++++++++++++-
>> >  5 files changed, 189 insertions(+), 97 deletions(-)
>> >  create mode 100644 arch/riscv/include/asm/fixmap.h
>>
>> I'm getting some git issue when trying to merge the third patch via email
>>
>>     $ mhng-pipe-show_stdout 4 | git am -s
>>     Applying: RISC-V: Move setup_bootmem() to mm/init.c
>>     error: patch failed: arch/riscv/kernel/setup.c:163
>>     error: arch/riscv/kernel/setup.c: patch does not apply
>>     Patch failed at 0001 RISC-V: Move setup_bootmem() to mm/init.c
>>     Use 'git am --show-current-patch' to see the failed patch
>>     When you have resolved this problem, run "git am --continue".
>>     If you prefer to skip this patch, run "git am --skip" instead.
>>     To restore the original branch and stop patching, run "git am --abort".
>>
>> can you send a PR with a signed tag?  I'll include this as part of the next
>> merge window.
>>
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> Okay, I will prepare a PR with following patchsets:
> 1. Fixmap support and MM cleanups (Author: Anup Patel)
> 2. riscv: minor fixes and cleanups (Author: Johan Hovold)
> 3. RISC-V related changes from "Various SMP related fixes" (Author: Atish Patra)
>
> All above patchsets touch same source files so this will
> help you.

Thanks.  There's also a handful of comments from Christoph that I agree with 
about the keepinitrd stuff.
