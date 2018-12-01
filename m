Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB4C04EB9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9459A2146D
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 14:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="UNDJWr9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9459A2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbeLBCFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 21:05:05 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:18825 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbeLBCFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 21:05:05 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id wB1EqI0x020074;
        Sat, 1 Dec 2018 23:52:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com wB1EqI0x020074
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1543675939;
        bh=2Y47WRc7lEm8fePYB+Goqw1mfLXtcvj2Y1SJoWhvIig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UNDJWr9rcoKbWtkTc2WncyDOPoNVhEmuZ0mKbOrI4gwMCyVWWbP1E2kmYfzztxEDy
         MA9nTHOHXn+KJ7ep4na8SfqKHVV0bdFGYEgjv0kyi8DB6boYiqrDzqDLMJbJPT7iN5
         8LJPGyeJLDfxVLqlMOlBXqtQ+RzAI9qwF8819GVTc/JvQbH3p8hktPCxIS5IaCRtkr
         BRnv/LmweuNv5e4Y7Ij9HZxDTsrGWsLnyGFRzy+Q98VeHi99IjdEdh1QY4K8z3r2qe
         QcnJ+Tie7t86dAm69hNltf6K4vMs59bZj2GCCcG3fDxWAN1GJj/B3hVkhqOh4z1e/k
         O1NZFJSVXvbMQ==
X-Nifty-SrcIP: [209.85.217.41]
Received: by mail-vs1-f41.google.com with SMTP id v205so5102211vsc.3;
        Sat, 01 Dec 2018 06:52:19 -0800 (PST)
X-Gm-Message-State: AA+aEWav2OgQVZxKXs2LjdSnbM6ey4QcV5MW6gUVFBCEi8jrIrK0XlCb
        gKUg7vRNikG1EKv4+Wc17PDRe2VPFfJEEmVSqhU=
X-Google-Smtp-Source: AFSGD/X9hDCEE7DofafxmDz+mI7Q+0KGXbwz4hhcaFEmPVo+p2jr4btYuSoVREN7878woE58x4Lk26OXXfgM29d2kiY=
X-Received: by 2002:a67:385a:: with SMTP id f87mr4275553vsa.179.1543675937837;
 Sat, 01 Dec 2018 06:52:17 -0800 (PST)
MIME-Version: 1.0
References: <1543460330-2219-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1543460330-2219-1-git-send-email-yamada.masahiro@socionext.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sat, 1 Dec 2018 23:51:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQN7A=P0T7ON0LvENxs6rpUqonu9S0GcQwHP6HaPt2fQA@mail.gmail.com>
Message-ID: <CAK7LNAQN7A=P0T7ON0LvENxs6rpUqonu9S0GcQwHP6HaPt2fQA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: fix UML build error with CONFIG_GCC_PLUGINS
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, linux-um@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Marek <michal.lkml@markovi.net>,
        Richard Weinberger <richard@nod.at>,
        Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 12:01 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> UML fails to build with CONFIG_GCC_PLUGINS=y.
>
> $ make -s ARCH=um mrproper
> $ make -s ARCH=um allmodconfig
> $ make ARCH=um
>   UPD     include/generated/uapi/linux/version.h
>   WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
>   WRAP    arch/x86/include/generated/uapi/asm/poll.h
>   WRAP    arch/x86/include/generated/asm/dma-contiguous.h
>   WRAP    arch/x86/include/generated/asm/early_ioremap.h
>   WRAP    arch/x86/include/generated/asm/export.h
>   WRAP    arch/x86/include/generated/asm/mcs_spinlock.h
>   WRAP    arch/x86/include/generated/asm/mm-arch-hooks.h
>   SYSTBL  arch/x86/include/generated/asm/syscalls_32.h
>   SYSHDR  arch/x86/include/generated/asm/unistd_32_ia32.h
>   SYSHDR  arch/x86/include/generated/asm/unistd_64_x32.h
>   SYSTBL  arch/x86/include/generated/asm/syscalls_64.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_32.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_64.h
>   SYSHDR  arch/x86/include/generated/uapi/asm/unistd_x32.h
>   HOSTCC  scripts/unifdef
>   CC      arch/x86/um/user-offsets.s
> cc1: error: cannot load plugin ./scripts/gcc-plugins/cyc_complexity_plugin.so
> ./scripts/gcc-plugins/cyc_complexity_plugin.so: cannot open shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/structleak_plugin.so
> ./scripts/gcc-plugins/structleak_plugin.so: cannot open shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/latent_entropy_plugin.so
> ./scripts/gcc-plugins/latent_entropy_plugin.so: cannot open shared object file: No such file or directory
> cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so
> ./scripts/gcc-plugins/randomize_layout_plugin.so: cannot open shared object file: No such file or directory
> make[1]: *** [scripts/Makefile.build;119: arch/x86/um/user-offsets.s] Error 1
> make: *** [arch/um/Makefile;152: arch/x86/um/user-offsets.s] Error 2
>
> Change the order of the preparation stage (with cleanups) to make sure
> gcc-plugins is built before descending to arch/x86/um/.
>
> Reported-by: kbuild test robot <lkp@intel.com>
> Fixes: 6b90bd4ba40b ("GCC plugin infrastructure")
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Applied to linux-kbuild.


>
> I will pick up this to kbuild tree to avoid conflicts.
> Ack from UML people is appreciated, though.
>
>
-- 
Best Regards
Masahiro Yamada
